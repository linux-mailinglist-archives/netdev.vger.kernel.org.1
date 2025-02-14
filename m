Return-Path: <netdev+bounces-166522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781CBA36507
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EEA16E856
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69932686A9;
	Fri, 14 Feb 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="m0ZNbvgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRVu5Odt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44956267729;
	Fri, 14 Feb 2025 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555608; cv=none; b=W/4Vv+M2/lspqSCCh/qHW7vIzXPIM4pyFHFl1RWFcrs7zC0CKaAGe0CVb4lUJsE11rNtKxCUCZo1Ygsn5UqdKL9krND4lj2FEIiGTzOYdE1crWW5nri/6fZo78fbAlGSs5mrz6yMaix3UfsQ+bMc0m/j88bPorWy8nB8cIQ99Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555608; c=relaxed/simple;
	bh=kjg5gxl2f6INKj1XrXgMNUYSgs+gPi/4wYi/KzID/IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbxm6mmWrPwUDhe31VVctm+s24jVRjXFSZq27Xrm6IkG3spf3oM2slCHuW4MmGnmxk0BlMLqpw+xIVsHloiBp+oi1wjFNeL0++iK26lP+STwlCD6FC9VQwFnGiGbdz/RBCHSch4L9rIfXaqUhWW4avpwSFbnZbnkihLWS5oWHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=m0ZNbvgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRVu5Odt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 048C911400D1;
	Fri, 14 Feb 2025 12:53:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Feb 2025 12:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739555605;
	 x=1739642005; bh=wXrNVYCspj4OrbFJ7KwnoPnS6zqQ5wTzdVg6vgsq0MQ=; b=
	m0ZNbvgE2WI4qnWPj1wNlAliWNyA4+1yywPz4/pdkffhOWprulZsT3N35oIR3cDZ
	BaB5F/cY9UVvDFfve3NdnEelEOzrMS/MoC/O6AmWSkbxL9ZXb2Wajxu8Ne/Gy38w
	u3zxMveHlpphN8/BlZV01pVDUY49nUlxPrD0rQ/L6urk9dv/7lLSFrlJIWgLjzey
	1y630cs7VhxOm2qiyqSgc/JYFWkeDXmISkYv3d7g28EyLyHcZ+91hT29iPTCc/Z8
	e4iiTTF0YcxHLthOMzf2+A2yCbnqE1ty5kC21xlEdKRr2FLFboWye9VpqI+aiHcE
	H6Ufmz9UgyKmVjy3RIbMpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739555605; x=
	1739642005; bh=wXrNVYCspj4OrbFJ7KwnoPnS6zqQ5wTzdVg6vgsq0MQ=; b=P
	RVu5OdtZh8aIPmseccabOxAJLKgQ/v0J8wGGrEXAzcvzR0jBW7T0EOwRcQTWBnx3
	I8dqjvFipVNC9s+9YXwUGEQg93lN/ccT6assMXlmS/XVG45fOOYVjUewVw0yc6H7
	Ca6e8Ul+smO5pdSmyTa/lQibb3/RBdI2YOOVI4M0AvIM+1KI6UpRDCPo2vjxCEu3
	TgcsXEp6lCDZFe6XozIjCybQYrh1ILI0paSsY+SZ4sOfmt9ihKVzBrJgNm0pIsae
	KMXQOEbuP/w/+p1K3R5sLD2zdeAC7u21NldflHaN9UdUBzOemKZwAATqJKhfHjBG
	nEekH0fhYVAzPXg+UlK0w==
X-ME-Sender: <xms:FYOvZ5-BKfuQqJGnIc5rtxuuYtJObZKNQ2iDJxIobjyG31ayD2M7vg>
    <xme:FYOvZ9smq-P16R4yedX6UVQdlCLZoiNWjDusHZlD5XK4D9SRaBzqEC67d7w9QPjGv
    7a3_mi0kQMOqgKMCwQ>
X-ME-Received: <xmr:FYOvZ3ClDGiEDgmaDCw_3UuZJyiKa6rDV11-g5j0uIlsMbGz0t7tN2SZotfIIKgxvc5d4KlIMDjGeyZW7h4Ngtlj0SzTkT4Lag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsoh
    guvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgr
    thhtvghrnhepfefhleelhfffjefgfedugfegjeelhfevheeikefhueelgfdtfeeuhefftd
    dvleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    nhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrd
    hsvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peguihhmrgdrfhgvughrrghusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvg
    ifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehgrhgvghhorhdrhhgvrhgsuhhrghgvrhesvgifrdhtqhdqghhrohhuphdrtghomh
X-ME-Proxy: <xmx:FYOvZ9d8KJKIswRmM8WfzhQxIkLLFWo7fnkTImRq8yJvAtou_-Btaw>
    <xmx:FYOvZ-MV3l-YcZ-IwFVk6gqfXZVtJ8MFfyIOQue9RecQFDD6bCiazg>
    <xmx:FYOvZ_nfY-HOzFXy0E1l2yEHFA3XwOGUvQzcPS6H-u12QAoCcwW2fg>
    <xmx:FYOvZ4uk6YwHqjF_5E1piL3w8lnhNTrz6_j7K5vJ0QWfokegyT3KBg>
    <xmx:FYOvZ6ndQ_DrSjOW3PBMzBuKm-bGElP-ogiSfIALtbxDLYTA4dXeUYZc>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 12:53:24 -0500 (EST)
Date: Fri, 14 Feb 2025 18:53:23 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: marvell-88q2xxx: order includes
 alphabetically
Message-ID: <20250214175323.GD2392035@ragnatech.se>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-2-71d67c20f308@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-2-71d67c20f308@gmail.com>

Hi Dimitri,

Thanks for your patch.

On 2025-02-14 17:32:04 +0100, Dimitri Fedrau wrote:
> Order includes alphabetically.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/net/phy/marvell-88q2xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 6e95de080bc65e8e8543d4effb9846fdd823a9d4..7b0913968bb404df1d271b040e698a4c8c391705 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -7,10 +7,10 @@
>   * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
>   */
>  #include <linux/ethtool_netlink.h>
> +#include <linux/hwmon.h>
>  #include <linux/marvell_phy.h>
>  #include <linux/of.h>
>  #include <linux/phy.h>
> -#include <linux/hwmon.h>
>  
>  #define PHY_ID_88Q2220_REVB0				(MARVELL_PHY_ID_88Q2220 | 0x1)
>  #define PHY_ID_88Q2220_REVB1				(MARVELL_PHY_ID_88Q2220 | 0x2)
> 
> -- 
> 2.39.5
> 

-- 
Kind Regards,
Niklas Söderlund

