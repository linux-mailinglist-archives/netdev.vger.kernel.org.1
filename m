Return-Path: <netdev+bounces-52083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF87FD3AB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEC6282BB1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F5719BAE;
	Wed, 29 Nov 2023 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQqEkhOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B2E1;
	Wed, 29 Nov 2023 02:12:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b552deba0so1659005e9.1;
        Wed, 29 Nov 2023 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252753; x=1701857553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=dQqEkhOietnylAHFpZT20w/7wqjDEd6b8zJ9ehzDOTJzUafR6esy3519bDxueMum0y
         T68Xn19Gmyuy30p2rQCxFPN2x9LD7qGF0KnT9Lwx8qezeJUzzs0bkOy/DJRg8cIfi3cD
         8XC3AAQXr/JeD2KfWarmSsMiKa3f2lbd95fBwnxMzwCGh528gdLV3CqAOev4kSdmlEkt
         46NpNBNuKFXzfbWpLeYpaSNZroZH19t4lf9u+Bl9Soa/wAPVnksI4sB8Oemdz1C1JZY8
         715Kt2f2GES/l9H89LfAI/GrVJXzHCMVBAdPV0UL7UH5Vb9am4jhr9Oz9mcUuLZNSdoG
         AI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252753; x=1701857553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnVO+XG5c6orDmPhNlnDUKCa0vfQLqdJ0lxbJhkoXw8=;
        b=g8b8JAsVZ2RrM2LuCUjN881ToxXoADFsi6GSjhEw8YOD0gqIV2dj3ThredCYhx+gdH
         MTNwoEr1GO2kXqnAmh01Yik8UMzOlOQ6cJeoJuRuMJIJ9AcT4gCXiGC4OqKE+ynAnTVx
         iQzxbtctC9JMlhPIMtlShVtPCeEmHMserVwkkQm7O3/azVBf9MN/VRuHwKOHU7qxPIO5
         EoGqBr2HjTMk/yGkPvgYbddvlu30++BDopjDMCdEg5EDjXnOHsx9YyBQ7O89w3HKDKBN
         yLHTatjo9x37XX+AO5dk5RZ6yh6LWFVMntw0ma289dQag+ndaxZjIwt4C5JLy1dV4/Js
         GGNg==
X-Gm-Message-State: AOJu0YwqSh51CPZczQfQ3LT1/bzvGKEug6fH4Ly/eBhb6jTPsyAnu0Xi
	SU8vVHmDv9m6uYz6BROyXeqe1klQYJyFtA==
X-Google-Smtp-Source: AGHT+IHiCiTnro+tWPMZSmaLUtqWNNA9LWwe1Pn+OOPV8cN6cElVkDBwZrUwYvHhKRfpFgIgrqgAkA==
X-Received: by 2002:a5d:5045:0:b0:332:f895:f58f with SMTP id h5-20020a5d5045000000b00332f895f58fmr8178889wrt.2.1701252753016;
        Wed, 29 Nov 2023 02:12:33 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC PATCH net-next v1 1/6] doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
Date: Wed, 29 Nov 2023 10:11:54 +0000
Message-ID: <20231129101159.99197-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101159.99197-1-donald.hunter@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
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


