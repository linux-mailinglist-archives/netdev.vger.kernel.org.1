Return-Path: <netdev+bounces-256300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFMOCuH8gWk7NQMAu9opvQ
	(envelope-from <netdev+bounces-256300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:49:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CBDA204
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8F83045A32
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DB39E6F9;
	Tue,  3 Feb 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkfPysch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724C318EEE
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126556; cv=none; b=ih8uU7GBVYouE2/OeUFJb1uICgShL95Q1SQpOXP33qbPeuP5QfkHEdXri2rSD9s4MU7h4zb5TVdeZ7OTABXlWXtnxy9tGLxYTdPuveFRRjKszigwWD9J9gC5KhBO/Cq8Z8PiftbjcE9vxYfxyBQ26zS7XJBu8XXyu/AoZM1SdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126556; c=relaxed/simple;
	bh=WcPvYQZ4hPvcxXauhmbhj2zr2Rf9jOKMLrdUrT7AWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVrZV1nfoEqewBn3KClwX9t5wTkPFuSRXN26Gf7fLNH34ggkR24OzGB7d+HVU2VIpcibb3sF7zgVeo/wTPM30bV4iffBXgT3Qg8FuVbGfU1JkLfM2Z0Z+TEhNkPF4lXiJIl5JFuhDEEvv6/G/RnEb06nSFjQDUGkGisNc1Nv4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkfPysch; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8871718b05so905169066b.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770126551; x=1770731351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O95u82WFtOCqmhhnrx4s8maU221mJSOHdUAd47NdUN0=;
        b=KkfPysch5AJuvwrcCH//IzQNGwqMGpKhymSQ614R6XX1q4m0H3IhHSIRsdzWd7qExo
         I8VUFnumqz+VTOtzLSOJVhm2nXI1dXN6hN2p3kZrJs3QA1HVNByvvnMw72UCTxH/70CE
         gU1FxmgmTjNsNxtGYqtmTLkI5ZJAxbiXeoJTCOsf7LOXaEN/EX08O/lg+K1lzAObeUEZ
         8V/7B6mOMGySU2wU1ieA9EtYpUR/jfnPCwN9+OzxCWBK4QpztmKMXJKzCBpQcENdCAQ3
         Wt3oAKGIeEbIidDdAh2tWb9rqI8Bw3kZq6RiC2i/9Ln/P1Ktvxha4ULKPzhGaYsEjLWk
         GE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770126551; x=1770731351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O95u82WFtOCqmhhnrx4s8maU221mJSOHdUAd47NdUN0=;
        b=S2nGe8Q8+3iZ87bR1BsIylhSp5ajIMjHVdxW2xEobqdZAkeFLb6NBsiB8ZgLR41W/9
         i6pVlpKUh/hKX4DbtiWBW1klxgsU8R8bynXd4STh16GYRQ1KSiVJj5dTJl7XnRrFwKMT
         HgPbi3859g7R7qlqoJWssJmfn4B3ZJnIJHk6sZQcwIkRd5kCRUI778KTZ0TjAy44Ra6S
         KRN4ZfZdh2ybf8faXt+Go5SJ9gFIhiExWe96DCtcJr8iP7tEiIjFwkrJ7o2azdyOp/0B
         U1tEhrdoY2CtiK0Z8USlm/AiIV4qpdtFT2GF2POms8zwhmyZ0s0mnkjhzUdbMdros/UR
         5iwg==
X-Forwarded-Encrypted: i=1; AJvYcCUdDxK4mvcoFUw9yCQyHwNL73B33Ht5+cHcVAw9JVodl761s1291fwgnp6eiVdjdoheFDpogdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22HL3CgMUysZcmPD7nOMzCkBLbYUlCAyADAGbOvf/ExtUIuLF
	VNNf12P0kIn3XdxhG64u7StTZjkzwVn8hfIYNEold755dGU/GNmi6WpJlPZ8Dg==
X-Gm-Gg: AZuq6aLDQGZ4RpBqzjg/kDt2zVgQQ0mTzf46xLoDVUavYxKeK0CkhqkAzbwAqz31LTS
	2CEI7ry7D2n6gCh14k1RMACvxosO4g66upID3kR3PexxY4osyDJ2uN5vD+cqzw0yPJsvPulJQrF
	ZfCaJBXmnq4oUgRoc2y+jYiklzs0CJcgIS/iBbjsQCZSrpXtLUl5cVjjJvK2d3t6hq2eBOSYX7e
	GpAtbpnN7LTmlWbddlAKuBoCEhzPm7kmCWKQ3zie5m9kCwY03QrT/n7zW4Uuy/FiwCSB9+M+zlz
	WuRqof1Etk1T8oTpa4OcgvyAq0GuqtBcQSy0/FLDWvS+y2VNB++vhL7wC1p8fqMCVEwLrIvHyBx
	l4JQSruOO7SfpaOTchAHZP6YhybbSKwi8tCRDUlhp/RJHL6xtnEAB5k4Kkcd00jVbbXrCAVXU+s
	LrfBsWe+2tHPKiHg==
X-Received: by 2002:a17:907:3c93:b0:b7d:3728:7d11 with SMTP id a640c23a62f3a-b8dff6be325mr961499866b.50.1770126551130;
        Tue, 03 Feb 2026 05:49:11 -0800 (PST)
Received: from t14.. ([165.85.67.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf184e5dsm1058051366b.43.2026.02.03.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:49:10 -0800 (PST)
From: anders.grahn@gmail.com
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anders Grahn <anders.grahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] netfilter: nft_counter: Fix reset of counters on 32bit archs
Date: Tue,  3 Feb 2026 14:48:30 +0100
Message-ID: <20260203134831.1205444-1-anders.grahn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,netfilter.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256300-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersgrahn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 814CBDA204
X-Rspamd-Action: no action

From: Anders Grahn <anders.grahn@gmail.com>

nft_counter_reset() calls u64_stats_add() with a negative value to reset
the counter. This will work on 64bit archs, hence the negative value
added will wrap as a 64bit value which then can wrap the stat counter as
well.

On 32bit archs, the added negative value will wrap as a 32bit value and
_not_ wrapping the stat counter properly. In most cases, this would just
lead to a very large 32bit value being added to the stat counter.

Fix by introducing u64_stats_sub().

Fixes: 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic.")
Signed-off-by: Anders Grahn <anders.grahn@gmail.com>
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


