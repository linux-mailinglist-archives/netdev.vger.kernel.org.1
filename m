Return-Path: <netdev+bounces-94917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416558C1031
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6741F23AF5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9D149C40;
	Thu,  9 May 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECTG80lB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C715278A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260406; cv=none; b=TgOZtjUTQVgp7Vouv89vkWhJb+MvUoRroR351dfwptYVTgHqyW6j+Ceix3xLz11nQiBiL8C7IhRqlGzpUsK6TlQ+2plhbMiTQkpoay2J906cQadWnzo+TLoXEYwvt/yf9Ic6fIQcfU8XdecZtkrjqpToUu951UHT1z9XaqGyuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260406; c=relaxed/simple;
	bh=4Y5hE0JqjQhTWgaMvWIe+OKRtT7jhIwikn5Xh1NZ+u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3ZFz39zQxqPdtF29ohtWjdUQ41tSGhMBZ0A98OnGstXntZZA08aLqrq1k3YtjAIIrbcO8IfFPRL+oBYsZsa9XjQRvTFOdwI82jgzJBmVH0u72eapfOIlIXBv8agqASVV/bYdqqMUEc3hr+ThFThF5HiVdfz3Nmz7lQe2xkrrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECTG80lB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f460e05101so635824b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260404; x=1715865204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etxF8fofAFwmXuwTGyWBEzPHeQxHlfGOewcxQZxNiGs=;
        b=ECTG80lBAxlkqX1YzPU7hsdqWmNXJSGrdLOdNS6YF9aO9yK8SV7VHFQ4RVprOZwiCN
         ohrjEm6FgFwk6FZWFiSqmYX32a94o45sVa5OaWlW9FZj2FzVXxwjWj+IMoJBBakfDDMH
         rOH+JcnxWgVG7j9ENhKC0K5moia3mOqpkHHZQPUh1tzfuE7smv6epWIWRX69fWnMnDl1
         sbqrb7nvchOHJNF1eVDn+/Q+Xs6YJhKeNy8EocvAMWmRoM45rzezO1MA4S8uXWpoSnhe
         5wrcs7cG7EJdREIJoJqwKJtRmI0n9UBcO3T2G7ygUh6kQSyBEvgGC7ViJlYXEtvRk3Gn
         Trqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260404; x=1715865204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etxF8fofAFwmXuwTGyWBEzPHeQxHlfGOewcxQZxNiGs=;
        b=wSCEctVePot8uBNN/YANpnEOhbo6sibaV1BCpnjLyK7tEkv6i6NfgTUbLRlFS+eero
         C0UjVXYxLhXiEF45hHanKOMIcj4JTjkuYsb5hszXPUyGc83gn9qfCDpqBzf7lPM0S/iL
         dfB30pR0oSSR9DlXOOigAsi+Nu3X/DAmotyl1OaZTiua+CSYIXLCRMvKF7byzQXiJ7mr
         SebUlXt8qBKKuq9FPf3Zbn1Nq5MSIgYz3Ik7t4QpNjEN9FMNrEhVx5qbXSbOtS9lHQKI
         jBhnTuLqfl/I5cd2nvhI9kJnV7LNU3AOnuIwi8O6R+S0ql56ttD7XPUXA9hhw7c0MYMo
         r8VQ==
X-Gm-Message-State: AOJu0YxgFXBR6bPyKnmgbkERCxyXC8QF5ptwCtZzWdwYyMif5MMqJ/Ga
	0EZF4yDg6mGqrXr3eKLzQwTxt2hcKv8RjQOGNZiiF6SvFI5p0WmOcOgBvCjN
X-Google-Smtp-Source: AGHT+IFMiHdvHcDPDC66KQvx0qwMb4abf7o18W9wg7EO6rhbxOwucL1PKBd9zuc7Trxa+DV3LbLb9w==
X-Received: by 2002:a05:6a20:6a2b:b0:1af:af86:ce47 with SMTP id adf61e73a8af0-1afd1444bb2mr4229257637.14.1715260403817;
        Thu, 09 May 2024 06:13:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/5] tcp: fully support sk reset reason in tcp_ack()
Date: Thu,  9 May 2024 21:13:03 +0800
Message-Id: <20240509131306.92931-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240509131306.92931-1-kerneljasonxing@gmail.com>
References: <20240509131306.92931-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Based on the existing skb drop reason, updating the rstreason map can
help us finish the rstreason job in this function.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index f87814a60205..a32b0fa17de2 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -10,6 +10,8 @@
 	FN(NO_SOCKET)			\
 	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RFC7323_PAWS)		\
+	FN(TCP_TOO_OLD_ACK)		\
+	FN(TCP_ACK_UNSENT_DATA)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -50,6 +52,10 @@ enum sk_rst_reason {
 	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SK_RST_REASON_TCP_RFC7323_PAWS,
+	/** @SK_RST_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
+	SK_RST_REASON_TCP_TOO_OLD_ACK,
+	/** @SK_RST_REASON_TCP_ACK_UNSENT_DATA */
+	SK_RST_REASON_TCP_ACK_UNSENT_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
@@ -130,6 +136,10 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reason)
 		return SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE;
 	case SKB_DROP_REASON_TCP_RFC7323_PAWS:
 		return SK_RST_REASON_TCP_RFC7323_PAWS;
+	case SKB_DROP_REASON_TCP_TOO_OLD_ACK:
+		return SK_RST_REASON_TCP_TOO_OLD_ACK;
+	case SKB_DROP_REASON_TCP_ACK_UNSENT_DATA:
+		return SK_RST_REASON_TCP_ACK_UNSENT_DATA;
 	default:
 		/* If we don't have our own corresponding reason */
 		return SK_RST_REASON_NOT_SPECIFIED;
-- 
2.37.3


