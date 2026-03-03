Return-Path: <netdev+bounces-263312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIl8HfALp2kDcgAAu9opvQ
	(envelope-from <netdev+bounces-263312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2891F3C52
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D2683069D15
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476634EA364;
	Tue,  3 Mar 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfef36P6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD414E3797
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555036; cv=none; b=M/6wbnXNy522l8wqTyPZJtjXPNC4bFqbef9sMGLlqE7mzUTf+1+qyUSD5TGpCSgXoJJLatyoJirg0qqBCvyp/4yqE7qd5i1SswNlqdZ9A+c94i+J86zCtu271phjJqBx5dPZeyT8s14Sn56x7TUTlEGF9vVQCb7UX9IRYsJOu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555036; c=relaxed/simple;
	bh=BQOz81h1tGXtJUu/dbPf/3nKtS0uGYEMD18y6QUy2Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsqooRkVGsJXB/CE9hWBpjQNvUM5NblrlyLHaJ2A2wjjhfk970pJlAxyke4WneeHyigze1pxj0UIFEOJKgmzqOxkPS1CJbKKHxSfiNMGkcHFTvVmhLbgoNAVI7++TGRXdbEfyqa3lykBSRjScBNZTCRh7w9VW6q2bsogwOsoe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfef36P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B619C2BCB2;
	Tue,  3 Mar 2026 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555036;
	bh=BQOz81h1tGXtJUu/dbPf/3nKtS0uGYEMD18y6QUy2Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfef36P6wN7ywOd5x9px91ejs8WHk11+YopRMgXP6ZIHSw/8tjRLlH9qAET67X1f5
	 aav7oTlhoSoXXuEET1DQ4KFEF7L4ZAFHhOvDsZ6zTA83C+Dhu6wQaKR8XehpT53v0q
	 upFgKXLQZ8T7+fi4OQFAKV2F5Ees99FEbg+qOfKe9Hv2jRQdGf+x4jlOnx1qfIabd5
	 pWF3HANBzBzKrLI1T136kXwSHSitKFMogBBxh2FxLXZMUXs0JPZVTcJ/arwl69AFga
	 4P10okLpqBVEB/p1dxqTAFFJ2qq8227CLYTiEk7DcOxqGNKHSJvYVCuTN9LwMU+cgZ
	 kBYp29k/wysmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/5] nfc: nci: complete pending data exchange on device close
Date: Tue,  3 Mar 2026 08:23:43 -0800
Message-ID: <20260303162346.2071888-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303162346.2071888-1-kuba@kernel.org>
References: <20260303162346.2071888-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B2891F3C52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263312-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

In nci_close_device(), complete any pending data exchange before
closing. The data exchange callback (e.g.
rawsock_data_exchange_complete) holds a socket reference.

NIPA occasionally hits this leak:

unreferenced object 0xff1100000f435000 (size 2048):
  comm "nci_dev", pid 3954, jiffies 4295441245
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    27 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  '..@............
  backtrace (crc ec2b3c5):
    __kmalloc_noprof+0x4db/0x730
    sk_prot_alloc.isra.0+0xe4/0x1d0
    sk_alloc+0x36/0x760
    rawsock_create+0xd1/0x540
    nfc_sock_create+0x11f/0x280
    __sock_create+0x22d/0x630
    __sys_socket+0x115/0x1d0
    __x64_sys_socket+0x72/0xd0
    do_syscall_64+0x117/0xfc0
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 38f04c6b1b68 ("NFC: protect nci_data_exchange transactions")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/nfc/nci/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 40fc397858ce..f8c0bab2ec07 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -567,6 +567,10 @@ static int nci_close_device(struct nci_dev *ndev)
 		flush_workqueue(ndev->cmd_wq);
 		timer_delete_sync(&ndev->cmd_timer);
 		timer_delete_sync(&ndev->data_timer);
+		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+			nci_data_exchange_complete(ndev, NULL,
+						   ndev->cur_conn_id,
+						   -ENODEV);
 		mutex_unlock(&ndev->req_lock);
 		return 0;
 	}
@@ -598,6 +602,11 @@ static int nci_close_device(struct nci_dev *ndev)
 	flush_workqueue(ndev->cmd_wq);
 
 	timer_delete_sync(&ndev->cmd_timer);
+	timer_delete_sync(&ndev->data_timer);
+
+	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+		nci_data_exchange_complete(ndev, NULL, ndev->cur_conn_id,
+					   -ENODEV);
 
 	/* Clear flags except NCI_UNREG */
 	ndev->flags &= BIT(NCI_UNREG);
-- 
2.53.0


