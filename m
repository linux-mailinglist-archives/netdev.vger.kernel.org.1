Return-Path: <netdev+bounces-180250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3CA80CD0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A34443818
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95722189913;
	Tue,  8 Apr 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NuZ/nKj6"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310117A2EB
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119795; cv=none; b=eDVKsEEeZVdxkxysHpL3fJ5DT7kFa1L9czXx2UEv+dS89um0Rci7HhtYsi/vcBK+nLuK3cj00DBV2a3rq6Yv5FHTTLeEgb4RF3PQAHFI4soOLCY838U75Abp3A/4+4itL4wKvVPr0OMSD8NxwUznxoNr7lG4KpJ9RtLiyUJTkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119795; c=relaxed/simple;
	bh=0oqFzUOBPKKix/1j0ccQIbPAQksuNWmVXOUfqjkEL2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WnfcxFtfgP44NXmTQAx/KCticRGLr8A2cPRMpPm6n81o16qJRqMiKcrfhRGPRBggwdpAfD6UU8V4ZvbDget/fVSBeT4RBjFZ9NOSFK07Nv7W7KjJbXuDuqWS+QXOzsUytCUclHPkN5FLYArnJzz8sTpDmo3PYRMY5mWduVNOnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NuZ/nKj6; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=KAvqNbZUARSQP7AzfZVwLgfRlsqyVvzAxLJDPsnC2Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=NuZ/nKj66k1VnNWfy5cjzJva75QohhM9B18hLWowCBLLMj5G4tNZLJOs1sU6x9+dH
	 D1hwFtrc1ghGXNzF1hm85e1O5saV1JFR7Qf5w849NAfcGU9DYu0SXNNjI7nuYMye07
	 Ie/YVZpHSLZSA86joSkqAIVxQFOSIbV7AD1hLNo9H/HGJhj3LPVBsNtSASn9vCcE9M
	 Mk/ny+fgY0BKeNSZ/6ZMyOdtU6bTjjLFXKXyKNuXC/1tT9PLCLHLty90e1GMfPErKv
	 fsAY2PJQr2B/LkBMrLqgG7EExD2T0Ank8MqseM2LbMTIIOK8Kyxd7lP66mFTXl/1HU
	 ygE7bw4xC6N2g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id CAA2D3A0165;
	Tue,  8 Apr 2025 13:43:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 08 Apr 2025 21:42:34 +0800
Subject: [PATCH net-next] sock: Correct error checking condition for
 assign|release_proto_idx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMkn9WcC/x2MWwqAIBAAryL7nWA+IrpKRESutT8WKiGId8/6H
 GaYAhEDYYSJFQj4UKTLN+g7Bvu5+QM52cYghTRCC8Md5dVj4gpHNWirhHQOWn0HbOo/zfAFHnO
 CpdYXHEI09mMAAAA=
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
X-Proofpoint-GUID: oIss7fQIRjTA0gW9VpyqYZaKxVA9fHnV
X-Proofpoint-ORIG-GUID: oIss7fQIRjTA0gW9VpyqYZaKxVA9fHnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1011 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504080097
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

assign|release_proto_idx() wrongly check find_first_zero_bit() failure
by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.

Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'
Also check @->inuse_idx before accessing @->val[] to avoid OOB.

Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate percpu inuse accounting (v2).")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/net/sock.h | 5 ++++-
 net/core/sock.c    | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c607d81920682139b53fee935c9bb5..9ece93a3dd044997276b0fa37dddc7b5bbdacc43 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1421,7 +1421,10 @@ struct prot_inuse {
 static inline void sock_prot_inuse_add(const struct net *net,
 				       const struct proto *prot, int val)
 {
-	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
+	unsigned int idx = prot->inuse_idx;
+
+	if (likely(idx < PROTO_INUSE_NR))
+		this_cpu_add(net->core.prot_inuse->val[idx], val);
 }
 
 static inline void sock_inuse_add(const struct net *net, int val)
diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def8ba517ff59f98f2e4ab47edd4e63..92f4618c576a3120bcc8e9d03d36738b77447360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3948,6 +3948,9 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 	int cpu, idx = prot->inuse_idx;
 	int res = 0;
 
+	if (unlikely(idx >= PROTO_INUSE_NR))
+		return 0;
+
 	for_each_possible_cpu(cpu)
 		res += per_cpu_ptr(net->core.prot_inuse, cpu)->val[idx];
 
@@ -3999,7 +4002,7 @@ static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
-	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
+	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
 		return -ENOSPC;
 	}
@@ -4010,7 +4013,7 @@ static int assign_proto_idx(struct proto *prot)
 
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


