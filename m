Return-Path: <netdev+bounces-141405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A319BACEB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F2281D7B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446816190C;
	Mon,  4 Nov 2024 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivs5iepd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3A17583;
	Mon,  4 Nov 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703660; cv=none; b=cOUw1Gev2rXGBy7P7JmU/46n1k1HdEK8bTsRsfQ5Y4qRoCu3olPHbdsksv9LhF/hz3oTJORwA9G7N2p3JtMZiV634kxhxikwftM/tqEOVXD5GC2eUkL4NW05AZL4lLrl1tMgNp0a+Ep4g7EMl80JgXEpIIJ9jPqjGgbDNTKZeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703660; c=relaxed/simple;
	bh=hC7F0fhiZg5D6UVPTp6KiStqCbFkcOa1WMSV28jaa5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGCrNRey6i7y+yrp1x+NMiWHGnJM+1kXsBpKSQ5/lakpd2UWaGAWeTWQ+kIvATmjnJYaN9m1MwO//DciqGGTKNoR+vwip4slhnPdYHsGOJBo77rS21XBzq8g9BRrLl+jE1k+h4PyOU+ALrQUA4ZjJRMRqECyKL8KIB6TnZM81f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivs5iepd; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2992935b3a.2;
        Sun, 03 Nov 2024 23:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730703658; x=1731308458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcRCa9PXpWbvCBL1vMLSzhAlsPl+CqOyZHOppQGsiRU=;
        b=Ivs5iepdkiMeNJnxGD/qVtaN743TIwXzleREBDcEcm8fqV8LZGZKaoXHFgeRxX49X9
         kZVSDYcgU0spzXUTQ0KtyQs7EU6MuuCS+78X/t3xvb7dh1EASMi3As1QOBGadcyhguPL
         KdjaorhC5ljDd8EmRHm0fD+CKQmTok2b1ed10BVp+OwfYrygnLlBW9+LzxweTvrCht2r
         Z7KRKhAgn/IYxilWc9Bh0Cf2GW6zgIdjjFNQiJt+D84MAKR9tZDZTHimI5cx8YFnO0ge
         xx+9jF0XOl1cs/TX9BftEqtmrAg0ZUyhCkRQoIVOxBnkFllxuTEPZazL+OYzzwasv9xt
         64kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730703658; x=1731308458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcRCa9PXpWbvCBL1vMLSzhAlsPl+CqOyZHOppQGsiRU=;
        b=tmGPMGAnOEmNVxPNHxlu6kwB1ghYnLyXdDa4vFxxrAn20Uhl3x0y4Mj7ppDVVKdKu2
         APHpZCfkfokk6sSA5r7bT2BbEne85NpFkMvJHPUUEOtGPdqtLTtoPMmbWjTLYbRgKA1k
         RhYY+b3xiraqrXeZqYJm2kgcvNZz71gGVIzdUhl9lkodi+lwD15i1hvKgYFRdTUssu6A
         hhBnQv7ZVraVp9IRDWc+6rGfnnqPyjckV6PWRram5+hOPFR/FnWBXPP0sZYlfBSIzWKT
         ebEx5gwfW4pce71J6XRoW5TluhMykhheV0FFzawFtPISt1JE07AUIQL3HJ0woq62/O8i
         grmg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZkzgvwSlTCMTxzGsQGZuvDiDWmsW9u2IOuUCKJ47+PZ3mxUWWt1z/CN6m8OCdaRHBZJ32c8l@vger.kernel.org, AJvYcCWcTWvsnJjtN6e9bm9vBvMhqzM7+c7Ggc7iWN6OWH3WqdQfsxSses9fXOChNAJoelTTLWc+nAd92ldbB5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpCo6ritLSa7vkKfonaZhW5ZgArpfn+tiFibKzALFQSCqN+os
	D7M/GoaJeMjrrot71wxtOeTSvjiotaecX+vBYjRLMCcclLP2VM17
X-Google-Smtp-Source: AGHT+IEjd6UWDvOMdaHanOHmjg+kShRprAl6051TkHSUXWe/Bi1CRP8VegFLo5qBzHP+xouXzWf02g==
X-Received: by 2002:a05:6a21:398e:b0:1db:915b:ab11 with SMTP id adf61e73a8af0-1db915bab14mr22782056637.24.1730703658457;
        Sun, 03 Nov 2024 23:00:58 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0eda2sm6481582a12.86.2024.11.03.23.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:00:58 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	lixiaoyan@google.com,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH net-next v2] net: tcp: replace the document for "lsndtime" in tcp_sock
Date: Mon,  4 Nov 2024 15:00:41 +0800
Message-Id: <20241104070041.64302-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
moved the fields around and misplaced the documentation for "lsndtime".
So, let's replace it in the proper place.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- remove the "Fixes" tag in the commit log
---
 include/linux/tcp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..f88daaa76d83 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -200,7 +200,6 @@ struct tcp_sock {
 
 	/* TX read-mostly hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_read_tx);
-	/* timestamp of last sent data packet (for restart window) */
 	u32	max_window;	/* Maximal window ever seen from peer	*/
 	u32	rcv_ssthresh;	/* Current window clamp			*/
 	u32	reordering;	/* Packet reordering metric.		*/
@@ -263,7 +262,7 @@ struct tcp_sock {
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
-	u32	lsndtime;
+	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-- 
2.39.5


