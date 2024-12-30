Return-Path: <netdev+bounces-154512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30689FE4E6
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F4B7A1592
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60C1A255C;
	Mon, 30 Dec 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K8k2MRdA"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB121A00D1;
	Mon, 30 Dec 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735551546; cv=none; b=YLsFvvRL/yiCtExujn6tM8KENJ3FYCTj2LvoVGBuAMD3JPpzB4enZkrtXQuB8lu6X8n2k5ZfJ4NGmk/iVl4hZnzjdgvMKSXTzmU8CHf/uKGz3fMfHuxBtuoXwWaf4x9ktH0TCxmi4FRdx+cL0oGgFZ+u+HVl/1yGRJHhfuq3bXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735551546; c=relaxed/simple;
	bh=9ZuSoeAFQAofB7wyEUWP3Ntu938zG3edQVmDSPbPo+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5jXi3StmzEblr8rejxLokiME1GGTzMcwt6TgstnqYuzT6iVArso7qgHSDz5sudD1WMXG036myyU2CZTPofkMnI58ToCjaKSeFSBztGiUDMYzrbyMI8Pk4W9UcNA4d43grRBdp7hyYJkuKUA5gW/0ELxasUF4+S3ltpEx2DfmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K8k2MRdA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DKQjb
	PTLUIasbjW6SoVU4hmlLOVF7UKCxVjsVReX3rM=; b=K8k2MRdAn+UaMIlNJA3hs
	TKk8zrWXu1x/QXpaEzSUoBaHeVSU3sgPo3zfki1xahJSFyMH+4yDWVQ0KpfhzL4Y
	08SWINeULl+3W4x4upFRH1DtGzptigUcX9yelusVqwfUg8Ix2vpQ3f2clPRt3NzX
	+BTJA68/2bpHIcpt/dliw8=
Received: from hello.company.local (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3vxHHaXJna2tRDA--.14417S2;
	Mon, 30 Dec 2024 17:37:12 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: kuba@kernel.org,
	ecree.xilinx@gmail.com
Cc: habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	pieter.jansen-van-vuuren@amd.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH net] net: sfc: Correct key_len for efx_tc_ct_zone_ht_params
Date: Mon, 30 Dec 2024 17:37:09 +0800
Message-Id: <20241230093709.3226854-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3vxHHaXJna2tRDA--.14417S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWrtw1UArWUWFy3Zw17GFg_yoW8Xr45pa
	yxC340kr1xWFs0gay8Xr4xZF13uws8KryIgFy3K34Fqw1ayFn0yFWktF1S9r4rtrW8Aw1a
	vr1jvayfZFsrAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6GQgUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbioBfFIGdyY4tAiQABsn

From: Liang Jie <liangjie@lixiang.com>

In efx_tc_ct_zone_ht_params, the key_len was previously set to
offsetof(struct efx_tc_ct_zone, linkage). This calculation is incorrect
because it includes any padding between the zone field and the linkage
field due to structure alignment, which can vary between systems.

This patch updates key_len to use sizeof_field(struct efx_tc_ct_zone, zone)
, ensuring that the hash table correctly uses the zone as the key. This fix
prevents potential hash lookup errors and improves connection tracking
reliability.

Fixes: c3bb5c6acd4e ("sfc: functions to register for conntrack zone offload")
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 drivers/net/ethernet/sfc/tc_conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index d90206f27161..c0603f54cec3 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -16,7 +16,7 @@ static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
 			     void *cb_priv);
 
 static const struct rhashtable_params efx_tc_ct_zone_ht_params = {
-	.key_len	= offsetof(struct efx_tc_ct_zone, linkage),
+	.key_len	= sizeof_field(struct efx_tc_ct_zone, zone),
 	.key_offset	= 0,
 	.head_offset	= offsetof(struct efx_tc_ct_zone, linkage),
 };
-- 
2.25.1


