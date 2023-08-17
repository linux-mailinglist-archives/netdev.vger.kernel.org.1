Return-Path: <netdev+bounces-28592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09C77FF96
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84531282187
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529A1643A;
	Thu, 17 Aug 2023 21:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F91B7C7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:15:35 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE33598
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso243372a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306933; x=1692911733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT8MJVDWHhlt7GT94EDDEs9nRzLXq6DEvQbiS8viRh4=;
        b=Q6MriGrKU+zV14wa941JOgTi+gqzhkkt96ee6lcGUbQWUgKDxi7fWotXu1zEoi0dcV
         jqZra5E71c8hTYDj7pB8tPmycyrXaDJ2/u2Bhx5f9cwSYQIFybzeAmmV1qmt2A2JPk5E
         EVl4teOZ6on0YKV7ZKC8M87jZ8aHd6LvixZdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306933; x=1692911733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT8MJVDWHhlt7GT94EDDEs9nRzLXq6DEvQbiS8viRh4=;
        b=BxBjVWQmVfBq3IRFyEiYFGAXcfFoZCD76K9HO+9aKnsd+7heW8PrqTTErOM/Bl/bAm
         1nSRo4nw0VbJJb4pa4gW/sDaoDuIyGVp/hlIsV3Q7dliYh3pZtzJsWq4SO1V0nke5mec
         g/AcILRbojTZVFWOfaqkdczRcchAX6CEZ1Kp5aiLxtGtUSj4Imzkw8LP+/FmHqGInxcX
         FRIrjxjjHncL0VbfVdJ63MBzp17ilQIRTKdDmUGrKBrYgYaB/o3Iec1DrpCBLbHEcSth
         TWF61l3ncyA1t17XjjwJR1/ggt1AVsA0526dFw7VRnreaY2sCVm13HrtLJAy/4Mvmpfa
         8RVg==
X-Gm-Message-State: AOJu0YwpNFwC5WplsIPktgY0iNrQXOWFbdWfMrF/dE3qF6/kARQvL/XS
	dEgW5uvRO4njstAmFeeA1h9NLA==
X-Google-Smtp-Source: AGHT+IFujRQeDYqtEuwBg9LalW0yXT1bQy92TumTfAdEV+ffSYyXL9lBszK0H7i2rGqbhZ9NHX/HjQ==
X-Received: by 2002:a05:6a21:7983:b0:147:c5e9:ac15 with SMTP id bh3-20020a056a21798300b00147c5e9ac15mr60162pzc.40.1692306933084;
        Thu, 17 Aug 2023 14:15:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b0068895bf4cadsm199906pfh.114.2023.08.17.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
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
Subject: [PATCH 2/7] wifi: cfg80211: Annotate struct cfg80211_cqm_config with __counted_by
Date: Thu, 17 Aug 2023 14:15:24 -0700
Message-Id: <20230817211531.4193219-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=keescook@chromium.org;
 h=from:subject; bh=ECnIXt7JV7ajMGIel3HODpAmzQ0rNDyrgZa+BQq/MjM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3xJTj0RQBtpGsyr25lmRq+X7daHGy0fxY9d
 iHi9VLtuYOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 Js23EACoJ3Il4Fox1qfv6MkF00FIjkgz3oRYETXrnXwRExjX9UgOxj0O8a+o0WKYAqsu77C5bkJ
 m8+EutF4wdDbNNnYQiT003irtBsaAPzt5XKeo2uvuWQqnhuR8Vn7nPrwdbr3YUu/GLFZcMCGMEE
 j5Pu9mUcyP1xpOYW/qA07g0FnxfO6B9AC9wIJ9cjpLGgZS7VJGcj6jtLSffl+bg2mCP7BfFpEcm
 KL2L0tc5486Y+0rnUbnUMHuI7Ulrkp2JnJglnXF7NCWdBXb7y2Lm4Zt8JV5pKmjOujBupvod0Ch
 /y7CnDi8b+SUAOi+Y+w9EqAj+tXOAa4xiUXgbvpsBQ4JkeTPSOnlA0iBRnj6m3tSHQCpkgPuwgg
 vSL7a6TIEza+DbAMt1tYrqPrDMJWhcmTgUleo+rZAb4tYnaoV6rdx+cHKPHTAHhA94GLnqL9k9U
 h2xBix7EEIE6fvqapgClnLk/Vw1gBIBKEPhzEUhwFq+VOVJ2WwVc3lxnY8rGtri+K60mNSESqQt
 IeoITB7eL74K4VO/zVj9MOGV9e7wSb9maD5ekrpESQt3fg2nNVAhi8YBq+lF7D+iwpq33YNiqgE
 7Z16srA65hfN1L+0QSKUbaM8loMTw4re3KKImg7iygQngjXSXVFTJGF9EIaX2yAkQ5hz+/1bfib 9VA99TlaYkEOXRg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfg80211_cqm_config.

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
 net/wireless/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 8a807b609ef7..507d184b8b40 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -298,7 +298,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	int n_rssi_thresholds;
-	s32 rssi_thresholds[];
+	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
-- 
2.34.1


