Return-Path: <netdev+bounces-216505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC82B342BB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F723A1A16
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69F286D50;
	Mon, 25 Aug 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6IHvAD8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913B278170
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130296; cv=none; b=oCK53/o6D8Ey8rF0tV5C2dc9M9cjb5gxxbRhZOLmDzNLmHFiaX1IRCVZUioFnNga2gy7keOzsakO52b/J6/xMuVqJ/op4dBgseFGWiqJ/xcbZHvTvh0EDCNGuxSL+aAIlrAWb7pFsfZe5e0aDRW0a7zNJRKV1ZAl3TTPOSktngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130296; c=relaxed/simple;
	bh=2p5wM2UFCZb9jguxu3GNVri3q+CZJN6XBykl7fafuLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sp//jilkhFQPlB1hOslWyviXiJPWJfg8OGiLOq8ffbfi9fzyWmBHV7KxSb3IMCPWQuOt0eZ5QkPbcSEID6sIMX8yITYDHUu6GqyFQntlosNAQ/p0UYkDA0dDyp4slvGqX6rLIlyRwxeIZMNJPzYGkdwuRAk2fKiQMh9oZ6JUAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6IHvAD8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756130294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6rLYAE4o72gWFWOCwqQighnmOu2LoKvz9PZ8NjIZRq0=;
	b=D6IHvAD8bp2O+ea+aOP79K6h7HzQKV5w9r2AWxHxkcoDiAezwAwY2rzYBrYSA0V2h2f+o+
	yVBACFL1I2omvFlBNAQ+KjQwMRGwVzA9lG8S13pB/hKcbxRaJs0qJtOCMN99kIfF1FXwW6
	S4T7olfaQXqMEbLgrVJkJ0kP32sJFZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-6uVYCZT2NU2ETXoKB7ct8A-1; Mon, 25 Aug 2025 09:58:12 -0400
X-MC-Unique: 6uVYCZT2NU2ETXoKB7ct8A-1
X-Mimecast-MFC-AGG-ID: 6uVYCZT2NU2ETXoKB7ct8A_1756130291
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c9bf5c8b12so704263f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130291; x=1756735091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rLYAE4o72gWFWOCwqQighnmOu2LoKvz9PZ8NjIZRq0=;
        b=B9iRFMXsiTL5K3sRyB4C8fd8AZTsI3KP0eNJiYrH8pBOh2A/pJZ7GopkBDT/ZUZa/a
         FORcYUSqVx6eA1X/Xuw/yyzuXA3HrqU+dJLx3dsYx9Dul8J2D7U5QXJRqOucOJPOe/Kp
         7nSAE7b4fYBPodSq+8zly2jWGC1kcwTtn1y/R9SljyFLgJEEoDLdfK8f17JtAsfgViyD
         qloktiPj8aAzJO4Ka8MhAGAJJkZ3Us5UDKYRVU5sIkXQtq7tU84JJ9cCzha54F1s/fVW
         VETf101tcD/SlgTNpyr0xfwAsRURxVsO7ZK8A5RX81lMDpeJgMmwKurhe+vzKQjfJz2S
         f+yw==
X-Gm-Message-State: AOJu0YxaAUi/V8Gz6UqjpWyA0Iqn3A6XFLaIo+F3ffsCTgKtVGXPstfU
	69qwWVvv2kHhfT4w1Q4BsIzk7LGx0RpdBMf/p0Sgj+WQo0efWcMsSQxrupgjianWkV59IvFw3ek
	KltD3aJ5fOBP3suNE/DfCaQKP+Bd4wEzW28LqeFao9kS+q8GmZaZg1DLb7a6hJv0XwX0ibHwdEW
	DG8yHJF6h0tDODLpQFC7geTif8USFiwhk93zTOaA==
X-Gm-Gg: ASbGncthZtJJLyzswDtlndctDIv6TdO9XfcfJwCxI8VOVlap7+BQ6yegKHIh5YEbfln
	/CUyqHlnxrQmKI0E3RHl6+TtxSszEX+GsQrxF81ioGQzR3nXOTAjjbsh2ls+soouh0ABhS4ZACt
	vgnFPa+BF/uX3hMk/ph55XSRYeoxr1G+KXWUuapfb7iquHqqS8BJOnYgtDKRn0zbPwiNSeLgpip
	rctrhqGAwTlYonFXOjfGvEYFxnfXR7PZxifvT8AqGYDcrRMcr1tGqPJi+SIxRmKFKAJr1qmlS2Q
	erYQKa1S+YOI72xTaQg223twILt/gpRrLq8cz/MDSDG8
X-Received: by 2002:a05:6000:4182:b0:3c4:edc0:28ae with SMTP id ffacd0b85a97d-3c4edc02d8amr11111608f8f.28.1756130291043;
        Mon, 25 Aug 2025 06:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWzlsgPWRnXPw9lVX7L/lBgOsk0n/4g4c80ovfzSSW9Ho2kYX30KTIYn2q9AYe4EjmlrUmTg==
X-Received: by 2002:a05:6000:4182:b0:3c4:edc0:28ae with SMTP id ffacd0b85a97d-3c4edc02d8amr11111586f8f.28.1756130290586;
        Mon, 25 Aug 2025 06:58:10 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm12581746f8f.9.2025.08.25.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:58:10 -0700 (PDT)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] sfc: remove ASSERT_RTNL() from get_ts_info function
Date: Mon, 25 Aug 2025 16:57:49 +0300
Message-ID: <20250825135749.299534-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The SFC driver currently asserts that the RTNL lock is held in
efx_ptp_get_ts_info() using ASSERT_RTNL(). While this is correct for
the ethtool ioctl path, this function can also be called from the
SO_TIMESTAMPING socket path where RTNL is not held, which triggers
kernel BUGs in debug builds.

This patch removes the ASSERT_RTNL() to avoid these assertions in
kernel logs when called from paths that do not hold RTNL.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/sfc/ptp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 4c7222bf26be..7d37d1d18f27 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1864,8 +1864,6 @@ void efx_ptp_get_ts_info(struct efx_nic *efx, struct kernel_ethtool_ts_info *ts_
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	struct efx_nic *primary = efx->primary;
 
-	ASSERT_RTNL();
-
 	if (!ptp)
 		return;
 
-- 
2.50.1


