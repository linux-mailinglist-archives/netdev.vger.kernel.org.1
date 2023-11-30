Return-Path: <netdev+bounces-52629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86897FF860
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DCC1C21049
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB758103;
	Thu, 30 Nov 2023 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXhlii8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC610DE;
	Thu, 30 Nov 2023 09:36:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9c581596eso12410571fa.0;
        Thu, 30 Nov 2023 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365770; x=1701970570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=FXhlii8wxdu6UWMfoLbwy9YAWKG0IrWTn+8mVquaapSWZ5pCHG++Xn2Gf4TXoi8xCV
         QERC9iXlb/pCgfkye/KuNZp4lBjpRWLzDU64u3lNXgCOWRG0M6aXudLzOohTlL1SuULz
         wa7f8eCUOARXxBrx9YcqPzv6vbPLWeFTTubNxlqseR4pSMjeVzkXjEFC5OuWqOT3TML9
         C6a/zHwQdkLceJEgQ2TsRv7nZhX4wlJiD94eiUyg0anZLk4UINQ4ZfpQYjMuOBgae9Al
         ONmCC8ISBwnSA1c2za6LzD+lk94qyDk0CWKAf5+d9sQ3W17GQFPiEt9TbtxcZp9TIWQm
         bLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365770; x=1701970570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=lnophehNy3DW7QtJGb+fdLRSkb5HTkb+CFQoWiCRNXmxSjCQh8w8op91SdYvUfOB9U
         uIcTdqsgQt0T8Y/GrNsoAEnLcNQBN4LUv1IouIwluE7CXB+Zuk6mFXlhdfdM0fydUxnz
         ZevpZBNpaucG5RiAXQpCjMNb6zUePjB/JDpQNw1CcNPTIAANeJ8fUvHBc1MrFUBJrC0O
         NGIDMQeLRbHDC6U2+UUGfqhwY49znJvktBIxyo85+T0FmgdZwSPCstf5Fr7i0h1lJw11
         w+mQw2yX0HBRQAm2o1MQldCBk1AtHmCBQPX5tx7pFzjvErU8Zhba5DQ5xOCXIUjxlege
         5JMQ==
X-Gm-Message-State: AOJu0YzPnYOUftGWzh7D1sQKPV/2BZJ6ZvihyyR8JdPzmhsOaDWielrr
	2DIDvgI1wc9ABVtoIyuZTQYL1TBJ/o7hqQ==
X-Google-Smtp-Source: AGHT+IEH3aE5eS6ftNn2d2BmNGm3H6Ds174WE21zCh7T1saReTQWKhg+KAotgV6WRJhkO+GrT5dGlQ==
X-Received: by 2002:a5d:61c6:0:b0:332:c6cf:320d with SMTP id q6-20020a5d61c6000000b00332c6cf320dmr9311wrv.15.1701364245087;
        Thu, 30 Nov 2023 09:10:45 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b00327b5ca093dsm2014531wrm.117.2023.11.30.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:10:44 -0800 (PST)
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
Date: Thu, 30 Nov 2023 17:10:14 +0000
Message-ID: <20231130171019.12775-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130171019.12775-1-donald.hunter@gmail.com>
References: <20231130171019.12775-1-donald.hunter@gmail.com>
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


