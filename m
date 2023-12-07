Return-Path: <netdev+bounces-54830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C9808727
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9CA1F22222
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48239AC9;
	Thu,  7 Dec 2023 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4JRmYPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29644358A1
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DB6C433C8;
	Thu,  7 Dec 2023 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701950276;
	bh=ZadLVg2xVw24qHq11LzSKHwhUbpz7A2+VUUzqsY+gLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4JRmYPDzmJcuIpWDoFr/AgUuC/LimYiBWcKw4SKa/rIIAtvW5457js1EIRnSAKp9
	 oiaGYfk70CtpyYTBw7P9x+5nAzh8+51Ivyiep0AfKrmW2Ww+vIRA8i6a0rtKk3weII
	 o+wouwc0EAcKUT2uFS0BbXEm0oLi8+yTfqEBSPcHVKvp0TBzTatvJnyQkTFJsHDZbF
	 xHeb6fw4PLDs0XjSz73zpfC5U4skvJPyA4sKyyFciJECWNNLeAmY2NZ28yHa/wwV2j
	 gky0Np8hxDExwZzEjtV/D0cvI8PYHhAobsq0ipFtKJxLs4lGyDG49/GfnvnDYedEEg
	 VsCQ/2YvkuYgw==
Date: Thu, 7 Dec 2023 11:57:51 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl] idpf: fix corrupted frames and skb leaks in singleq
 mode
Message-ID: <20231207115751.GG50400@kernel.org>
References: <20231201143821.1091005-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201143821.1091005-1-aleksander.lobakin@intel.com>

On Fri, Dec 01, 2023 at 03:38:21PM +0100, Alexander Lobakin wrote:
> idpf_ring::skb serves only for keeping an incomplete frame between
> several NAPI Rx polling cycles, as one cycle may end up before
> processing the end of packet descriptor. The pointer is taken from
> the ring onto the stack before entering the loop and gets written
> there after the loop exits. When inside the loop, only the onstack
> pointer is used.
> For some reason, the logics is broken in the singleq mode, where the
> pointer is taken from the ring each iteration. This means that if a
> frame got fragmented into several descriptors, each fragment will have
> its own skb, but only the last one will be passed up the stack
> (containing garbage), leaving the rest leaked.
> Just don't touch the ring skb field inside the polling loop, letting
> the onstack skb pointer work as expected: build a new skb if it's the
> first frame descriptor and attach a frag otherwise.
> 
> Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


