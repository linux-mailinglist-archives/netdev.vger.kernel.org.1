Return-Path: <netdev+bounces-108639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A88924C5E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4071F22E33
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8401ABC39;
	Tue,  2 Jul 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAoEMuv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C115B10B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964107; cv=none; b=Y0TffwOUDQi0gFh58s433rBnogewQLUeUnBE57nyQuCldbR/VwQU0J5k5ZfK57me6FNMiD9r/y3FCK16mwKxJAYE52gevKBmuPhUfmldjjxX+qs+61QWSPZLyfk4s5gY8+fg15SHjT3hA1n9vPvWD49Ov/HTulLmwSGMyNtWtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964107; c=relaxed/simple;
	bh=/Fg/1IPJw2zaHYrxAlzmIitFyBAj3aDBS8y2TZqsQrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lnl+k67BFbfdZmDaK0qWq2j1MJiPC64v5YSyrGZ2kIqjE3xNxnhci5zA70LUT9tf0GFXY91XEzeaCd8QSTcPw09VDxsxEA1ThuhEvu8ntQcgc+jeSFNAn05Pzq+ZRSeDLC/4EI7mbPidswP9er+xhcwiLke533v/HL2ifuC02Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAoEMuv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F54C4AF0D;
	Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964106;
	bh=/Fg/1IPJw2zaHYrxAlzmIitFyBAj3aDBS8y2TZqsQrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAoEMuv4WWlsczJ7Eeqgz6UnbgU/tFODLKMIe7EdvsWJNOnlE48fNJoo0OguQowp7
	 CGN9I1K58JqxmdHO2Pqp/4rCejKWfQaO1/RvU4DoVO5xFpx2AnrdaAerD32HWcrmYI
	 XL/7valat1Sr9L64kbZ9inibgUisNtWXTvm+p97yt3oPKu61JIYhUtagYJHugsVElK
	 aPnhuertKBsSrQNaWMzVY7HwNWvGrhFHxjVDGhaxwKF/AOOdTyEfKf+GGWrAAqnV/o
	 qmX3cFVcZJec85cEtEt5Gs3Q7MFs+Bn4uJuP4x3m0TT7YNwLP7wklKICdY+I1jE5M7
	 m7i2+twZ8U2XA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/11] eth: bnxt: pad out the correct indirection table
Date: Tue,  2 Jul 2024 16:47:57 -0700
Message-ID: <20240702234757.4188344-13-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702234757.4188344-1-kuba@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt allocates tables of max size, and changes the used size
based on number of active rings. The unused entries get padded
out with zeros. bnxt_modify_rss() seems to always pad out
the table of the main / default RSS context, instead of
the table of the modified context.

I haven't observed any behavior change due to this patch,
so I don't think it's a fix. Not entirely sure what role
the padding plays, 0 is a valid queue ID.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 13e9b3b26f09..1d587846c394 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1858,7 +1858,7 @@ static void bnxt_modify_rss(struct bnxt *bp, struct ethtool_rxfh_context *ctx,
 			indir_tbl[i] = rxfh->indir[i];
 		pad = bp->rss_indir_tbl_entries - tbl_size;
 		if (pad)
-			memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u32));
+			memset(&indir_tbl[i], 0, pad * sizeof(u32));
 	}
 }
 
-- 
2.45.2


