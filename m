Return-Path: <netdev+bounces-197504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD431AD8D97
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392A17A865E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99311A01C6;
	Fri, 13 Jun 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWYXm/4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76218FC91
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822415; cv=none; b=EkELSSf54hYihsbHSulPHi7HcTNolrrnsq0bCxYEdaYb4QJR6Elu9PliAP94kLX7k/y/2/pXK/r2LrPmM7CeBx6oogw8/9PigUfeeokwOXthgApT77wrZv1fYmy64UAaM8z1uHeOyJMCIA7rNNaE58AMTWaO+3CRVN1RywrjnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822415; c=relaxed/simple;
	bh=A23vnrv50wNJrw8NtC6jOH28SBhC3U/2P2sS9d1kwLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALwCjkyXrdrRwoKSL2EbcKfEMgO8/3gLlsCq1qPY9EYAWwP0t8j/Sk/ERw0uRf/JV/sAt9LcLuiuY2rHjHshwLCY/ZWD5/HqWTabcFk+199E39i/pekda4gjuRLPszhVtqhBKakYPg2vFUV1cq5im1cLLijDYx+4pNhY+C795gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWYXm/4X; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a53ee6fcd5so1395846f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822410; x=1750427210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdflZV1R2uZZ4qHx6w0jgWXXOM1/gXo3LHm1bfJRr6k=;
        b=CWYXm/4X/yY2/Y+1AdtErCgpJAmR4GAJ5bATSI2lExWA05KUDbBxK+UJoZWWuU5gEB
         /f7V1Twq8eKIprFNCAjE+Weyp97eqx2+iICPSaAoupp48IF3F7FlxWo5HjWeo/IXTa/R
         hfLXE8x5b3e1Qm7pWP0UMm4V8mQu2V5wx4MedD6KOZ4t1HJtl2JLqXHYlWaYmQK8/OPv
         O6npa3is6DZtpLgiklRsSsZ7uLwxHnxdfW0FhukpXjhfbeA+auMvMAqUibqmk+cALbjY
         WpqLV5h99HeiASQsXfesNqEHQsfMedOgK9fCOx7U7GgFagIX/n6j8CoVrfuQslN6o+gJ
         1XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822410; x=1750427210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdflZV1R2uZZ4qHx6w0jgWXXOM1/gXo3LHm1bfJRr6k=;
        b=w1m+UslaFTiQvTql97WtAsDbZ9cblWcV4ZKHx22tC+xXb5pslqfLFTarJ51PCG7iYG
         3jkTyqK4D+7wwVSNlDg9chQl0gkDhl3oRl3mMdFdmp4qjJ2GATX1T3WMfWd9UIDYpXSP
         4NpevWEz602oEU1a9CzQdF2a747S1Hnw6xm7B9HM1skChndlqeJ1B+KfrJK6WW0nVugh
         dwtRXfb4Gs974Gz7leS7j8KFaAuI+QBrTlaLDqXnBMWZ5WOmVT3hy6D3aa4uz5dmhtQs
         nUJXDTRKwBH8nGXyPOwaAN8U3MGP37R8C5OFa8wxTni7fkFr3v5z2C/1/4yWd2pmgNEA
         aEHg==
X-Gm-Message-State: AOJu0YwADy7C6CZuXFTQCubkTg7HAnwFAulJ4GYcnHTofpUdjHbb6FEB
	tAi62EQhijcl2PtJRgyAaKait+MyWqK6pvjB+h/IO0jRf05473xCKsSE
X-Gm-Gg: ASbGncsUyKR5f5H22jsFme1Eb+dZ5ysdb43N4tGyu97R5LzBhqRjnrO1RL51DUwn6+I
	fwzploOCl10q9Y84NjxhlGQDx7T5ysh8Z93hHppvhK6p1YF5K+v3f5NVnY7Mo2zo5SMF25Veru3
	om9zKexdLguYJa58NDaop5qgyKFclN3esGMk21tRThjwhw6JRdUk+Sk2W3ESH9kB+8PCiwRU8hp
	cNaMw6CdGlzn5F/3go0Ue/ex5NroHHP4NfyzUGs1PJNe5IWhZmBBiyIH1KweKYCQnQRGHVoTxFq
	fmS3COMCK0yNQW9jQJkNusiZchQrNjyIm2TBsdNdNFlSWiu+eaHoOZTpLwvQ7mEcPRC5/LSLFah
	u/Gcd1Qx3UOkNthCEeXHfjpSO8Szgpg==
X-Google-Smtp-Source: AGHT+IGR2tEG1lk9m598QjJJ2jBfda6viXGeOy+IJIqFApvdHx6Gwex6zSS4wMt4hK9K0Php8qF2sg==
X-Received: by 2002:a05:6000:26d3:b0:3a4:f2aa:2e32 with SMTP id ffacd0b85a97d-3a5687085bdmr3131086f8f.44.1749822409895;
        Fri, 13 Jun 2025 06:46:49 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2a6a5sm2391446f8f.74.2025.06.13.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:46:49 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	decot+git@google.com,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [PATCH net-next] neighbour: add support for NUD_PERMANENT proxy entries
Date: Fri, 13 Jun 2025 15:46:02 +0200
Message-ID: <20250613134602.310840-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussesd in [0] proxy entries (which are more configuration than
runtime data) should stay when the link goes does down (carrier wise).
This is what happens for regular neighbour entries added manually.

So lets fix this by:
  - storing in the proxy entries the mdn_state (only NUD_PERMANENT for now)
  - not removing NUD_PERMANENT proxy entries on carrier down by adding a
    skip_perm arg to pneigh_ifdown_and_unlock() (same as how it's done in
    neigh_flush_dev() for regular non-proxy entries)

Link: https://lore.kernel.org/netdev/c584ef7e-6897-01f3-5b80-12b53f7b4bf4@kernel.org/ [0]
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 include/net/neighbour.h |  1 +
 net/core/neighbour.c    | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 9a832cab5b1d..d1e05b39cbb1 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -182,6 +182,7 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
+	u8			state;
 	u32			key[];
 };
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 49dce9a82295..419f2f984d64 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,7 +54,8 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev);
+				    struct net_device *dev,
+				    bool skip_perm);
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -423,7 +424,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
-	pneigh_ifdown_and_unlock(tbl, dev);
+	pneigh_ifdown_and_unlock(tbl, dev, skip_perm);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
@@ -803,7 +804,8 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 }
 
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev)
+				    struct net_device *dev,
+				    bool skip_perm)
 {
 	struct pneigh_entry *n, **np, *freelist = NULL;
 	u32 h;
@@ -811,12 +813,15 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
 		while ((n = *np) != NULL) {
+			if (skip_perm && n->state & NUD_PERMANENT)
+				goto skip;
 			if (!dev || n->dev == dev) {
 				*np = n->next;
 				n->next = freelist;
 				freelist = n;
 				continue;
 			}
+skip:
 			np = &n->next;
 		}
 	}
@@ -1972,6 +1977,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[NDA_PROTOCOL])
 		protocol = nla_get_u8(tb[NDA_PROTOCOL]);
 	if (ndm_flags & NTF_PROXY) {
+		u8 state = ndm->ndm_state & NUD_PERMANENT;
 		struct pneigh_entry *pn;
 
 		if (ndm_flags & NTF_MANAGED) {
@@ -1983,6 +1989,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 1);
 		if (pn) {
 			pn->flags = ndm_flags;
+			pn->state = state;
 			if (protocol)
 				pn->protocol = protocol;
 			err = 0;
-- 
2.49.0


