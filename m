Return-Path: <netdev+bounces-224884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84059B8B3C0
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152C75650DE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10422D12E3;
	Fri, 19 Sep 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHnYqVu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EC2D0C63
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314949; cv=none; b=BDdkIQGfA+7nHUG40MUkKONiXg86rhDbVWJag7Z8YuwMDCLjuEChK1YBzlEGrYUWfsvWAjd55Y/G4g08fF3TqtwbhzPfD5lKv4d0esCtajYE2yXVH/W/gUUA9+qu3rjTqEdc/poI5nf+mP7xfDyeSl7z5sfRu5zcflphPucQG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314949; c=relaxed/simple;
	bh=k2ux63TN0UhTVVDpLFfSpi0qi52AHsSP01vOhOm1oCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZp9vAzoL/aMTaQ8aCBDrsS+kcxR+/o2eR0ib33ReUNdQSQOkvvzTH+sEAO7SLJGoJJm6fjZB7VaK31rGHl0/RZCTd3Qvw8DEjVR4mZvWAxcaWdASyao6kbK7VCa+cKbh7HMs3nOgtZB+O6e6Z4gpCvJTOFUNW5keVDW+TMb01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHnYqVu3; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b62de0167aso56871761cf.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314947; x=1758919747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNIIj9/yqTYO7dvBPBVMRkDkj+WXHoI5SCZ9hHRHpqY=;
        b=IHnYqVu3Ly6WrNl9CbwGYbbjQx9eIv3OYbqlhkGala+U+zhUOpG+IzemQZfEqGdSD6
         zWZIMab5KpS3EULsaLZW+Q5V4JerPtjtExZPCf8j9cjtJD55d+NiG25V4vbrTR6vFEXg
         rn5cG3x61p3X28WzK+8coN+o5ZB+4WiouiWWktVkeB2jBz50UjKwwQuJFs6Tq2L6fW9l
         E/q7pYZbGvCftBgkXxBUxTbIe3HJu08wsKG1oYJ3LwnoOvAzYEhDjKw8FhK3m2ZlrqHh
         Q9tGdDR1K2Np8dfpU7/EWBu+M21/By9vI9YbhXQ68Pza4c7KGlMeEdlMHy9qbRvxR106
         zNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314947; x=1758919747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNIIj9/yqTYO7dvBPBVMRkDkj+WXHoI5SCZ9hHRHpqY=;
        b=URYUwbwHKyUyFZVKzU8oMIybF/6nSkFYqX1xtyAVwSYfvbocrGkLB+St21Icob7TZf
         GffbBP9yYoZZMHHSxrIWmVJMPhKJm5LiaOtQdJAHTBMfqovoktAfYT1G7o4UVmMvLMfM
         DkpiYenbBk/0usiT99BM6Enrs+I/0rFhLdhLDd3j0N4pdRxrwUNhtMQ5IeksZhrL4Diy
         +mgtd8W48wdszH/OewGffvV3qFFNtJkHivTF7CjnPBygpNIMdAdHdWWjG5AsPyX0Hlkv
         2pLkZFFOG6/vX7cLxXpr1Ijn1sCyH6o/gf8/va+C5KTiHehp0G4PE+KOMI6FoGV6aWDu
         3lgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZDEsrAIiv+2rwn9JVLGnc/fkNYRFOQN3XcOldH4F1faePUX3zEdR5Pbcax6g0ti9CsySmWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYsc+IzGKYvPGo1fwetvWcZH8/Io/63PCc4PmWN7UX34WAjz+
	UuR8+2I3XWleyMey4j0tk0JnEg4peb558abkxsSp82PA/yxyw+piTUkaVC3D86MZu1rG+kXXIRZ
	YDHtCpIcjRmRh4g==
X-Google-Smtp-Source: AGHT+IFvHy5qwkBNSwxkOsok1UB6hNmCE0HpWrJYYheVv3H5ekMY4dwWK0c2v9rfv5hw1N53iFoi/RyCsOlnOA==
X-Received: from qtee8.prod.google.com ([2002:ac8:5988:0:b0:4b7:9ae8:6e9b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3cf:b0:4b2:fe63:ae03 with SMTP id d75a77b69052e-4c06e7ccf9dmr59812311cf.22.1758314947049;
 Fri, 19 Sep 2025 13:49:07 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:53 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/8] tcp: move recvmsg_inq to tcp_sock_read_txrx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Fill a hole in tcp_sock_read_txrx, instead of possibly wasting
a cache line.

Note that tcp_recvmsg_locked() is also reading tp->repair,
so this removes one cache line miss in tcp recvmsg().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 429df29fba8bc08bce519870e403815780a2182b..c2138619b995882663a06c2a388d5333d6fe54f0 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -57,7 +57,7 @@ u8:1                          is_sack_reneg                               read_m
 u8:2                          fastopen_client_fail
 u8:4                          nonagle                 read_write                              tcp_skb_entail,tcp_push_pending_frames
 u8:1                          thin_lto
-u8:1                          recvmsg_inq
+u8:1                          recvmsg_inq                                 read_mostly         tcp_recvmsg
 u8:1                          repair                  read_mostly                             tcp_write_xmit
 u8:1                          frto
 u8                            repair_queue
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1e6c2ded22c985134bd48b7bf5fd464e01e2fd51..c1d7fce251d74be8c5912526637f44c97905e738 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -232,7 +232,8 @@ struct tcp_sock {
 		repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
+		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
+		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
@@ -252,7 +253,6 @@ struct tcp_sock {
 #if defined(CONFIG_TLS_DEVICE)
 	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
 #endif
-	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
 
 	/* TX read-write hotpath cache lines */
-- 
2.51.0.470.ga7dc726c21-goog


