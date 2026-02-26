Return-Path: <netdev+bounces-261604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CHlI8XEoGnImQQAu9opvQ
	(envelope-from <netdev+bounces-261604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:10:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF21B0359
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31CF43030DFC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0E2E040E;
	Thu, 26 Feb 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y+RAFzh7"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417D40F8E5
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143807; cv=none; b=EKvDGMTFY1QJ7zWPeW0sX4cWryrJPDPgHjaLzh5zCx04ciKPI6cXnZlmj+O8JcqOd6RGe3Ho86QYSjPpBoGAXXKgTkFndgMlXY7PMv4UsHKP8Ew5xJlaVaQlBwSRac3+9pE1+XFsMqEbMW7s/aOQIOcS8VG0Ey5/fazkirB4F9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143807; c=relaxed/simple;
	bh=rFgNkQj9ffhJJa+B5MSLS8s1pQzg+f55Dn2zQid4+0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpCk11W9APBJDhulxfJOR+WjknhU5AtKNolTXKWkrQ0FR+dWB8sPdgE7VnZDWkTItcvKhAxVoVblP51wjLfLqMbi/l0eJEm1CisrUhtJfuKIEANN2tK+yzVdJd74m+3u600dR3GsdOdYbs85E2kPirGyRE8gO/8OLSQg7zq8BPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y+RAFzh7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BUKa80PiyIo8XUOj8evka7s+PeOxR3Si4KSiGWN9IU0=; b=y+RAFzh7Z6zkOgq4RedDja9YPM
	VBkbQeCsD3tM4/IKJVbNRmaCQeNVEfd5GjGLYtTTidbhbvxoIa2Bb0L+K/04m8xswZTzVvuaLFC43
	aYHPc0r34JqfWxh/9MvUv6wANvMEqoK2TTfv2ooZbdF4i3vMy8En6K16UluuLB4n27Zprmh3B0B3y
	jD7sbRJOAifBGrxWwDe8SoWi9n2gyu3gg6eHFlF/0R1l8SJ9db1/geyJIi9YPcwBWFQXe+MvMmwrK
	ZBr4UViMSNqsPKdCabAm+t1lDXlNN8VqnYJVQXUWwjhFyL1O1LmtguGLoQzL3AWxQS5F6q66k2xm3
	JaQs411g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjYb-00000007Hk5-18Xd;
	Thu, 26 Feb 2026 22:10:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] NFC: fix header file kernel-doc warnings
Date: Thu, 26 Feb 2026 14:10:04 -0800
Message-ID: <20260226221004.1037909-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261604-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: C5AF21B0359
X-Rspamd-Action: no action

Repair some of the comments:
- use the correct enum names
- don't use "/**" for a non-kernel-doc comment

to fix these warnings:

Warning: include/uapi/linux/nfc.h:127 Excess enum value
 '@NFC_EVENT_DEVICE_DEACTIVATED' description in 'nfc_commands'
Warning: include/uapi/linux/nfc.h:204 Excess enum value
 '@NFC_ATTR_APDU' description in 'nfc_attrs'
Warning: include/uapi/linux/nfc.h:302 expecting prototype for Pseudo().
 Prototype was for NFC_RAW_HEADER_SIZE() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 include/uapi/linux/nfc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260226.orig/include/uapi/linux/nfc.h
+++ linux-next-20260226/include/uapi/linux/nfc.h
@@ -55,7 +55,7 @@
  *	(it sends %NFC_ATTR_DEVICE_INDEX)
  * @NFC_EVENT_TM_ACTIVATED: event emitted when the adapter is activated in
  *      target mode.
- * @NFC_EVENT_DEVICE_DEACTIVATED: event emitted when the adapter is deactivated
+ * @NFC_EVENT_TM_DEACTIVATED: event emitted when the adapter is deactivated
  *      from target mode.
  * @NFC_CMD_LLC_GET_PARAMS: request LTO, RW, and MIUX parameters for a device
  * @NFC_CMD_LLC_SET_PARAMS: set one or more of LTO, RW, and MIUX parameters for
@@ -156,7 +156,7 @@ enum nfc_commands {
  * @NFC_ATTR_SE_INDEX: Secure element index
  * @NFC_ATTR_SE_TYPE: Secure element type (UICC or EMBEDDED)
  * @NFC_ATTR_FIRMWARE_DOWNLOAD_STATUS: Firmware download operation status
- * @NFC_ATTR_APDU: Secure element APDU
+ * @NFC_ATTR_SE_APDU: Secure element APDU
  * @NFC_ATTR_TARGET_ISO15693_DSFID: ISO 15693 Data Storage Format Identifier
  * @NFC_ATTR_TARGET_ISO15693_UID: ISO 15693 Unique Identifier
  * @NFC_ATTR_SE_PARAMS: Parameters data from an evt_transaction
@@ -291,7 +291,7 @@ struct sockaddr_nfc_llcp {
 
 #define NFC_HEADER_SIZE 1
 
-/**
+/*
  * Pseudo-header info for raw socket packets
  * First byte is the adapter index
  * Second byte contains flags

