Return-Path: <netdev+bounces-291262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDAFJUAKFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104775C7DC7
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF713028E99
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2763E3C58;
	Mon, 25 May 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nxn4YGEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F03E3D85
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698154; cv=none; b=Ztw6W1edm43PiE0utmVy2j6xOjWeDgAI5a2JHr/tzoqHbPc/h6Pg+wA6IVWGhZaubP9h2XP5FwYFB2hxI2BgFVTLXsp9zS4/Abs/OG/asGaDCTLDjWaERfCxE70RzymrWXDNxA2Ci7taTRtAyA4HlxJasnDF2tJvFz2PyXGJrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698154; c=relaxed/simple;
	bh=eZPyOnyaISQlGNPKVXMe7JMGi+GcIRwMkRCMh/pxDlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I4Wrk8fqWhuYG0u0rDDn/Z+Z5qhSzZRorcv1sKzkqlSl8IffVYdnLvPDwtXT1dQuuJSgMGnHn/1Qxd80Uf8eH48lMdq0Rgk9UVkHOVxtoq70pe2LseO9+J9foyknnOP7NVbks6GaK4NoCBv3miy5hZccciIhLP+WtzRKUgTx9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nxn4YGEx; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516d19f68acso72435361cf.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698151; x=1780302951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcBwwtneFy4Tc84/fYucUS6Vpdis8BttOJdB/vmBd9U=;
        b=Nxn4YGExhOTG34uW9y2vqfq4Q3MqIdh596fIanzgRDov77oiCcZO9MiT/yLOiD5g3D
         8oZkcWjBfpfnjH8f7x+2TRFZBV/zGa62ar4+WFmmEFLrZt2Hr/wYwIpWoIQ7/FSApndM
         OKh7wpHx6F+yIb2ptFxIGlU9Zwjy5gH388IzhlGak1yMwJJK0rJeq8PDJKRcvtfoVHcm
         SwnX5EKXQ4Z3tG68Kt+KY2XScQq48x0bOPRRYIx4j0zRuv7yt0e13PiDvWweJ14L1RaJ
         dUzckIb29QbOa+eiG4Zn/B6z9R7trpagnMuKzKH6B68ELXxPZpkITxoMLZNOFGJQul7W
         VcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698151; x=1780302951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcBwwtneFy4Tc84/fYucUS6Vpdis8BttOJdB/vmBd9U=;
        b=aQSFFiAWzDy4j2gJo0eVTPaQ9cYttYnMqV+3KUYkefhhZEJ80ysOcl8IEUWWOfo82L
         tjsS1/qWFhfWInrcy/r3JvFzWS+4g5EZA5YF8rkKfLZBC3DWDPAq+BfrYLYr12XTzBeg
         uaeuQORjqpYMAYKZyQgugZ7E1c+GPFEZrWBMEuKKGsLxMTOraO/IW2TVjC801Ba3QE7U
         Fx9Zj+y6i5tMNVBXukxO6xYE0FZj1EDAh6rQHBQA2N/3i8bJVwBl/AMrlGHfsTUTxar7
         T+CH89wNF4Q+P5LeQIL6X1x3sE534abfXJtmjFhG9ptOJ3gUwS0N4IfhlRXilNse3fSL
         Sxjw==
X-Forwarded-Encrypted: i=1; AFNElJ+igHFoCzkZevDmGlo0VZinIV55A1R+1qTSnUkSgQkF3jjYCgvKzfUd1FFlHoC6l7LYFirHuxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbHbp9Kg/w24Ra84vmfsxbwGY0/TxGCB5hvwqxSX/vT1fL8KI
	hEYRyE8b7+bQgdJr4s1mduX79Hg4IFqVsDri3DLNhdFCjvr2NseS8duauSEePm2neEaq0TqjKJg
	RFKk6cYUiqaG9dg==
X-Received: from qtbks25.prod.google.com ([2002:ac8:6219:0:b0:50e:6322:ba57])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5811:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-516d4285a0emr202781751cf.10.1779698150674;
 Mon, 25 May 2026 01:35:50 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:41 +0000
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-5-edumazet@google.com>
Subject: [PATCH v5 net-next 4/5] rtnetlink: do not assume RTNL is held in link_master_filtered()
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
	TAGGED_FROM(0.00)[bounces-291262-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 104775C7DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTNL might be no longer held by the caller in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6041e008b22dbfd164ede6d50a77d2db5d7e2e23..0a59036d5f933c5b2f123a47e059036d2a555911 100644
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


