Return-Path: <netdev+bounces-298307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hVQTEPwGK2pa1gMAu9opvQ
	(envelope-from <netdev+bounces-298307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B047674A9F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:05:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lwkCf9Bg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9E63023525
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493E40FD86;
	Thu, 11 Jun 2026 19:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3B356772
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:05:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204724; cv=none; b=J9XFb3f2B0OGd17obXjGe7Ygnjwp48Waigq8uR8TMc0zSY62w6syC8qc3ywLxMuFMTJfHk2+4WPoZN/kdge5MbRLbVQiVcWWTMD4ZYYIrX+LXRSKo2cJW123AqIvpF/SaSN7Cinuxj7q2cL2T2rSHSwZeOVpAgVLIhD2jF8KYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204724; c=relaxed/simple;
	bh=OLZ628gnU9D6ATcP2nGDVy/Dj++orWehGGKf9gzT/+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eT9tzTo3AjqN9FG0yM64oCwn8Atw5TPDj454zWZz4Jq0pEdFRow6DmBENZT7nhM9Cn/6IWZLdSpj5m3Hd8CXwe6BUK0XO7/DEYF7K0sTzzxRILcixaNBnhO73r8AHFDUxRt2nNDhKVOyo1c/eyX9xNMp+yTfoo+KO2OcyBTbJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwkCf9Bg; arc=none smtp.client-ip=95.215.58.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781204720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJV1onqgNlcZkX7FAHZ6+ZQqBWmTPIOCCIZSwo6rvbA=;
	b=lwkCf9BgH8FB3E71qg+BXqrEzl8I/e+ggYgVa3H2mRA3UwVQ2FkGNkJ/WuuEa7ti/x++5P
	4UvGhqqr9YkMJw0AL6rEyd6K1Cv3jAVfPjoHKYydmJTdlLkfRBLFLxaxZSVGI93XihB850
	c1+VPwz4wUKfOBXZmdBYIYUg5KTGr70=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next] ptp: ocp: add shutdown callback
Date: Thu, 11 Jun 2026 19:03:33 +0000
Message-ID: <20260611190333.787132-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298307-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B047674A9F

The shutdown callback was never implemented for this driver, but it's
needed because .remove() callback is never called during kexec/reboot
process. That leaves HW with some interrupts enabled and may cause
spurious interrupt while booting into a new kernel during with kexec.
If it happens that I2C interrupt fires during kexec, the whole I2C bus
is disabled leaving TimeCard with no devlink communication. The same
happens if timestampers were enabled, leaving the card without
timestamper interrupts until full reboot cycle.

Implement .shutdown() callback with the same function as remove
callback.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ocp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index beacc2ffb166..3465cb7f3311 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5171,6 +5171,7 @@ static struct pci_driver ptp_ocp_driver = {
 	.id_table	= ptp_ocp_pcidev_id,
 	.probe		= ptp_ocp_probe,
 	.remove		= ptp_ocp_remove,
+	.shutdown	= ptp_ocp_remove,
 };
 
 static int
-- 
2.47.3


