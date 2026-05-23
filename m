Return-Path: <netdev+bounces-291067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOdqBABpEWrKlgYAu9opvQ
	(envelope-from <netdev+bounces-291067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30F5BDF99
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D285301CF8E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B73750B9;
	Sat, 23 May 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFrKywnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33F374190
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525867; cv=none; b=fG7DXKZJLtGc117j2vh4JQ86Nlgqc81KgMKoP+YvJBr1FVs993y5j7QGfqtkELZixwMJyWB6eXYXEqtANQqybYNTwvib5VzKyohnkm0kWjoRILgILIWBFvEZ8Qsd/+TX3i+7eY0sF7/CNdQ5t3TdXYj357J5ogdc4Gwx74W+dGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525867; c=relaxed/simple;
	bh=LOuv6LBODqsvsKQfWfPMlLqdey26ht+cHZM6a96wiWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hva49wnPF8sbgwPdtwb/ZutiO2R0cUDHr/d6qke2XmqpNp8zop0mZXwyQuo3AGlI6CD2BM7j7oQ50qUfnHLeLpVDofOR4l3QuITtuItol8n7Xh4MmhrEdjpb+qC9DCfDH+Wb5Et9anppWZK70t3vIZluIdbwlVBH4aTsHM3EFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFrKywnq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1386030066b.3
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525865; x=1780130665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AjESINGZXo1FbNpnq3OQ+lE96hLtibEqkNb3ouXLoxs=;
        b=qFrKywnqpoA6uaR+iYUoP7HzrifrDFpwWipmEtWG8Y2Vbwv+2ZLOYRCQXc36tBKPsz
         L6kk1xXEgo6yrif3r0m4Y2GWzjClniGOPtduoTpDVOnpskfb28HlOjYy8gQrgJcap55J
         SXcOZaxEPO+EByuOCGP7u8LAgZnj9MHf8HOYpeGG+Dwtav1jWgStduumtQnFf0i+sTuJ
         qFW85cGA7KcyxmcrPdsf/auV9vxgn6d4O5VrsTYARCT4AQ1+lESb2Qb5LAE80YNxEYL0
         kwTslOWJK1RVZzmtc81HHawpflNHLUwr3Lq4MtKVXxrbVqwEI+rnHkvyA0a+MbvDDgko
         85Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525865; x=1780130665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjESINGZXo1FbNpnq3OQ+lE96hLtibEqkNb3ouXLoxs=;
        b=Qz+GsoGyqByqBwRn6hhXoaKmS/i+6AazFozMQ0heHE4L6Unu7EQTFASvHva4Anpkd4
         riyH6VzMMl8avb/9ILG2E/f3xoBispwwkKu7wx0wCxq/myzw1JXvXIS9z8zzZ3tXBNuw
         YF0+w8t4ep6jO5Oc2VS9pnH8Yjy91Xgy+Az5ivh2jZjh6Meng/BL4pCLdymzbwgxnRzL
         f9VOnTI2Uxf984hz9DyHHrWhQvuxmwzYWOmw+sFTMrWILzPZi/Uawn/cUB6JY16nFzpw
         u2x9bPx77Nm9rjqWMgy9qEdZQW8STx250e3uObEwXXhE++p7+vYH3sbc6epY6Ia3Quq5
         DeRQ==
X-Gm-Message-State: AOJu0Yz6A3/ZyOEhJqM8MrUz3WVyQBdcT69ms1cQ81y0Va5GDvwfK83e
	lr7RntVNILCJq715BA/a/WYQOfDJSR4yGJ1ncsA/ZsoFQyjIJMKrFu57
X-Gm-Gg: Acq92OHXB2O7Ga1JVCn2vyGFklqZsJ0vvawDj90REW+fP6nTxQE9+dtG/Lh3NiVsACQ
	KOUDWeoXG0UhYwT/gxeY6ecgADdcOO4alzmgzmOF+UcKPWfTHD2gooayVkWnpCSdcngoICmT0N/
	zHzejJAnEOMz7j8Ha7a+OlOFNYgcs4eyH374wxoJQEyAUCB5g0sAQAJP+Kogd6Ee2zXpZWVECN4
	HIck7LjVmKr9VqbgyE2mxqu2nE2QCV/tZRh7aYNqVcqFTL9rAMmjXLZjKqdz/P/ZXnM+y1Jon5l
	UI6IwxuUOIeFwpUOaosq1FCBtrMzeexXotdA1RWl2GfCJkGn69eO21FA4oTrMa6UJB7537yu4d9
	5hdyzhNnDRPJdMjb/UprYDRzVrgIVVK1gKEg7DA8jJhKRI8D3oLQI7gMt66mTehqhmVDbI+qzye
	ha04nYzmu5YQOX
X-Received: by 2002:a17:907:75dc:b0:bd5:27b7:adaf with SMTP id a640c23a62f3a-bdd272cf2efmr313030066b.33.1779525864367;
        Sat, 23 May 2026 01:44:24 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d70a5sm154042966b.48.2026.05.23.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:44:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Infineon/Intel XMM6260 modem
Date: Sat, 23 May 2026 11:44:05 +0300
Message-ID: <20260523084408.50346-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291067-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF30F5BDF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Infineon/Intel XMM6260 is a 3G-focused, slim modem platform designed
for smartphones, data cards, and Machine-to-Machine (M2M) applications.

The modem is typically connected via the application processor's USB line
in HSIC mode. To function correctly, the modem must control this line, as
it requires precise timing to initiate or de-initialize the USB connection.
This control is necessary to successfully enumerate the next stage of the
USB device loader (moving from firmware loading to the actual device
interface for example).

Patchset adds support for the generic portion of the Infineon XMM6260
baseband modem, which was used in many Tegra-, OMAP-, and Exynos-based
devices circa 2012. This driver provides generic power sequences,
manages initial communication with the application processor, handles the
SoC-specific modem powersequence, and verifies that the modem USB device
appears correctly.

While current support is relatively basic, this configuration already
allows the modem device to appear in the dmesg of my device
(LG Optimus Vu (P895)):

[    9.427014] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    9.431488] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    9.457197] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    9.460370] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.16
[    9.468470] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.475597] usb usb1: Product: EHCI Host Controller
[    9.480508] usb usb1: Manufacturer: Linux 6.16.0+ ehci_hcd
[    9.485913] usb usb1: SerialNumber: ci_hdrc.1
[    9.490862] hub 1-0:1.0: USB hub found
[    9.494005] hub 1-0:1.0: 1 port detected
[    9.657191] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    9.844726] usb 1-1: New USB device found, idVendor=1519, idProduct=0020, bcdDevice=12.74
[    9.850530] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    9.857594] usb 1-1: Product: HSIC Device
[    9.861606] usb 1-1: Manufacturer: Comneon
[    9.865627] usb 1-1: SerialNumber: 0123456789
[    9.908739] cdc_acm 1-1:1.0: ttyACM0: USB ACM device

This patchset is a part of larger series aiming to bring XMM6260 modem
support for Tegra devices:
https://lore.kernel.org/lkml/20260511135703.62470-1-clamor95@gmail.com/

---
Changes in v2:
- changed phy to pwrseq in schema
- adjusted Kconfig dependencies
- implemented bitmap for modem state tracking
- switched from phy to power sequencing
- in notifier added chech to filter only USB events
- in notifier added USB_DEVICE_REMOVE
- added tracking for regulator, rfkill access, usb device
  presence and poweroff calls using bitops
- moved pseq on call from work to irq handler
- improved rfkill registration logic
---

Svyatoslav Ryhel (2):
  dt-bindings: net: Document Infineon/Intel XMM6260 modem
  net: usb: Add Infineon XMM6260 Baseband modem support

 .../bindings/net/infineon,xmm6260.yaml        |  74 ++++
 drivers/net/usb/Kconfig                       |  15 +
 drivers/net/usb/Makefile                      |   1 +
 drivers/net/usb/baseband-xmm6260.c            | 378 ++++++++++++++++++
 4 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/infineon,xmm6260.yaml
 create mode 100644 drivers/net/usb/baseband-xmm6260.c

-- 
2.51.0


