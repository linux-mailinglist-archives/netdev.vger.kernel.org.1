Return-Path: <netdev+bounces-252969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFHfFRHkc2mjzQAAu9opvQ
	(envelope-from <netdev+bounces-252969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:11:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901A7AD5E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9AF63005144
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78022F39DD;
	Fri, 23 Jan 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE4tgvOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804B2D5C97
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202689; cv=none; b=rfgzpvpsAsJMKcnz9cZP4bGRwUNCDwIMDem/Ky14AgWSkll5m6vLG7L7J8gCxbg1SBYFdXnkNnx9rY/cqBEpFhOYsqgQDMk6QlYEyADZSXA14IBBQ4nUnb18JlBMyjJKbQ/Fc2fJrDWCKKArawt4M12QJ8zOqJz3SmpmNWMh8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202689; c=relaxed/simple;
	bh=O+ROFQDvMpAeVQShIL3e2yyFbsJrqnL7kQ8BnLOHpDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDy1p6KFP15Xvz7ZB8MG3Ixq6cIbmJ+kvD06DDCjHfB/DmL0ZJxooXDlAL2dydXlJpwMOrl5sGzm4OowuFwdzNwzz4VW91iPDgO+pN6KLSHS+/NaYGLxRMJS3v4m2AF5UMqYvYVXpyVZt8DKySIysZuPyowPHwLeUmakGbxICRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE4tgvOj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3532aa9a77eso1230743a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202688; x=1769807488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InDutReh6fzrwpM7HlP65wtd/9C6EOjw5Npjd+TBB00=;
        b=YE4tgvOjmlfCL2NwjMc6EeuJ2kc+MIbD8DxqgEfYTnZxnQFrLTv8kGfZuAn0mVfbmi
         A42AgB1vzYB4wFBuCoWA/zVlHI1/W/0Vyey+9qz5nQcbSAUEBIRjk2fcz3gxlgtaCcss
         2dMpwr0SLGALE4TFtytQJA6JjsztmnBj1mQW59rMRTydqPT/AJpD1AXKHXRy1VLM74Xh
         JEBdjq1hkq9OBLkG7LQLr1mEt0gkR7IESpdxi8Cew5Z87aDZVyKL9cIpkyfbtEjo3Kio
         T9GTVmXNjcB2i9UYuQje9AMGFUntxHUqD9WRgll8NO38ibK/56qw+dvD4CtjymyeCJUB
         eMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202688; x=1769807488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InDutReh6fzrwpM7HlP65wtd/9C6EOjw5Npjd+TBB00=;
        b=CyZtNFzFQZFPqmvQRCFe5L/HdxbqeU9PwC9APejOWA/axtiskyoI9ujP5YqBExU4v+
         H+2kpTvVNXAjac/Do4PMqG7yXROiMuXH0dqPGBN4HlPN9m2RdItoQbz+jajABSqt/5aC
         wjwVCuK+Rw08rNux/GMGM3g8Q5U3Ng0V4BnUleaU1Tg5wRQYgnfzobbZuzDZsheX1/Y8
         nx2WJRU4pyMr5XLlSl4o//TZfuWwgcU7aLhanRTVM56gNRr5jHxLzXE6iFjdMyHSjyDr
         QthgcwhUcLwWeXaJiU5O+E7xqUjkzEV9TkBkXNJhu/45KyaZrW2InGyIpKT/mFDbwLNs
         MABA==
X-Gm-Message-State: AOJu0YzTuu1wekCDWArT6pT0w57SZ8axnPe8VOadfWZU6BZ+r4lVq9Mv
	/e5Jt85JznEaUxY8ymfmFtq+fqbsUX6xVVZXQcT1FWwBW78XVA+eZOqn61Mfqg==
X-Gm-Gg: AZuq6aKVlmD44FmWBdwZt3CZAX4CrvxxU4xWplfyA5Z30tQwzXII5F6MBI+v+8xCRzu
	nAxX4rhgJrp+JhrRfPShJSKbBBqqft/gOt8MB/durd0QBrjU/WwlkISueQi/ttYEAX7fX95ftH6
	c4V8kBxiFLr7ocreFRim3c6Xj1/DOhTI7xKVjb5SaSbYgjVYiHexLpCni76jjPZSPAYW+kqWKDg
	tVGDQKTm2rehgQ6YpCvjov+4R4WZFchQ/OWv6K5fSMzZZVcnLFRoMm+85RgKbiIfQHlc1xlvn8C
	B0bvKDsk53i2iB378QVT7xwHZjT3F6G+QQ4yI580OsEDzGidwbvAZ1Q/LBv0KDy/2mtxlkAtlzv
	ceBbjaoB/HYOSRTToeXtGTRm6RqWTkxe0c2i4OaiO9Zh85SnU4xXCL096HlzJSH/5DK+krBHy+9
	DuipzSEs7MoMHbuX+SKm+Czx7PH5g7d9Oo9MryZjbCz0JndYs7BnYIGIQcTkn8vjE2
X-Received: by 2002:a17:90b:5625:b0:340:c60b:f362 with SMTP id 98e67ed59e1d1-353670151acmr3573914a91.6.1769202687520;
        Fri, 23 Jan 2026 13:11:27 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536d88bc55sm2805205a91.4.2026.01.23.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 13:11:27 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netdevsim: use u64_stats_t with u64_stats_sync properly
Date: Sat, 24 Jan 2026 05:10:55 +0800
Message-ID: <20260123211101.2929547-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252969-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9901A7AD5E
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  8 ++++----
 drivers/net/netdevsim/psp.c       | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 46c67983c517..f767fc8a7505 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -109,10 +109,10 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
-		u64 rx_packets;
-		u64 rx_bytes;
-		u64 tx_packets;
-		u64 tx_bytes;
+		u64_stats_t rx_packets;
+		u64_stats_t rx_bytes;
+		u64_stats_t tx_packets;
+		u64_stats_t tx_bytes;
 		struct u64_stats_sync syncp;
 		struct psp_dev *dev;
 		u32 spi;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 727da06101ca..0b4d717253b0 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -72,10 +72,12 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		skb->decrypted = 1;
 
 		u64_stats_update_begin(&ns->psp.syncp);
-		ns->psp.tx_packets++;
-		ns->psp.rx_packets++;
-		ns->psp.tx_bytes += skb->len - skb_inner_transport_offset(skb);
-		ns->psp.rx_bytes += skb->len - skb_inner_transport_offset(skb);
+		u64_stats_inc(&ns->psp.tx_packets);
+		u64_stats_inc(&ns->psp.rx_packets);
+		u64_stats_add(&ns->psp.tx_bytes,
+			      skb->len - skb_inner_transport_offset(skb));
+		u64_stats_add(&ns->psp.rx_bytes,
+			      skb->len - skb_inner_transport_offset(skb));
 		u64_stats_update_end(&ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
@@ -183,10 +185,10 @@ static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 
 	do {
 		start = u64_stats_fetch_begin(&ns->psp.syncp);
-		stats->rx_bytes = ns->psp.rx_bytes;
-		stats->rx_packets = ns->psp.rx_packets;
-		stats->tx_bytes = ns->psp.tx_bytes;
-		stats->tx_packets = ns->psp.tx_packets;
+		stats->rx_bytes = u64_stats_read(&ns->psp.rx_bytes);
+		stats->rx_packets = u64_stats_read(&ns->psp.rx_packets);
+		stats->tx_bytes = u64_stats_read(&ns->psp.tx_bytes);
+		stats->tx_packets = u64_stats_read(&ns->psp.tx_packets);
 	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
 }
 
-- 
2.51.0


