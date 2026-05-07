Return-Path: <netdev+bounces-285209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MnTAW9d/Gm7OwAAu9opvQ
	(envelope-from <netdev+bounces-285209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:37:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12F4E613C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD983304F433
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9F3C73D7;
	Thu,  7 May 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6WFcpxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6183C3C0F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146404; cv=none; b=IUs3W/Fl5ytLN0/sI8IlGkoyf82Q8ekMMhx3MS3YjWYbuuJP7AOvHGmPiAY7ztMdE41lae50StnAWrs8CAP2JLPN0eyl5a1TkQ+IQw/M5xNl1QpoAA7QtkKko4TsrNwBw0P3dvtXtzQ3oyAt2BSWttRKxOoBV8lSBjThTdrfZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146404; c=relaxed/simple;
	bh=Mkw4PfaPPFTJ/kedv7gHeQslnik6UCHBJiWIiwr5HZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrMCdvCDkPFvqrSXwO86NkbVnovRSO2YngwMb2r3DlK0rySdDKW2EkwRdGwe+8ZMu1y1FopWi8gWGyi7f4KDCdUbWpHiHvqx3lSPcsLGjgST8faGINon0TxCiDCQi4cVGNdlSgE6DnvWnYa093PvI4lV1JAg/s/wElNgmdKwNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6WFcpxq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39378db197aso5414171fa.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146400; x=1778751200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nuZVyHHS0MWbsqPaxc9Y1dPrv8TYvlBj5LJiO9S2F0=;
        b=L6WFcpxq1BtKN1cM21nJ3cldra9gswMl9jBJflmQle8jPqhLFnmC0XrKJBUT7+P2i2
         DqFyaVtSnO3kbrLQyZsJfpiDlpz+7LusnSDHt7H5LEKug3MuoOqqj8EUA+hUXF1f9Rbz
         cCjz2FbBs8NRVTA6LUTEdlFrIH7ELEu7oizaUfU/P+8R6TZ6jov9ojBP+HljNasD7xv4
         jJ5NF27e8JNBr2h5ZF8ZVtTcVktQ2EmnLhJY2hY6jwc31wCjjGU3d0tPqXohrYMOmY3G
         HIbBmpY6KJyUu/vUvaRD4UPuEG7SO9HhuSlTtG81gXO255ITIJb6M6/WQgUDXKzOZxZg
         5nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146400; x=1778751200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nuZVyHHS0MWbsqPaxc9Y1dPrv8TYvlBj5LJiO9S2F0=;
        b=Ru8XeNLRETJJ/LrIPOwJSSPX+0zffXnuZORjZwUnRz7lfX1Lk+BWhug0Sed/Gao05R
         9GhbiY1jbqVS+3xDMaXIazZj8jlcT6qaJneldHt1iv6247KOT+MYo5TperKNRmHBM42T
         Qi/vgPlRMjMR63NeS159UEletge8mxqGBfTNhX8S1lKXjcmYmuoHmaOuiY761HURlCee
         8NKReS79ClxUYJ7QeNcbQCvy/O7qLp9cicM8IoGm4Jvkh6Tu2CH31YIcu69hFhWVDlld
         //iNyntybzTL/oPHmE6rrbAI0r0Yu+ANXChjHvpED3amiWkmrwEAt5yU0FrQnzWOwOJu
         cafg==
X-Gm-Message-State: AOJu0YwOvDhECSTe2DNWLkHcp+9tyERCjjhvNmpF8hnNWFt/v/1ZNH/C
	FHdCgHR7TmqjEuxjs/XsMDcPqKSbEeeSYXLCHKpQfHsBoGJnjzd7m0ds
X-Gm-Gg: AeBDietJPqCzWU0R2E0HlbbQN3i+OYzicpN9P9OzWiv2oNRzQFtkWY7YKmr4BMekfXD
	LFnUcSPACB+3jg6PvM+rxR7ywbqAGQWasecpQ0n0QW+ZKY99Xt+sGs1hdZJs9s/oLgaOs/ojFIJ
	50LNcXM0V5CnkYMyLOaOwZLaOmbwcVNJ6sUO2taFBf7wSbzzr/TyDU5+MSbFrZC265IksIxpSH4
	618ajco9R/CtY4rqZe/lpsTJ6jgxYUAFO79pIToNlS5056cv3WyH4IKADAYLvzOXLpE/2MMfReo
	Xix3OdjVE2cJypnypHtPy3Xzt9tTk/oDkW+lcvDNIa7SiJZNCuQHP8MtKyxazu/Z2SJD+uTk0Lf
	RXNNufLXZtWnLeooi5Zj6216ziptFWszefzQSfDum9qoKeeqD8aDBff+l8yKNGkNMKCf/mn6Cdb
	XTHqU0BVBBhdTPwP0+uefQz6gc6xr9LHx5wKnL
X-Received: by 2002:a05:6512:61a2:b0:5a8:8eda:bed5 with SMTP id 2adb3069b0e04-5a88edac116mr1755466e87.32.1778146400140;
        Thu, 07 May 2026 02:33:20 -0700 (PDT)
Received: from builder ([2001:9e8:f13c:9216:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a864c6f16esm4752445e87.15.2026.05.07.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:33:19 -0700 (PDT)
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
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v7 0/2] net: sfp: extend SMBus support
Date: Thu,  7 May 2026 09:32:59 +0000
Message-ID: <20260507093301.1144740-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F12F4E613C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285209-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

---
Jonas Jelonek (2):
  net: sfp: apply I2C adapter quirks to limit block size
  net: sfp: extend SMBus support

 drivers/net/phy/sfp.c | 144 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 116 insertions(+), 28 deletions(-)


base-commit: dacf281771a9aed1a723b196120a0de8637910b9
-- 
2.51.0


