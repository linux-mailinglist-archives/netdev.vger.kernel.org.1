Return-Path: <netdev+bounces-179000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93EA79E6E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BFE3B43D2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD9923F406;
	Thu,  3 Apr 2025 08:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF219E7D1;
	Thu,  3 Apr 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670122; cv=none; b=Zmje+tFEMiD32DlvpyEKAsOK9SLwtr29MgoDpJWFmLDFWAnFN2x50E9ga21RL2qVVVM3LZ2fZ3d3O7zeDgNkLctRKX5ZVdjACr0lf7Ex/l3gZMU9CYcOcJSkc02F75FWe+NcFFvMO0cKV6SIBeR0GQIEbNLeWXDRF3GIG87086k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670122; c=relaxed/simple;
	bh=LMGWh7K8oa5KrX+W3kbg21yUcMQUNfXpXVe35Aqq1Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPlSh0kBlJPaF35f4/NNx1gg8/GR3jLcMIC7/3TA9SGj8imaRU0lRZKKAdwkeCb67Z/XWaVqa6+t74FG1zgokIaqSEpovk939LanEZX4UO9TuyfHQZL2lM05KnmV7cQDf4P5ClPI4jDFgJ3Tqqzp2ctPlA64A+pw6CeunlZp2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACXPP1SS+5nfWhxBQ--.16368S2;
	Thu, 03 Apr 2025 16:48:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: m.chetan.kumar@intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] net: wwan: Add error handling for ipc_mux_dl_acb_send_cmds().
Date: Thu,  3 Apr 2025 16:48:00 +0800
Message-ID: <20250403084800.2247-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPP1SS+5nfWhxBQ--.16368S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DArW3JFyrKrWDKF48Zwb_yoW8Gry7pF
	WrWw109F98AF4rAa18CrWDZa4YqayDXr97Kw1jv3Z5WFsrCr47trWxX3429rn7JF45W3Zr
	Ar4jyry3G3WUGF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR2hFcDUUU
	U
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREBA2fuKvd1oAABsa

The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
This makes it difficult to detect command sending failures. A proper
implementation can be found in ipc_mux_dl_cmd_decode().

Add error reporting to the call, logging an error message using dev_err()
if the command sending fails.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..478c9c8b638b 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -509,8 +509,11 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 			return;
 			}
 		trans_id = le32_to_cpu(cmdh->transaction_id);
-		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
-					 trans_id, cmd_p, size, false, true);
+		if (ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
+					     trans_id, cmd_p, size, false, true))
+			dev_err(ipc_mux->dev,
+				"if_id %d: cmd send failed",
+				cmdh->if_id);
 	}
 }
 
-- 
2.42.0.windows.2


