Return-Path: <netdev+bounces-216759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA0B35104
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D011B23F95
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BF1D63D3;
	Tue, 26 Aug 2025 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyl2FA3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5F946A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172043; cv=none; b=QLVQ7T8gxVaEDK5cesPBWwi1TF0+OlMt4edB+5OCyawVSn8Fk5AEPtypIulB6UNuAcXxdxDYo3NHF5stqRJ8qwftN+Kl1hPPMRyBZAco1yyYjeWscr3y2P3/GLvRQoxL1KeS+tbi1KxGhZwySwIJZcOzIicnHKJDr8aRaz42Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172043; c=relaxed/simple;
	bh=HiqUCuh70fBu0yUklVqK99hfXR8i8FtILhFgy2MLqrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRLTBVk80gupdQnIp80BCNZ3tVnkXCcbP4+a0/KvmLPQaaXtpAI+p7dngnsDNAVSlItHLen/JuzgEG7z8E377qv0q0pwHnIRsS+BvhTmzndGgTgxneWN1hrIJo2RD1xOA+5izHT7RoM1AUVq0a1GXw8zQpRBZ4+MaY2UvbCcHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyl2FA3w; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-770530175a6so1289665b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756172041; x=1756776841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSlv97TqTa/rXtUYo+s5Z8S3YXbcXX9csJ1QtRjgwcE=;
        b=jyl2FA3w84rAEVW3CTzNkfREbWh/OVeUYs+1OuTHCjkJnQcpdpqnDcgqkO+4PJG/uH
         4eSgDzSzRdpXa5X5SGQBHQbv3m4K7AMXPtQCOcUHwvyCwZIxzink0ePytqWZcuRXBGVd
         tWMjROxxTOUHYb8d1BDw4OgL01mvhb4TvHG8OYCMH8wABSnTMh18Cg0dam41ngGn0gdL
         xywAE2WJ7i9B6LInxfYtpfNShyVt/xPA9M8hYNcyVdnCyON9z0z+88hneRUenSQLL7qt
         PTSUiaBT1VYzh8JDWOpTOqLJ0xFex0mKxkSJikj2x1b7i797ai07S0p4ky1w59yTd5/S
         0JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172041; x=1756776841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSlv97TqTa/rXtUYo+s5Z8S3YXbcXX9csJ1QtRjgwcE=;
        b=Plajh1d5GKy/Ai2OwBPGv5YwJFxaxj2lzERaefhEBbg9sQTDDgVMyzZHhYJinezc9t
         oriMkbcZkc4M+Yuajb9UJapiFD/zGVePfCSJMROYCkD4Ag85GCO/jfRqs5v65o6kFluB
         fjujT+59pV1O4D/EJYcskMzd985xsco0IiWjQXZHlKB8RPWy4h1uvZ8pLzhxhgLn4Q59
         Wq66aJNiGYc3fvGETK+qEMJY5eaIv6IU0AMHO/52ShRkB/bwmNbbVxi694F9gKai3WGR
         nk516VBSp1jypYnoPmIEU8ZhaglT1/NRG0ehhuS0UrVp170uQ/FWrovvfR7+4y+pvf+1
         yzRA==
X-Gm-Message-State: AOJu0Yy8rCZz4ZR+D9bZXflVTjh2KmUEU2y5h3rvDW3ayknWg0jy4Jlt
	P/dEy2bt6b6FnBVJn0B8KRg80H5PyWoELnlj0AGwvSWXjwKAqDED7aszGJMFr43x
X-Gm-Gg: ASbGnctUZ09xTe79ucUoRln0O3cxbYl24hAHzLtG6p4Qgbg73lWSpAPRwSvZi57tova
	TLtWTSGywCDsg3phX/BFDdKIPIql33/2hDGVmPfhdEPyI8eNHlsaD81PWGmV7LqfHe1o4dXK8Kw
	ya9Kmly0Ues3OMdMkUM/otgrNfqRPQzXPUemLK9DRKYl8Vr2wkEb/4lUgxHdf/EwMjomAFy0LMF
	lAh7BWee6N/Y0OdKH0qy8Fj/K3ZG1GM79C++9E+8WAYfaww7Bqff4mAii2Qff3qlUudijo3Vof6
	bLeN4ojleyygY49HD29v+CSpbdfClDaR7Qw6OKYyVzbXy1GsZinHnU/ot6USKsrL8vnbyOipOgT
	dI6agrNaB66BJMNdkBoXizszrouy0lqffv5BBe926Jw==
X-Google-Smtp-Source: AGHT+IGFs7zbe2NhttRO82NvujSyQ9LrIprl6vS96RYRAaes11e+QKt81G5sd31JcORWIMktxUYikA==
X-Received: by 2002:a05:6a00:190e:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-7702fa10026mr16837197b3a.1.1756172040792;
        Mon, 25 Aug 2025 18:34:00 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm6319222b3a.98.2025.08.25.18.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:34:00 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Acs <acsjakub@amazon.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Taehee Yoo <ap420073@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] hsr: use netdev_master_upper_dev_link() when linking lower ports
Date: Tue, 26 Aug 2025 01:33:52 +0000
Message-ID: <20250826013352.425997-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unlike VLAN devices, HSR changes the lower device’s rx_handler, which
prevents the lower device from being attached to another master.
Switch to using netdev_master_upper_dev_link() when setting up the lower
device.

This also improves user experience, since ip link will now display the
HSR device as the master for its ports.

Fixes: e0a4b99773d3 ("hsr: use upper/lower device infrastructure")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/hsr/hsr_slave.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 102eccf5ead7..8177ac6c2d26 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -143,6 +143,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 
 {
+	struct netdev_lag_upper_info lag_upper_info;
 	struct net_device *hsr_dev;
 	struct hsr_port *master;
 	int res;
@@ -159,7 +160,9 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	hsr_dev = master->dev;
 
-	res = netdev_upper_dev_link(dev, hsr_dev, extack);
+	lag_upper_info.tx_type = NETDEV_LAG_TX_TYPE_BROADCAST;
+	lag_upper_info.hash_type = NETDEV_LAG_HASH_UNKNOWN;
+	res = netdev_master_upper_dev_link(dev, hsr_dev, NULL, &lag_upper_info, extack);
 	if (res)
 		goto fail_upper_dev_link;
 
-- 
2.50.1


