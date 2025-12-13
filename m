Return-Path: <netdev+bounces-244584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CECBA8AB
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757E430B2EBA
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4492E6CC5;
	Sat, 13 Dec 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfVKc7oo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAA2D73A1
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765627872; cv=none; b=MvU3OZtUqENw4nqLwCpGrVC1O+x0z2ScEby6oHiTJhmKTRukAZGmUt51+b3YFQnzLEN/E1YR9Pa6Xvd8yxgjIQAetOyKKuyxx0s0NNuP2ibMhT8ZwAJkHcTdYrBgcC5QxQYeNXZYJKJIK184Yj3XNwmW5fjkQmNETcpRZ5NhOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765627872; c=relaxed/simple;
	bh=bem3wRQCjgBf23CbeaTBpqrxizxf/yxfEoMPtIJkq0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaPDr9aCxrSQsiYlIHDt1Wz0xCCjCCJ9lBLhSgwOXqNoOBKloHMuinSclEK9TixA2BygKezFdxUF+TvLkDframg4msvxRuf/aKXNPpNrl/Ftwh9fYhLAy3ZLVPNNeARVzL66j8r5vObElH2wgi4GB1CS4/Z8/69QQioZUSDgwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfVKc7oo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-649820b4b3aso3121432a12.3
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 04:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765627869; x=1766232669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TB2UVG2E+GFNI7iKxb5BS0GxMZTNJO+7f400h+yjSs=;
        b=kfVKc7ooZMAIVLONZodESFOhlGFV5+4TZ1ZJK/OaY/lBmPe8oEc7/5hw19WLGiLcVI
         9tUc5yHo/zcKL7FU4Fau47urdClw71QSNju++Zog3UJ9UIsTIfapuQW5zQs6sFdjsNhs
         tKKoyIi2c3nX/sp23KsQMTag5w+29YMikmhNKePX4ssWtc/vWO0zPl9J4UlmFSd4LYCe
         LN7B6F6lkk1IWx2S6TGhr95RkAT+dn2AG1NyxUatqzjCLtWeMQyOVhKZklUSxeM/i7x9
         DokEQRlmS8AerfAL/jWFyIUM+5OcKJ8PBcaqHLzjDlKSxzbybF2vzD3ccRMGPyHUChj6
         uINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765627869; x=1766232669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TB2UVG2E+GFNI7iKxb5BS0GxMZTNJO+7f400h+yjSs=;
        b=S1DYIl6cwu/36LIrL1/BpXUOXpU2LNu16PAmHN0ramq4HfbfqPYMBaySpgQ0P+p3qH
         lNzdUOZ7g3zUpCfUiaV9dRFGWkunhJJ9zl5+AEfTSYJV4q6UPcdwtau97DBtP6flNpKj
         H7byzKV5WVMPXAc2d7Mx8iQzyklYWAXmcHzEKEBDxVD5XuM0bIOvHn3xHWaG2pUBd41F
         OeMUQSW8ZLMbADdeMzq216xP7fiVlB7bE/NccL2hu6QU/LnvuDQvCwnattn5UdLqP0a2
         3gpNrOGwxabv24OkBS9YWcdhIGfnWP2i73v7qGlIz3FIO/QeAnawnzITYl3ljva8t8Nt
         Z5hw==
X-Gm-Message-State: AOJu0Yy9+arlFp7yFjrAotClzkqa33p11H8g5I4F5Mi7Zq6FKtxHXyit
	Lov+QWIYm7SZNtkUIEe2QfbQuX1vbHPNRq+tzPiQXbM985XE4MPugKNd4SoTjrgg
X-Gm-Gg: AY/fxX5xDwtfmoa5b2wA49kJGNijFzdhkNAJYhlVn6wFuf7kRJ+vvZp4dSw3Ist1wzw
	lJ4cSlriwBqxm6COrwnatnL3uMq9LENmgRRedFhdGQEH58+jN9QxX81Kt5ADIBUcu9vrbxDj381
	qqYcCP7m7SEp5W2SxDbU0qoLN6YOYq6JvXoaE44r863Hzp2QlLOeTj6Am15E4LiOKbaA4+4CxKS
	4a2jfqHE83kl4gwzvqDBxLO+ka8Fz7ATc0xlA3irVcNB8viF6nYayB3CLcIQDbxKZ7Q/LYhEeiT
	nMkdbcp0u+ImbYT0PlI+vX+/6qa/IfQSDyvR7OwUlHY+pwACVyiVG+3Fx7iANadwvhcE5MGUjy8
	0ZIfjnmzaAKkZkokC5AOdfKrTQbIc6TMWLMCm99LPZX5ILuI2112arboHysFaCT8Cg2ibiThEaB
	Gjkw==
X-Google-Smtp-Source: AGHT+IHUUWToZ1YcR2OijjGkCGcKb/ZY1XCxIUfEaXkG+kOwSVpZzbVfseRejI316MXaLh2SKyJOwg==
X-Received: by 2002:a17:906:eeca:b0:b53:e871:f0ea with SMTP id a640c23a62f3a-b7d23b37ea3mr524222766b.56.1765627869080;
        Sat, 13 Dec 2025 04:11:09 -0800 (PST)
Received: from wdesk. ([37.218.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29bea0sm851394966b.8.2025.12.13.04.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 04:11:08 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com
Cc: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net] udp: remove obsolete SNMP TODO
Date: Sat, 13 Dec 2025 15:40:24 +0330
Message-Id: <20251213121024.219353-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment demands SNMP counters be increased, and that
is already implemented by the callers of __udp_enqueue_schedule_skb()
which are __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb().

That makes the TODO obsolete.

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
 net/ipv4/udp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..60d549a24 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1797,7 +1797,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
-- 
2.34.1


