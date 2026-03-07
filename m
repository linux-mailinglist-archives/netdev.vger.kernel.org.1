Return-Path: <netdev+bounces-265037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PTTASiaq2nYegEAu9opvQ
	(envelope-from <netdev+bounces-265037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:23:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CD229D85
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99A5B3004404
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A893019C3;
	Sat,  7 Mar 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqLm34mX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2E24E4A8
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853767; cv=none; b=Ikys7XYFqN5H7afefxYooK0LNK2+roM0gzN4LoWi4wJDPOV0PMzvH0y/pwfRAYwjzz7v5KHMaFPU+yUsN78ANahEQLo/Zf6uAdEK26RkuiG7sk6yKS/TPVidzzxqH5K9OY9ggANQ0neetfJP6ZY0zyzk8HZS2ARm2uCvX41Q9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853767; c=relaxed/simple;
	bh=ZyHvlwBT/YtbcP9Vmkuk7ZUS2woIMfHuib2VTN8SRTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/KfZyrKeQn9NXTbOqIiaEZXNJ+T49Bvo+i1lJOk5aVqdRkkp6fXzpd4GZ1FBzLdKOKDY9XqnRXtPT1WAOfXOtQTZKMkiaPpBjkZaDQO/2anvtcuWgYiy4miaZ2V2NaIHWvHLtqiuQB+oa8+5oPPtOuCokf8vvGLVa31ghmhzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqLm34mX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8297c035d28so1174719b3a.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 19:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772853765; x=1773458565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8NQdtceWV+OEbrLdoBXT0TqIGhQ3YN4L9sn2VN1ws8=;
        b=lqLm34mXFdbDlFZk/BFuEsLj8jw8ttenqMmE0VlAr5jHo32bgF7qD//9BPgx5vqfkN
         w8ZGk/klN9tYEDosrfELQmyhnLA0rTprIp/W+IshYoSZjd8SgHhN9a5sVOW9XB5d+gvi
         +u9cEw3KWkU8Odcd9Y+K2huWziBwRkViIuohEARbx64m5BVtf5mnXeGeX2lia/jsAc+s
         EGgq8HVh1xhKpnlJqIXZxl+mThCzr8HyGB14PmzuEbHwcl02DTdL+SSNjSDbL2dos9Lb
         pm04OgZR8GQmEijZLGiAWmcSgXyh7pMP8x3wrz6qavn1O1JEn6eGMZ+j0V9ipnEukH+J
         ZMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772853765; x=1773458565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8NQdtceWV+OEbrLdoBXT0TqIGhQ3YN4L9sn2VN1ws8=;
        b=f53Rx7Ru1T5IwVWxoGz9HoiddWXvWppOjTQj1+2KhzgQPLn0ZuLZvgQKVEMmQwk9DN
         +6t42N7/AjYXj+MXtU90TLuGJbK16EPsy3MDFqXAJikacuKKxO+DM+FcKPY4F5r1BMT9
         7On/q6ASrkQkFMR8mKG3ulG6t1UAYLpx4+KV5MXhWny1sv9MNlYML3Q1SvGjqyAruRic
         FzM++8wt6ELrhPkc1VaL12PUkBJlO9Op5WVWKfgR+WCu7HDqfkVg+KCZvbqfUoUlS36I
         n5S8pNXC/swnm3Uc0Y1Kmqc3BGRxXLwFONpDIF/weopWw0m6dcpjiGxISc8HJNB+vEnD
         SCUQ==
X-Gm-Message-State: AOJu0Yx/HtBF+IS8bMy0H8S7KqEjTix5WMfOxhAXj4MX09fCwyIlRwr8
	rSQn4s8whxbUdiedHXwzGHyEudflVIsPgiSjm2yATW2zg+8kgmaEsaPu7tyfGRXHonw=
X-Gm-Gg: ATEYQzzsaUatS9+NeyANhOsNMLtzMb4la5YPLIERJiLwJUQNdHYXfjuVzsMlxpaRFs4
	Gr9XfBK0vOsGI4CUOb3JQL299wgU2WJYDIoo12P4eYCMVDLumOb+UK8V/tg8uqJ43BZ1UP5hW1w
	fV+p6zVzdyeJXfekGu5cbQncEWlrlJjSMCv4YO2CiRMYGhu3CT+P4LytUpSI5mr+K7u/v4FmGnL
	rfvPDnomyn7Evwtc0+lJVNxoUEemlt6lGEfHHNz6ZYJBFaujOicjOh6zblFnWhk2v6A7OFnGXDv
	EehDHLR+g2sR+b2BzwS/36Jk2FBG92fif6xt3qjqSD+jdNlBZlLhaedAhHgLPv5c3XQOtb6fEK7
	rH4paGS4/tGO9df8Np4gvNmSphsr+DHFhFryHvKoE09rPzbfv7HajXqlDwmMZ9fxOn3vKmwPN0m
	y4AHRjeoko2odky6sFsnN6Xeg9FZnCL+rR8y7UimLs75467R1WP7gI57+LTlGbhNO36Q==
X-Received: by 2002:a05:6a00:928a:b0:829:9a7b:db79 with SMTP id d2e1a72fcca58-829a2f6c7camr3849209b3a.42.1772853765513;
        Fri, 06 Mar 2026 19:22:45 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a467239asm3323729b3a.26.2026.03.06.19.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:22:44 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: xgbe: use device_get_mac_addr
Date: Fri,  6 Mar 2026 19:22:27 -0800
Message-ID: <20260307032227.640904-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 206CD229D85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265037-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

device_get_mac_addr is basically device_property_read_u8_array with an
is_valid_ether_addr call. Allows just checking for ret.

Remove XGBE_MAC_ADDR_PROPERTY. device_get_mac_addr supports more
properties than just "mac-address".

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove XGBE_MAC_ADDR_PROPERTY
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 8 +++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 47d53e59ccf6..f2db920fbaec 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -252,11 +252,9 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 		dev_dbg(dev, "sir1_regs  = %p\n", pdata->sir1_regs);

 	/* Retrieve the MAC address */
-	ret = device_property_read_u8_array(dev, XGBE_MAC_ADDR_PROPERTY,
-					    pdata->mac_addr,
-					    sizeof(pdata->mac_addr));
-	if (ret || !is_valid_ether_addr(pdata->mac_addr)) {
-		dev_err(dev, "invalid %s property\n", XGBE_MAC_ADDR_PROPERTY);
+	ret = device_get_mac_address(dev, pdata->mac_addr);
+	if (ret) {
+		dev_err(dev, "invalid MAC address property\n");
 		if (!ret)
 			ret = -EINVAL;
 		goto err_io;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4333d269ee84..e57e416a1d5a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -96,7 +96,6 @@
 	min_t(unsigned int, IEEE_8021QAZ_MAX_TCS, (_cnt))

 /* Common property names */
-#define XGBE_MAC_ADDR_PROPERTY	"mac-address"
 #define XGBE_PHY_MODE_PROPERTY	"phy-mode"
 #define XGBE_DMA_IRQS_PROPERTY	"amd,per-channel-interrupt"
 #define XGBE_SPEEDSET_PROPERTY	"amd,speed-set"
--
2.53.0


