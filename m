Return-Path: <netdev+bounces-255478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGSCNok+fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:40:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14110C35DA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16CC73008459
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D835B638;
	Sat, 31 Jan 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWaujYXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6435B627
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881205; cv=none; b=IFvNrWcG7ZD9LOf6z7MOrO48d8PsFNqqLNsgybrz+SZhGMLnVPS/SrlTLcSDs0hx2+GlYdm5Cw6Q51S5dQ75whjEzBrQpp4lXadnBRIuPGxGBxEF1MdHpDXCBds03qC+ZyOoLu2OqHuOwJR56srwXDf8z2/SYqv0tCm/TqIxB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881205; c=relaxed/simple;
	bh=XTqCrafwy0FQoJigWHKUzbxCsrGtBH6jZaO1ghXS5RA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mp5pEy3+iE4GbgZhg+4MgLOx0IZ2vDNWKZCT1nNL4OzTnhwGrFzIOHXdNeiLZFsfAEMF0s+pHpulpg6kH3SEUTknPFWGg3pJgwDTzupzoxVwsCkyoRlczMxYBdKVAiT9SgnI+or71i9zO8PDpRrIy8jZHZzaqqMte555n1m2nOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWaujYXd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43601e96f72so96900f8f.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769881202; x=1770486002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QgmwdRM4QcAa92E/3yOVnX+erOsKbGYtR2XQGPwyhkI=;
        b=jWaujYXdEAJgY9wbKV0+mpLy5YbimlvPDnFD/FneMtNuaJNtBgB1pAOK7b6N7T/YWs
         Jjyj3CYOIuHRWTl6rpFzQMdP/ptiQBu7oiyw8eowiT6ZyFgmwIYq+GS1wrUV63D+rCXp
         Ia+rV41olrYl820mrwfz8S1AmtOJZJjtCKhUZZDRR8Qpvxy+b1ONF/aIRw9BYQZL/gIl
         KzgE0Qdu4ofqNZBJf7pU7A7rJ/XnBH7N7HjymFn3kDV/a6kWnBLKc77aC0N/GjRcumrO
         w1lmG9q5ZcncAX3oQXwElQ5xHb8nbkRelJ5MDMPG6cJXzOrGf6cSCimGRkMudpURTCpd
         kEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881202; x=1770486002;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgmwdRM4QcAa92E/3yOVnX+erOsKbGYtR2XQGPwyhkI=;
        b=UIr2ARd4mUpr+GfKLP26tzaw0K0xXTunNz3BoDN2nsFLbC+9+h8PP0xG4FxmvA5T6v
         WYuXc4s/SQVaWiTpjP3IwHEDD6ok/Q+LCi42STi2wZOrq6BfgeGyhkFsTMrroH+gMrlr
         Gpzu/o2uie8HH9yC0+0OuDOe6gkos56E1/a+vnNOsMhAlIXgwqAtcthgw577DoGtio9j
         nLrMaVpGqf0eAoJxHeAT9lAxp6aOTLNgL3wjJiS8xxFt92np4znSxC9GH4QJEADX5O3b
         yBwrsizfj1sJdMaVJQLhhkasU0T6PO2CGkIuWObczNMsi7vZCEaqAOOlKcwVtLOfAXEs
         2HSw==
X-Gm-Message-State: AOJu0Yxxq0ukJGEuZ9YkesjgnQlGmCAc70B+twQeT5j65/OY1foSPSUg
	bMrk6/qBhD8dQjhd99DALj3dw8cozFKHI8Rv/y8hptJ/M61MYc/Z1Tq2
X-Gm-Gg: AZuq6aK7Xq9nUhC1uTcjfiDbXGpx/rk+TQ+DZVdxyPNjI6bIf3cgO6LJgvOozHy2O7T
	OwwObWDcAz7ndodGleLlH+jsAFgxolGfdaLowzE5VN+M9KkWUZeBDb3lgop2ZqsG9Tjpezxwikd
	BK/BGNlX3sscmJ9TURCRvaTTJonheyG+x3DP2V8/HEUeOfZ93Az1Z/OXCgDPqAw2WbxDzNh0zAP
	W3ncB4SZx6QqoRd+vlUSCggEKxUQKheykDaHXnM+RhagqeUNMV74lvlCdqEeg+mpp/IE7idFTG/
	BlsVqewdXSuKkKmLAAiWueLG80I2oPQ3RxHNk4HJ7LH3tjXoijJDALQYrnZ+/hCvyzcz8N58Sx2
	3pe+wmwiMaOLdJ6QVCnHrMbNj4damR25Y3oxj4Xknd7eUlpx1wwTopDSzXnfn1+lbYiExwuF5xr
	KbVmbOeRtMvn/5YLEPtrFCgMsIum80t60BFD5HF4T//KdSbdGTv1DsN8QrjNhNH6Uay7UIQNAJV
	dv+khOaW504lPnA58pjATHuYFYjQeVePhV5Ough8J3R9SCt
X-Received: by 2002:a5d:5848:0:b0:435:bdc0:48e9 with SMTP id ffacd0b85a97d-435f3ab4bdcmr9017745f8f.55.1769881201853;
        Sat, 31 Jan 2026 09:40:01 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:41be:d7:a063:4025? (p200300ea8f06cc0041be00d7a0634025.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:41be:d7:a063:4025])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm30276962f8f.34.2026.01.31.09.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 09:40:01 -0800 (PST)
Message-ID: <ce1c6df0-4785-4b28-8322-32dc6bceea18@gmail.com>
Date: Sat, 31 Jan 2026 18:40:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: remove modalias-based mdio bus
 matching
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
	TAGGED_FROM(0.00)[bounces-255478-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 14110C35DA
X-Rspamd-Action: no action

Last user dsa_loop has been migrated away from modalias-based matching,
so we can remove this feature now. It was the only user of MDIO_NAME_SIZE,
so remove also this constant.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_device.c   | 13 -------------
 include/linux/mdio.h            |  1 -
 include/linux/mod_devicetable.h |  1 -
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 6e90ed42cd9..65636070a22 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -36,18 +36,6 @@ static void mdio_device_release(struct device *dev)
 	kfree(to_mdio_device(dev));
 }
 
-static int mdio_device_bus_match(struct device *dev,
-				 const struct device_driver *drv)
-{
-	struct mdio_device *mdiodev = to_mdio_device(dev);
-	const struct mdio_driver *mdiodrv = to_mdio_driver(drv);
-
-	if (mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY)
-		return 0;
-
-	return strcmp(mdiodev->modalias, drv->name) == 0;
-}
-
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
@@ -60,7 +48,6 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->dev.release = mdio_device_release;
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
-	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->device_free = mdio_device_free;
 	mdiodev->device_remove = mdio_device_remove;
 	mdiodev->bus = bus;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 42d6d47e445..7ad7ce48f53 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -29,7 +29,6 @@ struct mdio_device {
 	struct device dev;
 
 	struct mii_bus *bus;
-	char modalias[MDIO_NAME_SIZE];
 
 	int (*bus_match)(struct device *dev, const struct device_driver *drv);
 	void (*device_free)(struct mdio_device *mdiodev);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 24eb5a88a5c..5b1725fe970 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -609,7 +609,6 @@ struct platform_device_id {
 	kernel_ulong_t driver_data;
 };
 
-#define MDIO_NAME_SIZE		32
 #define MDIO_MODULE_PREFIX	"mdio:"
 
 #define MDIO_ID_FMT "%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u"
-- 
2.52.0



