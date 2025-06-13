Return-Path: <netdev+bounces-197663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D477AD9884
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E109A1BC50A6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82B28D8ED;
	Fri, 13 Jun 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCGNrQeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD128F518
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856159; cv=none; b=q/I1CLdawId9XAGFMtPj4UDEgOZTK5psiRXS0Way3L+oxP+dtfxjpQZpMqBBlg9cPuwT2oDSLUmditXojKJbw5sHjgobwikVYLMUYaJyFKyXrtnWGFZrCN2eDqW88h8BSLkL9yUi8S5R+Y5/wNoz2g+jP5ZtpTPCPtRiRjg/Epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856159; c=relaxed/simple;
	bh=IUa6tmFLmY0mgwivBdMOgtmnwT4XmSdvMv51BeFjye4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mootpJ83fIZO/CyM/Mdd/rghvnfxp9DcwKTF66cjIA2Jn719cIKDdFsB6ptbgaEnLVmlV0z4JPTd5yrDydAvDsJgz0IOocKH1PAEBWmfJ6WG4Xo4Q06g0d7pn5ZD0vjxJ/y9Cmr0BIj/QHqyhCwc1YHfWijqXnc3JC0UPngFmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCGNrQeB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d0a659e236so24209385a.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749856155; x=1750460955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2/NUSu+2Hf6jQdQYjeltFUxOb3rhGhCC0PzDNb12eE=;
        b=UCGNrQeBR8dLanIcuqERjJh8O5doYTDzGPu47p1NFz3ml7d//ZxRrsg3T0pf3kg5UT
         y3V/2589QTkQEi7gc9/ToqMpcm7is6iiMc9Q/F5A4BbgkxVVF44q1NEwWGWddulzfser
         Oq1QqdY+ms6T6sTUvkqKFMUmKNEI3w9DIn2TuMQVFMP4KX5rJKiC2qDO7t1j4DYJXnPc
         h/n2kt/yw5A8oHDQk9ht4blf6k3003quaIml+xO4nQkIZcXNAwwe1EtobCUbWlNSdpOl
         goOfdjZqJVUdhnTL7vtK43pvr9ksrG/29UA4/Ae0ytrEhRRIOEOH2cmGrIIikvDtkYAN
         OZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856155; x=1750460955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2/NUSu+2Hf6jQdQYjeltFUxOb3rhGhCC0PzDNb12eE=;
        b=gyK7dQ0ZUKfoZ+JLjfHGHUeYUcmX1oQRSuuFZupm1LsozefvTTGGxE+fXCPnsms1U8
         gzdBzay7XssPcb7uZoAI/wdCnDfy8iVcisayZu6mNtHCvsBJlMIHfmkVWNuikrPAYnYN
         BJHF3ytoNMtFzwOHFgGbkJaL4R0aT0XXnP54Za23rblLJMWmu96pzcdvoX905cC/Ou3G
         acdcJnahhA3PimR0ANl9ke5cOz5RyW2Og05DxcN7E2KwBuCIj6mhIdlOExOAggeZslKM
         X76HuC6OnLknHqI2SSHlU1IUZMYA8eH3T874kLb94lLGj5IhNS5o0l1hVaereh6BaaFY
         2A+Q==
X-Gm-Message-State: AOJu0YzvmcJB2vNT/2JGsyItT4TUN8fZ+8H29DsSxr1JxUCvq7rE0Zia
	l4+E5D6ebH8+T7YorxEyhlJa3dKUIITcbJqUXarb0KH04/2cL4gGxxF8/p1GIg==
X-Gm-Gg: ASbGncsb3xVT5WrqqNw7RrOFJ7MgnyPWNZJb1+U9F+fZsT1UFmxKspWwmdBbAWI3XkX
	QPrmVoGd3JCWk2RpykNu1Y/kGM2Xvl7slsfBozxJGmGhsg0Xx5gmV2ozq+ggdBrbiqJmh/WXQOw
	/Pki+3yA2rbPt49VK7dVrkH6zlA2M4FBjIUxjItmQEBSltr1KR5/ZkL/n10FVBB91Co1g/tvz70
	bjfc8IGZ66wc6ALWVj4qwUosqELj1nnZiKfvlgXlMCxh2EAalf8BK7c86QE5oEc5E1rwc/lFI+3
	Ww6+v7i073G6fVjpLTNn0x4VQqls5waTvyx8R6MlkH/Wh17Gxk2S6I4bCCui3dJREdM/eTbMuAn
	xlFKm
X-Google-Smtp-Source: AGHT+IHCOl2ShWFxQV1PtJlplbUFQBoqV5xL2DrMVZz3eWOesrYfgNc7r+v7fAhgUviD1SetodyoKg==
X-Received: by 2002:a05:622a:316:b0:47a:ecc3:296c with SMTP id d75a77b69052e-4a73c394653mr7292341cf.0.1749856155239;
        Fri, 13 Jun 2025 16:09:15 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:8d12:28c7:afe9:8851])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2f4fc5sm23122651cf.26.2025.06.13.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:09:14 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next 3/3] tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()
Date: Fri, 13 Jun 2025 19:09:06 -0400
Message-ID: <20250613230907.1702265-4-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
References: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Now that we have removed the RFC3517/RFC6675 hints,
tcp_clear_retrans_hints_partial() is empty, and can be removed.

Suggested-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 5 -----
 net/ipv4/tcp_input.c  | 2 --
 net/ipv4/tcp_output.c | 1 -
 3 files changed, 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f57d121837949..9f852f5f8b95e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1811,13 +1811,8 @@ static inline void tcp_mib_init(struct net *net)
 }
 
 /* from STCP */
-static inline void tcp_clear_retrans_hints_partial(struct tcp_sock *tp)
-{
-}
-
 static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
 {
-	tcp_clear_retrans_hints_partial(tp);
 	tp->retransmit_skb_hint = NULL;
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9ded9b371d98a..937a0085598e5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2769,8 +2769,6 @@ void tcp_simple_retransmit(struct sock *sk)
 			tcp_mark_skb_lost(sk, skb);
 	}
 
-	tcp_clear_retrans_hints_partial(tp);
-
 	if (!tp->lost_out)
 		return;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b0ffefe604b4c..eb50746dc4820 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3247,7 +3247,6 @@ static bool tcp_collapse_retrans(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->eor = TCP_SKB_CB(next_skb)->eor;
 
 	/* changed transmit queue under us so clear hints */
-	tcp_clear_retrans_hints_partial(tp);
 	if (next_skb == tp->retransmit_skb_hint)
 		tp->retransmit_skb_hint = skb;
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


