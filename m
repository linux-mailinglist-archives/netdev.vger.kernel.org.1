Return-Path: <netdev+bounces-190701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE818AB84E0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8521718935DC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED929AB16;
	Thu, 15 May 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJK9ePG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D229A9FD;
	Thu, 15 May 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308484; cv=none; b=YI5q/ggjtTB8lVms3MLkBm2TDBtjfLyAhsQM+SHAtCppddWKPAgV/HspetPVkdSPwjy171mB3kqfpb1zO7kzA1/L1ZrUlvP05fh3ziMgeeyJbvFFKUvglMKuD+tCnzGuvScYT+ODkrgC53jUPE5YpavmDuxG9MHJuTFpnmudacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308484; c=relaxed/simple;
	bh=7+tI8hwLbYdzJV+gBIpLHIKMoHARD16RXhpQ66Lpp4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm/MbQEMTC6+x9nGk6a+baq2xfXsDnJpcIWnA0ASnrJflMl24dnAAVbr4onxxC5mv3W5YLjzBdMl1sur/FnRwxaUzbpgyhGqr0nuc4Rd2s0XZ9bnxpE/qHf7cc5+mnYePfvARn/BW2kW10UVbQPm6qB2Oe7zZSScGnzNnhdeLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJK9ePG8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so456529f8f.1;
        Thu, 15 May 2025 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308481; x=1747913281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WRUASopis39OXvLEPbV9DFXqukBSZqYvvkgfn67TzI=;
        b=OJK9ePG8NDNx0v+dTR8ejo+gzdtEqT2dMy1sxFLl8/Gv89r2wUveXS6KnfoEzCz5qM
         +tlMmcF+bVkPx6BOlIPjBgtc2OdiPnNOOhJb+k3qzhrvtFZeyp7XGPrLV79K8L90Hh3W
         RQiupyhlHzJhlikskHfmArc7+GlR0T6bAzrW/L732y0/wuiYyAxa/9+IkbydgS2NGXuw
         3VTM85k6yG+yCOLvSljwSPXzbzc0aLDsHePGQ5gBCl1n/rCI6dFnfqJU336SToApzbvU
         tzsf8pwWDuaeAaDU3ytLnUhjWro5tapXDYdhogjfb0usHoB7Rb2lQ0rSMIs8+svJMM9W
         7h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308481; x=1747913281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WRUASopis39OXvLEPbV9DFXqukBSZqYvvkgfn67TzI=;
        b=OWPwI5uNOKL1yVd8w99m32dF/bL8tbE1tJYgjlM8fEIQ84kX5ezYbquPMmssdTqBT0
         tew9cncY/+gbx/A/naN1MGEMUWvE6GJ66P1w5lRF8E2SKaQ3k+BDQTVvOli14zoe/aUn
         UD/Lz8GwTilgkA273F6VkPi2BdiQAnnockjnc0J+pTpWProoxbaQGwfxNDhwjW/dkqJ9
         eVNRLzZuOZuwASQ87oxt6xohu0mhcxHjmsUZhwgNjycCD0w92SsBUqVxO0d1pon5T1dc
         dM5NlqCCaaMdAoVBJoA+JCA3SiwBWKCijUpfEXQhm2UWrjLzyMvQiOL2Jjny7UOuO3zh
         GxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr3Muv0hbnYXq4uaxc+2bNdYJdhzsA0dZ5fZ/zGk8q7zsPvysiIwO5W8HTHI8fTsPNlbiCR90G@vger.kernel.org, AJvYcCVIvr9FbCNoVr6tRIz3O82JXyIl1Fv+P5GYRygasmmHBsIsg+EsWIfd8q97/WtuwF8qayTugOiFrcX1@vger.kernel.org, AJvYcCXe9m+BNiL8VKsuiteHnar+RK6BgfylThFphqcqIrb+IjgQE8mGEHxzwvn5Crde9DEsl4TTxtNKk2j2e1X0@vger.kernel.org, AJvYcCXi3gBFqEbBg3yBrUQ+W4VYeJwpwBpFy9LGQLQ6R6tm/3sZOIHyJVAVwy0hol/0m6j8EvlWFevzYdiPF7jsCPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCy9BGhLhqdFq7Kve0zc7XnoWJ7LKA/lnEtBxNS6nhj+Ei3CLG
	x99+pjMon90wIzf6uO/XtCQhM65s00rj7oVALhDIc0+1Ig5Oafgb
