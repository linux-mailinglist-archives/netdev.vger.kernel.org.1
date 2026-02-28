Return-Path: <netdev+bounces-262193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKCGAXJOo2nw/QQAu9opvQ
	(envelope-from <netdev+bounces-262193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:22:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B71C846B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE4AF32943F8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9F38D005;
	Sat, 28 Feb 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faYghuKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98C38CFFD
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302122; cv=none; b=hUvJNvyogjo0p9aydi+zNq9SZF9l/lZJrTBTaLxceiR8X6SJuqCCcYt1J/rMlyz82i+HXiuB93RV5dOeeNDW1fFhGabFlYm6I/0g+XWkzc4OG4scJqtboCbUhVVJl0cK3DA/iB2F4ygWqfC77rgV0g+wtiX9sY9vHuPzSonAphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302122; c=relaxed/simple;
	bh=DsCvTnRonbBjO2JlO28mIxQ6YAbIlpWMICrRxDHCp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcvDdCnDbTrGWVtYJif44ICNe3g54/HOADKHlgV7rd296H0039CsbSiGl/vSS+5VuhX902OFt8Dil5fZJJNqZVLjsHtRKeTHQqR3ovweeKqFIwqHyAWN/Pp7hwdKyNNdxQKxtMcKN+0JFuY2sBOYrkhad2RxyG9WsRbYOIAX6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faYghuKc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8274936d2c0so2785730b3a.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772302121; x=1772906921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=faYghuKc7vXtr9QTHxALZNCNgHYhyRPzQWVmnW2aF0ZblwAjibf0agY2ZqdkqaOkIV
         3VoDNDWdHg/40Pu7Avd0o+fGsCRQw8h6gDG4i4BU7V+ARI7l/1Vj1Y8CY38hYi4Tnp3e
         HLlQQwKWSieGVyLW16dGVdjWjkjR5rCkveP1JqKKIRf7kMnU1dYAAOTfHCYkswLmvOeC
         JAub9MbSmXl0laI7sGQ3xSv/Owzte4Z7gMTs7IL4ipG6wTQ4APw8AisYAGX+8FvC+AhI
         vBJi7VBwD3WBUTtEgWeVCAF/YU/wCAHEj1+Qh48wzq/FWlpaY4AjKZY462SFZWVzyHV5
         dDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772302121; x=1772906921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=Bt1RLcqqLP4V14WJJEyvZDEeKPd1rkqzu+fzniN6npKdNR2MFM0K8QyXvdWwrX/6vL
         GU+t7PrJH/mpOEmxq6JL83EW7C+GYc5ylxcpiINsHx2fRWJp/Bhzq+F/2PF7eeqkbFaG
         xn/GMpmqbO+UW1eMVly4VYdGLD4nMj7yssONR4ECv1qEywxW09lQbLFtqAWiRnMBQRN7
         MA/s+QvInJutRDXTBI94Z7uzlSUkPkZ90QeWHid1IgVE4FhYyaXWX73wLugXXzwQWENh
         LvyTPxXalA11UOmdRU3gJVrIwI9MSirLNugIthUE6EFwZ0UjP2mU9y4X/JlA5IYV2ENY
         e79Q==
X-Gm-Message-State: AOJu0YyHtAHT6JKrSl8HJpMLnloEZ1nNMA131yhnLOZ6hlDC7Ue45rA3
	Xlnxkd16L9AGr8/kwYw0iZwe5aAF0pabCNLndyKHSNmz+JGCDswIpSbH
X-Gm-Gg: ATEYQzypRR5RTDycJVcnQMmHcAGYzh2UvuI2NL0JiSYb2Bl5d6wfUHAoB1gI5xXUqpk
	qx2BtEod5aXYwjkWLg4RKV4iRI9QjCS1SopQCE36ISLOS6N5NaoSDt8yu8mPO+QY7UAYn6NvZYB
	3pB7+wSW24LAhVTJxhpV3swn0dY2KMMp5rsZv2WVhvb1+syI6nwJRoP6yAmwHNqqiR16CHkSUZ3
	RlloAvgLELf/dWpcjMnOqb2BJ1Uunbwuar7TF7AtzmEXiBoIaa8+ZiOqtdtaLMf/qvB99h192E5
	FTLomUnOihqA5QW7+v7OTxZ/MDn+zBysmmV8pecYobxcMd6TB9it9Lnx1CVMYVtdmT4caPV0Lua
	Gqms9ahcjv7uj4bVJq16YJIRVVuIWbyp0faYQiCmfi1Wgcdhd49LuHHLNnUwEG6d+3S7T2BAPax
	U5EGf5i/wAqGPvtAzmnqC7ps+N0U6fzRxokAn135we/M5GuwfJNYVodv4gvALMsV7p/IqE
X-Received: by 2002:a05:6a00:114f:b0:827:17b7:58cf with SMTP id d2e1a72fcca58-8274d93d1bfmr6875788b3a.23.1772302121139;
        Sat, 28 Feb 2026 10:08:41 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm8065154b3a.36.2026.02.28.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:08:40 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v5 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Sun,  1 Mar 2026 02:08:21 +0800
Message-Id: <20260228180821.811683-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228180821.811683-1-seanwascoding@gmail.com>
References: <20260228180821.811683-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262193-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 740B71C846B
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..79ca19097b2d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,10 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
+			for (i = 0; i < QUEUE_STATS_LEN; i++) {
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 			}
 		}
 		break;
-- 
2.34.1


