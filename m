Return-Path: <netdev+bounces-282456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLW5FFBG8mmTpQEAu9opvQ
	(envelope-from <netdev+bounces-282456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:56:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1E498609
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF0A2301386F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C441B35C;
	Wed, 29 Apr 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYQAlbJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E683B19A6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485379; cv=none; b=t2ckJPFPuKtDRUTYbKEyx7x3hL2PehZrJ6V0L9Dzm3Oik/CWEZG3G2itO5zPjlTtAGeZYmQltUE3cDcCdhIyo7rPhLC7ba/x4mFAfRbHZEtenLINTrhNdARD4bAiKytuxW8LW8CROcINx6oGJbHUOZdVswFAwP4aPGGVFNzByew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485379; c=relaxed/simple;
	bh=eDBirYq4pCbL+nEUiEp7cl5+N06I9yeNRMJUvi0dUZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE31Z0K3UsqPV/DKu+zeukwFoMnQkqvzoB5u5pnIPO5eEtSPQp0FP4VtWzmjQS1psLHitm784z2GXVXbnKVdfGWmBFEsG4N5JvtYcB/R1BnID29Uoa5XdqT2DThZRA+0LhE+KSI7E2sTdi0rOpaXYT0/ceCvWQIwMLj1yiNPW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYQAlbJM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso120755e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485376; x=1778090176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAVLe7MO2A1MyrDF6a2t4MvPRiDZqS4DmH+U/JOcnYM=;
        b=jYQAlbJMAUmgBX14wyxFlZBhXAKj3S+TKPLSDiohw7yy20edVzYsqczSigBf0J6CcC
         ktDQiI+MWNeYMkIasiq6Qa6I8khKvtNF5t2q33GMs9LFFsuSvZuUIy88OuGlTYUP4IkD
         WPkh/d+tsh2lw6msVv4Q+TiPhfofGlpslXAeSx/2MpTgu6SLSRqstfmuT/4zkVjdmJOL
         FOo889lSGnqyx97fziO/SI+wjyWY2ZOWYsmPwZ9UTjf4w/BYKexvsrhONblzXMIHeHEd
         FmQL/73zTpBwt2H6vWHOIHk9wYs0vqoo7ffG7R2+fu40Cx1svYsuGwplU06b9E4pzZCy
         uO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485376; x=1778090176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAVLe7MO2A1MyrDF6a2t4MvPRiDZqS4DmH+U/JOcnYM=;
        b=TapIFKsBmQf16FlL+lR+rQHetyQrj4rfAMZ+90Y6fUBXEfr6r/fXKdyaq5kURhez0m
         6EIJ7ioaZoShl+M3BJeIZhJrh1tLcWekHop16iIOkEs9tsBAwK7ZNI0uBlDT5lQgo2zz
         8i7b9yAOVpHM55WlzA40/CJPtePhkvTu96DxpWc2l1wT3pFZLplObwEJBGRyxfwMNMso
         tFnpV/s/RBS3C6yQSqLZ7x7vq2In5oeP8gZme/D1IpqSG6eYAk6nR5uv3Uc2thVEhkNv
         DzcA1towSmxFG4KchqtTF+/FgpiQGiL9E0o4yhDAJkXqs9gfnkBNwwLd7j7/+m3QZlhS
         K9/A==
X-Forwarded-Encrypted: i=1; AFNElJ9flir35+S2tzRfBHY/yOT1ahEvPP92cYFo/E6qma/wn7nTLEsuqUGjdHrvohRecDq4g+X+ngk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1QPxSUgMlHLp67fLFfzIeUJlcUrsKKoN5giz8GCeR2Q9YPQ0
	tPmjr4sijwSMfUCcHhrgy+kudhyPzVLxnds5mI/50ou4gq1JR0WigrA=
X-Gm-Gg: AeBDietFPKDPr1MMAPKf1p+jFmi791zfLlh4F1q2BOdOYVSaSq2BX1azYDNGwV5ApGu
	XGj/fcwHLwYBawpxftfc/3mO0ZsRFxbhWEyotKHHixTW/cfripl3wW4mmXQZDqQpJkHMTQO+PXc
	GiUQahh2NrAuqiYjAOu3EVvdl+YNebF/dUmxMbBsYZ7SiS2bfU4iObEJ5Jyn+c4FS3eXYgcAO4G
	k6ylrmrUWmDo6UVSWBNKnVwGYV4AXIjuyQFK+8eSFSuVlx4IhDLY3WTW5ndUaY5tykTFZ3wgvsa
	JBwL4ufS57aKrA5yZrCVn2d+31V6/yBNdbfkN+Y6mab7el0Z1Ob7mo2VZqljEG5Adl/zft+dT7O
	K+xk7zJjjPWC3fn6eRHxinxl7c4yA1uFzI69G5QZlJyTOHxTtw5sNIMBo96NW5kQhDqBtiP5iyd
	O5838=
X-Received: by 2002:a05:600c:c048:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48a77b22dedmr99590625e9.25.1777485375550;
        Wed, 29 Apr 2026 10:56:15 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm6183750f8f.5.2026.04.29.10.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:56:14 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 1/2] netfilter: ip_tables: allocate hook ops before making table visible
