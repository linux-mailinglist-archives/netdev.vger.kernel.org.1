Return-Path: <netdev+bounces-55536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC280B369
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF701C20A6E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8611188;
	Sat,  9 Dec 2023 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBi1y0ZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E71A1
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:21:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d053c45897so25983485ad.2
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702113673; x=1702718473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bblvwmXoSojziLcRhLwTRwHqvOAy0kdN8M7lX+Jxd5M=;
        b=cBi1y0ZT0XSFjVu1JLlx3bAvplkmmT0IOFFUngetLc/qo42nWVrjh5Y+SkR6E9AMZ8
         Eh+x2uYQHDhcrgg+vKY373So42coWMkro9XhK+VxeQdHRQ6B2pgH4L1e9YBcHMKmpEWL
         9EHltBPmYg2WhGiwisd05ODHw9T2Nb1iw6Gd1aEcmQHHg3/N51Km6TySGFzSI1vxwgK5
         5HzgrpYa7aKA9J8Vmv1HA1sbpxYwjn6FlTG8C8ihQ6/F46t10QtSVq6Aj1djxVm4zhjA
         TVxXrD+EU4f9DlCr/7HzoU+xY59/c279uTcO5T+H5XrjwH4H7jJjubHyjbE0hqC7o7Xu
         V+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702113673; x=1702718473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bblvwmXoSojziLcRhLwTRwHqvOAy0kdN8M7lX+Jxd5M=;
        b=L68HjCzhjidLes1r0XErq93grQ0Tjb3lqbr/SybDQtxi+NV8hnnCX369tV9GqrmsnA
         n5HThOQvqqCP6N5ZT3BrJkjSu2O0WJwRa20VEjvuEiccQllTF7Si254IHyVubhBFkEcX
         2kr1iBtbkDEhcXd3sdicSXGbMNtVLV0C8AC2npkAppx9h8+BfBJAKQsKB+3cuJSRiSZP
         +MgAQEYe0kWa10QEoI19eqMTCQ8ZSE6zvhylf7zNnnExrorN4gwD5xukBGXK9u2sihJm
         910S0BXzMQJImAhLFo6R7o0OMO+C0YIptCyMJJkDx0rrL7U5n/Wwj1F3WJskYGulhFmi
         GijQ==
X-Gm-Message-State: AOJu0YxY7tr6TnulStD3gh1uqHyhnbeBjSysTwBCQphTu50PjWq2fzqj
	8Ywnojjpdm/dBWtg+oebVZUvSwS0Q+3BIg==
X-Google-Smtp-Source: AGHT+IH4yx6pDxp/SMKIA9w78JG3/EcKyybmaFR7EE+OJm+nQ+almJ/er2zPN+uFjBiBOCZcl3c5kw==
X-Received: by 2002:a17:902:ce84:b0:1d0:9201:5335 with SMTP id f4-20020a170902ce8400b001d092015335mr1438142plg.13.1702113673325;
        Sat, 09 Dec 2023 01:21:13 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.37.67])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902f78300b001d083fed5f3sm3023978pln.60.2023.12.09.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 01:21:12 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v2] i40e: remove fake support of rx-frames-irq
Date: Sat,  9 Dec 2023 17:20:51 +0800
Message-Id: <20231209092051.43875-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we never support this feature for I40E driver, we don't have to
display the value when using 'ethtool -c eth0'.

Before this patch applied, the rx-frames-irq is 256 which is consistent
with tx-frames-irq. Apparently it could mislead users.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2: use the correct params in i40e_ethtool.c file as suggested by Jakub.
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index eb9a7b32af73..bf7ebc561d09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2895,7 +2895,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
-	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
 	/* rx and tx usecs has per queue value. If user doesn't specify the
 	 * queue, return queue 0's value to represent.
@@ -3029,7 +3028,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
+	if (ec->tx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
@@ -5788,7 +5787,7 @@ static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
 
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH |
 				     ETHTOOL_COALESCE_TX_USECS_HIGH,
-- 
2.37.3


