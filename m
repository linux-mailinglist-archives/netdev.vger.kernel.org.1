Return-Path: <netdev+bounces-201223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C703AE8855
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A617B3BD3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7E226A090;
	Wed, 25 Jun 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmmVKAhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026773074B2
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865858; cv=none; b=tOf90nroKNIW+Q5n26aXtX37WWWj1lEsUejHyaZwqZRTGQ52ugaDlkvepoVujavTlayHNpoOAkf/wVU08SCFRINoiU+L3EusubZx8ffcS23TzuLzswehUKI4qf2H9J7NruXjVeM9/4jpUse4ydZPGlRYWFmoYnFgIZfF83Q1aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865858; c=relaxed/simple;
	bh=DKoiPiF9z+lAGAqipSuqCueoouuglHAY2EBl7whM1Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHqjdy0m5dLfl0MZnWCVaSp45MuSTvcTtV3Z7DXeH4+nNgNVl6inEbWuEKKy7nbkLzNGmjT/4NPP9ajux+Ezl5/onoIEKsM0AJsxQTuTQP1etjj1+Ox7U80ylYgiTQZKhEKMUv2Ml9RRsq7Ft17WG6fEOyVP9VGbh8P0ZiqgiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmmVKAhZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234d3103237so84695ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865855; x=1751470655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO30Bx/PN0B5lKF/+SoXHzPslEs9UvUz95f3VHaeipg=;
        b=YmmVKAhZ9ejn0BaD40IhR31Orx2YeWF9T5B0VvkL7DJ0W9PMgoWUhvTo60aIZSqAMu
         OYdW9dZqfW3k6bGMv6o7r0DGCONZp057iqhQdrz6ht2xz7Y1uRZ/MAfV6opTec/5YkYh
         SDZfYab76as3H6muUEkdJZbT/JHmQvYV3YtnP1F/wRrwTV8vQju9CVsN0VapDtFzHZ7G
         CjwFyz876YanfMPBhKtN/n8XMiGN+ZiN2DFppeholyjlBOLXCw2TpRRfY25DXFDVgULN
         I5AcYgGWgoMCdI7ZCcFufa0olP3Z37Y1qsqz3XYsrRyfiAiayOiKG3YX/fkFzJok44xd
         disw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865855; x=1751470655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO30Bx/PN0B5lKF/+SoXHzPslEs9UvUz95f3VHaeipg=;
        b=dD4rbj4D3svNyQR1yPYqEFRowrJKhZLqwXGGNOG3gFHtdsb2hgkePVAkSBn6H8gaVI
         xGvCVEuTCFeymfn30vVJKzNvG+3wzV8T/X9nrdal93HTuxW8yeIn9KpxQZlJ8S80fkHG
         7hRHUvyyhxADFpTSTbo4p1GYaQDfTyegmAKZYNJxd6ttljMgVloui0CllRSM2/c+ljhS
         hL3uFU1T2iFZpCr4t+UL7gT85E0jx7NzTN4zRqc73/s30CG10sDW1q6bAf29m7E4YqzH
         82qb3efvoqT4ON1x1oQRmwffUbzxCvhGsCa1kRaFx4tb6z1Sz6j7nzOnoJtGUfwC0/oK
         sj3g==
X-Gm-Message-State: AOJu0Yw8zOur7TEcztzKINmmuw0llKTKNE89wYfMFE2Uvb7z9SrQknDR
	kzXwHFHDx7Gxy9ho5qirtqEWjPuY3BXbblA+MEv4b03gJU/sRi6Sk+E=
X-Gm-Gg: ASbGncvzcpx9jkv2SIQ4JpMyVG6UBcFHCbl3D2meJ4mHGCmYueXNXqdz8ueO5V75jCs
	REIwxVtxL2kNH7rsiAUS31QFUKEj/pp8gbLm/9KUKH/cqLfqIyVse0mFCfdXyLYzelqEwFk3Twh
	a2JplTd4J0As5r9WmO9546YbdeoMmoxhih/7tSDXghBCijRVaWIu3ggXVbFct40RAEHZk3sOx97
	xBddhcmvIDxbs38Hk153wbJ/31jNkrtslIohBwSto6dm4FSkvM2adVHf9Xu+IUqmkPTFCBngJYK
	aV0J34MogjC7kD/eAqTavkGzImC+5FBxCQxaJFfoLslhYv+eq/ykQhGFvLwhuXAFz5KlpGLpnVD
	FAd0aGzcoLIC4X7dT
X-Google-Smtp-Source: AGHT+IHbDOZvIlG6iq4lHSdB6fT9aFJaxn/pGR3qKaPiDDVCW5jQJ6V6lzTLJzJ41U+xEv7CsUXWqQ==
X-Received: by 2002:a17:902:d4d0:b0:235:737:7bf with SMTP id d9443c01a7336-238240a6597mr23452375ad.3.1750865855004;
        Wed, 25 Jun 2025 08:37:35 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([62.192.175.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d866dd9asm136036825ad.171.2025.06.25.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:37:34 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: ncardwell@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next v1] tcp: fix tcp_ofo_queue() to avoid including  too much DUP SACK range
Date: Wed, 25 Jun 2025 23:36:28 +0800
Message-ID: <20250625153628.298481-1-guoxin0309@gmail.com>
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

After this fix, the step6 is as below:
6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:1001}],
length 0

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
v1: add more information in commit message 
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 19a1542883df..f8c62850e9ca 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4846,7 +4846,7 @@ static void tcp_ofo_queue(struct sock *sk)
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


