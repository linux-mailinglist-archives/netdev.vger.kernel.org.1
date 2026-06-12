Return-Path: <netdev+bounces-298671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J/CMHg8KLGqwKAQAu9opvQ
	(envelope-from <netdev+bounces-298671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B811679D91
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:30:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VvCxJbxZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8428C3029D07
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A453EDE75;
	Fri, 12 Jun 2026 13:30:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37D3264D2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:30:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271007; cv=none; b=AJhqI5crkaGfPqOTPrfyWVdrwzNP/fHUby4ibO8oVvuH9ujn7sy61Y5bTOIDnUNJtyCXe4uPKBHbmnjz+SvV5I8BxfE+uakzXrE1h7ASkCWC4B0+vJLZunmWsxpVQYzCCxzLph7zciUFfvvbXFIh1Qi4oQWWsYr799Nijq2Vu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271007; c=relaxed/simple;
	bh=D55jdz0uIc/qge56hNomD2wxxsVODJGJ5/yGkCrTFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZjpkGUK6/9ehzL4AuzBIQVidpTxY1qzfcElQDWXPlxJhjgMsTmC+7Xqysw1C1Gk3ZpSnO0Pi4SBSDq3XhC/0sCXFPMjKp5D51/EzlhJV75ULGXnr6Uel/9lFWJviUvibYOwu2R1u66WtUJjsBwnJHHEyxDbvCflj0gBkJjUU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvCxJbxZ; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so11419385e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781271003; x=1781875803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34xJfHUtfBhzidmrk3neM4lC4vDotCKUYix1d8mNaWM=;
        b=VvCxJbxZyinFjZIbRwAT76Ybm9QNPKuLrCC+sXZHgGQkw52GXTC6qyXq+AtueQpdkD
         F84A/9fijAq3udQ53yR826+XUZFWMIxfnaZUqlsZDHuYQDmylbu/opKYy/mGqXD7SZxA
         YKj9jzEjKhdh1Fe8NdH9ZVR40AtFVLvSGF8lyz0L8KUc2K9Vmy87imF6JRzke5XOz/75
         X96XUbv7jg73tqIvJXA/n2dgo8fAbP8CGJYDmx9DNzfwdSdD3TW6xalN51C+k2mRlpLJ
         FnyV6fz348PRASrk9X6uR3Lvj3SHeZ3Q4v6Y9Q/7PDML622INfieshcpqJhmd5Ja7lCd
         +8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271003; x=1781875803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34xJfHUtfBhzidmrk3neM4lC4vDotCKUYix1d8mNaWM=;
        b=dzAIwuB6fovm8PR/3dpYPWyu5iXagsMw7QRqtbCL1L3SEUv1rd0KudQUI4Pn4Rxxam
         YcP+GjwlsJAqWOgaRXqOf0b9ORUFoVTY4M2doYNbwOuBjU2csX8Qj4+kST+yXgO/W3fv
         Kp8Zmh4l7IQzW/rq0NhZXtCjHwXCxwABb9H+ZQQ2HRLAo9DQ9cgbdtVsEzJSFzpLvc05
         +Qbzi/UBnTof8O6K2sJMlPZfK8ZmgF8sziiSa2e3r79KqchZEyBeZDDG//fIrrmFsD1p
         9QrTkR4aTmjLsD1okQKZIIBfdeVvnwNbUaXbGLvBgI2RRpFZ/L5XRoAw5VPQcQm8VyEP
         JrIQ==
X-Gm-Message-State: AOJu0YxyXigclcCFOERnHnnpLcNGl/FPpzCoHCK+WaJxKgs9P6zi4eKL
	8o87U7SNdsU6fNa+uEwIOTaCXtSfmiY+7LXZzP1vh/C7JogTZvt/C8u5
X-Gm-Gg: Acq92OFVfhY7VJGJKS1nNnGGfsaDPEfisX80x9bkuP0cGd6zTIesw2HDsdtA2c+flec
	TU4Wnut1iJVohUnxaHawGfsxnMRp+52T/CWMWTV40Kfej19yPI6+tWZwDIJshxzc/b26bKmqrNc
	25MMYQVcOHR6ATfppZmLeTx6f2VK3eI6wq6K/BLSqoxAVHLNUJSHyvN9Q3c1HxYoJgudwsT6QPY
	i92qxbRevFDIG7MYq1oWWWQ9uHiBUT3H0v0L+lcBTebd2+8OIYvna/7wGylHDOdMtd/c7bjlNUf
	fNlXG69ubS6EY9uSxe77C+SKNLXjibjxlfUuHJBdR6q7Mv9y0ah5bb+YOUh2FMzZOToM4BLcPe8
	B+jONYfZmKq7vjtG3pFmr+G9QesriUVImzW3dR7o+F/x4u9nBD4lPJRJn8TW5f/OqHMAw34LsYK
	fZS+Y4R6W23XU4Z3OeLmAN/MwSwA==
X-Received: by 2002:a05:600c:574c:b0:490:d354:bcef with SMTP id 5b1f17b1804b1-490ec504ab0mr30086585e9.33.1781271002915;
        Fri, 12 Jun 2026 06:30:02 -0700 (PDT)
Received: from builder ([2001:9e8:f11c:fd16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2cf582bsm166811555e9.10.2026.06.12.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:30:02 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v2 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU support
Date: Fri, 12 Jun 2026 13:29:40 +0000
Message-ID: <20260612132944.460646-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B811679D91

This series adds a PSE-PD driver for the microcontroller (MCU) that fronts
the PSE silicon on a range of managed switches, together with its DT
binding.

Hardware model
==============

These boards do not expose the PSE chips to the host directly. A small
microcontroller sits on an I2C/SMBus or UART bus and manages one or more PSE
chips behind it; the host CPU only ever talks to that MCU, using a fixed
12-byte request/response protocol with a trailing checksum. The PSE silicon
never appears on the bus.

The same protocol family is used by MCUs fronting Realtek PSE chips
(RTL8238B, RTL8239, RTL8239C) and Broadcom PSE chips (BCM59111, BCM59121),
diverging in opcode numbering and a few response layouts. The driver
abstracts that behind a per-dialect opcode table and parser hooks, selected
by the compatible. The specific PSE chip behind the MCU is detected at
runtime and only influences per-chip constants (power scaling and the
per-port cap).

Why the compatible names the protocol, not the chip
===================================================

The compatibles are "realtek,pse-mcu-rtk" and "realtek,pse-mcu-bcm". This is
a deliberate choice and the part most likely to raise questions, so the
reasoning up front.

The node names the protocol dialect, not a part:

  - The DT node describes the MCU, not a PSE chip: the PSE chips are behind
    the MCU and never appear on the bus, so naming the node after one (e.g.
    "realtek,rtl8239") would describe hardware that isn't at that address.

  - The PSE chips are, in principle, usable without this MCU (host-driven
    directly) - different hardware with a different programming model that
    would warrant its own binding. Claiming the PSE-chip compatibles here
    would collide with that.

  - Naming the MCU silicon is equally wrong: these are ordinary
    general-purpose microcontrollers (GigaDevice, Nuvoton, ...) that vary
    across boards and are not dedicated to this application.

  - What is fixed, and all the driver needs at DT-parse time, is the
    protocol dialect, so the compatible encodes exactly that. The two
    dialects share one protocol family and one binding, kept in a single
    "realtek" vendor namespace because this MCU front-end is found almost
    exclusively on Realtek-based switches; a "-rtk"/"-bcm" suffix selects
    the dialect. This follows the "google,cros-ec-*" pattern: a compatible
    for a firmware/protocol interface implemented by varying
    microcontrollers.

One compatible per dialect spans both transports:

  - The 12-byte wire protocol is identical over I2C/SMBus and UART; only the
    plumbing differs (SMBus vs native framing on I2C, baud rate on UART),
    and the transport is already expressed structurally by the node's parent
    bus (i2c@... vs serial@...). A "-i2c"/"-uart" suffix would only
    duplicate that, for a protocol that does not change across transports.

  - This is the multi-transport model used by e.g. "bosch,bmi160" (one
    compatible, separate i2c and spi drivers binding it), rather than the
    cros-ec model of per-transport compatibles - cros-ec splits because its
    on-wire framing genuinely differs per bus, which is not the case here.

The binding documents both points as well.

Testing
=======

 - Linksys LGS328MPCv2  (RTL8238B, I2C)
 - Zyxel GS1900-10HP A1 (BCM59121, UART)
 - Zyxel GS1900-10HP B1 (RTL8238B, UART)
 - Zyxel XMG1915-10EP   (RTL8239C, UART)
 - Zyxel XS1930-12HP    (RTL8239, SMBus)

---

v1 -> v2:
 - all points flagged by Sashiko addressed:
 - uart: drop frame overflow (return count, not the stored length) so
   serdev retains no leftover bytes that would misalign the next response
 - uart: guard rx_buf/rx_len with a spinlock to close a data race between
   the async receive_buf callback and send/recv
 - i2c: return terminal MCU error opcodes (0xfd/0xfe) to the core
   immediately instead of polling to the 1 s timeout
 - core: cap BCM59121 at 30 W (802.3at) — the basic 8-bit set command
   can't program the advertised 60 W (it silently clamped to 51 W)
v1: https://lore.kernel.org/netdev/20260608205758.1830521-1-jelonek.jonas@gmail.com/

---
Jonas Jelonek (2):
  dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
  net: pse-pd: add Realtek/Broadcom PSE MCU driver

 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  |  154 +++
 MAINTAINERS                                   |    7 +
 drivers/net/pse-pd/Kconfig                    |   28 +
 drivers/net/pse-pd/Makefile                   |    3 +
 drivers/net/pse-pd/realtek-pse-core.c         | 1007 +++++++++++++++++
 drivers/net/pse-pd/realtek-pse-i2c.c          |  164 +++
 drivers/net/pse-pd/realtek-pse-uart.c         |  156 +++
 drivers/net/pse-pd/realtek-pse.h              |   87 ++
 8 files changed, 1606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse.h


base-commit: f6033078a9e671e3c8b83d387b91591a6f6a54e7
-- 
2.51.0


