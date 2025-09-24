Return-Path: <netdev+bounces-226066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FEB9B901
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68405170E8E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1B229B16;
	Wed, 24 Sep 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsoJOGtz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BEC148
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739590; cv=none; b=a4/BXdxJyhW3w11nuXIfiH7tjK/maoQmEruhtqP6W+eiaLL1MvrIVhtx5HDFe1uYtlf04zN78dkMLDsMbzUQbw9uYbrzlGYRNxW3ZiuNlJLwwHdfmLVNvjKdgwt+zaXd2O2EyONzgFvwtNyuhO57WNAgzkhqU+wAlTX8okastYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739590; c=relaxed/simple;
	bh=ha6BFUC4T/Q6VozDKn+rykgqHLtrGs+IOmor6pbBA+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRok1kPAAOZZQrioFUET+QsEqgdFeSoaKv2+jkKjNgRb7ZR7taSlJ5Q+ivrsethph4GVG7G4hH0/0bMacRF46RrT+RUmALWnJ11lNM1ZHtlkkpAohP12zXRzeqJt7IfYpOPK2lmGju/KM5beD/TIQ+/24S1aGjaapVNhpDxLuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsoJOGtz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46b7580f09eso805355e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739587; x=1759344387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFpO7NaDBoM/00ShHd8sun6mXQgZcAqqGKqakqMmvg4=;
        b=XsoJOGtzo4b0N1Zd/YLD6dc29dh8kDgvfoG8dPf8iuI51dO2eE1k9T7W2s9I0Rsgfs
         lTiOfalNJr1d2GucUHFTlrfQ40I7VP8xU1xGxKu9qOpaLV33wZUGAt9DlnB5CG+/nmSb
         Ns9/nsI4hDh9Gttp4vVCCqrj1I2AERdxz3KYbRFuzEj/9GpdGBH4YsB1DbcGmLoxenlk
         aynYBmF5XRnnM/bvj2bLxMfv8gbqkS0pI9AVZ4QpYl0cWoXcDKfhIAWKy7jDIpODLdF+
         BpJCilEWgTEWKn7IAphEesUy+aRaohKrXMvYegpvvwhVfyakiJcqj9B8V4Mzomy6DslB
         sB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739587; x=1759344387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFpO7NaDBoM/00ShHd8sun6mXQgZcAqqGKqakqMmvg4=;
        b=eztpsgT0kSFgWjjFOu7ikfpcN0bzrhzxAjiAAvXi2kumaUg8DwCmbRi3n5163ckG81
         ONfspA8jZSHFZ2Ufs6U7Gwg9fhfve9Swx9X9xlGOksjFjdwTz2lpm3q8o+bqTVwCVcU1
         Heu+tijYn2XvDp2AEq2aw1n5n7W1zKwrrM1qz/pigIJSENUtE/XcaQ78SaN89bLkvWn4
         V3OfoE9vaNmkjOlW2iQcL7wnuD10KgQFvio0cNlEyHb5ckK58Zxf3HR4JpdFqkjFoKeX
         paH3y8CzJvjeQNwHj1XOVJy24DEhVJBirhV92B679sepqUbchBYqvk32zSpSOg/fyLt9
         TsqA==
X-Gm-Message-State: AOJu0YyxvKVGNHAI9MYWz0rg9ERXN/rKGbOyx0iuDLmVBi7mFFFSB5QZ
	YRZ9fFDiZMpTM9AxaSQSwIhHoa9GM5p8Dvmsqth2ujbMfXdp2jCJvYeMQrl9XflE
X-Gm-Gg: ASbGncuZ9op1JUmGhFck1Ky77JdBoEj1Lh78q3M8Tu9WJTUuwdAf9RkwlR9taS9tMG2
	kdptpU7+sKzeYUnmO9VqOsjsMEiEsoohjX5ZvMI5p+ev1u5262vkCc60B026fGhNj5QjTseY9l/
	VBZr02NKDFiQSSJId18PNVnYIRz6D6fEotPK1RvMhU3e/8PjhmT9zLLPF8drVcMWuMa723Y0xD4
	rm5L6PSouZS95WMX3RGsk0V6bnK3kDCK19RaqoSxxVKF4XQImWhi9EGJetkTPOEl/5j+p0HPbrV
	XAar1GFINzNwKpJmqbeUveh+zwo+T22Hu2SqSIc8iUTiO1CnAAOjZS+FwNANmuQUShOUmo5AHEj
	PS09wkUCjfOTLqimN
X-Google-Smtp-Source: AGHT+IGdr3oVQjg6k9t21NHdrqg9WYS54a5KIcV+PeWP1oIY3UVDi+1MqxpSu4ukYIoHiaWc9HNHBQ==
X-Received: by 2002:a05:6000:240c:b0:3e7:68b2:c556 with SMTP id ffacd0b85a97d-40e46ad0110mr957669f8f.26.1758739586515;
        Wed, 24 Sep 2025 11:46:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbffaeasm29121989f8f.62.2025.09.24.11.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:46:26 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next] eth: fbnic: Add support to read lane count
Date: Wed, 24 Sep 2025 11:44:45 -0700
Message-ID: <20250924184445.2293325-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are reporting the lane count in the link settings but the flag is not
set to indicate that the driver supports lanes. Set the flag to report
lane count.

 ~]# ethtool eth0 | grep Lanes
	Lanes: 2

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index b4ff98ee2051..f60a2338765c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1804,6 +1804,7 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
+	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
-- 
2.47.3

