Return-Path: <netdev+bounces-114783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDE94416E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E598DB2E9B0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34613A411;
	Thu,  1 Aug 2024 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQC1aiTH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405913A253;
	Thu,  1 Aug 2024 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477356; cv=none; b=Z+E/wnXB/0VjNLEzDRDt2X8v6UX3bayMd+IBg8kTdFTzx7JDCA9fxg4a7a3EYNgYq12Q7b5spg8nX0njgoFn8mGa27HmPghv2/TMEnTvKvyo+tZ+zjEyYneJ/B2OzMzsv1A8rXtE9YJuTNhovQUunAsPR+FespAxheHWWDqWV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477356; c=relaxed/simple;
	bh=uHbLe+RBFmLlGtZXxZwsejz2HWhXvePnk+ZyQnjRY5I=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hw2/KEWUaRjvBnJJ4JakrVl1Ng8cLgBFz/jGjWAZgQJ9uOLhXPuL+8pa/KgKsXRYyjqgXvnlIcRDvcX+bOXL3gu9BpIp+iGK7GO86IFGxB/DetrzQ+r8k5dS4n2fT2c9pgmQeoU69OSaSiLCARriSWQvurk155s2kEOj4nQHxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQC1aiTH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26456710cfdso289870fac.0;
        Wed, 31 Jul 2024 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722477354; x=1723082154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tv+e6bMcKL54/VgxLJc8fu2XV128ccfY1/dmbY9QKIg=;
        b=EQC1aiTHWgskWqQAv9SGglZRbVg1PgGt2Hbe/fZ15x82KLb8okPI3xK67OhiL/G06X
         3c6eYI4+egQcB4COWHnyivZ0FxDwbLrmoGFtFxdoJlUnBXPysO3a4utaKlvmQYceRY7N
         TWYQdQufY23IeYaB9tYXD8Bc3YypK9Yoe8Y6iW9PQBqu+Uce5M4T+xEGiMjhlc71ILVu
         IkeKK68iaFOrpQhKnWsujlE8IrJbXAwrCKvhAPknLzAxK9ulfmNPn6PphccoKddiB80O
         jxiYVQ4Km8GWqmTPEDErPNKr7WbQhu2XMl6b+T1MPXpCYcZVhLsL5BBMcUSRJ56+8pzn
         RvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722477354; x=1723082154;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tv+e6bMcKL54/VgxLJc8fu2XV128ccfY1/dmbY9QKIg=;
        b=LXnwCEMANvP34HMQyq7k9qmipn90dsDZ2zDOjAwt35wNRREK0e5u3zHg+fMH984USU
         GuBDPQXyO6zTwEd2qbZbhIW8ruQR1GDVNLncDs7jNi06hixWKDycOvA12O4TAiNI6LTo
         Aw0DVQSMiJE0Gi0b/R6ecLKFG91LehvzKUnpYpRW2w3jnS+1rhwvkksCqH4NcsOMlecM
         MxBkLJgBiZN3a2h/nX8Npi6ywsqMMS8M9gafhAa1RlNYkjBZyLIaOp8O4oB8VQdxqLLT
         j7ZgLsvP6BuvtEQXjRogqGyiyzV5kxTl5GRj1mSRwKoUdD+6ohztYN2KYSSD+zUZ8XXZ
         0WVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh9NsKjR5rh0PuL7/NTOTz3oMM2UJpo4pPmJsy3GgQxZyJ4n5wToln5KyLhWDtXQe8GvbRESBM4xlG/XxnvkwHniSrR286YrgSNwxmUZk=
X-Gm-Message-State: AOJu0Yzs/yBeENqoxe5+wAAUx00Prt9uARE3Xw8DtMacvOsB/Lj/jq3C
	4bzKWn1QUYvbv+azQRf5g0M4/fLflZZqYHhFWgvmarGCGE1KpAkW
X-Google-Smtp-Source: AGHT+IFqv5+X426SpUZw1goD+Qa3VU5DZNz5ABs33goVp6dslaW45gCIpdQJ/ZW7LiyWLoX/9J2F8Q==
X-Received: by 2002:a05:6870:d208:b0:261:934:873d with SMTP id 586e51a60fabf-2687a6f3b29mr643524fac.5.1722477353480;
        Wed, 31 Jul 2024 18:55:53 -0700 (PDT)
