Return-Path: <netdev+bounces-224439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F4B84C7E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6592A3BDD53
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B922FE0D;
	Thu, 18 Sep 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Po0IaO/3"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121742FB62B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201624; cv=none; b=KW4oTazd2pGFzpoeuKSLN3LGxFOedtre2vOZ84Oon/b7LgFqxqp9NNFWwccGt3HNhmeLCjGvwMi9KdPXWUxWaeiDg8iMCxdbp9ZZb6ZlKSDBtfsdMhn3sxeRi4Z/3t3wfwLt7DpJD9Qb1bovqWmphKMdLjPqgZ65qJiAp3bDT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201624; c=relaxed/simple;
	bh=BESp7YMo0j4ECK1K7IXQ5Q9w77QTDd4knF0udeeynQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stVYyvdG97Jo6RhDBK/fQsIt7Lv+YKr3ABn5W/LqXORM5Y+eVUFQS9Y+lIbbOE0T63aLiN3q3EY1ebGD+ChHGRP9MaZdWoDxK8gvSP/IM/LtoaAIUpleTKjjjxPd4xPYEDCjcVhLabpM4DTMxAAiVLxlO0Lwnp1TFbugQO/A2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Po0IaO/3; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758201619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqEzJY5judtsdRu0sjsQMaldyVEG89URhxDEZYuoSHU=;
	b=Po0IaO/3xmPWLY0cDTs9w3/x0e09XTCrIRVgW0Febng6IF2SJ4xyHWX9TtwLiMZyHbnOaj
	aKeBNH7MAKmqE8K27Zn58f805rBIjy6C976xgf63AG9UxtYd0hf3XOZG1E/wjmSuq+y/Rn
	5BWtO2kKcDHQTKusn30396N/OfxennU=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ptp_ocp: make ptp_ocp driver compatible with PTP_EXTTS_REQUEST2
Date: Thu, 18 Sep 2025 13:11:46 +0000
Message-ID: <20250918131146.651468-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Originally ptp_ocp driver was not strictly checking flags for external
timestamper and was always activating rising edge timestamping as it's
the only supported mode. Recent changes to ptp made it incompatible with
PTP_EXTTS_REQUEST2 ioctl. Adjust ptp_clock_info to provide supported
mode and be compatible with new infra.

While at here remove explicit check of periodic output flags from the
driver and provide supported flags for ptp core to check.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ocp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4e1286ce05c9..794ec6e71990 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1485,6 +1485,8 @@ static const struct ptp_clock_info ptp_ocp_clock_info = {
 	.pps		= true,
 	.n_ext_ts	= 6,
 	.n_per_out	= 5,
+	.supported_extts_flags = PTP_STRICT_FLAGS | PTP_RISING_EDGE,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE | PTP_PEROUT_PHASE,
 };
 
 static void
@@ -2095,10 +2097,6 @@ ptp_ocp_signal_from_perout(struct ptp_ocp *bp, int gen,
 {
 	struct ptp_ocp_signal s = { };
 
-	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
-			   PTP_PEROUT_PHASE))
-		return -EOPNOTSUPP;
-
 	s.polarity = bp->signal[gen].polarity;
 	s.period = ktime_set(req->period.sec, req->period.nsec);
 	if (!s.period)
-- 
2.47.3


