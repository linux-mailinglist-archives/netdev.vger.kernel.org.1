Return-Path: <netdev+bounces-235229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD151C2DEFF
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F084E6C5C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942461A23A4;
	Mon,  3 Nov 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkt4JyOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847134D3A5
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199160; cv=none; b=LQowFL9CvStopDDoI/YkOJ5nT4g11Ivww4UjxBWnafQIIk+T5W3bVQj4RmphrRdmRsWGsbGmRfDCX3Y1/MY1V4S/vHYF1QvPmROn69NH00k5q6G4ODkIVyumeBcF+b0jYxLNIFnkyiQn156A3v8sTcr+kjmzxs0CBTjdaIDfvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199160; c=relaxed/simple;
	bh=IPTBE8hzRKTSZ+5Dq4mYL083Sn9ZhFw3PxQbIPLRuNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5NoymBFuXYXw9/UdsBP1GZy6U9UWTQRE8iuw6OCzNXAtjuKJhLHoVIezKkOa53Qx+8vE/QIX2VZ8gBnJ0vWb6iC9ButBHDTbfsi7UF0ML/60oLH+As07A4vYv+wOSX4oB7uw2joB45W60/IpUuoqew2U67TBwzB1Y4oVgG4y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkt4JyOR; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63fbbad0ac3so1024957d50.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 11:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199156; x=1762803956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDgrJGPwTkDqRWUIRmg2o0UWPQlQh5Pa4lWjqQeT3Vs=;
        b=Kkt4JyOR0bnSMdAAot+yuwREiDggObyb9FkBryzKkFA3AxVH8Tm/u0Fk/mF4zsTZoH
         mcxNtLiSk2jWYd7USg7j/iauoVq+6C2GBd/RSNTvgdQK9dwQY9dZL/yNnNjI+4V4x43l
         HNfO2seHzvyEMzP3QF7dxS832mPweLjFhxKbGbM0qz7h7+Lsbsh+CyLgtltX+oXFv7j8
         zCRSs10iH7zPnU6u/AtxZR4u7pPJX6gCjyDeHTe+R6qV0hNIXqArL+zR8F0v0KGXYkMB
         e2cJNzzxKZsA9dk9/EFm5tq9LPnX/JZDRl+q13wUwexKPIyg80sYF4/LkAUikIuIzsR6
         25VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199156; x=1762803956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDgrJGPwTkDqRWUIRmg2o0UWPQlQh5Pa4lWjqQeT3Vs=;
        b=QB1/KqUVTEcfgrSSHpykrObnZcrFR6ITqdxDd5ZB84nfPeDe7f416QJW1JQlVLW4pL
         tLIVrPaITJrwaHV15XUzZDrP0BPOxoJP8JU1AG7kAwqpyu/6juJYDlAgvagZek3qVCAI
         5oqszvBf3MN+E7eGjTMfeMSkx18y/RBdj03Id9xCwZgcyHFVG64utr+mMDj3B9BUWTd0
         gXRIuJP0r0pREtxtEYpc9QHeae8Ym3DLBE74kUuElND9e8xCzC97ZBFKbqyuL3+pgvZD
         Em7N9PF5GkfTdEU+P/S607UzdsDNeVGZ0FPU5YWx0gGsV3IcyOO+sWDckkyfAvubXp4b
         s/pQ==
X-Gm-Message-State: AOJu0YwLmBTFjeK8fBuo0SSOFsn0JtUehDakJ/iq9LciOjXoLOYeSzRd
	qNh4OVD9eOnc3f1LzRFuCDKFMdD5/S1dq6Vgp2Bi7GCbLAIuya9XmtK9
X-Gm-Gg: ASbGncvWlue3c0xYAX6xpVYN3Ct5e5FDIwxBN4TYzFgAQ4pa/uA0JfANXCBEpRHkBZa
	bjVhOdVlfUh+iurNiPWC4S1rPe3TQG4u3TMDnoLl3ykKKto/p8N1FNnTyyctUvwSTRE/AbrIr76
	2kINjfZLa9kZO1ChbD7Kna7xTqxVVjT/ntfQPrUxYnTColI0hbVmXdoP0BBeBtlWuD9hIsrgYP6
	2NsSZmDN0kVePbEtU2HmuAbmGCDyRmoCpnb7qhhMvrmnrHn72s8fiWKqWquDejdIq2vJYlJ5vvX
	CB0tCc26RQbY+yvgjKV9/0tnuYRrP0xhPk6TE2k5gJiQu5kc6bSvtoChFcQitshEAd3zH1k6Gsb
	w5i8KcDoc1JRLwgcGe2I22jamxWedySZCIxdQmAxtB0R/v5d/mrKsKEg/lwRShGZKE25jwiNGYK
	leKFQ+f8nJLNGgM6UcpjOsH5385NgLgGY=
X-Google-Smtp-Source: AGHT+IGNH0RPJesBeIcKsla8XUDm1bFpyEtjHsBQ6vejr6g2P49YD8AtgFLGMiN2odUrOWMz5ZeYtA==
X-Received: by 2002:a05:690c:6706:b0:786:8dc1:5242 with SMTP id 00721157ae682-7868dc1591dmr18450727b3.53.1762199156319;
        Mon, 03 Nov 2025 11:45:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869200367fsm3408667b3.42.2025.11.03.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:45:55 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next v2 0/2] devlink: net/mlx5: implement swp_l4_csum_mode via devlink params
Date: Mon,  3 Nov 2025 11:45:51 -0800
Message-ID: <20251103194554.3203178-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches. The first is a pure refactor that
passes through the extack to devlink_param::get() implementations. The
second introduces a permanent devlink param to the mlx5 driver for
controlling tx csum behavior.

Enabling extack for devlink_param::get() allows drivers to provide
more information in cases when reading parameters from hardware can
result in errors or unexpected values.

The mlx5 swp_l4_csum_mode devlink param is necessary for initializing
PSP on CX7 NICs.

CHANGES:
v2:
  - fix indentation issue in new mlx5.rst entry
  - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
  - introduce extack patch.
v1: https://lore.kernel.org/netdev/20251022190932.1073898-1-daniel.zahka@gmail.com/

Daniel Zahka (2):
  devlink: pass extack through to devlink_param::get()
  net/mlx5: implement swp_l4_csum_mode via devlink params

 Documentation/networking/devlink/mlx5.rst     |   9 +
 .../marvell/octeontx2/otx2_cpt_devlink.c      |   6 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  12 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  15 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 170 +++++++++++++++++-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |   3 +-
 include/net/dsa.h                             |   3 +-
 net/devlink/param.c                           |  19 +-
 net/dsa/devlink.c                             |   3 +-
 26 files changed, 257 insertions(+), 46 deletions(-)

-- 
2.47.3


