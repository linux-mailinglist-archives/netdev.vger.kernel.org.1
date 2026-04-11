Return-Path: <netdev+bounces-277686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCuJJ1Em2mk3ywgAu9opvQ
	(envelope-from <netdev+bounces-277686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068E3DF637
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B347B3016530
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7533ADB2;
	Sat, 11 Apr 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrPbFGq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8E314B66;
	Sat, 11 Apr 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904330; cv=none; b=Xk+O+DF1x8HiAPENHfHiHSN5cS88A+s1WoB+i63ifo9r7pqydAoO6MosJLZ8ZXw5MgI4T+KSWq3+CbyMQb/3rCMu4gs1b5sWXodEDpsyUudBxQg5XLfBHla0S1sTn2AP1x6j7Q6jQ7dm1S+WYLlX8NBwB7HKJgCJNKq78YSrJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904330; c=relaxed/simple;
	bh=UWGss+poipcIkY3rbdfFpwxZRwnqkp7e8tRBdi37qF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGIttO9fCVN0K8dtmxl9t4B7n6MJUlONp1gTlKD5QQoPlq4AGhxX7aeJMphcxzKY3sUhCVrNQ+suNALdG9DbrADivDQGFSYigHv9iKTVR8TRMW/oWID5hPCvbihmhxo871Iq0CytKZmM80C4aWlUm6KMfdtPivAuxa5hzwjyXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrPbFGq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E9C4CEF7;
	Sat, 11 Apr 2026 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775904330;
	bh=UWGss+poipcIkY3rbdfFpwxZRwnqkp7e8tRBdi37qF0=;
	h=From:To:Cc:Subject:Date:From;
	b=hrPbFGq8R0nn8IaGYtGJpL7BBHQhoCbeSJt/QzYdkwvSzwi5r5dl7zaJKHPt9m2KU
	 sqOVSmzXoVszD8Vrw73QUEffCtqv5+3VCqOOnuP3/nXma7C5F5NspL5Hk/FYJdwXgv
	 DFXrVoY/PdJGk3HjCh2qc72PZPEzVXk7HeX9fAHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] bnge: return after auxiliary_device_uninit() in error path
Date: Sat, 11 Apr 2026 12:45:25 +0200
Message-ID: <2026041124-banshee-molecular-0f70@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 39
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=UWGss+poipcIkY3rbdfFpwxZRwnqkp7e8tRBdi37qF0=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm31Fx4L2xQvrOTfYdMQtfnsG0RDWnX3nrP2hDuvPJD2 65i/SsxHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR/xcMC06v6O95EBRh+7ql 0s5GNezl28+J+QwLTr4yOHmC/4X+7++NIQwsa641zhN7BQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,lunn.ch:email,broadcom.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0068E3DF637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auxiliary_device_add() fails, the error block calls
auxiliary_device_uninit() but does not return.  The uninit drops the
last reference and synchronously runs bnge_aux_dev_release(), which sets
bd->auxr_dev = NULL and frees the underlying object.  The subsequent
bd->auxr_dev->net = bd->netdev then dereferences NULL, which is not a
good thing to have happen when trying to clean up from an error.

Add the missing return, as the auxiliary bus documentation states is a
requirement (seems that LLM tools read documentation better than humans
do...)

Cc: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index b942076762ef..67e93e17d4d9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -194,6 +194,7 @@ void bnge_rdma_aux_device_add(struct bnge_dev *bd)
 		dev_warn(bd->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
 		bd->flags &= ~BNGE_EN_ROCE;
+		return;
 	}
 
 	bd->auxr_dev->net = bd->netdev;
-- 
2.53.0


