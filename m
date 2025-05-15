Return-Path: <netdev+bounces-190684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864AAB8496
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136684A6E0C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22A29898E;
	Thu, 15 May 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ab5FD18r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC31D2F42
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307666; cv=none; b=rhvWVG8k6g1q98Vnm2rhKfdxkPHFQomJ0LkBb0Z7PtYFIqtjyGxikO8axMtdEKUjoeW9gnP5dAzZO960r1ob5WU5UMBYYe+dTonVUmqD3nwhT9NzdMJDNHQZrTsnf/zPkN14GOFkmqckJd9v7hlUpImjDuE22ORdHqG3PR4fPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307666; c=relaxed/simple;
	bh=E+12H282mcdFryKG7qFxxojQVvIQx1GKZKF4wZJE32g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbpmoZvGy6ZwCJqHq4AxfzVjXjPrfLb1wmQEneSc1lQ2gpXZjYhVT5mkVzHNCS25z0VQkXJp+X1fCAv6Y/G3FOYsJ6Ig8t2ULnZ4XiUaHH2csMlcrgm/Moqk/WcRy6l47j3bSB7OnwqgY15Nq4GI88aN5hBheqsiLtaEKIosm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ab5FD18r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso5736355e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307662; x=1747912462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHraCsh+Vgc+TzTmfcV1QhmIqCwKIyKVLyjfKhsYkx4=;
        b=Ab5FD18rssIQm7KPjhhptkhn+SZIrWjMyzWHbGeYolmw29KERtOD4SOLSW9LgmmiBF
         x6kmZ05KnPh6d/SNrCbp5zzuYnxvmHyKSLPzSFJHOE2KalJZReL2CoejOr0vtWZPvkgp
         FpaJyy/QWQ76xoqhaPkumVc0odk7yQqqZ6tbXAeM4g+Yx5p5+mgTBbPGb4vu4UDEWYJz
         1YdZPx5xteOoLKCGOafX9DdJoTXhgY/UdkoWOIlJYj7dpwMCfp9zxHOpZF2mQIT+Pva/
         g1KgB6LlsqmP2mjb987b3IXuyjvYsoVPp9SgBKirPyPRrIWMZRWxzgt7NDdvCacafJhC
         WeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307662; x=1747912462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHraCsh+Vgc+TzTmfcV1QhmIqCwKIyKVLyjfKhsYkx4=;
        b=l3SmEX7aTAkaNYEKgTG5khDmLcjY1PzHC/j019XTBZ/v/m6mR5j3/mby0Tp4j98rk3
         MLdv6EzVGqayUDDunc4q1Did00YrnddBtlzySU/mQ6zkEeOMdWcwlVjup8OUgA0SNO1P
         75/AHbrF/H1MZeMoN4q6dg3sfIUfSXFkQ2t3F7Fk1UQQMua4yqMsig2dDmcBglq5s1vg
         ADppMt+Zl6OFCdgxGr4eI0grnJR3AW6HsL309rlvoC/SSWUSuw9j2EO8M/Sybhs5SO6s
         /ol8XtofAPU+QlEuQvR82j9Dd+Koth6KZK9n0jwUvDoi+B7K90zrqmv7eipajKuLIyCq
         JQBA==
X-Gm-Message-State: AOJu0Yw0G6l9OZZ/FO7tBzSaupc1jbEAYW9UfrQ4rIcHiHRC1hUVKG+j
	3rUaJozHIbiuQduK41V3+kZrnZ3zMhabyLUoj5R4PVeVQdujxGjdopXc3VyCBL59ccQ6bV3NBWv
	B2oEySirnI/dJWzAyG2MFOkF2u73YAwsyUFQhdlng8Ni1SpFGrLfIe/zpwdSE
X-Gm-Gg: ASbGncuROaG7E0o5dN3/CNRQz4HsZCf2oDXCiVk/hehFxC6IZqAa3aHpYOJmvtRWTGH
	FNZLbEq3KZtEpkXLOBXUHiZA3clazHiXsCTGmZdetk+cg8bidG87ewIpjRYdRzJXqfbom4Sh2co
	AFwp/OZ6fdJhhgFXvEYysZmcJxf2/Kh+4He24q7tYdHlD2PJsukapjsm8HEMQBkY8kW0mbIqgcs
	JVHVzk+7P1NWDOw5mFxNn0k+8mAoBvUzF2W+kNcR06ukNVOvpUBnrZn6kgvvSz+J54F8x36rtbR
	5+LusPMXyDTnP6VaFo6VWzb1CTpR2borSpXjk7gEmxWu6S+ssYeY1a1TUUeSoku2GeDpRpxZylI
	=
X-Google-Smtp-Source: AGHT+IEg8I9nJ7XmRqGEKOCT4N8HedbnmXn0TVRtLhDwLyDDE7aBYqxyMue0WHmGT6eYaTM9MzZSeg==
X-Received: by 2002:a05:600c:1913:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-442f210f654mr76874135e9.16.1747307662452;
        Thu, 15 May 2025 04:14:22 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official reviewer for ovpn
Date: Thu, 15 May 2025 13:13:46 +0200
Message-ID: <20250515111355.15327-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sabrina put quite some effort in reviewing the ovpn module
during its official submission to netdev.
For this reason she obtain extensive knowledge of the module
architecture and implementation.

Make her an official reviewer, so that I can be supported
in reviewing and acking new patches.

Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 800d23264c94..9019bcbcd50b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18199,6 +18199,7 @@ F:	drivers/irqchip/irq-or1k-*
 
 OPENVPN DATA CHANNEL OFFLOAD
 M:	Antonio Quartulli <antonio@openvpn.net>
+R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.49.0


