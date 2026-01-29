Return-Path: <netdev+bounces-254595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA6PEasIe2k6AwIAu9opvQ
	(envelope-from <netdev+bounces-254595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DAAC7C4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C95F4301DDAC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F5037999D;
	Thu, 29 Jan 2026 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDIuyvMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182B379994
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670823; cv=none; b=nqWAEezd3uXqk/ibNat58foVHhb/xuSFxVF37rrRffSByMs+0Zy4wMYZTs7ZGZS0n2ivxlepQdWjOtiqHBcNbHpVXUw58xisuVyMrWpw25mDqUA2on7vwik60ZvkWLSLGwenWby7vONnqT2Eha78urxY7G1+3Tucjw0EerpHse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670823; c=relaxed/simple;
	bh=jgenuMj03TK6D5/8eKsMdxUuXfNrv6NeOB/FQYl3Nvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GETZFsdfIXbTWKiURWV02SkIVOxDl07CDx1cUqYAxC0PtRYbxaG2rAYmGcAKxQXfwY6tLT9aoOtlglrj8Xy/dPkt/f9+o0LQaQAopJoAZKvATKbxO1DIdm4fYK0q7OLvR+5xFr9YEIHjQOFsyz9JVInxyK/AJe0NndEgXzE4nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDIuyvMc; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c5320536bfso67131485a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670821; x=1770275621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVEIy0ce/mZ1haXqw7kJfBAznZATEelMO91BOoKnDkI=;
        b=VDIuyvMcWv7HS0WVaUezvVRccGl6t8RpRyjLJ7ZIbLKFVgyIhdZrc9XZEy7yQRUdNM
         lSkARCADhbwH6YvhYaS+HEZPBfMCeooTek8f4unqFFGRklU3C6Ph6OKFZlVb5ShqV1j9
         ReKVgZZTnrqsY5MWHvtRPgc3P7HOnq5OXBsiICFoeZsGfdG0CzMz7PRg59+Z2p7vxbyn
         zjVBc+x5kv+6CENezUlrLJb7geeNTTqWydYoc54iqmoH7+/SxYtixkziteTjZ9tQn/21
         MuQCVC0gtKR3cl89vooCenB+6xAKti+M19BEKLl/0d0+D5Y2tAac//1Okuy9XJlr7ncZ
         yLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670821; x=1770275621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVEIy0ce/mZ1haXqw7kJfBAznZATEelMO91BOoKnDkI=;
        b=lDCCJ+Rta7v/vyG7U8ToeAEokTseSU2SctLQmpiZWUNi2umkEI8ne6zFR94FDo4f7g
         LwNrAWZhnT+IgUwY4Cfb/klgRmfNLB2qQRyw3Ko12abem34NZuaA+GIgHxG6jN2qtca5
         qDEO11hGvWDpLISJHIoP7KVn6sWX+9EOfVurOnxCLs2felzzI0YqzT9w/KDPkcjJGnMG
         Upv+7MjAjj3+6EcAKxErSKenKaSqajn52KdeWbZzJlHhFacFNIT7iIZacNEVD04S6ZaO
         Fl+Y8gBwvfnzXOfwGw+IODK0IohGliLAaIog4GDlGvHlE9YHcbTTp/i6mQgIFyDnIooW
         TxNw==
X-Gm-Message-State: AOJu0YzxdN5O9g7Duod0dCUoKe6OsvnTicDHiZXdVjESQ5cIyf6VYIsy
	pHjS4F+WnSqwxRDTg3TYiTdlCGt/edkZZGnip/l/XByrR6YwUVEYv9lx3jVyBCcT
X-Gm-Gg: AZuq6aK3SCy0mDzhcqvkFURoEiOWrbhzYhvouOVbixCajHms3YE29LG5NDakjeWJRTV
	ewfAnpXnVzWvhsD3M+8uq21rf/hOnK++29Z6LMwQbXNXrBU+mhAY7GBHwOlksAlRiQpc0krYJ4v
	kL9jk90DmnHgzPnvaui3m8KGh9n/+WoU/rfCDmITesR05icK6eXjSb6woRCjb3ZrVGOECjf5wDi
	BQARck4QTSThtuRQyh1lGknlgYnctddFeHaUrcARfqtHUGhfRJjUe3uG5EdMWBfDeTo7qCD/t6b
	lRwGHRh+Awk5SLHkVOzglSbMIAaTaBLnqcTs95HcZiuOeOkc9ayeX+QDtOmHdqnW6Kt0VHkf1g3
	+ThDN/vLK3DCDNqaaNcWx22K2RKAKi3jln6vD6NZECIuXxY1laGx+GI/nDyFEo74k7cQEDvge3D
	/9N8Slu647O2SDzAyJnNxvbi5+O6mMz84X3x2RWexfhsOpxmeHXmZoe0cNwy+Yb1ktIqWkLgBFN
	drn/uOkuI2uzyTw5AlNVh2BdBfMR0biJZapJ38HTlcxjH01YoKwBw5nLnqWpy9afzx9oxjw/fhF
	qt2DVdpXunXK5rk=
X-Received: by 2002:a05:7300:e607:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b78d98ec0amr4513162eec.26.1769663866887;
        Wed, 28 Jan 2026 21:17:46 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm5466345eec.31.2026.01.28.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:17:46 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] uapi: net: mii: correct 100BASE4 bit descriptions
Date: Wed, 28 Jan 2026 21:17:35 -0800
Message-ID: <20260129051736.18986-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-254595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D66DAAC7C4
X-Rspamd-Action: no action

The 100BASE4 bits in MII registers indicate 100BASE-T4, as can be seen
in Ethernet PHY documentation (such as the datasheet linked below), not
4K packets. Correct the comments describing these bits.

Link: https://www.ti.com/lit/ds/symlink/dp83849c.pdf
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/uapi/linux/mii.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf53..ba6f8a4fe0a6 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -66,7 +66,7 @@
 #define BMSR_10FULL		0x1000	/* Can do 10mbps, full-duplex  */
 #define BMSR_100HALF		0x2000	/* Can do 100mbps, half-duplex */
 #define BMSR_100FULL		0x4000	/* Can do 100mbps, full-duplex */
-#define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
+#define BMSR_100BASE4		0x8000	/* Can do 100BASE-T4           */
 
 /* Advertisement control register. */
 #define ADVERTISE_SLCT		0x001f	/* Selector bits               */
@@ -79,7 +79,7 @@
 #define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
 #define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
 #define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
-#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_100BASE4	0x0200	/* Try for 100BASE-T4          */
 #define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
 #define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
 #define ADVERTISE_RESV		0x1000	/* Unused...                   */
@@ -102,7 +102,7 @@
 #define LPA_1000XPAUSE		0x0080	/* Can do 1000BASE-X pause     */
 #define LPA_100FULL		0x0100	/* Can do 100mbps full-duplex  */
 #define LPA_1000XPAUSE_ASYM	0x0100	/* Can do 1000BASE-X pause asym*/
-#define LPA_100BASE4		0x0200	/* Can do 100mbps 4k packets   */
+#define LPA_100BASE4		0x0200	/* Can do 100BASE-T4           */
 #define LPA_PAUSE_CAP		0x0400	/* Can pause                   */
 #define LPA_PAUSE_ASYM		0x0800	/* Can pause asymetrically     */
 #define LPA_RESV		0x1000	/* Unused...                   */
-- 
2.43.0


