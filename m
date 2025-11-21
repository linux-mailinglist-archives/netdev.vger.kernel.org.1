Return-Path: <netdev+bounces-240686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF56C77EAC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8547029266
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379C33B975;
	Fri, 21 Nov 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3FWry0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B430CDB4
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713984; cv=none; b=lLiZbMbyHktOq267/mrD7lRMscOoTub6nNoImQE+QeH5WcPMDatF0hEtFatUTPHXlrZljH0M85h1cKJvPrd9rzfUQD7yIIIaHWZRkUJyIBV4NMvw0nuprxSq615uSqjzXv7Z4amDGQaCiYBnzN+cS56kh5R8+Gp8YTAzCqgvbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713984; c=relaxed/simple;
	bh=C49va+BzgB/UJ6l5+tp/3TPlTRfd/HtkETgoZYhVdLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3bt4CjH0o4KujwdvMfVb/q4y1Hv2k4soXIwBcjh2ULeLpmyd1MtiUIGOXQij+tA2VCxZcxvO8uiDqMwE6zDsORlH3iHDF96zk2LsjtrcqvuMY0a89n6+gQqj8XnPRwQfZWtqA8VqCknYvbXu2+zPaEMd2IChva5BpbeEoAOJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3FWry0A; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88044215975so72542976d6.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713981; x=1764318781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSfhZgnsXkC4+tH2Y1SV+4rnSML6imH1zL/+X9kVqsA=;
        b=r3FWry0ARSAYXl8vqy2U6zdOr4meGPfsrNPfAPGRlA05Iyc/QeJLGdP/g/cbY0XVKd
         uujeEryQTjPKYw89xJZJCY0FO9T2fxbMl6421Qp5pafEKE9GOz2jf53WaIsz4AYEb5M0
         Q9p5WW1zrRH+dXfhpOL3s9Ws2nGCIMXE/8oro/KgGTRMN5Llc4rtULjfbP5yyI1GLkkR
         LUB7zmp1Ww7nhFvEn0c5+FfdFwOYSwfG2CoeIlFQyZrG5EBp2jxMZQuObvrNxV+Hdewu
         FhS4b0zKvHsqvARNvZMQ//rJ/aMn2GDrBhTKJD7QY34KB1zh1J86DfcKgC3TrSHrWVRR
         sPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713981; x=1764318781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSfhZgnsXkC4+tH2Y1SV+4rnSML6imH1zL/+X9kVqsA=;
        b=mOISuEKElPc+wc9v0a7VxAn9rv00nOuFwBKpULtPhlzORBXjYBb4veo+tGg1pxVfEx
         6v6qrAaO5F1toU+/2O4qpEn375Ac5WUTHjujx+6fRVVHId+QPurfRIInPdUXixSCh7WB
         E632Z/QQkulJkZPoiWY4gGjPcZvNvla1xKcEzYZZl8afnVvQnMp9Pn9R9G7IqYS2jc2J
         hgctu4c2ni6TtU2xLdWH+YuvyTDvidf2aS9diGEG1RB3wU/Fv19oD2jan3u0hEJO+vIc
         YD/an6aEyS7KgN0DPUS6D76FjEmU2kemhBwEqE62nOpFDPBaqI5Jjii7QgN41AQO93Jd
         8RuA==
X-Forwarded-Encrypted: i=1; AJvYcCXTOuZ7JDnif1oHuqsj5cqFxPGfPqtAQPDry7i5H98qFbUtoovelEI982TH7J8mUTRMFY7YBuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpKOMSze0wpoeEw3aYHeb+5KQeUMIxudG3ADMzzI8/F9IZygG
	UMZK3D/RSy5Z8fc2ob7kjWUYPzpifWDrQbxTTDmUP2DnVbl4ibjXz0nKKbd5wij/wBXQoh06tg6
	M9FQBhDHO51eW1g==
X-Google-Smtp-Source: AGHT+IHtno7qjb8tzIEsylA2Y5/c+b+ONhNCwGtCRYglrTtWFCQljQAQw4g71XHxfRMV9TPII2bWAIyDg0ECSA==
X-Received: from qvbpf2.prod.google.com ([2002:a05:6214:4982:b0:884:59ea:d79e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5aae:0:b0:880:5409:cb7b with SMTP id 6a1803df08f44-8847c49b4b2mr19330376d6.7.1763713981439;
 Fri, 21 Nov 2025 00:33:01 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:44 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/14] net: init shinfo->gso_segs from qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Qdisc use shinfo->gso_segs for their pkts stats in bstats_update(),
but this field needs to be initialized for SKB_GSO_DODGY users.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 46ce6c6107805132b1322128e86634eca91e3340..dba9eef8bd83dda89b5edd870b47373722264f48 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4071,7 +4071,7 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
 static void qdisc_pkt_len_init(struct sk_buff *skb)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 
@@ -4112,6 +4112,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 			if (payload <= 0)
 				return;
 			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+			shinfo->gso_segs = gso_segs;
 		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
-- 
2.52.0.460.gd25c4c69ec-goog


