Return-Path: <netdev+bounces-273466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHuvNu5cy2lJGwYAu9opvQ
	(envelope-from <netdev+bounces-273466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E4364282
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E96883001188
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB136EAAC;
	Tue, 31 Mar 2026 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYiOyFBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB3370D5B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935273; cv=none; b=kovjWqDy3SDn8QXJ3vmDiuQ5UE+ismbn6/7z8XCyZQ6xxIiqpB1RCMZ9C/os+wR0vCah9rBvGLxXIdF14Lg9xrTNUyCkPpi1YIIxzHW9hd3cPsng8W6ESmikZJuARyD1XpsQAG8y9Mlb8zZcPO/034BC4bV8qUZZMRburVLevSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935273; c=relaxed/simple;
	bh=IxEtXO/nWpkXJrRDFmzIhybDIIm+ESmVcrEy2sP3Swg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WvvjLiMSqWNiMDjBXKUlYfNROSp7xcY3F6vemr0o82FjwJHHVX5DSJVHomSK3gjx86QIG4/GVf//tK5VuOfFP2s+s0Lelfipe4zdG/8RwjcIq2BJbOJIwx7o4yjh5Yogue4EDuX6KdpxNCn/uuF8HWNLs3G2AYG5OJwpa6HlLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYiOyFBs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127337c8e52so1798296c88.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935271; x=1775540071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N54/SZrWs/Wp3KYTfHz5r2t2gDbOlOuPDGz9B0R98TY=;
        b=JYiOyFBsIkdGXmaUwMnj7GRyY/eyAeRRwV/h6GxhBKikjd8vSjw+J/k6ACl01W2p0U
         JLr/W1lt/AwgMTHIr9sFQaVQ2oHKjOaqUov/kkp074ViSaJ2YG4HSSlL5/oMcPNtDiFp
         4hD16mdeNVuvsoBdcAeT1toVyXAN928tFPIfGByO1zfIfdQBOxquWeQ5vcRmv/9Y4zFF
         22f7dRZ8YMGA7h/QM6p5dYP7HXy37Gwf2Wm5srGjQ8ALWj5uDqjQboutj4EtsYv4dN2J
         Ozy55B0PVbQwv/Z6WHnqRxY16DtuKARFVn7xjPPiSsIrokByuLOIDOHLi2YWZ/k9QHgp
         Q3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935271; x=1775540071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N54/SZrWs/Wp3KYTfHz5r2t2gDbOlOuPDGz9B0R98TY=;
        b=KAMALhqXwP0w3BMc6qGUbux4uYf3w459sSifirA3fogmDzgFAiZjspbpSLVvBXUwCI
         YWrm7JqVIGv9LlZSWgfVFgn10cqEfy6BQE7MDtAoHDxmNOB3mXOa3IfdpDJkmdPuDssV
         z7Erm8/HrRUv9cvaEQ2QR0Q3MRstnBaTNvYn/AgYIUDS7jYN66DpjdKCVlPNZ9qlo2IJ
         NG5rF7VFFMmdL5NNPrBvbluEZ5qozvK6PenXs/Natx071IEwCSZZfB0M4PcJnW97e/49
         dNUcnHqKvRGZZJa1vEYox0xuXP2W4nnq0DyU0lwNJapn2MhwWFQ3zYX+Y719fRRLDVSG
         Nf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoCfeYY4l5ikGTEchxnkMFp5LtpWOz2EuW+lnnrKYppasKGZ5vF/qvfbucyAvEDSUOSBB1MiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNYMhvgtmxn3HQuj+VUXfXl6nx+mnRp4T7wsAAW6MKJQ19rjD
	NEPUxBe4pweFVJV4ZaZWiwFwCYyNI1TRcnmLxX8iPbkhxBdQ13GEfpQRkFnxTd6iKkvcspFsfln
	QCsDFsX2d0YuV+ln2Vlvz/g==
X-Received: from dlbts5-n2.prod.google.com ([2002:a05:7022:b045:20b0:12a:c447:d6bf])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:48f:b0:127:867f:2448 with SMTP id a92af1059eb24-12ab28e4c7fmr8006150c88.26.1774935270644;
 Mon, 30 Mar 2026 22:34:30 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:33:47 +0000
In-Reply-To: <20260331053353.2504254-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331053353.2504254-1-marcharvey@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053353.2504254-2-marcharvey@google.com>
Subject: [PATCH net-next 1/7] net: team: Annotate reads and writes for mixed
 lock accessed values
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E89E4364282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The team_port's "index" and the team's "en_port_count" are read in
the hot transmit path, but are only written to when holding the rtnl
lock.

Use READ_ONCE() for all lockless reads of these values, and use
WRITE_ONCE() for all writes.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
 drivers/net/team/team_core.c        | 11 ++++++-----
 drivers/net/team/team_mode_random.c |  2 +-
 include/linux/if_team.h             |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 566a5d102c23..becd066279a6 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -938,7 +938,8 @@ static void team_port_enable(struct team *team,
 {
 	if (team_port_enabled(port))
 		return;
-	port->index = team->en_port_count++;
+	WRITE_ONCE(port->index, team->en_port_count);
+	WRITE_ONCE(team->en_port_count, team->en_port_count + 1);
 	hlist_add_head_rcu(&port->hlist,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
@@ -958,7 +959,7 @@ static void __reconstruct_port_hlist(struct team *team, int rm_index)
 	for (i = rm_index + 1; i < team->en_port_count; i++) {
 		port = team_get_port_by_index(team, i);
 		hlist_del_rcu(&port->hlist);
-		port->index--;
+		WRITE_ONCE(port->index, port->index - 1);
 		hlist_add_head_rcu(&port->hlist,
 				   team_port_index_hash(team, port->index));
 	}
@@ -973,8 +974,8 @@ static void team_port_disable(struct team *team,
 		team->ops.port_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
-	port->index = -1;
-	team->en_port_count--;
+	WRITE_ONCE(port->index, -1);
+	WRITE_ONCE(team->en_port_count, team->en_port_count - 1);
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
 	team_lower_state_changed(port);
@@ -1245,7 +1246,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netif_addr_unlock_bh(dev);
 	}
 
-	port->index = -1;
+	WRITE_ONCE(port->index, -1);
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	netdev_compute_master_upper_features(dev, true);
diff --git a/drivers/net/team/team_mode_random.c b/drivers/net/team/team_mode_random.c
index 53d0ce34b8ce..169a7bc865b2 100644
--- a/drivers/net/team/team_mode_random.c
+++ b/drivers/net/team/team_mode_random.c
@@ -16,7 +16,7 @@ static bool rnd_transmit(struct team *team, struct sk_buff *skb)
 	struct team_port *port;
 	int port_index;
 
-	port_index = get_random_u32_below(team->en_port_count);
+	port_index = get_random_u32_below(READ_ONCE(team->en_port_count));
 	port = team_get_port_by_index_rcu(team, port_index);
 	if (unlikely(!port))
 		goto drop;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ccb5327de26d..06f4d7400c1e 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -77,7 +77,7 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 
 static inline bool team_port_enabled(struct team_port *port)
 {
-	return port->index != -1;
+	return READ_ONCE(port->index) != -1;
 }
 
 static inline bool team_port_txable(struct team_port *port)
@@ -272,7 +272,7 @@ static inline struct team_port *team_get_port_by_index_rcu(struct team *team,
 	struct hlist_head *head = team_port_index_hash(team, port_index);
 
 	hlist_for_each_entry_rcu(port, head, hlist)
-		if (port->index == port_index)
+		if (READ_ONCE(port->index) == port_index)
 			return port;
 	return NULL;
 }
-- 
2.53.0.1018.g2bb0e51243-goog


