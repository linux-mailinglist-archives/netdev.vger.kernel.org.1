Return-Path: <netdev+bounces-22043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C1765BE0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEAA28224D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC11AA84;
	Thu, 27 Jul 2023 19:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222419897
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76349C433C9;
	Thu, 27 Jul 2023 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484852;
	bh=hf1ZgFNMwMAvQUMOMK4HuyngTHCBa4yPZCiJsur3aJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvH3pYb3MhPb3Ngd0LBtmvMm6Lfc9XehtcQdDFPXEVavWcVUJ7qRFGTRiYJWGjEL9
	 nIBYu35SsGU79hFKoMLr6pgfeSyKuz2mNeEaZKPC/5uC17y1JzntPZn6g9YFLJW1kI
	 8CSqePS8i8MyercjIzTAiuychuMkgtoC2gZ2iABtWifL8TgzdBrkGophkyc2ySg+Fo
	 CDBIB687pLWP7r3yKtituj34UltP9HiVN79UkGLOkn7Uago1D8BHiXBpklDSD+VFU6
	 f0qPfoqEDvYWR4n7zjan+x6FdkfJBwW4zA8b9bfnnJ3ZChWJxZMQkad5fy5gh9cWIU
	 f+/c1WmjJcgkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] eth: bnxt: fix one of the W=1 warnings about fortified memcpy()
Date: Thu, 27 Jul 2023 12:07:25 -0700
Message-ID: <20230727190726.1859515-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727190726.1859515-1-kuba@kernel.org>
References: <20230727190726.1859515-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a W=1 warning with gcc 13.1:

In function ‘fortify_memcpy_chk’,
    inlined from ‘bnxt_hwrm_queue_cos2bw_cfg’ at drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:3:
include/linux/fortify-string.h:592:25: warning: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The field group is already defined and starts at queue_id:

struct bnxt_cos2bw_cfg {
	u8			pad[3];
	struct_group_attr(cfg, __packed,
		u8		queue_id;
		__le32		min_bw;

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com

Michael, the other warning looks more.. interesting.
The code does:

	data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);

which translates to: data = &resp->queue_id0 + 3, but the HWRM struct
says:

struct hwrm_queue_cos2bw_qcfg_output {
	__le16	error_code;
	__le16	req_type;
	__le16	seq_id;
	__le16	resp_len;
	u8	queue_id0;
	u8	unused_0;
	__le16	unused_1;
	__le32	queue_id0_min_bw;

So queue_id0 is in the wrong place?
Why not just move it in the spec?
Simplest fix for the warning would be to assign the 6 fields by value.
But to get the value of queue_id we'd need to read unused_1 AFACT? :o
Could you please fix this somehow? Doing W=1 builds on bnxt is painful.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index caab3d626a2a..31f85f3e2364 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -130,7 +130,7 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
 					    BW_VALUE_UNIT_PERCENT1_100);
 		}
 		data = &req->unused_0 + qidx * (sizeof(cos2bw) - 4);
-		memcpy(data, &cos2bw.queue_id, sizeof(cos2bw) - 4);
+		memcpy(data, &cos2bw.cfg, sizeof(cos2bw) - 4);
 		if (qidx == 0) {
 			req->queue_id0 = cos2bw.queue_id;
 			req->unused_0 = 0;
-- 
2.41.0


