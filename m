Return-Path: <netdev+bounces-143564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF59C300D
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 00:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A975B218AF
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 23:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF481A0BDC;
	Sat,  9 Nov 2024 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="IMcak1cS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5C1552FA
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731194822; cv=none; b=d40WnzfybsR9CWpVKonY6LEY8rBqoqKPqVeLwtsvrtYUX5v/rnHLd6nyG+artAWV3KONqxf2RfE73o+Xs1v5C1yXQcyHMm011MU+09F5j3CIR+mJutH+nmx87GIPSRiymiNibvRmq45GMbQZ9KCIkJSYsxuI1E5wsfDU5VPZT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731194822; c=relaxed/simple;
	bh=bhfa8QVpzhJLNvVH2SZ6BH73Wyn+suzbcFJ9AvwI4qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an+sF/E95yBazXBHLBUHo/3o8OGKc3beEu6OBnNa/kHvzQ2N9amZkHIArFtAGtC9f4n9YQnyixiKkRwHInqjIaTY+bvmRKJ2mpgtTIwRX/X4ckh/DtEi+jUiW5dnJJMMrIT8hUs7klp+OiTBK9zX2rcJsUM4YpuJ5RLWVTat2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=IMcak1cS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f53973fdso3267888e87.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 15:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731194819; x=1731799619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUk+2MyJ3Nk7p96EL5x2+4zXYUEBWNJcqoIkZyN24sI=;
        b=IMcak1cSnlYk+2kyeu9r8Y/2HczW7gQZICMH98pzQgy+Hz3gw5afSoFNGo9yV92H+7
         kEn38frXJ1y3HC3T5MmdJYd9wmCpW34Bn4GkWCnd3LgA3tkfx7qW6fLYRVIm1pSh1aIM
         Hxw88+ibYk2pHC15Zo3TO4iUzAn5/BXD43h+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731194819; x=1731799619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUk+2MyJ3Nk7p96EL5x2+4zXYUEBWNJcqoIkZyN24sI=;
        b=ToNtsZWtov4e/5CuD1BeDmV9JBW+KDPo4PCtkGNJ82bxEhs5FDa0SGPtNRC9WyR+Q5
         R6ztvzgoGFfSaQQ5AEf6DZN8UBX2L3ZBb9MMGT2z1kyyVeqU1q7lDEqA9ZJaqUlouFAx
         ImoMXjqaAxbEKzMTer4t1+Ut03bvnFR4EnTGP1HisOxVVUITpXNJjaHW7O8QH2/AO/oG
         EGCMHjlM6zz/IAYkpUwHsm03jrsEyzBQL+csIl/W4Ohb3CSd6jFvPV5XWv7iDFLVvZrW
         E0exNR3KNul9Zn3vehPcY3rwM/VAD+zFnUy6WmXWsdJ3ywdbDWDEsKDCoXI6TNPu53Py
         Ez5g==
X-Gm-Message-State: AOJu0YyOe5/nliRC4cXvvesnn0udCPrwCNxkjgbeC2TDHDe//n2tySop
	Pa9lUNZLdVmogBTwVvNuDnNqEtdhuKCK+gtfv+wV2eSzKQP37wwYBVLwNBILC5svdGLCBfD2o5f
	bz6I=
X-Google-Smtp-Source: AGHT+IHu/CrOy1O8GUG/8a81IKfSyDxkXkDYyogMsyOSYajC01dxEovmO1L/UlKct/mw+O2nvMWy1g==
X-Received: by 2002:a05:6512:3d14:b0:539:edc9:7400 with SMTP id 2adb3069b0e04-53d85f13a72mr2843906e87.20.1731194818581;
        Sat, 09 Nov 2024 15:26:58 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aeb8fsm1057142e87.239.2024.11.09.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 15:26:58 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Tore Amundsen <tore@amundsen.org>
Subject: [PATCH 1/1] ixgbe: Correct BASE-BX10 compliance code
Date: Sat,  9 Nov 2024 23:25:57 +0000
Message-ID: <20241109232557.189035-2-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241109232557.189035-1-tore@amundsen.org>
References: <20241109232557.189035-1-tore@amundsen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as
BASE-BX10. Bit 6 means a value of 0x40 (decimal 64).

The current value in the source code is 0x64, which appears to be a
mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.

Signed-off-by: Tore Amundsen <tore@amundsen.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 14aa2ca51f70..81179c60af4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -40,7 +40,7 @@
 #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
 #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
 #define IXGBE_SFF_1GBASET_CAPABLE		0x8
-#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
+#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
 #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
 #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
-- 
2.43.0


