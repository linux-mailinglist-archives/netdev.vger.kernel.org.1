Return-Path: <netdev+bounces-206430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD5B031B7
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67742189797E
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360B277CA1;
	Sun, 13 Jul 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ptGzoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBB1E7C23
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420188; cv=none; b=M/Cj/9KlJntRO99JzfwByXKh66O7cqtdJIOd3OnSAbsSsXYApCUhNOj/i27ouQ8OID0Jc7AIWyynnH1Xt1Mu9F662G/X7rqRpdsVH8ydN3PmSZAcaCRuzq8gKPskc0O6RFFYQJONSzuXl+9Dvh7RNzZJJAX08Ncm08eT7B3dF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420188; c=relaxed/simple;
	bh=kPd147dWFEskqLI5gmanWp9YVNft3FhAHyr4l/+adcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR7fmBsTscMZ9h1MM07bGpMguU6k4AOniR4bjd++G+fIhaRSnbmVTCu1vKx10bjc51XbHclLEv0M6DIuHZRe7vMXKmeVGr8kBFglKoU9mCDy87nPvjMGO9964mMDaRT/2JRtvj5lxyDmjlq0gS+Plub4a3M4XHsgqsEvXIRSIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6ptGzoJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313756c602fso657786a91.3
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752420186; x=1753024986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTSekuxJLEHAvl7A9v/WKw4cGXLCV6tIJX8Y/BuwJx8=;
        b=d6ptGzoJLtJ77YwP6I9p1k9uA/BylkSutDplmb0zTqtjsDhJyzxfiSYPp94jHgXCLu
         v5loFcwDl55j+lVh12o2YquAdrpbnvDq4Lyk+WbtqHs4D0+HIK44oGwdBWyrjATTnixo
         JXBQbdQqMuVkffcx/l7trJytZmQnLPE43p7zp7QCkiFkMpUvAfsvIu4vS61wFKAu9uZz
         HvT4603E+OC3q9EpctmH6nvfJsphuhAjBfKTN1Ff6pj8XMyoby2ez9t5f9JCr6hz9kpp
         JWsBi36E1QoAdqeRWocT0xSNK930iyRhCcOOH3cy1m/+lUHQa5ZokoIi+9v3m5hgU2K7
         +miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752420186; x=1753024986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTSekuxJLEHAvl7A9v/WKw4cGXLCV6tIJX8Y/BuwJx8=;
        b=soWDIu4W/kSgENhsYCUshxleBY9fK5q4VKyZCEbz+lPr3Qhqj0l08faIyDAcIB09Md
         vj72hwpLxX/wNRI6xASqKwKkYpSqFGiWrJpn3WBTw6WyWycNbWpuHHwlVgjqAH+CNx1q
         tliRMEGEv7yM1jXx19h8MjrsXeVUT3B1ggOdRrriIGc+iySX0OiBtc0d0xXVOsjQJo8b
         uZDfCxo5/+86nE91YM6VWq2hApjMH6HUfvQwLCTHizty/JAVMKtjTqEe+ta9VG7oLi3v
         QAU2RLwMJK8hqS5FiyEyaswa+FvliajAHqKmPvE9riwSS+AsmogrZbVmJy6DiDsTUo8b
         oq3w==
X-Gm-Message-State: AOJu0YyIhoFYEOtgyLq+p93zRon+AZcl8w8OaMLhJBnhn+UJkAj3EPQo
	aHk1sI8OY0OSZvoDsboo3XHP5eVwFvPse4IKVH/0qlcyepBKMbgxGik=
X-Gm-Gg: ASbGncvO/0fFFnkxFgH1pVFwJxhwP76b2o14ywu/5ejxuO/1elhnOc1QzV6qFNG4iTf
	DKaicHLcxM2V27/c04iuWAbXwf0+7XQGT6ARMngMh8O7sG5msHPyx1oEqx+gVegYH0kesDzNmMj
	9IdHT1M30gWU0uuTRlkNRdGA+AAQjzJsMPcnTwL08k11yy1DzXF3/Pf0fXil2h7iLwvg1n3yVdD
	3R9zYmntwEzFr3a2XE6oR7bWVZOcZCoFfLBVQtX3T7staiGlTyVHpPSqbzzywOLhyv4ucJ42y3O
	YiAzLWIMuy2S89IDPtMxSTwS45Y3C7UfUCXMYifLMN7GmYnkjqSksryy7bHmqbPGNXNjbHT1ACE
	1TdaqGjWpLODBGYukbKrQSNVbnrHEgf84rmx6cuWNPaw=
X-Google-Smtp-Source: AGHT+IHWPWfaUrsOjkK5/SWUAAELZU2X6GfsvFZh1f/CuNN2SuGaDk5Pdif9uKl/2zZWjiI7YpjzMA==
X-Received: by 2002:a17:903:1106:b0:234:cb4a:bc1c with SMTP id d9443c01a7336-23defb22a52mr58322385ad.6.1752420186336;
        Sun, 13 Jul 2025 08:23:06 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([46.232.121.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f633sm8522423a91.48.2025.07.13.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 08:23:05 -0700 (PDT)
From: Xin Guo <guoxin0309@gmail.com>
To: ncardwell@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Xin Guo <guoxin0309@gmail.com>
Subject: [PATCH net-next] tcp: correct the  skip logic in tcp_sacktag_skip()
Date: Sun, 13 Jul 2025 23:22:53 +0800
Message-ID: <20250713152253.110107-1-guoxin0309@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_sacktag_skip() directly return the input skb only
if TCP_SKB_CB(skb)->seq>skip_to_seq,
this is not right, and  the logic should be
TCP_SKB_CB(skb)->seq>=skip_to_seq, for example
if start_seq is equal to tcp_highest_sack_seq() ,
the start_seq is equal to seq of skb which is from
tcp_highest_sack().
and on the other side ,when
tcp_highest_sack_seq() < start_seq in
tcp_sacktag_write_queue(),
the skb is from tcp_highest_sack() will be ignored
in tcp_sacktag_skip(), so clean the logic also.

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Signed-off-by: Xin Guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79e3bfb0108f..bbefb866c649 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1809,7 +1809,7 @@ static struct sk_buff *tcp_sacktag_bsearch(struct sock *sk, u32 seq)
 static struct sk_buff *tcp_sacktag_skip(struct sk_buff *skb, struct sock *sk,
 					u32 skip_to_seq)
 {
-	if (skb && after(TCP_SKB_CB(skb)->seq, skip_to_seq))
+	if (skb && !before(TCP_SKB_CB(skb)->seq, skip_to_seq))
 		return skb;
 
 	return tcp_sacktag_bsearch(sk, skip_to_seq);
@@ -1997,7 +1997,7 @@ tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			continue;
 		}
 
-		if (!before(start_seq, tcp_highest_sack_seq(tp))) {
+		if (tcp_highest_sack_seq(tp) == start_seq) {
 			skb = tcp_highest_sack(sk);
 			if (!skb)
 				break;
-- 
2.43.0


