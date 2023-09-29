Return-Path: <netdev+bounces-37099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D427B39C4
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DA660282A4A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA966669A;
	Fri, 29 Sep 2023 18:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013266DC1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:11:55 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70661B7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5bbb205e3so130601905ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011114; x=1696615914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrVonC05p6jOVhwUsfVJLWHka6sFzEOVBvIvQ8Q6DqQ=;
        b=iam2DgOt+pc0XpODhJMdV7fFqweB00abGT6qzmh0ROiTggfKN/uA26owAG9Wr7gAfi
         OVEYRh5M34c3svag3tP7qerBoaXgvjLFgEnzYiufn+X8t4y7Qo8W4+G0G7kPfTRnfHlg
         NaRToJAUo9/nJSawNsR7QJ8ntC/8SaOLnKnNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011114; x=1696615914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrVonC05p6jOVhwUsfVJLWHka6sFzEOVBvIvQ8Q6DqQ=;
        b=LAkOwAvhN2jjAIgG1fvfw+81fOvKjp5UTR2aKUPrgD9nCT37rJ9eHImfSesQZbXHVK
         dxzK4RquLS0ZzNm13uOJ6DuHPMnNX/rFY0R8ZSj7+0H+g1Qhp3HgpmHJSiKYaHKSt54F
         WhK0vdGoRxycEgej/j9Vr/l0OoeTxcLW07jpwrRUHP9WYCChwfM6WoHMBQ0Y5zFLb8pX
         dVDQyKxHvgH6UTUTVC1Y0gcJdNdQl0zdMVc37lKtipNZ3eb9ihBkYjnSaFEUqKPuqCSM
         NUxWBf3tSxVqzp/fg9+dHXUCunefBkB/3GXERo1RZgGJxIggbK706cfHEPEMjRHwbckH
         YskA==
X-Gm-Message-State: AOJu0YxsSf4ofTT5E3UAgYFQbq6cqQrszKRSziHw1or4H7gWqiobNC0H
	HFAZxkDqFKU/dV7nbaIP9n7o4Q==
X-Google-Smtp-Source: AGHT+IFgn+YcX7y6H3lg00IXM/XrZra8mruPoKoixaSoCVKNNnq8jxU4+SgPqKTL8waGiLmnTcRybg==
X-Received: by 2002:a17:902:d38c:b0:1c7:4ac4:8f45 with SMTP id e12-20020a170902d38c00b001c74ac48f45mr1746465pld.43.1696011114345;
        Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm11121886plj.101.2023.09.29.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <rajur@chelsio.com>
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
Subject: [PATCH 5/5] cxgb4: Annotate struct smt_data with __counted_by
Date: Fri, 29 Sep 2023 11:11:49 -0700
Message-Id: <20230929181149.3006432-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=keescook@chromium.org;
 h=from:subject; bh=JLyOuNbsppgNQ4E7t00aHIOLLwYOPNO4180/z7PYk3s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkFhFFrPwEa/QR03Eug35cqUa66za8zL4Yc
 tXAGq5NrJKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JhyfEACGOow2LuF71Rl2/1+567N4njI1FCgglmine5Smin9dsg3gXEI6wm5z9CqGgrQaAxNKx4C
 zmoIQ01iI7Dv13ajsqLxuuxhsDJJi33Q5MjAQ6XbWMCN0LDUIiu2pR1Kfv9XKAWxKV7qn/Oahln
 sryf9SDc7OSHj/Wou2usLanxazxvNzODnuZReRlw705m4BdnO7+yoLKCd981sdmOohczCfAyMaA
 oq2HA/pt2OaGJpZg2cOkDnndqDHgTmlwxYRg0Q8EUMa1h7eclM4/txL2VR1E0E9Spgv5lPy3iIh
 3rT+0yAVFoS8jrHSxABKSgNMRRP8AMKK3PkL5oHS1mqJDFYcbFBgjuKj6sKIbea4RtS0cYek06M
 hQv1Rk9XX6y//jV7kU22s0/ms+WqRZcuSyVxxmYgk+jwnAmAG3oONUwdDKAmPdMrChdWi+Vin4i
 5OAqx9x/Eq7456qC3yfH/YvEbpgKV1sMnxV3Q8GGgxw0rrrhY2tk99LzQ1S/WTU0x5s4ke3c2t8
 Siui7ik4Owf/oSeTLtn0yvCObp0kqkPgm/SpI/ZFoRDeudgpA51AFk4mvoy4fWw7de2TLJv9xqE
 KgbrKJRdrPpV7PEwtt/iay1GE7okgsjLZngWqD5ddaUA0tA5o/C1aDYkNpJJyXLkAW8ZADALiFl qSiszCEru7ozwrA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct smt_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/smt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.h b/drivers/net/ethernet/chelsio/cxgb4/smt.h
index 541249d78914..109c1dff563a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/smt.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/smt.h
@@ -66,7 +66,7 @@ struct smt_entry {
 struct smt_data {
 	unsigned int smt_size;
 	rwlock_t lock;
-	struct smt_entry smtab[];
+	struct smt_entry smtab[] __counted_by(smt_size);
 };
 
 struct smt_data *t4_init_smt(void);
-- 
2.34.1


