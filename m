Return-Path: <netdev+bounces-289367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAlyJyozDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BC57BAAD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB11314BB31
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123B47CC78;
	Tue, 19 May 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYehFi5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68548477E27
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183983; cv=none; b=ROwz9TPGCJGHOWkI3NUP7cVJA+oYAsWzhHbyAVQwdQL0hYXzsbGBEkden7zm12V/fLNr5mkxzUVgYVZ8GOr/Cm9emTP4212Zhta2zlUYPs0iqUFwmAczo/gtOsstDIGc+tDJ2jex/Tj9gcNUot2FNdV5BF1vvAZvPtNSDrJIV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183983; c=relaxed/simple;
	bh=Ak5rBO7cWmzF2eSrDjc8qtvF/SdNr0c1rC9cn4VSXqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KimL4ldcSyrS/Z/VbbK7I0TBerYxyLS83sX8rmH282jEW1xW2JsDXrDfEKgIztteVmU2eZb2d9DtwF0eg0AMAOpUN4kipwUl/9VCfciNcG5pj2JrqtyVRR8JMJCTi9rdS47FDiajnVnGaiGHLh/IIp8pUsWZq6TMwaKXxSpkHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYehFi5X; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-90f6c6101d5so836148285a.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779183981; x=1779788781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Jy7T4AYlNjPz7/IipZnsJtYTGon4MGCeYMuavDyQc=;
        b=vYehFi5Xb0j49zAPYyQLnXi84SCMD6Ixhl9SKotiCv9UltlqFxATcrEA1J61hpQEar
         Dn1Fi9TD/JSKVVwVFqugoW9NwBQ1PaA/3FCj/ORxQo/cm3I5s/z2gAOdOe8E+3wuXb9B
         zsEIRg/SGkrKjk4bTQUw2zsw3pW5k0RpQlQd7lPBQpc/nC2EE2S7PMYE9WBUjE6SGceB
         3ywE38iqPOvcXUlND2P51Ty3SeB/LpVu7nt8vHUUY9tWWL25qrIo55o3M+ooKstC3Y9y
         06sdF3jwL6sl1/8u7Tym1ITTJ1MQVmuw3OYkgJ04V+E8NTS4KGGoH03JxjlG5ZodF0eZ
         +AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183981; x=1779788781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Jy7T4AYlNjPz7/IipZnsJtYTGon4MGCeYMuavDyQc=;
        b=PX1c1h1DyU/Uk0fuqaFBZNJ1GyNwj4Huqxc3xZpokSrhFPFye56ToPxH3l3lprUeu9
         7QCMEUHDat635RkqSpu+FmgcTuLHJKhISNWoiV8+Q7E7W6usJh3hS/WzPhgV2P2VuYu7
         Zc95HzR6sw59lYtEpG4sXQtmopfEginojROk8Pym76Uno0S4xPh7EkAXCfWgdAuqjJ4p
         Upq5Y6ka4SMalUKuEkr+RMBlnaDCErZaY7mLnEWZq0gs9olFq/PErrcTkldhaFYQww33
         efmvRbs4zPfZAbOkY7UKHNd02f8IgoowI8/q8pAuouit9Ul7BU+KFdB7uB997otRHYw/
         mZXw==
X-Forwarded-Encrypted: i=1; AFNElJ866kEtJQf2F68WRxJMrr78PbEzD0j3YTCPbV/JkR+8dda7qgoE6pT04hLFGQPB95GoXFzfOfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8yKeoQ5Zr3B0gMb6g2Be5x1kTb92AhZizeEw5zGXlD91Jj/F
	pkrqz1KV8dyURBahhC3Hlvw75L1yDSTgk0WoTKXTDaCoUrRPOSQXmalcyvMdA9OmeZgVXZEkzAa
	SlcmqqhKmhogw3g==
X-Received: from qknrr1.prod.google.com ([2002:a05:620a:6781:b0:90f:c0d9:c6ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2683:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-911cf9e1f06mr2760992085a.36.1779183981116;
 Tue, 19 May 2026 02:46:21 -0700 (PDT)
Date: Tue, 19 May 2026 09:46:17 +0000
In-Reply-To: <20260519094618.2632073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519094618.2632073-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519094618.2632073-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net/sched: sch_drr: annotate data-races around cl->deficit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-289367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 173BC57BAAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drr_dump_class_stats() runs without qdisc spinlock held.

Add missing READ_ONCE()/WRITE_ONCE() annotations around cl->deficit.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_drr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 3f6687fa9666257952be5d44f9e3460845fe2a40..7da8c7c8421b7f2477c7c07d3b5920b375ce029e 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -270,7 +270,7 @@ static int drr_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 
 	memset(&xstats, 0, sizeof(xstats));
 	if (qlen)
-		xstats.deficit = cl->deficit;
+		xstats.deficit = READ_ONCE(cl->deficit);
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
@@ -362,7 +362,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
-		cl->deficit = cl->quantum;
+		WRITE_ONCE(cl->deficit, cl->quantum);
 	}
 
 	qstats_backlog_add(sch, len);
@@ -389,7 +389,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 
 		len = qdisc_pkt_len(skb);
 		if (len <= cl->deficit) {
-			cl->deficit -= len;
+			WRITE_ONCE(cl->deficit, cl->deficit - len);
 			skb = qdisc_dequeue_peeked(cl->qdisc);
 			if (unlikely(skb == NULL))
 				goto out;
@@ -403,7 +403,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
-		cl->deficit += cl->quantum;
+		WRITE_ONCE(cl->deficit, cl->deficit + cl->quantum);
 		list_move_tail(&cl->alist, &q->active);
 	}
 out:
-- 
2.54.0.563.g4f69b47b94-goog


