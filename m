Return-Path: <netdev+bounces-276867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAQONfBW12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:36:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4253C7199
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0EB6300623F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBA377016;
	Thu,  9 Apr 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAZRjVLO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+9yA6VB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3C30B50C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720161; cv=none; b=JisffdJx7c9UQoq7F2iWQS5wLsygGvkOrJ9WyFQ+Jgzm3Grlu25L4Yes0fu/b6qxL6tmIm6Rvgsy1++JzQpWeKOWSnOjvThCoCT7D3ntBbbBqX8vOrP+O7LkQuRzuQjVpO3LwWCQ/8YnWsVhF70GykGb8HcL2Jou0p7BtST8UI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720161; c=relaxed/simple;
	bh=VMNO04+sWHiHDMP7MhJuxjp78KjKe667oRjw8GbfBMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGh1DLhNFiGC2c2DVhymcmd6O3e7qK8AAPnDnROlpvHMekiRQ23GFRMSPES3Elrm8Gf2Ki+yOsHUw5uz9KLawAXPbtiKYlpyG+5LzawgP6IiaPGvtGe83uphO4/eMG+j/xzgf7lWfwkscwksV75twFBR9bsH07XMaLtDYojQ1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAZRjVLO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+9yA6VB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775720159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uG19OgUEh7PpCsC75GKl4DnQspRNzaFgp/WQbAcZds=;
	b=eAZRjVLOxOylKMHgqY1duVef/RQJ8RwHlTgPG/IEPd87d6n9VyyFVmra8I6G0IjgsdKTAF
	ZioLnQiAN178ENZUNOnDSAra6Ie5bgWdJua8ooW/SVA+F8d73nXtLJ3jhY/Fun1kvQxuCE
	X/bNCsHsZo1Hpan2Sw5dS4+R1KlJE5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-stPuC0DkOtGtPlNN79i87w-1; Thu, 09 Apr 2026 03:35:58 -0400
X-MC-Unique: stPuC0DkOtGtPlNN79i87w-1
X-Mimecast-MFC-AGG-ID: stPuC0DkOtGtPlNN79i87w_1775720157
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488af485ce9so3784535e9.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775720157; x=1776324957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uG19OgUEh7PpCsC75GKl4DnQspRNzaFgp/WQbAcZds=;
        b=W+9yA6VBsGsH1w2j5lAFVTbXStep9FIVe2k/bcVgUxRanGYKzfRonWtPEuN+UMPCBA
         gQ3wVV3YZzJ2UaCin+BmcYkBqeGZUVmEpy3qXexo+4cxeukK59gW7NqaZfK9QpOGzLZR
         KNNab8G71++zi5FFPfirzz08BQUYs6Af6AC6DFhv8B4hZ/62m8kz+NdFX+2EgSN4e58v
         72h4OwfeokGHIQDrGsHOlAus4u7RFHkZYHfYW/6oky4WRo1MsIPXqvD1hYcnO8UexA38
         AJvTBkosLjuCYmNkX9eGDslLYtG7//3Sqx3FMc1/0zjGmpqmv5N7oCipHMSFIkr5VB28
         NdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720157; x=1776324957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uG19OgUEh7PpCsC75GKl4DnQspRNzaFgp/WQbAcZds=;
        b=GohqD6f90JftfYTVdRJk1STnoV9W/N7hn6JijJH5pBDn04NQjYZ9GU+l91893MeHFv
         EtFgQmgO6GRCjS4/bXpjQjJ8p/oUQI04SnwIu4qbmBdUOlENOZ/z1ROjOYNbup/aBgeh
         J8mh2tfCSghFIlY30ntPOvKRIwzSzv8lgjVn1yxet5wGxdhgDjPKHHe/oFLou1NdCnT/
         WXQEEBmG7x1X4O/RbNiGEEWJmgkt/cX+n4Y8dSF2A/5bLdhj8Pxfr+XcsiKKAD5CKcI5
         LjtuOSfe35MNAP2wUlMZnZlaydnLjQXLliMsC+14ZivH8UYlPFxteZbVR27uQKt+0OFf
         /r9g==
X-Gm-Message-State: AOJu0YyVCNZ5JmlkGiQEu23KrZgyiwDjgQg3+7TzKHI9OK9rd9uk8lUB
	llFtYrpnvudD8wFLAnEQhuVRIz0eHvj9bgtq4vW0VQdvDqEaU+5zm/qy1+VPFS+fP4ilbP0wvDq
	t5N501i9iFWuklquMNA/r8Z+hCZMkAf21w75n+nXkNMZVw32sneLfKrc97w==
