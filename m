Return-Path: <netdev+bounces-262078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFbbGTBuomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5C1C040C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BD343058318
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D8733439F;
	Sat, 28 Feb 2026 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB8jtagP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727B3A1B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252710; cv=none; b=t55S9lBVHFSSVTaUdnXjXp4rkER9r8vaXq79oPacMZa4zT/OxxuygEU821gDITniDrhrqCRxLPnIIdjo1UuO4cFUOQKmMMKvPffXh+1cC5RCpvYZjpI4/c1tv/laGKKO/89gQsgoHjPraC1tIKP3thAa/cbyn6RX6Fh91qwbSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252710; c=relaxed/simple;
	bh=QTMrbPraPLDxOEIUtWRShfaSnMGJSy5Du5wSxtkUJDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y39CtO6LPieQj9ef8xWdGyGN+XcT85mHaiH5ZNJoFpBoB/OWExmJ7cSykGGEwXQdvzTh83xkfzIODaWAWG5HmPWx5QFS3uqXb45i1ANHbzyBDTQ4RRhSUz85tZSYGzM2lZ1Bu/+hDrLhnoj53vvqlToHlMFSNAYfMXcff9TyN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nB8jtagP; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-506ab115571so234733861cf.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252708; x=1772857508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=nB8jtagPnPTV2W2+S1QZfVerMUnHZKrzedyzXXqByvyZK9UvZVRfvU8v17rCqEGA4z
         fl3diNixZsBcm7Xt2MiYplNQ3BcusAvnOjmoJTBNIOwO5SN2JNPOZZ1xWGseBQjvqaSN
         Us3W+yyN5ywmGmYoKYH01Uk5tYumQ5sI02YiTMy4PSbOZxCX0UNeC/gCgKi46/UhLFCj
         gZj96HTyHJAX0b1vbyUO2JqZv5Wj2LUcxZ5hQMW4DukFVbOwDQ6Oj7sao1Ak/A6uyfnw
         ek+c816WE7a84FVnWTAuMJtNg9BI83uavdqLcHuxzBklKQUjG6VFYINeUPaSk9M1KazO
         ICfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252708; x=1772857508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++qqChHCxPNceSOgjzDFvaWkjwxttaKgTopHBSGe1To=;
        b=jdr1xIeLPdjZCCfd/zmiN1kqaIpfNriZ2/jPGfiPSYnkNfWw0oNsQ0JaOhF17KM2ME
         bguhrT/7boo79G3vgyj9nBZuOAN5T4TgaayUFyZ6eUu6VGfCKIcfhqNBe1ExkVVQze5Z
         BsKIWxSWel8MhIPJXfXkGVhYnfPGIWDrLDU++TArZiAS/6tH4J15MLZRZvBekIqNRn9y
         +MgNVppvkDT/NH5tcOSN4/fPmBkvf3m4wZk7PFfULfv07IHI2Qy1y9zZcUVfzTL9T4qc
         P6sgDs65Xb2VDHleZRx5DxEnXj9JrCBaFyKQvaMtlqzcPQnHGy9MRkukpTTbEoQId/RX
         sv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVlCMXdvWl2E+/Gino7gTJpblEsJ+h69fXYnEINzuoCm9bc8Er1P4Kh3z8lNEwlq/Y+hd4z/9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwn1l/eDoK04GAv5+u2d9baHFoIgLQUdEp4VsQT4AoqjqGZ5x
	3LVRJxZ/RjXCFiN5plLiHRt4nDZVMCubbAtHXmt6RutH57o2YYEv6ajPIvWplI5t/s1QMQ+Ed+q
	2pRXq7PftzO8N4g==
X-Received: from qvab20.prod.google.com ([2002:a05:6214:6114:b0:899:c7e0:3887])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e4e:0:b0:4ec:f2e1:483 with SMTP id d75a77b69052e-507528cdcb0mr68163351cf.26.1772252708354;
 Fri, 27 Feb 2026 20:25:08 -0800 (PST)
Date: Sat, 28 Feb 2026 04:24:58 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-3-edumazet@google.com>
Subject: [PATCH net-next 2/7] net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262078-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C9E5C1C040C
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


