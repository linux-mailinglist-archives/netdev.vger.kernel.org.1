Return-Path: <netdev+bounces-292841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG8pB7qsGGphmAgAu9opvQ
	(envelope-from <netdev+bounces-292841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD95FA032
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B94B30702AA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5D347BDC;
	Thu, 28 May 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkceFvDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325633372A
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001571; cv=none; b=eFvxIzYAZ3aOVpkq11Iyvu5MnPUMvGQnA8wcI/Dy7jJr2YgozNioItZCksaIMw9/ux8zP214yB07bXckJT4q1uDkJDLzYzAsrJCyQPpnphrYYz/Jp/m3nqXOWGY9qrD056XQ+jBSyzCSjIt10yaQMhWB7NHd752jWG7dEbc2gFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001571; c=relaxed/simple;
	bh=MN050FA6rBZty3fIFpcPuhl1RefRyasdQ+o1ingafn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELpwcohjkIuAtKelPn6DJ+u36iKKQcipXXMGEhPJEzXPjUhx2dEOk6ffjxGWB5Fh7W7k0DGx395AlJN1guTwIGigZeFnLW9/DBYFW0AwM3nHwIyVqMyc4oJLMrfMYRIX/CcQGXxfwGGB0NwHxTX5kvnmUfl5U+scKdkj+8Z6O8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkceFvDC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eeba68948so679537f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001568; x=1780606368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaOgFQE7kGLl/EGIsd7q8U6KYXTU5ZHRX/Jwj0LoeEc=;
        b=WkceFvDCUcdiQu4dt/Lz0JQ3KjqoZ7sCc0FeBWlHXVIGKpK50FdkPyxTPDJE5OgFI0
         bO7IsK4GhRDEjv+SSMWF/+hJ1ZZ5qxI0jgkIZ5i+uXl8H1jgYQDgTPNaDIjBBh1b+ED1
         Zn4tA9Zqx3+p7qUlq6/ExJrN56iIguKpXx76MREYN/VcrEP3zB4rR0SnVktCbRnDdmnB
         5DhDqkAmsZFGWtXniO0myKxWmvmQTXYUOcPhKJYizzw5V47a5zhvZrAGOsyYisgNweRL
         AAawRQKTaGpcBtNNxN2K5j3d4wNMZjFvvqcArYigqjk5QA6e/mkazXXAuuy32gp6vkBl
         BmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001568; x=1780606368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaOgFQE7kGLl/EGIsd7q8U6KYXTU5ZHRX/Jwj0LoeEc=;
        b=bMUqmDqbb6whQuTZwW6VbhFeeMpnV1Wexjx6I6KDMFEzf1fBCMrEEzH5KH7mMDyE/U
         D3JGqKFGnwPBN2n4gAz3GLzEIvyRdQokZDQJGRmw/V0JW52GktRPUMyRaYUwC4HzJFmg
         FhbGwvkCk66wGJ3S4xiSMI1xsyiJgYVZAP4DC+FDBDEdPVG0HZUjvkfuegae/2D4rqh7
         7tM6rw0wiW/TRhW+965KicV90hnYw5a62T1YKp34ImQ7vRlQ1QQF4mzdI6uENm2mP8o1
         1X9T1cMnwyD/yKgKXQF2lnIUdQCqkz9B1jU3i3Qvfn47LWcHCMaLz5mkJSHSUpueWBF1
         LzWg==
X-Gm-Message-State: AOJu0YxvmXWh4DLWjmKGn5Q3LD6PkN8tsKvZdrqaa14fpLMxpQC3bbzN
	1QYDrwVhWnmdIL0g3p2WnrRT1xKSFYHT1064l7e129EGLhhiO1YnueF9
X-Gm-Gg: Acq92OHMGttBp/5sckJsG+xtSsn8LUvxUV+X7lsuiCzWKiKbMyz0dpycSPhbjv9n4H7
	G0Vg0gTskOBl3O/WFY6dfNq1CRBelyl+z5JKPHmLx2R9dfRsOp+B5wUkpfksNguynyyyF6x4f78
	uK2BAM9q8KU7o7FFQHzbW0Wma9lKB8/JSs4OZEj08tHA6WcDgQewFh1mzZpVpI9KfrwKreU7bvZ
	gjG3HLvzOkS9QNUG9zLMV5R6BnaNA3H6KZPOd5Wbi7CfJdtKUqdzMkE9zIM6wD1BZoCOxX2k5Jl
	c1zNO3Kj9Y49/vzKvWRdCKo1CADuQlGrUN4YYYScJ3iaXEWWWk/QISh7zI7e4OIGzuW/A1PYe61
	d5UuhjsJoB1SaQTbkADRxACsH73BW99z8InG0X9PfCW5getlSkg5PhZcG2KbQH/gs1YAwk4kOvu
	M9AwsnZ/fbzo6AzSQaEhYUDtC35HgJA/PKvB21
X-Received: by 2002:a05:6000:248a:b0:45e:a0ab:8bcb with SMTP id ffacd0b85a97d-45ef02b5cffmr1319360f8f.15.1780001567973;
        Thu, 28 May 2026 13:52:47 -0700 (PDT)
Received: from builder ([2001:9e8:f104:6516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee5a84e92sm7104028f8f.35.2026.05.28.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:52:47 -0700 (PDT)
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
Subject: [PATCH net-next v9 0/3] net: sfp: extend SMBus support
Date: Thu, 28 May 2026 20:52:39 +0000
Message-ID: <20260528205242.971410-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5BD95FA032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

New in v9 is a precursor fix (patch 1, tagged for stable): before
sfp_sm_mod_probe() runs, an ethtool -m call can reach sfp_module_eeprom()
with i2c_block_size still 0, which on a pure-I2C adapter becomes a
zero-length read in a loop that never advances while holding rtnl_lock.
It restores the sfp_alloc() initialization from commit 813c2dd78618
(lost in 7662abf4db94 when i2c_block_size was split off) by initializing
the field in sfp_i2c_configure().

---
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
---
Jonas Jelonek (3):
  net: sfp: initialize i2c_block_size at adapter configure time
  net: sfp: apply I2C adapter quirks to limit block size
  net: sfp: extend SMBus support

 drivers/net/phy/sfp.c | 147 +++++++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 29 deletions(-)


base-commit: 0cf905cb9a12dbfb5d14896729b74508f83f73df
-- 
2.51.0


