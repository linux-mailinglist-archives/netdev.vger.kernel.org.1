Return-Path: <netdev+bounces-259851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILDEKURkmmm3bAMAu9opvQ
	(envelope-from <netdev+bounces-259851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 03:04:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F116E677
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EE08300E482
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D141A267;
	Sun, 22 Feb 2026 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvd8sjn+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7C611E
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771725887; cv=none; b=Tt4tW/rILqCLLmbu37OJVCNXNEhrVKIRdadjrgFnubQK2EA056S2HDTRzI/2mlda3SVx6kA6W1jT/9vlIF9PAJPQx/B1EePZMlt69NW4vzC32qbD3VE+KB0nM4/l1Sya9LK8ab5jEd+/RKQfE+2Xu2OPEb2Dc1ufbL3ThxmQMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771725887; c=relaxed/simple;
	bh=duhTr+UYCjJ+PiTP/OhBINAZDcKPVyrQDeSGofbEE98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxsMqXnQb5lkhu1KBMNTlxhUN5/Vm3XL2StpWuqPjwD7lA2XtirG84L15g6sol4PcErf2dBNJzBiv9c2i9iQQbrAlC3rvd6DJxz9NAa/AHQTA6dF7jZx9H3p8JoueNISqIsktyPdXkE7NcK2/1cMePBUrjkgHb53jTo1M4YuYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvd8sjn+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso38820535e9.0
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 18:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771725885; x=1772330685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ytpaqle850lzDXvjY9BO31X2B2LdaqlrsmWEjqqLOeA=;
        b=dvd8sjn+A9Fm68Ke84idvAwhsOdUxb8QY+uJVFQSeIuwLfTqvbYnpoovVkIVM2XZhm
         QahHzPzLKoFR428rnkEnBLCLbPE7D/jNaJpiipV/f7S8XbANbKSy6fXVcyjXeugCJmZ2
         7SvxoQSZJMLEMeU/ul+VlV9kJiIWY+4IsksnykcrLwT9YF/awWNF7V+W0bQheepVHrPm
         pGackgBTMUBtWJ4qDrpRJQ2f3d37jQxIFZBNb9+iTI/yvvQ3fGzhAlad4Q1gSlrzW2BA
         RNTuYg3Iu80GjGOxaMZ5tUllFF9JBU3jkLO1cmUGnvhqFpxsxkvpFsXjWgN7vRs6Em3x
         cdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771725885; x=1772330685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytpaqle850lzDXvjY9BO31X2B2LdaqlrsmWEjqqLOeA=;
        b=XJX7044H+Lo7uWC/XJcg4eHczWjVpCCyxGrp14/psftCWEPed4rhoSTxb49PT/ZDKa
         baOMWYpAQ7q6l16CSYMJUSxP8ByPhmnrJLxk6Kf40hpNTH/KnvGzy7DWsP3tm7JyCBQB
         EzHINmZ1MnuVx8t3K4P99F+4rvkdKDGmmMCNtUC8g4unStfHG8Hc1x6gwDcQ/1M6YLcy
         YG52urFMWe4WDNGlaB0ZrJKzINnW6yNtk1Eqo3lFsWwpzyhyT9QUx1NbeamldcN3ske/
         052mhr66Yjs7JyefUtxjODUS3xPh4Uu6XjFkf8RSdVQ4LzxE/Kz0wA0US3Fa69bTANw3
         D4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRGmFOJ3sIsrIInM1VcfTRdUWP9NjMxvqAmSiWv1hJAl6SjoZRtplqz8WxTcLmuvcqRsZOMRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAcaixSHcg7eVr8og7IklOvwaqduPZ5Dr+VaPNSLJIQNyrpFB
	qDeG3aPSeic4IXTVirqJRj7HNn+EB8h4MNz6tzsBThrosMPd0BvxU8eM
X-Gm-Gg: AZuq6aI+OU6RfIgyu1EqMPrm1V9QcKuTb7jzZnPWB4Hiyc7ju6WKj4N1TujNXEUBwe1
	vurdiP3MSi5D4NJh2+Qk+npyxj/SZ3wfzRGC5UffOyeXFOQZ4w//Qj/6Vo09RAK9UfC18ORUY6E
	n1Ce1BGgc9LiZ2Cb5VYBDaHzCR+ykMaDv/1rxQqMCvakBx0HbkLBrSYMuYIWyGHPj0QlCx8oYkm
	R5MIJfEZD1vf2Tj/OggO24/hZJO+j9RXyoxJhYWYRjhoAPC1IgtdeUwsnmcDEs7XG7BErvRYTXB
	+5EaGv2cu3L0EJ7DSglvnbAPcyW3UmK944PTVrubGU1a98Ill+3G3RU16oV7XouZLHFGrZmaHpb
	PxEIqQX7AgTkNdZw8IKxdAByg9tAXr1/h+xjtTk8mk0RXDK8VltVhcqKICq2NxuUcyHJXs9NMzA
	cg3V8n5fOWacd8wx28WsstZX0+8ihep24Ku2xuryqfVVPCd9MtG4icmW8zS5ZyqgBWQt3AG7TSD
	Cei6gwM/+M3VGU=
X-Received: by 2002:a05:600c:3b18:b0:483:29f4:26b3 with SMTP id 5b1f17b1804b1-483a94923bamr82501265e9.1.1771725884609;
        Sat, 21 Feb 2026 18:04:44 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a42ea5ccsm53644165e9.16.2026.02.21.18.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 18:04:44 -0800 (PST)
Message-ID: <0c1c2c7d-73e9-4412-b68b-4f2e8a396211@gmail.com>
Date: Sun, 22 Feb 2026 03:04:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Frank <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <aZpLZMK-FTmQI53o@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <aZpLZMK-FTmQI53o@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994F116E677
X-Rspamd-Action: no action

On 2/22/26 01:18, Russell King (Oracle) wrote:
> This is too late (chicken and egg problem exists) - phylib will already
> have scanned the bus, and found a PHY at address 0 (whether it read the
> IDs correctly because of the conflict is a separate matter. If there's
> a conflict between two devices, the PHY IDs read will be a mess.)
> 
> However, if this PHY is the only PHY on the bus, and some driver uses
> phy_find_first(), it will find the PHY at address 0, but it won't
> respond anymore.
> 
> Failing the probe for address 0 doesn't solve the problem either - there
> will still be a struct phy_device created for address 0, and if this
> driver doesn't bind to it, the generic PHY driver will be bound manually
> by phylib.
> 
> I can't see a simple way to handle this in the kernel. So, I'm going
> to say this instead: boot loaders / board firmware need to sort this
> mess out and program this PHY not to respond at address 0.
> 
> To put it another way, this isn't a problem to be solved in the kernel.
> It's a board design/firmware issue, and that's where it needs to be
> solved.
> 
> One of the responsibilities of board firmware is to ensure that the
> devices on the board are configured sensibly for the operating system.
> What you've said above, where two PHYs conflict on address zero is
> a failure to configure the devices on the board sensibly.

Hello Andrew, Russell,

thank you for the explanations. I now agree that this is better solved
in the bootloader rather than in the kernel.

The affected Cudy router boots Linux via U-Boot and indeed supports TFTP
booting. From what I can tell, the stock Cudy U-Boot avoids the MDIO
conflict by only supporting the internal PHY for networking. I checked
with a multimeter that the YT8821 is held in hardware reset when U-Boot
is running and this likely prevents the YT8821 from responding on
MDIO address 0.

A while back I did some digging into how the stock Cudy Linux kernel
handles this issue. It unfortunately involves hacks such as resetting
the YT8821 through its reset pin from userspace and then calling
yt8821_config_init() again by opening a debugfs file (ouch).

On the positive side, these devices generally support replacing the
vendor U-Boot with the OpenWrt U-Boot, which would allow fixing the MDIO
addressing early. However, doing so makes reverting to the stock
firmware more difficult, this is something I'll have to balance.

Thanks again for the guidance and review.

Best regards,
Jakub


