Return-Path: <netdev+bounces-114390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F769942559
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6953B23115
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164C28DCB;
	Wed, 31 Jul 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7zcXt3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6362837A;
	Wed, 31 Jul 2024 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399741; cv=none; b=Mht6ApiUodGHM0kh7hgpj6wfuvdIsxA5CPNFfq6+qbIqPj+5L3w+hJ+VbTKNPRZOuo9C8Rt91Jby8JDa4+pW2y5e2g8tZXqZo1p9fz1hPw6lqb0e2lKHbkgeL33W2RrpSKL9gnRjeeQ2/Vwf7d9XIVNh5DS5ZiVxjaRCyUK642U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399741; c=relaxed/simple;
	bh=ahSIr+s+HFafuqHmFomDqxGTzxgQjRqCJVh28Ds8if4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqfYpOLwSNnnWhFCN6a/V2XXSybNV3VXKUDYnak+Mn9VVihsT/km2j9TUrPOpPOMt+45rC1GuCsm3YSIosD3BdFAY6H4ELIgHUwgqq+NE8TY6J7vuuOHuLm7obah9M2m5FUz1N2R9MBB//oZ38VzvhKtOPIFAufbSG06nrdEjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7zcXt3b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4c33e746so2198975ad.2;
        Tue, 30 Jul 2024 21:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399740; x=1723004540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++YyWS0ASZfx5tTOkdNTrEJa6dMsI1hcaYHiGUePSXg=;
        b=K7zcXt3bO+fNHymk+a2WGdVgH2hwpssNBEXKViSh7svtdxpNIsjMgIfwmAXvvYTYWv
         4eGHksHE23mphgfPkPlxYC4VjD+D//o4Q/Yodqwu9HK4yGJi7Aww3t7L85In/LZ27MtR
         OH/n5ocwtA3mxZyfEkaUfJSd1LMW3DQMkNJELeiHW2x60jtrwyUp7XnKdB0mqcygaD9i
         nkt6W7nAjGDKJ1jVDMgxkV5P9DfIkSl9CZFYtun7ytUzRAF58fTxoRgCGzu3p6B37ttV
         9gwwPORPzJvIToh0rIkRA45I6m8KEB/0FmnyaoD+Rx2SJDrvHQIeSz4Y0uUrzZkQeBRB
         ZuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399740; x=1723004540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++YyWS0ASZfx5tTOkdNTrEJa6dMsI1hcaYHiGUePSXg=;
        b=sR77xB1ifrMeYLrOubiBHSm0TC02DXnOIq04KCLOa29Zc9BYiIUuu4mkT7YHI8XI4a
         jotqOq0fhDEDf3ZasUWPTOxefm6uyrd66jQSSMFc5TlKYvSbTUGgK3JEhEYLqvvtt0Q1
         T90e5BN4AD5KKjulALqR0RFbb5PKEIt5VOaUhjOOLHZlgccFjfEXj1vvDc/324aRMAQQ
         X8GrM74pxEH1mZhoz9gQxZmS4cQ1prjoE2JYfWNfe64h2xXOBwN0RoyciJnJb799UN2p
         /4emSOt2CoRxjxw7g82KElKDlTkLnto79PUgX3JNjDmWhH32lcTqgZ2RWOlpBzGZ+3BQ
         qxqA==
X-Gm-Message-State: AOJu0YzyYCNQKHo8UI17vBGEj1lyIzWRYDhKRPM+/CUyBu4TzP0u0dzJ
	R3J0OTgRi3ptj5BPDDrx/5JsQ8DjnOor+ncFeNW4f5YzRykflkr+XDUnnWvr
X-Google-Smtp-Source: AGHT+IGHwGPvLHH4EPv5bTuhQpCPmX8p8qUUcDO+WODWObp7QX54XRv5jlqqHIrSNjQT8/4yvWzo7g==
X-Received: by 2002:a17:902:e546:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1fed6bdd93dmr122477485ad.2.1722399739559;
        Tue, 30 Jul 2024 21:22:19 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:19 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Wed, 31 Jul 2024 13:21:33 +0900
Message-Id: <20240731042136.201327-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731042136.201327-1-fujita.tomonori@gmail.com>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
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
---
 rust/kernel/net/phy.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 99a142348a34..561f0e357f31 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -302,6 +302,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
     }
 }
 
+impl AsRef<kernel::device::Device> for Device {
+    fn as_ref(&self) -> &kernel::device::Device {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { kernel::device::Device::as_ref(&mut (*phydev).mdio.dev) }
+    }
+}
+
 /// Defines certain other features this PHY supports (like interrupts).
 ///
 /// These flag values are used in [`Driver::FLAGS`].
-- 
2.34.1