Received: from localhost (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8225f4sm10886795b3a.98.2024.07.31.18.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:55:53 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:55:39 +0900 (JST)
Message-Id: <20240801.105539.507881194037600942.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240731042136.201327-7-fujita.tomonori@gmail.com>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
	<20240731042136.201327-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Trevor,

On Wed, 31 Jul 2024 13:21:36 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> +impl Driver for PhyQT2025 {
> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
> +
> +    fn probe(dev: &mut phy::Device) -> Result<()> {
> +        // The hardware is configurable?
> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
> +        if (hw_id >> 8) & 0xff != 0xb3 {
> +            return Ok(());
> +        }
> +
> +        // The 8051 will remain in the reset state.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
> +        // Configure the 8051 clock frequency.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
> +        // Non loopback mode.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
> +        // Global control bit to select between LAN and WAN (WIS) mode.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
> +        // Configure transmit and recovered clock.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
> +        // The 8051 will finish the reset state.
> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
> +        // The 8051 will start running from the boot ROM.
> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;

You said that it might be nicer to put the above in a table
previously, I think. The following looks nicer? If so, I will use the
table in v3.


diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index b93472865bde..1b89495d7017 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -27,6 +27,27 @@
 
 struct PhyQT2025;
 
+const QT2025_INIT_ROUTINE: &[(C45, u16)] = &[
+    // The 8051 will remain in the reset state.
+    (C45::new(Mmd::PMAPMD, 0xC300), 0x0000),
+    // Configure the 8051 clock frequency.
+    (C45::new(Mmd::PMAPMD, 0xC302), 0x0004),
+    // Non loopback mode.
+    (C45::new(Mmd::PMAPMD, 0xC319), 0x0038),
+    // Global control bit to select between LAN and WAN (WIS) mode.
+    (C45::new(Mmd::PMAPMD, 0xC31A), 0x0098),
+    (C45::new(Mmd::PCS, 0x0026), 0x0E00),
+    (C45::new(Mmd::PCS, 0x0027), 0x0893),
+    (C45::new(Mmd::PCS, 0x0028), 0xA528),
+    (C45::new(Mmd::PCS, 0x0029), 0x0003),
+    // Configure transmit and recovered clock.
+    (C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1),
+    // The 8051 will finish the reset state.
+    (C45::new(Mmd::PMAPMD, 0xC300), 0x0002),
+    // The 8051 will start running from the boot ROM.
+    (C45::new(Mmd::PCS, 0xE854), 0x00C0),
+];
+
 #[vtable]
 impl Driver for PhyQT2025 {
     const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
@@ -39,24 +60,9 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
             return Ok(());
         }
 
-        // The 8051 will remain in the reset state.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
-        // Configure the 8051 clock frequency.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
-        // Non loopback mode.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
-        // Global control bit to select between LAN and WAN (WIS) mode.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
-        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
-        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
-        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
-        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
-        // Configure transmit and recovered clock.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
-        // The 8051 will finish the reset state.
-        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
-        // The 8051 will start running from the boot ROM.
-        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;
+        for (reg, val) in QT2025_INIT_ROUTINE {
+            dev.write(*reg, *val)?;
+        }
 
         let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
         if fw.data().len() > SZ_16K + SZ_8K {
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
index 4cf47335539b..603adfd369c1 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -49,6 +49,7 @@ pub trait Register: private::Sealed {
 }
 
 /// A single MDIO clause 22 register address (5 bits).
+#[derive(Clone, Copy)]
 pub struct C22(u8);
 
 impl C22 {
@@ -131,6 +132,7 @@ fn read_status(dev: &mut Device) -> Result<u16> {
 }
 
 /// A single MDIO clause 45 register device and address.
+#[derive(Clone, Copy)]
 pub struct Mmd(u8);
 
 impl Mmd {
@@ -174,6 +176,7 @@ impl Mmd {
 /// a port, then a 16-bit register address to access a location within
 /// that device. `C45` represents this by storing a [`Mmd`] and
 /// a register number.
+#[derive(Clone, Copy)]
 pub struct C45 {
     devad: Mmd,
     regnum: u16,
@@ -181,7 +184,7 @@ pub struct C45 {
 
 impl C45 {
     /// Creates a new instance of `C45`.
-    pub fn new(devad: Mmd, regnum: u16) -> Self {
+    pub const fn new(devad: Mmd, regnum: u16) -> Self {
         Self { devad, regnum }
     }
 }

