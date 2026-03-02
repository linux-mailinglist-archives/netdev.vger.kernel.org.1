Return-Path: <netdev+bounces-262777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMk6NaXTpWmvHAAAu9opvQ
	(envelope-from <netdev+bounces-262777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A511DE4E2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92244304A155
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E533261F;
	Mon,  2 Mar 2026 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIIBNsX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785C3431E6
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475280; cv=none; b=uswX5CrRjYJSV/woPkT+IBM5zlL7+wJ+GKm5QxeWLLnRFc/KEW9BjEgINmVdpvxijKhaKylwjwCCsEtN1fVNjIVXcaxnZl1l/LELgXpiEen+calAbe1rI/Pe93buWAyphwjQDD/Hw73jlCr+HOQWto4StqpBo6ln4XH1A6jhnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475280; c=relaxed/simple;
	bh=QTMrbPraPLDxOEIUtWRShfaSnMGJSy5Du5wSxtkUJDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dys3inAYqnVC6ojXzCHVBhEBl7m91vJU+hpxdGwJDfOxL8lIMi24TPTgM8J/53Ya5797543bNxOKWLj3zy8oCg3d984P2CsOzfAUHSdUKZ10H2nV1vPyLLdP4qppUo8TZ7L+s6B99GRnC59aiVwBQrMPJvzHHgvMEHucD2T0ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIIBNsX/; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506c0231e63so575903301cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475278; x=1773080078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=bIIBNsX/WRPaO+WInbnOHjAc193UvAzb6T7bdFfsLEyNUDWc0WV2b6jek1WYbiobTN
         8qP5v6Fj4bmtQ/RVAzlf20xej8DdBh+vrr5am5IGSqB5Omm1aeYX20dd63f20/GS5Ucw
         FYtc+97npxvNgBmcUg1qvYNSj1quVNkLwI67ofFZwNjc1G13B5tEmt93m3xCWZXDsj+i
         8akGGktLeJEfi7S+NWvX8j0Y0/riw4lsoSclW+HVQs9xipHRu6Qt5EtcRNSU7htxN/Gs
         P8/Ejut4B3v6fI520WwOuf3AAIsgu2fjXcHGwRrBygJW2+uxrp4A9NACtcUqHXFMJxgi
         /Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475278; x=1773080078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=D97ZGIweG+sKNY66jBtsRkmWTb43vS85cD/vq4QwHgnBMWbBjph5zO6PKAHFqzD2lE
         9FSVV/OUGR+SSXq4ueNOcaaIl3fpTrXpWQa+ZeikLiM1xWnlKlJqM09/b10ZJeHQgoL5
         4bitZa62zwpW/WbKxLFmvyFiSjNWatZLCwCcbbvu3aXJRos0y/AWuCEmPbiXRalkkQ6j
         73UDGY/ao5KbFLSCScOcLsAdZe4NsbV+ElFhbHOvo1X7tc405B4sLssTXbPZE0HgqQzl
         o2zb8PsW3qmZ1dEgNIx0w6u11pc4y9lvp9XLjaw+w8GXVdKfmVvX+u84Z9qumKYCCDrF
         PQjw==
X-Forwarded-Encrypted: i=1; AJvYcCVM4TGhueweySNqefHs5J4/qcthM02VcF0iavtgdnsIbyE7r53LLGM++suoxbDJM/7lmnKPL58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxscJu8kF2NBcHxoeQzbUMYdyOMBPbJz8HJJ0eePBuomi4GgJXD
	mNAvHF7IuuyTvfDl39S0w8clkYY4Tz2JNn+R5bBpTZqxGb9mdK4Ph6rdVOuZudLvVSs6ekxrGZ4
	aZ1Uu2dZb+X7W5g==
X-Received: from qtw2.prod.google.com ([2002:ac8:5702:0:b0:4f0:2dd:9d10])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:214:b0:506:baf9:5dd9 with SMTP id d75a77b69052e-5074436ffbbmr207320081cf.17.1772475277666;
 Mon, 02 Mar 2026 10:14:37 -0800 (PST)
Date: Mon,  2 Mar 2026 18:14:27 +0000
In-Reply-To: <20260302181432.1836150-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302181432.1836150-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/7] net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 09A511DE4E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262777-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


