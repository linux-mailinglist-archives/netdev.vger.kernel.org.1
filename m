Return-Path: <netdev+bounces-304984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nUi8AIOQS2pqVgEAu9opvQ
	(envelope-from <netdev+bounces-304984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:24:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1270FCDC
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:24:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aZpY8c2O;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304984-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304984-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E80B3010662
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB213E4C95;
	Mon,  6 Jul 2026 11:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064C3FB06D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337085; cv=none; b=hFp+hnoWfifSZ81Ap/4UIOAPc4l+Bd1f21ll+POb+ptv4Pxs/TSP/hcKy66hFEU2oyR9KXGS0bHmTD4cBm2t6bgMLuU0imss4Vpf64hCqn8jOSg6nAezW7a8ezO0NOm4X43b1KgGKHFHzjvSgHu+XEE6Bb89xVcMTfnTdX6QZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337085; c=relaxed/simple;
	bh=jFQ86kR44ReCnfjjIKpq+fZylsL4M0UAgppa5MtcKH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lgQ74um++jROw4TOeeMsZn7gP4pSraxxCrpWI+5vOr90qBH5EJHDzG5g/cxS5GSNNFbVcdU1vhrU3Yr/dYF2mtkdbBV2L5dtedRUno3+cJdGJs6NTGkFh1DmcC4hD9WD/zKDoXE8vwlmllSEKCuV5A0KdDeceiSkFzk/5y9Off8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZpY8c2O; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so35275685e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337081; x=1783941881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+2oB3yCXV7I5EVrMTHbphK35kzAQ5vkTkfYUmlM+Fk=;
        b=aZpY8c2OPX5pA659B8w+SWiCZzjRSjn/hOB31zPjKNRv7QajtG3su/BtOraB6BL2ck
         3HEcjfNz3xKc+zGzu0fuZOu/tM0NeKtir8gGE/KAD2hGJ9aVa9Z1RmTydEJx9dvlTEYu
         xXe2dmwNwlBsyQqjsWFT9/udto1b0fXLQgpgtCF4OGyytE5hSXAv9/Ceb4RXsyaDz2ll
         tQ5pybYRMsCggUeEn+R7w6l+buoYvCDF3ncECZITaUjX2fxznDPg+p+v9xfDvswEqmaH
         jS16EfIuGa9S/xpD79dqhNC6qzrvNlLHL4QZ4JJpXkJzlSIPV21NiDlqOtyNScKcDaCO
         YhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337081; x=1783941881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+2oB3yCXV7I5EVrMTHbphK35kzAQ5vkTkfYUmlM+Fk=;
        b=NLuoAzuxjfpgQn+CTKbMGZw6O/FYHmGzRCtyDihwb32TCgkzjbIjtpeLrtb+/ZQexO
         QoaCwJp2N7g5ayuwMyCzjYJ0/vxNFP2n3GpOWdRQAOVwrX5FZLWib+78TG5DPcnjXIiz
         MFS0N71xDM3+CZlRGObOiKIJzkHb/qj69f+eZOoUKIsRqpStRdWvFg8L7XhrkKkp57ay
         rNLnm8CCzYJdEFCL1F7ugCxTdYcQ5x/Ssf74F6Y3aH3ShW1r22lWh4/79K88lbXJx0Wd
         weaASuSO9hNb8OR83kvtDt9nvRBbZbiJv1C5bRGVdxueWMkwHW0OyUa4vJq3UNqy3FcC
         t5Yw==
X-Gm-Message-State: AOJu0YxGAPqqzWJDjeP5kC+tJHul9CtV8v55sNPq9isXzAT+PuYTfV5d
	qiE/0D7vrmCpERqpfwThnHS0ry0M1cegqwFtuVwvMTC3ZhSTb3k7P9Zk
X-Gm-Gg: AfdE7cmaZsn7uQWfETqMacb46Y9zxM4YViAWUWbMYT3z/5XEzSMu4ZkTU9874rJzhlw
	2V9BHNS8H3x8f/AjhUcZwbQUT0ff6T/+Ikv4rdDaaTAGv/exg2XkHX+YSSW6bsqb5twis3TxU36
	hNXWg7NKBoUPZQhZOYuhEU39VGjiDFCbXlLCGIe7jkqdOQhlYssXumPmd75Zn3cY7s6yNmhBLEc
	q/BoE6CRtf8qrSus/jU2VjtRXWWOWe935DWaxAU+qAY+TbeDlGEgftUyK9anVwRs2V6wBrlzB1r
	UT3B+06kVFyXLTAbYaVS2eT2pO7XOKQvfK+regoBfBmBBN0H/GGsnFc1zl/k2+KlXLxk538AAjR
	JZRo+XLm779it59Z2ibQoo4Hh/R+s8OIF0unRx6YM1poEv47HCULmR1vRi5CvvDktR5RmsGnMic
	G/zT2pfdknKUt/mDk=
X-Received: by 2002:a7b:ce08:0:b0:493:bee0:4360 with SMTP id 5b1f17b1804b1-493decf58d8mr1811445e9.17.1783337081173;
        Mon, 06 Jul 2026 04:24:41 -0700 (PDT)
Received: from builder ([2001:9e8:f13c:d516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab27dsm258903245e9.4.2026.07.06.04.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:24:40 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/4] net: pse-pd: add Realtek/Broadcom PSE MCU support
Date: Mon,  6 Jul 2026 11:24:20 +0000
Message-ID: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304984-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95A1270FCDC

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

 - Linksys LGS328MPCv2     (RTL8238B, I2C)
 - Unifi USW Pro XG 8 PoE  (RTL8239, SMBus)
 - Zyxel GS1900-10HP A1    (BCM59121, UART)
 - Zyxel GS1900-10HP B1    (RTL8238B, UART)
 - Zyxel GS1920-24HPv2     (BCM59121, SMBus)
 - Zyxel XMG1915-10EP      (RTL8239C, UART)
 - Zyxel XS1930-12HP       (RTL8239, SMBus)

---
v4 -> v5:
 - split the single driver patch into three — core / I2C transport / UART
   transport. Binding stays patch 1, unchanged in shape. (Paolo)
   Please give guidance on how to if I should split more.
 - core: set_pw_limit: guard divide-by-zero on pw_set_lsb_mW; cap the
   programmed value with U8_MAX instead of a bare 0xff; prg_val is now u8.
   (Oleksij, Sashiko)
 - core: discover: also retry transient boot-time frames (-EBADMSG / -EBADE)
   within the bounded window, not just silence/NAK/not-ready (Sashiko).
 - core: pw_status: report Broadcom 0x3 → TEST and 0x5 → OTHERFAULT
   (new STS_TEST/STS_OTHER_FAULT); pw_class comment corrected (0x3/0x5
   aren't "other fault" on RTL; class-0-vs-fault note). (Sashiko)
 - core: dropped unused decoded fields — function_mode, cls_type,
   disconnect_type, pair_type, inrush_mode, limit_type, chip_addr,
   channel. (Oleksij)
 - core: removed forward declarations by moving the response structs above
   the dialect struct. (Oleksij)
 - core: get_pw_limit_ranges: reverse-Christmas-tree local ordering.
   (Oleksij)
 - core: dialect comment clarified (only divergent responses are hooked);
   commit message "parser hooks" tightened to "…for the responses that
   differ." (Sashiko)
 - core: made parse_system_info hook void, both implementations return
   hardcoded 0. (Paolo)
 - core: dropped GFP_KERNEL from kzalloc_obj. (Paolo)
 - core: dropped unneeded u32 cast
 - kept probe dev_info() for now deliberately, due to different opinions
   on whether a probe might print or not
 - NOT included Acked-by from Oleksij, due to several changes
v4: https://lore.kernel.org/netdev/20260630105651.756058-1-jelonek.jonas@gmail.com/

v3 -> v4:
 - move owner setting from core to transport, mitigating possible
   use-after-free (Sashiko)
 - resend because net-next was still closed
v3: https://lore.kernel.org/netdev/20260628222705.4052815-1-jelonek.jonas@gmail.com/

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
Jonas Jelonek (4):
  dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
  net: pse-pd: add Realtek/Broadcom PSE MCU core
  net: pse-pd: realtek-pse-mcu: add I2C transport
  net: pse-pd: realtek-pse-mcu: add UART transport

 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  |  154 +++
 MAINTAINERS                                   |    7 +
 drivers/net/pse-pd/Kconfig                    |   28 +
 drivers/net/pse-pd/Makefile                   |    3 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 1006 +++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c      |  163 +++
 drivers/net/pse-pd/realtek-pse-mcu-uart.c     |  156 +++
 drivers/net/pse-pd/realtek-pse-mcu.h          |   87 ++
 8 files changed, 1604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h


base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
-- 
2.51.0


