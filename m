Return-Path: <netdev+bounces-113117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D493CAD5
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDB7282F16
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B714830D;
	Thu, 25 Jul 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+S/o9W+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E421482EE
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946246; cv=none; b=LQ/A2OnC45DPVsfN005pFCC8ez6rgCmC2dhV9g3Wn7lAUM/zWTVeC0nl187gLHuSdd2RiIFWtGzvCKAfbbnAZB0nAo9x/UMPDcMAWUvc3WS9v8AeuQB1ugVHNu9LFv5ZKjP1maoUEXzb/AiFhfz7ZWz1vCmLbRYebK3WmruEdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946246; c=relaxed/simple;
	bh=grQdt8JMcVjRohxFP+2jPQF0HLdM4ScdnuJ+n4Os1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdAzaZSP3Pmw/9UpXpbl/WiO+INW6zWxpMVJOmHPdEgKc8sjn5opSGLwn7gr4nqT2dog5OXh77PADSG3ywtLHSCT+UkNcope/2m5lToweba0oMNb97K1wwr23cGw1MxGzNt0SyPwd5Nc1KwmC0C3U2acIHcbksYu+KBckWBrNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+S/o9W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE353C4AF0A;
	Thu, 25 Jul 2024 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946245;
	bh=grQdt8JMcVjRohxFP+2jPQF0HLdM4ScdnuJ+n4Os1Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+S/o9W+W06/bliPqhXfgKC9T90uKyz1bhtZvHt1MNC5ztCk0CE+UwpRDcFJ/qCGW
	 b2PjWlqZx026O5aRvpzuddXrCrRMPG9xTE0BTsLUCiiadVkKIsunlQ551/f6FXiwYD
	 u+TReVOg8HMTdPkr+f1sBCeya4kDIKf0ylyhlQZzpzyp5qmAvMbT0mNywABpOckAHf
	 WrwJm9lsnq6k8HJxqthaEu8k2Rl27G96Is6EptkDCrrpj7Qe4GGbw+KzfVVJip365/
	 5FYmaRxGUnik9p79RsLOUMJ6+Y1fQgykAuvzIpK8GlKkZJ7asHnACSJ2v1FhKKggb8
	 jV2SzXoQUcWng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/5] eth: bnxt: populate defaults in the RSS context struct
Date: Thu, 25 Jul 2024 15:23:50 -0700
Message-ID: <20240725222353.2993687-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
References: <20240725222353.2993687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in the kdoc for .create_rxfh_context we are responsible
for populating the defaults. The core will not call .get_rxfh
for non-0 context.

The problem can be easily observed since Netlink doesn't currently
use the cache. Using netlink ethtool:

  $ ethtool -x eth0 context 1
  [...]
  RSS hash key:
  13:60:cd:60:14:d3:55:36:86:df:90:f2:96:14:e2:21:05:57:a8:8f:a5:12:5e:54:62:7f:fd:3c:15:7e:76:05:71:42:a2:9a:73:80:09:9c
  RSS hash function:
      toeplitz: on
      xor: off
      crc32: off

But using IOCTL ethtool shows:

  $ ./ethtool-old -x eth0 context 1
  [...]
  RSS hash key:
  00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
  RSS hash function:
      Operation not supported

Fixes: 7964e7884643 ("net: ethtool: use the tracking array for get_rxfh on custom RSS contexts")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0425a54eca98..ab8e3f197e7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1921,8 +1921,12 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 	if (rc)
 		goto out;
 
+	/* Populate defaults in the context */
 	bnxt_set_dflt_rss_indir_tbl(bp, ctx);
+	ctx->hfunc = ETH_RSS_HASH_TOP;
 	memcpy(vnic->rss_hash_key, bp->rss_hash_key, HW_HASH_KEY_SIZE);
+	memcpy(ethtool_rxfh_context_key(ctx),
+	       bp->rss_hash_key, HW_HASH_KEY_SIZE);
 
 	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings);
 	if (rc) {
-- 
2.45.2


