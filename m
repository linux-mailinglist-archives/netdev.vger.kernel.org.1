Return-Path: <netdev+bounces-36948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913F7B28FD
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4A943B20976
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF931A61;
	Thu, 28 Sep 2023 23:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17641CA8D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:48:25 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90E0195
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:48:20 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SNOnm4003919
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:48:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=V6g/hwrkcvI0uMg0j5zZCBBFTLKvnShwX+xOFyg5MpA=;
 b=hdSVmcFu+LiJayb1twPTiENqSUHisme5V9VVIzs4UqZzWAhEvEKYjwgJtT29mnAf9ix2
 pgA3Eks/sYlRHEMIVs72fUJbzU8MHdHX+Ko5K7M6eHyXERU18B1XfsFZygiBZqRFglQW
 iQxzqXBHTVAJDX9tx9sGIAz68LC6sQiuJ3U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tdk4g8589-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:48:20 -0700
Received: from twshared22837.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 28 Sep 2023 16:48:18 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
	id 2A08720995689; Thu, 28 Sep 2023 16:48:05 -0700 (PDT)
From: Chris Mason <clm@fb.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <dw@davidwei.uk>,
        <dtatulea@nvidia.com>, <saeedm@nvidia.com>
Subject: [PATCH RFC] net/mlx5e: avoid page pool frag counter underflow
Date: Thu, 28 Sep 2023 16:47:35 -0700
Message-ID: <20230928234735.3026489-1-clm@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LJnS8pC5sB1tFTWk5AOYeGUT31hdbTOo
X-Proofpoint-ORIG-GUID: LJnS8pC5sB1tFTWk5AOYeGUT31hdbTOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_22,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ This is just an RFC because I've wandered pretty far from home and
really don't know the code at hand.  The errors are real though, ENOMEM d=
uring
mlx5e_refill_rx_wqes() leads to underflows and system instability ]

mlx5e_refill_rx_wqes() has roughly the following flow:

1) mlx5e_free_rx_wqes()
2) mlx5e_alloc_rx_wqes()

We're doing bulk frees before refilling the frags in bulk, and under
normal conditions this is all well balanced.  Every time we try
to refill_rx_wqes, the first thing we do is free the existing ones.

But, if we get an ENOMEM from mlx5e_get_rx_frag(), we will have called
mlx5e_free_rx_wqes() on a bunch of frags without refilling the pages for
them.

mlx5e_page_release_fragmented() doesn't take any steps to remember that
a given frag has been put through page_pool_defrag_page(), and so in the
ENOMEM case, repeated calls to free_rx_wqes without corresponding
allocations end up underflowing in page_pool_defrag_page()

        ret =3D atomic_long_sub_return(nr, &page->pp_frag_count);
	WARN_ON(ret < 0);

Reproducing this just needs a memory hog driving the system into OOM and
a heavy network rx load.

My guess at a fix is to update our frag to make sure we don't send it
through defrag more than once.  I've only lightly tested this, but it doe=
sn't
immediately crash on OOM anymore and doesn't seem to leak.

Fixes: 6f5742846053c7 ("net/mlx5e: RX, Enable skb page recycling through =
the page_pool")
Signed-off-by: Chris Mason <clm@fb.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
index 3fd11b0761e0..9a7b10f0bba9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -298,6 +298,16 @@ static void mlx5e_page_release_fragmented(struct mlx=
5e_rq *rq,
 	u16 drain_count =3D MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page =3D frag_page->page;
=20
+	if (!page)
+		return;
+
+	/*
+	 * we're dropping all of our counts on this page, make sure we
+	 * don't do it again the next time we process this frag
+	 */
+	frag_page->frags =3D 0;
+	frag_page->page =3D NULL;
+
 	if (page_pool_defrag_page(page, drain_count) =3D=3D 0)
 		page_pool_put_defragged_page(rq->page_pool, page, -1, true);
 }
--=20
2.34.1


