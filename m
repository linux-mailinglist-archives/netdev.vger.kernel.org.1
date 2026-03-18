Return-Path: <netdev+bounces-268876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KD9GOYkumk3SAIAu9opvQ
	(envelope-from <netdev+bounces-268876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:07:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA52B5A99
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55447304E30E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257A33AD8B;
	Wed, 18 Mar 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuHOwstJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A462727F3
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806798; cv=none; b=G936bySLV0Nt6wRbFFQWVE4MxL/LrOCTnpaWTFT4b2Q9k2+YSd9sKDwMBwCGP9PGgNlgyzymnEu2O3muyvmT01+tTIN3JXNYEehdUZrceGyv7fYOdGaLAiRrUbfhPu6x6T25efh6jiu6CT0HRLcCigbpTieqvoOWZ03zojXJzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806798; c=relaxed/simple;
	bh=joihviCtiWMQpL5e796M61ZFsjKH57najvYE93buzOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WX3J/3dRqh13TbiHdG9jWYk0p8vEiiiBUEH3I0M1hPGVemvt7F9THlTjmpj5mhTqYvR/MXtB1DAemGOCC8Q4oGM1Hdik4J71RNknBDBlvKjZKlDDSNtj57AAd+UFK35ZP4VRV7OVbxv7GuR58xjkVA5b+9ix6YsxHua5/1P73iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuHOwstJ; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64acd19e1dfso325956d50.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773806795; x=1774411595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B07xfl3qfoR+omC7Mfw1Ly0caUSy+DmcyoeX6C6S7OM=;
        b=cuHOwstJX38IgHdeVxQO6RzdinK0mXkQgprP1iTwL+0O6ZuCZe66tcy67l8mLf1HEN
         v4kbJucK5b8uPe6kaJVZ2UoqPMFTJ8GYSUBsifI5EuJ11rInXV4xC9MANBWyXeqrkRwd
         V7KgFP9GYyZnGL5AFd8oAjrsJ6IcS62sk+05Jjbg2dr+0on61D6/gOq6VGAquEb6cgcP
         9+n+8Z3Ht+YMf6H58sYmMBXyEMLq/qkZIT9lLCgm5Qifr5A2hclu4PZewwLjUclSYYyY
         L4kOtEdami/+oxPSrb2cIJqsV+bqUN43B3bJ/0sDzZoSGX2D1Z8mOSiiAGNz+LpI9ux8
         ZLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806795; x=1774411595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B07xfl3qfoR+omC7Mfw1Ly0caUSy+DmcyoeX6C6S7OM=;
        b=UZ52sn3AlQXCiI/FhF9plnzaLRtZpEUTlM/ldknT7DDiDbrk6LMShM9VYJFw8yhKdn
         9GF7KgCAc8lBWdlM3WIVoR0fRnHOdKlGtvjWnUaBT4a8sdAx23ZlAmzwgAo+Bhje+WnG
         hz3gLtTTpgOZM2HYcfJcCZvn1xkMBGPQrXAxcn733vk8qixdLoJjRSergmBj+LDcaVyT
         J9wLKYNu088BDorVhf1He3gV52FpFOOLxBq+0Evfr2C8W9sYllp1ku6u10LyZrn0MVPB
         OIkcoGwOrxlZWASQYfrpYA+UFihgXcb+2RWHM+fpjhKFUJ8CiAIrSeRnELa/u09vOlXF
         EuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVApIvdcglzqkAeMIfTF455Q2Jldl9qgKup6oy4SH6UnPLD6FQhdSgbz3ZoO4aO4JJOfQU73rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBqCsliRumn8rz35Yb43JowH3Xu2WyoKePfNhdNEzXqJuzKcw
	6iCyknSGwgvGyS/1dOvRdbGK+fc+QubnGLqsdv3Oz+dxI+NOrBrEx2Hd
X-Gm-Gg: ATEYQzz7p29ICq9e04gU+YUp+JQ/OJ6EG0DMWmtBPhyX+H5kIQXS/LwLYGghmWk+piN
	w2QeUUrdKoMvK0EPMWZzCo9ssmDwwsZmXkLoU50oTpZIeDp3VL2tEUMuq7IFMgX6hxuZBJEm3HQ
	3PMnJQsMtaPJr+zGpa8cdswkulypuf4oxiHkdkC++ZZLDbp0CU4jfaYEe29FT5Hff6UEw3Yd/AO
	AanZwS5QljnWMbemoQreCPtg2+fS+8U0MPC6ZYtzpuYx14oR+HU6vOAQ09Vhr3euxZOrG0nO6Hp
	K1iUQQxN3+fgjg2KmUz0CLEV5aO9v987x1JeCK/cxmFZH/uDP7ZvyPYeNVHCIhc267NcD8WWzPg
	eFNQ2J5nDRH66Mf7kukkelaASqECBiugUN8o760Fd5tfpdb/W5tWiLRXhoodBW4URLHYa+4hraB
	oyFB0h21qskoPRWHAh5Js8FwR209n0GfWAcEWKFK58vscSM1tFTJx2fmS8LMU=
X-Received: by 2002:a05:690c:f09:b0:798:56eb:f238 with SMTP id 00721157ae682-79a71ade0b4mr19471657b3.36.1773806794849;
        Tue, 17 Mar 2026 21:06:34 -0700 (PDT)
Received: from Computer.attlocal.net ([2600:1702:6f11:2d0:7876:bdab:8062:a5f9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713fe5adsm10228307b3.19.2026.03.17.21.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:06:33 -0700 (PDT)
From: Omer Zalman <omerzalman42@gmail.com>
To: oliver@neukum.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Omer Zalman <omerzalman42@gmail.com>
Subject: [PATCH 1/2] net: usb: cdc_ncm: convert sysfs show() callbacks to sysfs_emit()
Date: Tue, 17 Mar 2026 23:06:31 -0500
Message-Id: <20260318040632.69531-1-omerzalman42@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268876-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omerzalman42@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACFA52B5A99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sysfs_emit() was introduced in v5.10 as the preferred replacement for
sprintf() in sysfs show() handlers. It bounds output to PAGE_SIZE and
avoids potential buffer overruns.

Convert all show() callbacks and the NCM_PARM_ATTR macro from sprintf()
to sysfs_emit().

Signed-off-by: Omer Zalman <omerzalman42@gmail.com>
---
 drivers/net/usb/cdc_ncm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 7057c6c0cfc6..6fcb4d711a64 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -204,7 +204,7 @@ static ssize_t min_tx_pkt_show(struct device *d,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
-	return sprintf(buf, "%u\n", ctx->min_tx_pkt);
+	return sysfs_emit(buf, "%u\n", ctx->min_tx_pkt);
 }
 
 static ssize_t rx_max_show(struct device *d,
@@ -213,7 +213,7 @@ static ssize_t rx_max_show(struct device *d,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
-	return sprintf(buf, "%u\n", ctx->rx_max);
+	return sysfs_emit(buf, "%u\n", ctx->rx_max);
 }
 
 static ssize_t tx_max_show(struct device *d,
@@ -222,7 +222,7 @@ static ssize_t tx_max_show(struct device *d,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
-	return sprintf(buf, "%u\n", ctx->tx_max);
+	return sysfs_emit(buf, "%u\n", ctx->tx_max);
 }
 
 static ssize_t tx_timer_usecs_show(struct device *d,
@@ -231,7 +231,7 @@ static ssize_t tx_timer_usecs_show(struct device *d,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
-	return sprintf(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
+	return sysfs_emit(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
 }
 
 static ssize_t min_tx_pkt_store(struct device *d,
@@ -313,7 +313,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
-	return sprintf(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
+	return sysfs_emit(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
 }
 
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
@@ -362,7 +362,7 @@ static ssize_t cdc_ncm_show_##name(struct device *d, struct device_attribute *at
 { \
 	struct usbnet *dev = netdev_priv(to_net_dev(d)); \
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0]; \
-	return sprintf(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
+	return sysfs_emit(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
 } \
 static DEVICE_ATTR(name, 0444, cdc_ncm_show_##name, NULL)
 
-- 
2.39.5 (Apple Git-154)


