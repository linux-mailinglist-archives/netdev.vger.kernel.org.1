Return-Path: <netdev+bounces-172883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C896A56636
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F993B421D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9BE20F063;
	Fri,  7 Mar 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDFN9sxH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D081925AC;
	Fri,  7 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345432; cv=none; b=T9WHr/7J0WrQFaluetJrcbpVTnDFIXwzWqbXDmYCSCJWlp59v0yCLSRVuq+IyNytzul2NcD9Lsra3MYafdbiG2LOLWltK+tzt1hWwX5h4oCBRHpSrTqvam7ewCgbtPoYZ3bhNFAWjji1+2GoP4vRkfc9x3RoJ4IJQ1cmsdChEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345432; c=relaxed/simple;
	bh=pzjFzK1eLmN7NkZe7es86B7QKp3hIAs0x8XnRYMwGpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbzB9UxJPmAGs2VfGOip/13GKK68s5rv4ccUHPugt1CwmlWkhn0M4gveAtP9C+F4RXiMpi56lQmyaqUAWAbSzyCR9tjSq+oZZjSkiqlNsHUNQHqKU+wK3sSBMXRjC5StzI6D3gnxkWl7+qBAjYpJpGAWqF2XxqP4wUQB03ux6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDFN9sxH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso10335285e9.3;
        Fri, 07 Mar 2025 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345429; x=1741950229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpotCte8H4PC7hGvjJ+k1ZIol1Rkv0hHrJYEaQxCJ6Y=;
        b=GDFN9sxHD363h0Urtv9PLpBTtgf7BRQl2vIncmcWHLlxK8eqUyOxGe05qO9IxINKjt
         fKW8v3woffxBulBMgHm3ZYBvHJOq0iIU8swYt2SOQdCrJQ44i2dSHboV9bYU5p4gQdnO
         rhvAxgV1PXtMsKlvRCdyrN4tUDhwpzY3k/w3ucySdb57M9PvfxBJIpR/SmQe9RKjd0fl
         H5Y7nuXsbkNJeSmnYF72GidDo8gilGTA8LkNWsGLm9X/M+8yFaM5Bof13kC3JLUUGt+5
         O61qadkKEmUNszqrYMTUc0Z1gA5ofiG8+dxmyZOMh/W8NoSP4jb3sgXV3QkhmbiY63jS
         rGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345429; x=1741950229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpotCte8H4PC7hGvjJ+k1ZIol1Rkv0hHrJYEaQxCJ6Y=;
        b=R8gYi9lDyM8H1HQ823GqbseR6l6Hyh4rsZHPjSHl51fZPxL0M64vwnrpJGq2QNxxPE
         pYktV3wY8Zp4p0LjCl9XXwHIJw0JfFhwy2yR7OrfsQGqJbIJrS7MZPLpBiDIKLM3mojT
         J7gsq1w09LaoGm+EhbTwKm9G+aRlhfQmiy1be5oRpFH6xyp/TAvqjlxI8yfSrXP3yxby
         AqnmJgMOLcVYUHk5hRxg5XOI1SRlyvjkeVWZUjjXm4FMWmJG61R267dyoVY6V6iOGMh/
         z3mcIjkIwY2YlhBUM948epXtk3Mr/0Z9QO8IiDLJ/ABsXHxFqTuVGF1g5N56WP7csAmW
         GKfA==
X-Forwarded-Encrypted: i=1; AJvYcCWIPlWFQVqgMbXFRX5KRn6gA5YRcA+s4jY4UsLFZ+sneJEsGMr6cLB8g0lZko9QJy7wGeb0+u1S@vger.kernel.org, AJvYcCXc3RBJ+yFRbzzJ9dL5p/TcFRs8xQX9xHgiCipoOjgJe55CHP3lZcHBt1XM76uFalIbBDzBht9i8wXRCIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfOmq0BHQxaOrOE60oXJnqGUbCTYfbUHyCPNdHXyS0vq0o5Sa
	HOcd0XlXtbexcsODE8LZBRJhwKjl840b8+cCGD+NUxVNI5Sd2n4=
X-Gm-Gg: ASbGncsRJ8008uB0uakB7lgq6xTQkyc1gP+eQy/YRKcZpht/YREDoLqkCNSeAVM6xbc
	jF6G6XTBnS0hFgIDuhkXEt7D3MOIzSaNjsm9Xxtqg0g/OWOGQ1iLm1dtyYLND2iPDav58PzjQCz
	yKFJt1wAAQRbQHifGdAtQ5IoPpMZsB0oYJqpWjorrB7TtYKPmNReyRaf5OIWUCblIU36rZ8emfo
	U9JlfNbthJCPShJcqp5kKoOtArByx3gQDYhBHhfAVVMvZF2SF1wgEfDr7p2RBROD5O5KfsvZsZI
	1N5A5mfxKLESQiXpLQYEZDV7bdU635RDAbaV36RS88SM
X-Google-Smtp-Source: AGHT+IEHSVkCVjCtHLyZDimSRoBR6Awi60yFRDLb8q1oMuE9nsLyv1iPrBcITJfvZYX/8JUJYfxlww==
X-Received: by 2002:a05:600c:524d:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-43c6871c50fmr21332895e9.31.1741345428437;
        Fri, 07 Mar 2025 03:03:48 -0800 (PST)
Received: from phoenix.rocket.internal ([2a12:26c0:2101:6702::14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm5074863f8f.62.2025.03.07.03.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:03:48 -0800 (PST)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: muhammad.husaini.zulkifli@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] igc: enable HW VLAN insertion/stripping by default
Date: Fri,  7 Mar 2025 11:02:39 +0000
Message-ID: <20250307110339.13788-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
iavf, igb and ice). Fixes an out-of-the-box performance issue when running
OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
VLAN configurations, as ethtool isn't part of the default packages and sane
defaults are expected.

In my specific case, with an Intel N100-based machine with four I226-V Ethernet
controllers, my upload performance increased from under 30 Mb/s to the expected
~1 Gb/s.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---

This patch cost me two afternoons of network debugging, last weekend. Is there
any plausible reason why VLAN acceleration wasn't enabled by default for this
driver, specifically?

 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84307bb7313e..6fef763239bc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7049,6 +7049,9 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* enable hardware VLAN insertion/stripping by default */
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
-- 
2.48.1


