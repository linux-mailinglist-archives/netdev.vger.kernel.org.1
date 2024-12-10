Return-Path: <netdev+bounces-150445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9619EA430
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A94288B90
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C917080C;
	Tue, 10 Dec 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iZbi2U3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22D4C62E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793647; cv=none; b=jP1U72W+Quzi/dAq9n0ArxZR7CE66JvBOmOVXqqyE7oRTrvPvYjZVRhFC6sdrObngkz0I8xJVuIdv+BN5uF7WWW/2B0TzFrbmnO6iZNou1CZ25H4MivGpGenlHzhPwWosiGFkZO/Mru4kH5KDpAvnQNagNwpU5ETyBqmGuXMYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793647; c=relaxed/simple;
	bh=vEUd0YwkL2bHlHo9bTCIdcaC/JGuoRWcZEmofKMiVGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pp/U9v4ifAizhmqaU89ih3pLZFeVfzFliW/cnmyVdlPpGa6uAazLARayXraoH87orONYmEKJOaXy6WwYZgD6GunqY6srtCjWOcEZ18AWRRzLfy4zkY1OahRGAqs8LBQ1bb2aCssWIX0vD6lpCP0kMW2l0K9sAjG8rOiDZAZNvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iZbi2U3h; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46772a0f85bso6896601cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733793645; x=1734398445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQePnGmxZLFdqSftS1QGw2B4wNUl4Xt9WYqUIVlY/w=;
        b=iZbi2U3hjxX6ZdxFvEqr0YZ9OOVAqFf36/ItT8Rxf2o9EbS9RvqTbXcCn/vQ8J2Fo+
         K8GSq9WOXKm6wPFKS0YdkIyjnRNa9JcugCpsGDAX4Vqn+HcWsMIzQE6UXXEqN21w1IIr
         UMErU/mSOnl/4h5RbYeq/B1HTJOeXyor6NeRyGHuos+sTxyULW76TBOwrUbpUV8DnW32
         0pWlE/BIHigeOZYEZ5Qw9XijWG1pd3kzv5EDpTcxMNahtbPI5rJCnmNpIgbDO9GEb/z7
         yeYw+Ezqy7+BEbGy2VNwjCAoDgw+Mi3Pgf1wBCZ5JELpteuqhAsptr1+2NT7uygR5/Dr
         84ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793645; x=1734398445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQePnGmxZLFdqSftS1QGw2B4wNUl4Xt9WYqUIVlY/w=;
        b=U0aNcQd4e7l4Q8Me7EN3nlular4lNd/X0HK6jeKS0CNMTIxae2REq2eummFbX1GalF
         ytTHWhT0/JEVxka201ryApGWL205bgET/HJND+rbcfiYC69P4Oi9taO9A8PXLli9H6nx
         ZF/mSX1CjMKzYUNnvQ5VdeFFZshcnwt3WtwbNK9mdPdNy5H9z/rrOF/EzhfGF/A86zTZ
         +PRenmrFD+N+Net0et4QCQBtlGDiRqd7VzBC0BNCEQFLYwqvuftA1yeZxp1Q34BAfvvP
         o5X/3A3CBSXzoDqM2JEDyU/0iCYLN9iICMCsyGy1sfUKGxmGIdgXvdpso/j4gAdqwoiI
         zuwA==
X-Forwarded-Encrypted: i=1; AJvYcCW8BfvPq+WShJFgEwLuBx82esQHOGaEqa4eU77ZJvjBxHiuCjWsYmeG+/2I9ddjFxXg1geeuV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCsCiuKwz5PISXBgsXVGHkhIleDKRDm9ifAg6iQ5UznucTGyR
	c0Mm1EMhCdsQ3Mjtg9dvvd6oPn+QL/5DHWdgCPGwtXiJWU+mtzDOgJSFuvJAkUYoMFHLsqrmIPt
	/
X-Gm-Gg: ASbGncvSTJVJ/A+qouIlmTh2vGB6ZJjxnb+4whEXR+qUZpUWLomfMfVFrklyJtyLmxK
	grwdfH3cQMhkRkiYUL8UZ7+F7/YvunkTTTS8kZUG6IM5s7nWAUoBCkZcqZ6PJYuZkt+nuBY7N9O
	4C6Kww3ndDTPlLVs4VnmJ9UCiCABKFkPcAbUgtXOJjmzuWhXOjdx/PODNH2mtN98ZkqlqptcTgl
	ezqJVvZL9UM5JLJfsgvAurgDA26JII1sT1iGTCO+0aaJp2z+ZdelxlTXAYXTkxKzCUHc6FKLfsR
	hik=
X-Google-Smtp-Source: AGHT+IFuk2gSsYsNdvw2Al86O3XxUmuHFbVzcrCJK5DKwqewhln70ZLJf81eA4FHE18IAlnlHjhdoA==
X-Received: by 2002:a05:622a:4810:b0:467:672a:abb8 with SMTP id d75a77b69052e-467672ac577mr91366821cf.5.1733793645045;
        Mon, 09 Dec 2024 17:20:45 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm8116521cf.19.2024.12.09.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:20:44 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH v2 bpf 1/2] tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()
Date: Tue, 10 Dec 2024 01:20:38 +0000
Message-Id: <20241210012039.1669389-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241210012039.1669389-1-zijianzhang@bytedance.com>
References: <20241210012039.1669389-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

When bpf_tcp_ingress() is called, the skmsg is being redirected to the
ingress of the destination socket. Therefore, we should charge its
receive socket buffer, instead of sending socket buffer.

Because sk_rmem_schedule() tests pfmemalloc of skb, we need to
introduce a wrapper and call it for skmsg.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/sock.h | 10 ++++++++--
 net/ipv4/tcp_bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..c383126f691d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1527,7 +1527,7 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+__sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 {
 	int delta;
 
@@ -1535,7 +1535,13 @@ sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
 		return true;
 	delta = size - sk->sk_forward_alloc;
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	       pfmemalloc;
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
 
 static inline int sk_unused_reserved_mem(const struct sock *sk)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 99cef92e6290..b21ea634909c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size, false)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
-- 
2.20.1


