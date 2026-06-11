Return-Path: <netdev+bounces-298234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V709F1PnKmp4zAMAu9opvQ
	(envelope-from <netdev+bounces-298234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02A673B5E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=GOTr8Ol2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298234-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B33DF3141C53
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6241931D;
	Thu, 11 Jun 2026 16:46:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2B34040E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196383; cv=none; b=XBpQzEiYJgG8ZlW+xLKc5q8z4YckWNwM+9vA7oDvWiMPMKVPElQ1Owta1Xc3GaWUVb2su1MMMmCFQSuPBIntiLgeDVz0l/s/7uQLf4OWJesXN5Gul/hZn3ibfWTidQ8LPlLNPYCxVZiHnHgon71YaCbuaGEng9dhRhNh8OJA+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196383; c=relaxed/simple;
	bh=dNrF7Y8pKxj7yvgmndjDoSHTf7ZuZ4ST/ADfdrEpFio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMhYJcTvihxImh5kqKthxy9xtmSgRZqeXHsA+GUvUnmMjxme4lXaMvlPcQZ4N1mU6t0EpzlIMZmz+6yx12hj41nlNXrUvSNwsTMUQMhYkSZZ3R3P4KJayGEQ3xvQdqopJuZgq2/xXeSExK8rk2zJg4G/YzoraSj56tq2nGiJALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GOTr8Ol2; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65B6HDsJ2485677
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KEQGIb3xKN2RiIsccMVUCd6vHp285MKd+W+/k0aQgEc=; b=GOTr8Ol2fdIU
	BLdFbT5Th1T4Bb+2Yixo1ptLj23bktDefCcnypTkeh+oYC8eEwtZFOE2wJ9Xwsla
	/j7zJrLJEjkM71UIVh/bM7XABFUAdatthatigE0iBfWc3rFRoGXJTwoNemAmysZn
	qvzHKBa+UWBmZ0Hksnx7pGEcIzv/DmAz5bEE8FL/I6hh/42eY4vM84c27o1nFTMZ
	wpy+x88JH30L1SukuVCklYTZnHZZMtdpU/4SkmKa23h6TrXy0Lo2GjRw+p7Ng2D3
	J3nZZCXubPa9u7Xa6RqvaNawSg9IlNKi2T4fBoPY0Rkht2E8b7cHu9hnK55ki5JE
	ohSzmtSv4Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a6yvx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:46:20 -0700 (PDT)
Received: from twshared88813.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:10 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 5CC913DD36084; Thu, 11 Jun 2026 09:23:26 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Thu, 11 Jun 2026 09:11:16 -0700
Message-ID: <20260611161546.4075580-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfXzNELQ9452MEL
 Cs5dgb3inEdj/gkgMgrFCPGJV9QoLA/J5zmiD+6OSmGX6O0ykm+slKVx9xLMkSrVmbGv9yw+0Ra
 5AszqyfYk5U31LGbnZLZ4VUqUUk1EwmJmgpTjKVuZB2Fnyloa2kixv4t323A6pUXkqETNmGgUG4
 qgMI76UFFJzhB1z08cEMhA0FlW8ggjhGw+FxGpaCUWCiLEEM15KIJbgoZhBlRZXPRDLkI9gtiA9
 V/StJ0mqgtVu87okJHuXS2eP+G4hwGVpUX7cOQd6kTD1yucv5pD7VwYTNEN4vZBUkSiHCYwS9wa
 EUZx8ejy3uUD4rfhD6VbgHon0eQg55J597Xmoa6TOytWD7UTJvsVTrbq8c9lfRsqSki2/RlloIz
 Jz3zA4VK953vDstWYxSzaBP8zDYqEX8CiXF1P581yEx8HFSOYYKQ6bZwy68bKfGRIo2WVjcA4ZH
 c+ppf7UY6b/NH02HF6Q==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2ae65c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=6RAPK-_vliJErzSYU6QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: gnRBdKqwq1SG8U7RzJoWP-G0fiW0mnQ9
X-Proofpoint-ORIG-GUID: gnRBdKqwq1SG8U7RzJoWP-G0fiW0mnQ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX80CmyNV9msgF
 v/d8hjzDd6dtj1QWpRORULH750Vq7oA22Uv6TktbW0cqSz0hDJQzYuVS5sl6aMK8Mye+usglBZk
 oL++R3sNnQaPojIWNdVvc0oPqR1bjlQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298234-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A02A673B5E

When the last reference to an ST table entry is dropped,
mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
therefore accumulate one struct mlx5_st_idx_data per cycle.

Free idx_data after the xa_erase() so the lifetime of the bookkeeping
struct matches the lifetime of the ST entry it tracks.

Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..7cedc348790d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
=20
 	if (refcount_dec_and_test(&idx_data->usecount)) {
 		xa_erase(&st->idx_xa, st_index);
+		kfree(idx_data);
 		/* We leave PCI config space as was before, no mkey will refer to it *=
/
 	}
=20
--=20
2.53.0-Meta


