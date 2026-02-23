Return-Path: <netdev+bounces-260029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YERcGHNPnGktDwQAu9opvQ
	(envelope-from <netdev+bounces-260029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A4176814
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9B4300A3A9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE5366805;
	Mon, 23 Feb 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZbqregE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350EA366546;
	Mon, 23 Feb 2026 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851596; cv=none; b=mjoQaszzwuACCyhLNk5xVT5P7jXCyin907y+WxDy0rXY6tSLApMPe5kNHuwT+gDaApfC1camguqUv/sRo6xw5qWAK5Q6BVkZ4SOr4Cx7linIqSGRwriPirQSOw6vSlkEeRleDupWYoF6CpEn4/DL1GTDLnm257QYsw3I+Q029Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851596; c=relaxed/simple;
	bh=hG5KVNioTFku1eR+EwLLVm3cnoXg/dKXvNBO8zGXors=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9ypur2Qu7S5O7LHuwP9rDsknT3H3y+WCPsDQwNVx/szvRjHrJu9j8I/G5Nrrw3d5r8eM+cs40iHh3szvX4HqOrEFmCKHHW1A7EfwH0gf/3U3H8dESg9FXwPfGTNcjzeh+nkje+IU/b5jr6tiXYy01UrM9V9E+4XOfij88pZPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZbqregE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9606C116C6;
	Mon, 23 Feb 2026 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771851595;
	bh=hG5KVNioTFku1eR+EwLLVm3cnoXg/dKXvNBO8zGXors=;
	h=From:To:Cc:Subject:Date:From;
	b=nZbqregEc1A172hnKmyPePgm/qHI4ZoU2q+tXVm95Vm4Xy8rV0az2uEXWN8JAfNqX
	 hjNuZKPYzpUgyPwA8/XMRvrinab+p+YKrS2Da8yxyTzCbIMXNu0VyjGGAvVWzy3IIO
	 kcRNrBtEH89qu11rp/JvB3UdbjFNlvW4eSAVFwnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>
Subject: [PATCH] net: usb: kalmia: validate USB endpoints
Date: Mon, 23 Feb 2026 13:59:26 +0100
Message-ID: <2026022326-shack-headstone-ef6f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 37
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=hG5KVNioTFku1eR+EwLLVm3cnoXg/dKXvNBO8zGXors=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlz/PWSi+uW2KYap7+a8F6vM74mwKYs4Gmtisr9V1d+7 J2VY7WqI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZy7TTDgrPmjMGz2ZOCg0s7 /J+WHAu6fUNQj2G+R9gqd52lzypWz5p+YOnjk463vaM4AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260029-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B49A4176814
X-Rspamd-Action: no action

The kalmia driver should validate that the device it is probing has the
proper number and types of USB endpoints it is expecting before it binds
to it.  If a malicious device were to not have the same urbs the driver
will crash later on when it blindly accesses these endpoints.

Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/kalmia.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/kalmia.c b/drivers/net/usb/kalmia.c
index 613fc6910f14..ee9c48f7f68f 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -132,11 +132,18 @@ kalmia_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int status;
 	u8 ethernet_addr[ETH_ALEN];
+	static const u8 ep_addr[] = {
+		1 | USB_DIR_IN,
+		2 | USB_DIR_OUT,
+		0};
 
 	/* Don't bind to AT command interface */
 	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
 		return -EINVAL;
 
+	if (!usb_check_bulk_endpoints(intf, ep_addr))
+		return -ENODEV;
+
 	dev->in = usb_rcvbulkpipe(dev->udev, 0x81 & USB_ENDPOINT_NUMBER_MASK);
 	dev->out = usb_sndbulkpipe(dev->udev, 0x02 & USB_ENDPOINT_NUMBER_MASK);
 	dev->status = NULL;
-- 
2.53.0


