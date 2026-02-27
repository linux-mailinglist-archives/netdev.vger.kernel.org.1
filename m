Return-Path: <netdev+bounces-261986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNE9NnAWomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:10:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD61BE8C5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE33B302AE2D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50236D50B;
	Fri, 27 Feb 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6XyUwlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C723624A3
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229993; cv=none; b=ojuStj6xKX2usYCd5/fxdsJ4iQ15dlt3+0gsMiUAixgC0FinChqJjkBaoUg1WSVHVtTdtyD3IiknM3xDdgydvq13jRIMS/wIvdAKZWfLJwSxExKDLrwNBG+gLyDL7mFgru82RM5K831qmy/TNb/EHFINKJVias5wOc3K1YYeIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229993; c=relaxed/simple;
	bh=mh9KzPimPJOI7uyDPYkQiUgVuJU3O577xxNQcaYGJfs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zu2CuikgQqByHUDPPCWl1/d7t3a8NABRuCSVn1xRR0vSccN/ysv5k4e9I6Ot4q7NNXgZA7FBvwNDevmyqWH9JJ1/Jeaxu7T/jSwfnYxnqrjAVRItDGxtBlT9FeKf7VLv5D37ndm6AvCXdkxnhFXZVUz8wQfuWkvRfzxc5uHTGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6XyUwlo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-436e87589e8so2473522f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772229990; x=1772834790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwqkUnfAdiWNUcrCcyLTrzzpCA4UkVml52+MHZMEQOA=;
        b=g6XyUwlo4IWQ0Xzg35O8cl4iVbGN7dvXXAvkWb9G5iJY2GysoirBZRB6rBrCrQe075
         fUJ2n/HHS7gRx75fpTFQfvUfOKLVJxJ8xYQI1uV1iXfbgwWpOh4+NcD/XkyYdNvOnQ1n
         FB3baU+l4L7hvYXLe0mlClwdXI9O6ThGT5JMnaF6B5GIPZVz5fH/+W0V8hCgJdV8LoRX
         +vBYXIs4ls4bjB690w75R00uFwD9/bmNYecaYQHMH0iaFrEWffNdiku86D5GBmhgQySE
         OoaNAxsrzU0PSTjUccek7RbtRNx4CB96G4DqdrIPtcNinwawrcczfGj3ppTdTssJDMmY
         prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772229990; x=1772834790;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwqkUnfAdiWNUcrCcyLTrzzpCA4UkVml52+MHZMEQOA=;
        b=VJ1hoeqjOySCHsewxynPSk9eQjGmk1RdUfLCX/Ywlg3KcNahKJTjwv0lALwxR+T+t/
         8m5hdqVXreFWQd/2+V23iEFMeh2k6eAN3rq+letspfW2ybGngkJz5s/I1iB0czZ4/0VX
         faQrnDgQqOLytRGW2ZPYGvkS2z2O26a+6dNP/DF0HPp0O99w/FWs3IZzdthmCvGftf9y
         kZctWzdhIfCzq9zfxd0c3IikgnyG5GAqVLq5nSvUtx8mcY47mvgn83BHUunerxmHuK2W
         nEZGW5A2AC+P4IiHcyy35KHFN+mBCojbXYBE/671THlzq944V7mURGKl2vWAihYWjFYs
         +naA==
X-Gm-Message-State: AOJu0Yx9j/KSMkrzGUOT5+rEYjCgqVsRr5utqb2WmpCs2d04uOENSk0f
	JUMyugnf+IPfXNg+z18ZecM82QRUdZQDOXQbl3CaqTVlIZqgd8byq0Y7
X-Gm-Gg: ATEYQzy04RGCWqJHcfZNMBvx5xSMTQqyVdGEF3fDB7YA/Baj5qloXg7mu2NJakjWCyP
	hQ/sUpFXovQPoOowwIR+XgS8WexD7umkFgGUwowWTBA5gudvbaj6+1GGd/y7b6cPfg/OkMec4dk
	O0nO3RfHObF4KPBChTnnkbPogtcStFIZKZAW+UtxdWiSZXHUyZmUp3BX+8E8GZHqBzad5xtelvv
	QcRvu7gpXdS+0gPHXANbSWVEKWV7is8BC/l+WWnjRbpJFGQOvCD57DOzwR+YADxBoBfcR3L8/u2
	w0KTXT878hCZsNDFkLKRVLoOzPM26Oj2Iny4diBkRX7idEGLOrtxhePEUjb8ZXKkdQCMkeHP86Y
	2pwAH2HJSaynotwZZsS5jLay1KpfP0nYondrPAbXuJtc2zJdVubwCdqB9g48Cd5Q/cyKn7ZFNsI
	T5GNE6vlstKJl0/ZyTtetOz16a2vYucvUBabHkiLAzZTG5j9coc6MWDh+gB+gOuDm3z3+fBYrj8
	aYYab+oH2rLCtQua8//MlCR2f+U5G5QgUWzNFoHsLhEoVfbMHc6up9MNkwxArRwBA==
X-Received: by 2002:a05:6000:40c7:b0:436:307c:b755 with SMTP id ffacd0b85a97d-4399de2b547mr7334749f8f.40.1772229990237;
        Fri, 27 Feb 2026 14:06:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ff6esm15158036f8f.12.2026.02.27.14.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:06:29 -0800 (PST)
Message-ID: <4877a4dc-247c-4453-b281-20a8d969b15b@gmail.com>
Date: Fri, 27 Feb 2026 23:06:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/8] net: mdio: use macro __ATTR to simplify the code
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261986-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ACD61BE8C5
X-Rspamd-Action: no action

Use macro __ATTR to simplify the code. Note that __ATTR can't be used
in MDIO_BUS_STATS_ADDR_ATTR_DECL because the included stringification
would conflict with how argument file is passed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 4fe9859369b..0c0cf7a7296 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -191,24 +191,17 @@ static ssize_t mdio_bus_device_stat_field_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
-#define MDIO_BUS_STATS_ATTR_DECL(field, file)				\
+#define MDIO_BUS_STATS_ATTR(field)					\
 static struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {		\
-	.attr = { .attr = { .name = file, .mode = 0444 },		\
-		     .show = mdio_bus_stat_field_show,			\
-	},								\
+	.attr = __ATTR(field, 0444, mdio_bus_stat_field_show, NULL),	\
 	.address = -1,							\
 	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 };									\
 static struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = {	\
-	.attr = { .attr = { .name = file, .mode = 0444 },		\
-		     .show = mdio_bus_device_stat_field_show,		\
-	},								\
+	.attr = __ATTR(field, 0444, mdio_bus_device_stat_field_show, NULL), \
 	.address = -1,							\
 	.field_offset = offsetof(struct mdio_bus_stats, field),		\
-};
-
-#define MDIO_BUS_STATS_ATTR(field)					\
-	MDIO_BUS_STATS_ATTR_DECL(field, __stringify(field))
+}
 
 MDIO_BUS_STATS_ATTR(transfers);
 MDIO_BUS_STATS_ATTR(errors);
-- 
2.53.0



