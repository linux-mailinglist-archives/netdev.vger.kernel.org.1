Return-Path: <netdev+bounces-281784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKdJLviP8Gl4UwEAu9opvQ
	(envelope-from <netdev+bounces-281784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7D482E67
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFA623021093
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F193F0768;
	Tue, 28 Apr 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tS7TzDA1"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26973D9DD1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372682; cv=none; b=l77M2NfnHkn19yANTd0IUvjoXJSVu6qYWltv2jDvpPSyWDGZC5ERI0gLlOKk6g3HMjAd98irn1HmTuI9j8rqO7rEXKFQ/C2DN4DdyHkSeR6eRU0VXbhhQGhlQ0OVfpYou7Js+crgB/ujV2igIb0VEoin+Jin1rIEbN4pz4mJarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372682; c=relaxed/simple;
	bh=/63CjcqVSdyZmQH13MfUszBXEiGLPGaCeHqH2QDaF+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=kJUqlqGT3K/lFiluWRtt1614m3XNbvPvcUv6QYQA1t/+h6OmXCBPj/mG3Dd3vWbOcI2yROdfAv8dJS4sDHnen90o2k6Nm1sGdQkRvlB31hbAzOTYhAzEy01mPUq0VgRL/kmIEK2juSCF2oTHzxrxglcdC6Tr1+H2ucTcqZNiq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tS7TzDA1; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260428103757euoutp02b0cf1d0b1cf8477b89293919f7ec8115~qfwie3Vh-2704527045euoutp02t
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260428103757euoutp02b0cf1d0b1cf8477b89293919f7ec8115~qfwie3Vh-2704527045euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777372677;
	bh=azDwVA7NGgGiKAxFELCpnqhJ6m/gaXxvTMSXNbYXqpE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tS7TzDA1xuhGqvVvFdQ/Hx/vPy70Eye+JRZjIhAHDYdSzAG8VGA5YC35sjwXG8W5W
	 ZhcisOFnVCjz3hKRukWPv8LGKBvbSrj1NJ63mLebxTxbm57/x27kZNBP2rwbg7enGz
	 ovz3luMqjLP2/5JXJ3bU9uX89oV6Drf8e1FrZkuM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931~qfwiMVCoa2962529625eucas1p13;
	Tue, 28 Apr 2026 10:37:57 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260428103757eusmtip1dd792289d478dfaae8220c7be02bee03~qfwhxcoZF0486404864eusmtip1M;
	Tue, 28 Apr 2026 10:37:57 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, przemyslaw.kitszel@intel.com,
	error27@gmail.com, Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
Date: Tue, 28 Apr 2026 12:36:54 +0200
Message-Id: <20260428103653.3539239-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931
X-EPHeader: CA
X-CMS-RootMailID: 20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: B4E7D482E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,intel.com,gmail.com,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-281784-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid]

There are still places in the code where manual calculation of array size
exist, but it is good to enforce usage of single macro through the whole
code as it makes code bit more readable.
While at it, beautify condition surrounding it by reversing check and remove
unnecessary casting.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reviewed-by: Dan Carpenter <error27@gmail.com>
---
Link to v1/v2:
https://lore.kernel.org/kernel-janitors/20260421114029.2689961-1-j.raczynski@samsung.com/

Changes in v3:
- Add 'Reviewed-by' from previous thread
Changes in v2:
- Beautify code by removing excessive parentheses
- Reverse if condition to remove negation of whole check

 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 1be97a3a86ce..dcf3baec7b73 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
index bbf5c4b3a2ae..dd2f61172157 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -113,7 +113,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
2.34.1


