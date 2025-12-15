Return-Path: <netdev+bounces-244791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF7CBEACF
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6093930140ED
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C474336EDA;
	Mon, 15 Dec 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSM/ZAy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454E3090DC
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812800; cv=none; b=D50yHsGoGkJgvnHoe6rS/wsAiy9aRXajDeOmmXVBd6FAsfAkHKPA5FLUwhZImznuo1syYwS4IDIcBW6U12m3c0ZnIgANacEOD5o9QOumYuOFUhJgpRhqrwBBRe1mPicMY1cQOO5arsR4pAs8ri8hTr0YBmAUifuFmezpVgQdQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812800; c=relaxed/simple;
	bh=WmWvQHLY73kq6pyu0tqKKzeIaeIlwBviwDjoR+oDJmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3vqwcdU0MKw4VUpT2rhb3HV+KmW35k1UVJNDaQ+dEQdmbshh7YYvIiRJu4OC8m2D4PdqFHQ7WUnxUKrBS6YpfJFVlqfCp5yfufX1rJ+L2ryGoIW9lcicw6jT4bkkOaz+dEoMF9fUwrdAeLtUd8HGFP/3zMsAQ7HeHP15VYfNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSM/ZAy9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso43956055e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765812794; x=1766417594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shGL9qFpkDmIajBigNqT+nCnomY+2wBP3NtQMg+px3M=;
        b=kSM/ZAy9A/ibb/vYxkZYagoRF9ZMiff93LFSyEpNV6Io6o47xro300HFC3HSKrzA8e
         rg6CUwlaetlOnHfab2oAhHD1/BiLyApEIyAVD/VuFdOUvcPRwxkiLYIe/6LeFpYLiIqN
         +dKPOUAT6RXXRRLgSneQQkTE/vXdJBt+0cfeXXKHY91fkUhlObGHHapwyQfMGyvw8Fps
         JghF+yd7RH+F0SFJbPBPFG8/FRCskPXXMYKmmxT5QmI3BmNnItgb8eooKjx/51QU2msh
         uBFORfpYSld0a1V9P/eVcrX04ZSychNdwtYRoeOk67cpKLE2Arbanu9K669oPaCsq4Ab
         Gxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812794; x=1766417594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shGL9qFpkDmIajBigNqT+nCnomY+2wBP3NtQMg+px3M=;
        b=QFBtO1mlr9CjU4iuF8MQ3rrf6QMxZl/zJMf8l4v4UcpUjSv9Hfdfs7QOP0SGF1XZb0
         38Y4zs5z67LfI1R/7R06rebT2OwqJgDuiAKohZsBMNwDK2MSSKcnpA14ypqEH1IwHUWu
         /g6OEa09X0ZKvnsndvC2RT9klVgiQiUtTmTVjMjUtQSuNEAX15yIXfVWKkxH0zr42zAa
         Gbxm4Y+GfAGUS70LKY2vqVfru2PzAUkPIrqjlBX7k4DpJDRQzQqUkgSMSMAhZfRx+dx5
         sTMita7s5GSRlEaiMAOwieimWACjzLV2cAKQMn48WCD6MvBsKi/dkx6xIOQACItXf2VO
         r9LA==
X-Forwarded-Encrypted: i=1; AJvYcCWHFlvVvIe+5jLL9LTthUMh52jVhdEvqvWkMh2nG/OojAnoSS3xEbMlYyguvXpNz71nw4E9yBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3laXou7qQ5gxeSQRCshybJ1hTvvBZxYgNDLDQOBu8AZh3p29
	rRJAFBEuPEEVxmflbmf/hdMZRx5gUcLaT3/9oXgssKCfNHLr5KMem8M0
X-Gm-Gg: AY/fxX64/3Vf3cc+Ncl1pzrzLYKIiEjoNT2PQUHLr9t7xRIGM5p/RkK46U6FwlvIgrU
	hrqdpWYhq3xXyD4w+3yjj44bIy39FbuCPj+lR5AXLj4aNLPmBJAtNAdicCTJajVPajlJk+WA4eH
	HUCUav82sbbizH5vjvfMaho2AAeb/a8ALR0NgyJ0oiBeBEPOwqFcomK5hbaaiU9HOgQAgmDEX2V
	D8L/lyxIb+6xC7dXcPagbzck4LMWb//9NU+TEtbO0CJiSALHfDzmTImlYzvh7ETcVFgMpQEt6tZ
	R+di1EvpYqarz4ktBHwCTXfiHAuPuENZprwVaj3sn6V0WUeOCoeCpcLT6PzCSoKsNE3u3AZ+7FM
	f1vGYTfebEMUOSTlhNMaaGJ5tOX6VBqiDOIifj2a/4ouN152JzL5hhVKYcMZDODPpJwPNcgkbTD
	wq3Nh/dcYuLCNhAeNsIeu1m8TH7HNXIbAfzdWFG6C7kmzDxL5hQETgXbPv4rp0gAo=
X-Google-Smtp-Source: AGHT+IHKWs48xUNePoBMrBpBe8hDtPaLfvOFnL9ImcikdGgFf5GE4aphSLQpZ1+Kfb40qsOChnhBGA==
X-Received: by 2002:a05:600c:4e90:b0:477:557b:691d with SMTP id 5b1f17b1804b1-47a942cd40dmr90250005e9.25.1765812793917;
        Mon, 15 Dec 2025 07:33:13 -0800 (PST)
Received: from t14.labs.westermo.se (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4ef38bsm203433985e9.0.2025.12.15.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:33:13 -0800 (PST)
From: Anders Grahn <anders.grahn@gmail.com>
X-Google-Original-From: Anders Grahn <anders.grahn@westermo.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anders Grahn <anders.grahn@westermo.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] netfilter: nft_counter: Fix reset of counters on 32bit archs
Date: Mon, 15 Dec 2025 16:32:52 +0100
Message-ID: <20251215153253.957951-1-anders.grahn@westermo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nft_counter_reset() calls u64_stats_add() with a negative value to reset
the counter. This will work on 64bit archs, hence the negative value
added will wrap as a 64bit value which then can wrap the stat counter as
well.

On 32bit archs, the added negative value will wrap as a 32bit value and
_not_ wrapping the stat counter properly. In most cases, this would just
lead to a very large 32bit value being added to the stat counter.

Fix by introducing u64_stats_sub().

Fixes: 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic.")
Signed-off-by: Anders Grahn <anders.grahn@westermo.com>
---
 include/linux/u64_stats_sync.h | 10 ++++++++++
 net/netfilter/nft_counter.c    |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..3366090a86bd 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -89,6 +89,11 @@ static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 	local64_add(val, &p->v);
 }
 
+static inline void u64_stats_sub(u64_stats_t *p, s64 val)
+{
+	local64_sub(val, &p->v);
+}
+
 static inline void u64_stats_inc(u64_stats_t *p)
 {
 	local64_inc(&p->v);
@@ -130,6 +135,11 @@ static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 	p->v += val;
 }
 
+static inline void u64_stats_sub(u64_stats_t *p, s64 val)
+{
+	p->v -= val;
+}
+
 static inline void u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index cc7325329496..0d70325280cc 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -117,8 +117,8 @@ static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
 	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
 	u64_stats_update_begin(nft_sync);
-	u64_stats_add(&this_cpu->packets, -total->packets);
-	u64_stats_add(&this_cpu->bytes, -total->bytes);
+	u64_stats_sub(&this_cpu->packets, total->packets);
+	u64_stats_sub(&this_cpu->bytes, total->bytes);
 	u64_stats_update_end(nft_sync);
 
 	local_bh_enable();
-- 
2.43.0


