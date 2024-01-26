Return-Path: <netdev+bounces-66289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893383E4F8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1997CB26A19
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25038388;
	Fri, 26 Jan 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjjrUjae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139C47A46
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307274; cv=none; b=o01pHIH5xjEns9vjxuTFwcUi1Jni9aIb4xvF6nh3IGDi6lRWFjAdlWTP5cXyTAVGOh/xdKnRYmtWEPOBO243prBQW7kXnGwc1aRSNtd95QeOWm8XZyQ1/g9uuz5uB98h4D1lSdsVAsY+MKyqNUsh2l6OHaaxsP5Ozypu98Wsu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307274; c=relaxed/simple;
	bh=O+evovscE1xZusCWBA6PGu9k3ENegClBMa+eeFz0GHc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=srE/TO2/kLoqkFMGwEKcgYSlXm6WU8Ga/k1mO17Q6ZDzp9muBSu68a5tXfubc89ZspkLNBxLVRZA6KGoUdV2+r6s45yZlrpYxXRZBz9LVje7z81TM8Tj8/Q328nVuc4ezUHmbko/b+QMZQ+4kM4JAsYtuiBK+fM/PtrraCfxVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjjrUjae; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eccf4a91dso13117545e9.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307270; x=1706912070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Yxm79+6+FK/awDAUlmcWMBGSPy/7KP13rKHZaKYJc=;
        b=jjjrUjaeBrvMgjCc5sKsLtwsIRQeOGDx+ANylj4DlGAXlk3j6D+w5A2xcbUJnq9YfJ
         kAsvjZsi4xiw4PX3MaakjIaYHKtAvD4W4DMDAv0TLLfbtNcse2yhe9bGxigg46fvlSy2
         bu+Owjw/Cw+ieqOlAS3uAuXIQif/op8C/VRRI+fzG5rHcFRc7sCTp2nVRRfm3G6024IE
         qyGzQsaMzWAtFjfAQP194F0PG6+sFaGhdEDuRvzyVWkAI6mKlNUh+5ktsFeu58canyax
         asj/489ESbh5fhGI1d9+Fbtq0jbgja9h3dQkP83UPeI7yskYoJ7e8Kl+nVmJizbS7NuK
         qfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307270; x=1706912070;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2Yxm79+6+FK/awDAUlmcWMBGSPy/7KP13rKHZaKYJc=;
        b=cUpLmYIVj0ssIy25G+KYxqcWsXcoHrxwluqqZZRzhp6RP294i7XqOSckhpM6QSy3p6
         3VvdG0/i0vlqxLgR+RrmCaGl1yOgHtXk2gb8a6ugfUr/j0dpXVx5f8HkzbU1SeeAvTsK
         NwwTqOdwSfyiR26Yliph8J9EAe34Vf+FOu38qmvX+fuDlgK2yRl0Te9nGNcSn4KEKSZD
         Ap3kMDgRTZfoWwJoBYn9DkvNaAFAAoLchAVRJkXVkx0sstZCglsOn1VTc48yyzk3Jp/w
         bHBJWb8PbEADWjBBDrjjkSgPZTHIdABlbnZx18ccSz+OwYRweDs0UO5+s2OxJY8kV9ns
         JrEw==
X-Gm-Message-State: AOJu0YwAo4FPzUUgpqjIOYr/lzmMJog7is0VloM4ez4CelZO5L9wkZq+
	H22s5UWv2/zRT7r2J681kym6QM01/w8IPpTura+2uCywdfrbohPG
X-Google-Smtp-Source: AGHT+IE5tQ1u1K1qCP9V9nzoBqP8fIjUliunBmNKVNwfdKeYiKMcOSztmhVkqqnQmM/JDBy5cJub2Q==
X-Received: by 2002:a05:600c:314a:b0:40e:629a:b7d9 with SMTP id h10-20020a05600c314a00b0040e629ab7d9mr352233wmo.121.1706307270455;
        Fri, 26 Jan 2024 14:14:30 -0800 (PST)
Received: from ?IPV6:2a01:c23:b936:a00:2153:65f5:37dd:e726? (dynamic-2a01-0c23-b936-0a00-2153-65f5-37dd-e726.c23.pool.telefonica.de. [2a01:c23:b936:a00:2153:65f5:37dd:e726])
        by smtp.googlemail.com with ESMTPSA id qc10-20020a170906d8aa00b00a34a47ca2b2sm1047973ejb.85.2024.01.26.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:14:29 -0800 (PST)
Message-ID: <15f3a892-7860-468d-b4a9-ace5ea4a4b58@gmail.com>
Date: Fri, 26 Jan 2024 23:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 3/6] ethtool: adjust struct ethtool_keee to kernel
 needs
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch changes the following in struct ethtool_keee
- remove member cmd, it's not needed on kernel side
- remove reserved fields
- switch the semantically boolean members to type bool

We don't have to change any user of the boolean members due to the
implicit casting from/to bool. A small change is needed where a
pointer to bool members is used, in addition remove few now unneeded
double negations.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h |  8 +++-----
 net/ethtool/eee.c       | 12 ++++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index a850bab84..14549cb9e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -223,15 +223,13 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
-	u32	cmd;
 	u32	supported;
 	u32	advertised;
 	u32	lp_advertised;
-	u32	eee_active;
-	u32	eee_enabled;
-	u32	tx_lpi_enabled;
 	u32	tx_lpi_timer;
-	u32	reserved[2];
+	bool	tx_lpi_enabled;
+	bool	eee_active;
+	bool	eee_enabled;
 };
 
 struct kernel_ethtool_coalesce {
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index 21b0e845a..ac9f694ff 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -98,10 +98,10 @@ static int eee_fill_reply(struct sk_buff *skb,
 	if (ret < 0)
 		return ret;
 
-	if (nla_put_u8(skb, ETHTOOL_A_EEE_ACTIVE, !!eee->eee_active) ||
-	    nla_put_u8(skb, ETHTOOL_A_EEE_ENABLED, !!eee->eee_enabled) ||
+	if (nla_put_u8(skb, ETHTOOL_A_EEE_ACTIVE, eee->eee_active) ||
+	    nla_put_u8(skb, ETHTOOL_A_EEE_ENABLED, eee->eee_enabled) ||
 	    nla_put_u8(skb, ETHTOOL_A_EEE_TX_LPI_ENABLED,
-		       !!eee->tx_lpi_enabled) ||
+		       eee->tx_lpi_enabled) ||
 	    nla_put_u32(skb, ETHTOOL_A_EEE_TX_LPI_TIMER, eee->tx_lpi_timer))
 		return -EMSGSIZE;
 
@@ -145,9 +145,9 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 				    link_mode_names, info->extack, &mod);
 	if (ret < 0)
 		return ret;
-	ethnl_update_bool32(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
-	ethnl_update_bool32(&eee.tx_lpi_enabled,
-			    tb[ETHTOOL_A_EEE_TX_LPI_ENABLED], &mod);
+	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
+	ethnl_update_bool(&eee.tx_lpi_enabled, tb[ETHTOOL_A_EEE_TX_LPI_ENABLED],
+			  &mod);
 	ethnl_update_u32(&eee.tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
 			 &mod);
 	if (!mod)
-- 
2.43.0



