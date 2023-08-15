Return-Path: <netdev+bounces-27811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B977D49F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B4028160D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F518046;
	Tue, 15 Aug 2023 20:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CD17ACA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 20:50:37 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0B1FCA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:50:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d66d85403f5so5584461276.2
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692132614; x=1692737414;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ci189aHPBFBjtm/RN/hzTJMe0+KKoH+4CClRyv2s6dg=;
        b=SAeIcykjeO3O4waBr9JKtx/sxluuhH/9cEcIo8KaE0eyK1VF08SzRAJKh6p+FmA1JM
         69OTv8TvYkczMG0mhmrq9GTsueFg0IlEsypYeECDD2vH2l6576G5pEuCEzFlDoCMLvWT
         fn362CQrZE/tm0v5rMp0CN01qzTPzCv6QJCv7l/IHGeLYxWRcXVES5g5p9/31INLZcoa
         Rvnz18b/2PQNIiKNRAYs2uT62njO7WMkocibzanwhe1+v4vEpbghNK/2MHile54eDFs5
         uM8NETVzrBbLkfr44/H893S5AScQPRBPXeWc34kmCmUx4lVV+Kfwz5e0JGWHAb4m+tw5
         X+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132614; x=1692737414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ci189aHPBFBjtm/RN/hzTJMe0+KKoH+4CClRyv2s6dg=;
        b=iXgLEpzaCvh/AmQ5KS0eykYeJppI/Ui1FDJJ3c2HlKymj6vgZxOesy3dMJuQ7pKzIa
         jzF/m6CUDzi0EuwQsWQ1btpQo6nqLtguA/ErKxnHAk1bYP1GSckKHzV6KnajLF1+L7TD
         fxK57/9Bq06kV4hQOAwdAEn21I+VBnsuv6DJ6rZOzTs2MZk1X4rnxFqi8mXJl7ZWnnoJ
         pbYaOSDe22nM6uDFU/3r6Yw9auhjO10ut8nAeADJkHUIg4oOvtt4Nb4UbuPM83hTfodq
         mZQOaZ331vrD3T95acO/teTcqWnLIw8MYTPLz1+QHExbHKbze2G6lCrd/+HXC3FwIBTr
         R87A==
X-Gm-Message-State: AOJu0Yw9Y0eSIb9M665gV8aTS3omy1dmXnTrARf3exxXuK6qYCOqK1d9
	vvuseioYZbTeMmcEbkX034pfVgWY2BBSYTm86w==
X-Google-Smtp-Source: AGHT+IE0S8U2GnJZpujIzqMD7YILSF8i9bPnwtVZEQv8bw7cAjHxPN+IBbiHTBhY+Q8tDhl8X7qu4g/1kHaZi/Xotw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3482:0:b0:d51:577e:425d with SMTP
 id b124-20020a253482000000b00d51577e425dmr172964yba.12.1692132614147; Tue, 15
 Aug 2023 13:50:14 -0700 (PDT)
Date: Tue, 15 Aug 2023 20:50:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAATl22QC/x2NwQqDMBBEf0X23IXEaBV/pfRgm1H3EmUjQRD/v
 WthDvMOb+akDBVkGqqTFEWyrMnAPyr6LmOawRKNqXZ1cL1vuawSOaoUaOaEnbEv0LsksRxmhO7 TPNs++HFyZEObYpLjf/J6X9cPHh5EAXQAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692132613; l=1704;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=koKe9TiNY9BHLtNN6bXZhZ0oxr/kaYIOgBRphxRQ9R4=; b=4zK7hYBEqziHv0W5/Pz/2k3HinI9eYV7eo3A7IjcFaIx8ueNhiyyhTdLIyTZ827+goMPHHYVm
 LXiqIzRSRwND2YO1dk2khOrUhZ9LI5EX+oXcD11QKowi4+yD62y5ymC
X-Mailer: b4 0.12.3
Message-ID: <20230815-void-drivers-net-ethernet-ni-nixge-v1-1-f096a6e43038@google.com>
Subject: [PATCH] net: nixge: fix -Wvoid-pointer-to-enum-cast warning
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building with clang 18 I see the following warning:
|       drivers/net/ethernet/ni/nixge.c:1273:12: warning: cast to smaller integer
|               type 'enum nixge_version' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|        1273 |         version = (enum nixge_version)of_id->data;

This is due to the fact that `of_id->data` is a void* while `enum nixge_version`
has the size of an int. This leads to truncation and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: There is likely no data loss occurring here since `enum nixge_version`
has only a few fields which aren't nearly large enough to cause data
loss. However, this patch still works towards the goal of enabling this
warning for more builds by reducing noise.
---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 0fd156286d4d..105977804e6a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1270,7 +1270,7 @@ static int nixge_of_get_resources(struct platform_device *pdev)
 	if (!of_id)
 		return -ENODEV;
 
-	version = (enum nixge_version)of_id->data;
+	version = (uintptr_t)of_id->data;
 	if (version <= NIXGE_V2)
 		priv->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	else

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230815-void-drivers-net-ethernet-ni-nixge-37b465831af0

Best regards,
--
Justin Stitt <justinstitt@google.com>


