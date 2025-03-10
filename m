Return-Path: <netdev+bounces-173600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51FA59BDB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A9C3A5B7B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68956230BF3;
	Mon, 10 Mar 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YQOkFEWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v22Bsbdw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YQOkFEWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v22Bsbdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FE233140
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625991; cv=none; b=tca5YpOCM1gY5xeUBEGPdd2p+p1QYJBgpXAvngGN/gupmsCqtl+fQwYp802JEDiY+5qSH8Ivp/gN7ZObaR89cGVq1D0mwby9e/R0XHsEOHBdctcIexZ1brkyMsUcA8ZOpZTIFlDHahf3eMCEXuk23EWypCev8CD6GKsfUbaE780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625991; c=relaxed/simple;
	bh=bzgxmPiyxdUgwrTaKmPrMP3C4VMs5NTi+aNP325TVKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6Ahp0BjPZ88PZwsxhalHyXYviX465R1RzrypIqYeh/HgYk5skYQ2NfPiXPPNcE7ILgQeriEGinrusvy2FZjO6kYzr9iUKSzWWA2fyPgwG0Gucjx1w27auJYGPp34t/f3rPmcuScbh4G7mufizpN1ypsYQS4Rw1W2AljDBSrlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YQOkFEWR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v22Bsbdw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YQOkFEWR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v22Bsbdw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D078921171;
	Mon, 10 Mar 2025 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJMKt3mXLhrk9rTRNxqbtzeFb/7va0YwRZyupNReY3A=;
	b=YQOkFEWRxYy0eGuIHoZ+YJtrsJQ3hifftOtEHd2MczhObqG1EtU3zIQFLGzaO6HE3X2BA9
	FBsKs7oW9lJfSdT5UPvRJFhmicnqHq2zH/KrJPEkKtnfKXIlIxJCW46V9ygkIDeeXr/TJD
	G4QEqvxGbqTjYjakYX4e2u5VsxER3WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJMKt3mXLhrk9rTRNxqbtzeFb/7va0YwRZyupNReY3A=;
	b=v22BsbdwU76c4Bpk9H4mkKtUWriU+Rg63PmPQdL05bNiIQyvncNfALJaGbW70hidGVHTRW
	Ifh3n9a4COnrAECQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YQOkFEWR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v22Bsbdw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJMKt3mXLhrk9rTRNxqbtzeFb/7va0YwRZyupNReY3A=;
	b=YQOkFEWRxYy0eGuIHoZ+YJtrsJQ3hifftOtEHd2MczhObqG1EtU3zIQFLGzaO6HE3X2BA9
	FBsKs7oW9lJfSdT5UPvRJFhmicnqHq2zH/KrJPEkKtnfKXIlIxJCW46V9ygkIDeeXr/TJD
	G4QEqvxGbqTjYjakYX4e2u5VsxER3WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJMKt3mXLhrk9rTRNxqbtzeFb/7va0YwRZyupNReY3A=;
	b=v22BsbdwU76c4Bpk9H4mkKtUWriU+Rg63PmPQdL05bNiIQyvncNfALJaGbW70hidGVHTRW
	Ifh3n9a4COnrAECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF014139E7;
	Mon, 10 Mar 2025 16:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2yJ+LYAaz2e9aAAAD6G6ig
	(envelope-from <nstange@suse.de>); Mon, 10 Mar 2025 16:59:44 +0000
From: Nicolai Stange <nstange@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [PATCH v1 3/4] ipv6: sr: factor seg6_hmac_init_algo()'s per-algo code into separate function
Date: Mon, 10 Mar 2025 17:58:56 +0100
Message-ID: <20250310165857.3584612-4-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310165857.3584612-1-nstange@suse.de>
References: <20250310165857.3584612-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D078921171
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpptcdopf6haxzq6q5owokncz)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

In order to prepare for ignoring certain instantiation failures and
continue with the remaining supported algorithms, factor the per-algo
initialization code into a separate function:
- rename seg6_hmac_init_algo() to seg6_hmac_init_algos() and
- move its per-algo initialization code into a new function,
  seg6_hmac_init_algo().

