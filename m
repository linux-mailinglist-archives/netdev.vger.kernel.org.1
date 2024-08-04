Return-Path: <netdev+bounces-115600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EED9471CF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9328102C
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875C13C9B3;
	Sun,  4 Aug 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNuAPAZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16813CF9C;
	Sun,  4 Aug 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814910; cv=none; b=e8yei8UwExKftjo04+FsFEgaUA2vzO5fUts6LcOPBcLBM1tUyaQ8/ngosA95zYd2MnbB7OqPZ6LWSvzy8o1UwVptX+SdG5kA1ElbpTWD5eMYQtC7NWAEWm3nnaRxIonJkl9dEUZIF4qAtTBOxZz3Nz5psQKJh27BG8tIDuQ+CJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814910; c=relaxed/simple;
	bh=CDfY6IkFb/pbtFZNpcTKNUsL9M+sTRdh9sP/wY4Hs8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvrCqOYDFRJ8WyZB70hXylH8OEfiFlDaWU66ZUU8VYTMG7Y7XlKxasg+2wEacUVALSuC7P6UxdmloHOnDP4lxVV0btIQi2RUtbghSneMVgZvltnpGB9iVGJ8CUP4ASWLgierdPeArNOwXICoGAiZ1V3V29hlMA6M4DtIsJM7H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNuAPAZT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d133ad012so114310b3a.1;
        Sun, 04 Aug 2024 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814908; x=1723419708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCN2W3Sl7lJRO8DMWpTdPVxW8ijvZedjxv3EDreI5jw=;
        b=dNuAPAZTzi17o86EUzFZFa6IMCncE11t1+orHuBrLY9fH+RJiMCyl/7GiysxnPD+HW
         ed3rGZ/tIlZ054PYxYwG9lticJQaEGQvrVJ7b4YfqsJY7HdGwpcJYYuipRJuX0m/aDxG
         rt1Qv/C2RWPalYsfsiKvxFsrATp+L7OIfEz+wvtAzNjmRwptKpr3CkrA2HprX+asl6Ld
         tudOnZwi4TeQvJypti3WARM2K+9Gm4QRLS0QXy1QX8jaYMrgo2Wh0pKhMrLp7flEyc39
         Tktuze+qeQjF0bSoBTrXieEK/bfBHEuHKFH32mspQJx4g0ROcaKeWzW3LOjQwJgn+Jd1
         DxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814908; x=1723419708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCN2W3Sl7lJRO8DMWpTdPVxW8ijvZedjxv3EDreI5jw=;
        b=XpfpNQw/gMZGgOv+lA9Jx/7tzhjYReo3THWkEDCK7OJlpFeWKsXUy41Ai00OHjv9k4
         3DEoA3aNeWfPn/kPJe5QxJVrmz4tI4ouuL4p8ZrWG+OQHK0Y5BsM8raLPR86klwcub7U
         DImPp2RgBny1Z8/d2C52W+IEEfwCfP+Oh7HgnONxu1C9TQZqkugC2+E4Ewi3AbzuUiWS
         l/JfGDI8O5KxTyYayJQYWO+AdYzF2QSbh1tFTXe52hoQ8H9YS9fPzxJ2QJRm832pm5En
         TT/tcLPHq+S9cl0j/SKcTMdgoQfzYGev2XyfTW8tAmAhR+5j44xgbFz7NI537ziWSK8m
         kJoA==
X-Gm-Message-State: AOJu0YzatnjQMjSjy6qR0QoqEqNQ88Q3MnshrdXaEEUf5IFovUASHuPp
	qwEayZ9M2Ka94hWLDTd+Q3KL+LPgbkZ2VhrDLQhihnLIjleczcZMDJT/THD0
X-Google-Smtp-Source: AGHT+IEG7WegUKGYNIKb/ZK7Dr9QS2s+EViYSCCK4Fd7DabCAMDVKADeOegrxkBwDcFRNNcqWY4kNA==
X-Received: by 2002:a05:6a00:a17:b0:710:5d11:ec2f with SMTP id d2e1a72fcca58-7106cdd9fd4mr8415312b3a.0.1722814908283;
        Sun, 04 Aug 2024 16:41:48 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:48 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Mon,  5 Aug 2024 08:38:32 +0900
Message-Id: <20240804233835.223460-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804233835.223460-1-fujita.tomonori@gmail.com>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
needs a reference to device::Device to call the firmware API.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/net/phy.rs | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 60d3d8f8b44f..bd9fc7a84cd4 100644
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


