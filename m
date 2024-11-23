Return-Path: <netdev+bounces-146921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C659D6C44
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B362817AC
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DE1AAE22;
	Sat, 23 Nov 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="PBOM+HoE"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881617E8E2
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406115; cv=none; b=aejopZU90fCa162pBlr0KNGaI6kZDk81wayAhyK2tZcmuDzNV5cGzH1j12RHh77h/y+DqmNYVTU+brhGHBOiwx/Gykr3iwxFE+WJO5WjtHpAP8c+ctBRYYEfgPtne1Xb6mup2pbYo5iogwxBjGwGyo6LjdrAY3MNuCaT35icvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406115; c=relaxed/simple;
	bh=qTz05nqTnzWGlitAN8pjkwivXOcYrp4rWS/0ISUDs1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvRuH1was/NrbodZn9aWljECZMsqcIa1x55m2yG1gpxjeypwwy+FDFeVN+PDa7qbTovxghCxAWLyT/OoTO20S1BLWS3rdnqxkAULEbt1F5PLKO1bt7zABQoo4T3FnWCiw/bVrR8vnv9i2XKaG59y/oDq6xUeV9Cv/qZr84VQhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=PBOM+HoE; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732406112; bh=ZejMZ0Ds6cRN9zJCVFToCfAynKBCNZqnISZujY3tuU0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=PBOM+HoE/sa8NVr0t2S5ZapVXUsG1rbNxc+6y7xk3jZXgKo8vkgUB8+UgWzU4ri3+
	 hdIeTSjdJX5F5Auv57umcWsPP+GtIc84aAFqwHPBxkkcJ2J/coavFHrdUM1D8MUqkF
	 NZ5HM+gPCT/y1lh8SX9RILYFiJdPybp/gmH8guiqaQzQnBs81AlstWlzJDEcZdNSYZ
	 4s0i1DhjDUWX+jX4LLSfTIc25iOTORhE0sPPKNsn3JLPe/0A7EK34O54Yp7R8GeOAY
	 zDVRJnbTCFJ6x8Je7h7apYImUs7/xND5D7NkhICcDw0+78+mSgQTK6fWhbFiQCD/8F
	 pwri/L/sPzpmg==
Received: from fossa.se1.pen.gy (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 22848A0139;
	Sat, 23 Nov 2024 23:55:07 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net v3 1/6] usbnet: ipheth: break up NCM header size computation
Date: Sun, 24 Nov 2024 00:54:27 +0100
Message-ID: <20241123235432.821220-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Pz9GJTxeu-MoO2r4pgHdbXUE0VvDHwZO
X-Proofpoint-ORIG-GUID: Pz9GJTxeu-MoO2r4pgHdbXUE0VvDHwZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=373 malwarescore=0 clxscore=1030 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230200

Originally, the total NCM header size was computed as the sum of two
vaguely labelled constants. While accurate, it's not particularly clear
where they're coming from.

Use sizes of existing NCM structs where available. Define the total
NDP16 size based on the maximum amount of DPEs that can fit into the
iOS-specific fixed-size header.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
Each individual patch in the v3 series tested with iPhone 15 Pro Max,
iOS 18.1.1: compiled cleanly, ran iperf3 between phone and computer,
observed no errors in either kernel log or interface statistics.

v3:
    * NDP16 header size is computed from max DPE count constant,
    not the other way around.
    * Split out from a monolithic patch in v2.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 46afb95ffabe..2084b940b4ea 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -61,7 +61,18 @@
 #define IPHETH_USBINTF_PROTO    1
 
 #define IPHETH_IP_ALIGN		2	/* padding at front of URB */
-#define IPHETH_NCM_HEADER_SIZE  (12 + 96) /* NCMH + NCM0 */
+/* On iOS devices, NCM headers in RX have a fixed size regardless of DPE count:
+ * - NTH16 (NCMH): 12 bytes, as per CDC NCM 1.0 spec
+ * - NDP16 (NCM0): 96 bytes, of which
+ *    - NDP16 fixed header: 8 bytes
+ *    - maximum of 22 DPEs (21 datagrams + trailer), 4 bytes each
+ */
+#define IPHETH_NDP16_MAX_DPE	22
+#define IPHETH_NDP16_HEADER_SIZE (sizeof(struct usb_cdc_ncm_ndp16) + \
+				  IPHETH_NDP16_MAX_DPE * \
+				  sizeof(struct usb_cdc_ncm_dpe16))
+#define IPHETH_NCM_HEADER_SIZE	(sizeof(struct usb_cdc_ncm_nth16) + \
+				 IPHETH_NDP16_HEADER_SIZE)
 #define IPHETH_TX_BUF_SIZE      ETH_FRAME_LEN
 #define IPHETH_RX_BUF_SIZE_LEGACY (IPHETH_IP_ALIGN + ETH_FRAME_LEN)
 #define IPHETH_RX_BUF_SIZE_NCM	65536
-- 
2.45.1


