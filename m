Return-Path: <netdev+bounces-150891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A102D9EBFCC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C5283E4A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA0195;
	Wed, 11 Dec 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeBH/1BA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8BAD5E;
	Wed, 11 Dec 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875702; cv=none; b=PWYA7XG5cuflZVZ+JVILOuMtZ7GtNfu2yhOGCCIrqSdpycVjc/z6J8Q1/dQRVvY3PktMR+oxuyq4y99WHmohwmPD5MnIrZc13cuTkTzxq7gG0Ki6bXV/8Tw7q5gplwd9tTD7CINxSg/nu/7qq65W/DLBcGGsQNUdc4TtgOQYn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875702; c=relaxed/simple;
	bh=sbIOuSJN32vC8RlW8xOT+xvwoQXmS3mK36l8ACMYi90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW8p1Na+tfVdr7KbuBunb2kwnUuamZOlpP/yom/Ttwvl4s0pHfrIpolPDWy/AlL1N0mUVhdu60IoRVYEI6Rsek735DHpH1TeK9GCzTu5Aa4WVNeanPDT1E+rT6pdeAmjTHo6mdom+Eb+eSFWOoITo+czfWMmlZ1NEyArlNispl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeBH/1BA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4509872a91.2;
        Tue, 10 Dec 2024 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733875698; x=1734480498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWfDJ8uLreZc4qiFdS7zDvZDBlkopaB7TbBYNKsvddk=;
        b=HeBH/1BAVZAc5o1oW6+OdDqD0Z6RxlGyZLp6/FPlAmVf5RGAFKliscJ6X5+b47i6JF
         fGYGB79qpEtIGx6YoYSphWhiEa5dlg8GUcI+TJUUad2FHdJD20xZ/lzkH1gTRp31f3Lk
         G3ExwHxS6ZT0yYBW9VtwmMcqYp7ujUotAwPSWo4z2pJTmWmjxuGCythYeKbOp73varVd
         qZ3XBHNFTghcBPwl1xID0BJ06T37NC65CylSgsuuh+0KOxZT/CBe8InRxNvNgNSgzIRK
         2ZNg4n+Ems6M9Au8X9gBLyzB333cAxLmlStIrGpVup/c7QTYppci/5a1G2uDP6lgWCdu
         nkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733875698; x=1734480498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWfDJ8uLreZc4qiFdS7zDvZDBlkopaB7TbBYNKsvddk=;
        b=wzgcQ92kcdrt7Slrub5Bdj/QsqLYTod12JVcBeEXElJLLkg+Eq7r66oINMUij2flft
         fJiY8kfvRfiha5crXrc2vdQgRj4SHDiohF6R0FIB0yjFK1V7iLK5abiUMeNInizu09pl
         mbYkPs9ZALtdh5E2eaDZwtYYtQQpb/Fhhbufcyia/e2x6vf21aqpXpdAvTw7xprvIATT
         sO7i3TZI5wC0iHGZrkpq9QqZkYiVTCXtyKVw6aRkjZ69u5FeY0mgtVDuxos14p/aSj35
         +2X9TMCnhBWucyfp1yO24z7Jv1g4HdhF/y1KILCb/6XNAzOt5oD8OvauHviK4MJqswyz
         htYw==
X-Gm-Message-State: AOJu0Yxd2BR5OaI8wFEfSYS+geQF7nDqpXn/RGZZIARs8JAnKMRRQSCK
	+2LNUsyXi8vg8p4uLWS1KFNCDgAatJh7tKUSgTbKnMIb4r3lIYXmuZbn7pKj
X-Gm-Gg: ASbGncu98+3rIP6MxwhjwjN3/DuBs8qewiPWw4jCmKABjBFnBpcxunedYbAMLr6D738
	J98tNSJ/uEcNa5yXAXLl+Qr9Yk408JpxNj/cVERUAP2ineZ4Pwgr0PhH3K/ltztFqsWIO9Or4vn
	mLK2XR2e/9z3u0rU3cWQ7BMt6UyVC2nK7ji40fjaEMgZ5QVhEdnUTym3pXo9XPOi8FLmKTDHtcq
	mzQihJTdOBSfXATCzDqzR8b1XrumD3fgA06y2XZ9qFZdC73cnyGK5kO/qny961NUuXjm4D+vzZS
	p5tqks273qeyMz7GTeYVuDsX6xg0
X-Google-Smtp-Source: AGHT+IEKiMYo90UOYfycM73IYnNC37gA6gxbmTDxHtP0+pJWRqjobiaAKk0IaoocnjfD+Zr/fYZ5cQ==
X-Received: by 2002:a17:90b:48cc:b0:2ee:f076:20fa with SMTP id 98e67ed59e1d1-2f12808cac8mr1305085a91.25.1733875697685;
        Tue, 10 Dec 2024 16:08:17 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2efa267857esm4998580a91.19.2024.12.10.16.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:08:17 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com
Subject: [PATCH net v1] rust: net::phy fix module autoloading
Date: Wed, 11 Dec 2024 09:06:16 +0900
Message-ID: <20241211000616.232482-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alias symbol name was renamed by the commit 054a9cd395a7("modpost:
rename alias symbol for MODULE_DEVICE_TABLE()").

Adjust module_phy_driver macro to create the proper symbol name.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b89c681d97c0..2fbfb6a94c11 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -860,7 +860,7 @@ const fn as_int(&self) -> u32 {
 /// ];
 /// #[cfg(MODULE)]
 /// #[no_mangle]
-/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
+/// static __mod_device_table__mdio__phydev: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
 /// ```
 #[macro_export]
 macro_rules! module_phy_driver {
@@ -883,7 +883,7 @@ macro_rules! module_phy_driver {
 
         #[cfg(MODULE)]
         #[no_mangle]
-        static __mod_mdio__phydev_device_table: [$crate::bindings::mdio_device_id;
+        static __mod_device_table__mdio__phydev: [$crate::bindings::mdio_device_id;
             $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = _DEVICE_TABLE;
     };
 

base-commit: 51a00be6a0994da2ba6b4ace3b7a0d9373b4b25e
-- 
2.43.0


