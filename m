Return-Path: <netdev+bounces-85021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A7C898FE9
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA0C1F22151
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D013AA4C;
	Thu,  4 Apr 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rdYDsViu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dclk8g+F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cdvcwCJg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFBGkHvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEF13473D
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265090; cv=none; b=mlewhUFAE6iQfC0PFuz4VwsUyvXTnRAej5SgdK0o7LBQz3po0TU5TmVnVtTxA5nxtH/S9a+S4BRH7GVE8vupX5PVXJ5Au3s9w3M2qN4YZ5xNG/EOG6mEVuzPSSUVg3AeYV3E5zOUgZ2oWjp6gQafBSmOPLnV4olrIoufkc7wvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265090; c=relaxed/simple;
	bh=kDsTczcgKrQx4Mv1yNTeTiqNGF2XlywCGmGwOZLPq8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnlQCGJxs+akbcGHfID0tvZLl6RsZdu9PlznJLDtaPLS85laM2IO8AuWqY4GwVT5QOuKHXzgM67wQS3yJbz1ndl+LZfLxO4CQmhqtuFm2ZMVPwLCZNkkYYFHk6wuNyI2aKT+3Q5m0Xm+6M1AP0ZT3Oa+HtnQLlfa7njdZrIe/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rdYDsViu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dclk8g+F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cdvcwCJg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFBGkHvK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6D201F441;
	Thu,  4 Apr 2024 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712265086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G4KkPw51wsPX4YLwRMC8+YIAnNVkPQo7t2OqZeZYoIA=;
	b=rdYDsViu0mfvwbSjZuOLK62Od5l9D0KTtw0xOkCIJibV2yAO4T28TuiEb8dw7z293Jwe9Y
	av41A1m+/NRGJdnI/473JbDK2rU7tBpzxctwn8ku3dNHY+ToTdexuYpp3TWC2kU4+5cf/N
	tKQceYBUstmivnt0LzzVMMM5T0LapJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712265086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G4KkPw51wsPX4YLwRMC8+YIAnNVkPQo7t2OqZeZYoIA=;
	b=Dclk8g+FEmhD1qsUum8WDeC058B6j+FT97/YJROUvptJ6CT52Jxhi5b0buPwSpPBqEkJ2f
	giL3Yp5btypPjsAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712265085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G4KkPw51wsPX4YLwRMC8+YIAnNVkPQo7t2OqZeZYoIA=;
	b=cdvcwCJgdXSz74Tif7QBlY4ii0Xi9+cSLAJYNVc8Uym/j3vowQ0WZlVLwwsjQDlPDZTK2u
	wf8VEbW++21jcFQYkURthjDCpniD2Mc0hWSp5ToWkkMBMQT2VEnfzKERZ8xJrfcGrbLnLJ
	qUAvGt1ZoRfKiV520d2vO5tUcAFic54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712265085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G4KkPw51wsPX4YLwRMC8+YIAnNVkPQo7t2OqZeZYoIA=;
	b=FFBGkHvK4eK8XvCY/pm7fGsgs9Z9W3z7dXdueJsQV5UAyDMh9aTNGUTxE86r2ZKj3Zzzqp
	1L9qKMaiv9JEYQAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDA2139E8;
	Thu,  4 Apr 2024 21:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id m9wOFH0XD2b6AgAAn2gu4w
	(envelope-from <krisman@suse.de>); Thu, 04 Apr 2024 21:11:25 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH] udp: Avoid call to compute_score on multiple sites
Date: Thu,  4 Apr 2024 17:11:11 -0400
Message-ID: <20240404211111.30493-1-krisman@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
sockets are present").  The failing tests were those that would spawn
UDP sockets per-cpu on systems that have a high number of cpus.

Unsurprisingly, it is not caused by the extra re-scoring of the reused
socket, but due to the compiler no longer inlining compute_score, once
it has the extra call site in upd5_lib_lookup2.  This is augmented by
the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.

We could just explicitly inline it, but compute_score() is quite a large
function, around 300b.  Inlining in two sites would almost double
udp4_lib_lookup2, which is a silly thing to do just to workaround a
mitigation.  Instead, this patch shuffles the code a bit to avoid the
multiple calls to compute_score.  Since it is a static function used in
one spot, the compiler can safely fold it in, as it did before, without
increasing the text size.

