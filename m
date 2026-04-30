Return-Path: <netdev+bounces-282803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDZGcg982kGywEAu9opvQ
	(envelope-from <netdev+bounces-282803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:32:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C049F4A22E9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038263001CDF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C23D903E;
	Thu, 30 Apr 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QimBV/Y6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODNclXgI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860D3D7D97
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548446; cv=none; b=aykVqGa48YYdm8mBLEF3AHILGPw/8VY85qRPikisfgmEGvpznDkSzFXPdNCFOR7rdmnIDYZfYE5NzYZ5l5LpJr36czZ7zjkEPmOXT/3r/KrebSeKuxhwAFSI0T3u9v80fUBE3SEKLEOKH2mGmPH1eVa/36Tlb2v3SccNsp77PyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548446; c=relaxed/simple;
	bh=2T++ZgnqanVb7btL16I7116C/GmLc7NafiInXl+HwAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EBRHWj7Mtoejdg9L+mSJVP9BFpjDhgkwJg1aHcgJraH6f55mkIxXDEYq3blxixbZ0NSMJCdzhOXtsaaUOkt67+MxvvGlTaUDiZrUX7Z02XBR7nFeon10Ocpdqo4eKsjFiAb3csJRGsT85qMVc386A6DiCJQ5tgpi/mBdnPiZ6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QimBV/Y6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODNclXgI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777548444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIMy9S5iWlyc40JZ79p231oXUkP2gHnlruiMtNy2qdM=;
	b=QimBV/Y6IlW8KXhRLpIRQmuf/sU8V6i4BCNEvOBVkzmHXkl7ufXyMtDKGovzq3WqQc0j8l
	rIr537z8yLGZ7yDB9rM1jyLRx8+yWdZHxUeC7WEW1YF78rkVpMZ6BmD8kNMWJF63kgF8rI
	xO+bLaBP/0rc/To23nYtCXUAIBUjykQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-260oxfxhOJmGNYhc0a_Cpw-1; Thu, 30 Apr 2026 07:27:22 -0400
X-MC-Unique: 260oxfxhOJmGNYhc0a_Cpw-1
X-Mimecast-MFC-AGG-ID: 260oxfxhOJmGNYhc0a_Cpw_1777548442
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so527078f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777548441; x=1778153241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIMy9S5iWlyc40JZ79p231oXUkP2gHnlruiMtNy2qdM=;
        b=ODNclXgI/vVOyfw+vWdQkOsi4g1BaoPK55kphih59OqU4cnm21p06pmgvfJzG2zBgI
         gBcNluAdw4lYpNSeIKh6r/MP2pn6jCAeZ0MsuMhVi1olyzRO1ssCH1oTAunkGxzHvbdr
         Vg/V+BRKlXEIQ2DBrhAOIQzy2UNrJmBWrd/IiozmrD0n79r77nzxUwdHyBp54D7TG360
         rvOICVmlGTI3ZqTR1w1s8MAno3RWB7Lby7VqKO3zGdjYf+x9Riss5QLVSIsn6Tj5bYbO
         BlyzK5sRSKBcxOR6VOGIxr9VpdjC16XDCYMGQloMdc2wCgB4XyOLLSeH3Db4tuT13NSd
         YItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777548441; x=1778153241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIMy9S5iWlyc40JZ79p231oXUkP2gHnlruiMtNy2qdM=;
        b=EgZJzUk9MVDl3D/NRuw7W7pt2WSglAs+UvOIGdu6VD6TRfXE3N/rDnlBUyABpXe7YB
         aubGcthJSC2+VCXpK2ejUFMeakKlW757CvomEMJRDC4DdmDuKjLitRtZoKhYngIe2XQC
         Ax4tUqd11B2XEKtm+IMzDrgW1wZcP1Rw4+cxBH7WiCugwildE+HuN8IeVZsmsq0gYReY
         IlFA1Eiyyj9CHiVt++lFJ+BA3JCrM/6+RWwepK8fYC9jNxhGeT2J+2GYUU+sE0hsBlPH
         o9ZGxUVpoOL15kKLn6nlBnc5kQO3pMaXpmig8HOGx5aJSCSYPASWPGWpglEZ+5dQFqr8
         gblg==
X-Forwarded-Encrypted: i=1; AFNElJ82L3RQF3JEwuhcv98L+vL0gpPe4ZinuOt05RMtOsbD8J5x5ujyjoHp8+/a9455M+FFLK6/hpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAq1WNnlYEagRER0hW4XFA7RRWcPhFfNnMuVoNSDCE0Z92AAe
	qYb4fW+qmU+hCRclKzNthO2KlAgCJh+6joEtwJ4lrFfZBt+i5m0IVkd9D1IC9MYUOJRtfzBpxKg
	qERAzyL4iNhaLfYDC1qxzVSDlRz5oza110Ae/IByS9KiIJKq6znuKZ/6LaA==
X-Gm-Gg: AeBDiesE9eCG0u+Y7oQE9fL8LfPd/njIvxK2/CHsuutlj0ScxPEO8iHSv5FXEAHtfAC
	GJZvt0Pku5Niows4+/NRAuzCE42hhOaVzmDdWYvJIn91hGCEH6o36+YZgpKHY/IQLfs5yvZR2um
	FwMaqd1AHmQ/u9z8GFwTGJsv2j9jLvpEwMKsLCrv9RR1AeHq1hZd/zYuGEgnVx/fK0vrS5CxS8S
	6S8HBQOGY1cq7Ds7lx5pw8lnHCgxDlnt72EKV62Y2iwVHfqxtP5VgDVN/AC8sgkC75JYq706EaW
	t34CnASGGBzV8XZzUJHZ3Z2IHeq6pzm2Hipe3leqK403yJYEUkSZkYZJleTJZEvPafIPAf33+ZA
	mCVQLldTz5Qw4QN5eU50G88kvQ/1O4THF5lWHTAHXjjNyiJ6/jJSFJtL7GCuhH2qOAg==
X-Received: by 2002:a05:6000:3105:b0:43c:fe0e:5bbc with SMTP id ffacd0b85a97d-4493d21f546mr4136250f8f.19.1777548441443;
        Thu, 30 Apr 2026 04:27:21 -0700 (PDT)
X-Received: by 2002:a05:6000:3105:b0:43c:fe0e:5bbc with SMTP id ffacd0b85a97d-4493d21f546mr4136180f8f.19.1777548440919;
        Thu, 30 Apr 2026 04:27:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm10934692f8f.5.2026.04.30.04.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 04:27:20 -0700 (PDT)
Message-ID: <0060104c-bb38-45d5-8f8e-14708702feac@redhat.com>
Date: Thu, 30 Apr 2026 13:27:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: fix LAN8814 QSGMII soft reset
To: Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Divya.Koppera@microchip.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428134138.1741253-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428134138.1741253-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C049F4A22E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-282803-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[sartura.hr,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,microchip.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sartura.hr:email]

On 4/28/26 3:41 PM, Robert Marko wrote:
> LAN8814 QSGMII soft reset was moved into the probe function to avoid
> triggering it for each of 4 PHY-s in the package.
> 
> However, that broke QSGMII link between the MAC and PHY on most LAN8814
> PHY-s, specificaly for us on the Microchip LAN969x switch.
> Reading the QSGMII status registers it was visible that lanes were only
> partially synced.
> 
> It looks like the reset timing is crucial, so lets move the reset back
> into the .config_init function but guard it with phy_package_init_once()
> to avoid it being triggered on each of 4 PHY-s in the package.
> Change the probe function to use phy_package_probe_once() for coma and PtP
> setup.
> 
> Fixes: 96a9178a29a6 ("net: phy: micrel: lan8814 fix reset of the QSGMII interface")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/phy/micrel.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 2aa1dedd21b8..e211a523c258 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -4548,6 +4548,13 @@ static int lan8814_config_init(struct phy_device *phydev)
>  	struct kszphy_priv *lan8814 = phydev->priv;
>  	int ret;
>  
> +	if (phy_package_init_once(phydev))
> +		/* Reset the PHY */
> +		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				       LAN8814_QSGMII_SOFT_RESET,
> +				       LAN8814_QSGMII_SOFT_RESET_BIT,
> +				       LAN8814_QSGMII_SOFT_RESET_BIT)

Sashiko says:

---
Could this introduce a race condition if multiple ports are brought up
concurrently?
Because phy_package_init_once() does not provide a synchronization
barrier for followers, they might proceed immediately to configure their
registers while the leader is still performing the reset.
---

on top of my head IDK if such race is possible at all.

/P


