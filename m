Return-Path: <netdev+bounces-127188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F0974832
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5CFB23F8B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBD273FC;
	Wed, 11 Sep 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9UCrQ5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C87161;
	Wed, 11 Sep 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726021188; cv=none; b=COVCwPKjmwXXEprAlJwSbB5Yg2I1zcWCrCmVJ/aBl5K7DSefb3syjI5lLOZRd/hpWn5HzgplSn7+eUN6xadz9ciyV5kK35asR8Ja+uJQaCjZ7LgEbBY+eoD6ySRPf2DSLiVpXJH9mSyAfG5OG+PB0thVvgt54WH2mPZKP4xQCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726021188; c=relaxed/simple;
	bh=AJkBmtbaw8Zj8MNsRWLW065rLMCDKTZf84K0t+Toj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ8pCNTVgS/La2G2uMiMz5HiqgRtrgR00fj85CGe0RO3fNG3eGR2jn7BGrUf9mS+5eaDSF/7WtY8WwLHlXrtsQVuO48lXkjTXiMVQfIarJ8S/iruaEhiJyKEpmM8T4I42qQMwefzZZI5B2KzFL2MwYargXiCZ2970MwhwjhkOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9UCrQ5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C758C4CEC3;
	Wed, 11 Sep 2024 02:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726021187;
	bh=AJkBmtbaw8Zj8MNsRWLW065rLMCDKTZf84K0t+Toj0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9UCrQ5+WQECvmpZMrgBlxWCCxLH0gU7LJwA/4WMa1PS1IaI86Mb3pjvbBqfuZ0aP
	 yrI9ru3JLzoYE7DxEqgcy4GdwmyWAK7lBRJN/5ucE4lrSISsNodPEA7mHrx7IUFYCw
	 9O2aEUl2bKVPRLX7dGZ6lrGZVxy0D4KncjkwyeTjzhypeIYmUiA1o3ApuemtKEGIRO
	 kV1ZTey5ghK63tZyzZJkhiTglPiR/ApFysm5JR1kAK9Em3FVGSwrGFR3PyKYWA4Ibu
	 g3ZOBpqDIo6nTjazSMOOA5QfPzZutuTXnFVI2Hfoe62YyS+BCpuDv5X2sJS0if87/C
	 Dh79XLt75P/cQ==
Date: Tue, 10 Sep 2024 19:19:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?QXIxbsOnIMOcTkFM?=
 <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, linux-mediatek@lists.infradead.org,
 bridge@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Message-ID: <20240910191945.717ea514@kernel.org>
In-Reply-To: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 15:03:14 +0200 A. Sverdlin wrote:
> Subject: [PATCH 0/2] net: dsa: RCU-protect dsa_ptr in struct net_device

When you repost please use --subject-prefix="PATCH net v2" 
in git format-patch. The "net" part, specifically, is important,
the patch doesn't apply to net-next so we need to give our bots
a bit of a hint as to which tree this should be (build) tested 
against.
-- 
pw-bot: cr

