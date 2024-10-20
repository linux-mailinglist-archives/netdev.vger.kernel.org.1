Return-Path: <netdev+bounces-137289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3A9A54AA
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068801F21CDA
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717F196C7B;
	Sun, 20 Oct 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2dGPHFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87464193418
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435847; cv=none; b=hbiG6KX3gomIDxnEJ80/ux6zcnsdu+rk+3Q2I9reGb9FSBJHPnCVlC7Kq5ZOPgi5aVRe0IJxhFLnWw8zAAg8134oCGjnGrGtb85HIz/Ume7JXLM420nKTI9aHzhHfi7vf+MPy1GPQIXrJ6BSC4pSSFtwHhv+cGiPdBcohjQ0f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435847; c=relaxed/simple;
	bh=JLD/csVSYHgGmmZVYl32QMDnTjWNecCBPz0i0VquG4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppV1Iz+ymE61ky03pBEUFnZAKDTGT54qQFJ0ZXtmxtDVAT1jCpX1HoplAyLKw3szKr201uCzDMpn+rxWG16XlttU6u3dUCjKb81la0y7eWfoP4a0zHtpzr5kgcAaH/ktXU+gwqTcui9gjlWtfOAT5WN3fZEHyBdSgQZQyzcR4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2dGPHFF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ea2643545so2009982b3a.3
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435845; x=1730040645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sllcFL/FIkdgu3SXusATaZSrDzq9uGn+NmvzZhnA/a0=;
        b=j2dGPHFFl2gS/wa3zqV2ZlkMc3oK5AX8yuTVkbBH9VjvQIxyuJuP8iqnd4x+E8QObj
         wkiEVba2Iz20mAxEGBgdJ9kgj0H3E4GgTVSCL7QQSKIHKAY54SPzW7uEGcrjltuyGh//
         B31C/Ha8Q/puFum7Cm0oAlCmfbCtSqaDKZMWwY34kOgiFBAcunt2hRorshPzkTZ2chU5
         xV6SoWKKVDmB816HHOd52X9dAmXrq1NVkx+scIvQVYtuWB6R571oJNbxeRvApPY2aMM2
         jaD+5jT8d6vL4zHnNE5eo66OwPZBiLtvAF5RxICqBcRzSJ6oom6XmSCQXDFib+fqyQt0
         jD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435845; x=1730040645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sllcFL/FIkdgu3SXusATaZSrDzq9uGn+NmvzZhnA/a0=;
        b=VAFEEA1DfGEzaTHgwPidU87rq251h0eM6h0tHHmyN7u3Lcf+4PywGqzRWO6qsaAXYI
         YvP7cSyK7Xm5gNuc/PHccSzRnR8UYwFFQsGtkN6gKFV04eEpaISoCYizx39wj8aqz+10
         vq2HcEqLv4aLdy0WjbMGdvz7PdMU7Nhsh6Co2sqBZskSLrR++l5hpmKAohrC7EczjsjP
         muhX7A+Zz7CxbZVn8lrJC8sZty9HSSYDXFtHKr141pVto+JWMn1aOfIF6ED00pAI+Fbf
         F0NXJTbv4Gnoj6ygCERYSMxdYf5NWL2out7YAFRPR8rOdmPPxFeyFFvn5QC6tIi8Q48N
         EagA==
X-Gm-Message-State: AOJu0YwuIbHQhkt655TvV1cW4WVTYQ5RbU8YqRkD1BRgOKOAGQey+kHd
	gieiYCjhPxMZeRuYZaYpti7hf1JTchSAJGYNuiMvDvqbNue4jfog
X-Google-Smtp-Source: AGHT+IFOI+k1x53TdcZTXAJlCw3c0P+ZH3Dc4GkLaTw+lmilzNqPSvexDd1/ankVb2rhI1sO6GinmA==
X-Received: by 2002:a05:6a00:3d15:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-71ea3118addmr13416845b3a.6.1729435844705;
        Sun, 20 Oct 2024 07:50:44 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415066sm1243979b3a.198.2024.10.20.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:50:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
Date: Sun, 20 Oct 2024 22:50:29 +0800
Message-Id: <20241020145029.27725-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241020145029.27725-1-kerneljasonxing@gmail.com>
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
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
---
 include/net/tcp.h     | 5 ++++-
 net/ipv4/tcp_output.c | 4 +---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cac7bbff61ce..68eb03758950 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2434,14 +2434,17 @@ static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *s
 {
 	WARN_ONCE(cond,
 		  "%s"
+		  "cwnd:%u "
 		  "out:%u sacked:%u lost:%u retrans:%u "
 		  "tlp_high_seq:%u sk_state:%u ca_state:%u "
-		  "advmss:%u mss_cache:%u pmtu:%u\n",
+		  "mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
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
index 054244ce5117..295bc0741772 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
 	}
 	skb = skb_rb_last(&sk->tcp_rtx_queue);
 	if (unlikely(!skb)) {
-		WARN_ONCE(tp->packets_out,
-			  "invalid inflight: %u state %u cwnd %u mss %d\n",
-			  tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp), mss);
+		tcp_warn_once(sk, tp->packets_out, NULL);
 		smp_store_release(&inet_csk(sk)->icsk_pending, 0);
 		return;
 	}
-- 
2.37.3


