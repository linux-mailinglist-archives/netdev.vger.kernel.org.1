Return-Path: <netdev+bounces-284575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPS7IS1P+mndMAMAu9opvQ
	(envelope-from <netdev+bounces-284575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBC4D380F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAA9C305421F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75523DBD7D;
	Tue,  5 May 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKIITUVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6A3DA5B5
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011616; cv=none; b=bmw42SoNMwAruGNL72VHnmW78YZft+qrJASZik7oQsTDtFVXKwMmnct7c/aNv/hAMlRjBceNDhsk1wdGA2qkSawM10Rfzitb2p4JDpqKbYTbDi4erSRRlkuhDZWWqm4lHCu3fJQV6oX5FOSViTCvVMVIgJeuVSyUlt5I7QaihIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011616; c=relaxed/simple;
	bh=yxQQFbPDX0UTtERpG0VWGDpOZ1IZ+Hpgmk0WiA0iRi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nybelQ5UJZZUzdUuGE6UXYOZ2eKDlNnP99Crv50NVEiDbJis8BlE2nVeSJtTnfVQcLmvoznMr21RlLKwcERorDEGDxqlZujNKk7t+XhKS130r6lABnGddoZk7nPnWpVfiYHcWoCXe6WoM0NgfO+lJH6VYvrFmyWz5K/w/Ip5q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKIITUVf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso2649158f8f.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778011614; x=1778616414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U69pDkFx0w5rkGimfNd3UP42FE6wKyks8vJvY493nVM=;
        b=OKIITUVfuGpumt1b6vraWTOw4OafPe3gjzI3eJAmtt+6a3qfQOd62AOxj4HeG2s0g6
         lNitogTXq3It4vdekGSUasfcRCGSJePT+cISWaJZcleW30mJ8RamGmacv2P7JQdw3enA
         miGhoBO6WhBlYg5Xfhpcje/jWvNPoeYr9oXttK71cEa3ey/F89CNRKJeY9XxJGDcDacj
         l2OVHsIvUEpdQxmRA5ZTrkekcad0NalNJEoxqaNPVBIbN4Stlo2cdCMilTNeUaYmbYX4
         yBd6HROh1mLrqH4fqSSFxGGEnmNk64DVkRckzCcz0YODoqjRIBWIpdxXRkH60Zfyq2yQ
         KmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011614; x=1778616414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U69pDkFx0w5rkGimfNd3UP42FE6wKyks8vJvY493nVM=;
        b=OtmZ6CyVANoofVGm76rnlsgqTlOCLNAGeu2U3MuCPTKChw/qqs53gie+mk1+r5HL0q
         tLButotUuFBcDX8O1kM8/uugynVSL9WKPp1ZIJ1oQauR8dsOzTPMx1viOs9iA/aak2Th
         ffMzv4ahcMV7ivaz1QEcixJMYS/zpLKnjGa/w0kOH4Q+LBliTm61uukLW6bCtAUOChtN
         8QtHVWD5crRGrVXUFvLWOf2wc+RzK4AeHD5RYHvH3RlpuNPaC6XULhv4H34LvFV7i8fp
         SLTNAGrexawI2CdszjhRYnMuOPEUUDcGW2JWup6jURq6u+PIE5Ddp/vYUBrNmjRuNq7/
         juXA==
X-Gm-Message-State: AOJu0YyMD/vJEBLFqgqYUT+QxcqI0584EsPJTEkMgn/HhT+fc43arr6p
	WRsLOnxJO2Ig+OpkZ81WpHw2B5ie2wB/wy8L8+IoBZ4xThSxzKz4PUKH
X-Gm-Gg: AeBDieuR9omN/GgM+ttQU1+DpGb0xBmxEkTM66AB4uDGhRLt15jBr/VMqFXPYdEuH75
	8lnd/toe8iIUih8xnTJ+Nqs7NbKzUOiOHkSBkm1l+fc408drg4wRTpS2jRawXtYrnWRELqZhKZ7
	x6aiGA2NgEUMsrM3c40o/NhKMCKK8zznhAEJyIYGr+c0gkKMmdsbGvLU/Aefcf26Io5WPi0xXbc
	dl4+tvhv7YB0+Sw1o4PtI4qtYOQ/IASRsXOPLQtKQ8VIcPimcwbc8T3qawXro8vjYx+3y2sDgzb
	RXbmrZZ6zV9VORTcetNcvpvWXI4cy5KpZgJic1ZPwr62lD8+5VNr3Me1uQOVjvXwOKjJ7hyiAWm
	KA380OK6PYtj4H73pZhXfBi4gm731hlqdj2kJl4HPOOcmBy/pSkrllT6sgpmkBoMFs3TUY7/+my
	vCzCncFt4jkGx1TpOCR7wiDgy2jfHoHPbAbL0L8hI2DuheHJo=
X-Received: by 2002:a05:6000:144c:b0:43c:4810:dc4a with SMTP id ffacd0b85a97d-4515da9619bmr861987f8f.38.1778011613478;
        Tue, 05 May 2026 13:06:53 -0700 (PDT)
Received: from builder ([2001:9e8:f130:ed16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm7049511f8f.37.2026.05.05.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:06:52 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/2] net: sfp: extend SMBus support
Date: Tue,  5 May 2026 20:06:45 +0000
Message-ID: <20260505200647.1125311-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BDBC4D380F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284575-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,gmail.com];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,209.85.221.41:server fail,2001:9e8:f130:ed16:be24:11ff:fe30:5d85:server fail,104.64.211.4:server fail];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


base-commit: 8c699be3dad7bba87cdda485dc099226cfc2f706
-- 
2.51.0


