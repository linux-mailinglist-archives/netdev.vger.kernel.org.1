Return-Path: <netdev+bounces-122947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5C963416
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CFF1F24967
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BE01AC8BE;
	Wed, 28 Aug 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="E3/tGh+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328071AB528
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881571; cv=none; b=OpoJoN8nAPbR1hOsB/TALeXIQbDVYWdwp0qV7mQIrp4ED7qnhHeGrqn9s4+NAGIg3nwecaLDrznAiQJBiPWLNZSR1VXrqjuWFsmJPzCq5/Hkuekh6jv4VlPQbAa73P0dUEuAlrYm+OBqbglUpNSSXP8R2N+T64DnKCqYWMWnAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881571; c=relaxed/simple;
	bh=whwOc+ATiSReyj/y+NpXR+hPpmNCmSxfYuR6aTujTVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2aBsc6PGK7eB89GuMN/aKR9VS+ftuca49PpeLmlv0BK/mGL4/QwIuhsA7grSf+yS8ZjTbwxkNuo5repk8P+AQnXhmWLKjc2kuonTP0AdSBjiURDkjA3VYP9AC9rmCfrRIjRgOlTJpLa8S3/Rr5zvhcYnnupMAU/gezCUzu8w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=E3/tGh+V; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3df03d1f1ddso471206b6e.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724881569; x=1725486369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd4BLxG6UmM52wUvLpi5yoIXtquUaogh6P9yQLLRUt0=;
        b=E3/tGh+V59rMI8xI+p3ALEtS8ghnfIHlvug2qiadE6h5sKHGWWZTdI4M6bb7r3Wp9B
         JLzmiLPDIa/WW3wJe+muPQLqRFd7+euYB08vnk5FblAsP+sQcaXHB8QX0Su0l7mwKAM7
         3KontC9G2gU7F3XH69CIeEUqtWmcz5/Sopqnl8TBJMhR5jbRdsfLiN0BuUIrCGCHmvlF
         ZPXKyt6x2C+8KN0+ZjV85q3X6H+QVR3RigtRWRlcTYY+11l4HvuUdG0V2/NPWOoO7jkS
         fwEXYSXJrvWjKIiuaJVCPiI9TZtOhL5sBzG0NgdsmtyFlGAnCn1k+gdLdeYed/i/Ddfy
         5frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881569; x=1725486369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd4BLxG6UmM52wUvLpi5yoIXtquUaogh6P9yQLLRUt0=;
        b=YC+pOawp8+CXY9661b3zOEwiGM/Pd2BQjFe8ooCX+m26tXcnBCGEiXAnxPZ/cGEng2
         6lWry1/rqhQVhf7kajNvFkS1ER/fBCY5SDOsYo84YE3HNVN8YYfrl+maNJFmu8eVM4mX
         HEyg3f6IOaq5vX4aA1SJYFzFFYNu/lJ7gTiiYXmw/gHYcpcGoRMUEW+LQ4QAzFlWtJeV
         XaxNWRIsWa//E0CvdpPC23YM7jJborRfYMbEO2/xfCqok7u4AQFYLygR0zlTWnlb7LI3
         coxx/BaqhJPBzhthRnCaQ4hn2O+NII8QgeG9oy+xQgX2CEtFL6bn2ynbadmnvU4KlEiq
         fg5A==
X-Gm-Message-State: AOJu0YxCkkPzJljC6zYQA8GcDhuvR6kGyNURC21hEJVIBX4OMl30JKHj
	hU++RbJzgydFKk1KEziGWikoAuS/k24huIbrxuPNcJxB+2XrplRaKtnDoR270SE=
X-Google-Smtp-Source: AGHT+IHRihjVOtHNKEpHeB8JyLd2E1QM0kl5N1ojsCNOb2mtZB/oU9NxA3Aez4K4DszmbZNVq/EkoA==
X-Received: by 2002:a05:6808:144c:b0:3db:1b70:edc5 with SMTP id 5614622812f47-3df05e68727mr988283b6e.48.1724881569112;
        Wed, 28 Aug 2024 14:46:09 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196bc6sm65227741cf.62.2024.08.28.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:46:08 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] netpoll: Make netpoll_send_udp return status instead of void
Date: Wed, 28 Aug 2024 14:33:48 -0700
Message-ID: <20240828214524.1867954-1-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240824215130.2134153-1-max@kutsevol.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_send_udp can return if send was successful.
It will allow client code to be aware of the send status.

Possible return values are the result of __netpoll_send_skb (cast to int)
and -ENOMEM. This doesn't cover the case when TX was not successful
instantaneously and was scheduled for later, __netpoll__send_skb returns
success in that case.

Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
Used in the next patch to expose send failure stats in netconsole

Changelog:

v2: No changes, resend.

v1:
 * https://lore.kernel.org/netdev/20240824215130.2134153-1-max@kutsevol.com/

 include/linux/netpoll.h | 2 +-
 net/core/netpoll.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bd19c4b91e31..10ceef618e40 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -56,7 +56,7 @@ static inline void netpoll_poll_disable(struct net_device *dev) { return; }
 static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index d657b042d5a0..664343e3b688 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -395,7 +395,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
@@ -419,7 +419,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
@@ -495,7 +495,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	skb->dev = np->dev;
 
-	netpoll_send_skb(np, skb);
+	return (int)netpoll_send_skb(np, skb);
 }
 EXPORT_SYMBOL(netpoll_send_udp);
 

base-commit: 3a0504d54b3b57f0d7bf3d9184a00c9f8887f6d7
-- 
2.43.5


