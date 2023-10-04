Return-Path: <netdev+bounces-37858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABE7B7658
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 641E6281484
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634A81C;
	Wed,  4 Oct 2023 01:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E732A29
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 01:44:55 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57351AF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:44:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso1156003a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 18:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696383893; x=1696988693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6m+ltiUxBgyP6O6NGVJRhv6n+IMmSQtxpfXHOcBL8MI=;
        b=cxbpQhcllg9aTHbTy6a3vGKZq5DMQujQscQ01G285jPDoIIoOdHUr3WWFzyyJzvd3d
         KI+VNTG/FSdBUPyYQ3XVZ94EpOo2eOwBG2/yG7rEVFrJ33oiDlQOSWqMPafrHk0QUCrK
         T8Sy7zuVGoRHdu72VNg5Sv31yZiQ9K9VKdldw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696383893; x=1696988693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m+ltiUxBgyP6O6NGVJRhv6n+IMmSQtxpfXHOcBL8MI=;
        b=VzAeHaU17y1p9j/rbD8l4O9vOcLhABuspssGrmxECf2NuMF60Lzifpc8vwDy9YANyj
         d8iMr3bT1fGkVSlzgDWLdqGT8HjF/LJz9oKZnMzZbsey5QnqIoKzoTlc38f7X3tnYsm5
         TIOvvYX8KZn78Y18y+joSFr0Fy/0Jes7U2yp45DO7HFaqh8JIn7OeUlIdGYzaSsF+Onu
         /uXLsgGxqyZqRpI7L2KwaSA2NQdjugcHE67H70Jwp1bpjQEWvCCizB9Hfhl8zw5ZMfiN
         JowRtpqErXP+l46Xr2WAUofWmeFajIngcQhUG+HoOOIyEO9ycIulfrKr+QWD1nFl0V8l
         4UuA==
X-Gm-Message-State: AOJu0Yx3ZTeevWqgP9wZoIFxm4j/v+oN8+SHvDP/k6oa5MXDtXd0nxVp
	dKz8UWbRQHMjBYI13bofLmyPeg==
X-Google-Smtp-Source: AGHT+IHoFcFaJCYuiM/XpPveaXoTnc32bdzwR7t511qo6mo1UVxZdSWNTi7fDNbl77FYtG6vuNalPQ==
X-Received: by 2002:a17:90b:164f:b0:274:735c:e2d3 with SMTP id il15-20020a17090b164f00b00274735ce2d3mr999366pjb.8.1696383892759;
        Tue, 03 Oct 2023 18:44:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b0026971450601sm287996pje.7.2023.10.03.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:44:52 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Ahern <dsahern@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] nexthop: Annotate struct nh_group with __counted_by
Date: Tue,  3 Oct 2023 18:44:49 -0700
Message-Id: <20231004014445.work.587-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=keescook@chromium.org;
 h=from:subject:message-id; bh=cMswho+iyVCS84W5fjbN8jRy801YZPgydXwTL+hQ8kc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHMOR/Qnr9xsjz+RFrB//RUqkmhmuWuLMRFIHY
 H/zRm5APC2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRzDkQAKCRCJcvTf3G3A
 JuubD/4pBLzIK8LRipBfuGiuOfRseLiRbFNh1J5EeR0aFUlyz21VWo/ONGuXtGXOxgktDliVWxQ
 pv0tg3RLvxJNCOGY0pFJOG7j7tgN8w7Tn1Eomvh7IHQ5UyysY1/txn95G/iwzma9N0e7cspWjOk
 i71eVTwBrYMFx/XI4JIGT/Y9Zt1Z7uXKyqTlkZXE6kTi3ZsMUE37k9g0yX58iiGmmdLols1ocL0
 rqjyPdN/KncryQkGHLsjMD3SXftQJUoKrZK61q7t0of7ZLGX8o4I0yTevYIk1imAMduLhWTqEYR
 n5BRvPG5JvAE5d8L3VsggU36WF5pidU5c5RPVzoOeztl69WWEB9ecpndC9ok0Z2xCh48x36HD/G
 G8235S8ONP14DbGP/eVc/1yqdWpS4vrLruFiJ1HySU5pHPtGQ2rcuJbbPDQx35xXPl6D7okwBw5
 6MMdORrwX7unzOIOhGIWeKBICZes22QAxOctpG8/+dcQkEIty1JY7KSivhZUA1pxzAp73DIoOtr
 hNj60Fetls5Hcp93vQjT0Ls91cpLL/i80y2sZmrX6m/CIEexZMYuGUrLdBMlDJrEb/v487rDH+P
 CEGyWn17nSifdO3/K+Cm1GoILthQET2DXe6j2wjQk5tbiB+Rs+XVL9eXb9mtQUGsB5NdyB+aJU3
 MmGRBkZ wCCDJXzA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nh_group.

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/nexthop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 8f5a2ab45920..d92046a4a078 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -126,7 +126,7 @@ struct nh_group {
 	bool			has_v4;
 
 	struct nh_res_table __rcu *res_table;
-	struct nh_grp_entry	nh_entries[];
+	struct nh_grp_entry	nh_entries[] __counted_by(num_nh);
 };
 
 struct nexthop {
-- 
2.34.1


