Return-Path: <netdev+bounces-271163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IIwJPK5wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:21:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34B318E74
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F6D63019CA4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019A3A0E81;
	Tue, 24 Mar 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCtZ1LnJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A9396B6B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368757; cv=none; b=ajG23kQY2RsWJKw034aTr+FPzl0fk4XlyrjO6kIEIGcaCvDweXjTMD1oy0I8wHCvLamE2KdXJyTDnPPesjiv+VRD+Ga1ruxaI4tEogHUHTWIj+vPLtId7Jk0LANf+OVBcTIiwtQA3Z0kXfFeiPystrNyY9uiLSMI7LR5s57wq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368757; c=relaxed/simple;
	bh=0N9yTy0Ah/hJksMewkUPOCqSeNc2/rh3miqtSm4nvAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKFU4gx1qrUa4KLR2q7XItW/mQC1SZ3k+Il/xTBTl6GVFsJnfDXtnABVoBlRaM2VZnFe+XALpq6md0s6qk2OMwqdDqtYBHlroTRPbhFURIZLmZ38KiOquhB+dFBPjaI3ieAuV2MEww4kqTq7haORetONGqOtfEz/3ZHRKqPiLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCtZ1LnJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774368755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yrOMh+odx61SdFLp1T6r+RNOQl8aAwet1NVPGkb0R1s=;
	b=LCtZ1LnJ6iMexD1I5DK34OoPRGlhKrBrPqCnkGn3n+v09yMyFmI6wPMwFYO8QQu07VFdZM
	qX0aYpjfrzLgfeChlkr5ggGPD/bGEoFt67g76oydksRI4fdDWv/V/LIwQVF+dk6QzLmsty
	hr3OUOzt4Lvz9qkjqQk3AiEL2wKLwas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-6SJ9ieOMOWirWheDSnf8xQ-1; Tue,
 24 Mar 2026 12:12:33 -0400
X-MC-Unique: 6SJ9ieOMOWirWheDSnf8xQ-1
X-Mimecast-MFC-AGG-ID: 6SJ9ieOMOWirWheDSnf8xQ_1774368752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD9BE18005B4;
	Tue, 24 Mar 2026 16:12:32 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.com (unknown [10.45.224.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 580E91800361;
	Tue, 24 Mar 2026 16:12:31 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [PATCH] sfpid: fix redundant print of Active Cu cmplnce.
Date: Tue, 24 Mar 2026 17:12:27 +0100
Message-ID: <20260324161227.693666-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271163-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jramaseu@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2F34B318E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ethtool -m is run on a module with an SFP active optical cable,
a redundant printf statement is being called before 
the sff_print_any_hex_field is executed, causing multiple 
"Active Cu cmplnce." labels to be printed to stdout.

Remove the excess printf statement from the
sff8079_show_wavelength_or_copper_compliance function.

Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
 sfpid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sfpid.c b/sfpid.c
index 9d09256..228b3ee 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -362,7 +362,6 @@ static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 					"passive_cu_cmplnce.",
 					id[60], description);
 	} else if (id[8] & (1 << 3)) {
-		printf("\t%-41s : 0x%02x", "Active Cu cmplnce.", id[60]);
 		switch (id[60]) {
 		case 0x00:
 			strncpy(description, "unspecified",
-- 
2.51.0


