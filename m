Return-Path: <netdev+bounces-180978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489AA83559
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D99B172066
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2660B8A;
	Thu, 10 Apr 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LgVxenhK"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DC28E0F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246917; cv=none; b=CzVMuFYQs2ddxYo9hr7j7AambIpSNJRPzGAPO3Uu32rXu/iuAo4mNjBrZkFcey7/97jsETbXQIseGK+3Rd1sCJk4u57J+WneHuF4icsYQNiMerh1sXNjR/QMHexeRtQXNRYAFzjJTeoyvwZGQngpMarqlmpZ0S0zl4vZdjOIcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246917; c=relaxed/simple;
	bh=hmkSbI1RrCSW4iI+AN1JDlh5YqLETWMidlQr5NyKUSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kQrjSduN5deGjks0hLGxzJRMARkAKO7Bsuosm/SRWaHYcmysbAT/Vq+b6EgYZoXhp6Jg7V3M4dazXU2zafM4ZPH8EBhS4ZsauYsXGhdIGpsLuvuFtRLaPd/OYRhWFM9NHxFw+pXBDZ4xUEwAhWrBVP0r2ysRglYNbAlmomCyphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LgVxenhK; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3yc4qS7kFZST3PgJRD2DZgFRmKW168rR8JYSKGLq9ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=LgVxenhKsueoYUJ96y16TmEtbivKhQDAdiXLOK0fflpOAAc65jWNdaCgwhdAihJJT
	 YoU5tWK82YAVHBvGXsyHNL5FALDY4ab4gBnANwTcQXBGOqNy74Wr3Tlo+W7SIiDTkY
	 GXipL92WH0ja2pLawWpSEpTa7OsnHTYxCo1YCt6kCDwEGi7XfbCJBQ5BHQSWKBJB+w
	 94QAVg8z9yUHWZcG00D/h8hNhGnatrHplHT/22Ht49LUPLNB8AI3jX5bNVtlG2o1Nv
	 xhiJ5kzdqLSjGxL9Qrf6EnjlLm8l9971TjnrgVVppFAE8dHVo5v2xhXP/gFaoyrO+X
	 nwx3rcttJdgoA==
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPS id 0364B5001B6;
	Thu, 10 Apr 2025 01:01:50 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 3954C50021C;
	Thu, 10 Apr 2025 01:01:47 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 09:01:27 +0800
Subject: [PATCH net-next v2] sock: Correct error checking condition for
 (assign|release)_proto_idx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGYY92cC/z2Nyw7CIBBFf6WZtRgexVZX/odpTEOndhaCApKah
 n8XiXF5cm7O3SCgJwxwajbwmCiQswXkrgGzjPaGjKbCILnUvOWazbReLUamsFeHdlJczjOU9cN
 jUbV0ge/A4hphKGahEJ1/14skqv/V+n8tCSaY6rTsxNgdjRDn54sMWbM37g5DzvkDL/I6zqoAA
 AA=
X-Change-ID: 20250405-fix_net-3e8364d302ff
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Pavel Emelyanov <xemul@openvz.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, Eric Dumazet <dada1@cosmosbay.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: VE4z8XHw115b9nu_j831GHZYeTMQCROw
X-Proofpoint-GUID: VE4z8XHw115b9nu_j831GHZYeTMQCROw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

(assign|release)_proto_idx() wrongly check find_first_zero_bit() failure
by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.

Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'

Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate percpu inuse accounting (v2).")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove @prot->inuse_idx checks in fastpath
- Correct tile and commit message
- Link to v1: https://lore.kernel.org/r/20250408-fix_net-v1-1-375271a79c11@quicinc.com
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def8ba517ff59f98f2e4ab47edd4e63..e2c3c4bd9cd915706678137d98a15ca8c1a35cb8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3999,7 +3999,7 @@ static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
-	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
+	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
 		return -ENOSPC;
 	}
@@ -4010,7 +4010,7 @@ static int assign_proto_idx(struct proto *prot)
 
 static void release_proto_idx(struct proto *prot)
 {
-	if (prot->inuse_idx != PROTO_INUSE_NR - 1)
+	if (prot->inuse_idx != PROTO_INUSE_NR)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else

---
base-commit: 34a07c5b257453b5fcadc2408719c7b075844014
change-id: 20250405-fix_net-3e8364d302ff

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


