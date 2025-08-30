Return-Path: <netdev+bounces-218462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E57B3C8F4
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AB20776C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D52116E9;
	Sat, 30 Aug 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Dk6jrL3r"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372D1E98E6;
	Sat, 30 Aug 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540566; cv=none; b=pTNkF/Vw9sw2aFeH4JW1u3fG87nF14GFRIQ8VrV1Nr8jcY3vxT6sRvagnCQGh00rRKyw/Tjzzk7xnjdpZVlxNKJwbvp399zncErtJj42LysAN5t8KX0BsVXVp7ns1CQB9tt7dv3sIUCOtXXIDblVFzcooKA8ri3XwmvnJG7GCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540566; c=relaxed/simple;
	bh=0MuwySFYQQ89dW8ac9oH8qXN8cnUprs+5zRxZwRPrkY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=k73MpaZ6eEbbb0E0YmuLMjc6npHv3BE8uYlyL8B4GIXrCWuna6XTaf2EiZyMCoLVPbDg3lGh8BekVhbPbUSylNjf55wM5KBiXlNYj3/hFKFGqA5tELM1ix9Gf/n7F+8UX9PdwdueUBqPtVUuyQ8FErUjFwMON+eODSzlwgt7Ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Dk6jrL3r; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756540561;
	bh=kM5xYGGf5Pa2dA6SYPxcECHy9sKic510waIx8ZhytcU=;
	h=From:To:Cc:Subject:Date;
	b=Dk6jrL3razAJ2Pb6mTm0ZPET/w7TzlgDaQT8IK4gDcxBQYinWAqT1EMcOHUODLRAp
	 TAt/xzHXdywT1+ynFqaXZPh2pqYwghoLbaI/tSw3116I0ikXdnzThaHILIlESdDxHf
	 hCnnk6+hyIlLxnvaRw9CEiy3CLzDg/gK5qBMgZvg=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id C70B98FB; Sat, 30 Aug 2025 15:49:48 +0800
X-QQ-mid: xmsmtpt1756540188t9ie460uc
Message-ID: <tencent_1489A82090ADCB83FAFDAD60B4D46B2BAA05@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/T535LjUGyzhuaNsShLahvBeDB55XX87jKvJonpqQ99SIyahz1y
	 2oDbE6N9IvXb8B2fz3VYoEUqV3UEyZpgcLeOCkYTfO5dXO0OoagPTsAbYlp/xqs4ThWv2pZClvq+
	 fosaMVPSvhUiQX0MCLYCXRXwWn64aI4lbVgjJdpwMtlhQArq//sU2XJoyReM5c9CvlfhZhIyjJB8
	 cu4KG61Wv+akMnEo2LlA8Q7ffx1L04ElAWVnrMeBFCQmr1mR/wzRqB6toRzm84Y9LWMHbICyOXwj
	 4b8Not8FEzbbvf7uZHwu++1CzsHrps+/Apq+aGLzX380H1TxEyLis+dR/P2Oy8whL7lHHYlKlZKJ
	 1FJ4a0pHAuGuD/X0Eb4x7eHGN7Btzp6G85959Fk3Q/HKtXJunujUrclZzUmzQiNuAWVeMscQUMqj
	 sRJT/3VsiqbYbl/hK2ikFLbMGwWHKXfvA9DT+EKCQkToip56+YeD0iXJfgNCkFf4do2o3cfsatZH
	 a86kQwlrOLdrhYo6Xwe9NFjE+WVqKYX2bHv38ws7ywhzCiwJv9XWc+3PoiZ8lnhKT+PyuJt2CSKH
	 4J6jJRhew2SiUD8QaEfuTwV/zcW2L7chl9W010B0DYBYdelqsuZkqvOBRDb2FEvBwaB/nR/Jh9eM
	 Kq3LvwyFVDR72O06W489UFHIb/wrvdNkC6H85o+ORcopAcZ90TipRtFhx2GCl5ARyfpr7R95uTs9
	 tdZrFlYTjB29IVUiNho6xFgOQup8HtwTO1P8BjQWJkQ76zSiMHgOSwVel4hy4qPuo036A1cZyXNb
	 Jr+aGc3McDJrPdQ906N57Q7hzkekYKi0hgxXbmfSYhI9cC3uFxTwPKNq9BNslZIdNmvHR9fmqV5a
	 8x1Vd3+N5TfKYiAW6b6cBbgVR9g4TbBatMEg77mtiWqEFUkd6qre/x74ZSJQJvMk+/fFp07ILszP
	 SEy8nn066nUIRbEOKYvyiqAy4rhTxe81d5cDomXrIydf/Fjx628iplntoF0fC3H74gF55Ugr4fPd
	 m9QyJ07gQteIdtpRhGCcufCQM1vZra6HCgQDzvwQ2REMHxZSjPrZDfC7tBqs/KaG+KHiMr8SJlgv
	 Rl3ce837Pa6p7Oo2HqbV7tbcBMug==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Conley Lee <conleylee@foxmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH 1/2] net: ethernet: sun4i-emac: free dma desc
Date: Sat, 30 Aug 2025 15:49:46 +0800
X-OQ-MSGID: <20250830074946.2665792-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the sun4i-emac driver,when using DMA to receive data packets,
the descriptor for the current DMA request is not released in the rx_done_callback.
This patch fixes this bug.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 2f516b950..2f990d0a5 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -237,6 +237,7 @@ emac_alloc_dma_req(struct emac_board_info *db,
 
 static void emac_free_dma_req(struct emac_dma_req *req)
 {
+	dmaengine_desc_free(req->desc);
 	kfree(req);
 }
 
-- 
2.25.1


