Return-Path: <netdev+bounces-237517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01AC4CB59
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23004232C1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E52F6187;
	Tue, 11 Nov 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9H7tTYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3C2F533B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853544; cv=none; b=OBAgJIPpYuUpg+qJyWgajfnc/Q/DEvYNFyYODSqe3Oq/71wLGbjt3KBrLxgMONqIh1KzQh2oiC1Dk4TJWsjDKfzDFJFMr1GJObc18qgNdFYWB+M+zpnRxtnB+/nms5e1s3hQrzBjSh1EkYMMVSa/cwfnGhK4aZw8pZrHkB7+Px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853544; c=relaxed/simple;
	bh=mNPKHhAZXcXPpyaWLeJ3O8gXBjYdyzbwd59rWrsloxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dS+AnPH7E0Y4nv2Tsuh1gR2ZlKTprC+u7CR5d8vGI5/hb3NF7K3x482MdMXsmBrp2fVbeZEDf9l2+hrtitIiDe7J7rNcjYVpNGRs4Fjp2/Z3aUVOGC+yXPi/OerRbuooSuVEGe91o78UtLizzSvrBP2Ua9ewC2qp086P/7ZL9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9H7tTYx; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88044215975so140631936d6.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853542; x=1763458342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsUCvmehuzsHgSc1QA/5mwKQR7xeg47UQK015TxHuFQ=;
        b=A9H7tTYx/2mDnvGiyytwxfe+eZRMscj3j5eNzAsPSyaqX7D2F7HmezaQCKnNij7mfY
         JVQcfXZD6gMfncInVBs+WRVtDKEhzL5/iTRAxFK89Wzker3UF00VU9M4lPIrUg2ZHTwZ
         apOztqL40ViclhNDqhoB0lijq0XYTvcVFsBgyzAsv8p0zRfv+Mjwbvh7LuceHBKCrJmf
         iTsgHJ8asXBUyqXK0IIYlJzEcZBv8PNVmnL7Z6mjDwvcckvOvRZhb5V+ZtHOkkBqf0FG
         G1g7jMCc6eGIGGT8cCFHTnH3wySG3nXo6QwRTPrNeWCXi12xhaFBqxva38wLPmbattWW
         kEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853542; x=1763458342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsUCvmehuzsHgSc1QA/5mwKQR7xeg47UQK015TxHuFQ=;
        b=NkBNQHp8kqF8jq7hM0tKTcu+DZGJAEGPyR9UltkIgnC/pOt0XUFDeI89owG8/kUnNI
         ZXHdAhFN4gCabkr+DfuhCmlRqMlgabxedRPZfuHNr2nO+FKigAM6nPFDMwwRJ21HZVgI
         z6hqGMDTQTK/WR5U8buDUKSf2Sbi0QpIE3Y83ougoZjbBAc3/QEy65RYdn6N75uTz8Sj
         lHOZkQJuymG3HcQ3oHgTG1Sx2dHyfFpP2HGpn81Uz2YhWzoNPhToFAeIyJjwyOtTMzXh
         aaMjf48nSMUL7j1M1S06/9duPGRnc6u06k3D9LaSUCZzdJHQROoNHYpRj+23EF03bl7K
         m/3g==
X-Forwarded-Encrypted: i=1; AJvYcCWn5gEQn1nnjJjPgGAy94b+pI0kqg7WhdwJpXxuq4I1RgovTAhh0dcncTfmVMqmawgvNpF6nPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0Mcfnme7Twtlx6ew3uY1QR57ErcmSnpZl70XZC21WQXtqFFm
	zWWzvRoi4nxgzVTGmlMrEe0eHXKs8wsElsJ8eOMd0xAFpPNDDBXTfjTXB9TF00T2NBcuKc8/BdF
	fTq0xkhMRentI0Q==
X-Google-Smtp-Source: AGHT+IF09qG0C+kIFLmgx6aKs4d+Ig5CUpecR6JY6CePHeP2c5yS/2p7CIv5wT3+L2gh+QBQezlbyBhk9UD64g==
X-Received: from qvbkv1.prod.google.com ([2002:a05:6214:5341:b0:882:2f2f:9f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:130f:b0:880:1be2:82d4 with SMTP id 6a1803df08f44-882385f2009mr140449026d6.26.1762853541638;
 Tue, 11 Nov 2025 01:32:21 -0800 (PST)
Date: Tue, 11 Nov 2025 09:32:00 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/14] net: annotate a data-race in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

q->limit is read locklessly, add a READ_ONCE().

Fixes: 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 53e2496dc4292284072946fd9131d3f9a0c0af44..10042139dbb054b9a93dfb019477a80263feb029 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4194,7 +4194,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	do {
 		if (first_n && !defer_count) {
 			defer_count = atomic_long_inc_return(&q->defer_count);
-			if (unlikely(defer_count > q->limit)) {
+			if (unlikely(defer_count > READ_ONCE(q->limit))) {
 				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
 				return NET_XMIT_DROP;
 			}
-- 
2.52.0.rc1.455.g30608eb744-goog


