Return-Path: <netdev+bounces-288633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eUP0OC13CGpOqwMAu9opvQ
	(envelope-from <netdev+bounces-288633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5D55BF75
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E01B33008A55
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274E3E2752;
	Sat, 16 May 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvmT7tZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4B2580CF
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778939690; cv=none; b=ScNKG5WEEfVwOUpawxPyE8CpJqWALTVE4BRO8jmWXTriViqQ2XNDH0JiMqmtzlQ3P0xxCPx2/FkGzukFfZy0XhEZGI2gLb8pPtfX8sTSm3wlyIfYGmHMyOZmRTpebqBFHrQ1MISnwHxvU2iXgPLE0bOOeOgPPrrgz4btUj967aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778939690; c=relaxed/simple;
	bh=oAd8+u9veKXMSzawomfdaIEz00uqz+8Kr29J7YGDexM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCeFrGasEwJr8NZIA2QOWHI8vCnn78jND0GPTxOq+57aK/9Uo4Vn0ZxfgWX6y0wegIKRcNu7YJCxUcrfMJf+NhFY21mGzR+GnIvRNpGDhUekoOdRNgJM/okwD6N5n30x7r2Z+xBMRZq23ZJ89XjUDnYFYytl9mTenwmpc5CegDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvmT7tZW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso3793455e9.1
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778939687; x=1779544487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9IW/+7uckKhQmoH+ll6/6XySLsCP/Qj0il6Jj7grGd0=;
        b=YvmT7tZWsAm4kXzMyKF5SLdTMIq55kT5GsGj2N7Uk/8H0qRL0gXSqkKae6g4rTuEQb
         hQjmsow+Qbe+XJJVVK1EdBu4cKlszmscp/ML+oQlRLrT1bkNwe4A9x4iUUCMQB0u8rJy
         GMZ1xMMFIprpn4PKTq8idjl45qmEG9ZVCwID4N9UAfOE9/5mfxNI524fO8wQkES/53Hp
         Jbk9LUnD2q5xRVQhNMZMtcK7WAidl1uZfceZiM+sK7BR8pOKJ1GQfAAhpbxGxFj0SXzO
         A0VFYOWGiOECZ+w4xifK19xEmO9d5Kwuat0H06R+4BEubnrQ6sHyY/RT2VIM/+8TM3So
         wh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778939687; x=1779544487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IW/+7uckKhQmoH+ll6/6XySLsCP/Qj0il6Jj7grGd0=;
        b=RKQ0/9Su4FtLmeWZTqtUYMXKaOGx2tj7Rto10vKESnS6s82Qq+T2OJG2r2aJihg6tz
         KtBfAbM2w02xDVlcnmPD57LdNoCcpUcQkQ3lLVTZN1Oh6e7rU18Ht1AATaHrXiErWacd
         id7hH6ayTEpDqT72NP/1fSD4YjUc+UPFaQtOCkSfetyMM5ND0UUkjMagZG8H9+DuVJSs
         RdVdcQRemCr7bhC/rJg6N/RhBOeY5iSc8nUX+Pr0xD6oDJ4F7S1U8Oyr8wdJ59khvOFP
         gpYTdyvWIWDdwphfKMzhsVnd358kU0EUcoOfWSeJeatuRsQ9ZkJm/H36Li9VmkWgeHdO
         9dRw==
X-Gm-Message-State: AOJu0YyToAlQooBErszQhMFf17au5uFXXEJw4bUtHBlbdspnvrDG9+zq
	RpC4r1TA/dLQZkZdYKUpCmd1rzsdt82FomQ1hVRLGfeXDIsQMd36wQ70
X-Gm-Gg: Acq92OF1Bzw/IQND9DDjzllsqrvag89wyPwDR/119P2N7rxlktNYTuwy9YdJweiI22z
	5OLz4btAHRkLPhH7mxd2eANVBrftoCHK+sdvvFGVIRNloyHifxaF87AO1SKf9DVEBibPuHECdex
	OEeOCmGU7LR2+sjPrJSdbpJzvKKIsVllxP5UY7vOhyinrl6cifDrwk47K1hMoEUeMO+vc6ukuAT
	PVP8SziKQKYHsn+VOqodUBPinFJSatNuNXt6GPp6d8DsRg8EZWKRBIjXIwtdffGEH7ooVL0Rz4C
	J6AQwKC6qE9FCbXFElILPVWXEzzl4TAGd4GTEJjxp5XMsNvUv3MYXgE62kwILApcrRKf906G1da
	8tdIibLMKqONrmZNCthQhYt+SosVny4vf/0v50pSihAggo8eZyHj/C4iQ+V50npnqcLV4b5M3rb
	W5P2NaNPjrLv8g/PECbH3+xjM28g==
X-Received: by 2002:a05:600c:3e07:b0:48f:d1c0:721e with SMTP id 5b1f17b1804b1-48fe60d7823mr118973705e9.12.1778939686924;
        Sat, 16 May 2026 06:54:46 -0700 (PDT)
Received: from builder ([2001:9e8:f136:a916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm123360645e9.12.2026.05.16.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 06:54:46 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/2] net: sfp: extend SMBus support
Date: Sat, 16 May 2026 13:54:40 +0000
Message-ID: <20260516135442.2234729-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30E5D55BF75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
---
Jonas Jelonek (2):
  net: sfp: apply I2C adapter quirks to limit block size
  net: sfp: extend SMBus support

 drivers/net/phy/sfp.c | 146 +++++++++++++++++++++++++++++++++---------
 1 file changed, 117 insertions(+), 29 deletions(-)


base-commit: 822d4a8e390a08ccfaf2abb347ae670b230b196f
-- 
2.51.0