This is a refactoring only, there is no change in behaviour.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 net/ipv6/seg6_hmac.c | 88 ++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 2d7a400e074f..85e90d8d8050 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -380,51 +380,61 @@ static void seg6_hmac_free_algo(struct seg6_hmac_algo *algo)
 	}
 }
 
-static int seg6_hmac_init_algo(void)
+static int seg6_hmac_init_algo(struct seg6_hmac_algo *algo)
 {
-	struct seg6_hmac_algo *algo;
-	struct crypto_shash *tfm;
+	struct crypto_shash *tfm, **p_tfm;
 	struct shash_desc *shash;
-	int i, alg_count, cpu;
+	int cpu, shsize;
 	int ret = -ENOMEM;
 
+	algo->tfms = alloc_percpu(struct crypto_shash *);
+	if (!algo->tfms)
+		goto error_out;
+
+	for_each_possible_cpu(cpu) {
+		tfm = crypto_alloc_shash(algo->name, 0, 0);
+		if (IS_ERR(tfm)) {
+			ret = PTR_ERR(tfm);
+			goto error_out;
+		}
+		p_tfm = per_cpu_ptr(algo->tfms, cpu);
+		*p_tfm = tfm;
+	}
+
+	p_tfm = raw_cpu_ptr(algo->tfms);
+	tfm = *p_tfm;
+
+	shsize = sizeof(*shash) + crypto_shash_descsize(tfm);
+
+	algo->shashs = alloc_percpu(struct shash_desc *);
+	if (!algo->shashs)
+		goto error_out;
+
+	for_each_possible_cpu(cpu) {
+		shash = kzalloc_node(shsize, GFP_KERNEL,
+				     cpu_to_node(cpu));
+		if (!shash)
+			goto error_out;
+		*per_cpu_ptr(algo->shashs, cpu) = shash;
+	}
+
+	return 0;
+
+error_out:
+	seg6_hmac_free_algo(algo);
+	return ret;
+}
+
+static int seg6_hmac_init_algos(void)
+{
+	int i, alg_count;
+	int ret;
+
 	alg_count = ARRAY_SIZE(hmac_algos);
-
 	for (i = 0; i < alg_count; i++) {
-		struct crypto_shash **p_tfm;
-		int shsize;
-
-		algo = &hmac_algos[i];
-		algo->tfms = alloc_percpu(struct crypto_shash *);
-		if (!algo->tfms)
+		ret = seg6_hmac_init_algo(&hmac_algos[i]);
+		if (ret)
 			goto error_out;
-
-		for_each_possible_cpu(cpu) {
-			tfm = crypto_alloc_shash(algo->name, 0, 0);
-			if (IS_ERR(tfm)) {
-				ret = PTR_ERR(tfm);
-				goto error_out;
-			}
-			p_tfm = per_cpu_ptr(algo->tfms, cpu);
-			*p_tfm = tfm;
-		}
-
-		p_tfm = raw_cpu_ptr(algo->tfms);
-		tfm = *p_tfm;
-
-		shsize = sizeof(*shash) + crypto_shash_descsize(tfm);
-
-		algo->shashs = alloc_percpu(struct shash_desc *);
-		if (!algo->shashs)
-			goto error_out;
-
-		for_each_possible_cpu(cpu) {
-			shash = kzalloc_node(shsize, GFP_KERNEL,
-					     cpu_to_node(cpu));
-			if (!shash)
-				goto error_out;
-			*per_cpu_ptr(algo->shashs, cpu) = shash;
-		}
 	}
 
 	return 0;
@@ -436,7 +446,7 @@ static int seg6_hmac_init_algo(void)
 
 int __init seg6_hmac_init(void)
 {
-	return seg6_hmac_init_algo();
+	return seg6_hmac_init_algos();
 }
 
 int __net_init seg6_hmac_net_init(struct net *net)
-- 
2.47.1


