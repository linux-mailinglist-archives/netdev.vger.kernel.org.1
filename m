Return-Path: <netdev+bounces-138132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83E9AC13E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB811C215E0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECA153BFC;
	Wed, 23 Oct 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt5fnLjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1C15C13F
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671308; cv=none; b=H2oF/xvZGSSF7G63MFHKzS0lM0YPUI9QnYSIoa+Iud5+DGI31SFxF9ljTDewtZWgmPRvLNZ6tIv2/+4SVaIh6gTWH0Yiq2pedin6chv0rZJCxjGwQyGP1YkVW5JshtOuUvD3GbkUyft3Sj35fL9R7rhmrSKJc/7+Dsyh6aLaeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671308; c=relaxed/simple;
	bh=TGV+TDsctUgneUan+to+MWzX/iPyiUeA4AKWokegHfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdqo/UczBg29x8UBl3QJMh6/CkMWjoSCKMksYMotxf3I3rCGbnOWXnPX0ODPUGMv3end0w0EL4Jg209Nad2xFISQIrR2icw00T1bETbXvzyiHkYs2wllZFIu8kfQ9MGZI03EuglBtzcQHaxgwpWZhcLoo9EJI8XUpGxmc8ICqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt5fnLjb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so501614a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729671306; x=1730276106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3lDrf8nMbheae0kI9Cq9wDU/qv8Sa2XrwC1/t0b94w=;
        b=Yt5fnLjbOjxtsHaa8aPKa/yWunA8DZPIb20u7BEPnZksFovy2lrD6EktG++qailTMX
         w7ILKL69HzT6wqsdfoNhOZcZt1iczSJF1f7db2aFQFnFjX8jMZGEtOfI73Ck/rBXo2ho
         VItI/KEjRWZ+ZYDNy0sTKcIV0xP1yIYZCaNl0t/0GX+Mzp3jdOU5PApykqM0T2i9RX+C
         7MpfgBYq49VdsOJiING6InpdaJHfgZ0yT6gENB33zY+aEVpfS5Rb3LVlm0CACNQkhDzf
         9EIGiqWWnnpNvaJQCyHxhEozT0IBpKuWuo3Xs+eaNxrnRTkj81rI2HRuoBd6dtUVQ0KS
         wVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729671306; x=1730276106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3lDrf8nMbheae0kI9Cq9wDU/qv8Sa2XrwC1/t0b94w=;
        b=MdvG2JbwmJAZ+2JCvMchnf7P+ZYGRlBuF9QGHZ83ZMODgmYSJVDoIzOGJnzkBpGi1h
         wGiTHKLyLzbV5jo1fQ4ljJqGkmbRMWqAtsGM00otbhtV5ZHfB4NPHUKyffdFdGW/qCAg
         YsLFjjJOX9F31SailiSxEzCrDcDUBBooo1XJZ8Qvwf2Z9yhhj8MdUCR2V/cO1Vja1hes
         R8iHgeisYTpmpt4byJ0z1we97mbSqffzEbeGzYXaiBGRoceVzBIE1SxTxeoWUAAexGNe
         BeU7JvDjoP6HSbAy3jNS8oo+5y98eeiIkQmhDbjCyjo4sIHlyqIpe4zz0nVmDPnHDITJ
         Ee+Q==
X-Gm-Message-State: AOJu0YwZrxEqdTqgWUo9pTnW88V0cQxlcbt3GNeJyuenus50xOwkdE3b
	P8TVa7/pVw4SNK3SkyA7ODj5AXn4W+lq5G376qD2qn/IA2GKuibV
X-Google-Smtp-Source: AGHT+IE+vKPLhg1UzhA2Ko991QH82Cxc/X7DJX+l0HqsEK1jHh23tAoIvRqu/5He/Ed237uPn1QU/g==
X-Received: by 2002:a05:6a21:78b:b0:1d9:21fb:d31f with SMTP id adf61e73a8af0-1d978bb2aacmr2016659637.45.1729671306036;
        Wed, 23 Oct 2024 01:15:06 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d1fsm5837786b3a.5.2024.10.23.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:15:05 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net-next v3 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
Date: Wed, 23 Oct 2024 16:14:52 +0800
Message-Id: <20241023081452.9151-3-kerneljasonxing@gmail.com>
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

Add two fields to print in the helper which here covers tcp_send_loss_probe().

Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v3
Link: https://lore.kernel.org/all/20241021155245.83122-3-kerneljasonxing@gmail.com/
1. add missing string "invalid inflight: " (David)
2. add reviewed-by tag (David)
3. remove tcp_current_mss() due to possible change happening on the socket's state (Eric)

v2
Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7Jujtr8b3+bY=w@mail.gmail.com/
1. use "" instead of NULL in tcp_send_loss_probe()
---
 include/net/tcp.h     | 3 ++-
 net/ipv4/tcp_output.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8b8d94bb1746..e9b37b76e894 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2433,8 +2433,9 @@ void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
 {
 	WARN_ONCE(cond,
-		  "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
+		  "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
 		  str,
+		  tcp_snd_cwnd(tcp_sk(sk)),
 		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
 		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
 		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 054244ce5117..5485a70b5fe5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
 	}
 	skb = skb_rb_last(&sk->tcp_rtx_queue);
 	if (unlikely(!skb)) {
-		WARN_ONCE(tp->packets_out,
-			  "invalid inflight: %u state %u cwnd %u mss %d\n",
-			  tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp), mss);
+		tcp_warn_once(sk, tp->packets_out, "invalid inflight: ");
 		smp_store_release(&inet_csk(sk)->icsk_pending, 0);
 		return;
 	}
-- 
2.37.3


