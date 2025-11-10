Return-Path: <netdev+bounces-237128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D8C45B3B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5813B74F3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98511301031;
	Mon, 10 Nov 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnmZNnOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25252FF172
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767926; cv=none; b=FezE5hAShd33mPTmwAUh/sAE06kLyIuX2dhaU2xu5jfqFJ2L7Hq55HBva9kBdp5WgzAsC2TkVC0QlDqYozhoWJQFIXeOmeq9n7gut0eG78baCyWpM+JUNMcP8YbHJiKsycTSqDVCNHR1z+/4BeSoeHLfn2iil0x+OftMmVuMrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767926; c=relaxed/simple;
	bh=ymprAWwE/b0TiCIBnOWKaCwTIZBk+tq0AM4bmDCTUjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O+xg0QuncYBTXgr5I5Bj08rqDYQdcBEd26UJqbi2j1rw0h8hTzKpjxWoXBfXXmTJ2plqoF+2a24ysI73B9BscM+NT0SEHXtiMq+erA/RAJNeSggDf9anSAHbYFqHLGTn4Gos/CLAjqjHZrZgUQb7F62IFn8a1DuHnD3QV/HWVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnmZNnOv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-787d4af9896so28527577b3.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767924; x=1763372724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Antq0Ix7QekN+wa9+mZpMxLG9OWYpawCQSJUGVUU1E=;
        b=wnmZNnOvrRWnMDRx99xqXMRFIrzwYait8nmA0+rAJOsV8bCnvg1ybBRZC4halD1/Dm
         XxKOiXvedMlpCHCcR0xGjDUo2KPh3V+bsFdiSmFrvPuw8ws8XrOXltfxBshBeLduCZbO
         XdoNgNBcGdviKZOiD+uy2QUBPz2gqiMr/P5rwqeHp0EKSqWhYB6QAB8sj4/WjDImnRsQ
         BsKR+UJVMOUFfRaAig/5EaethoUFfoSN7q4Qmy2s5MWxxE0i8Z6XuxFzu9P5Ndd0w9Mv
         BKPV7KrQ3ESraN1CZAYtQTSOUgcfR3O/Sve+MwoE+mnm4SU/R9GtGcg8J9g/KlVOuXUX
         Pd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767924; x=1763372724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Antq0Ix7QekN+wa9+mZpMxLG9OWYpawCQSJUGVUU1E=;
        b=wXKisxp/lc+rvwxuh2RYDsyxyAMQW5C2mZHvfzrHkfgHDIMglFV2BM/LhQHa+IHgDF
         RD/dYxZh/g0h+8ClnuxsdtvtvwvjdJ3C5XJA+AOEg5a+2AsZ00tNH9dcn4f/HagqQUmb
         8ufowRWwVW6NN6uj5Cj+jHdWB/3grNJ+0y5QFpd/O+2GjUxiGhIGGdwbYBu/jXI/Zjbw
         qNjzdPiRyBDa3mVE53LeplllRtMOy9EgREmIPHTzhHW8LqMQmATvOFQ7nk5REH1JWX3P
         kDWfjNH+K5fMx0IDC+8kvWoqPSRIl6DWvKAliGf0NnnqQIz7MbxT3mexoKD5yPBZN0Q8
         HHyg==
X-Forwarded-Encrypted: i=1; AJvYcCXeh89VdI/SbNfcBK7GigLxt5u3jIKyQOroO2z/Dj3iQSPVKvSz4Ic62yytiNUGwGAQCpwM848=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXz2u3xC/SV/2y72KCyfkiSupOo6ukVdxnEx47YzGRpeEs8EA
	FoVp7T9xXKhXTOflxufNtAiuDmTcV0k3TmfNrDEy7DTQQvldEdCAhmj7moM4pxPFwrGF/QDpcHI
	L7cT5i/zdB6UTxQ==
X-Google-Smtp-Source: AGHT+IHnzl8+XgvK32Hh1DkI5GzwjeYuRwPpjUre/HD/9cDOFKW3vMkYkeLwsRATVpnqY+ZPOJkFvz9/RCX37w==
X-Received: from ybbei2.prod.google.com ([2002:a05:6902:1b82:b0:ec0:9ff3:8018])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:c04d:0:10b0:63f:b545:9981 with SMTP id 956f58d0204a3-640d4543969mr5108115d50.2.1762767923971;
 Mon, 10 Nov 2025 01:45:23 -0800 (PST)
Date: Mon, 10 Nov 2025 09:44:57 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-3-edumazet@google.com>
Subject: [PATCH net-next 02/10] net: init shinfo->gso_segs from qdisc_pkt_len_init()
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
2.51.2.1041.gc1ab5b90ca-goog


