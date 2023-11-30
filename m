Return-Path: <netdev+bounces-52713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E287FFDE6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C31C2102B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703B5B217;
	Thu, 30 Nov 2023 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYjzCCz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F70170D;
	Thu, 30 Nov 2023 13:50:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3331752d2b9so1038635f8f.3;
        Thu, 30 Nov 2023 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701381010; x=1701985810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=PYjzCCz72Z5erYIfmzufhkvd8J2+PthMC++HCnHKiustQsA9DHR4GSmR4PkMHZB2Kd
         wT5tzCQP/Paovh0t3eUmWtAj9z1u1fk3DSKPdmRIAmdq7/3wpND24BC4pQKsa0aHVG62
         fG6T61JaEJ6COnqcPuZR176PDQsft3aScyr1syQqeKTtxWCF7Ub+nOe1wVQM80jSeRsU
         EYhV4p5ZvPDwMJWN97W8rUXhskvbWDfT1OKWuOuyowH7NeCDMOp3eu91n2i3e61lbD+s
         CDnu20V8NAJDpoHqlP2QYCv8yGVj175gmm4QzOXQ9th6jOEJsHJYXlK1QJFGinlCKUyV
         fEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381010; x=1701985810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=PERyq8klADh74u5zVC4PRhVASkella4IJ4DVdJTO9ExP7IV69vlcn9+l8XKV0vb0Cv
         mRfz2swLmxebkBsr8UKToXiaoEbDE5NZgYVYW3KLg252yAD7mZ67NHjz7gQCHYSqVsii
         qL0j2AvvtpfxCTKiD3s5Zp5FndA6C76We8ZiRtdFTYBOG1JwBDtUYYSblxN56j+k0QJD
         3/78tipB5qSUTr84iR/Nx2gw1h4G6nryyDkJRdal8UfelQmOf5xUdTwSWRrp68bAk5Wu
         g7skgOsaPodBXZdKbsfndjBVXOA3i16Rfy11q6wVIZwFxuc5cllzBWzE0Ini6FHz2VCd
         5fRQ==
X-Gm-Message-State: AOJu0YzEO3TjT2nlc8lTQG5Ahi3qpkUDSGiYnIARzhOwPRgs/rpJ631g
	UmBtJytyg7r2QBB2Wdo9ntnHU4Do/R7fEg==
X-Google-Smtp-Source: AGHT+IHGWN2kldrh1QVyGdaDaSgTW4BeJF3Ub8rvJWGZfLIdV7fvYWwpItJ+4gO47Iy/v923b7CCdg==
X-Received: by 2002:a5d:4d0b:0:b0:332:f495:4fa3 with SMTP id z11-20020a5d4d0b000000b00332f4954fa3mr175249wrt.29.1701381009740;
        Thu, 30 Nov 2023 13:50:09 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id dd10-20020a0560001e8a00b0032fbe5b1e45sm2519237wrb.61.2023.11.30.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:50:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/6] doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
Date: Thu, 30 Nov 2023 21:49:53 +0000
Message-ID: <20231130214959.27377-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130214959.27377-1-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink-raw schema was not updated when bitfield32 was added
to the genetlink-legacy schema. It is needed for rtnetlink families.

s8 and s16 were also missing.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 775cce8c548a..ad5395040765 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -200,7 +200,8 @@ properties:
                 type: string
               type: &attr-type
                 description: The netlink attribute type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary, bitfield32,
+                        u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
-- 
2.42.0


