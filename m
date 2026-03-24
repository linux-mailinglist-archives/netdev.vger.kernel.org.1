Return-Path: <netdev+bounces-271146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBgFM+C0wmkvlAQAu9opvQ
	(envelope-from <netdev+bounces-271146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FE73187E1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AED307BB49
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60738AC61;
	Tue, 24 Mar 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmYXnpOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A3386568
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367594; cv=none; b=CcRaRP1fSuOzwek0tMiWInGlvZq/l5I5m0lGSQC+C+uBnePDAKCM1Pn0UrOuMGqOYoY73PraKhPpug/adIIIAelTLXCleCJhCoKy65IiupWxFFSaw94stxH9ZxSkuT/Qz+1OQFpE2ef6N8TOJgqYYruUYDcm28Eq5Q7K//E7L9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367594; c=relaxed/simple;
	bh=hrrNL+56mppOvmFvbOeCemjCcbpv9s0ZjUfDxVxrYvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojU+mseHCLuTqaK2Cr1aeOS0Y5UMw/7bladyD+Tt4EAxdUXnSAu5v/AHeeUDGZX2+6m+FxPm3H2GAtK/helLEa/L7hpWOQWQkv31nd9PoZ7qq/O2lwPK7R0em3exOmZDMwlda41owbp5KpqEWR6MFmMyxTbpcaPbT4skyjeFt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmYXnpOq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38b13652c87so12836031fa.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367591; x=1774972391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88dwbvAjV65wqRTN/ZNYuvXuh2RhGbEcaTfrEwVcFKo=;
        b=jmYXnpOqXFNwfTIc89JXdtbNKwB4L118Qu99Zf3or47iIeW6WoabnuFDHhgJRx1fDJ
         FxBkulUPjPBxZ194fq128g96ZiXTqIakccgBjZvTsCuD+IfmCzT+glZdIHdWw8bgmB4N
         XbC0o7lmjaRoOHew+7GY/j7aiUOBGUCyrV6zCbmfqqoP0p7adec4F435K/GrrGrxZK0j
         qu+kotq6rfVmtuPY7w5AFlp7PmY3MFPyQqoVjp08xH8XX5mN3XQo3aDLaxWb6JQsXAKd
         6FfIB9m4Ev45oEHf1y+Q7hhSMqifZwRzWKyyOPwxp/Cq/B7SpXe95n3PPzspv6mBo0lR
         tRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367591; x=1774972391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88dwbvAjV65wqRTN/ZNYuvXuh2RhGbEcaTfrEwVcFKo=;
        b=H7ESPANpMVzkiLCzuxS7dMfnjc8FgrmOjRZfsRkTD8i2vp/7CgBzGl77dxD68YPlfR
         OOPmLx8kCrkhG2tc5hnJJy45QyMroJ/rJS6TrmR+N13F+fnOIQ+p+UR/e/bfnne8RqnE
         IA/BX085dnMrzpY2oWXVmEBXNJzoV7ELES01+fzCRWuECsrxdLSe0Iq+v1urZ5MzgbHf
         5Yq9tEq8OqYgWUo0e1dPZPk4xLAo/FBJ03naGXxMIQVbELWgCIifnR8sJz4hbg+n/Vzo
         YMlWNQMWb7CuQlghMj2ZUwwCq30pNgwwUJGZvNtTHQMhvk3K4DXyYykqY+wGtnBwFMFM
         +fag==
X-Gm-Message-State: AOJu0YwY9Kx5v40VXFYfzgYCnb7670qVkSLP7ZCIVadvHsrHewV4GiWA
	XiVnSYznDlniWrStyIdolbKjWm5hy4dSQAtSLHImzpj1X81nFWuXleKlZzSd3jv4
X-Gm-Gg: ATEYQzyaquLGqQIhlumyiOlH9tFs+WixT6DWYMCGxtthJyslJeCZRMg2C6r6lIM6A8a
	LLfBjWBHTtPeLGIvMWqCmpTt2NmWeshhYkDX4BFaPvfs0H0O9wEm517V9hLzjKp6CoPAUctFZNB
	t9ABE29iLwvhyvBBuKr9pRFzl/h9wcGt/nS/GqCmJ4w/lP8AWOwaLcSyt5JTgtRSMAb4QmmD7J+
	CiQ+PhnCb4DNFsFfqPlkYDTL5ukkhQKeUqIFSZSIclbOkjdCvVeBo8Bcs0uQVWZXYy4lh+zA8mp
	oyLpGNoYp9zUm4RCBJUGgjhlyvpU+ZO4aZPtICha88U35aaD4nFB3oWrCgZ+mNrKv+Gfk+ZoWB5
	Dc/QLZdjyfHW8SKtXMl8I/ZeMwInEWHYPHIW8s5Uu5k/u9rlA8eOMZb5r7Dks44wrl94PCwkxwm
	SQyfcveUNR9/r/z3S7j8EgFZHawKB2bSqaugAsl74b9FmuAnWlBdsWXD3WsL8UdruiI++smZmg9
	GJ6ph0UyG8v/oHlNw==
X-Received: by 2002:a2e:a9a4:0:b0:38b:ffb1:4b5 with SMTP id 38308e7fff4ca-38bffb105b5mr47405991fa.8.1774367591159;
        Tue, 24 Mar 2026 08:53:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm32567841fa.32.2026.03.24.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:53:10 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH net-next v2 1/5] rust: phy: add read-only device field accessors
Date: Tue, 24 Mar 2026 18:52:45 +0300
Message-ID: <20260324155249.15098-2-iprintercanon@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-271146-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 53FE73187E1
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


