Return-Path: <netdev+bounces-74346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A80860F4B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A191F2513A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215405D742;
	Fri, 23 Feb 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edurkSNt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A56D533
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684188; cv=none; b=afnDpbMU8033WlQrZnvDgcCuh6cirqjCvcU52vZp27MbjaJAinwwYIsUsL4yRGHRHLuOQ/TyHRHiWjq4zSRtSIDpd7+m9RDih5TsSWLCkNYR3VkGRxjf8r0cV7cKtI4Aq3VdepyQdIAb25vE8lSVHs5SVgQxls0V5QHSQz2eecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684188; c=relaxed/simple;
	bh=/i3A3wQT5Z2ehZu0rjrkw9GwUEs5YduexTTNvHdgku4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDtiOAt1NhSDYaV8VxTG0NQuflVwcJ+zptL3hshRBH/ichJEJJxK/Gkk2kBRzONN4h1xY/ie9yHA33Ju2ZHU1NYSykkGzhNu01h+8an6EV3IFG+7u/L1MHGfKjDlsmQL2M56YHs1yP1xAIXVZEVgKMmUpRByEf4qqhy7JdPtoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edurkSNt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so583285ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684186; x=1709288986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf9BwtgVLn98CO74o8ZuqNBPza3uikkUdz8+DwVrcYQ=;
        b=edurkSNtfXTf+GfsXbGw7pYFpNlFlP9v/BI3KjXbpk5r04PEAsVT/IMn0CBHbl9aq4
         kimS6d6p8AvvpSGf1FC0bnW+lipwlMDIpdTEKVsrFmpruTVo2jFl80pmwGQjOtQVxs25
         1y8ikxrkC2pTOpvsCF7hBbzIbfuCFPK66AT25MWCW60lZDRaD13JOX+i9xtecW0KU8Xu
         it25LIR5jDb+4UKzwQcsmKImxyWlG7oyUXLfGQpTvaBS0elclo+mwlAv1Kss5AXNuDTW
         t4L2uZcWemMB0X3y9cWb4Nv56OsBEwXaegF+u/y8OGxcFnisPNuoQdkEWUU/QxQ+i/Lh
         0AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684186; x=1709288986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf9BwtgVLn98CO74o8ZuqNBPza3uikkUdz8+DwVrcYQ=;
        b=jxmCxgIilAyWH7/CCfzSMXW/eRlQfRT6otDC/F+SUDb/8lRqCC8yYml1f8W62KaNJg
         dWQ10Zuo0vxeDBIocwk2tORSxmvm9Nv2EKrA/Wh1KWAqLa2liP9FZWAgquowo7l8sCUz
         Mt3SDAeFwu5XrRfuDmKTd1vxDOYrKo+wNNzmTY4PAFV6v9usIRJnV0jKZmo3D5B2Yz0k
         oiWrrC6ZvQqxL+/YKtuMfdRRBzbH4xQLd13ryarp6fQkpvDV894JMcZrzZVq6Zq5b3gX
         tuunprfufprRrpoBkJfeYDtUSCQwueIqEtIU2sTcCG8AWn7/xs2iTsdTfdDync31bBYA
         Wg2Q==
X-Gm-Message-State: AOJu0Ywrs7/pyfFbq/j3FQ8ijEy/pCHxaZqRowTqeNaprMbJRrrm9FqU
	HXPpHryngwqI+OhVMBN3zoPGzG4UOEGiASAN3su3k3js3pSmI8/V
X-Google-Smtp-Source: AGHT+IEJ1ELdRLAo1CFu4HzWgYnFFmpEgtQHpzyjqUfntIqMweNcjJS4/+hiQc98kYt8QkYXocsafA==
X-Received: by 2002:a17:902:a502:b0:1db:e792:bb38 with SMTP id s2-20020a170902a50200b001dbe792bb38mr1203690plq.63.1708684185966;
        Fri, 23 Feb 2024 02:29:45 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:45 -0800 (PST)
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
Subject: [PATCH net-next v9 07/10] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Fri, 23 Feb 2024 18:28:48 +0800
Message-Id: <20240223102851.83749-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
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
function in the subsequent patch in this series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89i+EF77F5ZJbbkiDQgwgAqSKWtD3djUF807zQ=AswGvosQ@mail.gmail.com/
1. add reviewed-by tag (Eric)
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 74c03f0a6c0c..83308cca1610 100644
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


