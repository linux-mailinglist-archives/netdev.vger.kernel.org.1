Return-Path: <netdev+bounces-260004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAVfO/M5nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A217582B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1905C3026329
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567DC35B65F;
	Mon, 23 Feb 2026 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1SAS3xn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394B34DCCC;
	Mon, 23 Feb 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846128; cv=none; b=QNbcP5DBqYDerqNrAV669pw35EGGQcgsk7Lplx1WEIVOkJUHgTvT+euFsDi9S7frj0Uon3Gp6KOyuyVmaAvwYI6Lq/B4zgBFybxm1w7Od0RjZM+JdmD1RfKIoGGUiRyJKDBbCez2eIn5se01zDoWbFkRF/mCtz/1lNao8hzBF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846128; c=relaxed/simple;
	bh=zlrZwwfDFHHx9SFRxtYnYmYIk8hkz6bas7Jwl8jtDRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmHYlrz4kDLRhS11ewViCy9rztdpBUJ5hnn6iZRFaiiAnNAM50PmSPd5CLtPtquhqpwG2Y+0dfjLSgGgykUyByMcQwPVzpy1LaKEdWWvyt+r26XDaJAnUt7aHfctuHZ54Cxx+z3M8tElCUKxi5AQ9gOESQtkKa2OZaWQSfo0h6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1SAS3xn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D60C116D0;
	Mon, 23 Feb 2026 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771846127;
	bh=zlrZwwfDFHHx9SFRxtYnYmYIk8hkz6bas7Jwl8jtDRo=;
	h=From:To:Cc:Subject:Date:From;
	b=1SAS3xn441EJrT44+U/6fXpfJs1jBmMrflPonDPzIR+piVhSCejMV6T1WxLH5ny99
	 BtyzsTQnh7AXTWWRWxXLKPMkEU9wmSAE9xQOe6Q75pppB7+uscKXFcsRgfWwOU2upY
	 ndbF1IsUJnUE4cWa4ECrJSDkg5lFHxqSlxyteBww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>
Subject: [PATCH net] nfc: pn533: properly drop the usb interface reference on disconnect
Date: Mon, 23 Feb 2026 12:28:30 +0100
Message-ID: <2026022329-flashing-ought-7573@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 26
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=zlrZwwfDFHHx9SFRxtYnYmYIk8hkz6bas7Jwl8jtDRo=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzLO/O6v7MdHzD9a7WlMx9zKK/YwN8t88wPiT6Zk36m Unvjr6d2hHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATOdXFMN+n//iRW3dYNpXP szr56FLOQRad2ZwMc+XPsni2zDtrVGg9rWVprdeZ21nuQQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260004-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8B4A217582B
X-Rspamd-Action: no action

When the device is disconnected from the driver, there is a "dangling"
reference count on the usb interface that was grabbed in the probe
callback.  Fix this up by properly dropping the reference after we are
done with it.

Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/pn533/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 018a80674f06..0f12f86ebb02 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -628,6 +628,7 @@ static void pn533_usb_disconnect(struct usb_interface *interface)
 	usb_free_urb(phy->out_urb);
 	usb_free_urb(phy->ack_urb);
 	kfree(phy->ack_buffer);
+	usb_put_dev(phy->udev);
 
 	nfc_info(&interface->dev, "NXP PN533 NFC device disconnected\n");
 }
-- 
2.53.0


