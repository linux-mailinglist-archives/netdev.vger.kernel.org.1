Return-Path: <netdev+bounces-43026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D8C7D100A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A501C21014
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC481A732;
	Fri, 20 Oct 2023 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGWmxMGv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA681CFBB
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:13 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C19F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cad450d5fso976249276.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806691; x=1698411491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAN9QE6I9dE0JsECENUlQr6m9rIHVhfMuyc8Wyi3QCI=;
        b=HGWmxMGv8o5Ng3JlehD80Ewp3o+gAA6vXe0mCOWdukiJt0Vcd41/luKoeTnar+YK4K
         Pt9UqJjuoariOy/7sNTCEwKW4RNYt8PKR/eqXjoZFVxU2chsA08SbOWGy3Fm13J7nsNp
         wqvD39m2lwtXxIHlDaOV+pQdKS62ESc9GCNoP1u+qlFlIGyPW3K/cKANGs24jO1TENXu
         r9lTiDFvTFyyGTt4x9EneAfvhaRyA5kJNr4QA1lrbLr706u2U2cZMk78M/tpQdn3f5uX
         SEIb4sAlCxpV5QQ6Y0t75FyxEYzWhzPLer4BFYqGvoXNifdl7aBxxis4Cj8a5/sDA2Fq
         z8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806691; x=1698411491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAN9QE6I9dE0JsECENUlQr6m9rIHVhfMuyc8Wyi3QCI=;
        b=Q8USRxFMHZJcp6i7HZBBaRq/ZVAd00/6GegQQ2yGrjQYTP6nm2aGBJEIrnVDeULUDz
         KGb0DpLYyWUiCW4UeaSAxJ0gb0BlLVP0GUVltrBOZUshuCVpG2Tu5I98a93ITzdX778Q
         tL8pAVfM4IruFqSFT2jmjBLis2dT5EnhZldLwPxxhTdctIp3MuSt+CJ8/l0CkjHz/nUz
         xfQYr2hUv+UF1FuDLdXQbquLhH7XS2qcJoeCT1NuG4zY47/lAdAAJzP7I9D1Lb+8V6aI
         JGetrElqe7PX9pf94xIB9E6k7TH0pD1cgHbHNSQ+2e+X4M5H60cul3YIi9OYZmm+CZUg
         G1lg==
X-Gm-Message-State: AOJu0Yx3QX9HKPomuwFtILVbxlBNdc6H3hF8/RJGAbVUTM/LffGPWk7f
	6qYYiI4Z66LcfvdTzyeDtGT9xFA9UPbnVg==
X-Google-Smtp-Source: AGHT+IF4IML+MEWvkv9PmP1gjYo0wQdFABbJgfn4tE10HAfH0pUHCXEIPe6OvU6wllvAAswel+824UqZFOYvVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d34e:0:b0:d9a:e3d9:99bd with SMTP id
 e75-20020a25d34e000000b00d9ae3d999bdmr31309ybf.5.1697806691721; Fri, 20 Oct
 2023 05:58:11 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:48 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-14-edumazet@google.com>
Subject: [PATCH net-next 13/13] tcp: add TCPI_OPT_USEC_TS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the ability to report in tcp_info.tcpi_options if
a flow is using usec resolution in TCP TS val.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index d1d08da6331ab5e1f07baacd7057c7a2207229e6..8aa3916e14f6d09322a2a7e90402129d2aaa40b8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -170,6 +170,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN		8 /* ECN was negociated at TCP session init */
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
+#define TCPI_OPT_USEC_TS	64 /* usec timestamps */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b961364b4961c5f6fada9b2f6828413dfc8307ed..a86d8200a1e861b7c1292f480013c97eea141126 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3760,6 +3760,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_ECN_SEEN;
 	if (tp->syn_data_acked)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
+	if (tp->tcp_usec_ts)
+		info->tcpi_options |= TCPI_OPT_USEC_TS;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
 	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
-- 
2.42.0.655.g421f12c284-goog


