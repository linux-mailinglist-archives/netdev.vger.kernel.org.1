Return-Path: <netdev+bounces-53709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD998043D6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895EA281265
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADB184E;
	Tue,  5 Dec 2023 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNisPZS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CED111;
	Mon,  4 Dec 2023 17:16:19 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58df88683a6so319660eaf.1;
        Mon, 04 Dec 2023 17:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701738979; x=1702343779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIxki5ebOHyftGQ/c29kSL0t6c//h1lA2X7sh3QCtfY=;
        b=fNisPZS+ngA20fn7RvxBmCfBkc+OK0r7jAAebW7MBP6n2W50l3tJZEoHNiFzhSYSP5
         k1hQIDlDti/QSBu/9Nt2JEz6J9ppcUOVsZMawhv4PmIgTQfvvMaJ4mTKXlYBJgL29dYG
         1SgRboyA4Jhjs9kUx03QBnkuq6xTpTW73M4U6u4Pz5AOVm1T1iLd4jMiqFNo6oKTh4Ao
         Lfl2PB4bHSXVUrJHGzggov+XKXWYzHvSLjc+Ckk1UQFhg4WlJ+Mn3ou9oQIwpzaXR3yT
         3MZH+fN1tTy118tUOuScLj7X8SBYPeNrzAPy7NGO0T/JGa3ky/VM7j/47KbaEDwKqk8u
         mnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701738979; x=1702343779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIxki5ebOHyftGQ/c29kSL0t6c//h1lA2X7sh3QCtfY=;
        b=nUcysN4ybpjQL1K5l+JZcVsG1TCP2uGyq/0z4OHtzIT3TyXB5PYfeUKMvAXZD3UHP4
         /QowV6T+O5ZQHkRpobaNMD3MwUJZzOjJuyOQvxz6/VgALETuYcpsUW4Lye5bjh0xD44r
         1CDRL7XTX+wBckW4EZRi2TYylCY1N4hk9eMm276cJJDN/nx/04O91pYzmKNdtBVpO3no
         yU/c2PEME205FfZsOjlgiKHh/uM4aB49PJ3hbbliaUiHoj1ccXUzDMv9LSUETKqXO7Yf
         XFTdq6l0fMAP4OnFIbus/w8+KGYCg4SN2U2z084yyUKkqkixou0m7mpV4rIK6j4KOgL1
         erhg==
X-Gm-Message-State: AOJu0YwZ1uMX/wVUxzYLZIOslbuSJ71IQ1COhbWi6dLi/1zCLBM5O/0/
	HwBe6ocQewgpcESb3YCxGgDkKZwghYx2HJZa
X-Google-Smtp-Source: AGHT+IGONXX9dE9M1+rVVy/bOzsmEclkdVwpMUw0038TEkioWAIN4llJUocXptWVL1+7SYLN2bTFxg==
X-Received: by 2002:a05:6358:91a4:b0:16b:971c:98bc with SMTP id j36-20020a05635891a400b0016b971c98bcmr34147627rwa.2.1701738978850;
        Mon, 04 Dec 2023 17:16:18 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm89337pfk.99.2023.12.04.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:16:18 -0800 (PST)
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
Subject: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Tue,  5 Dec 2023 10:14:19 +0900
Message-Id: <20231205011420.1246000-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
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
index 2d2865c1e479..0166188446ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7922,6 +7922,14 @@ F:	include/uapi/linux/mdio.h
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


