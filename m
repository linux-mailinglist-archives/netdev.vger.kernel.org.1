Return-Path: <netdev+bounces-54707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D0807E66
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E43D1C20BE3
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C3186B;
	Thu,  7 Dec 2023 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE7JrhmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD781845
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55104C433C7;
	Thu,  7 Dec 2023 02:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701915925;
	bh=ChJJWFEbCoEqPcDPxbkhnbgAlE/Upit/zOnqnNrWgTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kE7JrhmQfxP/YPAxBM60OQZHsuh/o5alyZwgC0LShGrumseWvRE85WQRW7CPumxmJ
	 vao4xf0A/9nzOEWvGr1nAFBIpgv9nscvSwruRC4x7tK2pN43zUX1EYFmUPUFZ+sj9q
	 AagfSAuyiQb6Ip7H310SApCAUwYA2ywt1yOe675JLe1PLK/iX6IZS5AETvWVXOdGXC
	 TcHsqWPlsM2oHRz1sEP+sLc3q/Z7t5KIP6SDZ8PEUE2e2YYhmDTkVRaoNrIw6JQkhP
	 BfAvSMBRdDVTyPwfTryNsuOblyZWxXXfY4RU3qhtrqast5oCZnI0Gx2q8XXKu0dgCn
	 7JR9XD4H1O73Q==
Date: Wed, 6 Dec 2023 18:25:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: [RFC] ethtool: raw packet filtering
Message-ID: <20231206182524.0dc8b680@kernel.org>
In-Reply-To: <bef1ce9b-25f0-4466-9669-5ea0397f2582@intel.com>
References: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
	<20231206081605.0fad0f58@kernel.org>
	<bef1ce9b-25f0-4466-9669-5ea0397f2582@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 15:47:18 -0700 Ahmed Zaki wrote:
> Sure. The main use case is to be able to filter on any standard or 
> proprietary protocol headers, tunneled or not, using the ntuple API. 
> ethtool allows this only for the basic TCP/UDP/SCTP/ah/esp and IPv4/6. 
> Filtering on any other protocol or stack of protocols will require 
> ethtool and core changes. Raw filtering on the first 512 bytes of the 
> packet will allow anyone to do such filtering without these changes.
> 
> To be clear, I am not advocating for bypassing Kernel parsing, but there 
> are so many combinations of protocols and tunneling methods that it is 
> very hard to add them all in ethtool.
> 
> As an example, if we want to direct flows carrying GTPU traffic 
> originating from <Inner IP> and tunneled on a given VxLan at a given 
> <Outer IP>:
> 
> <Outer IP> : <Outer UDP> : <VXLAN VID> : <ETH> : <Inner IP> : <GTPU>
> 
> to a specific RSS queue.

Dunno. I think it's a longer conversation. In principle - I personally
don't mind someone extending raw matching support, others who care about
protocol ossification and sensible parsing API might. But if you want
512B you would have to redo the uAPI, and adding stuff to ethtool ioctl
has very high bar as this is a legacy interface. Moving ntuple filters
to netlink OTOH is a different can of warms - it duplicates parts of TC
and nft while having a _lot_ less capabilities. And performance
(everything under rtnl). Which begs the question whether we should
leave n-tuple filters behind completely and focus on tc / nft APIs.

So I'll be completely honest - feels like this is going to be really
high effort / benefit ratio for the maintainers. It will be challenging
to get it merged.

