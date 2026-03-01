Return-Path: <netdev+bounces-262437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEDXImOCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C056F1D10F5
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770B630209DF
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4A3370EC;
	Sun,  1 Mar 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0xh/3E9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90D337BB5
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388905; cv=none; b=cMYopHxBu2de5ugoINyj8MWAk6jyoMovqKKdbNi4CgXGOrpLSVgYQbN+LRziJYKAkmzaVwymtVA9dK8RZczWXU0CTLrWrOJNYZX7rn5Q1MLGKBqrwNGayGhkdPvqPOsMHf/bE7v+4wCqcBFdyLyQleGlxCe/I5a+DdlCPu8caNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388905; c=relaxed/simple;
	bh=QTMrbPraPLDxOEIUtWRShfaSnMGJSy5Du5wSxtkUJDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OChZ7WBcw9ZZUUhkFIkUPmRkX03D5WXl+K0j22QY+o12D7U9QqD+Dk/aKmlJ31UKDF+FlIe1Hklx0bM7McGNRSrwjANEvOazKHLJHbTKgiOkbO4Y8VRjbh8pi0JNH3itvigKX+51OR+ge9UJmyvOEqPY2jgUIiM40kK313Xfzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0xh/3E9; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5069ba5af5bso300296141cf.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388903; x=1772993703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=c0xh/3E91qlPt59Ffg6qvm8BmOxb0YBEi49ZyIKKNtXdsPR1a9+lPF2W0zYBM4lMMA
         0FoDph8liVr0OTxrk/Qy5hcyQZLlxSIj87fhDEY7UEHzMhEFdKu8w1JuWt/qLDAad5P4
         0OqgZJFGaUAPmKWdQf6G+IRh0mfVVZu9RNoHfm2uTKQ2PBbFjPOhY9K5QwH78jqJeik+
         3PHfP9Pcib3UMpRpXMcJPS3josvLrAzacPN8alUURwzTTTJS6w+TFSNLTXpzENuybgzD
         d1y+tsySSX6wJ3IqZH8PPxIU5lfJCus2Yh6CqxaXjrQsfN3/DZwVs3/kmYOlJt7Y1sPd
         Znug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388903; x=1772993703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=ZNAwMJxo2JZpdZq77s2Fsx3Jiwst6wjIFi4f47YJuOBNqqXWuCOw10EKM+lXct4FLT
         e02Qruo8mx5WaOYNsU0cKjYh5LZUhceUDrw6uY0X/YLBvFo744qwo29U7ufssT70N1Kd
         E+Bb28TkX0yPw5R+NKxiviEE4YsPanN6oFqbm848PRSrodzbtphYg/EsjkRJReupdgP4
         nO2vPxOWDibzI4zdYqTJW9vWDvCvTVZ89X4vPEhqmIeB2IDx6V51KLRWECL9hTY46PWY
         XLc7Qxb52nPgkkB+u5XHXPOOnfIjKluz9bHhdf0bY9ZxV95d/T8ohfE7QkkEWL4FaNml
         GShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfLBeB0lqCBggIglmmpH85Qm4LFDfKGACFOrtE537n3b0Gs8ll6dn+pEQevip4TvrIOHud2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGo+gc010VAzRk0Jm7G/7NQqyoyx3M+tzVf6MAMfDee6jOOct
	XSX7sS9GcvVtFbfY2j8h/RSSv1aks49TB7q/sIxARq3Q/keEYhVHuhYGRVKM0bIhEulKTlX8utj
	hnwBBF353jLpQSw==
X-Received: from qtbig10.prod.google.com ([2002:a05:622a:6a4a:b0:4ee:26bd:e2e4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:57c3:0:b0:501:d6ab:99c6 with SMTP id d75a77b69052e-5075279b9eemr136258831cf.32.1772388902761;
 Sun, 01 Mar 2026 10:15:02 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:52 +0000
In-Reply-To: <20260301181457.3539105-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260301181457.3539105-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/7] net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C056F1D10F5
X-Rspamd-Action: no action

Removing rcu_head (and @mask in a following patch)
will allow a power-of-two allocation and thus high-order
allocation for better performance.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h          | 1 -
 net/core/sysctl_net_core.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index f1794cd2e7fb32a36bde9959fab651663ab190fd..32cfa250d9f931b8ab1c94e0410d0820bb9c999f 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -60,7 +60,6 @@ struct rps_dev_flow_table {
  * meaning we use 32-6=26 bits for the hash.
  */
 struct rps_sock_flow_table {
-	struct rcu_head	rcu;
 	u32		mask;
 
 	u32		ents[] ____cacheline_aligned_in_smp;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 03aea10073f003b0339884ee0f40b8c96d7d22e2..0b659c932cffef45e05207890b8187d64ae3c85a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -147,6 +147,7 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 	};
 	struct rps_sock_flow_table *orig_sock_table, *sock_table;
 	static DEFINE_MUTEX(sock_flow_mutex);
+	void *tofree = NULL;
 
 	mutex_lock(&sock_flow_mutex);
 
@@ -193,13 +194,14 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 			if (orig_sock_table) {
 				static_branch_dec(&rps_needed);
 				static_branch_dec(&rfs_needed);
-				kvfree_rcu(orig_sock_table, rcu);
+				tofree = orig_sock_table;
 			}
 		}
 	}
 
 	mutex_unlock(&sock_flow_mutex);
 
+	kvfree_rcu_mightsleep(tofree);
 	return ret;
 }
 #endif /* CONFIG_RPS */
-- 
2.53.0.473.g4a7958ca14-goog


