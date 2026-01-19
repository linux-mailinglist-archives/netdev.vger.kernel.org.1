Return-Path: <netdev+bounces-251184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 557ACD3B35C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 912DE31079BF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341492E888A;
	Mon, 19 Jan 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlvqXKJa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FF2C3252
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840801; cv=none; b=dqW+zc1OqHvVSDjLrHW+It/PtrfR4mEwQMTVMnVhlwOewHLszBJ7+jWoDDYpX93htQB6PfcKe2HmmfyYk4k5wZ5UTkNU34m1y6L9Rv05cIvYgZk3A5ZH4B3+LOyFMrAwr/n+n0OVPGEMnIOzdrDTgKPSBq36/T4RiF91zz+Coh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840801; c=relaxed/simple;
	bh=FwA00Qj6SIpCup/e+CsmfjGU8+jsNtiuUTx7m643M80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jBEovl/pysHwqpVcZ6ucv0AbP0ft3ocBrRTSamdoKVZABsspJGXg10hjTsKzAtW39I9eHgnqjfj20JFtM7QgPIOer9n6tgRJDOcZrXh1R9ncKCZkTIuLVfmgSqdBjPbu+m0ZY/HakUWkGtFCYIUZX4g9hk+wI+J5aLAA5I4VKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlvqXKJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8DCC116C6;
	Mon, 19 Jan 2026 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840800;
	bh=FwA00Qj6SIpCup/e+CsmfjGU8+jsNtiuUTx7m643M80=;
	h=From:Date:Subject:To:Cc:From;
	b=LlvqXKJa9rTI3wtjTwnpulp7vZyoqwvueGyoXUZvg2L7MF0rwbnMEIeVbP+rGwmzv
	 5OKZyqpYGKnq3dDC0n60AyJroZ1YODX9+bp/Tg5zWN34SzLUdIrUodXoplJIOMZD7A
	 54BC6KeVDHArMUPxN3NEgMPgWmcXK5TNHnryRHnC0zPhE7X2sQQ27R/SZQ/s8FWtfO
	 50ighej7YFkBBMZojvLXKrZ3pIl6y+xq7DgSw8xvRgfxb9IM8GTyJJv0rEvyL/fzsV
	 dSt3sH1gSytIybi/kNYPdJjUmkerUQxrXddmnwSAl/PkcAqo0koudZMrNL2Oe7Xyiz
	 wmtDL30gs/sdA==
From: Simon Horman <horms@kernel.org>
Date: Mon, 19 Jan 2026 16:39:37 +0000
Subject: [PATCH net-next] octeontx2-pf: Remove unnecessary bounds check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-oob-v1-1-a4147e75e770@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEhebmkC/x3MSwqAIBRG4a3IHSeoA8G2Eg16/NadaKiEIO49a
 fjB4TTKSIxMs2iU8HLmGAb0JOi4t3BB8jlMRhmrtHYyxl0C1sMd3p7G0yifBM/1vywUUGRALbT
 2/gHfyFdRXwAAAA==
X-Change-ID: 20260119-oob-ee6fe9cf6d2f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

active_fec is a 2-bit unsigned field, and thus can only have the values
0-3. So checking that it is less than 4 is unnecessary.

Simplify the code by dropping this check.

As it no longer fits well where it is, move FEC_MAX_INDEX to towards the
top of the file. And add the prefix OXT2.  I believe this is more
idiomatic.

Flagged by Smatch as:
  ...//otx2_ethtool.c:1024 otx2_get_fecparam() warn: always true condition '(pfvf->linfo.fec < 4) => (0-3 < 4)'

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 8918be3ce45e9ae2e1f2fbc6396df0ab6c85bc22..a0340f3422bf90af524f682fc1fbe211d64c129c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -66,6 +66,8 @@ static const struct otx2_stat otx2_queue_stats[] = {
 	{ "frames", 1 },
 };
 
+#define OTX2_FEC_MAX_INDEX 4
+
 static const unsigned int otx2_n_dev_stats = ARRAY_SIZE(otx2_dev_stats);
 static const unsigned int otx2_n_drv_stats = ARRAY_SIZE(otx2_drv_stats);
 static const unsigned int otx2_n_queue_stats = ARRAY_SIZE(otx2_queue_stats);
@@ -1031,15 +1033,14 @@ static int otx2_get_fecparam(struct net_device *netdev,
 		ETHTOOL_FEC_BASER,
 		ETHTOOL_FEC_RS,
 		ETHTOOL_FEC_BASER | ETHTOOL_FEC_RS};
-#define FEC_MAX_INDEX 4
-	if (pfvf->linfo.fec < FEC_MAX_INDEX)
-		fecparam->active_fec = fec[pfvf->linfo.fec];
+
+	fecparam->active_fec = fec[pfvf->linfo.fec];
 
 	rsp = otx2_get_fwdata(pfvf);
 	if (IS_ERR(rsp))
 		return PTR_ERR(rsp);
 
-	if (rsp->fwdata.supported_fec < FEC_MAX_INDEX) {
+	if (rsp->fwdata.supported_fec < OTX2_FEC_MAX_INDEX) {
 		if (!rsp->fwdata.supported_fec)
 			fecparam->fec = ETHTOOL_FEC_NONE;
 		else




