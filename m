Return-Path: <netdev+bounces-270999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHSfEn9vwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:03:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6B306F58
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009EF30B4617
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63163E5576;
	Tue, 24 Mar 2026 10:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35C24634F;
	Tue, 24 Mar 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349818; cv=none; b=sogyI/IYZx1nh8xEiV91ulHK+z/D0N01qU4aC+HUdIgAXMu+NG3jn0c4etfgMxl2r3J/biDpTYDqi29gSrR9OXYiqbV61KoaATyg0ejZnSDCyUrvNoPFQM7Fwrz9I0VA9o54BT7XsP0UDuoKEPWx8T3x7qSyT+VjvglWGIgiuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349818; c=relaxed/simple;
	bh=ocmcfLK2NLl1s6pf7dgWfIT7+5DP2mvCMguliftdYxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OD665apD31rwbCnMuGnd9yKkhmoFOdSOC761xi6toosCALX/70IKRlwqYVLhEbE5hht7huKxOG25VqhbIgrvGTp/5T8wNC557qR3NZ4CdBsiYZ6NJ3e9DukWTVa2KD4VZXMnrgLA83jhjcjqCpweWMa4q2y079wUgdl219pGUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAXpQjvbcJpsKxTCw--.52795S2;
	Tue, 24 Mar 2026 18:56:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] qed: fcoe: limit command queue array fill to the ramrod array size
Date: Tue, 24 Mar 2026 18:56:47 +0800
Message-ID: <20260324105647.92763-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXpQjvbcJpsKxTCw--.52795S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUXr1fZw4UXw4xCrW7Jwb_yoW8Ww1kpw
	47Z3yq9a18XF43t397Zw40vrnxua42yryUKFy7t34a939xZr13XF98CFW5J34xtrs3XF18
	tr1jvrnxCFnxJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACA6B306F58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

qed_sp_fcoe_func_start() validates fcoe_pf_params->num_cqs against the
number of command queues exposed by the hardware resource table, but it
then uses that count to fill q_params.cq_cmdq_sb_num_arr[] in the FCoE
init ramrod. That array is fixed at SCSI_MAX_NUM_OF_CMDQS entries.

The in-tree qedf caller derives num_cqs from the device's reported
num_cqs and the online CPU count, so current-tree callers can request
more queues than fit in the fixed ramrod array on sufficiently large
systems even though the existing hardware-resource check passes.

Reject queue counts that exceed the command queue array capacity before
filling the ramrod.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
index 2ae3639d6cf7..5fbf78f6adca 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
@@ -126,6 +126,15 @@ qed_sp_fcoe_func_start(struct qed_hwfn *p_hwfn,
 		goto err;
 	}
 
+	if (fcoe_pf_params->num_cqs > ARRAY_SIZE(p_data->q_params.cq_cmdq_sb_num_arr)) {
+		DP_ERR(p_hwfn,
+		       "Cannot fit %u queues in %zu command queue slots. Aborting function start\n",
+		       fcoe_pf_params->num_cqs,
+		       ARRAY_SIZE(p_data->q_params.cq_cmdq_sb_num_arr));
+		rc = -EINVAL;
+		goto err;
+	}
+
 	p_data->mtu = cpu_to_le16(fcoe_pf_params->mtu);
 	tmp = cpu_to_le16(fcoe_pf_params->sq_num_pbl_pages);
 	p_data->sq_num_pages_in_pbl = tmp;
-- 
2.50.1 (Apple Git-155)


