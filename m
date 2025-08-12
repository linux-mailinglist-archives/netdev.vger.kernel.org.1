Return-Path: <netdev+bounces-212981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54349B22B97
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 421024E1D07
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550B2F5478;
	Tue, 12 Aug 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+qR2gYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C12F5466
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012227; cv=none; b=dt5GknPb60qH9f3KAuXjB52WAC94Xojsck1YUVYHU/cdx2HWedcjha3lEJSLI+gi3ZjFW5WZD6pbp4Rh93aS9BCxy+VSgIExVoAbM22mJO0X9P6lEM8hzXRjYV6WZ9uiFgDRdDC506hXJFMop/H34NXdC5MqQ932BFwxIbpgPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012227; c=relaxed/simple;
	bh=XkYYt1orzy92SI0EAeKTZGXInST9+P9vV2Cfl2tCt6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Log9d90A/3jROh09E8bdK3PU1KoZzkDQy6e95ZChu/REnArIVSLjFdYx+JjqZt3qkxYSiRdCyfP7AwvO1+yMyjGO41F9zg3nJknv0Dj8a0FsugQnKJsnsWQwjnn5hvfwqXDbmiWQCYUDqKzlxkJufiO9LCov0MKz0DUIEWNSW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+qR2gYl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76c0387f1edso569486b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755012225; x=1755617025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REuNat5RMCeHt4bUJ1vI8adkuPSQ7aoiv4z3ZnnE14g=;
        b=d+qR2gYlMIU9kdUporA2bHOkgIipsOB7ACVpIQU4gs592PM5f1vTfur623IfdDiRac
         OvpXdcdhEEMC+HoOC2PQJIsYq/Pda5AOW/0OB6sZeSRMC/AIpxWehBooWsFgdHZXyxH+
         HCVPFi28CXM/gRHlk2VeHkfLxsytLX4anFGbm1yzhluiWEobQ0K8V1DLvUgcmWfYPIMC
         nG9eEAtT5vydZgBu9qRiRfE2fWWPmhqaQtAkK1Powd9U7iUvuS6ErHuo9q/j+fwI3mJq
         psrMLmHCobC6UtkQ4fRhsI2/HyTlBqg04e24t4XMDMwA88tjG67ghj2fEZOenSdMWxLt
         OBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012225; x=1755617025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REuNat5RMCeHt4bUJ1vI8adkuPSQ7aoiv4z3ZnnE14g=;
        b=husEiw7XX98CJmSKTWwYUjpHHLIZ/WNW1zDXIWwLee+2XTUdPFFjxHf0Bjh9LF56cc
         G6bh8fTRbwD4oOGvGrkDDzY8gW9bhF5Cr5syYQPAqYfJzFSEwnyVi+7UmDmWl1Kh2WJF
         TiyF4S9QSRfdTkosbxyDMP/+P3mh0nLunAPT0QCcDSp8Ce8fUWPhVGx8b55kmrn6GpNM
         oKAa7O7nHAewkNuzJPel/aYQ1qaGDz7K/PRg4nYrcHUqL+5XWbYyG6u+7j1PPsQEXkL4
         al6E6aQ+I1LBGUBQIzhoI+/MB79fTKfdLOE4ZE1QCTHha59V6nct7UvA9Je697hseODe
         qNZw==
X-Gm-Message-State: AOJu0YxZWFZ636CbWPwYdMp7cQ8d0I9wL6YXRDjJ1tjdGeRrkFkrOY7r
	sP47DkOXZ6HA6td8IRia5Q1yYsqUxjSKinzlfQ1S9FPIyjcnubnt6EQ=
X-Gm-Gg: ASbGncvWI/1ojQ3HAl2LNmoEX0WS+2EWI71xcksYl1eBiw1IW8aJX3L7fhhsgliPAnN
	hnFDSK3gOL9QvasXxM2yS/8vI5kC7HHC0DLUM17uxX+N1IsPfp8JFk1r973x4Dz35wGt1jXQ37p
	TmedANuBGhoPJZ5NcXIgdeR4c43R9MX/SNv3QlJCmQM7LARuI4BFq9sPmDtRPt6sXQAcblPSaFW
	NF/w9hfyZJfPrm2GyF+FR4ojl4B5bwuLGYqaqYbJAfYHgABP0jmD+C/lA2L6gZgjC41Uf70PR0L
	zmjELiSjSKJgUjQFY5EkOHxhkxP/sdX6NFKlBHMPDZ9Oq1Lr8ISEt07ipQKV4WflcEZzBMDs07N
	z7nY61qq2qkLLLckMu5fIpYJyNuUgzb4CWKrW/8Imt5A=
X-Google-Smtp-Source: AGHT+IEfhEmTZpwELQb3fVbckzvSYoBBt9yRpuFqayVS+zrDQQTykA1EJ0UWjvRjsIZMEsqswmH+LQ==
X-Received: by 2002:a17:902:d502:b0:234:df51:d190 with SMTP id d9443c01a7336-24306922263mr11155105ad.4.1755012225103;
        Tue, 12 Aug 2025 08:23:45 -0700 (PDT)
Received: from jiaoziyan-Precision-5510.. ([46.232.121.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24309a18411sm8172705ad.146.2025.08.12.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:23:44 -0700 (PDT)
From: Xin Guo <guoxin0309@gmail.com>
To: ncardwell@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Xin Guo <guoxin0309@gmail.com>
Subject: [PATCH net-next] Check in_sack firstly in tcp_match_skb_to_sack()
Date: Tue, 12 Aug 2025 23:23:22 +0800
Message-ID: <20250812152322.19336-1-guoxin0309@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is because only when in_sack is equal to false
the pkt_len can be greater than or equal to skb->len,
so checking the in_sack firstly will make the logic
more clear.

Signed-off-by: Xin Guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a..293fb2cc8969 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1375,7 +1375,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 			pkt_len = new_len;
 		}
 
-		if (pkt_len >= skb->len && !in_sack)
+		if (!in_sack && pkt_len >= skb->len)
 			return 0;
 
 		err = tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb,
-- 
2.43.0


