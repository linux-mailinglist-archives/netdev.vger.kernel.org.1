Return-Path: <netdev+bounces-290899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NKpAt+VEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33135B8739
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FED230FA0EE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC662366542;
	Fri, 22 May 2026 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Knvj3zFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F738366560
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471013; cv=none; b=KpleKsHlf5XE51wX247rIjwDqnXEO/iHZw67pBTuJlrYiVgKaTNP/mucxNG8qJM8TtupsYw3xtuzykYNb6vDsfq5s8c5QWvKl5LpNR7kXN624kWRsJj24FRQZBOaKdH2CrCLXIqf4qaLOuGQxP6sx3ImLscZ5qmrEjGPlmpayQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471013; c=relaxed/simple;
	bh=y93T6R3ZPaoHK8S1fzJ5zBOeWQKcY8DLsLD5LRPVkmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5bkOKp5LyRQebSMKaULHCZfSxaZ/ZrNAmWz0Sl3DHsUxqtV40qqRXppbwiNGEVaf0hoaa7xTlw55aNVJ/uma+HuGWljlbJDSxJji5vIoMUUDnzKh6CW+SWxwg7bCAd6IFHUgq/wW95HW/9Wva78Vd67VpzEk8QE0F22SsevIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Knvj3zFk; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914b11441aeso254483185a.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471011; x=1780075811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpHmmZYZTmVF1LVFIqwlKvtmdWVBJK/BRseLdxPSIGE=;
        b=Knvj3zFkHg7CJMHA2GdQ/fhpeGK2Hqhxr3HKzVpc0V4MuvMIuYNmj+ihSfSbsI01TX
         iSEaAjPt8W7/bGgfroxUOdt+QUG+IHBk52yiWaUku1bgyZijcygXP2tF2n5jtdRLqqFR
         +/cRDqrJ0wLgogaxtXwzuEtY0Cl0BnJKhzOHQiRtHDLLkd8DDoETCf0VbzFbU8goV1dh
         Z03i4tJRdAlTiONLErvyiYzySb7UzOyS9IgYzcFFbUa50oqHnsy7N1HRe7PiuUexGvnM
         sQzwuF4sI6I6/WON4FdVve5kPGoaDljkEm54lILNj4p0h9si3pNt2HLwx8C/delpez5a
         SB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471011; x=1780075811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpHmmZYZTmVF1LVFIqwlKvtmdWVBJK/BRseLdxPSIGE=;
        b=S0UMFsrGQALPBYsPka3gRY/Dl5b3kHHWeuWJW/yz/kR4C0lO4Unnq/eaGWbs3dncBh
         0N4PRmt6ZMd5wlYGr3foCwWPtxveaxlpt+Dj+Juvu0mU2xAKF1QP81p/V012qLn+J9hM
         5i/dWxeHJ17O6V+CzHubS/RQU+ybtI9JmYmcq+/dcYvZt7Je4hLNwmeJ+0y/aNwl+Fnf
         Oqsv8eU8wkdmWFVtAB2laRhvN0KReuO2zkDiHgKhWJnLrXtPgVFVYIwbMJs2jp587maE
         xuqkbbS7W+8xRL22astBZ8Ee9IJZ4mrNl9YDXdQtfLYdX16B5IufGUMuLxkwBDLWHZpX
         xurQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7g5YnEWPcRwO/u3BeqcqhJ9lUWxGdkns6Lgmvs03dktH/Qs/9ssqRSu7/WE0vCOsg8AP3jsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamGh9GXLqPIcBr/3cdZG6kOfO52gtVb/hfLk1BtO8mMUXvRYa
	rXRshGVufkaXQww7aVybjkQrA9s7y/gR1cqEGaRqF2BnikZz12QcjWd8s0qAZnKD1yuVtK3gZGx
	k002M6/pXTzTMgw==
X-Received: from qkkp25.prod.google.com ([2002:a05:620a:1139:b0:90d:670f:7021])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:390e:b0:90e:dc5a:c07 with SMTP id af79cd13be357-914b48d66dfmr696579185a.8.1779471010607;
 Fri, 22 May 2026 10:30:10 -0700 (PDT)
Date: Fri, 22 May 2026 17:30:01 +0000
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-5-edumazet@google.com>
Subject: [PATCH v4 net-next 4/5] rtnetlink: do not assume RTNL is held in link_master_filtered()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A33135B8739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTNL might be no longer held by the caller in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c342b22528e4478a61f22e204a3934ba1a48cb3c..bad036ef7614ffae52a65c447344ac1314f5521b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2371,22 +2371,24 @@ static struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla,
 static bool link_master_filtered(struct net_device *dev, int master_idx)
 {
 	struct net_device *master;
+	bool res = false;
 
 	if (!master_idx)
 		return false;
 
-	master = netdev_master_upper_dev_get(dev);
+	rcu_read_lock();
+	master = netdev_master_upper_dev_get_rcu(dev);
 
 	/* 0 is already used to denote IFLA_MASTER wasn't passed, therefore need
 	 * another invalid value for ifindex to denote "no master".
 	 */
 	if (master_idx == -1)
-		return !!master;
-
-	if (!master || master->ifindex != master_idx)
-		return true;
+		res = !!master;
+	else if (!master || master->ifindex != master_idx)
+		res = true;
+	rcu_read_unlock();
 
-	return false;
+	return res;
 }
 
 static bool link_kind_filtered(const struct net_device *dev,
-- 
2.54.0.746.g67dd491aae-goog


