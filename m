Return-Path: <netdev+bounces-50370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA17F57AE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6726F281754
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3246C2D8;
	Thu, 23 Nov 2023 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYgtwxCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A621B2;
	Wed, 22 Nov 2023 21:09:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51f64817809so91146a12.1;
        Wed, 22 Nov 2023 21:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700716195; x=1701320995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frRlW7PisUvcKFfqyeIkT6OJIouietDrjHix3ssG8Gs=;
        b=nYgtwxCPQT9aOh87IcSsVdxRYhQJk/zpmH4te3rXWXM0gBkzEDmOcM4L0hUs4OrpIH
         hcGM7x7we869txQKmGC4fMO9scgqOfs3wu9GBmQkZtCPwXCFkc1UCTSW4VmJzNaAxn7N
         gbfoCscE0TKG9PytSl30+IgxJdq66VzTcI/uJxTO8jn5xqCGuxv+ej17yXhoV7Sep8ci
         3gw2LHQxrrDEH+AAcySZmMRD+Az+xQqhRCBnjBBgRKwYhq9AI3kKHrNrS9GGZcWaqywC
         vTUMrNzTo8bNqxpkDJBrHnqBf58qK86N8dwj85MXciP+UEgK/iaoKxzzlFNSLsPvYETS
         LGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700716195; x=1701320995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frRlW7PisUvcKFfqyeIkT6OJIouietDrjHix3ssG8Gs=;
        b=pLaCSA63sr9js0WBDHwWp8+O81razIQAiKHRhoGsIAH1c4L+CwlIJfk4hF5NdT53O4
         vDGEI5z+QD7hmlzY7db8QJsXBu80kE24Iw1mrCagAmuxQJQ59X3RfLWI3TEaJEPth1EF
         dqB90d8bV1mQvEgIxVDEP3kK3MeJ3esizJO+rbKc8Xlpl5mGqwuTJzn4k0VWJgU4Jsb4
         atOiVPpFubLCQ3bQZef3dkL4Nvpzl7sRqzD4P7h1RrG9rlbFNAlJXL3ymFHYq4uHaxVP
         /7xLHAf9KC7BMSV0KCgjmsW2Ek6N6SEf1VcUQPzr990LcV6vHqYBpAcP4BOhXP/UEAWD
         b3Hw==
X-Gm-Message-State: AOJu0Yzmtcw3nOQ1TM85P6B1sQ5qhJDXA37VSp6hR/7TchHJLd/Ir3TL
	OR0re2zDt6mVNlxUDWpkT5eG6rQpHe1gzQLH
X-Google-Smtp-Source: AGHT+IE6v0JGMR9enb/vBjn8SAfy9PsE7EbosMR5zatKnWKXQeyBf7O16Bu+JIc+Hc/Vvb7tQuQXOw==
X-Received: by 2002:a05:6a00:1ca0:b0:6cb:d24b:894c with SMTP id y32-20020a056a001ca000b006cbd24b894cmr3539872pfw.2.1700716194711;
        Wed, 22 Nov 2023 21:09:54 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006900cb919b8sm347734pfi.53.2023.11.22.21.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:09:54 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: [PATCH net-next v8 3/4] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Thu, 23 Nov 2023 14:04:11 +0900
Message-Id: <20231123050412.1012252-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
References: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds me as a maintainer and Trevor as a reviewer.

The files are placed at rust/kernel/ directory for now but the files
are likely to be moved to net/ directory once a new Rust build system
is implemented.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 482d428472e7..49ba506fbc3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7929,6 +7929,14 @@ F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
 
+ETHERNET PHY LIBRARY [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Trevor Gross <tmgross@umich.edu>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/net/phy.rs
+
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
 R:	Kees Cook <keescook@chromium.org>
-- 
2.34.1


