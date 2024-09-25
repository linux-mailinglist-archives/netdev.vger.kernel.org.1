Return-Path: <netdev+bounces-129649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933E985213
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 06:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B9285714
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 04:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597414B962;
	Wed, 25 Sep 2024 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b="SjVdS4dq"
X-Original-To: netdev@vger.kernel.org
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D014B942
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239117; cv=none; b=R7MimeEOzw5qsvkyeCKY4VA/Xo2ctJOPyaKxbjRerFa/kBN1otGs2DR/qb7L3NUYwE0bLT/twabUC7il4g5D3NxslauerrdwxBth+TJarfg4IdoPQDcb1E5EpLLXo1Yxj765zgdP9YkpVqoCr7eH2TH/jBXfnll9e08kprwQOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239117; c=relaxed/simple;
	bh=cnwFYYGk82ueC0ybmoGUyCpSEP839tim3QSaNtcvnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaREgWF8+NGUkxfWwtF3BRzz6MmlCCFPUvIowqbH9HcVrXhc8eKNQG1+G3t+Cq4w7h+wmd8oALb0YCUC9By9mtGRLoRls/bZajbN0xHZZ/9jx8uyoslMzWAU4n1KTF2pyVMft0x0x9BlLeFVpcfnUtPvZUfhn96U/GgIzqqV0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev; spf=pass smtp.mailfrom=ludwinski.dev; dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b=SjVdS4dq; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ludwinski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ludwinski.dev;
	s=sig1; t=1727239115;
	bh=A8K/uFUDiFHk8zlvTjYFSNdfEg//HrYSwqvjOdFpdsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SjVdS4dqEhl9uIfMbErv7DLAwl5HBMBkWHJanLU1S62rNv+bp8oji2gxU7VhmQ6iR
	 9aapo3HjRJ3CSLR+Mm6YVzeR+yeVAB2Dwmef4jwPrFMbxHyuaA7hhOYdcBmYocNX7n
	 HG3hrqSheKn4y5rCL8YU4kHME7owe+eDB37c90q5t5Eo6zLVngA9e5WwqPSUZOEQVG
	 gzvRJpbPpwhYuSOVRjqKNj7rcng0ZEU8u/jfOYqPDGo0fluuiVJZfz8FjvmGNn3oqw
	 JPTaz/lzf4gXKRoC6QH5qRJTC6c5FeaWyQEBG1FfeGycXk4h49JjVZxXtRCZIxs7pX
	 U7qvCRsj5qzoQ==
Received: from ubuntu.. (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id EB1131E0223;
	Wed, 25 Sep 2024 04:38:31 +0000 (UTC)
From: Kacper Ludwinski <kacper@ludwinski.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Kacper Ludwinski <kacper@ludwinski.dev>
Subject: [PATCH] Fix issue related with assigning two diffrent vids to the same interface.
Date: Wed, 25 Sep 2024 13:37:24 +0900
Message-ID: <20240925043724.1785-1-kacper@ludwinski.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9NI5YyQG8HNCNDON2XDDpFn56xFtAmzS
X-Proofpoint-GUID: 9NI5YyQG8HNCNDON2XDDpFn56xFtAmzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=639 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409250030

Fixes: 476a4f0 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index 9e677aa64a06..694ece9ba3a7 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -202,7 +202,7 @@ one_bridge_two_pvids()
 	ip link set $swp2 master br0
 
 	bridge vlan add dev $swp1 vid 1 pvid untagged
-	bridge vlan add dev $swp1 vid 2 pvid untagged
+	bridge vlan add dev $swp2 vid 2 pvid untagged
 
 	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
 
-- 
2.43.0


