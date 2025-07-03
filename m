Return-Path: <netdev+bounces-203780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D985CAF72C4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE0D1C82F02
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E62E6125;
	Thu,  3 Jul 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GOPSKkuw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB82E5435
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543162; cv=none; b=Brqll4Id5XOHTCG9SxUjwRABVf5DZn/PsVCqBhFPqShriXFYLSNtZnLHXXCCdqTmj+RnDhX/bQGmX6uJH4WWjF5SxLzXJZ9/x4pzUkFjxUwshnCaE/wCRn9Ann6I587ulC2r3XJjyGY5XTMfGvkH8ML4kRVQNuCx/cUrMU9SPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543162; c=relaxed/simple;
	bh=+MygOH5s03WBamEE1JsTEBSyXCbxQSo1/+p7URAI3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAIWjAJP6IYBECJix+AJczCRy2ouf8WfWvznwaQdEYTjSSF+UXJOrYFuNtsgsPqLT+/GajoDK1qPyvKi9psS9dxWzenE496jZhNQg9FsdPI50za7WES4SfR6CBYEaKc+ny+GB9BfuvhSj/151ysd/8P9bi4jw7eu8yBWtX0k8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GOPSKkuw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so5757215e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1751543158; x=1752147958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWHkdbNA6gsGW3IvCwvedCkXrN6MyTNxVpT937ld2BE=;
        b=GOPSKkuwpN0p2lOMEoaMxzG0n8XemXHy0Kt51e9ig0bxPVvADhEJ1c7LxOFhr55oD5
         20OwnUggkNCc4wli4tJG2tcFEGX7NT5oodGxHgojFbzEwgF6cnFa6ukfCr52GzUoWT53
         os7a59t2g3dSxeK/zGL/I2SS/WNxuuooglCfMFE5B+MKs1kTN/Oo5MZM4W7Xam+qnvsk
         fi/n+uZZ7zS8C7GIvHVQNLTjgcoPHOQirz9KpMfyquO86ISULqqDqmYi1f5S2z+LxnhA
         Pu32bUhjRn6jamd3StGk106uUdF6dNCdyeUb4stZvAnp30CryOqBzz32c497MFCn6XdG
         GraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543158; x=1752147958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWHkdbNA6gsGW3IvCwvedCkXrN6MyTNxVpT937ld2BE=;
        b=wgujTZN2GkB/oSwlcPxJ7OO0/NMqvO3Zuqhl8v9cmAc4bNUTQiKXfMCh8oL4DmEVuh
         iEBtnLxbXhbBlFxt0zcoB5boqHtouXSut8ZSlSgRztIJkBqZ8vPDjTbB3qPfw4TiybcF
         E1uNTv+MbE8D1onssLfOO+Wqd6lKz+pG2g9n1WmhsQng9Jj3+JoPbP3oDgkOaqVZ+ADj
         kJmBfgpCmKzaxxtS92NoOE9DVQYVEb3RfNNeduMBFEXSVxBJsoFdmQNu8LuiqrCCQxJn
         h+NnescLH9wP6/rLToMO1pFnJahv5ymdlMmsArWOv0piEiXxtw9/IeFNcR+mfDPn24Vn
         2Yxw==
X-Gm-Message-State: AOJu0YzfHjhM9zBquHZEo2dD0i6ojQTwOoJ5Zrmgak9vZ56cWZO3bCyp
	2sMPyeT7YZGQFVHMUy1pZ/jZFIe4rHq1KbCw4t+vVbFxwqZbQWfYJ8P2x/qIyA6UPoS9sovXRSY
	wYtz6hkL0hg9WrxRvfieRL5SzOZeooFDSKAB7blyJQoEXSUvHZNkXXZZRjN5YoFdk
X-Gm-Gg: ASbGnctctftiy+8134d2DPamgoiDnBbaszwyegPKkxqGy2tMCHTOS8KwpsHujmjhqBU
	JpuJFDVA3obe69+SMVmau7tMZ5+kdvIZ8CmZerMm8hRKmFberbDkebxEY+LED91CUWwMxZTqVkV
	iXiewwXK0Q9xLcBUYTKC7KmNaHnVaoWc2Br6mnh9Xyan756mFxn11v9/iyjp7pR41vtTfBDJ0bO
	EgMRGxAxMmpD4YvNo9Y6XeowlFj8U5EIP0lQ9o4CJkrPidGwjSkdjZzOxsap8/kEzd1sF5mCU3f
	DAnYGHPTiwQYHg/Sr7tKz2gsNIV4s7B3i6UCJ2W9mEG2s4CMRScDoXyu21s56jV4REavE0YQIbl
	m61/2AsCB
X-Google-Smtp-Source: AGHT+IHq66TQeySgzUv365AkEmx6Knd+D1brvVjILr7pwpKpG54IB+vqf0wAWj2A1UkZDFJUTbs6nw==
X-Received: by 2002:a05:600c:8b0e:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-454ae8893camr15442475e9.3.1751543158196;
        Thu, 03 Jul 2025 04:45:58 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:aeb1:428:2d89:85bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be5bbfsm24174145e9.34.2025.07.03.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:45:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/3] ovpn: propagate socket mark to skb in UDP
Date: Thu,  3 Jul 2025 13:45:10 +0200
Message-ID: <20250703114513.18071-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703114513.18071-1-antonio@openvpn.net>
References: <20250703114513.18071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

OpenVPN allows users to configure a FW mark on sockets used to
communicate with other peers. The mark is set by means of the
`SO_MARK` Linux socket option.

However, in the ovpn UDP code path, the socket's `sk_mark` value is
currently ignored and it is not propagated to outgoing `skbs`.

This commit ensures proper inheritance of the field by setting
`skb->mark` to `sk->sk_mark` before handing the `skb` to the network
stack for transmission.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31877.html
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index bff00946eae2..60435a21f29c 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -344,6 +344,7 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	int ret;
 
 	skb->dev = peer->ovpn->dev;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
-- 
2.49.0


