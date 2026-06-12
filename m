Return-Path: <netdev+bounces-298695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AU+rK6oXLGr/LAQAu9opvQ
	(envelope-from <netdev+bounces-298695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129367A2CB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rzL15J+R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298695-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC6063003602
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADAC388898;
	Fri, 12 Jun 2026 14:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB85346E72
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:28:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274535; cv=none; b=n2t4+A1chLDDzjzvdW+vBFeFeP0/eHsJmYC4YFuhcUTaCKnJvhqavsGnbA79Uhc5f/QuQecaZMTq32bMpyl6aeX1QLse5e7BwXSP7sj4+uYbgsFJtiwmYBM3RJU7bDWajWFS+C3sACAbhYuw3dPNqpskOibN8srUpOgxDfNsgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274535; c=relaxed/simple;
	bh=RetPaBuiPfHSJjxUESzQ6m5S4LpjMLDE12nPHTFcKbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnvZHqZyFQWNz0Uhf++Hlz7q2GHyeuTF4PRsq2ToqsAJP1OwJwUUVSCPAD+MZHiDbFS5aT+Ha1PZApyHbfc2STVdqtIzw3QD7kLDbpQqUtEe5zTxCdwt8W9ZWAxGu2Ja9YCgwDAQxZaoGgX/aaBpSzWsK/HcOBYEzuIEqJCRg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzL15J+R; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b12270b3so6439405e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274532; x=1781879332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TbR5zMWgfDb+swg6Kmhekk6Nj3Rt55k3DUiPrn9m+/Q=;
        b=rzL15J+RyMs5645f7UWAykBX/v7wgyF/p0erGaFRwdSsfnKU04wZAlbwiEIu/URx5O
         9g6w1bIjbc7zwS2NStajYmoHIdn6t40F1KAxm0mIqOKVi/GV3chH5BV7h4j+tCkRbtKk
         d+anpQYAqJiprGc2JHDsVlby2+JUM/FtBd1YUmRS+9G1oByqavlqRklfWE9k4g4FMLLb
         brvaOFTSf8ABY2KzHNRYiEVqieNT2Zv+AeSG6QFjKD7UFoRO0BhI9P18thgjwAqjmAW5
         /IF/ALY+RmCcUUpWm54JZixTS0J5ktkAHDI6BzKyRt1MA/crCH8wv5SMzqumvgA+/dia
         uEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274532; x=1781879332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbR5zMWgfDb+swg6Kmhekk6Nj3Rt55k3DUiPrn9m+/Q=;
        b=P79sWBiSn7yUTJScSkwRnoI2g5RIG20WNje0dWSiTjsBmcLTRFmxftReKbQvuMMmIc
         4mv1TSPyVN/97CTI1EKCKAAG11vFjct05jYezI77or/mtJ0tBljdrOp9srfahsJfpvgr
         TQJbr2R5ctX0og1rokQpQs7MM57TvEpOiz+wvf0doY5sFGLqy6hkHlXWdyzl9mKhhLbC
         XL5LEyi5IxoMl9bjB4po5RHjGQj2Wy+YYjZoEXJwrHmtuYuaKt76gdgDMRm5LF9BpqkL
         kFd+DngzAZ3Vd6ib1RTLSbR25YMPg5Ifw7ayT9tmO6iL7ncs4mSdurrYISsqi7fyAUCB
         c4wQ==
X-Gm-Message-State: AOJu0YzvnaL+HmmRi8SM0KTcdh3O/UZX1xjeOA0ROSAHikafH+17Y/mM
	BLZ3LeER3MofZtPLz59bPANPWClHWwK0lpEXp2O3/WhvfLWJOWVuFMAr
X-Gm-Gg: Acq92OFq10XKfTUuebZBmTXBxnal7RYYKvdW/vcQShAsJoLM+xxaLN3rh6IaBgotes3
	opNWiQUcHV/Ewa7O0KRB4E2VxjWsyuuFldtUeJPaD8/sNHgavsbSr7o4xTvCAj54gsPv+8lAmwo
	TM7H0RxMq3rNpF/6nlB+DgOXkj/hL8l/mKiME0uBeT5k7uN7okjQNWq00cElB0CRAaPZy2lG+FZ
	QOpC669I0p/fo6xE1e8emBngst57iAh6UTnR5ANu6mQHRS+t2rd3iA/oNSzM777PEktD/Vlx94G
	pGWHlElGQytgyW/39AiL2fBNBbMPA7kLl4xsGaywcUQWf9dpG24gAowgHrdkzke9HYueGgnV5A9
	u9W+9saxWBBJCqH0RLxMn79cmIw/WAvxY/f7bX/zNzFF3rLfgLCGohM83zlT/+cg0HoiaccTQFs
	VS25qRY2tyEqHRThavwzEQq7qntg==
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr45357405e9.9.1781274532120;
        Fri, 12 Jun 2026 07:28:52 -0700 (PDT)
Received: from builder ([2001:9e8:f11c:fd16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c0d360sm175410705e9.0.2026.06.12.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:28:51 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v10 0/2] net: sfp: extend SMBus support
Date: Fri, 12 Jun 2026 14:28:38 +0000
Message-ID: <20260612142840.462664-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298695-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonek.jonas@gmail.com,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5129367A2CB

Today, the SFP driver only drives I2C adapters that advertise full
I2C_FUNC_I2C, or SMBus-only adapters via single-byte transfers (with
hwmon disabled). Several SoCs ship I2C/SMBus-only controllers that
support more than just byte access -- e.g. word and I2C block -- and
have SFP cages wired to them. Today, those adapters either work
poorly or not at all.

This series teaches the SFP driver to use the larger SMBus access
modes when the adapter advertises them, and along the way starts
honoring i2c_adapter quirks on read/write length so adapters that
cap below the SFP block size are handled correctly. Patch 1 is a
small prep doing only the quirks handling; patch 2 extends the
SMBus path itself.

Capability matrix supported by patch 2:
  - BYTE only:                   single-byte access (unchanged).
  - BYTE + WORD:                 word for >=2-byte chunks, byte tail.
  - I2C_BLOCK present:           block as the universal transport.
  - WORD only (no BYTE/BLOCK):   accepted with WARN_ONCE; works for
                                 even-length transfers, odd-length
                                 transfers will error at xfer time.

Adapters with asymmetric R/W capabilities (e.g. only READ_I2C_BLOCK
without WRITE_I2C_BLOCK) remain functionally correct but use the
worse-supported direction's max for both directions, since
i2c_max_block_size is a single field. No mainline I2C driver was
seen advertising such asymmetry; per-direction sizes can be added
later if needed.

---
v9 -> v10:
  - dropped accepted and merged precursor patch
  - resend as requested by Jakub
  - added Reviewed-By from Maxime to first patch
  - acknowledged potential issue flagged by Sashika, impact is
    theoretical, see [6]
v9: https://lore.kernel.org/netdev/20260528205242.971410-1-jelonek.jonas@gmail.com/

v8 -> v9:
  - added precursor patch to mitigate issue flagged by Jakub's AI [3]
  - issue flagged in [4] acknowledged in [5] but not fixed, due to no
    practical impact
  - added Reviewed-By from Maxime to patch 3 (was patch 2 before)
v8: https://lore.kernel.org/netdev/20260516135442.2234729-1-jelonek.jonas@gmail.com/

v7 -> v8:
  - avoid leaking uninitialized memory on short reads by
    zero-initializing i2c_smbus_data variable (Simon)
  - theoretical issue without practical impact raised at [1]
    not addressed but acknowledged at [2]
v7: https://lore.kernel.org/netdev/20260507093301.1144740-1-jelonek.jonas@gmail.com/

v6 -> v7:
  - use i2c_block_size instead of i2c_max_block_size (Maxime)
  - move WARN_ONCE into 'else if ()' (Maxime)
  - reword comments
  - included Maxime's Reviewed-by for patch 1
v6: https://lore.kernel.org/netdev/20260505200647.1125311-1-jelonek.jonas@gmail.com/

v5 -> v6:
  - Split adapter-quirks handling into a separate prep patch (1/2).
  - Use I2C_SMBUS_I2C_BLOCK_DATA in the block-write branch (was
    I2C_SMBUS_WORD_DATA), so block writes actually transfer this_len
    bytes (also flagged by Jakub's AI bot review).
  - In sfp_smbus_read/write, check i2c_smbus_xfer() return before
    copying smbus_data into the caller's buffer.
  - Use I2C_BLOCK as the universal transport when available (carries
    any length 1..32); drop the this_len > 2 guard on the block
    branches.
  - Broaden the SMBus gate to also accept BLOCK-only adapters
    (Russell).
  - Accept word-only adapters with WARN_ONCE rather than rejecting
    them (Andrew).
  - Add a short comment in sfp_i2c_configure() explaining the access
    hierarchy (Maxime).
  - Use the all-bits-set form via i2c_check_functionality() for the
    composite I2C_FUNC_SMBUS_* checks (Russell).
v5: https://lore.kernel.org/netdev/20260116113105.244592-1-jelonek.jonas@gmail.com/

v4 -> v5:
  - made a more general approach, also covering word access
v4: https://lore.kernel.org/netdev/20260109101321.2804-1-jelonek.jonas@gmail.com/

v3 -> v4:
  - fix formal issues
v3: https://lore.kernel.org/netdev/20260105161242.578487-1-jelonek.jonas@gmail.com/

v2 -> v3:
  - fix previous attempt of v2 to fix return value
v2: https://lore.kernel.org/netdev/20260105154653.575397-1-jelonek.jonas@gmail.com/

v1 -> v2:
  - return number of written bytes instead of zero
v1: https://lore.kernel.org/netdev/20251228213331.472887-1-jelonek.jonas@gmail.com/

[1] https://lore.kernel.org/netdev/20260510164726.1401317-1-horms@kernel.org/
[2] https://lore.kernel.org/netdev/5129a58d-8852-4395-85e1-8991934810b8@gmail.com/
[3] https://lore.kernel.org/netdev/20260520234208.565366-1-kuba@kernel.org/
[4] https://lore.kernel.org/netdev/20260520234204.565333-1-kuba@kernel.org/
[5] https://lore.kernel.org/netdev/4a1b13f4-9c68-4f4c-a676-fd61e2aeeab0@gmail.com/
[6] https://lore.kernel.org/netdev/ec27912c-a66e-4a81-8c8c-318d27ec62b5@gmail.com/

---
Jonas Jelonek (2):
  net: sfp: apply I2C adapter quirks to limit block size
  net: sfp: extend SMBus support

 drivers/net/phy/sfp.c | 146 +++++++++++++++++++++++++++++++++---------
 1 file changed, 117 insertions(+), 29 deletions(-)


base-commit: f6033078a9e671e3c8b83d387b91591a6f6a54e7
-- 
2.51.0


