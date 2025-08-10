Return-Path: <netdev+bounces-212379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2718B1FBE9
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765C11887B8E
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FB20CCCC;
	Sun, 10 Aug 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="kZsPUNLw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8113790B
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854184; cv=none; b=i89AYPVzDDDsyZBzjbbbZJBeTXYELwAloyhOuFIGy5jktSPrJccMQm/vuyI5VJjsA4nRPnftZhNiFIpEJvnp3keX2sHg4XqIcc5pelGfOad9ujLTCeNvgBfKYR35fJYIvScGtlpsAHNH8QwMkEcAE1Wu18sHw0ZqQBPxQ8A78to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854184; c=relaxed/simple;
	bh=qiXweLcthhmoBVRyxI9rC/8yZ7xarcdKU3zPxanEA2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OfK2Tezw7U4BQ0squL8Mu7yIgRWqkFLTMIw1cXaUDE9gUcWhCpeSS3mVf7I3Ga8PDR7OYbq5kQ/4tzJtKkd4PL78wTEv48OjvRwUAGJBpSkXtzV862jf+uBJD9Pb6CErbQRwSfZxxhLn3t71x85QFx/lD5yhEVhzhx4v4xn0kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=kZsPUNLw; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id DA441104C1E4
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 00:59:33 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in DA441104C1E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754854173; bh=qiXweLcthhmoBVRyxI9rC/8yZ7xarcdKU3zPxanEA2w=;
	h=Date:From:To:Cc:Subject:From;
	b=kZsPUNLwv37Bcz1boWplj5pWbytBrYX949DvafxZx8Y//BNf6eceOjJO9YQhTZBQc
	 D2frhczJu4S5dq3dKUeAu8yVYeIh/XYGKg9ifHnKiWquV79grnGC6F8VLZRueAgnKv
	 T5hhtPURzW48acyCrur4VDxP8lFoNRYQdBG9pJcU=
Received: (qmail 14877 invoked by uid 510); 11 Aug 2025 00:59:33 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.198067 secs; 11 Aug 2025 00:59:33 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 11 Aug 2025 00:59:31 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id BBBBD360085;
	Mon, 11 Aug 2025 00:59:30 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 805D21E812F4;
	Mon, 11 Aug 2025 00:59:30 +0530 (IST)
Date: Mon, 11 Aug 2025 00:59:25 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, neescoba@cisco.com, johndale@cisco.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] enic: use string choice helpers to simplify dev_info
 arguments
Message-ID: <aJjzFb6c6OCGib2F@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use standard string choices helper str_yes_no() to simplify
arguments of dev_info() in enic_get_vnic_config().
Avoid hardcoded multiple use of same string constants by using
helper function achieving the same functionality.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/net/ethernet/cisco/enic/enic_res.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index bbd3143ed73e..a09625d47edd 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -95,11 +95,11 @@ int enic_get_vnic_config(struct enic *enic)
 	dev_info(enic_get_dev(enic), "vNIC csum tx/rx %s/%s "
 		"tso/lro %s/%s rss %s intr mode %s type %s timer %d usec "
 		"loopback tag 0x%04x\n",
-		ENIC_SETTING(enic, TXCSUM) ? "yes" : "no",
-		ENIC_SETTING(enic, RXCSUM) ? "yes" : "no",
-		ENIC_SETTING(enic, TSO) ? "yes" : "no",
-		ENIC_SETTING(enic, LRO) ? "yes" : "no",
-		ENIC_SETTING(enic, RSS) ? "yes" : "no",
+		str_yes_no(ENIC_SETTING(enic, TXCSUM)),
+		str_yes_no(ENIC_SETTING(enic, RXCSUM)),
+		str_yes_no(ENIC_SETTING(enic, TSO)),
+		str_yes_no(ENIC_SETTING(enic, LRO)),
+		str_yes_no(ENIC_SETTING(enic, RSS)),
 		c->intr_mode == VENET_INTR_MODE_INTX ? "INTx" :
 		c->intr_mode == VENET_INTR_MODE_MSI ? "MSI" :
 		c->intr_mode == VENET_INTR_MODE_ANY ? "any" :
-- 
2.34.1


