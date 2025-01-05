Return-Path: <netdev+bounces-155227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8BA017A1
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AFB1884218
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7135968;
	Sun,  5 Jan 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="FXf4HhcR"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815827447
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038940; cv=none; b=o6dkM4q3gxnPck09sKIUTTInuTb7JTOc0OPIKQnAy17iCTK75xt9etmrSijHpy9x+h9ZutqjsssziFxG9t4TX9IxTTKXIUCdfaB1ZM0qsbpNbax3y70d87qBbDdSvVfFHvG6OEnsoHsBTCXcNHgCFqop3DnT8McTYE7UyQxk1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038940; c=relaxed/simple;
	bh=flyKp3RQ53pkfVwzwBlpnTDsA60UWcGD7KZcCgsPMPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjPMU9gVw1RDsS9uB5yeRIZzd8qNxogrPBObuFdGYTB1Xqd33cHqihAjM5pMDRDt3ivWoCTKL4sulkykYaBDfnlTOOh7ihmnR3VlsaJSe3OxLmxINg3b5RKVYmM6CBUakAZ+6xZ/MOwFg1u60G3AH0YCleYyZanG+jzrT6C+IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=FXf4HhcR; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736038937; bh=oWa6tcfAyF//NHcdPXeZ1i6bnr87+mwpPqXxI3ayEQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=FXf4HhcRhg0Ih6rNTEEoxohcs0DaamOa2vXvSuBKVQ7iA1R2iaFb3rGevMPibgGYk
	 kOHKrg1aXHktn0BcMpjjOc3LNiBg4bqoVsA595gsGVfhTzi59iJJukqg6SEL9o92AV
	 oDvKs8XC8pWuHUi+BlekgsruiNV4/cgzXGmpvuSmDHn5eUACCBwmgpcOMzoZ8dU5qP
	 DNKPEhkGowt+AZKWTjlfjq4+4CwesplF+Gl4DsPl+mBzh+/JBs4O4aZ1sGzpqBVkBM
	 nyHwrwA2IaUzs3B9fkURaLXr59DMSTtukpThCLgF+esCJ3DCmFn6MHXq/+tfGWIN2o
	 Hbop086Os0e/g==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id B43484E4030F;
	Sun,  5 Jan 2025 01:02:14 +0000 (UTC)
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
Subject: [PATCH net v4 6/7] usbnet: ipheth: fix DPE OoB read
Date: Sun,  5 Jan 2025 02:01:20 +0100
Message-ID: <20250105010121.12546-7-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250105010121.12546-1-forst@pen.gy>
References: <20250105010121.12546-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1wRceMRCbWig1Waecu5rj_D2gdrov75F
X-Proofpoint-ORIG-GUID: 1wRceMRCbWig1Waecu5rj_D2gdrov75F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=738 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501050007

Fix an out-of-bounds DPE read, limit the number of processed DPEs to
the amount that fits into the fixed-size NDP16 header.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Signed-off-by: Foster Snowhill <forst@pen.gy>
---
v4:
    Split from "usbnet: ipheth: refactor NCM datagram loop, fix DPE OoB
    read" in v3. This commit is responsible for addressing the potential
    OoB read.
v3: https://lore.kernel.org/netdev/20241123235432.821220-5-forst@pen.gy/
    Split out from a monolithic patch in v2 as an atomic change.
v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
    No code changes. Update commit message to further clarify that
    `ipheth` is not and does not aim to be a complete or spec-compliant
    CDC NCM implementation.
v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
---
 drivers/net/usb/ipheth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 03249208612e..5347cd7e295b 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -246,7 +246,7 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 		goto rx_error;
 
 	dpe = ncm0->dpe16;
-	while (true) {
+	for (int dpe_i = 0; dpe_i < IPHETH_NDP16_MAX_DPE; ++dpe_i, ++dpe) {
 		dg_idx = le16_to_cpu(dpe->wDatagramIndex);
 		dg_len = le16_to_cpu(dpe->wDatagramLength);
 
@@ -268,8 +268,6 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 		retval = ipheth_consume_skb(buf, dg_len, dev);
 		if (retval != 0)
 			return retval;
-
-		dpe++;
 	}
 
 rx_error:
-- 
2.45.1


