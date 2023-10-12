Return-Path: <netdev+bounces-40362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A327C6E94
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E57A282B11
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86D29409;
	Thu, 12 Oct 2023 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/SffTU1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170427712;
	Thu, 12 Oct 2023 12:54:29 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB671CA;
	Thu, 12 Oct 2023 05:54:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690f2719ab2so201282b3a.0;
        Thu, 12 Oct 2023 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115266; x=1697720066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9knpCT2/E8qoV0tJIiNVtq1TRrrBJ0WpjTGyqizZQA=;
        b=G/SffTU1F1YPnqwYkelyBv2GxcOzYvAkz17hFzlarFL8ZmornK0hUEdYiQki9aoyv9
         XwSlbuRTkTprEpPELwpwqbiaU4I9URIe5/hUhbGE9ql/cMCXLE5ZoZPnnNuiKcXHEyDn
         VWUCnfYQ+CyM5L7YXZ9B2UHxgLaXmBFrWGWLKzSsoqDbvtHLwddP6XlHSA6t2+qAnS/M
         VFhlCfrQHjY+A+KGmfUaT3kTDr4PTdxtu6M/8X0+hBlm36rWK12QqpFj6j0R6hpc+Ge4
         9MsHQlof5xFTV3/1q9uqT1HWzzDxvHqQJZ5F0Y6T+Mggpq/6hGmOBLzlgPHkKJ2PujG+
         N8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115266; x=1697720066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9knpCT2/E8qoV0tJIiNVtq1TRrrBJ0WpjTGyqizZQA=;
        b=GjuKyRnGC9ylGVomyxci4klE3L56kWwPzyutJlUIuyGncvIU/PrT/25IZanaOeDjAA
         4jyS3IrphZiP4kZ2sR6rpuCuJUd5if9mcigmkP9+oKH1Pae1xk/aiPwoeTY88ACcu1Sd
         oRhRIKAHhmnD5pnA45l0N3ENxrbBR87qc541r1I7GkQQPxe36Aga7rVpaKzTZQNKk2jX
         leK/iHFxJhKkWQbeIDNRemOlmVAJzkSLltPurDCWY+FvmZ4D3jHs1bmQIzAnEnI6m6wX
         7S0Yb1jV2/q0EkoLaf9Tu7UO6Cbv3jtbzCjrsRQueCrHxNt7VQwXCMRjU5Qjan1t5tFi
         ptUQ==
X-Gm-Message-State: AOJu0YzEp43QQ57EvXGaNg6dhOyOHkSkxFZoI/TMWaJn33opPg9DF+V8
	SFO2WCMVQE3MbM9AiblUC5rd4WhCJjtm84BW
X-Google-Smtp-Source: AGHT+IF9GjZRqL6VXo2Q5x7Mar7M+G73NMHf4Se7hFUP7ed8z5yUAjSot4NnJOu23dO20eomLa7ekw==
X-Received: by 2002:a05:6a20:8f02:b0:15c:b7bb:2bd9 with SMTP id b2-20020a056a208f0200b0015cb7bb2bd9mr28500413pzk.6.1697115265806;
        Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001ba066c589dsm1886857pls.137.2023.10.12.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
Date: Thu, 12 Oct 2023 21:53:48 +0900
Message-Id: <20231012125349.2702474-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adds me as a maintainer for these Rust bindings too.

The files are placed at rust/kernel/ directory for now but the files
are likely to be moved to net/ directory once a new Rust build system
is implemented.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 698ebbd78075..eb51a1d526b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7770,6 +7770,7 @@ F:	net/bridge/
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Russell King <linux@armlinux.org.uk>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -7799,6 +7800,7 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
+F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
-- 
2.34.1


