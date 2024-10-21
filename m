Return-Path: <netdev+bounces-137560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A29A6EC6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA30AB21896
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD01CCB48;
	Mon, 21 Oct 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDyhvPDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F851CCB3B
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525980; cv=none; b=D5t4m21UC7O6nhwgeBqJqVHcvztVOmWNymqrXDKr8cryRtF00CSSchBrB+vIb3j31sQ6vknovP/CKS6rZWbI9F08WmJYPNsIL1w1QakXJ/5ZfvlY0XJYxtte1FA7TEs5uA236hrVQmR+Q8Zj2hyfsankR84s/tpdpgauJbd5P70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525980; c=relaxed/simple;
	bh=bLaPNxW4Qw6IN5UkG4aFXF2UIxCgTmqOjelzn17PAD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RN0HC6ERQaeauwewJ03v2BEKsCproNwV9BUgQtULKlx3lEPf2LYWqVasN5HxW3AG9gILCv6FkzRx4wuyq0BzKy9gIzNnKskTxoorxpYS7u7CUSk4ivDwGSWK1oW9U/El2ILDGLxdSAMTbUEYocCfWoHacAsIa2bydGs9eeeM8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDyhvPDd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e67d12d04so3615272b3a.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525977; x=1730130777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4I+lF/YWvKTTjQgdPWRNPPR+o0cMWvXbTA6bTUlmpU=;
        b=ZDyhvPDdu1yKCUrpomjfs8HFKIiNH8453JBEjAfBPJakmkt23d4vHvf07eLgl+d9NK
         U0v5aAO/YibGBBBkbC8pNjj1aa9z4xGp/LtPEqF6UW7dZmwTTil2rSESrEckVOEEc0J/
         1w5CR85lePr7I80KUVwaD+uUV3vPoU4SeaA5197Xq3rxfkGcwkoPkMHtyGkKl3XWIQWw
         z41syXgVGwQbxGmiDEvxsXmB8zKk3/YkcxISI1rOhgvT/s59s2pdi33B7F+FfjafwP4G
         NcEfyyNKRzvovrsiIacsRE23Q0x0CnlCc78sTCL9PO8zipWyTmrj6SQrMu2kqXUnpAPa
         zVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525977; x=1730130777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4I+lF/YWvKTTjQgdPWRNPPR+o0cMWvXbTA6bTUlmpU=;
        b=g6dqbv00etL9YOQBt8udOA29mbgqTwXiw7GnhZTZA/s7kwth01Gbsepnlxnk5PfZkv
         oeRq8T1jtXEzD6pNv/JpkfQMAH8g5Ewuy7nKHYmAgQx83wSbcmWp075mwDEs7iFLedGO
         6gC3nV2d92ppVl0WWDusPXfquzjM7mhgkK+Ys2t1GWGnZtePD/kP3/3IC6Ffj4cXp3sB
         n2d2wNr5ZOHtm7ZH1Q3ADVuaimk33F4SDguAqkT3ZBVu3WMCoL8ljOeidkwa3DMbg0hN
         8xlUX2NbXRMD780exhw76+FJll1KJw5rWvB3cZb1l+/h71MEfkOUE0y1RoKDqhJklP6p
         KhAw==
X-Gm-Message-State: AOJu0Yz1ONhEEb2kxcbbpfPwr5i8n2okPHZAPNqdji2w4kQAItdrYJWF
	l7DbIQToho9kPNyw3/eXtXHViRuUdoxNskH49DBoz5c7QVhyMnVe
X-Google-Smtp-Source: AGHT+IEqeUGr1KoQG7HSI2r+MnjbgSoCtR55wEgX++MH7OvaBVVfsdZWhKEoldjZv70scM4iZCLtLg==
X-Received: by 2002:a05:6a00:3d4f:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-71ea3333eedmr17837496b3a.24.1729525977573;
        Mon, 21 Oct 2024 08:52:57 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea0ddsm3154697b3a.143.2024.10.21.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:52:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
Date: Mon, 21 Oct 2024 23:52:45 +0800
Message-Id: <20241021155245.83122-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241021155245.83122-1-kerneljasonxing@gmail.com>
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add two fields to print in the helper which here covers tcp_send_loss_probe().

Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
--
v2
Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7Jujtr8b3+bY=w@mail.gmail.com/
1. use "" instead of NULL in tcp_send_loss_probe()
---
 include/net/tcp.h     | 4 +++-
 net/ipv4/tcp_output.c | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8b8d94bb1746..78158169e944 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2433,12 +2433,14 @@ void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
 {
 	WARN_ONCE(cond,
-		  "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
+		  "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
 		  str,
+		  tcp_snd_cwnd(tcp_sk(sk)),
 		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
 		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
 		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
 		  inet_csk(sk)->icsk_ca_state,
+		  tcp_current_mss((struct sock *)sk),
 		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
 		  inet_csk(sk)->icsk_pmtu_cookie);
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 054244ce5117..36562b5fe290 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
 	}
 	skb = skb_rb_last(&sk->tcp_rtx_queue);
 	if (unlikely(!skb)) {
-		WARN_ONCE(tp->packets_out,
-			  "invalid inflight: %u state %u cwnd %u mss %d\n",
-			  tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp), mss);
+		tcp_warn_once(sk, tp->packets_out, "");
 		smp_store_release(&inet_csk(sk)->icsk_pending, 0);
 		return;
 	}
-- 
2.37.3


