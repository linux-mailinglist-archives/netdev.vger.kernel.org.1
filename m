Return-Path: <netdev+bounces-29715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FF78466E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D203D2810F8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83591DA56;
	Tue, 22 Aug 2023 15:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCE79CF
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C2C433C8;
	Tue, 22 Aug 2023 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692719992;
	bh=U5/rni7ScMnO0oxxGq/4AvPlu3yOQhVRQnsrpy6LqXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lGTdEXBEwFJ4kOaYWUt/D15uCtzCvKv1svUaa5EflX4HJOSu+qQQqpM5VKRZkIb9c
	 0Vfqpk0qaYDO6rh2gA/WIn+aMo3wbuMVBhIAefxIPY86KOHJ5mE6spMRy0OQKwirbC
	 F05Jmfr0DFkb8I0O8e9jccCJjo5BmIyH5Y2b856E1lW2B9c+IOd3QCfB5cXoV16Zyh
	 p4Wk7cr8eqjIysxR0Ns3fsi/P+64wn/lN4/4mysSKH2DyqZ98KC0aBQKwmh8GoLNnn
	 OsUkHlsS4Chg2NYbUX72Vvd3dfu3R9me3WNvI2K+Gyo/77WK58vO2pM4j5C9+hRTgB
	 OMiYeTgk5RzQQ==
Date: Tue, 22 Aug 2023 08:59:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Scott Dial <scott@scottdial.com>
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Message-ID: <20230822085950.02d2d2b0@kernel.org>
In-Reply-To: <ZOTWzJ4aEa5geNva@hog>
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
	<20230818184648.127b2ccf@kernel.org>
	<ZOTWzJ4aEa5geNva@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 17:39:56 +0200 Sabrina Dubroca wrote:
> 2023-08-18, 18:46:48 -0700, Jakub Kicinski wrote:
> > Can we not fix the ordering problem?
> > Queue the packets locally if they get out of order?  
> 
> Actually, looking into the crypto API side, I don't see how they can
> get out of order since commit 81760ea6a95a ("crypto: cryptd - Add
> helpers to check whether a tfm is queued"):
> 
>     [...] ensure that no reordering is introduced because of requests
>     queued in cryptd with respect to requests being processed in
>     softirq context.
> 
> And cryptd_aead_queued() is used by AESNI (via simd_aead_decrypt()) to
> decide whether to process the request synchronously or not.
> 
> So I really don't get what commit ab046a5d4be4 was trying to fix. I've
> never been able to reproduce that issue, I guess commit 81760ea6a95a
> explains why.
> 
> I'd suggest to revert commit ab046a5d4be4, but it feels wrong to
> revert it without really understanding what problem Scott hit and why
> 81760ea6a95a didn't solve it.
> 
> What do you think?

Unless Scott can tell us what he was seeing I think we should revert.
The code looks fine to me as well...

