Return-Path: <netdev+bounces-245274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B5CCA1EB
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DBB13014F48
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF562FB99A;
	Thu, 18 Dec 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR68igvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873C261B6D
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026788; cv=none; b=GoAVaWZLRpEb/Y6vxuWZe5/tDn+Ost+LYbSopMguyUuitTQuRc0bmOLK0W1/2XAXQtTcldGYkT9HaQjzziRkqbqhVFQdWdCimIShQN3qat+JGXas+JLMyJ0Q71PwNZw2hE4ukixZGUXekUtGl/yOO5Zd9XlFfH5QTZ3w5+8mvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026788; c=relaxed/simple;
	bh=WyvPve5LAklKO1fh6O+R/c1D7j2AerWk5OXJqsIwmsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf6rSjl70wsP37dNOfuT7N3ClH2KOJH+IOsw/kc+vQqk2DyJxZlu6CcZ6mQ5NQqObn9aP/oO4dRPv2ZfAo8dIBHhzBNwZQ7O8LKQ1agEyLzCU1APHVRkeRvp+dYiXkLVXBa+VkQc+Uv9vwzGqVW4T/gSpKf9IYrhAonnxMDJiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR68igvG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7e7a1b08e9dso9874b3a.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026786; x=1766631586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ue5x/b3wE4VR3QWVURKRvM1AZio0rSlcZc+u9XE/0k=;
        b=HR68igvGDvwNSFIYkmtguxQl1/Vx5asDPIGt5adBK10eJS/PxJ0oXVlYENeO69BtK0
         GtsPMRqLgkbX5jzqOlW/fAWTsbcNyEDGfygWzUxXgoDKxSo09KwQTxrnm3YVkh1/2wwL
         2GaB7VMS5ZnCWU3PJXmEorAw/FD0c8nzUJZUd69fxBI2adAJjoXQOXtj6npIAotH6jZA
         5bf9vd4SlHn+kGbXJYs8b1Hk6MRNPvKCYv7GiaEB3lLkgKKA/QX8JZM4MZo193YHIz6k
         7VIMyaHuGk8S7ROoebHc188c4bMXtIGTNR9oG48A4lMTcLzeMG5S+snbpz1zW8Ce1AHp
         G30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026786; x=1766631586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Ue5x/b3wE4VR3QWVURKRvM1AZio0rSlcZc+u9XE/0k=;
        b=fOxmY4sUXx++S4eBze1kEWTKDzSsMMgnClweZp+p05msTtcCcRnokjrnHJc62AMOQs
         u9cBWvGKXxthfDgAR4BEB5q7dUfxKWPUPGPV9qc8O9DGEAT7CTICWkCQPhrFkFGZZboS
         x2hd3Cd9NiV5khExpMCGdLGm4A3xssmKcwuQNLflV58r7o6Ix6Eaa27Sz21x06Pg7PLu
         m4O4GRVOf0V5fe4WL6IGIAgFjswzWLVRZc444y0iLoLNR33yoGxQFjszXvZEaYj2QHEt
         XhroWk+W9baZ0AHSG3irZHOXQ9OiGvXp5Lutv8Y5ruoEMPf1hjWpGaPLB/IrEARbRPQT
         gqCg==
X-Gm-Message-State: AOJu0YwfdeDOPi6LaqRtBe93zUQTCZByhZHniTRLaONEaCwK3eBSwB3e
	U0wrFHiZCBLhl9O5E9wR9VjEh6JGL3F+q/s4ELorjfO44GCXw5NnbrwU63PrjtoU
X-Gm-Gg: AY/fxX4gtqbrfknep8lKJ17mfcoKuaSC9NzL0E1JLmgd7YwAD79OwXwfk7tWKjB7AiG
	ATINvSx4gUl2e20do2mxC16UA+Zy3NfnGPV4udc51hauS/d5PDQJ3k1T8HZ6UCIibIjc+M0nHB0
	eH39aAsnzztYtijc0nvpU/bmZRZkB3rEgfKVgJUfjrUrxROmvGs02K4nrHo9ODzPG4bIinrXmKP
	Ff0X94mlGXnOwucnFoE71JPOYOgdIpGgOiM0ShUlrmEYJ2vl0TFWCPbDqXzg1C7Exk2RfXbYuDN
	MNP7IT/llF41127mUmXk2w/c6vvwoJrwmQaTvB/jjSYGt/jnpVXtEGxW4u0HQoZ4yh1QkFNmc8H
	Vc9vK3RzW07EsFME8sjEl6ol7zX01+SVxL3ZVkjakUTM/YPk918Z5C15/HlnetCjP9M6Wr2RFTG
	6ZUFSx+GMZlmcX6PDkq6xTztSN+wUtMKeMkY73LS6ld9PLtjk1XM27FdBWBYaAjYTWhf8cXCtd
X-Google-Smtp-Source: AGHT+IGeJ+I3A3UGPKjnq4HN6ND6861/cZnOg8n9srw8IdydNPC11hCj3XY9cF8qTnRop/yukfUIkQ==
X-Received: by 2002:a05:6a00:989:b0:7a2:855f:f88b with SMTP id d2e1a72fcca58-7fe53bbbe23mr551826b3a.3.1766026785647;
        Wed, 17 Dec 2025 18:59:45 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14a5727fsm800985b3a.69.2025.12.17.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:59:45 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Thu, 18 Dec 2025 11:59:22 +0900
Message-Id: <20251218025923.22101-2-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218025923.22101-1-pioooooooooip@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
the code used to perform release_sock() and nfc_llcp_sock_put() in the
CLOSED branch but then continued execution and later performed the same
cleanup again on the common exit path. This results in refcount imbalance
(double put) and unbalanced lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, 
while keeping the existing DM_DISC reply behavior.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


