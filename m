Return-Path: <netdev+bounces-178994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ABEA79E1B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F768174DBE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A6241CA6;
	Thu,  3 Apr 2025 08:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA4241CB2;
	Thu,  3 Apr 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668755; cv=none; b=f5yTzElpw+fob74AyWPe7dV3Gr4JaNmlv7JWX5jA7vR5MQYMxJPW7ZgMmT/zyEQ1jwg6G72fzAXc7slV9vPNiPi6+VdS3as65Wpo8NpnRykXWVmd5cQtheBl4aMkB4aEwBGutK+saDmAyNBDfKQTjYco6Q6Yc+J4/HIRkexG9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668755; c=relaxed/simple;
	bh=LMGWh7K8oa5KrX+W3kbg21yUcMQUNfXpXVe35Aqq1Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvUHYn1qTtLQCTr4yfsdxeEaJsmNaBDBji3pTzYnFRJG7NoQgDhUGZS4vi6nr5YcnXszKnxL23sIyHCjtExZ/E6lHYONzfdCDIHSD8gOGJH8ewcJ1HS+aFV1vfiq8B1JGJLUOUaCSkUZ2cztEw/galAa9s7Idk9ra/50YlbTq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAA32vr1Re5ndMVvBQ--.37834S2;
	Thu, 03 Apr 2025 16:25:30 +0800 (CST)
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
Subject: [PATCH] IPC MUX: Add error handling for ipc_mux_dl_acb_send_cmds().
Date: Thu,  3 Apr 2025 16:24:49 +0800
Message-ID: <20250403082449.2183-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA32vr1Re5ndMVvBQ--.37834S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DArW3JFyrKrWDKF48Zwb_yoW8Gry7pF
	WrWw109F98AF4rAa18CrWDZa4YqayDXr97Kw1jv3Z5WFsrCr47trWxX3429rn7JF45W3Zr
	Ar4jyry3G3WUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwBA2fuKah3xQAAsy

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


