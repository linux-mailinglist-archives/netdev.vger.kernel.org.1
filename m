Return-Path: <netdev+bounces-140694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F259B7ACE
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35AFB23572
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3C19F119;
	Thu, 31 Oct 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVCxobOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D176242;
	Thu, 31 Oct 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378307; cv=none; b=JdoHpt72+0xYTIIvU6BQNRPwtNydqRcPbVthWaoPhjnulMnBer5BE8tsFxguzYWytcjonCLvo8tMmAC0/ztSur1cfvdrKFQiTDWTEXgPZuYrSH+OFwbhKkI6duzqLCv8QqS5RQ6DfNOP1E6GV63HMxjblvm2nJUgJO4vrMtma1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378307; c=relaxed/simple;
	bh=Y33GuH7QLiPhf7+LTq1ps7KBHGskAfFyIpfkzgRvfrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJMD8nQ2SvPmdIMKzOeMvdyBsxDKRh7jF1cbYN+AkNLH50MfCED537u/mnKgw9awnrj8V3NkQX4ymEyzjXIJ/vifOryBiwWJ4Eh5xxTK6gSOW0/Kp1OwrQhNv9aAI4FCOYpmYZ+GY3gQp2MIEW7s/ec22LZIp0sK+caFexfTxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVCxobOI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso668151b3a.3;
        Thu, 31 Oct 2024 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378304; x=1730983104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4KSyovOfDrHV8NZhZMB3HLBTUX+scqNEzF0S7bESVM=;
        b=gVCxobOIxD8UEGf27Stv9GBt6vtkhMTOcK/TLhzGF04Oj6PTbE3aGByKPol/TfgBHV
         LHdky4vj8vznMD6op25hB3dzAXWZU4Z9lD/XPF4hmgjAS0Hihfj56jDn0UOsFiVfVGJu
         5gHBYGhnnNyOcpLyLTvSuBaSHXRhiv+9+Pu7E101YbPFmSyel+kwOALNeAMgz4fKp1yc
         bfefKc3dfrGzk8sUu/WMM7Bqp2RvZ9dL7CnC36YnLBFVGjDfFvorq3vv4cAJWlUG86G0
         VmZN2exGNrlqItUC1ZWPJLYgokM7/DAg9od7tU7CYGSsfXhkg+rnbbcueBA0uWyegr21
         HYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378304; x=1730983104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4KSyovOfDrHV8NZhZMB3HLBTUX+scqNEzF0S7bESVM=;
        b=IK4N1oJwHK6+5jgtbEkCfGLjHQQDvta16uKABzMUjmh09/sYRbsAZibeD/KkZBSyLQ
         YCrmefVxyq87WjzOzN+/if/nTs5jbwmEeXuaWbNq1ySQo0gfv4/7ALLFN6jcKxxUXb23
         Soe/h3aWM7/z/DAyzdO1LyGo+cX+wdTUV39h9KiRgMdUwLS+4NARd2Q+D07OgFRG8Sq2
         BYWTr0DjHOgwaduuc9+EkXjEsxnkg5K5UHPBre3SZ6HuyQ7QJgnAA/NAkQw026Z0oL4W
         3Sqj6zY/3bLIFfj5GTGhuNWeBBGy3hVX3ENGi/QG8odMran07VVCR3zhJ8KWddvaH/1x
         lU6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfo9Z8tjv8U5opzrN+QPWtMAmk/o/AKAYbvdNjv1wkcrSGiXmhXwchIqEA+xYzHZ4p1w/Ad5HbTjADgHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gvscWT3VAfETZ6cJcP/VO0t0AyMAEEM1cxTq7bJIlWATybOa
	3J0pFRkFbAQnhQ1VVdlqYqMzg4CGTnRUcrKINxVvAgGAD/Wsm3gdCaw5Ig==
X-Google-Smtp-Source: AGHT+IEnmJEbZ+p+tbzFPr8vLmUwpdgp7oxOJv6CIcqZsn3QmOiDgdAFjb05DCavEh812W/iJV9K3Q==
X-Received: by 2002:a05:6300:4041:b0:1d9:2bed:c7e5 with SMTP id adf61e73a8af0-1d9a84b89bfmr25790299637.40.1730378303416;
        Thu, 31 Oct 2024 05:38:23 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:38:22 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 0/8] net: stmmac: Refactor FPE as a separate module
Date: Thu, 31 Oct 2024 20:37:54 +0800
Message-Id: <cover.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor FPE implementation by moving common code for DWMAC4 and
DWXGMAC into a separate FPE module.

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
3) Bit offset of Frame Preemption Interrupt Enable

Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Changes in v7:
  1. Split stmmac_fpe_supported() changes into a separate patch
  2. Unexport stmmac_fpe_send_mpacket() and make it static
  3. Convert to netdev_get_num_tc()
  4. Commit message update for the 3rd patch

  V6:
    https://patchwork.kernel.org/project/netdevbpf/list/?series=904502&state=%2A&archive=both

Changes in v6:
  1. Introduce stmmac_fpe_supported() to improve compatibility
  2. Remove redundant fpesel check
  3. Remove redundant parameters of stmmac_fpe_configure()

  V5:
    https://patchwork.kernel.org/project/netdevbpf/list/?series=903628&state=%2A&archive=both

Changes in v5:
  1. Fix build errors reported by kernel test robot:
  https://lore.kernel.org/oe-kbuild-all/202410260025.sME33DwY-lkp@intel.com/

Changes in v4:
  1. Update FPE IRQ handling
  2. Check fpesel bit and stmmac_fpe_reg pointer to guarantee that driver
  does not crash on a certain platform that FPE is to be implemented

Changes in v3:
  1. Drop stmmac_fpe_ops and refactor FPE functions to generic version to
  avoid function pointers
  2. Drop the _SHIFT macro definitions

Changes in v2:
  1. Split patches to easily review
  2. Use struct as function param to keep param list short
  3. Typo fixes in commit message and title

Furong Xu (8):
  net: stmmac: Introduce separate files for FPE implementation
  net: stmmac: Rework macro definitions for gmac4 and xgmac
  net: stmmac: Refactor FPE functions to generic version
  net: stmmac: Introduce stmmac_fpe_supported()
  net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
  net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
  net: stmmac: xgmac: Complete FPE support
  net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |   1 -
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 -------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 --
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  31 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  11 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 413 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  37 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 165 +------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 480 insertions(+), 412 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


