Return-Path: <netdev+bounces-179428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79BA7C8F5
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A23E18941F0
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D71DC070;
	Sat,  5 Apr 2025 11:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA101A23AD;
	Sat,  5 Apr 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854006; cv=none; b=lP7gaaZOXm1JWsDXDNKVMflSXPUtvhZAU4bv3FKf+mzEKa1eZwkwnFElt8o2vTnl1ljw20EVUjyIaM/DmlvmMZM5wNYbCSgnxbLrpqjwiq3jC245V3fluTRd6ee8KqlbFKweLJjGaGcb7pMK3z/jlfUZ5+brmozw2B7AxfvOoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854006; c=relaxed/simple;
	bh=4udH6z3AtFCgu6jjn/q9CPU++JiXf3aqebXlTaavKbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGQN4pUemWZ+iwjxlAS007ssk2XppLSUbnN6FkxuzGNdemQLgJcZ4ZWUggqxsPSebDGvhxrn5oU+XaskKvSYfUMomh+lkOdX6MjubXukiP1rg4lgs41ln9GVd1ivihDQdZgdm5LWa+/81+yeT5ytQZ51zGE4F3TWFkT4qL3AGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-01 (Coremail) with SMTP id qwCowABH7v6VGfFnwIQ9Bg--.48370S2;
	Sat, 05 Apr 2025 19:52:55 +0800 (CST)
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
Subject: [PATCH net-next v3] net: wwan: Add error handling for ipc_mux_dl_acb_send_cmds().
Date: Sat,  5 Apr 2025 19:52:36 +0800
Message-ID: <20250405115236.2091-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH7v6VGfFnwIQ9Bg--.48370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DArW3JFyrKrWDKF48Zwb_yoW8JFyUpF
	WrWw109F90yF4rAa18CrWDZa4YqayUXF97Kw1jv3Z5WFsrGF47trWxX3429rn7AF45WFnr
	Ar4jyry3W3WUGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkDA2fwn8GfzwABsW

The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
This makes it difficult to detect command sending failures. A proper
implementation can be found in ipc_mux_dl_cmd_decode().

Add error reporting to the call, logging an error message using dev_err()
if the command sending fails.

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


