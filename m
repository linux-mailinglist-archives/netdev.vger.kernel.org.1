Return-Path: <netdev+bounces-255124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IInBNQqZfGmJNwIAu9opvQ
	(envelope-from <netdev+bounces-255124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:42:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF2BA262
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF2D3013D51
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542B36C0D9;
	Fri, 30 Jan 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNGVY6gR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA236C597
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773318; cv=none; b=KSvCRyQxw7s5GI3qCtDNOv8FMWnH4l08ZZMjaXF2GAQ7PbrhJ+/WyIh3NtwRHzOLCCjjwTTLYMMQCmqMq589O7l2duqgnNFEQNwA6TzomeU0aWCPl3FhQq5/PX2on1JVZbO2A5yjMzw4alq6ZJIzpLc+B3SxtDoNXxtlw2z4yXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773318; c=relaxed/simple;
	bh=QYbm57pbO7UP72Nd6eTkTa1GxsZUUno9GSyI0kkRqQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah9uv0bWMeMeoE8F0l9XmLqltoj+Rk28oOznEEIxaj+T89QQpnScIT7I5KsWQy96pjJocL1cN/1Hs5d+KqYqGbcHY+raeSa7gUx0PpMomhMujca2w+2GW/POQ/u2xnvmKZ/sUQgB1WqG27KU1ukTSUYq9xhLv3NOo9F2K5V2tqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNGVY6gR; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4043496eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769773316; x=1770378116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xecIX2fMDAwRib/lst+YsPeYlfC8fIbaBNXW8TdPxjw=;
        b=aNGVY6gREu1bjNZinnmBxXxEs/J5h9aZ4e9gqVKA5/bvlAmD9oJj5H32iZdPe7IMG1
         ZfNO30iL3Bl7Emeklueo7SHWZwOjNRURc6ZPOiRq19OjVsD0tChQ7gZGolwWQv88+dmj
         Ms2zl2MDwdQct68JiyyDHGfFRllXEj7g8HLj75eQ0dfCwRBreAQfc4KQHELrHjqXfLqd
         fwFMebQ0M9GAKwHkCdSVhmpW7+9CdsCsawABpBtI5QIXoqx19FgHQa57uvusLq/8SIn3
         422iIbGG2tcvEuTmFUXuUC9eE4HthA5J7cU2nO3uPOGJIk9X34Qs4lNLwfy2LU4JW2kh
         XgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773316; x=1770378116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xecIX2fMDAwRib/lst+YsPeYlfC8fIbaBNXW8TdPxjw=;
        b=OzVP/WMP/j5PU1qlS4W4IuRLM6Y1Sw8jOVDjm29XPx+xSwz953nPlivdtR28STDSBx
         6nYcBL9ey8c+z9h8Eh7kC5ZxEWopUPPO2hqzT9jHS1rwGd/4hpXevBLWcCDXglKNsOan
         naMJLxtTOm28Fei5LqIaPVfgD7iW5iudwqtEFKcTwzWi/ewyTPSH+H7dxNC8HNUOvFnW
         /9QaH568n4Fo8VYdaNooUS0EL42q0QYxQcVYECViW1WCiS68pzRif9Ir86qd9tob2OYY
         vm2mVGs/HeX8/7JpUp8ucwoJMoouV0ho2yOcZ+a/okyQ6/T1P13L9KI1YmKi9avJPuSl
         uC5Q==
X-Gm-Message-State: AOJu0YxUR86KSOJ6N3aYobiPXG7ftK0kqvziwAG4uKYLKSdZYTmXlNW0
	9gPOF0rK1wYYNKTWF71DS/TLZZJUzBcda+iQ6RTcsr3VQ0mGSwZuGDXbLs1+ZZMQ
X-Gm-Gg: AZuq6aIDeID/2BbJgW8DFYx7i9VGuAX4joGx5F6OxUhOS3m4v/O1AJOLP+1jHVAmErr
	wuxffVx6HZ2/QdjOb7w+dd4iTGg/lNaxv/MIz3QXbvFLonZKHScaXZ8gLeC5KRjNLyw3EuRL/NU
	9nrVLhCKMX+1ltJJHUDfdvceRptXZTkp+icJg9lFUFfK0p/VwFgFR2MvvyU85AuPQChPVyG5z/u
	sbARJb7Jifb8zPPRYkWLd/0sgf2pV11MXsWiTXISey4UTyqHKqAZ7L4iMBkS+wBRGUaR1jhTRka
	bCMk7cWAo2Qd8Bd5PUvoLRzM4ivTGaMxQVazS1pKz1uFQx1j38RYZ/T5J3LtKysR0goc9l+BXx4
	Frttrt4yDwnezjV4WAieRiz3C4S81wm8+o1tjj18SGrjXT3GqUv+Cyp8hhoVNqMYh+wFLqkscCt
	t3BsKIAUlNmYcw08oUkEL6f/atpCWY3/Q1rD0M4+R0M24MOkjmSVSglofNBb6lXBwUgbf3J/EFv
	k75epTdNz2X3BrsmiokqiNfJhkEk31hvE4GIOg1fHSlls3ljTnhQ2i3g6sJTPrBt+ZkeJIoWXuj
	1YXr
X-Received: by 2002:a05:7300:3249:b0:2ab:8ef5:df2 with SMTP id 5a478bee46e88-2b7c891b404mr1101106eec.35.1769773314519;
        Fri, 30 Jan 2026 03:41:54 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7bb9ca10csm5424424eec.30.2026.01.30.03.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:41:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH net-next] net: can: ctucanfd: remove useless copy of PCI_DEVICE_DATA macro
Date: Fri, 30 Jan 2026 03:41:33 -0800
Message-ID: <20260130114134.47421-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cmp.felk.cvut.cz,pengutronix.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255124-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ACF2BA262
X-Rspamd-Action: no action

The ctucanfd driver has its own copy of the PCI_DEVICE_DATA macro. I
assume this was done to support older kernel versions where it didn't
exist, but that is irrelevant once the driver is in the mainline
kernel. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_pci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
index 9da09e7dd63a..35edac9c0a5c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -22,14 +22,6 @@
 
 #include "ctucanfd.h"
 
-#ifndef PCI_DEVICE_DATA
-#define PCI_DEVICE_DATA(vend, dev, data) \
-.vendor = PCI_VENDOR_ID_##vend, \
-.device = PCI_DEVICE_ID_##vend##_##dev, \
-.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0, \
-.driver_data = (kernel_ulong_t)(data)
-#endif
-
 #ifndef PCI_VENDOR_ID_TEDIA
 #define PCI_VENDOR_ID_TEDIA 0x1760
 #endif
-- 
2.43.0


