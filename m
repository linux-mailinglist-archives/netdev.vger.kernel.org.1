Return-Path: <netdev+bounces-263543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFwOMl+Rp2l7iQAAu9opvQ
	(envelope-from <netdev+bounces-263543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:56:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AD1F9BE1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 131BF3019FE2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F030F531;
	Wed,  4 Mar 2026 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8IvRiTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12721156CA
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589405; cv=none; b=RUkw9GQT8O8BolHaKLQXm7vIjieE/JdtqdxgpcoLbLL0Zl1QS1HcQqreKuBtBetC/Fe/Pa9T4pw626jMgD3/SPxBbDL2Ge6Tkb020WLr0X6up5sTDChRfWln4E94L8zv4HCD6zuhsRXl0vMQxDXuL6tS98oEfO9p81eYATwB724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589405; c=relaxed/simple;
	bh=yy9c6NEKVdXmBGUthHCM0IoQeVjTTmiTse3WyDECnjo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GLEYD5vH9ciTpqsi2AAotjozCjhsxxMUA6NVnnlj2BA+KltV3ByKn5YDMA/2ZHVOIM0EKyX+fZ0TRWnYN6RUSjOvIZ4QQ9AtETXB5FnZSxM21NxMNt7HukwXsf/zor6DCffP9p2l2nvBbDEG5J2Iak5caIEZglu4peGbH6QEBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8IvRiTQ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506c0da79c5so540888021cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772589403; x=1773194203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AuoEPwW5QTT8aPRUAFOSydZ3LlNir/FcjvUC/OXM7zc=;
        b=U8IvRiTQfdmUOwwlir9TtPPmf5eBodsB9h2tDLh9+M5F0+1Z3d3eR2PIcq04glAABN
         9NUl2vksdpb4AH9K6EmfTTyG6H6lbeGOz+6bvIXBLuoG2DkzvyJ/1G6weaVeBN0VgbKj
         4819FSc7zpcQ+WO9QaffMMciXdY8HFAnRJ2rzkCM8AwozDZvwwhsQCNBmLBvxkHBlSAc
         B+z1fpvO/rAWd7UbasBDwQHJnHBkRqtmWam368WdWv9dLXR2jkG5f3IRMJKMUd+NW4uE
         kuYfOQtfpgJVamdXreUwWKtGOcMMUzHfSw9NYSyx5f0c8IPbpS2yY/+zNTNNZq8nKv6y
         0YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589403; x=1773194203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuoEPwW5QTT8aPRUAFOSydZ3LlNir/FcjvUC/OXM7zc=;
        b=WarVkI5da8jmHld5WkZ0Qn1nNQxvbhGUTBBKKVAy7Sw8cku20KDaN9uRAxiA6HlUwC
         GGkaw1BW8kLnV+gT+8tmed1vqrbwP0ce1OjCrtYcqsSTISNwfqZr5s+kkBqpUbaPQhBe
         k0wmVXiXQXyo3ved+rpzlVCxer9x/J9oP6zjJZKMRft/VC9LLY4taQRZblrv6nefOeYp
         OS7FnjRLO+3jZ46UwM3jDROI7jkuS/XobTRZD1dWtz1cFiIpNVa/y89ZKurYjMMIrmpP
         Y6AFCrA4Ya8wqEa8LBOaiX9nmLvEB8e/zCoVwEf00lJAsO5L762LzbpUSffdsVTX13SK
         0A+w==
X-Forwarded-Encrypted: i=1; AJvYcCWSoX4Kev0JJBkWtMD6/jARNpgZMi0a4i2PLB8i8hdbm8AW3J7nQ9KprAkecMgh+xf1S6bDMng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xXK9mQ3pAoPnNIMk5dO/k4XkyOKTV6lR3LzUOhxV/PP+K1n3
	tMMXLy2LKIR6mo5XR/PetePl0dBNw5U07Iwp2IoMoIH3XB0hDnrqu52JR/3rBL3ErIj9t6/7kom
	w55n91LfSMLOyKg==
X-Received: from qtwv8.prod.google.com ([2002:a05:622a:148:b0:506:d20d:b893])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1888:b0:4f4:a9cf:5d40 with SMTP id d75a77b69052e-508db2910a4mr6665521cf.11.1772589402825;
 Tue, 03 Mar 2026 17:56:42 -0800 (PST)
Date: Wed,  4 Mar 2026 01:56:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304015640.961780-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_fq: clear q->band_pkt_count[] in fq_reset()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5C3AD1F9BE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

When/if a NIC resets, queues are deactivated by dev_deactivate_many(),
then reactivated when the reset operation completes.

fq_reset() removes all the skbs from various queues.

If we do not clear q->band_pkt_count[], these counters keep growing
and can eventually reach sch->limit, preventing new packets to be queued.

Many thanks to Praveen for discovering the root cause.

Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
Diagnosed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/sched/sch_fq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 80235e85f8440ee83032f171cf28df6f161473db..05084c9af48e1c7254a695b30293806a8ac78632 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -827,6 +827,7 @@ static void fq_reset(struct Qdisc *sch)
 	for (idx = 0; idx < FQ_BANDS; idx++) {
 		q->band_flows[idx].new_flows.first = NULL;
 		q->band_flows[idx].old_flows.first = NULL;
+		q->band_pkt_count[idx] = 0;
 	}
 	q->delayed		= RB_ROOT;
 	q->flows		= 0;
-- 
2.53.0.473.g4a7958ca14-goog


