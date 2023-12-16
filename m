Return-Path: <netdev+bounces-58159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE981560F
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1EB7B243BA
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2C3110E;
	Sat, 16 Dec 2023 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeYMA2dj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3064110D
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E044EC433C8;
	Sat, 16 Dec 2023 01:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702691229;
	bh=84H98YcSh33wXt1xNDx8TrAJaO6JQefXyhvTmUX7nGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qeYMA2djtyBpdwicZGXtzetCuBf2AOVUk7t+4IjdUh894pzMD45+BJR976Kcwzvpw
	 QNTT9DEceVyNyHQo66w2ro+cApGSpYtZi0iSySaO83jE2tAwpwUTNZDKO9LqxGVs+6
	 tGb5j3jx0ytPnc+fvj7l13bVuk9hwp2X73qHAUWrL7qx0RmM37PBUeLhHYkHtYpa7S
	 O/fO8bIF2Pf8GVK/VYiXx9BoGV3YCz7N0KeS6IVSZKQrtUmHwZKRKmPFgJ86n8LnwY
	 qyvJK8ha+BBJXhJVG0EbSiEPI4v7s8Op9pwAhV1xKXfxR5O6rGMxOPZHS/aGgyAePe
	 PqFjAW5s1IwNA==
Date: Fri, 15 Dec 2023 17:47:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <20231215174707.6ae0a290@kernel.org>
In-Reply-To: <ZXwnqqsFPDhRUNBy@nanopsycho>
References: <20231214181549.1270696-1-jiri@resnulli.us>
	<20231214181549.1270696-6-jiri@resnulli.us>
	<20231214192358.1b150fda@kernel.org>
	<ZXwnqqsFPDhRUNBy@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for the latency...

On Fri, 15 Dec 2023 11:17:14 +0100 Jiri Pirko wrote:
> Wait, let me make your suggestion clear. Do you suggest to remove the
> WARN_ON_ONCE from __genl_sk_priv_get() as well?
> 
> To put it in code:
> void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
> {
> 	if (WARN_ON_ONCE(!family->sock_privs))
> 		return ERR_PTR(-EINVAL);
> 	return xa_load(family->sock_privs, (unsigned long) sk);
> }

I meant this, although no strong feelings.

> OR:
> void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
> {
> 	if (!family->sock_privs)
> 		return ERR_PTR(-EINVAL);
> 	return xa_load(family->sock_privs, (unsigned long) sk);
> }
> ?

