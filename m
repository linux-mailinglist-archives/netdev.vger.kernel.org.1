Return-Path: <netdev+bounces-55658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAB80BE5E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC701F20F35
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E71F93C;
	Sun, 10 Dec 2023 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDckM66w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D7F1;
	Sun, 10 Dec 2023 15:50:23 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so676820a12.0;
        Sun, 10 Dec 2023 15:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702252222; x=1702857022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtjAVFHEUj43HM8M/oEcvmd1M30Q+DedQSYqnN5Zak4=;
        b=bDckM66wOobSmYnNEVIu6PBiN/FwCeqbzgl64/S+42M8EG5XxeWvuBBfgiSPtnanqj
         M36Xqw8iR8L+/LxwYYMC4+939gjRbK6Tl5B1QEPOPbzgPzX8gPn06FuezgUpVY+177an
         9FHGzm/tbojj5onVOaJizxIPhHwBwCGlq/NxmiRUsJGyndsxGBjEqQdSTpbOqv3rtbed
         gbI9E4ZcWdHPVyouvj0axyigtsdvW9m/eWEd2i/XRwNlDdP4pIHh2yrCuFTzc0YpYTPZ
         DCJEcgN5Cuf3cYgca3RTG/ynCYDVLf6iSvCkJIL5yOwqceQTdOjo2ZKeubFEDCm7DtAw
         DMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702252222; x=1702857022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtjAVFHEUj43HM8M/oEcvmd1M30Q+DedQSYqnN5Zak4=;
        b=GfvuyFvXGBYVPDppcFzClEQY8/rL0nViIdVa/ok3u1HgUr9bT6w/uuZY30Tx+rSHvZ
         YEwryLcdDnsfLoOFdTd5yIdGoXz5nurghdVlTtHOJryI3rAQrvDoE8MKCn0QAQahvNlF
         PElLUhazZ2XOAzduftFylnWqk9kkJ2f9oY2d9cYyqUntFY+2g5QMUoR7rFid4/JW28RF
         KZY9iLLtdW1/qu6cthK7jGlVC1Gqw6EeqPy23qj6DxStY3cV1NefiFS/PgiCPD51o/8n
         gVLZNj6LIkxeIhym5ouyxrrSXVko2ecdlUqpaJps37mXYcQs96xeAbXOor4ga3nxRx9/
         WDTw==
X-Gm-Message-State: AOJu0YyhBNtjuA7EcbI6c0Plsr7KN+Se6SpyGBl4qxmEBI+le+F8ox1f
	4dJ7KBof8J1z+sSerywE4RKRi3kO1aGfKg==
X-Google-Smtp-Source: AGHT+IGc2eCMby8Eq4Q14e7cr9xL5a/6/2Al5MgpuDaO4RydayK8Qo+ocndybDxnutnMs0Nv/C3/Zg==
X-Received: by 2002:a05:6a00:9a4:b0:6ce:3918:2114 with SMTP id u36-20020a056a0009a400b006ce39182114mr7917558pfg.2.1702252222185;
        Sun, 10 Dec 2023 15:50:22 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006cef6293132sm2812878pfl.101.2023.12.10.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 15:50:21 -0800 (PST)
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
Subject: [PATCH net-next v10 3/4] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Mon, 11 Dec 2023 08:49:23 +0900
Message-Id: <20231210234924.1453917-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
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
Signed-off-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fb66210069b..089394a0af2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7921,6 +7921,14 @@ F:	include/uapi/linux/mdio.h
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


