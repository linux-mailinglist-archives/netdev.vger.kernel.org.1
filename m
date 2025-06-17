Return-Path: <netdev+bounces-198710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED126ADD1FC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0C1898A6B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1DD2ECD22;
	Tue, 17 Jun 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOiki2Pk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7318A6AE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174637; cv=none; b=bUHYo2bsP21zcwPgR2CdunuY2bSrsPsV2s8KprfFqVxwh8vEnbVdcJLR0fpJ/S8Ijbiii8mVF+VWbpWipC2YZ1rUo5Y76D4OBCxB6NiVabIfZCcIaVOKiiSQjd6MfKMPG1SCYD+Y0yB73qVEIb74aYH7x40cg90d/VkJhj5BUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174637; c=relaxed/simple;
	bh=f1R/Zmc0zHt6BpIF67GaJZyBO4WZjpR/zDKNa3FYX68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFobxgAdGbkUURGaUeO15Q8nO4V3PcWzz/Ho45RSUDbfbiORxf5iQHfDAdFhPvD+AnGuOZpi0VVE4KfizHZ+NbjLmGj+b/yumOXbwboJl1G05RH96R9LjVZDS2reeWCi15K8x3XvNX3HxoObsJ1f7Q6kFAmSQ3Ncc4/z1gT8cGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOiki2Pk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2eeada3df1so488383a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750174635; x=1750779435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a87MY5va47eNr6e3cBqmeJ6bteDfCokwocB2/QqcIbo=;
        b=mOiki2PkRkUAgmsqD2Pab54iwWsrqhMPf0SFfbU8763vkUoIfmUatxBJBTvzueNIV6
         MEWVppTN8BlBH+B82WqWXL+gLUJdf+sPihBEZSk7BT6ccfA8Tlw8BjHRDuCyT80a/aQJ
         a/84Morblk1ZWs0/JRkQnPqgK/wkgxrJM4x5ohrB/fgyG5b3GfeljfmEhHHNYkdG449W
         2YGxaR9pYobBCAwE/b++P9wqqvWsmgK6eS06xo278GQC8ZGhWDRkk5EmVE4wJq33slUQ
         M8e3BG6yl9LXFMRe5zRg8nhNhANNjp2WOCWw6XfzBBBCxRI67HL6KLw13UyE/z4ucuvI
         v5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750174635; x=1750779435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a87MY5va47eNr6e3cBqmeJ6bteDfCokwocB2/QqcIbo=;
        b=JUQn6WWozyd0MFz9hl7zIrUWeN7VR5SB72T+OQFKm47DZUXEJh0Aa8UYqJoRPoLYcA
         dnVAWLSUqnNcK9ULRp8mVWZTrm0AUY7Z3jwrRIvwDE4jObkc6mkZbwd25zD7inT6Zwsh
         6TczBJIS0kQptj2xFzHNBaVIbQoVVE/iE1EoBhHxv/AfnpdT9PrvaDw0ggnILHos+nut
         fbSTFHguLwNUjQdMB7SzMLwkPDllzxQwu1BPNIC6RuakOytRhZrvU6i6e0ypqJtQM+Yu
         PhP/c+5Rqu7xya5ZqHzSyJsVQHyrg025s1x28uRbUIESH87/18u22a6C4detXSq93zHo
         jn+g==
X-Gm-Message-State: AOJu0YyVQDO54lkSj9kDG4fHOYC3i31ZTdWxbhoTAWAvvnWmgUS5RjuA
	Eg2yWYppknBtJ71vWfxX6ICZ02jER8ktVOpKM2hwJMNh3nwIRPtSQZBIHYbhoVw=
X-Gm-Gg: ASbGncuRnUNa42bjxl2jqSs+shm0yAXX8NnLDVK7HyPzuNV/Ba0lpMt85zUkbnrR5yO
	RHcZeAIW79UqJ808ZxwVgE8jIr044XdjgroDCoyzRx3fMkrx/WkgKLuJDONokatcD3OJ167nXN/
	bWGXmPBb5mBfs2BfbuR3ypYOIshM60GoJHYW5wpyyZ/ENniyTx5+2aS+CMllj7GN/Z8H6uts1Cs
	pNA5ZMiCnVBppgLCOU6KEefpPoL29I6tjnquXvRihyMkDXBSvGQrxJzZ35epr+nMfYl10i0pD6R
	orS0MbvVMUOqIRMjzRWOWMJVdWMaPRUQOFehY/h7uthu5glC018Uk5vq5Sw3QV9Gb4ylTD2F0XC
	AAzKnUdunjA6k
X-Google-Smtp-Source: AGHT+IEVrSKXmle1zNCobDLyweUOhkFI6SWuTTXJuQA41Cy3mLK1LQgZbGT6aQVraEG97pBqoK3ZNg==
X-Received: by 2002:a05:6a20:a109:b0:214:70c9:37d3 with SMTP id adf61e73a8af0-21fbd66f922mr8439819637.9.1750174635063;
        Tue, 17 Jun 2025 08:37:15 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([23.163.8.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1689af9sm995938a12.59.2025.06.17.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:37:14 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: ncardwell@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next] tcp: fix tcp_ofo_queue() to avoid including  too much DUP SACK range
Date: Tue, 17 Jun 2025 23:37:06 +0800
Message-ID: <20250617153706.139462-1-guoxin0309@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the new coming segment covers more than one skbs in the ofo queue,
and which seq is equal to rcv_nxt , then the sequence range
that is not duplicated will be sent as DUP SACK,  the detail as below,
in step6, the {501,2001} range is clearly including too much
DUP SACK range:
1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 1325288529,
win 20000, length 500: HTTP
2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
[nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length 0
3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
ack 1325288529, win 20000, length 500: HTTP
4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
[nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
{501:1001}], length 0
5. client.43629 > server.8080: Flags [.], seq 1:2001,
ack 1325288529, win 20000, length 2000: HTTP
6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
length 0

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a..6194ddf46024 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4973,7 +4973,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
 			__u32 dsack = dsack_high;
 			if (before(TCP_SKB_CB(skb)->end_seq, dsack_high))
-				dsack_high = TCP_SKB_CB(skb)->end_seq;
+				dsack = TCP_SKB_CB(skb)->end_seq;
 			tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack);
 		}
 		p = rb_next(p);
-- 
2.43.0


