Return-Path: <netdev+bounces-247336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFECF7A46
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5CE30386AB
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A61E1DE5;
	Tue,  6 Jan 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj8fpRJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34522EACD
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693207; cv=none; b=dLqzWUnI4ejMtEjaIVYARZi38ujh2gT0YTuQEdHyAjXgxNN/G1pU8H2nr0w9D1s09HTUMuVl6wcQ8yaaF5ICVUIiKwtXQUHAXbMM+hv71/SA1qDSi42/TbRgvqK1AwhqnJk3T+ph6aOcseHXexwOQkt8Mr4bhfhxTsm3qP9PiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693207; c=relaxed/simple;
	bh=2/biZxHtWA20hs7OCdpZqfftc0W7jixWYjL4B4wwO+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3xdI7LNrM/Eh1QP5F2t3x4ugzH7fTHMAW0qILDHXjiM+cZo3W9e7iVRD2ghhBa/bsbHG6kmGjIHKNB0WS0kQGw+944lWMjhTrQHntIOqPYS2XLNbdayw5LXh6+14qWakj0sN/b6pT7jDDU+lkIbuH38xcvxVwrRDdBaoMSiC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj8fpRJ6; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78d64196795so962057b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767693205; x=1768298005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoHhlq9wqE9JcnKZUtl1pktNkPdH5R0ItLOemHxm+DI=;
        b=Fj8fpRJ6P31p/3MsG18O6qk43IG1vuIpJy+qC5Vr97UozIfUbdqLBf1OvlihLE88Uv
         JYRv0oiYmno4JmwLkKRcMupYTmD0fFwiLWqQu0XDVsfeJL1iXeKUm+upWPR13wNwicd0
         PTIo8JX44+QahzJyk8oIyh27S6ID/5ygmcy+N6upykMSzz0CF8nqLQe+6fUJ8hyUi7w0
         h59aT4C4+9bv7Ahxw1GuERCs8+tpI8gJs0obaXCx8w9ogg9R0gCBqo+LWtWqcmsLRUaa
         z8LEr3p3uPkRDHpy9M3pHJxNxpTZNHCD/L8pseD3Lf5wdGaSQVv7z5HarZw7THWstxgQ
         RIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693205; x=1768298005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoHhlq9wqE9JcnKZUtl1pktNkPdH5R0ItLOemHxm+DI=;
        b=NWJhGgQmMv8Iu5QL92iXr0F6y50BbbWOlzpAAmbc2gAmitUFVg2ewfwGbXS1ZBqiEd
         3JkiJWSAzeMEW6VaNUtZW7qupLVeYrd6UP5xGK0RAh//GR+wCUqj6DfzGf5Kx6mXvwfR
         sTj9OAI6mNMMcAx0mcRCMisJ/pptF6yxzhi6N9dSiAptOjLvfG2AyoYgfjeQuVojNoj+
         g0oM2fgS5Qx0gRSb6QX+a1hAo2OfUx6akgoc1lVwmq5WjbjihDQkC3fpoO6SfBqDDySw
         GO4E6x5x5gYS83rqkrAlaGQZM0o2AJcEmq/fBa5B5MzdUzAs18o4XvjYeOK+dQX1t9eB
         /WKQ==
X-Gm-Message-State: AOJu0YylrGuOu67EzL8wcR4/UuM4oI4sdlGNhuDTuz4NtvL6UwVdALH0
	UbWDb8/Jf9+ohO1P9csJxOnKeb+HVga+3oO5yMSggKnojLtr+dBIXB/r3Xw0Zppf
X-Gm-Gg: AY/fxX70i3NBmmGG3Wf7Um7uAPCEEAoHrg/yJ9ytIey3s1zB7YWe0tRIOTzfcw2zr0V
	gROIwFDnJSemRTdL02xSc268u8iZBjyM40pngTqDkO0MpZBLfX6HO2GdYB9hUOKEbJxg9x0MnUN
	KkSzvInKL6vjuU3APq7sK0XNM3Fr3F48LMGI9HMZCsnu4k9EfpBk6viDkVLduRV5AYMeIfiksnf
	2rqrIO+QjPbfKTGo4G4Oz+vQ7ElPETWwAld12Kgk7icOuQHX4LR8XKtGK1tb8rrHM1jchlG3SJm
	1C3BgRDaKQSg05/qtXyYhOefAQx96p/J+Ofye3GjTMlwrc5h/Jijx1+rYSPZZzx/FNiW5rxa8QR
	E0hBVRYD+Ikyj5OE1ljlU4sk/CYoOtO7megqPxY8TYVdYKmd0zy7exkQXajG2l/q722rtYsKJQ1
	1hB3BcSFAD
X-Google-Smtp-Source: AGHT+IE9BB6EdKCYgtshjDV4w5+9jkTZrsXCGlJF0lvjxXbWnnGlN8SGJw5v2v7F2p8CfFwu3b6dhQ==
X-Received: by 2002:a05:690c:385:b0:78c:2fed:b9db with SMTP id 00721157ae682-790a8afca13mr17353187b3.4.1767693205009;
        Tue, 06 Jan 2026 01:53:25 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dc249sm5722947b3.51.2026.01.06.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:53:24 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH header in seglen calculation
Date: Tue,  6 Jan 2026 10:52:41 +0100
Message-ID: <20260106095243.15105-2-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106095243.15105-1-maklimek97@gmail.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue in skb_gso_network_seglen and similar functions
where the calculated segment length includes the HBH headers of BIG TCP
jumbograms despite these headers being removed before segmentation. These
headers are added by GRO or by ip6_xmit for BIG TCP packets and are later
removed by GSO. This bug causes MTU validation of BIG TCP jumbograms to
fail.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 net/core/gso.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..deacd32f644d 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/if_vlan.h>
 #include <linux/skbuff.h>
 #include <linux/sctp.h>
 #include <net/gso.h>
@@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
  */
 static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) -
-			       skb_network_header(skb);
+	unsigned int off = skb_network_offset(skb) + sizeof(struct ipv6hdr);
+	unsigned int hdr_len = skb_network_header_len(skb);
+
+	/* Jumbogram HBH header is removed upon segmentation. */
+	if (skb_protocol(skb, true) == htons(ETH_P_IPV6) &&
+	    skb->len - off > IPV6_MAXPLEN)
+		hdr_len -= sizeof(struct hop_jumbo_hdr);
 
 	return hdr_len + skb_gso_transport_seglen(skb);
 }
@@ -194,9 +200,7 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
  */
 static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
-
-	return hdr_len + skb_gso_transport_seglen(skb);
+	return skb_mac_header_len(skb) + skb_gso_network_seglen(skb);
 }
 
 /**
-- 
2.47.3