With this patch applied I ran my original iperf3 testcases.  The failing
cases all looked like this (ipv4):
	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2 2>&1

where $R is either 1G/10G/0 (max, unlimited).  I ran 5 times each.
baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
tree. harmean == harmonic mean; CV == coefficient of variation.

ipv4:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline 1726716.59(0.0401) 1751758.50(0.0068) 1425388.83(0.1276)
patched  1842337.77(0.0711) 1861574.00(0.0774) 1888601.95(0.0580)

ipv6:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline: 1693636.28(0.0132) 1704418.23(0.0094) 1519681.83(0.1299)
patched   1909754.24(0.0307) 1782295.80(0.0539) 1632803.48(0.1185)

This restores the performance we had before the change above with this
benchmark.  We obviously don't expect any real impact when mitigations
are disabled, but just to be sure it also doesn't regresses:

mitigations=off ipv4:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)

Finally, I can see this restores compute_score inlining in my gcc
without extra function attributes. Out of caution, I still added
__always_inline in compute_score, to prevent future changes from
un-inlining it again.  Since it is only in one site, it should be fine.

Cc: Lorenz Bauer <lmb@isovalent.com>
Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Another idea would be shrinking compute_score and then inlining it.  I'm
not a network developer, but it seems that we can avoid most of the
"same network" checks of calculate_score when passing a socket from the
reusegroup.  If that is the case, we can fork out a compute_score_fast
that can be safely inlined at the second call site of the existing
compute_score.  I didn't pursue this any further.
---
 net/ipv4/udp.c | 24 ++++++++++++++++++------
 net/ipv6/udp.c | 23 ++++++++++++++++++-----
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f..8ce5c4e8663e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -363,7 +363,11 @@ int udp_v4_get_port(struct sock *sk, unsigned short snum)
 	return udp_lib_get_port(sk, snum, hash2_nulladdr);
 }
 
-static int compute_score(struct sock *sk, struct net *net,
+/* While large, compute_score is in the UDP hot path and only used once
+ * in udp4_lib_lookup2. Avoiding the function call by inlining it has
+ * yield measurable benefits in iperf3-based benchmarks.
+ */
+static __always_inline int compute_score(struct sock *sk, struct net *net,
 			 __be32 saddr, __be16 sport,
 			 __be32 daddr, unsigned short hnum,
 			 int dif, int sdif)
@@ -425,16 +429,20 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 				     struct udp_hslot *hslot2,
 				     struct sk_buff *skb)
 {
-	struct sock *sk, *result;
+	struct sock *sk, *result, *this;
 	int score, badness;
 
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
+		this = sk;
+rescore:
+		score = compute_score(this, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
+			if (this != sk)
+				continue;
 
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
@@ -456,9 +464,13 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(result, net, saddr, sport,
-						daddr, hnum, dif, sdif);
-
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again yields
+			 * measureable overhead. Work around it by
+			 * jumping backwards to score 'this'.
+			 */
+			this = result;
+			goto rescore;
 		}
 	}
 	return result;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7c1e6469d091..883e62228432 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -114,7 +114,11 @@ void udp_v6_rehash(struct sock *sk)
 	udp_lib_rehash(sk, new_hash);
 }
 
-static int compute_score(struct sock *sk, struct net *net,
+/* While large, compute_score is in the UDP hot path and only used once
+ * in udp4_lib_lookup2. Avoiding the function call by inlining it has
+ * yield measurable benefits in iperf3-based benchmarks.
+ */
+static __always_inline int compute_score(struct sock *sk, struct net *net,
 			 const struct in6_addr *saddr, __be16 sport,
 			 const struct in6_addr *daddr, unsigned short hnum,
 			 int dif, int sdif)
@@ -166,16 +170,20 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		int dif, int sdif, struct udp_hslot *hslot2,
 		struct sk_buff *skb)
 {
-	struct sock *sk, *result;
+	struct sock *sk, *result, *this;
 	int score, badness;
 
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
+		this = sk;
+rescore:
+		score = compute_score(this, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
+			if (this != sk)
+				continue;
 
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
@@ -197,8 +205,13 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(sk, net, saddr, sport,
-						daddr, hnum, dif, sdif);
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again yields
+			 * measureable overhead. Work around it by
+			 * jumping backwards to score 'result'.
+			 */
+			this = result;
+			goto rescore;
 		}
 	}
 	return result;
-- 
2.44.0


