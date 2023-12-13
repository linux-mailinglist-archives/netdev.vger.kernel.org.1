Return-Path: <netdev+bounces-56680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC778106E5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FB01F21745
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66466101;
	Wed, 13 Dec 2023 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcYMtJiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA35B9;
	Tue, 12 Dec 2023 16:45:37 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28ae1de660bso51638a91.1;
        Tue, 12 Dec 2023 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702428337; x=1703033137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtjAVFHEUj43HM8M/oEcvmd1M30Q+DedQSYqnN5Zak4=;
        b=lcYMtJiJ7R89QSjXBxhCnjWwMWP5Rk02e4Qkql3Sx4JfTb1I0HExnC55OB1AY4MMOu
         5UyXUKuIzU38HHKXQviW95R+GG2Xe05MMn8CTcrRopqY4cNn+dlDgFatUfqQ0BBB7gKa
         J7ooBGKFZ45cvQjzRtk+eYqFyLT0vPW+TcuDqsbuAIvyMix5AcYAD2R6tHzor3UihNSo
         V2VN+MnPEZt5L+RFH5UITIl75F4Nnq9Ny9IT10Pau+d/L7HPUFiD3khP2wedhXJB71gu
         BKEzy2ywmVCZaAwFoluwxW7AdbRaa4iHAE84KyLk22Q1dgKIXYyI518Yp5/HNi28Hyqz
         me0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428337; x=1703033137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtjAVFHEUj43HM8M/oEcvmd1M30Q+DedQSYqnN5Zak4=;
        b=CSoYQb+6DkSoQ3HANB1qj3XmNkfjT3eQDvSZvNLhkwdhgPbZ5ANMHimxthVqUrNWry
         cK3r2hIwKhoav4ulVL7TbpvqOXRcGwH+3j+AqKuta7mpjD2ooqoG8yavKiQPTlg3Aegq
         YYdG/Yr3dTSiAHL/jU9UNgSsDh15iy5tz75aR/0PdZlSF8vnb4r+G3hc4X6X2eWOoljf
         NkXhcWhzrsTK1UVm8PWggSIBCIekoxi3uFlVSl6TGG+6Y47unZxqC0bw5GFeHV/+Tvyy
         w3IkavCtWNngmw1YJVpXRbqLHNXPkr3398XIFfChQITiKf8lS3r0qHvwXi99APPvO87o
         SqpA==
X-Gm-Message-State: AOJu0YwPc/goAi7COQgxxTDY4iDw9hmmmuul54K55IUiZn7fERNFlv0G
	+xF4NJRwGG0IXu+E626PhTr6suihdH5g6iyt
X-Google-Smtp-Source: AGHT+IEGVRX7WzfvSMokGpiTInzS1z4eHzFEyCL6S9e70nfPplIPcuaxScSB3jyFbPXbzKmV4X7BrA==
X-Received: by 2002:a17:90b:3909:b0:286:f169:79f1 with SMTP id ob9-20020a17090b390900b00286f16979f1mr12374065pjb.2.1702428336705;
        Tue, 12 Dec 2023 16:45:36 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b0028ac1112124sm2031130pjb.30.2023.12.12.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:45:36 -0800 (PST)
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
Subject: [PATCH net-next v11 3/4] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Wed, 13 Dec 2023 09:42:10 +0900
Message-Id: <20231213004211.1625780-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
References: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
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


