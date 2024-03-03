Return-Path: <netdev+bounces-76908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742486F5B7
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 16:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E9DB24A68
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07666B5F;
	Sun,  3 Mar 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuJwkYgU"
X-Original-To: netdev@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064572E412
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478507; cv=none; b=cxzWHObLbsKzybOpYUexbR3MQM7aRLzw2zq2lXZWk0cOPHVHx+iMcxpZJhJvYmXVdeUGddVQcGT1kne1Dvjtt90r5deMZX0AAROngxBR4YgYgHcFXBSfMuzwGW0Fz38g89zRF/Mq/5lUbrVuvz/debHZQnWeATi8Fg5jx3wphNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478507; c=relaxed/simple;
	bh=aD8YUG4USvnoJxzwK2Ti8FLdDS2uccACDDhpRonlcto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnwJnG+P0VcutHMd5aFM7i0zgTgmVtveUKOerEFYJQ59VPzzPRihm5k8n9dIC61P9S4IxEQG6fJ4GGYRLzGcjE8cv308zTE1ra8NUKEP+AI/vBWZLcVsTXwfAXLgVjDaYk2N8iZNWlYPBS1ae6d1BjLgCIMSALZemzD5P+CT304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuJwkYgU; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1EB6F320010B;
	Sun,  3 Mar 2024 10:08:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 03 Mar 2024 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709478503; x=1709564903; bh=ODKejTPaCjt34kny2jKuwAwh+wC3
	hyoIqlMjRNYMzwA=; b=KuJwkYgUr7aAzk+pmUoOtHv6AzlbWZQTD8xKGzlXbA1z
	boFzVTwz2zvd4k4Wqdbr1nWJ1V5Xd2+8orA5sMC45vfKcZD7rTGacyeRfIFMq9lT
	3mlripOUk4URP1wXvhWir+s6Afg7ZMX45AMVFbR6aUgXR3k66XSAQGLhfXcwGZHs
	pySkj05hVzAkq2jCCn7FYyl/uBgU60nD0F9XT+mLKzMFNaRW7/0E9YmlO4M3yNVW
	LE+vhb8caUNeKoRzkfpn4ukX5UOBS/ufeq0uvq9lMja7LyQr4z/m62asp2/xTpMw
	GF3kvojJ5gCWupVJjAYdFKDd82I4Vut+bXO9753ENg==
X-ME-Sender: <xms:Z5LkZbWDoXs05qSpX0OFJjPoR6lDnwOL3zp4vNeVuXKUyuoh08LUQg>
    <xme:Z5LkZTnO62hn-PUQsb9CIG9sXn7_BWn7oTrgAxSNHEJBAf_xLMFzWUwyLNij0sVyM
    r6TENkOl2bdDBg>
X-ME-Received: <xmr:Z5LkZXZcmgn7XLz3-g1Rg88IB0WoEUUVU5NdSAwW7luqgZ2mgaLj7RC9Y_-r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgud
    eifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:Z5LkZWXOdpuBCcSew_XuJJjQ3BC4_9z2mgUkOvjrxFFbRh0kzb4-_Q>
    <xmx:Z5LkZVljZAYVwiuYfLCovFSJ47t_S-W4qcxO_JmuFbSqfmBdYE8e-Q>
    <xmx:Z5LkZTff8i7CmaeSU_OOhT9sRG86NKUdAHmD_eXSYUFWShxCkB2jQw>
    <xmx:Z5LkZWhSoOmiXs9BknSBeo8Nd37FsZtIzrmawgNXYErpeDKhik42JQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 10:08:22 -0500 (EST)
Date: Sun, 3 Mar 2024 17:08:21 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
	fw@strlen.de, pablo@netfilter.org, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, hawk@kernel.org
Subject: Re: [PATCH net-next v2 2/3] netdev: let netlink core handle
 -EMSGSIZE errors
Message-ID: <ZeSSZSuXED2cIJDn@shredder>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303052408.310064-3-kuba@kernel.org>

On Sat, Mar 02, 2024 at 09:24:07PM -0800, Jakub Kicinski wrote:
> Previous change added -EMSGSIZE handling to af_netlink, we don't
> have to hide these errors any longer.
> 
> Theoretically the error handling changes from:
>  if (err == -EMSGSIZE)
> to
>  if (err == -EMSGSIZE && skb->len)
> 
> everywhere, but in practice it doesn't matter.
> All messages fit into NLMSG_GOODSIZE, so overflow of an empty
> skb cannot happen.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

