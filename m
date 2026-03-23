Return-Path: <netdev+bounces-270724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJwsJ16jwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF92FD4D6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33BE30620C7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6D3DDDCD;
	Mon, 23 Mar 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+eoYf9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DA3B9600
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297192; cv=none; b=cZXP1EZW0Jma6ohXCajk8vq4XKvYvxmFBmpsQNlIAoSzRrBPkRmnodh6P8BvigcUNDwqVqo1hoHBOJdbkbGaEQkdY4L3mYN73BMVW0c3sCt48YYpGShz5mfFzQ//Nt/ohlKMkoeBwo7VcAGks1Nz5v6cNeCf6n+abJR0UJTod7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297192; c=relaxed/simple;
	bh=B/iMACF8boppVlhKT3EV3WhxAci2tfI24r1XLay4l54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLJFoNCW/gRAUsjQayAJiWtXLzOXOBVCtD55MR4rw+A5wNWADm9YXtkXbPGMAjSHAg4O9ZxiNHVLHjONXOgsDNTtiqTUT79wvEpEx44N5oMorJ0oFW81JbSXnQICbo2wkMQtXcrtHnR/W78UL3o5KPJratwkcc0iwc0n9mOSezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+eoYf9A; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4a04f059so2842865e87.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297189; x=1774901989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1xlgAKziwDGy7HCoeKtXi6eXYVXotOIcpLXVMuXXLU=;
        b=Z+eoYf9AyINynE2liAc2JHbHyI5tbF01/6V/3WC7b4juBS/QB42VkYnDasQC5kZsGx
         TbFizs1+0ckRAGZ2Wg86t9SwFHzkE5FoLS2TIOoy290MyZpQaTgz8bQBhfXff8on3HXq
         yUQbCAYjRzo0N9bVLwCoCJn0ZHn9gTe4DOlZpUtR9bkJj83YKN/FJ5ZcOdyzb9qr3VoG
         XJvbiRTcpOXT2XPlzCHepFJF9k9t3gfiqtodtUV5iNCmHm9k0bNtCTj1ZTB7IlUOzcDm
         XtRbgJcecO9YUKK6eSff7HN1pE4mOxf2j6/sYrhJ8H77+6MCducHRqb1rBU2LuMqwES+
         R9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297189; x=1774901989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1xlgAKziwDGy7HCoeKtXi6eXYVXotOIcpLXVMuXXLU=;
        b=rxEz3pYJUpI4UiKjYG6Dc2Y2+upRX/RaY8rzPiedbfMPDYNBEhNyhpJ6xwCWT+gBzC
         +FJW1dwzU6cdPhsMqlic//WI48JZQ6fVOFY/iIElmJVWDL9l5ZLX3VCNfxA35LwqzIvZ
         kO6uZ0Oi4LeT34k4Gjgqjj7byGzgyiOviOe90F01TADR1Q1lCHvmtwahkuFK19LJ9P4o
         zdtdkvY6ptoxlwnpin4ySA6dBpg0ZplHlYzSzxoGb+fqk4aW1n0XDj+zzUcVpCSInz6k
         0qqFB/FLvsxItm2IqmYxqZ8P/xZN1zvlTOSiKPl8txb7xJ55YSGF5VP2ltb427pP2so8
         qj7w==
X-Gm-Message-State: AOJu0YwTrjuAoLASCZeqhpsC4F0/wDi+HwDwJ8OyRk8XKabEGlvP9SO5
	BE6iFudsbsCVuKqMEYayK9GW1yCKgVOqStY0qiil1zhZjK4XzsNemEz2l9BqO/kz
