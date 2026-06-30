Return-Path: <netdev+bounces-303084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uh6aKoykQ2qheAoAu9opvQ
	(envelope-from <netdev+bounces-303084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087A6E3694
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TSwdst2E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303084-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303084-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F235B30ABC88
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E18C408626;
	Tue, 30 Jun 2026 10:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30DB403E82
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817022; cv=none; b=XMZsJffRNN4fq8cSKSl6PYq76A2EyF8/d1cGWXW4bDoWZ+fECVlNBe13sNB0qpLawgoh3JUfMaxg7Z6zpEI3uXOLYr6OK0CA2RFkhRuA2OHOYzlnJ3o0QhiXNjHSm1p6kCOhxYk4WCgRgfJkiZRj5s0pYUXczTO6ubDRmqm6RN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817022; c=relaxed/simple;
	bh=HliCWpX+P4iK2uQ6x448yHALdeeH+CaHIUpO3piBc98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmSzstKOb96EfvKRSbrhuey7DVqNoK33a7Waltq4sg6fgbhd6l2kkurXhf6NYBUsuAAaaYk5Duw3nd5LBiXdeFNoT1Sa2OtAYNl9zFwoUW6G7jVJ6yVGs0g8KABLOvCQLczF7AnkY8zJElcgusqD8K8kHF6sR60/VnkGvK4jxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSwdst2E; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493a548fc99so12025235e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817019; x=1783421819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTjmg/WV4XIIk+g1JyzkTwvD2NVKFE7W+0hhPUx5v0k=;
        b=TSwdst2EsJEspRGlkHd4rrXmk5+XhC5ICN9c9ic/i7pTZQAt9e3izlS8+5BAT7jCxJ
         WU02zCR0axgdfuusrjUMg0hZcNnpCnmFF7LQ/QfZJSPpC/F/d0aai03wLtR/JewevPRv
         hal9YKG/5Ok1nMrihLRKb8rEJ0Oy5e/PnhSD5kFVYtY9Q55xxPTquISOi9T/4tlwWlig
         xV9cETrvcIc/MUJd3MYBdpXXS/tEc9YzgarBwQDeZgh02YdtJfAO4ob4iCeb6AJ0scMJ
         e0+xYkP8yr9rRnwRYAeE7wQbI+ucOSnbheipzFgZhQodgHZAKX/+cIihbGDEaVG3ULrr
         uUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817019; x=1783421819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTjmg/WV4XIIk+g1JyzkTwvD2NVKFE7W+0hhPUx5v0k=;
        b=QZeo/Qq4vs8BwgqiauP6mywtntedX/WPCRrJb1Xlx0gXF8rUj9a4mE1XOPf/Y3Req7
         Zp8ahFFOO/qV7GjwgS8ZJn6XeQVenoYHo+9r8ZuPZjc8Nzv9RkFDzq3PnVzJGYy6Ex+u
         mrrpqVIXvOLkkud4cbW5RhfnG6YlmTOC0B/LY3HqrhWrhW/2bsfo9nDsmdlMaMWTxASV
         NElkCoTDDjURl8H4Rf5x86xJpt7noFBBURjQWHTWV+WW2wy+WEGtZuCjcUeX67IQasv5
         yGTAkQ4WSdeaGTHM8BC00On0An1OC4ml+w48GRXoYe539CFjPDPhXhwO1WRqss6gvzW3
         T1kQ==
X-Gm-Message-State: AOJu0Yx3s+dSk1g5g2GcynRSZ5n58Ie/q5en1XPkJ6pPrf4toaeWplyL
	ZGVdceOqyslIoPH8CQghHBtJv3RtMN64D2WF8y+WTNq9CD/mzJIhWUSX
X-Gm-Gg: AfdE7cnhdbeOtRkJrfJDXgRZUJ/+0FFcqalf4J9kCs+NZ4oGFz/ZGCZGuIRZMAVrl+J
	R6V77EblTclAckJ/W9A+JwWxUvhZkemqXPoZE4XaluesvpsJmwImhVGfinxfgEl31BD3+pk6UgT
	rBAKqL54/gRjR4ioCEbehpD/S7sdQYg0APeIR7H4Mygbv1rZtnz2esfOqJuZRACjvJzPsbH0ohl
	0c9IpRi+lx0HpEaiTvEY2Il3/rctx3RhDXMTfa4mtXD3aZg6hOnCHT4DnAgaWs1oVH+aRXmewoZ
	Mn98Yfr2x0/+UtYjU0jVJNCJh1FsCFeiGMJoa6pVVl8uuORh/eBIVvrJsvqdSThKPUqp7JCMci0
	UYca+MbxLr/rduHj3WcwmBmZawH5AQAB/DycNSth7pndeNCEoKMppUMwRS0WyHIAshKTZDkz/8H
	OOB+mH2kmfMDrZmQ==
X-Received: by 2002:a05:600c:3b24:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493b82bc0a8mr52781445e9.27.1782817018794;
        Tue, 30 Jun 2026 03:56:58 -0700 (PDT)
Received: from builder ([2001:9e8:f11a:416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0bbbcsm70701085e9.13.2026.06.30.03.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:56:58 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU support
Date: Tue, 30 Jun 2026 10:56:48 +0000
Message-ID: <20260630105651.756058-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303084-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1087A6E3694

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
v3 -> v4:
 - move owner setting from core to transport, mitigating possible
   use-after-free (Sashiko)
 - resend because net-next was still closed
v3: https://lore.kernel.org/all/20260628222705.4052815-1-jelonek.jonas@gmail.com/

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
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 1019 +++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c      |  163 +++
 drivers/net/pse-pd/realtek-pse-mcu-uart.c     |  156 +++
 drivers/net/pse-pd/realtek-pse-mcu.h          |   87 ++
 8 files changed, 1617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.51.0


