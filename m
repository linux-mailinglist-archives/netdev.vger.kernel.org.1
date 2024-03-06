Return-Path: <netdev+bounces-77952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1A7873943
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9081C2225A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEB130AD6;
	Wed,  6 Mar 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ/mrAqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0D130E3F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735657; cv=none; b=lTjJ1UDl6mUW2OHQUsEyYb/cyOutoBjNT4ChlADhCTFhkTdqOHpkBw2cJ+EfECDOdhpuQjDEtCsWZbIeyA00XExq9++rjl/Sbb7rqODVCq0MdIDGs8eIYTjwp9czqpegx4KK6zBN6LuEwWdRnpGymKahFAsw/meeah13U07QX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735657; c=relaxed/simple;
	bh=4K6n0+T/S6LGwEfBFR/QadcKdKE74eM9ZNsOf/TGf9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2UJAR7oXy2TSh0v/OYQ9AIlqrlcFqLSyFFb9cSS1Qhhd0qKTKK9VvgXMrouINWphVOJ9sCfcsSaBSTyYxtqWE8pmplY5N1nNK0TjMjLHDZwtyCkKHngHEIUEAvtzIR3afHVTE7qsNNrPGqU1qTm433WNRA2NzAEYllNRwv3i2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ/mrAqT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso2294763a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709735654; x=1710340454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Oi5P3ot2tE3z9TBltK3p+v4L3IWL0dkDLVy0vtf3jA=;
        b=DZ/mrAqTyAHa8NcdE8uWwn/UCuW4juZMCtJFCbeG15jM5sVNAEsHIDWlPK0wPrZCRj
         E203PORtCb/Y59Zkabf8W+cCOwPRUM4y+se8UicxQrEHLv/zXOCAPfDUSwaPzt3VM4gD
         GVRq8BLItsDwwd3c4+xU8DUR9IsJlgS3FA05qsUaK34aKN6HoaPv4TMFd1JcZjKlUk7p
         8FjYEwdN4OMXKBzi4zemk3AtJ8pcA9TObzAvCRKey0rY9fSuGzyoo+OGue4ADKsqADTP
         2vXFVLvZe9yBXjhbNjKHzrRAYefcWg+wsiptB6AReONlmT6lwPwSB7qz4FAGy23bBZYX
         GTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735654; x=1710340454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Oi5P3ot2tE3z9TBltK3p+v4L3IWL0dkDLVy0vtf3jA=;
        b=FOfEKVzvov1qwseXTdlzUm41clGDMLwxpn5lZQQrtFi1eZpO7z+eR4Ky5jjEkIJnPw
         a/fvTjyy46Hc7/WBBuDNl8Pppp41/85ubWMw/tG2F6EBCo2MPCcOx28I69aFncu3f5kF
         tpQJjyD6IxxsFbJbbl5g/z+F2osI6+izgeetEQ/xq+sT8BXDGGLur4Zl9z0qXkfHJl+L
         1DirYExvkcgOgJfYisrFfeEzduPEtRUKpBi8IVMzcLgHSn/yEp4pMvelubYzoz3lUBUD
         62vcu+MAoTOnhfWox2ejjNyqhqCu4lusJ5wFaA59cGyNRyEzBVGCBkMcTaQ7nIa80NbW
         gaVg==
X-Gm-Message-State: AOJu0Yznd442sLoZP3d9O9Azi7bEMA53vijXYmOP0VmULse3q+pGkibg
	Puuy7bkZSSCxt6wnsd27Q48AfKtxgS3esyaZvYdqODUIn1IKxJFw
X-Google-Smtp-Source: AGHT+IF2/C+cJFEvlMKIHRhnHvjS5+TB29BagwFdzgDuwnNTfswvHK0JuyWSH93h8f2K+9F9GV2Wkg==
X-Received: by 2002:a50:8e45:0:b0:566:7250:9ea2 with SMTP id 5-20020a508e45000000b0056672509ea2mr11152857edx.34.1709735653778;
        Wed, 06 Mar 2024 06:34:13 -0800 (PST)
Received: from pc-de-david.. ([2a04:cec0:1024:d009:4baf:fe04:4380:e7b4])
        by smtp.gmail.com with ESMTPSA id c28-20020a50d65c000000b00565a9c11987sm7293663edj.76.2024.03.06.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:34:13 -0800 (PST)
From: David Gouarin <dgouarin@gmail.com>
To: camelia.groza@nxp.com
Cc: netdev@vger.kernel.org,
	madalin.bucur@oss.nxp.com,
	david.gouarin@thalesgroup.com,
	David Gouarin <dgouarin@gmail.com>
Subject: [PATCH 1/1] [PATCH net] dpaa_eth: fix XDP queue index
Date: Wed,  6 Mar 2024 15:34:08 +0100
Message-Id: <20240306143408.216299-1-dgouarin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to bind a XDP socket to a queue id.
The DPAA FQ Id was passed to the XDP program in the XDP packet metadata
which made it unusable with bpf_map_redirect.
Instead of the DPAA FQ Id, initialise the XDP rx queue with the channel id.

Signed-off-by: David Gouarin <dgouarin@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6..988dc9237368 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
 	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
 		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
-				       dpaa_fq->fqid, 0);
+				       dpaa_fq->channel, 0);
 		if (err) {
 			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
 			return err;
-- 
2.34.1


