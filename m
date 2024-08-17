Return-Path: <netdev+bounces-119375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80046955588
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F4A1C22E98
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8712DD88;
	Sat, 17 Aug 2024 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoZpf9Zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74E137776;
	Sat, 17 Aug 2024 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872344; cv=none; b=sab0uFMvN2GGOu3HrdpfpmsPaYJAbBLGFTJ7c5RhMEB5zpg5NPTSFV9h3DNYFejoQFg80wtDhf9GeyxxRAB7LJJ8Ox7w57xP4Z7r8EXIyISguldsQq0ly/MDLW8hSbvHvGQHmNWWO11H2ipprV4rey0qHP3WbDIwQ3td4qfMndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872344; c=relaxed/simple;
	bh=oBJW+f0XB9jarmPHvUlABqZwuQ4N8OtpaNryfZDmRtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJOcx3p9be5jeDAueUM8wL8N/ejfU6XbOw0sJrVUuyJr7+az3w6V3kF/bM+n9TNEQyn3PMIajonyFc93X+hz5Qk+eJUXNtrh9QrvBRIGHOy72gh9yG7haBOX7b8l0MDnrX/tVYZBLJl9LfdzMjGIeOWZIpMJEnhZ9jnekmJ70c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoZpf9Zt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7b5aacae4f0so367603a12.2;
        Fri, 16 Aug 2024 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872342; x=1724477142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joLp5cfPPOhu5Ns4d8tVtMuReBzWCm/v4GqRjTEhNhs=;
        b=MoZpf9ZtveaOt1oH008k3Iws/kkFoQObgmUBKoCVMk77xyOgUWDEhVEW1HdqWmJce9
         nLPW6eY5g70M5fvG0vx+83E9jXGVUI11XoJoJz9/RpA3/IRa84Su0Fv6T2i0UmAqEUXY
         67cM9e+drRhCy6d/airmixTQ+4wpfwyWsJaUjEDBtYyEkZ6DJZyWZnfQN0kQY9xRtY/w
         PuL1nG8QmAZJcjoAcB9OY7ascbxGJVTlISHNjuA8kTuyvLChWAZ5V50La8PJc8S8B785
         3+RP1Om1AK2V55PmwYhHA19LGWujowgDcdhIdPJsD74kbes3TpH7NnoGWSb5qEiLxYYR
         OirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872342; x=1724477142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joLp5cfPPOhu5Ns4d8tVtMuReBzWCm/v4GqRjTEhNhs=;
        b=VI6r7Tq48tNsswx9drxKL6PaZ4VuTizflqBFyeTIRTkzh4VIJHkxXH1UX/uKJyh7Kv
         Ips1x1Izemxf/MYfYw2jLDHl6rHaruCTQT8TusZSi4VbY5bmf+NKWlHP1OQguiKzfE7l
         SYF1yk5LiMzahTBkxhdE1bEuM59qK1+6GWqwSPxfR4ch1f/DgmzdJXR/HVN5tQjyXJtd
         KRACMPNOKw3NXCpYwsq0xhTWFN+cFaWipafL9hrPq2lwde7oP2b5H4UoKL+rrd9sbMpU
         5M8cmyftcwiocJIRRtEusdigzk8bEQ4VCN6RRHcxxvn/9R/3tSCiU3e95RGL1IGIvv5y
         rSAQ==
X-Gm-Message-State: AOJu0Yzs7FvfnvKAxni0UEBj/izidIE0SxKLlRrwlMNesG4XN2fA9tcY
	f6PbqNjzjG4PmFbYk1rJvatF27NmgNGDtcs4la0qsM09CPm7RCahkfjAvor7
X-Google-Smtp-Source: AGHT+IH6MkHCdZYrzJhG1xTIc1rSMqRPhK61ZMTOMa1T4LNKctrvplkoeaoJcPn1bBCRk5SH+zsDAw==
X-Received: by 2002:a05:6a21:9982:b0:1c4:e645:559b with SMTP id adf61e73a8af0-1c9050929f0mr3703363637.8.1723872341772;
        Fri, 16 Aug 2024 22:25:41 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:41 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Sat, 17 Aug 2024 05:19:36 +0000
Message-ID: <20240817051939.77735-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817051939.77735-1-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
needs a reference to device::Device to call the firmware API.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5e8137a1972f..569dd3beef9c 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,8 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::addr_of_mut};
 
 /// PHY state machine states.
 ///
@@ -302,6 +301,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
     }
 }
 
+impl AsRef<kernel::device::Device> for Device {
+    fn as_ref(&self) -> &kernel::device::Device {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+    }
+}
+
 /// Defines certain other features this PHY supports (like interrupts).
 ///
 /// These flag values are used in [`Driver::FLAGS`].
-- 
2.34.1


