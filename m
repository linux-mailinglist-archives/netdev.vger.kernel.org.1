Return-Path: <netdev+bounces-185192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC7FA9909F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3F892146B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165052857C5;
	Wed, 23 Apr 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VQi8B4Fh"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CA280A3C;
	Wed, 23 Apr 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420904; cv=none; b=EDEu9cuOw5HjGQW/B+mpq04xCVQcCTZANVShALPZWjWuTIyICDneszivcY3xrU3WVGFmLGgsNy5Nf7s54TkB459bxU4pWfQn26gUOv9QQq+juSsdpv/0mcNPU87dR3YLXuCmrHX/kPfzO39eRIEPf5t7GqsRZ+cF5AmVAEAEJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420904; c=relaxed/simple;
	bh=sU7HrxlC9X3SIigWg3LaSJnHeY4oUGBQMCo+9Mv3unk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI8sZYv/Wz4Mx0JrPZLviYmZGH07nwkxOBXRdbf1QTLz68dhCrs6WYNiUvO+PuHe1BsrlGLVOhw7toVkUfJfs/CgCkNMAcKoyCRk/bVRakPj5N8WPSSUn6fZEvJtVtPK1zoC87/33Ut3/0V9fjjQVH0qStPMDqmWRtnpG664N/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VQi8B4Fh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BzRbmbdVH64WkPtUMsoKFbvdXYbRjm6+e5C6pk5/ync=; t=1745420902; x=1746630502; 
	b=VQi8B4FhqpWwxmKjmGUglBkhYli2Ffktkwg7iwzvrF1sPb54T7kjC8kPH3cbLM9q/ujwXLjIT2k
	4XVMxiO2EP/yXauRQhUzOWfPJ0gW8Px09YZ1fM9Zru+0+Xe5W0upysBK8Kze+ZBiSAHos5Bx8FwhO
	ER/6AYSJKt/bbC3YOGSZhAvDpnb4qsn8i3UiHdQhnigsovpze7UDOrTDbjM/+mHomdeLeGf51IumK
	fSmBlFT/SwyRBj+pjiR00ucYaE+k6VZcQnGviMtPYhSyfIyuLCZePJ8AThwxdfHAMI4q1KJSC7QSG
	MhTHtu3wp+BE+KszcnppakGPjHTROmYh8kYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7bhz-0000000Em2o-10Yf;
	Wed, 23 Apr 2025 17:08:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] net: ethernet: mtk_wed: annotate RCU release in attach()
Date: Wed, 23 Apr 2025 17:08:08 +0200
Message-ID: <20250423150811.456205-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are some sparse warnings in wifi, and it seems that
it's actually possible to annotate a function pointer with
__releases(), making the sparse warnings go away. In a way
that also serves as documentation that rcu_read_unlock()
must be called in the attach method, so add that annotation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/soc/mediatek/mtk_wed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index a476648858a6..d8949a4ed0dc 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -192,7 +192,7 @@ struct mtk_wed_device {
 };
 
 struct mtk_wed_ops {
-	int (*attach)(struct mtk_wed_device *dev);
+	int (*attach)(struct mtk_wed_device *dev) __releases(RCU);
 	int (*tx_ring_setup)(struct mtk_wed_device *dev, int ring,
 			     void __iomem *regs, bool reset);
 	int (*rx_ring_setup)(struct mtk_wed_device *dev, int ring,
-- 
2.49.0


