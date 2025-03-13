Return-Path: <netdev+bounces-174488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC70A5EFA2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D0D3BA55F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451A2641D4;
	Thu, 13 Mar 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztnmyabv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1484B26388D;
	Thu, 13 Mar 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858617; cv=none; b=WJvmxhrexOgQ4CV6ZcnpYdjV9IYnGmYdPL4YcBZ7ZZ0QnYr9RIFE9ZA0VZ1+k1zyxvNfN6gFZD8RO272DdKm57oOoNRYrJbr8DPZwBsgN3gLVTCqTYo2iAkz3v57Bq3A1IXt8q8nNm96RT49k9Nh4K5Q/fIvueFLpB+hBPrHuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858617; c=relaxed/simple;
	bh=ObsR4d09TiK8gM5mzUBcVhmllDBKA2du1QTZ7irUDkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y699KZOYKG+itQXbUrH1F4YHmPcqZa7ZCEYyGdXxtxLyQHDfuFXbSeKJvL1X4GXtW81mWpSUs3vyFFrd7fuQmCRoELV4DQSPm2dVZorM6dJCFtBYUsT12VkSyPDA1lWGOBmiIMwCsiKao9gk8w5v3IAEzjqNCvxYkN4Gzi3p88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ztnmyabv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948021a45so5960205e9.1;
        Thu, 13 Mar 2025 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741858613; x=1742463413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvQ7dzhduECDrLpiYmThBQ/FoZ4MRllET4xAKqhw1E8=;
        b=ZtnmyabvO6l3EGHo7EXzJ2hiq1hz3B+kYFEIWt8BECJtGBsUleC6g3Ehpk4MF9joD0
         jiqNGm+2lx55jGxRKovm/VFFHXyLbsKAMa05+mVnXwJoCprKAcPA0XtfXoDBMBupC027
         qxZCcWDy+osvaNbeIvj2Ajb6sFAQ+bsvGR6ika/3pBDlcZgO9gOg+zcsE6OyVo4fbBNu
         hbD4YBY1B0mVO3z/F22Dgvj5Jd5oTy1lW+L2kLHjKA72uGGzORtMzn6CakqULpDo3I7P
         4piVyVmY0x6oMnJE8kjYsRehcb89cgUTzzeT8YJ98p5ndtXTg8ACtLUI4b2HHEwn4CVO
         28ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858613; x=1742463413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvQ7dzhduECDrLpiYmThBQ/FoZ4MRllET4xAKqhw1E8=;
        b=qUGQRiXJhaZZCQSWzCisNDrP5zCuz+3qY14P2cPCafczZe1Ifg6cOB/Oj0t3lie6dl
         KoCGvlE5amQRr5w24XAmU0J5X+S6DXqp6t7KPBZoyJPZ1tK2MJPo9hqgs1M2Jk4/RQji
         Qx5qrHI7Y4QpLxz87KMlI925fgVfeTBMIl5S+3wg6EgOxDszMKFKV17KwYATr86YqW2h
         NAHNi2VRJXZ2uOVLU38G43YAIdP3PkIExHZufKf1gj87E7v3YmGmi8GOBpxzhEmvDx9S
         ESmLJKZGHWFOgAOYfO52XtqUvIDWhy5kGn8URE2CTOZsnQxY0TMoBJ1sJNCkWRDiVodK
         e2mg==
X-Forwarded-Encrypted: i=1; AJvYcCWLKVMZN0Ohvp0qgVT/yZ65jt+MKVQjYi7UrIyaWKAVAb/wTX3rI2P5k1Nh48xNTnTFkqE/Sdgn@vger.kernel.org, AJvYcCXh8BNpx5XnZXwWeNakqfyAeF3iJJCWjF6vRXwifdsGPNodgSw2ezQEHTLNU+CxWDQONAOpf7q9SowHfIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPe+Cg99DE0S96co2G8oo+h1HaczvqxpcarHKe1ytqVO1vLCZc
	laOeSUv/RJPBUVyC2ojSQy8mjAwvxEmDuCHi4JUEEUuDqW6XY9c=
X-Gm-Gg: ASbGnct0fTGaCA03gsugwZI3biDK9tBNCcpbdnt6NFqKt3o+bxPPRw8uZ+wvPIpLOyj
	qa/SDyK7IehtWAKx+aHU6k1nlEaskfhbTLTIh7byn0eOIIA0VavUiyRoaAGh9AWjIn6X/Rb+bQF
	095CDjIiL710hhz+LPhQ1YKnDoEwuZbmgHs3l6pFUNTwTpRHrBs4QZyoZulsxHZLNiVL9HuBr8v
	l+J+XnV1IntzUsheaUzCweJiNvyr3xzaGO3k4foVj+nuqEdKd3zZGDCYFg4E4Bv5R8RcCfI8Vy3
	Y/ljcAcaVuHvcsSUp/ODF7CKWtiIqo2VDMymwq8CvhT6
X-Google-Smtp-Source: AGHT+IH4SxyWBmHQREG2JRZBSCpc9n97vp7qOSWmSGUrlsH7EaBDPGRKB6Rc9iE5qfhPMASjZ32mWg==
X-Received: by 2002:a05:600c:1ca6:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-43d09f264eemr53241605e9.14.1741858612924;
        Thu, 13 Mar 2025 02:36:52 -0700 (PDT)
Received: from phoenix.rocket.internal ([2a12:26c0:200b:2402::14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5ccasm47178835e9.26.2025.03.13.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:36:52 -0700 (PDT)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: edumazet@google.com,
	kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH iwl-next] igc: enable HW vlan tag insertion/stripping by default
Date: Thu, 13 Mar 2025 09:35:22 +0000
Message-ID: <20250313093615.8037-1-rsalvaterra@gmail.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84307bb7313e..1cb9ce8aa743 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7049,6 +7049,9 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* enable HW vlan tag insertion/stripping by default */
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
-- 
2.48.1


