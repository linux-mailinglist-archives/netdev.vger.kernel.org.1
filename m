Return-Path: <netdev+bounces-115807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD78947D57
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D130B217B9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6F13C8F9;
	Mon,  5 Aug 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DqdNJ6Qa"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788713BC2F;
	Mon,  5 Aug 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869865; cv=none; b=nEv6fjA80iSjN6kr5cpN2o0p7n4+0L82dUn7AJ2TqeDwop1CvttPgE7g00g7Dcoe3xojVHdxC5TqR2K0HQdomRS4kg+X06H9bJ5rkvYNgqFWGSA42ssTAKqTAzTXKNKQcG6FzDIgZXwb4NztlZlNvHHQqlQ3wgeMHlYTWIhhtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869865; c=relaxed/simple;
	bh=xQxs5tA86O7NH6G9PP9yTirBnWcDZOoo7XIjpVLI+xY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P6J+wrcWfVMopBWtF2QFU0SMywLQQQUcbfIW/DF5SOMtXnB6nPviJotg9KcdVdIdHaKinISrj5Qk9YCItFxJ73CZXjAduHizrXZRAHn03waXCV1f+n7752crIkJtImRBn9yNiC1L+sqpASRmLn2wtjGzgABHYFA353gE+yg33jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DqdNJ6Qa; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CDA6AA1020;
	Mon,  5 Aug 2024 16:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=rt0/DzSJHh0VO/aLzwYC4bGQHdS29kdGzx/bnV7v0b4=; b=
	DqdNJ6QajXuCswon2Ki8MzHdHH1KWtMMPtFZSTDwStmjN2bytgjJnPb9PoMIp3HP
	StVCZJhwc2Q1AtT1GYcEh1RcEBsDoQkYuPpU9kBq7cs3T7I//PTaJJ0ZVZG4OZI/
	zC9nJMFTkFuVfqZK59zHS0s7xB7JAVN0y6t9hqos3RYTDjUrkNvyf618PhbJJTyy
	QsasJz3Sp/m/vWGjagHWsquZlMC2nDPlCW1JL8uPsPPmvUl8e/HIGrTkGRuAdZx2
	XJC1WAbKVEozZOa2GYcoNUT5CfVIcBYf6RjyqTHFNdcidVeIDWZQ+9AIL5aQYE4n
	OWlQ5wi2p7PAp9xmqBvhCPwWOro9iPrGR2zESFpmr6vdL6K7crJNOuZjMkfDbPrY
	IoVVUxc1L96fr/d8AYLD3cqv1CvCUEzvrjFoIl85melnItoExvFWXmIRHARAbK76
	s79zQqfP2RrxaVnpcRbOMfbJpr/8YX6PbjW31PjeHkFfhVWngpDD5HbqHbWWr+hh
	ztVuRwpbLqH/YGpUJPLWzlHyYMhF84l8ATXfNu2honf+A2aP4nTOl5QlVYojmq5i
	tr930Hri0dH7xaXzRY/KDN3+2WpUHSOq7SSoNEUZhz3C43bZdC/AZMEsrLG8Mqlj
	SN/Rjf517O+Khqr0eJvjerv/dX12a2HkhaR4jadwtiQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH] net: fec: Stop PPS on driver remove
Date: Mon, 5 Aug 2024 16:57:36 +0200
Message-ID: <20240805145735.2385752-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1722869861;VERSION=7975;MC=3706177826;ID=151856;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94854667C61

PPS was not stopped in `fec_ptp_stop()`, called when
the adapter was removed. Consequentially, you couldn't
safely reload the driver with the PPS signal on.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index c5b89352373a..93953d252d99 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -787,6 +787,9 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
+
 	cancel_delayed_work_sync(&fep->time_keep);
 	hrtimer_cancel(&fep->perout_timer);
 	if (fep->ptp_clock)
-- 
2.34.1



