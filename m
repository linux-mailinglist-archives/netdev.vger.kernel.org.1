Return-Path: <netdev+bounces-43984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744B7D5BBD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881AD1C20A4E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21433CD0C;
	Tue, 24 Oct 2023 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExRTvu5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35781D6A9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0EAC433C8;
	Tue, 24 Oct 2023 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698176714;
	bh=14CpRoRTnVLHEtyYrgpQsbnAorgH+0vQ4iGdKl0gfqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExRTvu5Y5ZbUFYbkWqXEQdgXPiSGAqjCstU2N/WOkMVWg+3A9OZ6VqSivNS/YqgT4
	 hf2iECUaAaVrQQx/07e2qfceYsVqiMAeFM3QYPh/jcvAmH0vJAXVJ/fEawlJIFj+8m
	 5GPRX7JS1rMXEiqU11MVLCSzFv86k2zNt0dib9E9yc5nCTAct+MhhSMqHrfQfFosiW
	 wrFS4JhtNnopfpU3m2YwLuZhZZWtcBEGZcDb0aDaOBXC8KKCs/B9NRLgHNJo1Snl+I
	 iTCF6FzhSzBMepT5YY3XtxpllbMpecWEbc1IX2X/3RoJ7IE5rTzxMr6jdV4SokQM0I
	 ttGboMV5Kfpow==
Date: Tue, 24 Oct 2023 12:45:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Message-ID: <20231024124513.69121bdf@kernel.org>
In-Reply-To: <dcfbecd9-5539-495f-a046-2d89a34252ca@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<20231024160220.3973311-6-kuba@kernel.org>
	<cb0d160b-42bf-40c9-ac36-246010d04975@kernel.org>
	<20231024104910.71ced925@kernel.org>
	<dcfbecd9-5539-495f-a046-2d89a34252ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 13:19:35 -0600 David Ahern wrote:
> >> blackhole_netdev might be a better choice than loopback  
> > 
> > With loopback we still keep it per netns, and still accessible 
> > via netlink.  
> 
> and if the namespace and loopback device get deleted?

For now we're back to printing the warning to dmesg.

My instinct is that such double-orphans (both netdev and netns
disappeared) should be reported via a separate netlink command
accessible in init_net only. But that's for later, I hope falling 
back to the print is good enough for now.

