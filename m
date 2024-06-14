Return-Path: <netdev+bounces-103599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863D908C3B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A1281EEE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958B190477;
	Fri, 14 Jun 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jgY/LjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15E14885C
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370380; cv=none; b=AlsG1qsuZIPUdKd4uNoGkrRBGtR9ruQpKWvWzVSLS3D+m1YJ3sPCLUDI9YpBymVSseiatp+Po0FHDlQgxJe9+/SqRBXP/BLZHjL4OWwsEINBBzd6PAc2IZ7dLTvprTcPRpYYVLVnq7SlsSu9PywikFsq+ESmSmy3P7waOMOPrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370380; c=relaxed/simple;
	bh=SnUQNI6UHQP5MbPqCnlHxHpVurWDkYrxspXEtgwaH54=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BGIxMIZ7gAPxWt8X27qOPxwE0IyibhvvgjOx1bJh8HUZq5EIwknuv0yvUZj4zQH2cp/OHINLmcZ3QZr1APiO5cz+ZNnu9jPnkGR/BPVmYN5DYi3GrREN4WvgOmTBCUXRGNw8vGd0QVmCKbdhJMKOfXa1ZZWim0En5knLN+uF+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jgY/LjQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df773f9471fso3563581276.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718370377; x=1718975177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7fRKhubzFyYMHPVT4nS15jvFr0tZ15mqILMaqnV6cNg=;
        b=2jgY/LjQV9T9KwdxoEgdgqWIgXfaDBYcvYrwUawYzFthrSQ41BLxG0Q/pRGgA9mQYF
         isMz06AfIwpd6dW/CSbenM8Lc/rkSDJhTOU6ZKrv6WWEdX3Dy96LUu/sfnhkc7Hv6/qY
         D2iEbQCSVZcaTZsDDsfYPgISZeyKQPmCTbBe8axabuQg5APBJvdEqwlPi6iF1e09zUVa
         BOU8Lmur3NwtFlvy6dA8cy4WbzWyDtmAS4kr4PCpWaDbUL1rR7jPcli6FuJceE+SHtGH
         lH0VvNjQ7WYK4zPMv/jWmj/CARK+hpJKnSJWt2pSCUefT8PJ6PkuthLnUIxOhcYp1ZRH
         h5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718370377; x=1718975177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fRKhubzFyYMHPVT4nS15jvFr0tZ15mqILMaqnV6cNg=;
        b=j6uarjXSX+XuCTnDUyYq7PVDYmwAA3L9RUpnE4PvgDRTXPQDdrZgrVKVyMua1xdLB2
         FAs3K4gjY/qLv2pj+qHbDP3DZ40YGLacthsSm8HL7aEqet0vUs74A4iU5A5h3AdpKTez
         jDKStu74pSvF81gnnOVBPzzNUar3GxdVg/pJ1vQ1gHFhuvfOVAFJyPpqBUiP90/ZZIdH
         4vBK9jh2C5I2hWo++qSQ/cUEw2mUGatL/l4z7g/iZT6deaibHsDLimF9WTsPzwXPT1pa
         eZFI/qzt2JqHL9D8yF6KhlTh5cv2dxB9MSkdAmr43j4kyDHYrSqULFCBTKejMuBj1epy
         6x+w==
X-Gm-Message-State: AOJu0YzpM0/u+Oxaoc548yNCHY2mIHxtJru1JTrM85ltzyfzZawE8zFX
	HqJaO2Ww5+g4kvDl+txzxqImtKRbg4cY+nM0tsDx344ZQEQuVpS7/qe6JFYZC5mlGDDPiCTZvxx
	tX0gfOZTMaw==
X-Google-Smtp-Source: AGHT+IGIoTzHzTFDFsyv1dPaltPPdn/E5X6Cw9mb6zbL+w9fxfWZJaVo6SWO3fdCWvcUwkVcatanyPY7TGVySQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:150b:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-dff15402e19mr658855276.1.1718370377078; Fri, 14 Jun 2024
 06:06:17 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:06:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614130615.396837-1-edumazet@google.com>
Subject: [PATCH net] tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Some applications were reporting ETIMEDOUT errors on apparently
good looking flows, according to packet dumps.

We were able to root cause the issue to an accidental setting
of tp->retrans_stamp in the following scenario:

- client sends TFO SYN with data.
- server has TFO disabled, ACKs only SYN but not payload.
- client receives SYNACK covering only SYN.
- tcp_ack() eats SYN and sets tp->retrans_stamp to 0.
- tcp_rcv_fastopen_synack() calls tcp_xmit_retransmit_queue()
  to retransmit TFO payload w/o SYN, sets tp->retrans_stamp to "now",
  but we are not in any loss recovery state.
- TFO payload is ACKed.
- we are not in any loss recovery state, and don't see any dupacks,
  so we don't get to any code path that clears tp->retrans_stamp.
- tp->retrans_stamp stays non-zero for the lifetime of the connection.
- after first RTO, tcp_clamp_rto_to_user_timeout() clamps second RTO
  to 1 jiffy due to bogus tp->retrans_stamp.
- on clamped RTO with non-zero icsk_retransmits, retransmits_timed_out()
  sets start_ts from tp->retrans_stamp from TFO payload retransmit
  hours/days ago, and computes bogus long elapsed time for loss recovery,
  and suffers ETIMEDOUT early.

Fixes: a7abf3cd76e1 ("tcp: consider using standard rtx logic in tcp_rcv_fastopen_synack()")
CC: stable@vger.kernel.org
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..01d208e0eef31fd87c7faaf5a3d10b8f52e99ee0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6296,6 +6296,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 		skb_rbtree_walk_from(data)
 			 tcp_mark_skb_lost(sk, data);
 		tcp_xmit_retransmit_queue(sk);
+		tp->retrans_stamp = 0;
 		NET_INC_STATS(sock_net(sk),
 				LINUX_MIB_TCPFASTOPENACTIVEFAIL);
 		return true;
-- 
2.45.2.627.g7a2c4fd464-goog


