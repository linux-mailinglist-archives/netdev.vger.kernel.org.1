Return-Path: <netdev+bounces-306970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DWrbOKHpU2qkgAMAu9opvQ
	(envelope-from <netdev+bounces-306970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD0745BA9
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:23:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BcoG73FW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306970-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306970-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF97300A133
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED993B3C11;
	Sun, 12 Jul 2026 19:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F035E926
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:23:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884191; cv=none; b=QhWXrV5U7WfUjA/QED4Hl9O29MxLu9GQq+ENq/hgYiCs4V2Fm8tufZzYmTb4kg15sYNqiDJpogbHv20j3fTXAgPDIyQrbEF0F9nhnxkJUKKEQS/5Wk3ENP3/s02sZL3xLZ13pGDJ4JUP8DG9+9FTJ0IaMQfdQRXs9bPjLvxNPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884191; c=relaxed/simple;
	bh=f44w1Qb66VXvZ7aENOxpRg5+03jFXGl5u1+SwIgIDb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+z53eAVJtVpbeB5itc237xiJdkZomPp3ZgG1V+SVeIw9asPX2rVRGHB6qo3vXSDe+PGagEEv/c3YJRXXW9F7sknxbrtOQUmKYZSGpKcbYFyHKvoUBuiGBuj/Zs17+chDAATdMacYjMATWyiXEN7CjMLQHwC5MbPpePWojcWvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcoG73FW; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-472326ca506so1912213f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783884188; x=1784488988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vxdq/uhXL6csJR9SPTwCd0QBGvP6WfjC0Zo32lhxE/0=;
        b=BcoG73FWSwKLUqYGbvSwSd/ejJSvpTFnAsg3VEBTTlbW/9WWzneWb9FSQLr+MF8lyH
         8SVB7HAb/99uIyvsq8/u7c8UPcKafnVqOLiRvKDhdFk7XEU6lZSvZLcDUofYBdaCFxOc
         cRKmHqDwp1gXo36vqd2HnFw9C5cpTYiM5XPdwFzNvzjwoGhLkcrar0O0kYpCRW3bfHrf
         nEYVQ4j61YEY6i1tNNRAmVDh/ViGqf+DIDIeDm+gB9YhIiAbEE4lT1VMxdunIhb4grm2
         SGQmwvCX8QC0tI2qH13BZCaN3iyzS8WjMhXPpXu3jjPdlm7t/oPXOAMs+11ATbirNEgp
         BBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783884188; x=1784488988;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vxdq/uhXL6csJR9SPTwCd0QBGvP6WfjC0Zo32lhxE/0=;
        b=rhduwqozBmThNirIMx3gJVGKW1dAx6TBRd/XL0wFRFPT4tGnuhf/8hKrwQgMkKNq7o
         4Uehh1jSWieVd2fc6VP7EONm+eJPEg39My15XrSJDTYeVTGEFaNIGtmxHWuprcNH68hL
         3jvb4fnbjBfplF2Z5/E10Fd97hPlO864ceCPZFP2JXrehB6jBVWbQ2G18117nTylKY9K
         LQhObjaUM4E102A0s5YBrFRxVhGvzlWCB9ktkPlnwcDdjtho0PYpi6zF9QpGR0YmTsAp
         FBGTFqvkuF+giY7aV5SFUbFbkKzZKme4hYnwtNHLW7pEDov5YyKQwpnQc6q9br9WJZGj
         Y2fg==
X-Gm-Message-State: AOJu0YxgTiFwO7yX5rRe/gwnVHRmpSgCv/HFy0bfAv2eaRtGNwQqSerz
	hcoMYlwYqEcZ1XOqekXMIYed5ltWP4FmLobQEKq8Ld+dkcBsAQsVVUsvEOJvJg==
X-Gm-Gg: AfdE7clZuXy9zZUyD+TwAb9TYrh/QrQ0pZLsBv0U0z15AXdR6cFGpEjo338fjkoHrYe
	DQxZu4LYZuHLuSb3cKoCi+l2yvz+L62tJU2jjcHLStcsD47S2rJ3C3BqBzpZUpjKyuMWKlKSofI
	I6SoisuI8bWyVKlfKJSLG4G1X7IsP737fTmnY4rYQyvXu/lrjCkvQASgdw7TmmHFGE4EySy1Q75
	nB0qkDmQ/lPSVPKg06Fdnj9v12RpFMZc+9AG40bpSH7G/9aob1mhIrKCT1cqhT+HERj0aQ3+h0A
	jGbLXQ0KHy3lqz0Zs4Y5WzLnyIQ9Cg8+aRlK+6xvcOsLT3veADjKWaGlJTW7Kc+jMqlKlg5rIYh
	5MsIV4yMeggaczcw54mNFA6L8YO1Su3EfrhcC/dGLqTsMCzfBfoyZ6hfUoT/wdQ9trbQZBwp35R
	rafYnh7uTbSAO6BIc=
X-Received: by 2002:a05:6000:22c9:b0:46b:cab9:f697 with SMTP id ffacd0b85a97d-47f2dcc9239mr6838982f8f.24.1783884187613;
        Sun, 12 Jul 2026 12:23:07 -0700 (PDT)
Received: from builder ([2001:9e8:f120:f516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm34883190f8f.16.2026.07.12.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 12:23:07 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/4] net: pse-pd: add Realtek PSE MCU support
Date: Sun, 12 Jul 2026 19:22:46 +0000
Message-ID: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-306970-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BCD0745BA9

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

Two generations of the protocol exist, both Realtek's: an older one on
boards with Broadcom PSE silicon (BCM59111, BCM59121) and a newer one
used with Realtek's own PSE silicon (RTL8238B, RTL8239, RTL8239C). They
diverge in opcode numbering and a few response layouts; the driver
abstracts that behind a per-dialect opcode table and parser hooks,
selected by the compatible. The specific PSE chip behind the MCU is
detected at runtime and only influences per-chip constants (power scaling
and the per-port cap).

The compatibles
===============

The protocol compatibles name two generations of the Realtek protocol,
with the I2C framing folded in:

  realtek,pse-mcu-gen1        gen1, UART
  realtek,pse-mcu-gen1-smbus  gen1, I2C/SMBus
  realtek,pse-mcu-gen2        gen2, UART
  realtek,pse-mcu-gen2-smbus  gen2, I2C/SMBus
  realtek,pse-mcu-gen2-i2c    gen2, raw I2C

and each board carries a device-specific compatible that falls back to one
of these, e.g.

  compatible = "zyxel,xs1930-12hp-pse", "realtek,pse-mcu-gen2-smbus";

The naming is the part most likely to raise questions, so the reasoning up
front (the binding documents it too):

  - The node describes the MCU together with its Realtek firmware, not a
    PSE chip and not the microcontroller silicon. The PSE chips sit behind
    the MCU, never appear on the bus, and are reported by the MCU and
    detected at runtime; the microcontroller itself is a general-purpose
    part (GigaDevice, Nuvoton, ...) that varies across boards. What is
    fixed and Realtek's is the firmware and its host protocol - hence the
    'realtek' prefix.

  - gen1 and gen2 are two generations of that protocol, both Realtek's:
    gen1 on older boards fronting Broadcom PSE silicon, gen2 the altered
    protocol used once Realtek shipped their own PSE silicon. The
    generation is fixed per board and is all the driver needs at DT-parse
    time, so the compatible encodes it.

  - On I2C the MCU firmware expects one of two framings - SMBus or raw
    I2C - which is a genuine programming-model difference, so it is part
    of the compatible ('-smbus' / '-i2c'). A UART attachment carries no
    framing suffix; the transport is given structurally by the parent
    'serial' node.

  - Each board additionally carries a device-specific compatible that
    falls back to the protocol one. The driver only ever binds on the
    protocol compatible; the device-specific string keeps the binding
    specific and reserves a place for a future per-board quirk without
    having to retrofit device trees already deployed in the field.

Testing
=======

 - Linksys LGS328MPCv2     (RTL8238B, I2C)
 - Zyxel GS1900-10HP A1    (BCM59121, UART)
 - Zyxel GS1900-10HP B1    (RTL8238B, UART)
 - Zyxel GS1920-24HPv2     (BCM59121, SMBus)
 - Zyxel XMG1915-10EP      (RTL8239C, UART)
 - Zyxel XS1930-12HP       (RTL8239, SMBus)

---
v6 -> v7:
 - dt-bindings: rename file to 'realtek,pse-mcu-gen1.yml', using
   specific compatible as file name (Conor)
 - dt-bindings: added Conor's Reviewed-by
 - core: replaced some leftover 'BCM/RTK' dialect framing in comments
 - core: use rolling sequence number instead of always hardcoded 0xff,
   adressing the issue that stale data might be accepted for new
   requests (Sashiko)
 - core: reordered MODULE_ calls to keep consistent across all driver
   parts
 - i2c: replaced some leftover 'BCM/RTK' dialect framing in comments
 - slight commit message adjustments
v6: https://lore.kernel.org/netdev/20260709194125.2784507-1-jelonek.jonas@gmail.com/

v5 -> v6:
 - dt-bindings: reworked the compatibles per DT-maintainer feedback
    - name the two protocol generations -gen1 / -gen2 (both Realtek's)
      instead of the -rtk / -brcm dialect suffix (Conor)
    - encode the I2C framing in the compatible (-smbus / raw -i2c) and
      drop the realtek,i2c-protocol property (Rob)
    - add device-specific (switch) compatibles that fall back to the
      protocol compatibles, with the board↔protocol pairing enforced in
      the schema (Conor)
    - rewrite the description accordingly
 - driver: track the binding rework
    - match on realtek,pse-mcu-gen{1,2}[-smbus|-i2c]; the I2C transport
      selects SMBus-vs-raw framing from a native_i2c match-data flag
      instead of reading the property (drops rtpse_mcu_needs_i2c_proto)
    - rename the internal dialect and parser symbols rtk/brcm → gen1/gen2
      (chip identifiers like RTL8238B/BCM59121 kept)
 - i2c: DMA-safe raw-I2C path — bounce each frame through a heap buffer,
   since i2c_master_send()/i2c_master_recv() may DMA and the core's
   frame buffers are on the stack (SMBus and UART paths unaffected)
   (sashiko-nipa)
 - includes: drop unused linux/mod_devicetable.h (core) (Uwe)
 - includes: drop unused linux/delay.h (uart); add
   linux/regulator/consumer.h (core) and linux/slab.h + linux/string.h
   (i2c)
 - commit messages — update the binding, core, and I2C messages to
   match (generations, framing-in-compatible, DMA note)
v5: https://lore.kernel.org/netdev/20260706112425.3149226-1-jelonek.jonas@gmail.com/

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
  dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
  net: pse-pd: add Realtek PSE MCU core
  net: pse-pd: realtek-pse-mcu: add I2C transport
  net: pse-pd: realtek-pse-mcu: add UART transport

 .../net/pse-pd/realtek,pse-mcu-gen1.yaml      | 176 ++++
 MAINTAINERS                                   |   7 +
 drivers/net/pse-pd/Kconfig                    |  28 +
 drivers/net/pse-pd/Makefile                   |   3 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 995 ++++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c      | 170 +++
 drivers/net/pse-pd/realtek-pse-mcu-uart.c     | 155 +++
 drivers/net/pse-pd/realtek-pse-mcu.h          |  91 ++
 8 files changed, 1625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.53.0


