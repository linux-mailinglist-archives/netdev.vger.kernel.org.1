Return-Path: <netdev+bounces-224521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18292B85DAA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE789E0719
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F317315D42;
	Thu, 18 Sep 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bkst+fbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38E314B8B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210939; cv=none; b=Z6L53JS854lHUi+4B3q8sEILZ4OEJyuZ5MC+9hO5P9GL1rsl0ODxDB/e0ilepAw053+9rpu+99HJt+z7HJuftdD1QXo66OdDiRgLVwoYPNW0JiwUV4ga923towK3Qm1R/NO92YE2FXnV3BL2Cnjkwt+0LhTQcms8bBiJJJXYnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210939; c=relaxed/simple;
	bh=BP51XfxjrF7l1/Z8YIMblZ1YUozYtIpSXjuXw7CRc58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FL4XHOOfr4LZ2geLbah63HN81D+MxWOeal62khdSxFsvM+shjSeSlEGbBasrXX1CABe+WTfKD7o+QuqquBfVgS3Gv2ohzFttpxkRnVK10gYApB31aEM9fjKTiao4M7pSOEP2m0biq10XpARBOhSHkh1Fb8baq7D/JXdN0sYY8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bkst+fbw; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-83622c273f1so129806085a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210936; x=1758815736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaAJ0kIy1R6f/5QxuMrMxsPW8QxEi9J+NlZXhf0S/KU=;
        b=Bkst+fbwS9lQlkCP9zuyR5QqKSKs39hY4BAkrr0isgvULkDsyQtkaIbbWiZfP8XQ71
         /96AgP1ATCxnU6VFAalQI9a3m8E5cXkAfhsoCRj/2MRVvqHyVsD7EitYkLmNOuZQuKTW
         Zt2O5uEz//w2y/GD4PsOkqPTBJQbVfQCG3378gcFIxrI4BT8HP/CWFDlo5UlAseKeX45
         jvPnOgWPPkYpUpY7V0DxTz4DMiaPGDS2aHyk39cMAshehopLgDoBT2onMSMPtbRSu552
         avc2IXCdFIJXyDMO9h/F+ylUy26rSuPQiLp1xKFeKekep+cepfsb73ea3GBWYxa7xkbO
         XR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210936; x=1758815736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaAJ0kIy1R6f/5QxuMrMxsPW8QxEi9J+NlZXhf0S/KU=;
        b=fMnb2VegglDgAvF4OpFZ2lcGG27x/c1GpIS+EYflvflbCNl4B5i36/U52m5GOVY0cY
         7BWyRWa7O8b6FAQ93DPCl4YFEP2FbnndeHGnOPIhgsSFh9zxkVkkOO6+Ey7PAM7z7qji
         rsWWDW8Ibo6uKqqHbqXtPQ9JErjtKIVLUrqkLYLweDs6oROkzglqRBtqDEkhzmQcM1FG
         i06xJhmH3TrG0AzYONFhRKWYuRV7ir6D0VkES9NRwVnITNg7Fbt5hgc/3eT9zbFAlpeh
         H+uBon8AwNaxHcj/BcrL0UGLjxoc4eZlHgVmtvvFXzYpG+wvcIr8gjunaNIKob0ARQOY
         OLHg==
X-Forwarded-Encrypted: i=1; AJvYcCU8isoXmRsaGzfnPIUQBiyBH4C7do9hGxwumLNvHLdku64eju7ZmFWMHL9dGF0MsFRUlQT7dys=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmCVwAuxoet10Ct/v6JE9TWF8WzTPrnmWceufvkR7kfLTyV2g
	WNMVD/E8EHlXT9T/OP6T7vAzYwBDfz4Iq0/V9u8HRtxxgjEx8lE0xbMmiMeICvD2mgor0uhFlmN
	9GIqmy2BV9othVw==
X-Google-Smtp-Source: AGHT+IFzn6BnITWKZNJmamoN3LV3pvgdCJtGvj9gVNtUImG1m8U5edKIPZDWxgf6Zra4nRmQ3k8yR1jRF8EDVQ==
X-Received: from qknpz13.prod.google.com ([2002:a05:620a:640d:b0:827:66f2:d271])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a83:b0:827:3325:1209 with SMTP id af79cd13be357-83babdfdbb0mr5286285a.65.1758210936374;
 Thu, 18 Sep 2025 08:55:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:27 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-3-edumazet@google.com>
Subject: [PATCH net-next 2/7] net: move sk->sk_err_soft and sk->sk_sndbuf
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_sndbuf is read-mostly in tx path, so move it from
sock_write_tx group to more appropriate sock_read_tx.

sk->sk_err_soft was not identified previously, but
is used from tcp_ack().

Move it to sock_write_tx group for better cache locality.

Also change tcp_ack() to clear sk->sk_err_soft only if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h   | 4 ++--
 net/core/sock.c      | 3 ++-
 net/ipv4/tcp_input.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 99464b55c8fcd1fe62dddae5bc686014fbd751fa..b362b9270c0b21f63b5ad45685156e1a75168e73 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -467,7 +467,7 @@ struct sock {
 	__cacheline_group_begin(sock_write_tx);
 	int			sk_write_pending;
 	atomic_t		sk_omem_alloc;
-	int			sk_sndbuf;
+	int			sk_err_soft;
 
 	int			sk_wmem_queued;
 	refcount_t		sk_wmem_alloc;
@@ -507,6 +507,7 @@ struct sock {
 	unsigned int		sk_gso_max_size;
 	gfp_t			sk_allocation;
 	u32			sk_txhash;
+	int			sk_sndbuf;
 	u8			sk_pacing_shift;
 	bool			sk_use_task_frag;
 	__cacheline_group_end(sock_read_tx);
@@ -523,7 +524,6 @@ struct sock {
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
-	int			sk_err_soft;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
 	unsigned long		sk_ino;
diff --git a/net/core/sock.c b/net/core/sock.c
index ad79efde447675c8a8a3aafe204e2bbb1a5efe7c..dc03d4b5909a2a68aee84eb9a153b2c3970f6b32 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4452,7 +4452,7 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_sndbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_err_soft);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_queued);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_alloc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_tsq_flags);
@@ -4479,6 +4479,7 @@ static int __init sock_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_allocation);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_txhash);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndbuf);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_segs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_pacing_shift);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_use_task_frag);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9fdc6ce25eb1035a88ff2640601cc665187a78b2..f93d48d98d5dacf2ee868cd6b2d65a396443d106 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4085,7 +4085,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	/* We passed data and got it acked, remove any soft error
 	 * log. Something worked...
 	 */
-	WRITE_ONCE(sk->sk_err_soft, 0);
+	if (READ_ONCE(sk->sk_err_soft))
+		WRITE_ONCE(sk->sk_err_soft, 0);
 	WRITE_ONCE(icsk->icsk_probes_out, 0);
 	tp->rcv_tstamp = tcp_jiffies32;
 	if (!prior_packets)
-- 
2.51.0.384.g4c02a37b29-goog


