Return-Path: <netdev+bounces-71904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80488558B1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564C81F20F26
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F1184E;
	Thu, 15 Feb 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWyi1YZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B736FAF
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960073; cv=none; b=ersSZxBiR0Q95vpqq3vNoAvcaty3lBdOH/yf721IvaaAcTmhQkcBCjuGRrw5FxsHNy5vcW1SqMv4lA4/e1Kf5danOyNB9TfDk+O2C7p+RMdEkCg42/ZnPep2zjVXRzBvuXvqWjw/DZFmRkqLnAY/1KwCwHgmh6cL4CWsMbFVBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960073; c=relaxed/simple;
	bh=/N9m4JzzY4Og8houBpM4FYqjNvSreR2fN/mmtnP1Dgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEj+X1HXSyfffFkmKn9kKD6FtiaCrotm2r8b+BpdPivLkDvG6CU1pQzaZJ9+kfOPtYj25BrEBUjbPU4n8ikbgVPpLgzBxTdDbS+/4HthRnWcgxvDYcj0X5Qg7cljRymk5sySGmCqLLYb1sXfSv3Opi4p1n1/+Nf3pfpc25t4ZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWyi1YZd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so335917b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960071; x=1708564871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2kud7U1xCPuFRH3Fod0cdrqRbt0/6Sra3JlljoFMKc=;
        b=VWyi1YZdNzz30bGl7VTX4JUXX8/ofBLHbeUj5lp+TjJ2i6FLN6CpsDrAbjx/D6IqYx
         kmbAvfaCvlanMZMSsU6jZoYK/4s2Zw+RUY2a42m3PpX/zaBAMkPJBlD9tRGS+D/vUboU
         EbUjB3+NtZZ/6fEGCxAGWONk3xwZrS7lX9bw0UO0tuUrLGVFtc4JtllYpMeCHUlgKaLF
         QUV2i24KnuLPAF0i6VM//Cc6U2FzjRj3kQE7pKMSPhNrd9Ma+c2u6b640WEkBziw69xt
         DVitTJuD4yI7agoQqEqNBH/2iiWlmBz/lpNZ2/EM+FLirG9ZfLX52Eh4RQ2u7LAa/bWd
         gZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960071; x=1708564871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2kud7U1xCPuFRH3Fod0cdrqRbt0/6Sra3JlljoFMKc=;
        b=gSRzfd6k5TLX0trODLg68XY/OM3uIvRdWI87oMo1vAfTr7FyaDB1Q96fillRewjsv9
         eU/Q1whBc2fm/r5R+bxBsjEiE3cQptQzXIVzKnOlvfbpgNzfEoU2d0yzbcB1BlcGC6FN
         0va2nRXKQGiv/a0VU/wWGyhUBdeuOpE2iDcVY7RgoRbnIbAC/IhVUkfKYi8Idpg1jyMX
         NkPgOcEWlOYfrjv0zoE3Y345mMCyXSdwLIe0BGyU/BAJ0MrXEfhQALXcFfqfZXfyTduq
         6JFo/Jf+zoThKCmCrMvH07ih2us20dYnG/DcaDh3c2XL3lbS5vC8bQz0Sjdm8nFrmXp8
         wuGQ==
X-Gm-Message-State: AOJu0YwlzVu/SRiklB0ByMKoJp6sSiqtghjKLxs+NZFTjyDvImOC3xoz
	SMoBiDc6bbzWClwb/hSsCNJNGHfMs1uZsNUiq4hyixThpmpfUY09
X-Google-Smtp-Source: AGHT+IHNgR/LoHRDwGN5Qu23390dC45QtlAjx2JpDQcEs8ID7qDpvLH3/SdkZxD/pdH0FYZqGoAcuw==
X-Received: by 2002:a05:6a20:d04c:b0:19e:9a59:20df with SMTP id hv12-20020a056a20d04c00b0019e9a5920dfmr593886pzb.9.1707960071451;
        Wed, 14 Feb 2024 17:21:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:11 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 07/11] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Thu, 15 Feb 2024 09:20:23 +0800
Message-Id: <20240215012027.11467-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch does two things:
1) add two more new reasons
2) only change the return value(1) to various drop reason values
for the future use

For now, we still cannot trace those two reasons. We'll implement the full
function in the subsequent patch in this serie.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b1c4462a0798..43194918ab45 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 				inet_csk_reset_xmit_timer(sk,
 						ICSK_TIME_RETRANS,
 						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
 
@@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
+			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
 			goto reset_and_undo;
 		}
 
@@ -6572,7 +6574,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 reset_and_undo:
 	tcp_clear_options(&tp->rx_opt);
 	tp->rx_opt.mss_clamp = saved_clamp;
-	return 1;
+	/* we can reuse/return @reason to its caller to handle the exception */
+	return reason;
 }
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
-- 
2.37.3


