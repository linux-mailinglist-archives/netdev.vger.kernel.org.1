Return-Path: <netdev+bounces-99405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57F8D4C4F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235D21C2228E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F5183072;
	Thu, 30 May 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+QfLNCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267117CA1C
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074806; cv=none; b=gXMtJ7Xeinp28zt9N+a+SEWaYPI/as3wv/qfKLtKA4vnz1fYPTKAg9byuTYB2dEwwkUQpRAsgeFxCSpbvV5i7JhnJSjSzT1tLRcpBsLEVGlKYwB1Lq++PiodmZVhQy88/cSCQAmfW3k6AOfIPbgvsi+CQ88dFtJRCsPm77xtDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074806; c=relaxed/simple;
	bh=Wpgs9oUIypF+YvMnNy17mKtpyzQ9DGF0AjFAPIa2cog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2m3+8cTjLUdbDcS2iXi0YmbVhND+LHJLsdlwADEmqMT92W19WRvOVPRE8dOBBRM+PdkCsunXqba+5SCgHbVUqaB0DPRh1RPsBv5/awL8MdBVOJhNZEQHFrBQlzscO6of8B8Wk/KDQ9jLPnZN/WhGtG2GmByNKwGMCgHjF6pQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+QfLNCz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so6597465ad.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074804; x=1717679604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSri7aw0KgXxxDOvTqU37iQnlBCCkk3J7IFK321nd4M=;
        b=J+QfLNCzlENFWU6HlpPfkMagrGGYvcG9aoEjCxgFkq1ssMV4E6Du5CpbuDA3MGBZJF
         oM6DVoViUdj4TOrNikWLWlhq1ym7rHHqKgNZLjY0Ex7Hpuaku92fyuLxnvnW0ek/qkzG
         +ehrxETZzD3YQ2DReV+nGfo3mjejRki2mrKLqw9UTt6Fssy44uEnIY6wFQ5axlqjFx9b
         WBXBNqX3c9/kSWz0b9af1b7SX9b6H8OB6eSJeClki7d46vBjTP5vsksTgJsET8mySDgw
         UXAd5xr/cHJUvOZJFXT0ZFHty3Kjc+YMBlqGFEUbI4EuWxnXch7aZqo8wbGZkZtXdYEj
         PN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074804; x=1717679604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSri7aw0KgXxxDOvTqU37iQnlBCCkk3J7IFK321nd4M=;
        b=NO+nYfqcxH1PWmrKs6uzot7u4wEHY+NnDRQytlVQkxB5aZyo18xgL3YvEdcS92mXTg
         A8qJMSFzLiWm+OKho+M00DjsWNBQDgmO4PvaBRblgJHm0t/I+n4vQzLu6a4yCkAWNtTj
         ans2KTBy3BE4PIGcoOkqCqJlHlB9fCByskJcdEyf4DcQUgABWHvnqFSJO0fZCXxl04Nc
         osTeSLL7/8yaIC1dWDkf9PZvO1nTZ19Inam/AeA66pMbht6jSUcxO91S2PfE5Ixf6m21
         gAjy9a3GW972KoxZcyE8SPVasPFNYOO7UlI7H/04atxgjXMQ0oB1mdSm1DJqhOuXFhrI
         ztKg==
X-Gm-Message-State: AOJu0Yyg9YtKmm8NjxONuWudqxGWo0ccTZR+1Cm5etKLZvDcAv4qC3A2
	lpCMM5TAP1vD6MUzBHiGTcnjkvmeVuvEkkamcQkjCruxHkkPHjsc
X-Google-Smtp-Source: AGHT+IEP4j6FTfV2AFI6IKK+thft4SO9J3LKn/pKJmSe6Qnkac4vMuZU4u3BFjtyj6bO6qpmGWETTw==
X-Received: by 2002:a17:902:d4ca:b0:1f3:4f58:2037 with SMTP id d9443c01a7336-1f61be7749bmr25529205ad.18.1717074803969;
        Thu, 30 May 2024 06:13:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Thu, 30 May 2024 21:13:07 +0800
Message-Id: <20240530131308.59737-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240530131308.59737-1-kerneljasonxing@gmail.com>
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

According to RFC 1213, we should also take CLOSE-WAIT sockets into
consideration:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

After this, CurrEstab counter will display the total number of
ESTABLISHED and CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) if we change the state to ESTABLISHED.
b) if we change the state from SYN-RECEIVED to CLOSE-WAIT.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Please note: there are two chances that old state of socket can be changed
to CLOSE-WAIT in tcp_fin(). One is SYN-RECV, the other is ESTABLISHED.
So we have to take care of the former case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/
1. Chose to fix CurrEstab instead of introduing a new counter (Eric, Neal)
---
 net/ipv4/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fa68e7f6ddb..902266146d0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2646,6 +2646,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2657,7 +2661,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		fallthrough;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3


