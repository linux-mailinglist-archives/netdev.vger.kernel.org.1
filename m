Return-Path: <netdev+bounces-138549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEA9AE131
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9428282E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35701D5140;
	Thu, 24 Oct 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXxj4Apn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA61D2B21
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762698; cv=none; b=N3kyFMvVUKLzPVXv3vlEMyR1aeg/QF89KBLU70MrtetnB6Nr1u/3mQkcDGpNtKb9zJ66lyx/JNXjF/J1Ow51Q4AOm9K4ROW7D2vbCawffdjCkUJxw4Fsik7zeszWp/6KbJK0DhuxhZCH6H3Z2x+Z32uMiAlaI0xoqzIk26g0IgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762698; c=relaxed/simple;
	bh=eEWc8uzG9YS6xpTxiJveLH9YJXMl6ltPj3uRUP3htAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFFbkiqTRjSBRjZWq5RDYE0bnwfWgMFvdBxrLPlUbQ84PHi+RFRVr/bTdrg3A8tdMcwGcxiTfrHW3sa6sZLT9EpmxAXTnxE5TnpzsnDMwk4IqO5A2JMyRDRQBGDExFf2pAP9CNl/9Cuwchcv6LBZQiKufskzjKkUKeVPkqAQuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXxj4Apn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e6cec7227so552261b3a.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762696; x=1730367496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CPLrrngokzuY0+Bs9QdrYJltx7NudqNJiilD478Iog=;
        b=UXxj4ApnpvQkw0F3/K09fWoZFyOgKct98Ut2qzlQ4GwobIyiOF9DiUK5mDALT+SS9I
         6C5Y0xDOMH1G1AdXpK8UdSdBmQLxAw8uGedbWN8y0qhRNWwjrTJKVG1oXiZ3xrq98Xu1
         sUmUbEQvDDFKdKvgCikRXO48FPbirJxo/+YfrC0G/RPjZ9huCW7YgsK0fE0EHRFsOYoe
         EUyealhzNhaWoUrDVE0/B8OEqHquuOdB4yD9SpDBLhXOhdIoz52pow+ZBtNiKezra1z/
         1RSmDTJg02xlDShAXsFygOP4HSKKFaZxPv7vPgdLBkzYN/3y5OGmDjFVITtys537i+CP
         xblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762696; x=1730367496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CPLrrngokzuY0+Bs9QdrYJltx7NudqNJiilD478Iog=;
        b=QPVfMvX3GIFV2M1ImU+e+4Fe4M6M8aFvgkAXIiQhGSKSdciQqSW48mmMIPAlZRQCOT
         JfJTifK8DJvtch4P5dKRrsZtFe1azsSeCKihT+U2uD/V3bu+uHHtWG+zljrGX4BwNNPz
         uCH4h283fJIsAojIi29Ixm3uJyFnwMKRe8nREZ9w1JO4aREqJ+QXEAd1Rs9gj589GKy3
         fkSQkfZHoHYf7pQAMR+hNY6VYYa7gxfNV9txtM/M5N3/LDjaCIrDtFmL0gjoDy9o46b7
         P+T43cG79VWJsEoL74gVAAhu2NSdJzwoNkrKbf+O7LKQqJ3nfO4BrsBtuKoF392OmsyP
         xpyA==
X-Gm-Message-State: AOJu0Yzw4Bs6+j58BJ5Tei9Irw6ZAQR0aRXriydTUKLutsT0/hgYDAgO
	ABddK/o1WR/sriWZry6FmcH8GK+GvYufD8zQzR4aDYFUqoTZ8ImD
X-Google-Smtp-Source: AGHT+IFj1OYYx3TmNcFDIXrFDzr+agNO+o0nHtIRaYkuGaiMPeLv013Kc0D5ZqY8p7/tMHEbR/7cwg==
X-Received: by 2002:a05:6a00:2295:b0:71e:692e:7afb with SMTP id d2e1a72fcca58-72045e25427mr1311724b3a.5.1729762696176;
        Thu, 24 Oct 2024 02:38:16 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm7613923b3a.131.2024.10.24.02.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:38:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
Date: Thu, 24 Oct 2024 17:37:42 +0800
Message-Id: <20241024093742.87681-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241024093742.87681-1-laoar.shao@gmail.com>
References: <20241024093742.87681-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We previously hooked the tcp_drop_reason() function using BPF to monitor
TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
To address this, it would be beneficial to make noinline explicitly for
tracing.

Link: https://lore.kernel.org/netdev/CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>
---
 net/ipv4/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc05ec1faac8..cf1e2e3a7407 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4894,8 +4894,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
 	return res;
 }
 
-static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
-			    enum skb_drop_reason reason)
+noinline_for_tracing static void
+tcp_drop_reason(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
 {
 	sk_drops_add(sk, skb);
 	sk_skb_reason_drop(sk, skb, reason);
-- 
2.43.5


