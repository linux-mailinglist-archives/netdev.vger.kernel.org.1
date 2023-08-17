Return-Path: <netdev+bounces-28598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803277FFAD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223A228219F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC581BF02;
	Thu, 17 Aug 2023 21:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7231BEFE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:15:40 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3F35B0
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso172743a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306938; x=1692911738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1xDe42Zb4O1g25la6ZbpuaxP3YQAxL+qM/43yhn7u4=;
        b=aAnD+yQ6IXIXvqgfxPjHa3eQuh0LMSjOgvcikD2gU4WhmPjmZ5UKGdPLx9zVjdMWq/
         htAwgtscCm+le+2XgzbGGyAu0u0v25DSSdxStSrMki6Vmy7v4V9iAZSwWRcg46VgRUC6
         GBsKGsdXMR9I4jsHBGhPuW1cOm7H1PO49iZ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306938; x=1692911738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1xDe42Zb4O1g25la6ZbpuaxP3YQAxL+qM/43yhn7u4=;
        b=kFkMGEe6w7YuxUWQkbSHB9fFo/FVfyba7fO4xKDQEhxEJWyHd1c3UdKCEIFbhD4OMW
         J0hcOo4EYe2TSUUXZVHBArfvIPja5XjAPgDCtIIvP+anMG9kwESAAxrX+fvyByJ0XhGp
         PmuO+ustzLNE5hiVtbI31z0q1i0c2lrbhUO6IjLv8kELTL4b+8sjw/DcWpcsC/qkhNyK
         rytz5WJJgIlyah0M9bieaLEqyFEvgs42qzh/RVAJwpWW3gIT4/DgyilZpGrjynirmPPU
         t8eae2tpV9HhdCGgUW01UWq6gGcUtYkwBcTb/pp017jOHuO42FKQIwzZ2Efw7eGmrhu8
         c5EA==
X-Gm-Message-State: AOJu0YyqxkQ9yjm103G9tcEH/EDNpl9T9wVbCtCipA91J+ijRLqJ2D9v
	OxcdudHJQQ84q/6gvafW8we6SA==
X-Google-Smtp-Source: AGHT+IFi8O0i9RK0CHXGKeQfJM6qFoojgbvsRcV1oh+MbrP9SdGULKDsRCDtwXu5ebU7gX5iSPej4A==
X-Received: by 2002:a17:902:aa4a:b0:1b9:ea60:cd91 with SMTP id c10-20020a170902aa4a00b001b9ea60cd91mr614626plr.7.1692306938249;
        Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b531e8a000sm212760pli.157.2023.08.17.14.15.33
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
Subject: [PATCH 6/7] wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by
Date: Thu, 17 Aug 2023 14:15:28 -0700
Message-Id: <20230817211531.4193219-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=keescook@chromium.org;
 h=from:subject; bh=B1om6kzjnM+KYttPuLCv8qgp2sSo5I5ukw0vuIq7IR4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x6e3yCDOyg/CnRvaTxYnwKpLSGmq9jMXbu
 Lj6hWgVrwmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JuPqEACvZBjYWwE9vVsmWQaH0PScoxmrFrBmcCJVAXE9aU4a7P770PtzaGYD5I4idLwYuQstxsu
 hyy8i9VRnSI4ZhovMyvONu4Oa5vSGx30KKqu+EgYLel4gougy5ljNd62Ma1JJQwq/tl3Ib5VvtG
 b4/+4/CP1NIhwdhZGpdOCu9K6sbcBy/VllCKVkuohkOsR/LZWmQbOxapbM5l99ZKMlMtRi5Y4J6
 ZyNkLPFv5UCoX0UNCoOwjIf8TX7Re1URAq6OK74mYIj2KLLBcQQb6WtzVhqlhEy69NV6s9mG4zw
 aN7Um7gzgf/969aG7t0K+Bg7sMaFVyl4Q5j2/ibGo3dLnxRjo8NcXeI7nFByEoZzCr0D1pLlnvE
 WyiFXEPJpE888qd74gajJKkFm/VVR8Aa+rcay3qko/HJACbC7MlDGKVmfbYWDentPVIeYfLpBAK
 0zKQV4vVA+8Ni+4/N/CcXyEOVIoIEXU9gl3aOVSKME20mJd2/uEV+jkDQvzz3l2O3q3vg0iebeW
 oMZpUFHphqMXnfO+ecIAtyviIuuQ90a8AIu5ZFBzcnRmj44QZlSnICV33GdmCz1azq7xOUMe2Lg
 Nbedjr4+NY+tfEx20wxse70y+NoN5qmNSjxe027lWYKy1MuBHxZMamCWXthTi8bDNtm15bGhHWG GVGAyzyr9T5ndYg==
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

As found with Coccinelle[1], add __counted_by for struct cfg80211_scan_request.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

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
index 6efe216c01d2..a2afc94a5408 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2544,7 +2544,7 @@ struct cfg80211_scan_request {
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
 
 	/* keep last */
-	struct ieee80211_channel *channels[];
+	struct ieee80211_channel *channels[] __counted_by(n_channels);
 };
 
 static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
-- 
2.34.1


