Return-Path: <netdev+bounces-230236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A05BE5ABA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26EDD4E3E2B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF42D9EF6;
	Thu, 16 Oct 2025 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vsMsg8PM"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF862D3725
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653496; cv=none; b=plUvLCv2yUVGA9iirhHBmj5eFhKteIhfcgmwQISBwn3gQuGtDtxYC65Teh04tY9MuztDQ8neChISCGn6LHQkwUAulb4rOX4c2n+8j3Iqmd+8aIPSDnyGbGlyH3GzzggZe+Tlnoiebu8sHxJ69S1vehP8PKsD0h8vpdaImRl6t2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653496; c=relaxed/simple;
	bh=lQaQAods4Cd4zp4Oh6gyQgqNPPOylZ+td+/oxzjvOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYgogjo/aKCC056JLxcjIuNGPez2C4/Y0xWECvJl6hXeFTF4EcOirYdFuSDRf1n1zSdPNOXeBh/BIKNC2P/dANs0CtNFV+xmS2fsSi4k0SHbUyDgXkwFwkJpCfUdrF+tPNhgWvWifxnKrSDWySCBM0s0HByKXu2MV4GLffHXnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vsMsg8PM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760653491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xm8jvNKL/thtQYSSarOS/S/a1pF3fC0Ry8sZYSkKtGs=;
	b=vsMsg8PMjPp4NevIQWDDFjlwdwZKIjpd/ZTN9OB4XVpKFEFicagtdtAlq5cV0dgIrKJm+K
	h37IC0mEMPEwpckTT5LVgy6MSOGcCpeULQMATMuBlYGNnMA3MrHfvfMPU9oAzmzZmdl4HQ
	sqotdpfwFqu4FxcWZHpKb2mP83tGMi0=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next] bnxt_en: support PPS in/out on all pins
Date: Thu, 16 Oct 2025 22:23:17 +0000
Message-ID: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
of pins rather than max number of active pins.

supported_extts_flags and supported_perout_flags have to be added as
well to make the driver complaint with the latest API.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index db81cf6d5289..c9b7df669415 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -965,10 +965,12 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
 	hwrm_req_drop(bp, req);
 
 	/* Only 1 each of ext_ts and per_out pins is available in HW */
-	ptp_info->n_ext_ts = 1;
-	ptp_info->n_per_out = 1;
+	ptp_info->n_ext_ts = pps_info->num_pins;
+	ptp_info->n_per_out = pps_info->num_pins;
 	ptp_info->pps = 1;
 	ptp_info->verify = bnxt_ptp_verify;
+	ptp_info->supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS;
+	ptp_info->supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
 
 	return 0;
 }
-- 
2.47.3


