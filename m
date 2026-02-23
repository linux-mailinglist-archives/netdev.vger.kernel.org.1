Return-Path: <netdev+bounces-260028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI1zJiNPnGktDwQAu9opvQ
	(envelope-from <netdev+bounces-260028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:59:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E43911767E3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8633004627
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7BB366546;
	Mon, 23 Feb 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3SQS1/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF753644D3;
	Mon, 23 Feb 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851552; cv=none; b=M4vvh2gL07hXu+XhVWkTBwVQHSD/7N/w9M4FczTZif7AsvCkWBm2T/uoZtNHA+ES33qC1+Zm1YB+AQh2XzOVaoXlbRN5KVFclkCNtUAs5ade1eFqMhlxaQteG0UJu9uEO5Dgg2cxVGapgNI87R6Pf1jbb++6yeQ4sHvlUGo0qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851552; c=relaxed/simple;
	bh=Par3+OJsZbAIJien6Jci74rK3rk6O9eJHfJ9GFnuujs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XY0YItJ08c8sJLLXwBM/zHekrbd9OuXvAENS2G83+xpUZitd5Rjtk2Usl0GySKDej2aAB+8mjO1dNQs94/3wCQ6wwi4AmcY1cyenzBx9+6JhYySoIB8CWE8Vktwc5C6K2PnAHqUWjMkVdQaOZQ/aRtnkKBuzjsYO6IDKoV4M2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3SQS1/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C63C116D0;
	Mon, 23 Feb 2026 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771851552;
	bh=Par3+OJsZbAIJien6Jci74rK3rk6O9eJHfJ9GFnuujs=;
	h=From:To:Cc:Subject:Date:From;
	b=t3SQS1/PeorMhVTyDNdC7MKXQ1qsupnKz0nFIVbkDiZ0d7PO5i7L/PNM7GygyNdpP
	 jJA/OtZ/H00YOM/VOMfFrcX6IsB3tPAbX8+w9vAdRMZweIMDT2cT2VvyU3/FhcOnHf
	 rkT+ZIMQ8rFf7NBgSa3HDucTpBQzf/i5bKAp2pC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petko Manolov <petkan@nucleusys.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: usb: pegasus: validate USB endpoints
Date: Mon, 23 Feb 2026 13:58:48 +0100
Message-ID: <2026022347-legibly-attest-cc5c@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 55
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Par3+OJsZbAIJien6Jci74rK3rk6O9eJHfJ9GFnuujs=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlz/NnbD33OaP+22aLmT+XP6pRdvpEntC+Hrn6xekv1z 2SxnyWRHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRjakMC3rZwnOP/ZZ8ulFj /ryzIkK8uYVHpBgWdFUmCL2UOPsgpbp55r0kmTmzfn+7DAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260028-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nucleusys.com:email]
X-Rspamd-Queue-Id: E43911767E3
X-Rspamd-Action: no action

The pegasus driver should validate that the device it is probing has the
proper number and types of USB endpoints it is expecting before it binds
to it.  If a malicious device were to not have the same urbs the driver
will crash later on when it blindly accesses these endpoints.

Cc: Petko Manolov <petkan@nucleusys.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/pegasus.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 4f539b5d509a..94c17fed0bd4 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -801,8 +801,19 @@ static void unlink_all_urbs(pegasus_t *pegasus)
 
 static int alloc_urbs(pegasus_t *pegasus)
 {
+	static const u8 bulk_ep_addr[] = {
+		1 | USB_DIR_IN,
+		2 | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		3 | USB_DIR_IN,
+		0};
 	int res = -ENOMEM;
 
+	if (!usb_check_bulk_endpoints(pegasus->intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(pegasus->intf, int_ep_addr))
+		return -ENODEV;
+
 	pegasus->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pegasus->rx_urb) {
 		return res;
@@ -1143,6 +1154,7 @@ static int pegasus_probe(struct usb_interface *intf,
 
 	pegasus = netdev_priv(net);
 	pegasus->dev_index = dev_index;
+	pegasus->intf = intf;
 
 	res = alloc_urbs(pegasus);
 	if (res < 0) {
@@ -1154,7 +1166,6 @@ static int pegasus_probe(struct usb_interface *intf,
 
 	INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
 
-	pegasus->intf = intf;
 	pegasus->usb = dev;
 	pegasus->net = net;
 
-- 
2.53.0


