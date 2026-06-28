Return-Path: <netdev+bounces-302427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uRSEA+KfQWo4swkAu9opvQ
	(envelope-from <netdev+bounces-302427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 00:27:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BB6D527D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 00:27:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qGbtdkMu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE0930207EB
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A93BB69F;
	Sun, 28 Jun 2026 22:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4E3A6B8E
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 22:27:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782685635; cv=none; b=ukZGF8Fc8BMLgMyx5z9tlbK1Nws85T6Flf7nzT4B9jf5EnMWleDC0+KhHy6+JG0e1Y1Sn6oS0OJ5la6SoowVFzy87w24ssK4AjSH4GNi/gsIUOq868njJFO1A0bIhq9DmrNu/0M1mZc36jRjwASw9w0dLRN7MBR/GuWTja3zfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782685635; c=relaxed/simple;
	bh=XnpeFFRVO0tjDOoFmUitfP//W/nUOurCQmEvHUHdycg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EA9E/3VOrD5ccGnSo1LHOIHnfZkrBGSW07VOUSstqWV5fXrmPA1yn0WPD+K4be98HbcMJNGZduOQPqdkNkZ3MrYmKnpHU6+QaqM1ufHyuA+eARSa68spYWHgD+qW1A4czEn6VzLzYz+GidQ4EkkZ/akkiEYShdpAIsKPza0FMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGbtdkMu; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4939a809b24so10915985e9.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782685632; x=1783290432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjl7WES8qENIG4D2sCAdOBhowl2ZPI7VPIfctvhWNJE=;
        b=qGbtdkMuUtpiPn4jYoEgv7CUUVXcgVZ4K8kPLbriFHAJo4N3d4QR++TAN4wOBjoQDm
         ZZWcFNEWhaDGFBLQxnxkPaUHaHNuDYqtxMVjk9TaMzi/gzTj1NgIP8ukiPC+JKcyhJQw
         eBhk5clcuM3T049g1cOwlkC/JIsAF40lb1f+CTm+9PIMXBGmnR4QtYGSAs7JdJxJFFAf
         I1j5w5xNKGloI4YSLtmZPz8YRbRRlkJOJdij7NXh0x7DFR0gEGlMA8HwaIod2DeauUtH
         yUBDr9E1p74ppCWr2zLew9ecQAZACwVz9Pi8q+7l/FfED35o2zq6orfpsOjHwHPp1xV6
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782685632; x=1783290432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjl7WES8qENIG4D2sCAdOBhowl2ZPI7VPIfctvhWNJE=;
        b=TpZxDQGkPCv8UaWrxefjFpvqWWHQp788qhBMryTmQ4PgLgpoP8qI7k5rCNQ+kLVVBj
         NCKgCubh8U82sE7pXKLiTHVQFpLj8FjDJujJP0ZCX1DLEt5a4zKyf8xJT917em1/X8Dr
         fhab/jOJj4oDqjBgpkavh+IMAbeD+wiZrAjPgDFFJ/eCQ2VAPtphG5VK/1tX0SUVlbXl
         kZSwVfMKehkAhyhQdf/cBNEp2W43ZqhPm9D8FicmhUuEXL9itq2sxhOofJ2k14w51xhA
         vRXX4vgrEHMPxhm1rLFydy80HnAVvrsqgufmLxLNmvfknyUh6kHd4KmpaS63+TQdpLSN
         EDAw==
X-Gm-Message-State: AOJu0YxvhDxvSem5wukYyNz5FVUXl8g3P10vJqUl5OA0sOC+5ZDUkUz3
	IFw5xRGp/WTlRLJ5nXMrF1rB7elQmKLxtBq7syXLRmE/vBjsvFUhL/gg
X-Gm-Gg: AfdE7cnjRuRdLkfnxgIwqxtbjbjMDlseCxPBfyd6aZ6eqzqwixSqv45B7fnKVaxTPAo
	0jHgnglcyZBDYNWfnVFkESE9gstbCAH1PSQH2BT1k1yJDWRNWpUNggfUzKk7OS4xGAM+Y5faWNm
	IL4GmksMXC9kXBCURIR/Z6hI84eDEVS3rf/fsU7c4zJGwima5RkjqyDrtnsPbxGSRFEv/4SF6wg
	se7ZoTpwl3QkT8FgH3sz6xo5WV7EwKybqGwCfV/ZTU/oxWatp6VErUKF8r450uUQtw6APqKLf4B
	7p/pfWEF5vALhfs1XxLVQNPpfsz/qrwLoOj+77Y0r9t3aK0VCziXmkTyZOGEMa4ZqJm8+b9M0Gs
	lbqKQWCpBWtaYEiE2WGvbKu9o7bIPoTtngUTZlsOEHQoSO01XMmBeSw09on9/a0w4IMGskI/JUf
	PSwkG2MzdBEcLHipc=
X-Received: by 2002:a05:600c:8b08:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-4926687e70cmr224768435e9.17.1782685631820;
        Sun, 28 Jun 2026 15:27:11 -0700 (PDT)
Received: from builder ([2001:9e8:f10e:1a16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269002511sm246811675e9.8.2026.06.28.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:27:11 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU support
Date: Sun, 28 Jun 2026 22:27:02 +0000
Message-ID: <20260628222705.4052815-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-302427-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 604BB6D527D

This series adds a PSE-PD driver for the microcontroller (MCU) that
fronts the PSE silicon on a range of managed switches, together with its
DT binding.

Hardware model
==============

These boards do not expose the PSE chips to the host directly. A small
microcontroller sits on an I2C/SMBus or UART bus and manages one or more
PSE chips behind it; the host CPU only ever talks to that MCU, using a
fixed 12-byte request/response protocol with a trailing checksum. The
PSE silicon never appears on the bus.

The same protocol family is used by MCUs fronting Realtek PSE chips
(RTL8238B, RTL8239, RTL8239C) and Broadcom PSE chips (BCM59111,
BCM59121), diverging in opcode numbering and a few response layouts. The
driver abstracts that behind a per-dialect opcode table and parser hooks,
selected by the compatible. The specific PSE chip behind the MCU is
detected at runtime and only influences per-chip constants (power scaling
and the per-port cap).

Why the compatible names the protocol, not the chip
===================================================

The compatibles are "realtek,pse-mcu-rtk" and "realtek,pse-mcu-brcm".
This is a deliberate choice and the part most likely to raise questions,
so the reasoning up front.

The node names the protocol dialect, not a part:

  - The DT node describes the MCU, not a PSE chip: the PSE chips are
    behind the MCU and never appear on the bus, so naming the node after
    one (e.g. "realtek,rtl8239") would describe hardware that isn't at
    that address.

  - The PSE chips are, in principle, usable without this MCU (host-driven
    directly) - different hardware with a different programming model
    that would warrant its own binding. Claiming the PSE-chip compatibles
    here would collide with that.

  - Naming the MCU silicon is equally wrong: these are ordinary
    general-purpose microcontrollers (GigaDevice, Nuvoton, ...) that vary
    across boards and are not dedicated to this application.

  - What is fixed, and all the driver needs at DT-parse time, is the
    protocol dialect, so the compatible encodes exactly that. The
    "realtek" prefix names the owner of the protocol the MCU runs -
    Realtek documents it and supplies the firmware - following the
    "google,cros-ec-*" pattern (the prefix is the protocol/firmware owner,
    not the varying controller silicon). The "-rtk"/"-brcm" suffix selects
    the Realtek or Broadcom dialect; the specific PSE chip behind the MCU
    is detected at runtime.

One compatible per dialect spans both transports:

  - The 12-byte wire protocol is identical over I2C/SMBus and UART; only
    the plumbing differs (SMBus vs native framing on I2C, baud rate on
    UART), and the transport is already expressed structurally by the
    node's parent bus (i2c@... vs serial@...). A "-i2c"/"-uart" suffix
    would only duplicate that, for a protocol that does not change across
    transports.

  - This is the multi-transport model used by e.g. "bosch,bmi160" (one
    compatible, separate i2c and spi drivers binding it), rather than the
    cros-ec model of per-transport compatibles - cros-ec splits because
    its on-wire framing genuinely differs per bus, which is not the case
    here.

The binding documents both points as well.

Testing
=======

 - Linksys LGS328MPCv2  (RTL8238B, I2C)
 - Zyxel GS1900-10HP A1 (BCM59121, UART)
 - Zyxel GS1900-10HP B1 (RTL8238B, UART)
 - Zyxel GS1920-24HPv2  (BCM59121, SMBus)
 - Zyxel XMG1915-10EP   (RTL8239C, UART)
 - Zyxel XS1930-12HP    (RTL8239, SMBus)

---

v2 -> v3:
 - dt-bindings: using brcm instead of bcm for Broadcom
 - rename the driver files and Kconfig symbols to realtek-pse-mcu-* /
   PSE_REALTEK_MCU* for consistency with the realtek,pse-mcu-* compatibles
 - rename driver-internal prefix from 'rtpse_' to 'rtpse_mcu' to
   emphasize this targets the MCU-centric setup (and leaves room open
   for eventual directly addressable PSE chips)
 - rework the vendor-prefix rationale (binding + commit message): the
   prefix names the protocol/firmware owner (Realtek documents the protocol
   and supplies the firmware), and -rtk/-brcm select the Realtek or Broadcom
   protocol dialect
 - core: reject zeroed/echo-mismatched responses via the echoed seq_num
   (a BCM PORT_ENABLE on port 0 was otherwise accepted from an all-zero
   frame)
 - core: enable the PoE supply before global-enabling the MCU, and roll
   back the global enable on probe failure or driver removal
 - core: drop inline from helpers (flagged by automated check)
 - uart: update the completion under rx_lock too, so a late frame can no
   longer make the next transaction fail spuriously with -EIO
v2: https://lore.kernel.org/netdev/20260612132944.460646-1-jelonek.jonas@gmail.com/

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
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 1017 +++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c      |  162 +++
 drivers/net/pse-pd/realtek-pse-mcu-uart.c     |  155 +++
 drivers/net/pse-pd/realtek-pse-mcu.h          |   87 ++
 8 files changed, 1613 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h


base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
-- 
2.51.0