X-Gm-Gg: AeBDieubHqt7OoVHQq+/e2Nm6d9867xZ0hBOy+7SS1Sbn4kdF1DrqWSnKG/ROpWr/EV
	/G8klD52R3xM3rLPDv023M+Dh+v97JT+H+BE4m1dLk6itwRyoAwqaVc9S+UoU++sFfaHlyienUJ
	Ev4Evyp8d7k3HlJWBzkskJnuYq4qjcHZFi0HvJbv66T4/0Glkbz4aRJSKPbeEO8W81G7kxyXtHu
	4lrvnx2KY1MPR0lLlBXD4/200bTmvlYLsofutrKtVyw90kVWqBIpVy5rCd32AP6DoMIN5iM3rTm
	uJ2AC6IoCpJ08YRm7DaRvgjM/sEi3mt+J7r00r64OKHcWS5wlXdLD3boS5U0T9wdJGOOseb8KfE
	xOMmIVuOdgNFf3GSud7Wo9nKEujwmrM2mosreJ1yj98A9Y283vHMP7Prw
X-Received: by 2002:a05:600c:8719:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488b8115360mr164776055e9.25.1775720156708;
        Thu, 09 Apr 2026 00:35:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488b8115360mr164775565e9.25.1775720156209;
        Thu, 09 Apr 2026 00:35:56 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd18f377sm26560865e9.9.2026.04.09.00.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 00:35:55 -0700 (PDT)
Message-ID: <76e290cd-22bd-4ed3-b2b3-036e1edff140@redhat.com>
Date: Thu, 9 Apr 2026 09:35:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA4253C7199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 2:37 PM, Maxime Chevallier wrote:
> Hello everyone,
> 
> Here's V9 for the phy_port netlink interface (get-only for now).
> 
> V9 addresses sashiko's issues (not all of them, as some don't make
> sense), and updates the missings parts in the doc.
> 
> This work extends on the recent addition of phy_port representation to enable
> listing the front-facing ports of an interface. For now, we don't control
> these ports, we merely list their presence and their capabilities.
> 
> As the most common use-case of multi-port interfaces is combo-ports that
> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
> SFP stuff in this series.
> 
> This series is in 2 main parts. The first one aims at representing the
> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
> by far the most common cases for multi-connector setups.
> 
> The second part is the netlink interface to list those ports, now that
> most use-cases are covered.
> 
> Let's see what we can do with some examples of the new ethtool API :
> 
> - Get MII interfaces supported by an empty SFP cage :
> 
> # ethtool --show-ports eth3
> 
> Port for eth3:
> 	Port id: 1
> 	Vacant: yes
> 	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
> 	Port type: sfp
> 
> - Get Combo-ports supported modes, on each port :
> 
> # ethtool --show-ports eth1
> 
> Port for eth1:
> 	Port id: 1
> 	Vacant: no
> 	Supported link modes:  10baseT/Half 10baseT/Full
> 	                       100baseT/Half 100baseT/Full
> 	                       1000baseT/Full
> 	                       10000baseT/Full
> 	                       2500baseT/Full
> 	                       5000baseT/Full
> 
> 	Port type: mdi
> 
> Port for eth1:
> 	Port id: 2
> 	Vacant: yes
> 	Supported MII interfaces : 10gbase-r
> 	Port type: sfp
> 
> - Get Achievable linkmodes on a SFP module (combo port with a DAC in the
> SFP cage)
> 
> # ethtool --show-ports eth1
> 
> Port for eth1:
> 	Port id: 1
> 	Vacant: no
> 	Supported link modes:  10baseT/Half 10baseT/Full
> 	                       100baseT/Half 100baseT/Full
> 	                       1000baseT/Full
> 	                       10000baseT/Full
> 	                       2500baseT/Full
> 	                       5000baseT/Full
> 	Port type: mdi
> 
> Port for eth1:
> 	Port id: 2
> 	Vacant: no
> 	Supported MII interfaces : 10gbase-r
> 	Port type: sfp
> 
> Port for eth1:
> 	Port id: 3
> 	Vacant: no
> 	Supported link modes:  10000baseCR/Full
> 	Port type: mdi
> 
> Note that here, we have 3 ports :
>  - The Copper port
>  - The SFP Cage itself, marked as 'occupied'
>  - The SFP module
> 
> This series builds on top of phy_port and phy_link_topology to allow
> tracking the ports of an interface. We maintain a list of supported
> linkmodes/interfaces on each port, which allows for fine-grained
> reporting of each port's capability.
> 
> What this series doesn't do :
>  - We don't support selecting which port is active. This is the next step.
>  - We only support PHY-driven combo ports. The end-goal of this whole
>    journey that started with phy_link_topology is to get support for MII
>    muxes, such as the one we have on the Turris Omnia. This will eventually
>    be upstreamed as well.
> 
> If you want to play around with it, here's [1] the patched ethtool that I've
> been using to produce the outputs above.
> 
> Thanks !
> 
> Maxime
> 
> [1] : https://github.com/minimaxwell/ethtool/tree/mc/ethtool_port

Some feedback from Andrew, Russell or Heiner would be very appreciated.

@Maxime: I went over sashiko feedback and I *think* it ranges from
orthogonal to wrong, but it would be useful if you could go over it.

Thanks,

Paolo