Date: Wed, 29 Apr 2026 17:56:11 +0000
Message-ID: <20260429175613.1459342-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBA1E498609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282456-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

ipt_register_table() adds the table to the per-netns list via
xt_register_table() before allocating the per-netns hook ops copy
via kmemdup_array().  This leaves a window where the table is
visible in the list with ops=NULL.

If cleanup_net() runs during this window (e.g. due to concurrent
netns teardown with failslab-induced allocation failures), the
pre_exit callback finds the table via xt_find_table() and passes
the NULL ops pointer to nf_unregister_net_hooks(), causing a NULL
pointer dereference:

  general protection fault in nf_unregister_net_hooks+0xbc/0x150
  RIP: nf_unregister_net_hooks (net/netfilter/core.c:613)
  Call Trace:
    ipt_unregister_table_pre_exit
    iptable_mangle_net_pre_exit
    ops_pre_exit_list
    cleanup_net

Fix by moving the ops allocation before xt_register_table() so
the table is never in the list without valid ops.

Fixes: ae689334225f ("netfilter: ip_tables: pass table pointer via nf_hook_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ipv4/netfilter/ip_tables.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 23c8deff8095a..c47bc776eb4f2 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1745,6 +1745,21 @@ int ipt_register_table(struct net *net, const struct xt_table *table,
 		return ret;
 	}
 
+	if (template_ops) {
+		num_ops = hweight32(table->valid_hooks);
+		if (num_ops == 0) {
+			xt_free_table_info(newinfo);
+			return -EINVAL;
+		}
+
+		ops = kmemdup_array(template_ops, num_ops, sizeof(*ops),
+				    GFP_KERNEL);
+		if (!ops) {
+			xt_free_table_info(newinfo);
+			return -ENOMEM;
+		}
+	}
+
 	new_table = xt_register_table(net, table, &bootstrap, newinfo);
 	if (IS_ERR(new_table)) {
 		struct ipt_entry *iter;
@@ -1752,27 +1767,13 @@ int ipt_register_table(struct net *net, const struct xt_table *table,
 		xt_entry_foreach(iter, loc_cpu_entry, newinfo->size)
 			cleanup_entry(iter, net);
 		xt_free_table_info(newinfo);
+		kfree(ops);
 		return PTR_ERR(new_table);
 	}
 
-	/* No template? No need to do anything. This is used by 'nat' table, it registers
-	 * with the nat core instead of the netfilter core.
-	 */
 	if (!template_ops)
 		return 0;
 
-	num_ops = hweight32(table->valid_hooks);
-	if (num_ops == 0) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	ops = kmemdup_array(template_ops, num_ops, sizeof(*ops), GFP_KERNEL);
-	if (!ops) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-
 	for (i = 0; i < num_ops; i++)
 		ops[i].priv = new_table;
 
-- 
2.47.3


