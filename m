Return-Path: <netdev+bounces-131118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772D98CCFE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BF4B22590
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2736811F1;
	Wed,  2 Oct 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWQgGEfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25F1F93E
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849653; cv=none; b=BMyRyItA8UofjuQiIhktgs5XLMSRp4KiQbZFPSAGolZ3D1GKWsn8z3Ye9/yHIHbB2YUyW5lNxvFMhCsNY+zgpv0EbfDkmYMg1MHbDYSLAclraV706emH8N0yHVcPgCesaMraFe8ELoygI/BMZtnSDT93bFsqxy+NUSqj3cY3dWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849653; c=relaxed/simple;
	bh=bVzgrEgiLhJbB7RwQoMrX0K0MRe6IV+FtaLfIEjTMTU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=up+BVdbz5J0TiGPWMnIZFhNOtUATuDkOXDvjrfjE6MCUAVnGgZILolBYSxuZ7Qm/F/AHCpRfxHoKqAENMnn3Tfbcb+VI+iF9ywf4XvV2grdaFKaVX2WS0fr6hdHBS9O2Jepvet+uOiZGBG/vPehWqTcVP4eu6eaW2u7C/KDvjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWQgGEfq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0a47fda44so964811a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727849652; x=1728454452; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZMKJi0ybwQHR4jHcalCgiEDAdpq36VaVWrpv9+wBLE=;
        b=aWQgGEfq7d6hP8K0ng4KCl2i28lGkS/X8/t4VdK/e0xjyGLk0yeN7dLMC1mP3lPjlB
         hI7x/Eg3NcdndSL+AXo+QWb1/3uZ3kYS0KWPOK32U3UfplF79Z5od+ny/u1HJKD0C/1m
         dMsQ+LKKiymCAHuSXYJS1vzrcDUGTb15mjj+wio0jlpLZ0UW0zfCXDFDpHcm0fIRQ8Fc
         wm9vgNYN8E1I936lWpYvJHwUtSfvAfgNOrhNkBscKtlEnmWr7CohAX/WlBRCYByyYFAn
         XcVtzkZGXRnzvnBdoEspzzBs5g+hENN+ip118tr14AcJiPwY4Xlhkjmt5IzHS+mZ38pm
         2Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727849652; x=1728454452;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZMKJi0ybwQHR4jHcalCgiEDAdpq36VaVWrpv9+wBLE=;
        b=dFjlakGt60csstMux5/7toC0WqW0GPHjEbPmiL1clFXC7fJJGNMe/ywNJPC0oni0vF
         MjacnWOYQsgAAigsO69gXAeCpOG247jopHgKNFFLFU8e6vTtT9KujkSIvOZPgIO0bTOF
         m3NGgK1oTZPe0bv8oPG9IwVrcDLrvGXaSOKRwzWmj/tZSqw0Rlqy6CzBKuml32pvXztX
         Bt8757PIKAOB79MReGXbKHeeSd4RFtFptcIZB3wUg3rdAd7aHWGehLkuRzTRQQBDJ8K7
         pbtasUPiTn5v5O4YkXANbiDcjb3oGKGBp8bK4Pe84ZBgJzrXNkQZpSo3Gkfe3zIk984n
         5qcA==
X-Gm-Message-State: AOJu0YwZUOLHWaY3X1GkZCHJ5x2nS3SPe6H4yPLA4tuCcnhRafDaGYpN
	3eXHOufB+Y3QhtkceMgsZf+ttHYY6q5jF8d5NGPx6AlL7Tf4wjg=
X-Google-Smtp-Source: AGHT+IGOaqz/HV80L8uGTOmvsGspbhLz+oiuPKZhTiKTXXYtUEtyPcPderRkzSsgD/91cXv8jLqKUA==
X-Received: by 2002:a17:90a:fe0d:b0:2e0:8b1c:f3b2 with SMTP id 98e67ed59e1d1-2e1848d7e8bmr1114110a91.4.1727849651607;
        Tue, 01 Oct 2024 23:14:11 -0700 (PDT)
Received: from VM-4-3-centos.localdomain ([43.128.101.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18257efb1sm895464a91.0.2024.10.01.23.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 23:14:11 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next] tcp: remove unnecessary update for tp->write_seq in tcp_connect()
Date: Wed,  2 Oct 2024 14:14:03 +0800
Message-Id: <1727849643-11648-1-git-send-email-guoxin0309@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "xin.guo" <guoxin0309@gmail.com>

Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
introduce tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
so it is no need to update tp->write_seq before invoking
tcp_connect_queue_skb()

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746b..f255c7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4134,7 +4134,7 @@ int tcp_connect(struct sock *sk)
 	if (unlikely(!buff))
 		return -ENOBUFS;
 
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
-- 
1.8.3.1


