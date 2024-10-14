Return-Path: <netdev+bounces-135289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723F99D6F2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0728403A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648041C75FA;
	Mon, 14 Oct 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TiM4/2fI"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919B26296
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932604; cv=none; b=ljySTF1TJ777TJLDLvp+i/95F/hMgtC6rJsU7wq4reagSOwE6AMngc1VmZM6Jx+avXd5WK5EIJcMZeE1e494rHYTVIXEqNyv1Apa3EVNTLzE+zfP1pNmGXsN67FoWaNOc/+hRjcZHb152LxNHRxoPToyUbPNN0gm3wLof0JOTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932604; c=relaxed/simple;
	bh=C3UAnpsb9gGc5/Ggakbchs0wHEotkXGk4bMEaUWriok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrqmRF5//rOIlKLC+jlCWQWJ2wX7dovm4vvVZzWGnwUzz7iHSEn1iY25c4JyVK4boHuIFwKPJHKYLm2fGamJmTm1LzO6vgLb7pmKR20Jt9rx6uJoHxhXMVzT3EoCrCru9y3KOxdy7s5ctaJUnQA67y6k6zrjRy8/CmpsYw7b86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TiM4/2fI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=NFpvjZ4pxOVnqtmah7B/hISv2i34BWIKPtLGEOicD7U=; b=TiM4/2fIG/VwimnJWD2NVC5bC9
	J3L/SD64Tk9KVvxDdAHMdfUJusmaBEUjRvNsC7ixrE1P1MJ6jB+/a+SnjWV0yNmi6tjK0XO+1xuqG
	jjc/xRfg0jMbjHIakrhGs0JTLcz5h+0LIsExZOhvdYa6/GyUzq8vLQUkNco9neaEOdD8g5P+yvKUR
	QiFaIoJuMTz1NylUWWOv04znVsuzKfk4abE6m+dTDjqmcfZ5h/K0EMaB8+OupOLKbeq5HhjpjoQu9
	wD6zxou4MgdQwEhpZBYTGy112PYrUoJhAp+XEQlMg3xoYlJli83o/qngN+HArTwcWJIE15nT4TrpA
	RS8R5TOA==;
Received: from 47.249.197.178.dynamic.cust.swisscom.net ([178.197.249.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t0QLX-000Dme-Ug; Mon, 14 Oct 2024 21:03:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	Andrew Sauber <andrew.sauber@isovalent.com>,
	Nikolay Nikolaev <nikolay.nikolaev@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	William Tu <witu@nvidia.com>,
	Ronak Doshi <ronak.doshi@broadcom.com>
Subject: [PATCH net] vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
Date: Mon, 14 Oct 2024 21:03:11 +0200
Message-Id: <a0888656d7f09028f9984498cc698bb5364d89fc.1728931137.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27427/Mon Oct 14 10:48:30 2024)

Andrew and Nikolay reported connectivity issues with Cilium's service
load-balancing in case of vmxnet3.

If a BPF program for native XDP adds an encapsulation header such as
IPIP and transmits the packet out the same interface, then in case
of vmxnet3 a corrupted packet is being sent and subsequently dropped
on the path.

vmxnet3_xdp_xmit_frame() which is called e.g. via vmxnet3_run_xdp()
through vmxnet3_xdp_xmit_back() calculates an incorrect DMA address:

  page = virt_to_page(xdpf->data);
  tbi->dma_addr = page_pool_get_dma_addr(page) +
                  VMXNET3_XDP_HEADROOM;
  dma_sync_single_for_device(&adapter->pdev->dev,
                             tbi->dma_addr, buf_size,
                             DMA_TO_DEVICE);

The above assumes a fixed offset (VMXNET3_XDP_HEADROOM), but the XDP
BPF program could have moved xdp->data. While the passed buf_size is
correct (xdpf->len), the dma_addr needs to have a dynamic offset which
can be calculated as xdpf->data - (void *)xdpf, that is, xdp->data -
xdp->data_hard_start.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Reported-by: Andrew Sauber <andrew.sauber@isovalent.com>
Reported-by: Nikolay Nikolaev <nikolay.nikolaev@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Nikolay Nikolaev <nikolay.nikolaev@isovalent.com>
Acked-by: Anton Protopopov <aspsk@isovalent.com>
Cc: William Tu <witu@nvidia.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index a6c787454a1a..1341374a4588 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -148,7 +148,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
 		tbi->dma_addr = page_pool_get_dma_addr(page) +
-				VMXNET3_XDP_HEADROOM;
+				(xdpf->data - (void *)xdpf);
 		dma_sync_single_for_device(&adapter->pdev->dev,
 					   tbi->dma_addr, buf_size,
 					   DMA_TO_DEVICE);
-- 
2.34.1


