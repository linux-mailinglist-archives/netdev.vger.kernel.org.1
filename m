Return-Path: <netdev+bounces-110958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3692F1BB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD04B22B0C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE31A0B0A;
	Thu, 11 Jul 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFdW4uxi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98F1A08C7
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735645; cv=none; b=b0z8/f0HRtASVKyzFbMpbF3L4jqKyc40pTaQ8dkVjDky8F04U5XR7UlUhqMhhfZy0uzYvk4WJo0lI5P/B0K5nI8uMnHT/W/odkDxjPQL6Mnc51rKf2l3J9ZTy1GpXQarYOvwiXSq86gtT8VeqPvZME9RLO1zGsrtwmadXR33G3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735645; c=relaxed/simple;
	bh=BA/4/lrYg+wmWQ4tVUW2kOuW7U1qId5Lb3PiH0KAVL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clhCWqutDvrbM9zD7MPXcfCJcPexMXxk8NyODYv/XJHSONdtkfdm629F7WrDWELgF8+mSOEaqr3duDDDb49cjDMDCOJUv9YEL9dgo9tvgi6sLMQbCVqpEoz+6ip5fzkk4i+s2KZr6H5dS4zBOq4CLm6qnxhSzXjIlvdp+FfOXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFdW4uxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC2C4AF09;
	Thu, 11 Jul 2024 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735645;
	bh=BA/4/lrYg+wmWQ4tVUW2kOuW7U1qId5Lb3PiH0KAVL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFdW4uxik8R5POIbb/rbdCFcnVDqVjiPvHWS3pOyVUtLlV+yJ48dbX5G5ss7w0lOF
	 H7k2KC/tg6pZwqWjHtdnxgPzBRstrgqAtrvKE0SXLsjpw3d5HUmRD4yslI3uMRb6Mu
	 LrOM4q/UQtpvLVom4mRdWQ0Ck0MXEFZMajSc4QX6bE91sqJV0B1/D9rTc8bJ8tq7z7
	 AerltfOib0AA/TORNq5SXNjphncLehigaMe7Dsom1NrxNCOlUfRUmsLTy56VhSJCv3
	 ZJuOHNqAimodK5BkKN6bKqiktorMaUdO9p1P0g8aSKeVFuQ7JFWSsiB9phGh08r5Bs
	 vKT7IiGt48RJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] eth: bnxt: pad out the correct indirection table
Date: Thu, 11 Jul 2024 15:07:11 -0700
Message-ID: <20240711220713.283778-10-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
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
index 74765583405b..8c30f740a9c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1856,7 +1856,7 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			indir_tbl[i] = rxfh->indir[i];
 		pad = bp->rss_indir_tbl_entries - tbl_size;
 		if (pad)
-			memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u16));
+			memset(&indir_tbl[i], 0, pad * sizeof(u16));
 	}
 }
 
-- 
2.45.2