X-Gm-Gg: ASbGncsd0szTsm+bJluNKhQPtbVrhjBEXRaqFEo1+m2ISccFtSjA3sRc5o4ugcl6sn1
	WbtPoCp6sFaZqVSIFM0G5IhvpDRa0NVdQCip8Xu6fBp+ur2oX9NDZJTmJPiAsdc0ajt7O6dhHNN
	93sKtugBpdHpJPFHu9gmzBMvBScRECseaQB5cDIkQakYDb65O0jsfRUb7ZRMpTfD3VeDyAUXzcV
	r/QmcHcTgf+hIOz7TY2mQ9+pLitatozfIamMmxk5qcjm4J5MG0/HsgyoK2Q9MgYqrTAyHQbXFPi
	zTcEoTW/Js6AnZGd2fbzwQALxbS/C4F2Q3E8rvws9lhrJ++oMawZ4+yaIkDOa4M7BLQQmr6Wi7n
	XIjaIbUSsMbc0mmHwNg5E8OQ+O3vRTxo=
X-Google-Smtp-Source: AGHT+IGbTtkMc2zafm9iTKM3qZMaH0v+dLTSZ0CIbIO+8P/WRxIaRaD668iTpr1FLDn6Kp0dcuBW3Q==
X-Received: by 2002:a05:6000:18c4:b0:3a3:58f0:a38b with SMTP id ffacd0b85a97d-3a358f0a69fmr1000632f8f.43.1747308480571;
        Thu, 15 May 2025 04:28:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:28:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [net-next PATCH v10 7/7] rust: net::phy sync with match_phy_device C changes
Date: Thu, 15 May 2025 13:27:12 +0200
Message-ID: <20250515112721.19323-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515112721.19323-1-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync match_phy_device callback wrapper in net:phy rust with the C
changes where match_phy_device also provide the passed PHY driver.

As explained in the C commit, this is useful for match_phy_device to
access the PHY ID defined in the PHY driver permitting more generalized
functions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..936a137a8a29 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
 
     /// # Safety
     ///
-    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    /// `phydev` and `phydrv` must be passed by the corresponding callback in
+    //  `phy_driver`.
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
+        phydrv: *const bindings::phy_driver
     ) -> crate::ffi::c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.
         let dev = unsafe { Device::from_raw(phydev) };
-        T::match_phy_device(dev) as i32
+        let drv = unsafe { T::from_raw(phydrv) };
+        T::match_phy_device(dev, drv) as i32
     }
 
     /// # Safety
@@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
 /// This trait is used to create a [`DriverVTable`].
 #[vtable]
 pub trait Driver {
+    /// # Safety
+    ///
+    /// For the duration of `'a`,
+    /// - the pointer must point at a valid `phy_driver`, and the caller
+    ///   must be in a context where all methods defined on this struct
+    ///   are safe to call.
+    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Self
+    where
+        Self: Sized,
+    {
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: by the function requirements the pointer is valid and we have unique access for
+        // the duration of `'a`.
+        unsafe { &*ptr }
+    }
+
     /// Defines certain other features this PHY supports.
     /// It is a combination of the flags in the [`flags`] module.
     const FLAGS: u32 = 0;
@@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
 
     /// Returns true if this is a suitable driver for the given phydev.
     /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID`].
-    fn match_phy_device(_dev: &Device) -> bool {
+    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> bool {
         false
     }
 
-- 
2.48.1


