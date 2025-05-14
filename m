Return-Path: <netdev+bounces-190344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94393AB65F5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6471886988
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521621ADB7;
	Wed, 14 May 2025 08:29:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAD218AD4;
	Wed, 14 May 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211376; cv=none; b=Xyg84VhfTtv/k6Ange02OsCvmnrCYuaGtKkOmYnusGpGC4109fDkA5d/S1POS0PHVMw/LiC7NIR9goIO3VGX11zUVW/2QeSkrfNBHI13A9izH485J7GKVcvXM4Qp6Jd3Qy+4SwayTB3LgST3KR2pTlJ3ofAtfOeRY24AuMrk4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211376; c=relaxed/simple;
	bh=h/RoXrF9EhmVB749ozpnWoC+NsjWTVPhX7E7QNI3cwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NS/DAgac+cgHtZ0l7ozq8PEzIlO3Rz7sqiy9NhPKBIL/77z4Zto3sRMSjVGqvQsDv+V95MXeXMyea2g4IR0eGzFy4Jo4Sbwxl4XuhmxZua97VaV3MluXxhTSZhk8BCO6fvV9ofhhqnx/XBWLNg9+3Eo5h1LnretPDY/XjQ5L/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABnpAxcVCRoIdclFQ--.54183S2;
	Wed, 14 May 2025 16:29:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] mlxsw: spectrum: Reset lossiness configuration when changing MTU
Date: Wed, 14 May 2025 16:28:59 +0800
Message-ID: <20250514082900.239-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnpAxcVCRoIdclFQ--.54183S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UJFW3Cr1DJFy8trW3trb_yoWkWFXEkr
	9rZr1rW3W5ArWYkr1a9rW5Xr9Ik3ZYvFs5GFWDuFyayr9rWrW3JF97XF1xtw4kGayjqrZ8
	JF4fXa43Xw17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwCA2gkKjK6wAAAsl

The function mlxsw_sp_port_change_mtu() reset the buffer sizes but does
not reset the lossiness configuration of the buffers. This could lead to
inconsistent lossiness settings. A proper implementation can be found
in mlxsw_sp_port_headroom_ets_set().

Add lossiness reset by calling mlxsw_sp_hdroom_bufs_reset_lossiness().

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3f5e5d99251b..54aa1dca5076 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -797,6 +797,7 @@ static int mlxsw_sp_port_change_mtu(struct net_device *dev, int mtu)
 
 	hdroom = orig_hdroom;
 	hdroom.mtu = mtu;
+	mlxsw_sp_hdroom_bufs_reset_lossiness(&hdroom);
 	mlxsw_sp_hdroom_bufs_reset_sizes(mlxsw_sp_port, &hdroom);
 
 	err = mlxsw_sp_hdroom_configure(mlxsw_sp_port, &hdroom);
-- 
2.42.0.windows.2