X-Gm-Gg: ATEYQzy2D7PLejaXe2iIPGMSjj4C2TDdVEnvNl8Ew4yVkb/ro9NpUf7K7ayXPrTVKuN
	yG4yFVbGHwIWa0A1mEMDJ/YlH+SGWAb1OQgek04xRZvqOZzp9d/6PERL0fsojzzignEe0VoAr5E
	LOwCsOS9BEAs+KFhZu9nurEmIXhwidkYmvXHsOLgXHmL1waLTFgjtEPce9TldBEFKeg4TZTdbEc
	DL73s9X50Mr1PO+wqstRBoK1n+wCXHmjkCv6VFsrFm4pclqOJpxDIsW8TQH7VlEB0g4wfotKCAG
	hsXLqgDPptMwIQIb9zSHaamMuIpZn7ZF0Ma5bijlHzMLxB+UOq0YPVOgwwQzyfbT7pjyhopx4Eo
	yof8VgeNH3KvKdV6q/oKyub/IyTidaiH5YUyXlSysdhg69lOBQFz/GE5lrtEQCHjZ3Zify45G0U
	ZV4Z+l51Ml7LIxkiAlB3vlhfT50B1cOeaSj23ueOWT7Y49aY1MDI5f44SNeYHj/rKcLPncbX29V
	TbbBYpOlFcAKfpXTw==
X-Received: by 2002:a05:6512:39d2:b0:5a1:2e0c:86de with SMTP id 2adb3069b0e04-5a285b523d7mr5516711e87.32.1774297189065;
        Mon, 23 Mar 2026 13:19:49 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207365sm2720623e87.42.2026.03.23.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:19:48 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH 2/4] rust: phy: add paged register access and bit manipulation helpers
Date: Mon, 23 Mar 2026 23:19:23 +0300
Message-ID: <20260323201925.8405-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323201925.8405-1-iprintercanon@gmail.com>
References: <20260323201925.8405-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270724-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26DF92FD4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add Device methods for register manipulation beyond simple read/write:

  - write_paged(): Writes a register on a specific page, completing
    the paged access surface (read_paged already existed upstream).
    Wraps phy_write_paged().

  - modify() / modify_paged(): Atomic read-modify-write operations
    that clear bits in mask and set bits in set. Wraps phy_modify()
    and phy_modify_paged(). These return Result (not the old register
    value) since the C functions return 0 on success.

  - set_bits() / clear_bits(): Convenience wrappers around modify()
    for the common case of setting or clearing specific bits.

These helpers are heavily used by real-world PHY drivers for
configuring vendor-specific registers without races.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 646b2a78a2710..43d1ee360268b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -241,6 +241,49 @@ pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
         to_result(ret).map(|()| ret as u16)
     }
 
+    /// Writes a paged register.
+    pub fn write_paged(&mut self, page: u16, regnum: u16, val: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret =
+            unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
+
+        to_result(ret)
+    }
+
+    /// Performs a read-modify-write on a PHY register.
+    ///
+    /// Clears the bits set in `mask` and sets the bits in `set`.
+    pub fn modify(&mut self, regnum: u16, mask: u16, set: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        to_result(unsafe { bindings::phy_modify(phydev, regnum.into(), mask, set) })
+    }
+
+    /// Performs a read-modify-write on a paged PHY register.
+    ///
+    /// Selects the page, performs the modify, and restores the original page.
+    pub fn modify_paged(&mut self, page: u16, regnum: u16, mask: u16, set: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        to_result(unsafe {
+            bindings::phy_modify_paged(phydev, page.into(), regnum.into(), mask, set)
+        })
+    }
+
+    /// Sets bits in a PHY register.
+    pub fn set_bits(&mut self, regnum: u16, val: u16) -> Result {
+        self.modify(regnum, 0, val)
+    }
+
+    /// Clears bits in a PHY register.
+    pub fn clear_bits(&mut self, regnum: u16, val: u16) -> Result {
+        self.modify(regnum, val, 0)
+    }
+
     /// Resolves the advertisements into PHY settings.
     pub fn resolve_aneg_linkmode(&mut self) {
         let phydev = self.0.get();
-- 
2.43.0


