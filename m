Return-Path: <netdev+bounces-173599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F3A59BDA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C237A712D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CC230BF6;
	Mon, 10 Mar 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M4+ynvU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fwi7KwdL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M4+ynvU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fwi7KwdL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A6230BF5
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625985; cv=none; b=Fig7/rQ6rMftzULI4NBqHgLoVu4qtNPQ2xt+OBXnFU+AhXEPB+h/fttGxbN2HsuD0xXWdhAnfLMIiHC4qSTV5Wj7ApBm62lKQPJ3gE9lriKOcNpS2LXg0BsCdfm3FrxB3VvE3aSN4ecv9Ydz9PgxpOxXQT2vxvFyLhrStpaV+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625985; c=relaxed/simple;
	bh=WRCayP3MmhXf5xryWJtI2GbmV78ONoyo1lshSWu0AB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aih05l6s41MQDjf6JXvaIKyQ5H5h171TVyvblTnhLYDaE7zTUw5QK6632fbLtmJzDysqa8IEafMl1fxHB8CseK+fzY5JPVmAPjD4w1Ei/yhTbAGB3fElWjci3+kyMd3mcOZcpjABaA9NgLLOgMK+pM5nUxZS8FRPTps2fHi9Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M4+ynvU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fwi7KwdL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M4+ynvU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fwi7KwdL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 684942116F;
	Mon, 10 Mar 2025 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=829coLoa6VRYDjhgJeMBamrDTaVX11h9vawDyvsvboQ=;
	b=M4+ynvU6Qf4z/5iLvPoXjPMb5TuLXVHOsK+T0NSPHHTf2i+Fuhy+74xHGWqAtZ/bVHT1U6
	7el/QMGJLzyr68cV7kgg2dwpiStPQI19UMSs/PZQXBmEaEP21UmhMQbpgGx/G8MVSAMrBx
	pGWTzrh7Zbl0+EuA+9n/czctpKfUJvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=829coLoa6VRYDjhgJeMBamrDTaVX11h9vawDyvsvboQ=;
	b=Fwi7KwdLPuxSsYsf+/ZganJVVTAgF0yBqK1b9xS8Cx1LyK7FXLOLMxFeeoJ9Up3R2EEZSj
	cq+bho+QJwgl34BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M4+ynvU6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fwi7KwdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=829coLoa6VRYDjhgJeMBamrDTaVX11h9vawDyvsvboQ=;
	b=M4+ynvU6Qf4z/5iLvPoXjPMb5TuLXVHOsK+T0NSPHHTf2i+Fuhy+74xHGWqAtZ/bVHT1U6
	7el/QMGJLzyr68cV7kgg2dwpiStPQI19UMSs/PZQXBmEaEP21UmhMQbpgGx/G8MVSAMrBx
	pGWTzrh7Zbl0+EuA+9n/czctpKfUJvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=829coLoa6VRYDjhgJeMBamrDTaVX11h9vawDyvsvboQ=;
	b=Fwi7KwdLPuxSsYsf+/ZganJVVTAgF0yBqK1b9xS8Cx1LyK7FXLOLMxFeeoJ9Up3R2EEZSj
	cq+bho+QJwgl34BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EA6D139E7;
	Mon, 10 Mar 2025 16:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7cHEn4az2e0aAAAD6G6ig
	(envelope-from <nstange@suse.de>); Mon, 10 Mar 2025 16:59:42 +0000
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
Subject: [PATCH v1 2/4] ipv6: sr: factor seg6_hmac_exit()'s per-algo code into separate function
Date: Mon, 10 Mar 2025 17:58:55 +0100
Message-ID: <20250310165857.3584612-3-nstange@suse.de>
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
X-Rspamd-Queue-Id: 684942116F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Move the per-algo cleanup code from seg6_hmac_exit() into a separate
function, the new seg6_hmac_free_algo(), in order to make it accessible
to upcoming error handling code at initialization time.

Make seg6_hmac_free_algo() to clear out ->tfms and ->shashs in order to
make it idempotent.

Otherwise this is a refactoring only, there is no change in behaviour.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 net/ipv6/seg6_hmac.c | 48 +++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 77bdb41d3b82..2d7a400e074f 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -355,6 +355,31 @@ int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 }
 EXPORT_SYMBOL(seg6_push_hmac);
 
+static void seg6_hmac_free_algo(struct seg6_hmac_algo *algo)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
+	int cpu;
+
+	if (algo->shashs) {
+		for_each_possible_cpu(cpu) {
+			shash = *per_cpu_ptr(algo->shashs, cpu);
+			kfree(shash);
+		}
+		free_percpu(algo->shashs);
+		algo->shashs = NULL;
+	}
+
+	if (algo->tfms) {
+		for_each_possible_cpu(cpu) {
+			tfm = *per_cpu_ptr(algo->tfms, cpu);
+			crypto_free_shash(tfm);
+		}
+		free_percpu(algo->tfms);
+		algo->tfms = NULL;
+	}
+}
+
 static int seg6_hmac_init_algo(void)
 {
 	struct seg6_hmac_algo *algo;
@@ -423,30 +448,11 @@ int __net_init seg6_hmac_net_init(struct net *net)
 
 void seg6_hmac_exit(void)
 {
-	struct seg6_hmac_algo *algo = NULL;
-	struct crypto_shash *tfm;
-	struct shash_desc *shash;
-	int i, alg_count, cpu;
+	int i, alg_count;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
-		algo = &hmac_algos[i];
-
-		if (algo->shashs) {
-			for_each_possible_cpu(cpu) {
-				shash = *per_cpu_ptr(algo->shashs, cpu);
-				kfree(shash);
-			}
-			free_percpu(algo->shashs);
-		}
-
-		if (algo->tfms) {
-			for_each_possible_cpu(cpu) {
-				tfm = *per_cpu_ptr(algo->tfms, cpu);
-				crypto_free_shash(tfm);
-			}
-			free_percpu(algo->tfms);
-		}
+		seg6_hmac_free_algo(&hmac_algos[i]);
 	}
 }
 EXPORT_SYMBOL(seg6_hmac_exit);
-- 
2.47.1


