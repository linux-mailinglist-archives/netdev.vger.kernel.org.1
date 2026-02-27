Return-Path: <netdev+bounces-261994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OISuEtEXomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:16:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A91BE9BD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F0F31B9F89
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF444779B4;
	Fri, 27 Feb 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPn6DF87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5247AF5F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230267; cv=none; b=tYTJZetC3zT9a22QLgohICBObMPYJtLVm4dyZe+9w26YLz85phxKqWOyWzT7MlFU0MfJJ4Y64dXkqbtah+sRfbqcTDe5sqYKZkjAaFrZyxzHpy1aMTqK2g8xpIIWWHlDkI9S26ApwW0i9VDonfB88a8YjJbTwdjCujOMp7airic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230267; c=relaxed/simple;
	bh=2dGT4likvtwszoXbUiYwtPhQ41CDF65NsMXXeUjsfkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QhQeNJqYOssQAvqDlXXAa7e8qRSnwaCClm1Ky8R5PAb06uDuiNSeM2AGtapMgD0nB5du0WVqPuiQly/PTQpYsM97Vqp8Gw80Ae4WAXUPljB7QWpzEpaQWUaouSc9Rk3HEwbPHfpatd9RscO9i0ab5m91ztYeWwzLswu4X+4a5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPn6DF87; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48336a6e932so15676935e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230264; x=1772835064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOrGLv7mxKqkmbxXFl04sgM6GLQlMw0I3/2NGTQY2yQ=;
        b=GPn6DF870Kx6YN2x86AxrwA5X/mENsjBTY5b0eB/yhK5NuVNVGArNs4+Ba4WLOq1YS
         tAX+TBdJVw+cHqLCQygztEqYl8IenUcan+qY5dSVS95GRozI+5+hpaQz13u4HF05FZmn
         LLq/TyRk4A2ONiPKKt3bxeI7tETBEYr0sj2udGJ30LyBnkbGLP2ZJQwjtobZbgqx9Gl5
         P9Jx8O7x3AHHtcrHQRtu/Poh4KYCIuy8Js4WO2ljnOaqQCL7mRihk6UtWZ72faY2ojRa
         hwGd5A95cqhxygnoervdGbTYVu8DhqMHrKErjP38TmvsXp7pKLHER5H8zG1FCcILWyLx
         GFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230264; x=1772835064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOrGLv7mxKqkmbxXFl04sgM6GLQlMw0I3/2NGTQY2yQ=;
        b=pxiLe9M3xUBsYBX6P6AdFEdIcT/TGKaloS1zoQl6ULiVMmSsG4vdXEeyqPu5iL2Glm
         euMBUlnaSxhQpOxq0gT0h1+vqFUa7fA2NwJDeAt78LDDsOJ48ECLy3HFT551Q20V3LTe
         Qg3LkHJyhwexJ8UYpDXlgVs+qqvWvfB8vhEI+92urr9MSyZQ5KzD/05bddc1iMoMdLSJ
         HkizzwbhwWlVUPRMagNDtqFWRVUuPc/seUVyaj94X9XDLb39HV/2WoGG0bqT1g17+4c6
         mWEYVyl7HbvFIZylB7lmtXKR6mttTSapadi44Ny0rR5RranrO/SYWAqcqct/PvvO5PBS
         wdhw==
X-Gm-Message-State: AOJu0Yy6og+t14kr/nId8w0NeX28jJKsS2Z25+yy2aGkVWesFNIQjjI2
	JzQBmSMZEinHIozx9NddAHHJ+Qh3ynAORCTctaH4WLmCPtknc8p199FZ
X-Gm-Gg: ATEYQzzL49Jzv94vDrx3WkQDTH0Q4XARZm8Kl5xoXGo3i9cLb7CmUPud4AahB2xRirr
	+E8sKSPJs579r9n6ZFCW5T/qNnXcubQsmTLdnqqwCkfh6F5f5J8ZZhBnhCRaTPogYxQs4fQ3CNk
	vFF9/bsO4S1pIhhqzIGk7awrmhfMWQe1oHqhAexxlvghidecl/g7Vtg1uxWrJF6s2dtuIpRjQVa
	lRmyc4Cup8gIjXB/8Fvp4yxtFXM6zfDZpyLWRM74NYS93PdDXEXJNEkb4rfexNKRdR/yijQdUWy
	W/X00xJ1V9PuGI204vwkN3+fO92IXN5ccR4KWbqfMdM0yURFjXYgKHYgAQMVhQj38btPpdzUEyA
	PgIJhqZG7nQ1XrzMqSCo9SkRN8aaKZYkVT95WPcTPwVXyQm1QugHhxcMPo+FN2opJDuSNiUHQ91
	NbZy9NPodhu5yery8i5ePkiyJAMQG4+WDZDwXLxLCiExuEJtHxWO71PRdJVSazCdxjW+o8oFLCt
	FNjMTWMe9zV25Us4rJsk1Apj1zSO8FM9y8ntYwtf83Ga1HSEZ6zpSRIHGcveoAwFQ==
X-Received: by 2002:a05:600c:3509:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483c9b971aemr67784975e9.3.1772230263904;
        Fri, 27 Feb 2026 14:11:03 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750607sm242858065e9.10.2026.02.27.14.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:11:03 -0800 (PST)
Message-ID: <2ceeb542-986a-404e-ad0f-62e0a938ce7c@gmail.com>
Date: Fri, 27 Feb 2026 23:11:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 8/8] net: phy: improve mdiobus_stats_acct
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD3A91BE9BD
X-Rspamd-Action: no action

- Remove duplicated preempt disable. Disabling preemption has been added
  to functions like u64_stats_update_begin() in the meantime.
- Simplify branch structure

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 48c0447e6a8..b32a369cd25 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -358,22 +358,17 @@ EXPORT_SYMBOL(of_mdio_find_bus);
 
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
-	preempt_disable();
 	u64_stats_update_begin(&stats->syncp);
 
 	u64_stats_inc(&stats->transfers);
-	if (ret < 0) {
+	if (ret < 0)
 		u64_stats_inc(&stats->errors);
-		goto out;
-	}
-
-	if (op)
+	else if (op)
 		u64_stats_inc(&stats->reads);
 	else
 		u64_stats_inc(&stats->writes);
-out:
+
 	u64_stats_update_end(&stats->syncp);
-	preempt_enable();
 }
 
 /**
-- 
2.53.0



