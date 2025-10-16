Return-Path: <netdev+bounces-230256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5BBE5CD0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9C4E2535
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE12DF716;
	Thu, 16 Oct 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="d6RNMENY"
X-Original-To: netdev@vger.kernel.org
Received: from rn-mx03.apple.com (rn-mx03.apple.com [17.132.108.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC312DEA94
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.132.108.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657600; cv=none; b=hd4hKpCRcLHx903zNUporVBnF5/V2S2J/ISAgun02H003WJBivp887jZP3OgCCtQgmgK25V4W9l1ow4NzbEzwnYcZai3AOroHe53ZWnFs7tHd22+L8BdCd9XpxBZEqnPFCnFCEMCOj6e4Q9+H1A8NIz5nk88dQvvdu7C9yMBpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657600; c=relaxed/simple;
	bh=DCzEcb0EbjY1g8s20TbAhSfGBhmj/YWS4n3dfbHCgmE=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=daGOOtoYzerIblVpQ0xWoiXxKCAhQv4/C1Kss1RyR0+5pxmxBl/cdVCgVrFcR9iYjVVp6GjX0wlijnlR9DgUfj92Y48/+gUVXcWLYj/5ZMOrwH0YVvRJWFEQX7Yacc8xmTS754MHzv5XjSf9z7b+ny+1SQWpTgUgYzstiJPokug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=d6RNMENY; arc=none smtp.client-ip=17.132.108.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from mr55p01nt-mtap02.apple.com
 (mr55p01nt-mtap02.ise.apple.com [10.170.185.211]) by mr55p01nt-mxp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) with ESMTPS id <0T48248J8XBCNB10@mr55p01nt-mxp03.apple.com> for
 netdev@vger.kernel.org; Thu, 16 Oct 2025 22:33:13 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version : subject
 : to; s=20180706; bh=5oAD5oOer419JlgdycYn7yg2e5s40AR7Miv8f7yrRho=;
 b=d6RNMENY7L83Q2Plfmelzg4NhOhrh30kekbCHM0MouRx5VhJpB3uf1E3ArixgdhhF0xf
 rd3VPf4UYG5YgKosYtEBRBDxLGxJgGRd/CNnRD0mLV0n+pqjz5rKl2Bi4MfPpX9112uS
 Lr1QmPY67s+/TUhWIOfw3vOf4PlJ+NDu6RMxqzpmivdIViTnk9TBzzzieCZ994UjR4Bx
 COVyEGoow2S2CuAPAfLUIfONn2H1+shWNUtQ3oVPZpODEwNlzyAg0COeuL/5v3cNiiG4
 XWkkgqGxWDAG0hHVM0V9ISZHT/4SEiIJi4eUwJpPf2ob/asZ0C/Q3ZmK/zxXPY7Im+Yb nQ==
Received: from mr55p01nt-mmpp03.apple.com
 (mr55p01nt-mmpp03.ise.apple.com [10.170.185.208])
 by mr55p01nt-mtap02.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) with ESMTPS id <0T481TPFDXBCVHV0@mr55p01nt-mtap02.apple.com>; Thu,
 16 Oct 2025 22:33:12 +0000 (GMT)
Received: from process_milters-daemon.mr55p01nt-mmpp03.apple.com by
 mr55p01nt-mmpp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) id <0T4824Z00X7ATV00@mr55p01nt-mmpp03.apple.com>; Thu,
 16 Oct 2025 22:33:12 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-Va-E-CD: 7634ee1c9f2a9e46db68005ed32c5d68
X-Va-R-CD: 9cc962ae69cb668f1f695ab9a070da32
X-Va-ID: f093272d-667f-4240-92aa-f411f2c52dbd
X-Va-CD: 0
X-V-A:
X-V-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-V-E-CD: 7634ee1c9f2a9e46db68005ed32c5d68
X-V-R-CD: 9cc962ae69cb668f1f695ab9a070da32
X-V-ID: 69d21ee1-e5fc-4eca-8136-b7659b4d75c9
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
Received: from M4Max.scv.apple.com (unknown [17.192.171.196])
 by mr55p01nt-mmpp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) with ESMTPSA id <0T4824Z2EXB5MK00@mr55p01nt-mmpp03.apple.com>; Thu,
 16 Oct 2025 22:33:12 +0000 (GMT)
From: Wen Xin <w_xin@apple.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, virtualization@lists.linux.dev, Wen Xin <w_xin@apple.com>
Subject: [PATCH net] virtio_net: fix header access in big_packets mode
Date: Thu, 16 Oct 2025 15:33:05 -0700
Message-id: <20251016223305.51435-1-w_xin@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

In Linux virtio-net driver's (drivers/net/virtio_net.c) big packets mode (vi->big_packets && vi->mergeable_rx_bufs), the buf
pointer passed to receive_buf() is a struct page pointer, not a buffer
pointer. The current code incorrectly casts this page pointer directly as
a virtio_net_common_hdr, causing it to read flags from the page struct
memory instead of the actual packet data.

Signed-off-by: Wen Xin <w_xin@apple.com>
---
 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..c10f5585bc88 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2566,7 +2566,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	 * virtnet_xdp_set()), so packets marked as
 	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
 	 */
-	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
+	if (vi->big_packets && !vi->mergeable_rx_bufs) {
+		struct virtio_net_common_hdr *hdr = page_address((struct page *)buf);
+
+		flags = hdr->hdr.flags;
+	} else {
+		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
+	}
 
 	if (vi->mergeable_rx_bufs)
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
-- 
2.39.5 (Apple Git-154)


