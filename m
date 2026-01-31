Return-Path: <netdev+bounces-255477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABsADw+fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:39:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A473C355A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 133BB3007AE7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67135B623;
	Sat, 31 Jan 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrkUAplb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE3125A9
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881141; cv=none; b=lgc/4sEsNKqCZDWye121XIpVJKIhX2tpHl5iVMZk4qrhXhPb6iResYUVJ5euGA03TOV3dyYAWF9OQNJQKsgOJnZPYqnxaVLVfJ+6dJwEtkgXPFySbHg3LainsrwRxL3Me1CLJQMrmbDpO7+xPGVcWwkJF20Q8/ZM3yyRDSPlSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881141; c=relaxed/simple;
	bh=wEAzBbDX9J50XPKdtzYZVC6MUkgM4jM3Jryol1qn4Qw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YcL7YGCGCLokCRYSzQ6SaNTw9iGgIFgG83jnFGOOcKoiILK28Rffk7Qd0D7JDELY2rrabS9RTsYnGAQVXlcBl/bNyidsn0/l6eSD4sErziqNR+BANDCgQ65n7ly4RB2sYvi6MAjxTwJ8+9vnp1sOtUslVGtsAyX8aQO9vyf1UsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrkUAplb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso28025055e9.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769881138; x=1770485938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XhA5sOYyJbdjrg3dYheIh1Yn8u/FqIdGaum/hwO7z7o=;
        b=mrkUAplbMkuEvi+OKFLkmC4LPd/ugFZPcnSvR+fpe+E66gqSoz/mZHDiHIA4NdPJUt
         v5nEMf5NkAYd66ggUaw/Y2rE+DyirAaWIvCX9SN+ZjeiBDlDzGtD4blqSZ2RINVv38ys
         B+bkRiNGdObGRxZuCTEXFP7TyQbXTaXfZIz2LWv8NVoY7mgvrtNRlDJLn2RYYyZ4iv5O
         /Hk8pEAKE41ZA1WZMxDm6HXgmsv4MoA+DPB/fjmEpxBPRAaZCeQH5QU3HP7cDiXVu21y
         uC3S81QJzbsMrB1xmndjDZGcIPw7Nv0ZBo9Kx+zjTKPt/FZJW2Ww5sCRZ/1lE5YfluAu
         Nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881138; x=1770485938;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhA5sOYyJbdjrg3dYheIh1Yn8u/FqIdGaum/hwO7z7o=;
        b=dWP/LVGFmThVmH7cH4mL0Fpm6voWkO8SAg4N1ev6pNaOzRKzoVr0O9CUoNJM1Cz7Hm
         5EwicsNNkkJ9v8TA26LN0mgahS03zKsCKCUPYHNF1vRPQ+pkHuF1lLPuPE/BSWnky5MZ
         dssp+zXRcQaslvhDH0uP2g2HT9kymCn7LdY5Cw26///A9q+1BgOIrBGsoVDnfVVsrz2I
         svLu0b9WCpnDAhrKKAPy0QBgnkrTGLYXQ0P+g/7tzxxe1rSXsaWMfklkmZ1KsKX4LF2w
         WHyt8FiNosyybtL6ZiuTrqHYbEhdqQMEMUOF1ff3OoZLtvLKB5/wN01j6n7y0FQZo2qX
         MOfw==
X-Gm-Message-State: AOJu0YxZEZ+vkNaPvCHW3ny+7sHn1rT8Helkl8k2tP32aTJRCUUvinnx
	D52EOjn4XPHdPakzTPbgmISZLdA8MSk+GcEdrkrqgMk755jwV/PIal0w
X-Gm-Gg: AZuq6aJtHw+UbyTaUOSaujxbc6ToNb8MZl211Kovb65VCZXg39b9Ze/VZadAosNfByd
	G9CIkvWDfqMVCqoQd1iKJAvU5SGVFxYoL0hGKEbI/Pk4Q7lro3wdub8RQN5mDuJqzAqwrEDjXgq
	N/PNHAX8uG6C1Og8Hg3aO7OS2+S3LFPGCThwCRbPIYsCUUTTggg5UJQwTckP0ouKuS/qKwjtP1H
	CkAeuGrnNCYWN6AoW4xxq8wPu05EPsWGjCuZ5wCJaUgWn4MmubcELVATc1a/CD6OTibThf9ub2p
	b9u863u0LOBS9BDxmdVHfbBj/wMSm13hwJIwUuaRHWYC2QMtkYnTFru+6PO5XmwSaIfETbAbuve
	NEhbm2dVDr+wfuv4OpKhjVjtodfrV9xoz64eEn/ZpMzXTU6NZ8/viN0CoSeXLjHolYhO7IL7gzN
	RA8fOH03/RsgPI0A29tyfXyzea3xyJm9zDj8BNUSWwwknqFPjMQmypYz5IH0lc35tDZVSNObCTB
	Ch+GRI4K93iBlHFAKnjtliFt22smVN/JVECXACfTGQa7BUI
X-Received: by 2002:a05:600c:8115:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-482db44886fmr84004865e9.7.1769881138262;
        Sat, 31 Jan 2026 09:38:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:41be:d7:a063:4025? (p200300ea8f06cc0041be00d7a0634025.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:41be:d7:a063:4025])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267aad1sm43036665e9.15.2026.01.31.09.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 09:38:57 -0800 (PST)
Message-ID: <15a4318f-50b5-4df5-874e-e387ee070a9d@gmail.com>
Date: Sat, 31 Jan 2026 18:38:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] net: dsa: loop: remove MDIO device modalias
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
Content-Language: en-US
In-Reply-To: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,armlinux.org.uk,redhat.com,google.com,kernel.org,davemloft.net,analog.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A473C355A
X-Rspamd-Action: no action

This change is a prerequisite for removing the MDIO device modalias,
as dsa_loop is the only user. Switch from modalias to a custom
bus match function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 4a416f2717b..b41254b3ac4 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -395,6 +395,12 @@ static struct mdio_driver dsa_loop_drv = {
 	.shutdown = dsa_loop_drv_shutdown,
 };
 
+static int dsa_loop_bus_match(struct device *dev,
+			      const struct device_driver *drv)
+{
+	return drv == &dsa_loop_drv.mdiodrv.driver;
+}
+
 static void dsa_loop_phydevs_unregister(void)
 {
 	for (int i = 0; i < NUM_FIXED_PHYS; i++) {
@@ -428,7 +434,7 @@ static int __init dsa_loop_create_switch_mdiodev(void)
 	if (IS_ERR(switch_mdiodev))
 		goto out;
 
-	strscpy(switch_mdiodev->modalias, "dsa-loop");
+	switch_mdiodev->bus_match = dsa_loop_bus_match;
 	switch_mdiodev->dev.platform_data = &dsa_loop_pdata;
 
 	ret = mdio_device_register(switch_mdiodev);
-- 
2.52.0



