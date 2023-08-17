Return-Path: <netdev+bounces-28597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3F77FFAC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DBB282187
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD91BEEF;
	Thu, 17 Aug 2023 21:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A81BEEC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:15:39 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA335A9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-564cd28d48dso241382a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phUiJ93OG5fT2HQgeI0x27DBfVFvmCA05DOo5t8M3F0=;
        b=m13GfLSVElpoUlkc8XTfd2EAm/nFZIAFv5nYubhdAXg39AjnARc8PDqRRwhZ7nFuMl
         THmkcqR9SondynXpKqbAIqxO5ImaGw85uLzxTZpc/SMsVg7BpStQ00iERACf6w/Uaz1H
         +HeZJOIfHkfhzg2I/Y98/HcqNNILtGguIkQO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phUiJ93OG5fT2HQgeI0x27DBfVFvmCA05DOo5t8M3F0=;
        b=EYEw178gnL8o4b4pEYuu1MBBDKbw0/hRkow59oy2/BddAhtN1Xe/4sks/spj7hWHpo
         MGZY3u+kyDaUsppBTCbpGgBsLoFuC85uUh/C2qNTRKv7eHqMN5pRssPViBMikmHGpuHI
         0IFsHYqSoVvnG8kAIdqCE5kqq2XcRu7Z8eKMAzwQ3VZQ85TAhnQGC5xE2R5Dna7J6DyQ
         hdJr/UYjaS/oM4+nCprLd0ITciQ9TO65PFSV4GwuGKqsxgWIuPIp6AnyvByA4VX03+fD
         HPJIx28CLa6BVTsKhyXrMAMYE8RCv+6g/zZMoUSpdD/BdkyPbfnXFUmgTkgBbguhoNyj
         eqhQ==
X-Gm-Message-State: AOJu0YxYBz9ryhZW1NwV3e0vlULwWaB4R5jM7LbpnzDcivxPjlbYPe9m
	NRKPSaFKg5t+6EpyWasJkdS21Q==
X-Google-Smtp-Source: AGHT+IF7s+IU/lIpVVTRfA7A1qbIsiivth3Da3IhciHPIQm6pnVUAKXy1L3JsiXrPdjKSQOIbfeQaw==
X-Received: by 2002:a05:6a20:4420:b0:131:f504:a631 with SMTP id ce32-20020a056a20442000b00131f504a631mr1181516pzb.51.1692306937174;
        Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b00688701c3941sm197317pfa.111.2023.08.17.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:35 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 7/7] wifi: cfg80211: Annotate struct cfg80211_tid_config with __counted_by
Date: Thu, 17 Aug 2023 14:15:29 -0700
Message-Id: <20230817211531.4193219-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=keescook@chromium.org;
 h=from:subject; bh=MqZgW0ZDJW9VKg5I69oHRlFrW/5s/bnzmd4geiRSuSA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x/34xyuHIsFO373KwVl2QODEFDIBSLz76F
 4mS/Sq+pMaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JjEZEACO9GxRQKT9xf9tZlwDCcN6atAAOa0htPWNOoIsLNtvxWAYtKhtG8g1/ekxWwGhQF37YHo
 lJovHZ60rO+krmpUaxkVL5JglO/98U8OFfCt+Zm/XtjpwhrYgCk1rH4rBxQ05BFwiu3jDUK1rPx
 wrSqHb65i6piGqoNBN2P6KBm8E8+V25p2xE4fvwzJ/suiSSZoEWuK6HZYe6BIcIwQPAdT4JS1tW
 r8OEsiBL0pGU7Fnho3C2Qy1AuT42bVUTaS1PBVVDy830zM3Y39TqW7pWAD/N7mMNL36SVXXb/VY
 ujNzAglxUWExKIpLT5YouRtrrf7XBrJkOsZ9qEkj4JKqF9/iyQxhSopHsPuoOS8+cW8thVGuBDH
 z3scez2jr1rzzA1hPNKfOsmFMmJVIsQvgMERacrkLUXcnjkDdo9jsTn1zASB7NMYY4r4UjPz9cT
 m/vMQZpwV7/p9uZBhyBJrutEDl3b+ExnXiwukaJGKBRvhNznOEXbA9snzl3Vmjgijs4eELKywMM
 gfc4VntArWeYXia3LhmT2zLetKC0mrOBm/hHBTy6htJ0tG8Qkf+mYREzDm61HGSTZlDo6mwUzFk
 S88K7vNOHe5KjZ3/wUHPkbS28drKdo2jeZCveIDDJ0wNjY+Ih9FEGvjYYD8KY1lR5ZUMnQt6ovl gwCSNjN0bl2WPLQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfg80211_tid_config.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a2afc94a5408..423fe9b85cb0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -811,7 +811,7 @@ struct cfg80211_tid_cfg {
 struct cfg80211_tid_config {
 	const u8 *peer;
 	u32 n_tid_conf;
-	struct cfg80211_tid_cfg tid_conf[];
+	struct cfg80211_tid_cfg tid_conf[] __counted_by(n_tid_conf);
 };
 
 /**
-- 
2.34.1


