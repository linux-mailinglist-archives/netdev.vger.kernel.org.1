Return-Path: <netdev+bounces-230761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE3BEEE52
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9F718973ED
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E05246BC5;
	Sun, 19 Oct 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="epexj6oM"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5DF1F3B9E
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760914652; cv=none; b=XOBIwzfT2yIzcR2juPN40JNF4UX7mKWuc7KyRSS75oki1PyfWjlheZPT/OmZsgto+63JXqpH0pBIZ3KQ65drrDt42Gbs1JUXcLxegew9vKt2uF+zz4klqc04Q4wIO6btXbJzfAX9PPTuJKKrLuQHq9f6fRTpmADO1xVx/Z6ZHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760914652; c=relaxed/simple;
	bh=UfdnkjVFu1oYMJc3m2ZZuuU3N9p4LBBT6+vkWvW9Zk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUXt07oxFoMNHH9XHXaI6tvNxHyxmDwfMXb6aBn8YNes4TGiCWrb1PUzdRzrKNj9j93/kgA77qL/bDTEu9+B9jANyMNOx4zuhBTycBf9zB9ypszmT83uVaTvpigiTpO2LdkosL/VxT7kQC2BuHlMu97/0zSDcvZJTk1zsV+CIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=epexj6oM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760914646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wAI34WwdV/e7xF1Haa5t1Z2vbBsT/9F3FLVY3EkGzdg=;
	b=epexj6oMq8qH2eTecL1MHK4s7H5qtcjlW+NvOhPxph4d5Roa7+uyN3xJhGVULCLFjySTUu
	3Nc+mVloK01Zgo0xUkR6k1B16HG/FgG01XTGb9Kerl25nUQ4VfapJkCTOz7tf6e3vct3Sg
	K0BMYtZLxs6JVnn5zlQm22Z8f2tQS08=
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
Subject: [PATCH net-next v2] bnxt_en: support PPS in/out on all pins
Date: Sun, 19 Oct 2025 22:57:20 +0000
Message-ID: <20251019225720.898550-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add supported_extts_flags and supported_perout_flags configuration to make
the driver complaint with the latest API.

Initialize channel information to 0 to avoid confusing users, because HW
doesn't actually care about channels.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index db81cf6d5289..1425a75de9a1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -952,7 +952,6 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
 		snprintf(ptp_info->pin_config[i].name,
 			 sizeof(ptp_info->pin_config[i].name), "bnxt_pps%d", i);
 		ptp_info->pin_config[i].index = i;
-		ptp_info->pin_config[i].chan = i;
 		if (*pin_usg == BNXT_PPS_PIN_PPS_IN)
 			ptp_info->pin_config[i].func = PTP_PF_EXTTS;
 		else if (*pin_usg == BNXT_PPS_PIN_PPS_OUT)
@@ -969,6 +968,8 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
 	ptp_info->n_per_out = 1;
 	ptp_info->pps = 1;
 	ptp_info->verify = bnxt_ptp_verify;
+	ptp_info->supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS;
+	ptp_info->supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
 
 	return 0;
 }
-- 
2.47.3


