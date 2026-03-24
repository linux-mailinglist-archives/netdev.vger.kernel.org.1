Return-Path: <netdev+bounces-271147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDb+Lu+0wmkvlAQAu9opvQ
	(envelope-from <netdev+bounces-271147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722943187F6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00FBF30C2D94
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0438C2BA;
	Tue, 24 Mar 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgqIIKtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BA389445
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367596; cv=none; b=RtyEhAn5l6mMR8nk4Ud92c1rAA2c+iPYOv98W5Es/esl1tXAORQW/fQQLyxAk1KqhNgTlx9GVKCOV2/YCVGTrby6bOlrxS4uJC41IxlCxUQGw7ytypq620/6bfjSV+at33HDUHHFM2AfBSzIujJfqR0C5cfX9GSusrgnnuBHTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367596; c=relaxed/simple;
	bh=xuyvMe+SNux1ePFfxCnCrN815+h8uo0A3psb5ed0ZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQsIAfNZcr6FI7nSrJcBIaH9+jSgpuxNVF8VJmufR4nXXBhreDu66P9XEzc3p/3kHm7H7kZrBErTKkyPSLG3Re8f9RHSIDGmNLWLlUJ3Wc/UPQI8X75Nuc0gYqr9b/0KZMZw8GbJHIgPUf3ZI8YxZa8sxqAtl1vpVin0r9E/MYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgqIIKtO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38b13652c87so12836161fa.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367592; x=1774972392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjErHIsHseJ35cde2HIfuRIn9XssCsZP9IFfHWdKmU0=;
        b=lgqIIKtONKiG8Z7mfawOiVJLrtvJcn+TitGDZTalEW9ydhPmkz23MpJBoiSx1vJg69
         kj3uyV04ScvdNKu27k+7ZzT+eeDBjMtSUrpJlsmJ2E3cbAngyEnQkX4WhIOaluNKhJ1P
         xl3DJcadNs6/4fYpusun1fNBzLi84PPYlVA+Q7IT92+zu73XQH7VxKjw/VtXUE9bMuZI
         ontr1aUXAnSBbo6oFqZteB4zP9aE22ga10zNsgTDnWboKLde3TydWlav/yFRKkhwMOr8
         Gu9H3ff1lG9HdgjrcbfPbSZv2GY1SxFohAyFpGPQ6eU7Km1XeP4lh3iLmv3h8NJyMCDU
         NlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367592; x=1774972392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjErHIsHseJ35cde2HIfuRIn9XssCsZP9IFfHWdKmU0=;
        b=FwP1RhQRZzocj9xI+dPSauVIVjr2m05Zt+mhGt564R1efrZzoRhZw04bm15qtSC1CY
         iDa14ZUkymnSXYew66700i8Xs8ZpF38hqGOjqibDhbQ4RNQBv4gnB7Gg8BrzX7MmF3Q7
         g+cN0gyD7NHytd5qW2GBF+nlzxtNx6kvjsWAsXQ+od8k2y7yVhvqJzUFfuaAfZVcAfJu
         GX0R3ANc2F6UKAGztGo+4mRiS9yW9k8vHwX8nGusIZOk7YK8oneRb0AypQPe1VtJgIBV
         R0xaswK/pYZKZvg7kiLQG5S+moKEMHpIO4pk4AQsY5FVSAz22Ku041EQadBLHP+cv4O0
         hs3g==
X-Gm-Message-State: AOJu0YyB81ZGDEfio2w6C4Noz4sMRkPZN85CqEBTo/JEQruZ3Nv+kn7F
	9e3rDFQGHS8BSxAC5jRNpKAC+dCTVIHZpw/f19IzI9yPnxiNI+BgIon6Fc+Y9rf2
X-Gm-Gg: ATEYQzzci17FqslnZo0RpaA2FzGtba5L1Moc+VrkeDqx+1LJyHUJqcK611GucKPaFAh
	hCVGrqt2AplGE9mgYt7BrE7R8a3s74W2RJGbjrA/Hc3G4ea/WFNcCnDmnE+IPXzNo/5q24AUdty
	MdpyPZjEXc+pqOLaMINp/upEqFCxR9REY6MuKuQ2tq8aDixGVFSmc/MPSXydm/XdOOQYBzWLXFK
	CG64KGz5Keb64jbusZ+mZ+UJ49ki/3eBikmcjbRL5w9A96GK2PqFvBMnO5w58tuo9daw0mTGIxQ
	+dEkys7wkmIpNx7qUglnCFndLa6xMYwLEqrUvPIFPSj0RtQJFuqxmnjPePMjgFMxHFCS+fq9z1R
	MaCEVS35DRP4OzgDrchR7jGASEkLV97R4ZasgUHI2748BzuLvBFdpoQuSGVU6fSeFLb8BMQXYfo
	EnNeDN8gnKnCtSf+PKkVxvQf84MrvKGaD/XK0H3+h27IqnoJJJtUrGfEs4OMw9FeEfiHcR9Fgey
	tflFtXec9JzSogEHA==
X-Received: by 2002:a05:651c:234c:20b0:385:d6b2:f4cc with SMTP id 38308e7fff4ca-38bf96cfbe1mr40001761fa.19.1774367591926;
        Tue, 24 Mar 2026 08:53:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm32567841fa.32.2026.03.24.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:53:11 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH net-next v2 2/5] rust: phy: add paged register access and bit manipulation helpers
Date: Tue, 24 Mar 2026 18:52:46 +0300
Message-ID: <20260324155249.15098-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324155249.15098-1-iprintercanon@gmail.com>
References: <20260324155249.15098-1-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271147-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 722943187F6
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
 rust/kernel/net/phy.rs | 45 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 646b2a78a2710..142f7101723c8 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -202,8 +202,7 @@ pub fn duplex(&self) -> DuplexMode {
 
     /// Gets the PHY interface mode as a raw `phy_interface_t` value.
     ///
-    /// Common values include `bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII`,
-    /// `bindings::phy_interface_t_PHY_INTERFACE_MODE_SGMII`, etc.
+    /// Values are `bindings::phy_interface_t_PHY_INTERFACE_MODE_*` constants.
     /// A typed Rust enum is planned for future work.
     pub fn interface(&self) -> u32 {
         let phydev = self.0.get();
@@ -241,6 +240,48 @@ pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
         to_result(ret).map(|()| ret as u16)
     }
 
+    /// Writes a paged register.
+    pub fn write_paged(&mut self, page: u16, regnum: u16, val: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe { bindings::phy_write_paged(phydev, page.into(), regnum.into(), val) };
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


