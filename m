Return-Path: <netdev+bounces-219104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A88B3FDC3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE03A9509
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CE2F6563;
	Tue,  2 Sep 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="N10i6Qhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B922ED870
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812424; cv=none; b=sIQe0mMy/XVNbgF1RoHLgo2DQ9rVFQvkayZwE/0/eSReEnX29gyVLtIyIEWdOhw4o1oL2TeM4LbN9Er6CMs8lvVEOf4D6AadVub72Pm5lb1b/Yan2G4woO7OYi9lwMwI7zojIDTmg7JnmbQQNI+bb2l95HFL4G1Ad0D3jvFhhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812424; c=relaxed/simple;
	bh=A2+gURc/N148EgdJvI3e8sr0XBnlatuJSrMEH0JkDpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1hop0u9UWJyacwlmJRqWHpDeNVMAhbaXTqD7IvBEYt70AFYbEWBxrE3mikWVScniwgnKtPNyr2PYoS1hyc8RigA250ChcaH4bh89hvnMDfoZOUkV84gC+b74SIiVMd/E+atviUvU/mI+dUK0L2zPHWokceMHBVLmRsHY8JQg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=N10i6Qhi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dae49b1293so305326f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756812421; x=1757417221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUpM+TfGUn1KWbFANwH41itX0SuJdYzT62GEMNpNdBY=;
        b=N10i6QhiNgy9zkyq1sUWfQcSvukPxD5PzyfWQGPpXlRO5Qmx0EZL1g7xmOlbd4qgKn
         iR0BPDE2sdxLNsRmvo041/AGUXqrX+BRJCWdCaeaIbdG/OSX5W8Svol4NUdcNCELPevb
         um8PFrdAf5hvQCwZeY4iBhjqyI+L4yUEJVvE+yO77pOXThcXd+EM8NRmCO1hJKR2QXPs
         vQrLabi+c7dahWoulLYXRKAz5VYtoNiAfRO8zdTUhlq4IX8pFEnfeJFFgblbICqJfrHP
         ySQ5W6J24bxsggZ5OKbINT10AEfZGI6fN9m6JzyM6WcWP5HIcsD6wYOtJNAooDFHvN9G
         BFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812421; x=1757417221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUpM+TfGUn1KWbFANwH41itX0SuJdYzT62GEMNpNdBY=;
        b=TVxcHJRd7s21i+n8rDRkbuX5PDrsXbHxx6GQQCivT5CWrq6MC2EtBmSmPZJgb0SENq
         tQb4VvYktEeUmHsyB0YHKjcPNQw7acOn6kU4kvv9kYqfR60O2erevfUAx0W8rek8EHY4
         yJODewreWEwd8im+GRcN6mXuKrqLwPh5Bt4e+ds1cq1uAex0M4LWACYcUw0CxeQFw/6a
         mRwVhksizz+4PEAy6wM3Jhx5CYcPpovVrNmt0Vq56Qgvc62VloxUNc6aP/yDVQDku5aM
         1Xl1MWyDf0v9ESFxQgXAR8wyEv80427YX76ptXJ2DkbmvcJqI/Bd1Tv0byl4JLdratMc
         HMXg==
X-Gm-Message-State: AOJu0YxagsQEeQQWcbNNRaHWBray77Vy7LSe9R0XE3jiOjHM8OWtDn2a
	x17ZQGOCFvaHBUsmJf6+aI0PJBoLP5ZJmHaLgA5SlKhEbQobF/RpsBS0k/BttlG/D4WgDwjnTb9
	bpW14jZZJFTupqqk=
X-Gm-Gg: ASbGnctzZjp8e5vjx/cNV1yISma0+OnRqGG7qV0igFC7EvaaTNw5gu9fHEK3AnvUpy2
	hT7tTF2fCryDMDRW8JFoOO5e+/xVQNWzaXmlLMckBBZFWdVEZPOF/NRJYXy+lCxGUY1FCrjipzR
	sJhL648trjEBE91PFxwvoEN0N59T36hI/HCN0wXtT6Fm3eg9VdCku2Cet0OK8TQPSYMqhMa/HjQ
	Ms/ZULGXGqGvwgoacFdo5kXsTZY7o6ZCDuMt0MJyzcVekG4ASXh0c4GY9XtYOXW+7bIbQIdROk5
	tQbJZ1KUhFiQB5gMW5Mt96WcPu6xG+Atbg1oJVyVnjMxvVGyQgEoHKniy0ArykYQshqUdUoHaZr
	2IE1He5lv3KAbLeIvCZvkucxQDtCkq1sQ381ewYI24C751FegZ9xHxBWfhzDLxHkHcTHEv+NgGs
	/i3TI=
X-Google-Smtp-Source: AGHT+IHmq39fnS6y3KrokT9FlJ2KUZN8EFFWkB7Waf4RcDsBBp8Lc328M2L3NudsU8dL4TAOfrhF4A==
X-Received: by 2002:a5d:5f4a:0:b0:3d0:c1fd:115f with SMTP id ffacd0b85a97d-3d1e04bee96mr7199641f8f.49.1756812420457;
        Tue, 02 Sep 2025 04:27:00 -0700 (PDT)
Received: from localhost ([149.102.246.10])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b9bcda91dsm12850315e9.6.2025.09.02.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:27:00 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	security@kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH net v2] netrom: fix out-of-bounds read in nr_rx_frame()
Date: Tue,  2 Sep 2025 14:26:52 +0300
Message-Id: <20250902112652.26293-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add early pskb_may_pull() validation in nr_rx_frame() to prevent
out-of-bounds reads when processing malformed NET/ROM frames.

The vulnerability occurs when nr_route_frame() accepts frames as
short as NR_NETWORK_LEN (15 bytes) but nr_rx_frame() immediately
accesses the 5-byte transport header at bytes 15-19 without validation.
For CONNREQ frames, additional fields are accessed (window at byte 20,
user address at bytes 21-27, optional BPQ timeout at bytes 35-36).

Attack vector: External AX.25 I-frames with PID=0xCF (NET/ROM) can
reach nr_route_frame() via the AX.25 protocol dispatch mechanism:
  ax25_rcv() -> ax25_rx_iframe() -> ax25_protocol_function(0xCF)
  -> nr_route_frame()

For frames destined to local NET/ROM devices, nr_route_frame() calls
nr_rx_frame() which immediately dereferences unvalidated offsets,
causing out-of-bounds reads that can crash the kernel or leak memory.

Fix by using pskb_may_pull() early to linearize the maximum required
packet size (37 bytes) before any pointer assignments. This prevents
use-after-free issues when pskb_may_pull() reallocates skb->head and
ensures all subsequent accesses are within bounds.

Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/netrom/af_netrom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..3056229dcd20 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -883,7 +883,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 
 	/*
 	 *	skb->data points to the netrom frame start
+	 *	Linearize the packet early to avoid use-after-free issues
+	 *	when pskb_may_pull() reallocates skb->head later
 	 */
+	if (!pskb_may_pull(skb, max(NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN, 37)))
+		return 0;
 
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
-- 
2.39.3 (Apple Git-146)


