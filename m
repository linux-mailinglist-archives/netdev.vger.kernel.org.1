Return-Path: <netdev+bounces-237516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C7C4CB4D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31843BB8B1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52472F5A28;
	Tue, 11 Nov 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZ9ROC8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4312F5305
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853542; cv=none; b=OVRdgkI6nMRMbl4gUZOo/26HKMoAoa0LDgrG4oSSQmB1SgYnmQiqm+C17Hrj325b+jVuBzsaM1aQc037V7fGFAQso/N5ZBKYR7ACll9Mpql9gtGFxyx2VT7GD9zkCxT/kDbwJspWWZb2P9XF9NP16Y+Z5nRa8traT9kQwAm2AQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853542; c=relaxed/simple;
	bh=YlGCisQT05aJAItXMiTYZKPqCVHGJL/3PXO6JYVMwfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYofTs7W3wAvdLL9O4oJY+Ykf0Q2fDDWl4lJCUMLUNbjVpunkF77IgHJCIMsbJdkWg7whlx8BMg+EgRSx+KRMidMFLydGDZ3d2AiKyox0jJKUJjEvgZ6RFdVnsZ4AEIDozdEPMuXxY2Dq1HQyLSthoUbs3i2fjF0JFVzQ/60GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZ9ROC8C; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8823acf4db3so84246946d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853540; x=1763458340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GK0vmIwjr4MslVk0YIFp9b/docGmo+D7d9cD85NwfA=;
        b=MZ9ROC8Cg9bM23QuKdB47GGn0XJjZTdqUMXCf+oXdDF/JoswHN5v9CNeybfesqsFAW
         Jn8IlQ6zQRNWODlFzPj42hepC4cK41QE/PTtV4p8F8Qa+3eKB78rcnBGdhCM03MbAE3H
         Nb5RTjSNqrdywirwIQMBvUVkDO7MPr7zK1Djjsvzog6y4Jya3cP7RNYXKCDh6wCYlqQx
         5plbh2Hw1sI4RnwPC5ztlKrvdWUuD3g8aYzNhev6A3NsEnmL184i+obr0hhxrAxSK1mL
         EnkDjMC2PSpTT5UNIVM8gIZbxQ3fT+X73EWeq6RSYM4ek4ez+ch/if3Ow4SOOyHBcgiw
         nHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853540; x=1763458340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GK0vmIwjr4MslVk0YIFp9b/docGmo+D7d9cD85NwfA=;
        b=kbcEw75/MneHg9sJGEMGh6SdV2tpfVEyvbMpEd+UWYHT4w5mGy9mz+C+nuB8s8jYQn
         CoximtW5TSizOUrNHydEVNVUbK0MaG4sf2uw3ZPrKbudMt3QFGXSRcXbdtgLBpoDzCdp
         bO9RADVoQwFvFQlPwX1pKchzm7Z3++Ns2T2Z0Vvn2qRJiPxp+T5y6VDLcGDwirRwOAWL
         6WbENPCA3ptB0/rKFpbrME/kFzM5oCJelBvQEy9P5Z2qrPpk6V0yffu4Ek1mpZISoS0D
         R39m4+eIRvsAcDOA9BDZ+USPGmEHs7/lEKfXBu4kKwg99k8QGt74YdogNko0Lknz1Ql2
         CGzA==
X-Forwarded-Encrypted: i=1; AJvYcCVhlGYi1XFukbNcqPZArV3dxkpT8/ZELj2i5kNOPyXsa4bnSeDCF0dGmbC0OT7mI7NoLyVMXgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZBlxOXLIDibxo7dWgtHkaVLsE7NQxvnYpIuYoKToTYOln1eL
	Icm4ke27X7q8wnnTti4xdv3nLwx2P5sGhqLPWr1SaeXfKZuAiNLXH0s5rgW+49Dtc296jw0muJb
	O5G9WAKpFkJNYfw==
X-Google-Smtp-Source: AGHT+IGA2IiKce48bxA0nALqX+MM7hf+wzyih4qGPuqg1oQq/IibmTqroJJrI1J5rTbL4Ds7NaO0gPRmue5bWw==
X-Received: from qvbri3.prod.google.com ([2002:a05:6214:3303:b0:87c:4bb:5d6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c67:0:b0:798:acd7:2bb with SMTP id 6a1803df08f44-882386e2f2amr140251806d6.51.1762853540060;
 Tue, 11 Nov 2025 01:32:20 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:59 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/14] net: prefech skb->priority in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Most qdiscs need to read skb->priority at enqueue time().

In commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
I added a prefetch(next), lets add another one for the second
half of skb.

Note that skb->priority and skb->hash share a common cache line,
so this patch helps qdiscs needing both fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e19eb4e9d77c27535ab2a0ce14299281e3ef9397..53e2496dc4292284072946fd9131d3f9a0c0af44 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4246,6 +4246,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
 			prefetch(next);
+			prefetch(&next->priority);
 			skb_mark_not_on_list(skb);
 			rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 			count++;
-- 
2.52.0.rc1.455.g30608eb744-goog


