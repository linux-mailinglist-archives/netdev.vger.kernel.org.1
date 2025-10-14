Return-Path: <netdev+bounces-229049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC02BD785E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 471DE34F4B1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052C30E0DC;
	Tue, 14 Oct 2025 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWOmFP5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461C30DEA1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421899; cv=none; b=YOGvaz7blgaB7l+zKJhPCHMz/dcMievLJ2mKozJPI25tljD1nYeHZxELdxh7JgJkOmaYPofkPdK94VcLlMg8dUHLBjDkUwRDyGIApPKdADy1Cgs7ZEmsNNGajjS0MgePCLSigmFHTnm43Cn8wcXw/ZZ7GQUfgo//DY6X8t315rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421899; c=relaxed/simple;
	bh=EDi2Vfmr6DMcd0Dgtmokflpcv7CbpxRKL19zpeZeMXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WVJaIjDwpxPKUryJoWTN8q30MiFe0crF8j5778pcuBaJolzmZKPVP+Xeohc2u+biVQ+o3yI2SQafyXwuzQGTLzOQTapyq+wlQq+DE80IDwLVvzfN/ZRgnhSVTC+Ez+D95+jQ2Qz7uJVk32RorAag2U0LOgNDtzFk/ARG3R4yq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWOmFP5T; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-746b28ff4c5so76613427b3.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760421896; x=1761026696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPNCDJIzcKxMd1XqXNf1X1HrtdQFSscOSVjaL4HJWrM=;
        b=SWOmFP5TeWTE0y2FvEj//LFbfLALE7l2+LZxpldkooxpcpzNUyDZomc7RUPaCQvqR/
         qFkT02QxCPdJcbE2Fmj/vqsNm04lIavdwY0hCRDOC9+7lmENqQys8//Rq6VS4CF569XX
         QbsepjUCS+yG3SqTQaVBJ6dAMVA13zRfDg8BwH2LbCcO1ZGkVEDIgqzo+qhEAsFvKxx2
         KypkQ69U1qkZd/TZhUNVVtbc/aEXASFJoP2FHz9WL66aihiwG0BZZfETB6/drefsJkZI
         +5L1b8u1UEUFKzYepMZoPZuSqsF9DTc/aw6anVuQKbhaiyOAyU5avML2rO8DHuz2VAtl
         Oq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421896; x=1761026696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPNCDJIzcKxMd1XqXNf1X1HrtdQFSscOSVjaL4HJWrM=;
        b=Ju8vUiwB420jh93HnGDuvmS1foHDfT2kRKX1xSwH8F5lA13vmVjuUSaY/Kj3OLUld3
         czee7e9LZG7He3hFFYbtkeSqECRE1JtJW6bFnPSWWvoc0ujizpTQb97/ufnqTSy9f66I
         78BUYxMjht6aBcuN8EOo9Nwr6WGJ2xzYXaum71qo+sHjuww17AC8e0sGjj6V/S9YIlXu
         Uy3rrVg40UO+/V2S+aDkBlNOUoxtEnGBQBMnm1kq+b8aeWjjGV+mmPZkv20vVz2vSFVN
         VYy5uP3A4euwQ/qxj3Voa5Z5YrXS1zbF7okumln5KiiQoTVHt7fxwCDZFewgZpNQk/iM
         8xtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV101MIl1FRvjwWufcwCEGp4Vk4AlEWFiynQTssT9wuLSTvjCBv3aLnApicfN0kKMGZgs67/Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl78WFu0qWzVczSfmi5V3ser1W0oznoNVly7fapDp6FH6uBwft
	SMum/YmyGrMeAx8zNRy1B4q6jcqK64QwgA+ekK3MPo/3cCcyGXfbq6bcBkoaA0XUrHdML80MdMp
	z+3QWdYTkcRHQfw==
X-Google-Smtp-Source: AGHT+IGGjydkMU8y2HBYukSQ/01VRT2Uf2efwwq+fN40nai1KLsLqJyEBgWeZun2RwFLI8tHOX4Cbm0nKrs/CA==
X-Received: from ywbcm30.prod.google.com ([2002:a05:690c:c9e:b0:780:fdca:f834])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:3686:b0:71f:9a36:d33e with SMTP id 00721157ae682-780e17cd77amr255519667b3.48.1760421896521;
 Mon, 13 Oct 2025 23:04:56 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:04:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014060454.1841122-1-edumazet@google.com>
Subject: [PATCH net] udp: drop secpath before storing an skb in a receive queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michal Kubecek <mkubecek@suse.cz>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"

Michal reported and bisected an issue after recent adoption
of skb_attempt_defer_free() in UDP.

We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979f
("tcp: drop secpath at the same time as we currently drop dst")

Many thanks to Michal and Sabrina.

Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
---
 net/ipv4/udp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..3f05ee70029c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1709,6 +1709,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	int dropcount;
 	int nb = 0;
 
+	secpath_reset(skb);
+
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
-- 
2.51.0.788.g6d19910ace-goog


