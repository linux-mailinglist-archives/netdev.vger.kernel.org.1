Return-Path: <netdev+bounces-270998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDz+FFJvwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC148306F32
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24DE3024A48
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED63E5570;
	Tue, 24 Mar 2026 10:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D64241665;
	Tue, 24 Mar 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349805; cv=none; b=PNjfrYrSQ0n2AmwhKm9/AJB9uNXySfkvVlh4Fiu9xLTncDO4C3AMqF5HRFLR8JOgdNrcjRHSS5FvSNs04xBHrKbqHaSkQIXbr4h53/wkjLQu9FxQxe75BnQr8fGt4+IPgqj92VMiY4yWMIc/kwTGD+BGpjY5/+Wd3Gu7auOhfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349805; c=relaxed/simple;
	bh=eJzwVK57HM3NlJqCxShuOUp1UyNCWpVTwr5WISCJYYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLIRdZAoE2NS5HigqFzQDXvVYg+l869YI1ka7nmWLBDMRoC/3F1WpSVrJJOrWG1lrCEjWI12BjM7CK5v9EqN5S9mT8uxkGFMVfi81wiT7qT0kN5zcgXHOL30/pvFPM4pTtr3hRJfl18ysY4RhsWzn1ctzwti3r1NVod3qa8BMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAXqw7dbcJpmKtTCw--.62782S2;
	Tue, 24 Mar 2026 18:56:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] qed: iscsi: limit command queue array fill to the ramrod array size
Date: Tue, 24 Mar 2026 18:56:29 +0800
Message-ID: <20260324105629.61282-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqw7dbcJpmKtTCw--.62782S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48try5GrykCry8uryxAFb_yoW8ArWUpa
	y7Xayvvw1kJF43K397Zw40qr9xXay3KFWjgFyxt34fuFsxAFy3Zry5GFWYqryxtws5GF45
	tF1jvrZ5GF9xJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
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
	TAGGED_FROM(0.00)[bounces-270998-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: AC148306F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

qed_sp_iscsi_func_start() validates p_params->num_queues against the
number of command queues exposed by the hardware resource table, but it
then uses that count to fill q_params.cq_cmdq_sb_num_arr[] in the SCSI
init ramrod. That array is fixed at SCSI_MAX_NUM_OF_CMDQS entries.

The in-tree qedi caller derives num_queues from the device's reported
num_cqs and the online CPU count, so current-tree callers can request
more queues than fit in the fixed ramrod array on sufficiently large
systems even though the existing hardware-resource check passes.

Reject queue counts that exceed the command queue array capacity before
filling the ramrod.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
index e16808291338..62cf85f9a042 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
@@ -177,6 +177,15 @@ qed_sp_iscsi_func_start(struct qed_hwfn *p_hwfn,
 		return -EINVAL;
 	}
 
+	if (p_params->num_queues > ARRAY_SIZE(p_queue->cq_cmdq_sb_num_arr)) {
+		DP_ERR(p_hwfn,
+		       "Cannot fit %u queues in %zu command queue slots. Aborting function start\n",
+		       p_params->num_queues,
+		       ARRAY_SIZE(p_queue->cq_cmdq_sb_num_arr));
+		qed_sp_destroy_request(p_hwfn, p_ent);
+		return -EINVAL;
+	}
+
 	val = p_params->half_way_close_timeout;
 	p_init->half_way_close_timeout = cpu_to_le16(val);
 	p_init->num_sq_pages_in_ring = p_params->num_sq_pages_in_ring;
-- 
2.50.1 (Apple Git-155)


