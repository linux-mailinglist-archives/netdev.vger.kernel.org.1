Return-Path: <netdev+bounces-250012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A8D22964
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A6330169B2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8E2D8773;
	Thu, 15 Jan 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPK3lJHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1E1632C8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459256; cv=none; b=bNRokk51EhEF1RIuVQNKoNLVkapGz96s9nVyk3EnawatcPzKur9VzZzNwAwmpj8UDk1vvOpnRp1BDuwP7vfZLhl9ZRQb6cbGJYtBIKV34xnJX5W1rZQ1tLYAXoK8pD36ZDK+09hOx2ACj3v9p7E9wO/6igbbV8k1tYhOtPYyMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459256; c=relaxed/simple;
	bh=4b1rUr0N0IIKyRRcF7UQDJDLxGja8zuzlJhyXz/R6po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhkW/zr5iHD1glNyWOGOJa8Kr+1xdW6hRpiZHV21tCIJkuLKqCJ3eoMgKVxQXBM4jVBj29iiU8xA12JaCv5AeGCxoDPy/laEezZugNpl9Q9fYtfNwmweMmqWG3xazcg0yAh3LhHOhvH28vOj66xaPsrQoIJNrl3hS6D/tegUotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPK3lJHo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34f0bc64a27so243005a91.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768459255; x=1769064055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vky4xlT/KdK6YWVitpVisDdHQI89YOi/CFwhM/gHQU=;
        b=EPK3lJHoeGXcmaVBp/1R4LrrRPAib7bVC9JVyZ5Yd9STtac8IggRvEd0QrDVRQlNx6
         deygRRjmUyX1KicRsLCEKgmX3+o0njnKyaW7RjiaIjADlyDEGHVF+jvhiF0NuT70laeq
         1UWNEf29I5xtp9i2lwxh9KL4BsrkAhIWUBZBYpk3A9uaw2toi4VEb8CndpPRag68gm0E
         zzc/HK8i4wGqTcw48NZa6Pf2PLKbRJGWqEhnbgv3AphqYosg9l3aMyHE+HkVt67qrIkq
         uGg6lnuaoDz7umkFiDxxtM+DACScPbxWEJ9j8LqovzOm9jrv3Nvu+Jl5w4bjTzTENMou
         PPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459255; x=1769064055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vky4xlT/KdK6YWVitpVisDdHQI89YOi/CFwhM/gHQU=;
        b=R0VZs9Yzu8dSR7M8v4OV+LQoWlIuJdr4K7bymA/JKwtjSTmdS+lafahQhVpcOnavKx
         PNKKyxhJ57DY3d375ciVcNm1dDTIq1eIGWgdz5s7/h39Px2O47boEdUdNl11bBh7zvaM
         XI4rMTQ2QBY3XifCAanivhLFlcFoJ/IU66EQ0l/Qc/2qA5QS4zA+Yc+dORoYaQBNveZL
         QCd9JXgyrCgYUQFsANGrOrMgTKyXl3eigB76EvVpQJl7iQuwttTxagZ5hAzSVbCsW4rS
         v/bvUWQ74vSFl7e6VZDnLhoJ5Q07Gss+IL6iTZ7sVBD9sTAYki1Ivl9E4oSYjHLU0BAy
         Y7bw==
X-Forwarded-Encrypted: i=1; AJvYcCUwAJ6oN/ZnOWNLrtVDSi+PtLXRpWKwVbupEEC0OlHctsBfFVdAAEfPLBjhOaim9uLP3e7+abY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FSTm0Y0oeLjzIwUvQ10H2bDqdORqvPf3dhbq+/wAxfpSzAUX
	gpVv/uXHlOezpprAForfFUsgNk74TGM9oH6UkZA2vV/Rp8iWlFMviR2u
X-Gm-Gg: AY/fxX6cIp09oAbvDO9OV+ranim5DD3uXKKZ1FtLUVOI/eEUp6Q0GxkRXE8+320nRaP
	I+D6PyNftuEBprv/s514beaZqAQGDl+QBu9ZRMDFqrhkiubf80Ur4YYr2vSO1qBj6ycLZUJhcBI
	A72RGmXclqycnoEfMtKvzK9dWmPALxDkGbU20LmyM/JRVWUxkDX/Eo79wHwSfwniaX/VNerpga9
	vcqnLm8dqrz9IFR5vjJf7uH3+UAiO3ptRTrEXWMZEIe5AveC9jUAP4pwKGndUsFCHQr+I/UB43B
	m56y4GceeN7zwleKt3KdpVTXC7AkhtaZCJIHpLzckvaAJUBsYsOteIkckS3p+3d4/zxvfysFIl7
	npDwevjjad9ZeMxZRl8PPs/eILknfUVW4swTRLN+ukcv00vKARu+f0C4bJWMBLnH/YMnf7w0uj5
	lsq02deD2rt2551qerv6i+
X-Received: by 2002:a17:90b:5211:b0:340:b912:536 with SMTP id 98e67ed59e1d1-3510913ea6dmr4852462a91.31.1768459255024;
        Wed, 14 Jan 2026 22:40:55 -0800 (PST)
Received: from nbai25050028.lan ([2409:4090:807d:4601:85d:6566:6475:3c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc9e7e824sm24129855a12.30.2026.01.14.22.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:40:54 -0800 (PST)
From: Sayantan Nandy <sayantann11@gmail.com>
To: lorenzo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	sayantan.nandy@airoha.com,
	bread.hsu@airoha.com,
	kuldeep.malik@airoha.com,
	aniket.negi@airoha.com,
	Sayantan Nandy <sayantann11@gmail.com>
Subject: [PATCH] net: airoha_eth: increase max MTU to 9220 for DSA jumbo frame support the industry standard for jumbo frame MTU is 9216 bytes. When using DSA sub-system, an extra 4 byte tag is added to each frame. To allow users to set the standard 9216-byte MTU via ifconfig ,increase AIROHA_MAX_MTU to 9220 bytes (9216+4).
Date: Thu, 15 Jan 2026 12:10:43 +0530
Message-ID: <20260115064043.45589-1-sayantann11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change ensures compatibility with common network equipment and jumbo frame configurations.

Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fbbc58133364..20e602d61e61 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -21,7 +21,7 @@
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_MTU			9216
+#define AIROHA_MAX_MTU			9220
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
 #define AIROHA_NUM_QOS_QUEUES		8
-- 
2.43.0


