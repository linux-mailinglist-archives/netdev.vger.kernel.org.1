Return-Path: <netdev+bounces-280089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COQuF7Rk52l07gEAu9opvQ
	(envelope-from <netdev+bounces-280089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:51:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A243A472
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F67A301F1B0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CD1D130E;
	Tue, 21 Apr 2026 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K8oDEJ1P"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23930E836
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772139; cv=none; b=WdHPAVeeZfEr0wIelSsW8H3GLMVw4fIb7zIjTSt3wt/8f2x+q/Wih/r0sUWS4x0lOpzipaun2FSzQ1MnPJ+0jow2YfFfF4/VISm/eUzVS7NIyVkOcyfrHl1J2UGPrxRjld6VG41ZheIsf3cFR56p7xDrxA0OrmgscWsXWpM8JBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772139; c=relaxed/simple;
	bh=Aqwmxj8uFkfP9nHrc8fZ7RRLzeMC8fJOyFF5kKMYktE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=l1yjP9FHWpIvCf1N8b7S37sI2bx8uhPLcZYK5OTxTudldpOL1TThXkl7fdDV/D12nhoesJ7ktDH+Yt5tONKBnmWpCyyZHD0vaQC012xcxtgZR0geYYB14Q3jdUzWr6A05ZaFaiaSFfNJ7Pkp7GyO8oM4FYZ5utm/zo0l1ChHSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K8oDEJ1P; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260421114034euoutp0141ce51d36a834170fa53b60f5eec3134~oXGNl9HsP0192801928euoutp01g
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:40:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260421114034euoutp0141ce51d36a834170fa53b60f5eec3134~oXGNl9HsP0192801928euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776771635;
	bh=MtJpmhcXNEwjZg/96uUvgc/7Ds9nqk3h5aj71RrwZIY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=K8oDEJ1P4QrFUafUofy21JaFfSTfykL+A1gBtrqVVOYwIf+1osMgat2N1wnkguvmc
	 ZPMA5OEQ6twMpuf9+QJLEG5oSvPviYW2Gqb4O+HCuF2io1eqJPccIxj8stL3g7xQmJ
	 cX0IBtaakUxkqt/b9U6vFAcrPQ1/fr4ZZx6N651A=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124~oXGNTHFly0938209382eucas1p1q;
	Tue, 21 Apr 2026 11:40:34 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260421114034eusmtip112d8a374cc8b5bf185ab61c332f660d0~oXGM-A0Sj0596605966eusmtip17;
	Tue, 21 Apr 2026 11:40:34 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Date: Tue, 21 Apr 2026 13:40:29 +0200
Message-Id: <20260421114029.2689961-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124
X-EPHeader: CA
X-CMS-RootMailID: 20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124
References: <CGME20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124@eucas1p1.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280089-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Queue-Id: 9E6A243A472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are still places in the code where manual calculation of array size
exist, but it is good to enforce usage of single macro through the whole
code as it makes code bit more readable.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 1be97a3a86ce..0e7cecd00169 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
index bbf5c4b3a2ae..eb0257c86058 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -113,7 +113,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
2.34.1


