Return-Path: <netdev+bounces-121198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9695C20F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0697B1C20B65
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533E197;
	Fri, 23 Aug 2024 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIFs0Qm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CC195
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371921; cv=none; b=XG8JGs1Iu0/uXCltCRozjN9yBqKbq6eblseEB+F95dH4uFNAKigsSTVQ9GKVyuMZkuqMp/oJj9VTnhHRf+sByqezsZJN3wAR4iHveq1t7gMYNwRG1T+5uUjzQ7k7iDbYKJA8gVgflb+58/G7CzO41HORrk9o9xpn/8UeTbH5Wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371921; c=relaxed/simple;
	bh=izQfwDwmclVeioioQytX25oOgXOzw1V60HyQdf1k160=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUWo+Q/J1pOdTnyvkoPitkJG8sQ9Mi/f/4G2MZbIB0VyCrjO5Vl+rFYWZ/ytjR7tLxgkXqXmSmdPEWO617Sgkp/z3G1R31qw+mVoJVPoVkmZ2pUXhRZjovm/tt7HUniwLLJS5WtKpbIPSgs5d0ru6ifGXTQNgO7d02EndbT0dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIFs0Qm5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc611a0f8cso12278745ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724371919; x=1724976719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p81mFTAA+R5GPGnAAOllBhjqjVmMRGMQ8xNCPxQB7ss=;
        b=OIFs0Qm5fssP1Gc852/BnfAPdxNOE0CpWhI7wgPfXGcoVFMP+2nXhejg9DTkvUjR2R
         lwgobIPMPC0gG5WAlvvkvMNczLmMkWk/bRubAGBZ9ertwk8D6ay+HgrToue9ldESeKur
         qAaioib03rkzgsOpO4c5WQxiyjJzewj+6RwZk0vUYFYr+fpOLs3pPKh2FdaeGAZ/0VIE
         wEA6pjunqBW1wb0vnj9rZPaxjm2qnOfmhD2K8YeHugX33zcuEdOvj4O9BAet/HuOr1kG
         OLYw16VIEejDXKoBF0z0T2iTsGW4yXS2y+q/GYBQP+UDRmFRei4xKt0FuCqRB2dEHeSk
         +psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371919; x=1724976719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p81mFTAA+R5GPGnAAOllBhjqjVmMRGMQ8xNCPxQB7ss=;
        b=F8b9xXTFuMwVouztEB2iDof8dKYJwtm9YlBaQIl55Xyc/Q6ntJdV81tVT1Tl78PsGs
         aZ+vyZCJeyGab15X8als0a7l+AQ18eeXE2O/HOUSvS7HwJGB6/Rw66iSpCHcbH7XmeOZ
         D3tGkSUqLn6aw7qvjKVgEljBPCCU102EelFpFStTDnNcdnU32vDIZkD8uVajD44q/HUn
         7pvjeOnGw/dfG/nIysuXEDdeli2xMr0reYh4MsUtE1XghcFAnm7hus4yrkhfInlyZddz
         NHD24KqobYYPbSA+eupI1xs6r7jcAGTtuTNzfwBENJsGLdHDb91/0/uh+p0buHd/eZgF
         /WUA==
X-Gm-Message-State: AOJu0Yy6RpPj2uMhsj5FbHFFj0KY/jcRZSJDAYveXMOWsOTvlkbYJMs1
	Eo9KI7Gdd2iGtPkOXBG6Cq2vc60DPf5ZvH6EHM0aVZIelZ5cstYT
X-Google-Smtp-Source: AGHT+IGiTYLZDdfOstjdqnrHuliiVTHq8Fi0mLwYRdjNkSsEggr77K2KqA4F+CABUB92T1n0j5uOgA==
X-Received: by 2002:a17:902:ec8c:b0:202:2e81:27c7 with SMTP id d9443c01a7336-2039e4e7d19mr5279495ad.35.1724371919129;
        Thu, 22 Aug 2024 17:11:59 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385589225sm17988785ad.115.2024.08.22.17.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 17:11:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Jade Dong <jadedong@tencent.com>
Subject: [PATCH v4 net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Fri, 23 Aug 2024 08:11:52 +0800
Message-Id: <20240823001152.31004-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We found that one close-wait socket was reset by the other side
due to a new connection reusing the same port which is beyond our
expectation, so we have to investigate the underlying reason.

The following experiment is conducted in the test environment. We
limit the port range from 40000 to 40010 and delay the time to close()
after receiving a fin from the active close side, which can help us
easily reproduce like what happened in production.

Here are three connections captured by tcpdump:
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
// a few seconds later, within 60 seconds
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
// later, very quickly
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1

As we can see, the first flow is reset because:
1) client starts a new connection, I mean, the second one
2) client tries to find a suitable port which is a timewait socket
   (its state is timewait, substate is fin_wait2)
3) client occupies that timewait port to send a SYN
4) server finds a corresponding close-wait socket in ehash table,
   then replies with a challenge ack
5) client sends an RST to terminate this old close-wait socket.

I don't think the port selection algo can choose a FIN_WAIT2 socket
when we turn on tcp_tw_reuse because on the server side there
remain unread data. In some cases, if one side haven't call close() yet,
we should not consider it as expendable and treat it at will.

Even though, sometimes, the server isn't able to call close() as soon
as possible like what we expect, it can not be terminated easily,
especially due to a second unrelated connection happening.

After this patch, we can see the expected failure if we start a
connection when all the ports are occupied in fin_wait2 state:
"Ncat: Cannot assign requested address."

Reported-by: Jade Dong <jadedong@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v4
Link: https://lore.kernel.org/all/20240821153325.3204-1-kerneljasonxing@gmail.com/
1. Move the test statement earlier. (Eric)

v3
Link: https://lore.kernel.org/all/20240815113745.6668-1-kerneljasonxing@gmail.com/
1. take the ipv6 case into consideration. (Eric)

v2
Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxing@gmail.com/
1. change from fin_wait2 to timewait test statement, no functional
change (Kuniyuki)
---
 net/ipv4/tcp_ipv4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..9cdf6e7c44d9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -118,6 +118,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int ts_recent_stamp;
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
 		 * lo, since we require a loopback src or dst address
-- 
2.37.3


