Return-Path: <netdev+bounces-37827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F697B74A2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 4E7621F21860
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D73F4C8;
	Tue,  3 Oct 2023 23:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BC3F4A8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:18:22 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DABD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:18:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e106eb414cso977978fac.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375098; x=1696979898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rOVzN2PCRgnrHqP+jBm3ldFT981CkAJwsAUdzgdjEk=;
        b=LBV153uuWvGhC0i2PdKbqI/x32sJqJsuhpGwKacYV3JX4NXAP8zjKkQCsdqy2RWi2c
         MVUtifleO/zZT8rR7HCwA9Qotc3iKnyI7pzn2RY63ExIVbTUfZka6DUQH7QH570qR1BH
         ywXdHk7OlysIuhjpVv4zhPo0AW1CFCZdmvXRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375098; x=1696979898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rOVzN2PCRgnrHqP+jBm3ldFT981CkAJwsAUdzgdjEk=;
        b=Law/Ece9Y1Yow4h5gbCXTFKp/V8OBKkG5AP9ZLE3x6QcjwN3WwLnFXYQOZHuQsexyB
         x2pRhTXilQJCNXMAeqX4MrzO/rvEyJVLYYWuY2W8DSKKT6VYiGkTJl7FPKQ1g7uEjoOz
         8NAwYBgdVmaEpd3EBIZHX5AM0RxgjAgE0KxFxgvo2mCmfJkUJBQbC9ITrJQv4gOuuEFQ
         m69zsinoVeiG7zJpkuvMKQjMcEep4WGhvv01EeFpM5z0Sf31SSrl8tHZL+vRiH8S5NWT
         /DwcggiNe769mpM2acoluPVRU5oRaA1NfvPG9cVWv9Z1C2KUPDb1ENSeWAGLHIDr8+0G
         aMsw==
X-Gm-Message-State: AOJu0YwMwwIZ8Fiphvc6vg6JI/TLrKDKsfaxPG5U77Opgx7RGXlVYSFn
	+xOU+efPBmVTQwcdVuSzBcFl4Q==
X-Google-Smtp-Source: AGHT+IEYnl3bkJ/TRCC4P/s1uj+lcaOxooGOx0efGkFJ7ASXla9V+F85ONcda+3xmNzFJH9WpNfABw==
X-Received: by 2002:a05:6870:ac09:b0:1d4:dce5:332e with SMTP id kw9-20020a056870ac0900b001d4dce5332emr1045463oab.51.1696375098244;
        Tue, 03 Oct 2023 16:18:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn25-20020a056a002fd900b00692b6fe1c7asm1958637pfb.179.2023.10.03.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:17 -0700 (PDT)
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
Subject: [PATCH] nexthop: Annotate struct nh_res_table with __counted_by
Date: Tue,  3 Oct 2023 16:18:13 -0700
Message-Id: <20231003231813.work.042-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=keescook@chromium.org;
 h=from:subject:message-id; bh=04VwMUdoOUg0Q3PoomQoaiWpcLJL9oFj2Z3pRVMvhsY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKE18bbozIjEbjkEMDqDSUfdgSjKZnp/dO6MO
 2v7rF/PyfeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhNQAKCRCJcvTf3G3A
 Jg3qEAC1Sa7rKcvXjSXNo4pPqi0dpvCQhPdi9HONfIHpOYimtWWDUFCjlzs1uiDQYgcHT8gHEFZ
 qr49f0ZGX20wSggsRfREApX0NF4U+UuvvQSU4OdL3j9zluRhSPg8EDCjIei1H+vHxISjlUnLFFF
 8z+yzyG3Z3C8zN8xs+q01IGw1x8xjoxLnPLv6RxW2cRak5xGNB1PnC6/on+s/KAz1bbYDC5r5vo
 a+CPr5TkGN5EmehIO+nT4vf6FRxBcpjrDwB2172DbK0+IxtDzkK2ME7wwTeqLwuzGse72E3Jf60
 +dZfhQiepJmXetshJ20V4HLzB1d8OBa3LcC9JNCP3eRrygjLIBMNe15+ZLt9DM1vtH7yg5Gmase
 NNq9fcGB+K3MwHVuM2c5YREEAW/gE7w6FrNhfVU9+bfe0pdH/YNuH00hDj+WA3oYO4jOKKyKBL2
 hP9+doqrfkrof7SXN4ZQlo2ojUHjGFNMO0KzZ2XfL4jgu1JCm9H3ZWUXrgvGgGmZ3Mx0ZsSOGiI
 vCo120kCO3BlscD2j8RA59I83C//X7mfSC+22vhr/Bnofg70JKUd0eWl2IWlQFKzSVjAz3rTWU7
 rVXf3nvwLJVwD08ak7+0tDsKCvZO0bB8amlrr1vf0TGP/ZKdXS+m6tjms4YJsxa2SNdITm9BPre
 aUFjyv9 gJ0MqnWw==
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
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nh_res_table.

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
index 5dc4b4bba8a5..09f9a732e640 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -92,7 +92,7 @@ struct nh_res_table {
 	u32			unbalanced_timer;
 
 	u16			num_nh_buckets;
-	struct nh_res_bucket	nh_buckets[];
+	struct nh_res_bucket	nh_buckets[] __counted_by(num_nh_buckets);
 };
 
 struct nh_grp_entry {
-- 
2.34.1


