Return-Path: <netdev+bounces-287897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBl6HBadBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E127B5400C9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B55B3302FE88
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668393AE6FA;
	Thu, 14 May 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx2h8XW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08F397E96
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752780; cv=none; b=scI+aMxsEghWf2tCAoLoYY/Tr78sgUiozPHwhzpm76WkdkGSecMPduJ+Ej6m4xA2uP7kMzpDE1w2AiUt6nqwEwc/ECLFR5+CdZ7GF4L3waTBsvYZrxcuSvcnYnwxkkcV0GC2d/b2QB1GNI6L8TIHYuFsYpcTKhUI+Z0qdPHO6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752780; c=relaxed/simple;
	bh=tuECKSlwxvLk0nEzq3OR9Lv+Du4T3CMpkY96MpACm6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7yBcKZb7ERwhbbzO3y3z/zUI7W1JRcpZUQLEnFRhhaLI3j2WdEC/QhVpqC/y/Et63SQsQfGi/0MqMBfuk3fYz4jvMOJ6oRo70wPNLOPpd3fJ4Ba5P1L4Kn9pAfHAmwsPVeK/41ilBUJtEbpcWCSccBMR1sbZadkyqykWfxleCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx2h8XW1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so84415561cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752778; x=1779357578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=80on3zkaW0R4uDbLTKLRM4L1l7RybVe2HOSVaMyLS7o=;
        b=Xx2h8XW1UvXR7jvyTIZRs4OvJ/IPOHShkr82nY7KbOS1Gd20EKdT27QX2FF3/g4tti
         uxLHcn3xzE0vF44KpHkfhnsvioWNo9jEoElVP6gd7tq1aSi+miesytDUed3Fh67bkz9u
         x6JW0MP35rN9Fc7Z1bXOx8KjqTWNawLi0d3rZYfMQrrbGX06Ab9l2QWZySXwPrPaxjsr
         mUSWAzsW4HvVHBaepPSX71/DfKA1VLbh2MPsDeXmFl244V7P68cqncxh8IH3GTl/wCnV
         DrNajJ3+UrLm9co6VpHxDtCmwUW6RfZblGxl5O17aoczRRijDBHZSbZdcHpkxSL6GsNe
         LALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752778; x=1779357578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80on3zkaW0R4uDbLTKLRM4L1l7RybVe2HOSVaMyLS7o=;
        b=cFwZCf18A6sveP0RcshoimSOzXtKURp4PKJiyWuopif8PfdnMeHznK3md5RbLSawEp
         A5C2ALjN7iQ/87QaEzpsE87mFbzrwLrCcXZLB6/MDXdQTdtMNrv7NktXG+ItHXg1BZZF
         oWVROA/u6qefeHPuXb5WNjxZQDVXjokf+YOFjAzvYu/MNfercINCLI8Ndb4iSPVaVGzy
         ICceFveKPlpJ6MF2Sh9bGXQb/9mAqnE8+5dMeS09YWiQlRZXLAvhjpdYJ+8l5pHNZuGa
         1Rg9phisiCT8VnfT10t8LPbRnGryUIoEnR9AyoSAF05RAgh1FI50T5ZWS/OxS6oJD6gf
         jqjA==
X-Forwarded-Encrypted: i=1; AFNElJ8ViyLT/hYRjUQGzcEDeccUDhuDxMguAycx36jvkw7ObyMuPVhuAYRk9Ar+sOoXpRrwqn7yGNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxi5q67EfDU9Ow6TUHcPZHAWs9liORo8UOnPgVDNnm/cBzVEwa
	NLf0lZ3S6KwOy6ni9mFNUWydISXvblJ77SmekEUtWtTtyHm3KKuZYqlnxK9k30R4MZbTivY4dsQ
	baUpTpivyFJQwAQ==
X-Received: from qtye21.prod.google.com ([2002:a05:622a:1115:b0:510:1458:788c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2cb:b0:50f:b13e:b740 with SMTP id d75a77b69052e-5162f437b35mr92903921cf.9.1778752777807;
 Thu, 14 May 2026 02:59:37 -0700 (PDT)
Date: Thu, 14 May 2026 09:59:32 +0000
In-Reply-To: <20260514095935.3926276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514095935.3926276-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095935.3926276-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net/sched: sch_htb: do not change sch->flags in htb_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E127B5400C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

htb_dump() runs without holding qdisc spinlock.

It is illegal to touch sch->flags with non locked RMW,
as concurrent readers might see intermediate wrong values.

Set TCQ_F_OFFLOADED in control path (htb_init()) instead.

Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_htb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 1e600f65c8769a74286c4f060b0d45da9a13eeeb..873337ac1cca28ea1a32778d8e91cacb5bd3af9c 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1147,6 +1147,7 @@ static int htb_init(struct Qdisc *sch, struct nlattr *opt,
 	 * parts (especially calling ndo_setup_tc) on errors.
 	 */
 	q->offload = true;
+	sch->flags |= TCQ_F_OFFLOADED;
 
 	return 0;
 }
@@ -1207,11 +1208,6 @@ static int htb_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct nlattr *nest;
 	struct tc_htb_glob gopt;
 
-	if (q->offload)
-		sch->flags |= TCQ_F_OFFLOADED;
-	else
-		sch->flags &= ~TCQ_F_OFFLOADED;
-
 	sch->qstats.overlimits = q->overlimits;
 	/* Its safe to not acquire qdisc lock. As we hold RTNL,
 	 * no change can happen on the qdisc parameters.
-- 
2.54.0.563.g4f69b47b94-goog


