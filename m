Return-Path: <netdev+bounces-114388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBA942557
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE81F24542
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDB1862F;
	Wed, 31 Jul 2024 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3rdmy/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC51BC2F;
	Wed, 31 Jul 2024 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399737; cv=none; b=ePTZeSZtRSHhmIcz+rNygoDDdzUPZD+30ZuamnQWAfx0jOK5qVyeWpQpph5L8kvoLywMNMn4w5vqdCm4BW2XINqPraM9ac9bH8tJqgcW8uFlES3YjWjVyGhEPnY1mzQYSjrI/DdRKJfHGGw+alWOvTbLNUWhdd0mYHBh9zuy2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399737; c=relaxed/simple;
	bh=u6x2RbCFPVeM+mpRyOnx37NMTKi8eStfFxkcFAoGOIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/ma9JqOmpTiCM0k9PEUIl46yuitZOSbnQ31JTa7OjwB+l420JB61JmaxonTbj1VxekCepIK+jaIbkXMl7PWM6iWHJAnG/qbhZRv/kEJDjstF/w0O+PRv0BpXwHglCek8XXKOHLv6vriSwWm8+Y+8dxhsOLy/h4ejf+zhAYJDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3rdmy/N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1876e748so593566b3a.1;
        Tue, 30 Jul 2024 21:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399735; x=1723004535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSEvqBNPkZucSUo+If8vG9EYTsL60DjHY8zUoaiuJlI=;
        b=H3rdmy/NGRynYyJTNaJgJdYIa7LVUwNIMquEDMzsBT9sr4B6DLWFuu3kZaJ+7v7xN/
         cN7VEZlY9yMdfHljjp1DpR3ESII9JOJIMSke+YyHbVg6LDj1MLWRn5KqCjHWR2uwWRbf
         uHbtvlCJ2Spfm96MHRo1E0RJ5t9Zkap2u2R7YCEEkhCBtjS0iRmlGxxY1XB8Rxv659NK
         P8iIpqhuG5RNZeqdjpitdq5ej/GL0ZWwxDT0sQXTd9tAmnx4IAELoUIBrxvnRmOY2Fm+
         mK6IHjgtAlNh3PReA/WhAqpcmEcBeGJSGKccnedi0bOChQzyxIlUUV+bug45mp1GU4sW
         ye/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399735; x=1723004535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSEvqBNPkZucSUo+If8vG9EYTsL60DjHY8zUoaiuJlI=;
        b=xKzmi3Jtbcq0fst4EV7IkdWNk8obiQ+ZVyuQRSqwbzrOVE+8o6Wqod4zj34TAmb+mE
         5HuUKCIvQfscZ61u4vZb/AG1nX4zTOrXhRdIEeDxTgZvc2YwcqqEln/o6kGPGRboMI64
         d1LpanRbT0s+qzysE3Z3JkI3lsaEOg/uvixOKXuDvbe/iYTlWbLeI+BMGF6g5MIPCbAs
         7a/mWKaayg1chsldqIyINgkv7/fLTEEU+28f5e6HHz7Xa/HaExfe4vf3kl63wJdY1+H0
         ocwBUKI0IxOvB4520+ORnasMFPlpYhY2nQOtE/VJFTg78Ttrv+2rhBZ/nzj3k4D1LZFP
         YJhQ==
X-Gm-Message-State: AOJu0YyXcf9y/B5NeopRg8rFhiGZXhFEVVQYwIWnNeWsIDCQqiAKAE4X
	+dCWHmhQ785JoDUs9KmZRfpbZH//KK3YL7Wkm8brfnMi6gwMIxShv5yY/Z1H
X-Google-Smtp-Source: AGHT+IHY/6NRoT7XbYwXJCKgXKDyrhku6w27jNf/ZsVXBkI8TwKBCTBtSQz5XuE7pvQ7TBntt20UPg==
X-Received: by 2002:a05:6a21:329e:b0:1c4:c4cc:fa49 with SMTP id adf61e73a8af0-1c4c4cd043bmr6950858637.7.1722399735254;
        Tue, 30 Jul 2024 21:22:15 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:15 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 1/6] rust: sizes: add commonly used constants
Date: Wed, 31 Jul 2024 13:21:31 +0900
Message-Id: <20240731042136.201327-2-fujita.tomonori@gmail.com>
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

Add rust equivalent to include/linux/sizes.h, makes code more
readable. This adds only SZ_*K, which mostly used.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/lib.rs   |  1 +
 rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 rust/kernel/sizes.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e6b7d3a80bbc..ba2ba996678d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod sizes;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
new file mode 100644
index 000000000000..834c343e4170
--- /dev/null
+++ b/rust/kernel/sizes.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Commonly used sizes.
+//!
+//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
+
+/// 0x00000400
+pub const SZ_1K: usize = bindings::SZ_1K as usize;
+/// 0x00000800
+pub const SZ_2K: usize = bindings::SZ_2K as usize;
+/// 0x00001000
+pub const SZ_4K: usize = bindings::SZ_4K as usize;
+/// 0x00002000
+pub const SZ_8K: usize = bindings::SZ_8K as usize;
+/// 0x00004000
+pub const SZ_16K: usize = bindings::SZ_16K as usize;
+/// 0x00008000
+pub const SZ_32K: usize = bindings::SZ_32K as usize;
+/// 0x00010000
+pub const SZ_64K: usize = bindings::SZ_64K as usize;
+/// 0x00020000
+pub const SZ_128K: usize = bindings::SZ_128K as usize;
+/// 0x00040000
+pub const SZ_256K: usize = bindings::SZ_256K as usize;
+/// 0x00080000
+pub const SZ_512K: usize = bindings::SZ_512K as usize;
-- 
2.34.1


