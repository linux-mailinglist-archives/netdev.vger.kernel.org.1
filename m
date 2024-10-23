Return-Path: <netdev+bounces-138131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1419AC13D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3214EB24C86
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CFA15AAC1;
	Wed, 23 Oct 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA1lFo1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F5153BFC
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671305; cv=none; b=Ml6d5GZ/3pgYuOJAbVsHnkxf/eaWotUw1QMuiFwT72xqydeST7fsxihH4XJ/IWVPmFJuWeM4ZMI5jiKkhePaAl1l190+dpo0OVb7IqIT66O5+91TB5AdIqpR8wdNMhOLL1OU3VrCA6Ybn32NVusmng+r4VqIOHoInYM0KH+LAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671305; c=relaxed/simple;
	bh=JyL7KJmrLwRMMayuDJ9HXC3NVA97DsX7qIjzWmPwPUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbU/RxKXwmoPQqHsyaPgfoyXuvCEeg0TABPFyEDEGSviLnKBAAPi2YC+qSSpO3GQ+s/Bqv+xibwKKaksmYxnjBvsmM/LztXVw5z9RanIYlP6A3FDoKKnil8e8DTZsC/Zg8mKOVbMfqZy/G65PyT1rpKA8z2LAtjSNbDOfN20ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA1lFo1e; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-288661760d3so3586806fac.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729671303; x=1730276103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kotvKiyO7pUmUjvSeAfq2wtPetyDaGJ7qjohyJRt1aw=;
        b=RA1lFo1ewHIQRPKrjP56kV/Khd0vLnPOkA0zLWyipMxnL7dqTh6rZzdlCK7VwkL+GM
         0wRalKUIbPCVb860VkSr3V0tjAJr45424DBYXFaO9c9rqgCCxzkaSOIsk8n3BHeGnVYK
         ZO9oHpvQK6Ys3dDvt3QA+NY5mKO/SklacJxOZXfiL8gdGlBH7e7+Z627LHJzopj6pHgf
         yOvkZsKm9rmghtAUT49wRrMTjxwnzICV2UW7BoVYSgT0DmKalUC5vqZ/ostp1ONsZjzd
         iO1xOJW3EH9acydwGpoQ6ukUDTsKECg6zUsWvZe9pfJUEl55BKddEW937e2F+FU03sy/
         OCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729671303; x=1730276103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kotvKiyO7pUmUjvSeAfq2wtPetyDaGJ7qjohyJRt1aw=;
        b=M+s9r7tsaJvBlD0kbcmDpISFK3NZwimZ2nB6bwi6xVKkdcjCuDWg9sw/89vK6V58fG
         oURMQyhON4/DAUF1bT9TemWqDmHrdh5lMGmQb5/ZSMFw82qVmn7A2V++O5nk+neQj/gq
         Ryxd9l7t8Xxmm7Fg6O0yhOw5XnqkqFuVMDMknCRuz+AF2TXvKjmZszEZ0b8swkv1DYR3
         bZUXOIlZqKqnD2J3AzD0UTo2JXVJ14Pdl61s+zOY8rMvwqcNgT2JhFKLDIjWVNJjP1Pl
         BTlByrVe9Z0QYlmYCyAs3MYobygZli/pB1uCWec9LwOAinQvRQD9vBBbMaXs0OqXqDtX
         FiBw==
X-Gm-Message-State: AOJu0YxwMZkHRRB3CK61lXC8cpemD4SYJVaxuw9RLcNp/vfpl/VIswfw
	3nREcMTpWPSUfV/ZhylilxdXJC9LZqRPWNuhRkKKtVqYVuE+T5wlWPzHUw==
X-Google-Smtp-Source: AGHT+IFrO/pcfB+9oEHp4+4+xWalJfsqHZClAXUQBoVZm9ZoHXjKO1V17XOeocPPWoL/CqbUEDCz0Q==
X-Received: by 2002:a05:6870:8a0a:b0:288:6644:9c1c with SMTP id 586e51a60fabf-28ccb39b1e0mr1886556fac.6.1729671303135;
        Wed, 23 Oct 2024 01:15:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d1fsm5837786b3a.5.2024.10.23.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:15:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net-next v3 1/2] tcp: add a common helper to debug the underlying issue
Date: Wed, 23 Oct 2024 16:14:51 +0800
Message-Id: <20241023081452.9151-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241023081452.9151-1-kerneljasonxing@gmail.com>
References: <20241023081452.9151-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Following the commit c8770db2d544 ("tcp: check skb is non-NULL
in tcp_rto_delta_us()"), we decided to add a helper so that it's
easier to get verbose warning on either cases.

Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v3
Link: https://lore.kernel.org/all/f6e70c8d-b9d8-4d15-bb25-69fbec0d138a@kernel.org/
1. add reviewed-by tag (David)

v2
Link: https://lore.kernel.org/all/38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org/
1. fix "break quoted strings at a space character" warning (David Ahern)
---
 include/net/tcp.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..8b8d94bb1746 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2430,6 +2430,19 @@ void tcp_plb_update_state(const struct sock *sk, struct tcp_plb_state *plb,
 void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
 void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 
+static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
+{
+	WARN_ONCE(cond,
+		  "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
+		  str,
+		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+		  inet_csk(sk)->icsk_ca_state,
+		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+		  inet_csk(sk)->icsk_pmtu_cookie);
+}
+
 /* At how many usecs into the future should the RTO fire? */
 static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
@@ -2441,17 +2454,7 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 
 		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
 	} else {
-		WARN_ONCE(1,
-			"rtx queue empty: "
-			"out:%u sacked:%u lost:%u retrans:%u "
-			"tlp_high_seq:%u sk_state:%u ca_state:%u "
-			"advmss:%u mss_cache:%u pmtu:%u\n",
-			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
-			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
-			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
-			inet_csk(sk)->icsk_ca_state,
-			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
-			inet_csk(sk)->icsk_pmtu_cookie);
+		tcp_warn_once(sk, 1, "rtx queue empty: ");
 		return jiffies_to_usecs(rto);
 	}
 
-- 
2.37.3


