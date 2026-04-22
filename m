Return-Path: <netdev+bounces-280384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0jNsyp6GnEOQIAu9opvQ
	(envelope-from <netdev+bounces-280384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:58:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81987445093
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D52C93004920
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81B3CCFC8;
	Wed, 22 Apr 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O78c/4K0"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB73542E5
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855498; cv=none; b=fJ4C89EnRLJCD96LCRq6QDeoK4YP2LpdxvuIwgZiSyiEaOK805dNNHkh7VUzDLoPyOQfjTqOVSIJKLW3tt8TmYKDbpBr8ADsVH8p+vo7PTMLhrr+oSjyQLBjwpO6f6PQCbY5fE+PVzNJjur6/gZk3/o8GKHd9RK7YZM/+tf4jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855498; c=relaxed/simple;
	bh=087e/nvJmgEeLsXW0RHyWGzu7RXBNSYdUUjS8aydZE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bPPlHRv1BWut45knBfSW1X2aO7askuWVlAKRQH4m6dhPAVusd9RzsrvsHnU00XBysudZJLf4wm5/T9WR/hGCvw1nNsc56zz68hwrGYusgvTOCm321PskqzXQq7Sd34b0m4w4VJwXtKOJPuWhu9kFwIcL/yPaON6Nau4FPZ8CA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O78c/4K0; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260422105814euoutp02388d06c6b9bf5769f2f333b00c1c2c0f~oqKhphXnM3164431644euoutp02c
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 10:58:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260422105814euoutp02388d06c6b9bf5769f2f333b00c1c2c0f~oqKhphXnM3164431644euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776855494;
	bh=HqZ/MfNxixsoC5HUHKPFpN1nTHkNJ5klIDKPGmogXBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O78c/4K0wAM0YGFZ8WN3N64GlFLsKgB+jiRv60SEoZNAtbVhzpEKeYLSMQ3/7khUI
	 7FdazqVt7/3sz75rbUY+Fp10sbMgXkCVo6VQO9Z/HgAclQmWNllebCaL2MoUfZ7r90
	 6LR38jWBGRGtiD0X6Pdxi7+TFxiEdSSqqVavZBJU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8~oqKhYw4N90671706717eucas1p1Y;
	Wed, 22 Apr 2026 10:58:13 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260422105813eusmtip15775a2bab96a887094e270ad7d48787e~oqKhA-sow1020810208eusmtip1X;
	Wed, 22 Apr 2026 10:58:13 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: error27@gmail.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH v2] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Date: Wed, 22 Apr 2026 12:57:12 +0200
Message-Id: <20260422105710.268003-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aeeFh1zQqhVysvxI@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8
X-EPHeader: CA
X-CMS-RootMailID: 20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8
References: <aeeFh1zQqhVysvxI@stanley.mountain>
	<CGME20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8@eucas1p1.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-280384-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81987445093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are still places in the code where manual calculation of array size
exist, but it is good to enforce usage of single macro through the whole
code as it makes code bit more readable.
While at it, beautify condition surrounding it by reversing check and remove
unnecessary casting.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
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


