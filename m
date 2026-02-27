Return-Path: <netdev+bounces-261992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJRMOT0WommizAQAu9opvQ
	(envelope-from <netdev+bounces-261992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:10:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259211BE89F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EEB5302804B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B7478E4B;
	Fri, 27 Feb 2026 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH7EGA+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECA4779B4
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230182; cv=none; b=gg6dqpr3dlFTW8oHZ8fpbCFY6X8K+3h8wzwLN0z/L6LoOEdf2ppMVQhal+ZFqE/HUCNQ9OYpX9oFu9iB/K1+K4gogC+++De9bODkzjRMR/48a2iGh89Ck7Z2ZLdvpOMshGmSod66l6NKbo/YtHxMFy2X4n7jVyvhgAL1XI/tnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230182; c=relaxed/simple;
	bh=cCaHPAXiI++VgIB4NfGFJ5fMPZWKm5ttzoTFYGUA2RU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oBafUJD1INqXw7hbVxrilsCRJjLjl4FWftkWB0rCECAQJlkOdyWtDMFcIMDQpWwZ9HcqO5E1at4rCA1efPf82WGE8QuEQcgeF4iNGXFJZNElmJHoLoHSr1nxYDa/DtSxrOeEKwQ2N7g/5TDPuhKlX/QqEVayHORGE4h4/pZhVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH7EGA+K; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f10628so16789035e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230179; x=1772834979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LHr9tGXku772O0pMPxisKVgoUX/usY1Co2V1g0hw2Co=;
        b=EH7EGA+KqFtMFvwaTGIUg1QjMRTlxmQnrGAUfteOK+zJbfaTf47k+KvCiKkg/Prkol
         +09AqicKloTJlXbcblIXiRA9ntWF/72M0q1aIynNNZbT+1glyEuFT5io0toO0WHoOnD+
         xuqh06vdtpAQYtA6ExuHkGmSOtfMnHy9AgoVbi6XS32lqiSAKcJ0NQi9JYkC0LMmw5J3
         EQK4zLvP8PTHbLkjCloyUvFq6i+TPrc93gZC47Zger+n/JgRvgXlD5q1RPGmt7CYCRnE
         zIU0izzB+WSR599VsOxhbxFKobAETR0CfUiE9AvdG8UmioBVt1BXfx9/qHcqaX1Xr6SK
         8Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230179; x=1772834979;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHr9tGXku772O0pMPxisKVgoUX/usY1Co2V1g0hw2Co=;
        b=uwymaWLruCn8cfCA3Zq4SmAMMdAJcqsofmhcfrblWBWQCW0igIV/0Wgt8OD7rR+tOJ
         QvYQzjflIKqOtIqHtEWV7c0QyT26KOFrLsMGHQE02fW5/s8GizSpuY96NKX7Oef21aDx
         fIR+IL87iq+pMy6nCvVzaI9MPb5KLxum0rvjwEMrYRqvv5/UsaklLFtj/Jn58+9IQKU2
         C1AZHtGrpQAaUvpugNmPty3GfxLh4HD79AFFTPb6+HbQz4yCt00G2ml48Ljpmtg0ZGZy
         gQPfWOOJZBpGRJrsK4jSgjGRnDFuVPB4CzCqXdhYzbrP51OOvja4hnMQ/EAPpKwvkD8k
         IaAA==
X-Gm-Message-State: AOJu0YxS2A4Q79vARA2FaeGAXx8tGaaSOnkLcjUisV58eodJs92SAOEd
	qORuFZ1vLaWxXbPY5EMnICwcaWfNuEWDwreqTRXaHlQUP+AUxQnidjWI
X-Gm-Gg: ATEYQzzWz2HiyhYesHPRNUC19/ea5nO/R/1W98k8zFxl+fCN6OG60eTzTyWcUEQMnAs
	vMiCcBK+nVmhEa+Bl53JRYn5YUkKvAKWLA9q6ofjpmwsWb1u4CF1luqdtYdmzzDOjgeJM2skIhj
	fBt3aJSkYWQ1p8biClLhMAEmKOLgusZt7kkHlLy3Ej3PQVToNGKP0MdUnYTyhH56bhyccaCWkl2
	xXiMJySHIHs6i0p19C0o3V7QEmvbfPVqgp6arEXh16dfEXrNFMpl03w6z4SqlpxOqrij3LkMF/s
	TaX0xSLSNfWNR+PR2+e2vexgjg7afCnfWaK4yBRpfqZFTYAFVXjeW3erzcuOrpW4WkVdKyBTci8
	ylaa7FBAMdtV4wd2+DRMAykhMGzG3CikOlU5a3B2cN1Wi+aZt15e+gKoubkhxOmur5mnDvNLKPL
	KBqWvVagRp64dkvSCgIFi3B42p6Uem4bo85jNTFoyHGV3yHepK0+qwK7s9Ip/rSy7zQvZSienYm
	Zc9TccbUxvdJODILBenEBKAzjReaRHTTSZcAOH1u6GPMuWk+D+kGAC6hSDZWbkEpw==
X-Received: by 2002:a05:600c:83c8:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-483c9bde71amr76114845e9.19.1772230179116;
        Fri, 27 Feb 2026 14:09:39 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm267875865e9.9.2026.02.27.14.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:09:38 -0800 (PST)
Message-ID: <260fb184-c662-415c-b288-e1423097f2b9@gmail.com>
Date: Fri, 27 Feb 2026 23:09:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 6/8] net: mdio: use macro __ATTRIBUTE_GROUPS
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261992-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 259211BE89F
X-Rspamd-Action: no action

Use macro __ATTRIBUTE_GROUPS() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 750b9165086..0e2820ab8cb 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -310,16 +310,12 @@ static const struct attribute_group mdio_bus_statistics_group = {
 	.name		= "statistics",
 	.attrs_const	= mdio_bus_statistics_attrs,
 };
-
-static const struct attribute_group *mdio_bus_groups[] = {
-	&mdio_bus_statistics_group,
-	NULL,
-};
+__ATTRIBUTE_GROUPS(mdio_bus_statistics);
 
 const struct class mdio_bus_class = {
 	.name		= "mdio_bus",
 	.dev_release	= mdiobus_release,
-	.dev_groups	= mdio_bus_groups,
+	.dev_groups	= mdio_bus_statistics_groups,
 };
 EXPORT_SYMBOL_GPL(mdio_bus_class);
 
@@ -986,15 +982,11 @@ static const struct attribute_group mdio_bus_device_statistics_group = {
 	.name		= "statistics",
 	.attrs_const	= mdio_bus_device_statistics_attrs,
 };
-
-static const struct attribute_group *mdio_bus_dev_groups[] = {
-	&mdio_bus_device_statistics_group,
-	NULL,
-};
+__ATTRIBUTE_GROUPS(mdio_bus_device_statistics);
 
 const struct bus_type mdio_bus_type = {
 	.name		= "mdio_bus",
-	.dev_groups	= mdio_bus_dev_groups,
+	.dev_groups	= mdio_bus_device_statistics_groups,
 	.match		= mdio_bus_match,
 	.uevent		= mdio_uevent,
 };
-- 
2.53.0



