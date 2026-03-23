Return-Path: <netdev+bounces-270725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1f3tGuChwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:26:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1E2FD2F7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7119D3047A79
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA43DE427;
	Mon, 23 Mar 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz3EmZRj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82C3D7D67
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297193; cv=none; b=QtAUNdyhoBhkYD/MHDkYG1bhZGbdymYbX7qB7S2NccpMhvR/ZQhRvTwFLfNk82R/Au0pnAQiCgmv7ybfxafBGuqEfv3hcChYehGUHpwcKOM/IFu+VtQJeALYrdA6c3uNJB8uj7YdL3MVXbyB4yFgwrVIGhULJ9gQGo+cE3H63Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297193; c=relaxed/simple;
	bh=hrrNL+56mppOvmFvbOeCemjCcbpv9s0ZjUfDxVxrYvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9RAvUSUGJ+56Sw4PhICsX1kj3jBPzhuKXeoVpmnCLREc6b3HxnvKAB4kxnLKw1JN5P22qNVy8xU1D6cgaqTEiIrF8358t4Hdm5czli1oxFkTSbSVUBjobeBH5hWeeM/nSimkOsvGvYIGcuZIfeDtSU5mT7JOJ5afNPBTJlKtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz3EmZRj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a281b091c2so648599e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297188; x=1774901988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88dwbvAjV65wqRTN/ZNYuvXuh2RhGbEcaTfrEwVcFKo=;
        b=Nz3EmZRjXYEFPCjKTRBiWqgc/Y2SZEddUCXSvmAW9w/hPD5FmYMKp3K1Ww5DkBrBx2
         vEWY/a11vLzs7i7WgZf3z68aHbKyfwJt9eyVXof/CyywWi6Bjp56EPbtFr+LqMs0+CX6
         IyfztQsRsxEJxB13nM/GWjrZXO1FARNJLDrxGjoEs28QmNAPQCY65AETbSD8cqZwOcw7
         xPADmOoO5pLEFPe/IBhaz8AmWGdFn3RUkG4z5oLMXDFKeRYgmhExocBIeQ5DiwrdLKnr
         ZNabAJHNvncYvGglefb0I5B9Sz9e7SsbUyIKa/lXELhLBlIUWKYTjm7YnGWg0y3lY/Mq
         ATCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297188; x=1774901988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88dwbvAjV65wqRTN/ZNYuvXuh2RhGbEcaTfrEwVcFKo=;
        b=gxk+8hfNxytl/YUnrPiwmuuf6uPA6MuLES4UCQeAOOOnwOF0XggR32lIXCfXWelLT0
         1PK9SOry0oW4rczdlKLUfjuHxJcXM3ecji8+cWfV+g8Zn6TKuFk0l/HMM4P0CZzMTPNF
         Cqs5OBaoZrzuPC0dege7hK5HS1CCd54r3J5QYTu7v/goezvIxYzIm5U6gStjV+4RiMKz
         T/h49HuS3Lmgeorm/fSC5AbWVrBTmS3eGQpjmg869KTcbS/R40OkFXvxLiYXyOQVcoLz
         CJ0I+oQUcypUFxrSQJzkfea7Nujo/rD+KzPLH6PY1V13GgE+bZN4JKwE6A1idxtlpgXY
         76ig==
X-Gm-Message-State: AOJu0YwkkLG0HEfn5TTFUC4JFpFrE4voRJUBNz7xt46bFqKSHeGtgsNv
	hty3yqPf2LfcxhDNg7khYre2N8U5HheIuR9jz/c99AeiVu/xqfWwSSe/gKDDo17r
X-Gm-Gg: ATEYQzyEsBu2NPn1nM7Fh79IVIPiu7viz0anFnhKEx942U98p6aPoMzWATaJk7g6gvv
	/YqajJkzaxpVl4NFr1LqGOgko2NCy1Qby3cblGK96WpXQoRT3v184d4KOUuqHBhYJ/Zo53M7NfK
	+EmnN8t72+SnHNu5LVsEoucZ2IGnsbMXzHmmiuQbEQlttApSc3ehUP/QF/UwK1puDSRNsBSjnA5
	wMHxe8Vjctr07K1ZlK4kdOnt5sn650HCuYCfuJwEOFb61r12QRUnu/X9x10gtihSYpSyjRmDTPA
	AmQF5tGjlxbHIIil/rlqn2Nef/mrYG0TSnq6GwG6PeFZEfl3wscKdU2fqq7yMH2DjY1lSN0ydX5
	aI0Q5PcWm5e00sJ/ENElSICdkyt3WMa4Eks1BNumRsWsQnGzs2WZzrKtWjWdswRVpqnesCWoQLK
	V13s/g3xs6VSKjnL87+8QxajHefXJj6u7aO+Sc9Pbll/Sl6B8Vx/WTUfSWvZVMrRsvqC+pd+N4Q
	VHr45vMsRxyEPOVdQ==
X-Received: by 2002:a05:6512:3ba9:b0:5a1:407e:1207 with SMTP id 2adb3069b0e04-5a285b910bamr4659921e87.38.1774297187905;
        Mon, 23 Mar 2026 13:19:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207365sm2720623e87.42.2026.03.23.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:19:47 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH 1/4] rust: phy: add read-only device field accessors
Date: Mon, 23 Mar 2026 23:19:22 +0300
Message-ID: <20260323201925.8405-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270725-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FF1E2FD2F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add getter methods for commonly needed PHY device fields:

  - speed(): Returns the current link speed as i32, matching the
    C struct field type (int speed).
  - duplex(): Returns the current duplex mode as DuplexMode enum.
    Only the setter (set_duplex) existed previously.
  - interface(): Returns the PHY interface mode (RGMII, SGMII, etc.)
    as a raw phy_interface_t value. A typed Rust enum is future work
    since phy_interface_t has 40+ variants tied to DT bindings.
  - irq(): Returns the PHY's IRQ number.

These accessors are needed by Rust PHY drivers that must inspect
hardware state, particularly during config_init and read_status
callbacks.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf2..646b2a78a2710 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -179,6 +179,47 @@ pub fn set_duplex(&mut self, mode: DuplexMode) {
         unsafe { (*phydev).duplex = v as c_int };
     }
 
+    /// Gets the current speed setting.
+    pub fn speed(&self) -> i32 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).speed }
+    }
+
+    /// Gets the current duplex mode.
+    pub fn duplex(&self) -> DuplexMode {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        let v = unsafe { (*phydev).duplex };
+        match v as u32 {
+            bindings::DUPLEX_FULL => DuplexMode::Full,
+            bindings::DUPLEX_HALF => DuplexMode::Half,
+            _ => DuplexMode::Unknown,
+        }
+    }
+
+    /// Gets the PHY interface mode as a raw `phy_interface_t` value.
+    ///
+    /// Common values include `bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII`,
+    /// `bindings::phy_interface_t_PHY_INTERFACE_MODE_SGMII`, etc.
+    /// A typed Rust enum is planned for future work.
+    pub fn interface(&self) -> u32 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).interface }
+    }
+
+    /// Gets the PHY's IRQ number.
+    pub fn irq(&self) -> i32 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).irq }
+    }
+
     /// Reads a PHY register.
     // This function reads a hardware register and updates the stats so takes `&mut self`.
     pub fn read<R: reg::Register>(&mut self, reg: R) -> Result<u16> {
-- 
2.43.0


