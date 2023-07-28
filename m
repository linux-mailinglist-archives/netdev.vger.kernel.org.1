Return-Path: <netdev+bounces-22374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCE767363
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD821C21181
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44525156D6;
	Fri, 28 Jul 2023 17:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB0156D3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:29:36 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C23A94
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-7748ca56133so23306339f.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565371; x=1691170171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyD41TjCbmVuD3Q46FNMhjbjisbmz8hDWYj37AkUnHk=;
        b=hRWim4l1+IGA137PJlwexSNurfpuER9flcSAxOm4LsJLdw4LW3UU3afJMVs4uU00D3
         1Qt5g/3GnnH930VtMFyQBycmOwkuWCDxTkUfNRg36JNk6CjHSj/4FJQSx52zavvuSDms
         r8tm/WVlJJnSmLy94GGd+gUn1klK5b8ETym7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565371; x=1691170171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyD41TjCbmVuD3Q46FNMhjbjisbmz8hDWYj37AkUnHk=;
        b=PaycJ3kemyOj8y1PBWcero3T/pFVG7KQDigm9X0Uep7bLrN5dHxh5UgT2OjdrdOrnz
         G17beYTGV4lJ8vs3S8TC1lW8PyZetXQIxXTeIwg89RzS0cy9kLNJpCWRBfgpG8AY7kXh
         e62WwCUA5Hv0MMp9laFw7tmncSrkzhVBWnSaqEu66Tw/c0TRiYBUg6BLff7wz0H84/NE
         TXrbLi/xOO86PwY2DgOS0cYX+ZQeCFA1neD+LEUcGC6iTFjiEtVwv9AgdWK/tg004OKg
         lpt90oIP+kLL52LsCm6SMFHeZeIwjPj/XmBSl11+6uOkXG0Ti9J9A1UikFGINJZhfFD7
         bnSA==
X-Gm-Message-State: ABy/qLalOSTi4BqQV0okdptKlMFpaPGK0AteJhiM1qKNlWJFdJZHhn5E
	i+diPcT+5vsQLFAyW9wJx3fCmw==
X-Google-Smtp-Source: APBJJlEG47QTZ1NoYk+U+Zk7I8oCNRRLU7ElqoKqeRa52rla1kFe15V3Xjtvfnln+NhSRMvp/M6PGg==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr339190iov.1.1690565371630;
        Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	Liam.Howlett@oracle.com,
	anjali.k.kulkarni@oracle.com,
	naresh.kamboju@linaro.org,
	kuba@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	davem@davemloft.net,
	lkft-triage@lists.linaro.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH next 1/3] selftests:connector: Fix Makefile to include KHDR_INCLUDES
Date: Fri, 28 Jul 2023 11:29:26 -0600
Message-Id: <d0055c8cdf18516db8ba9edec99cfc5c08f32a7c.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test compile fails with following errors. Fix the Makefile
CFLAGS to include KHDR_INCLUDES to pull in uapi defines.

gcc -Wall     proc_filter.c  -o ../tools/testing/selftests/connector/proc_filter
proc_filter.c: In function ‘send_message’:
proc_filter.c:22:33: error: invalid application of ‘sizeof’ to incomplete type ‘struct proc_input’
   22 |                          sizeof(struct proc_input))
      |                                 ^~~~~~
proc_filter.c:42:19: note: in expansion of macro ‘NL_MESSAGE_SIZE’
   42 |         char buff[NL_MESSAGE_SIZE];
      |                   ^~~~~~~~~~~~~~~
proc_filter.c:22:33: error: invalid application of ‘sizeof’ to incomplete type ‘struct proc_input’
   22 |                          sizeof(struct proc_input))
      |                                 ^~~~~~
proc_filter.c:48:34: note: in expansion of macro ‘NL_MESSAGE_SIZE’
   48 |                 hdr->nlmsg_len = NL_MESSAGE_SIZE;
      |                                  ^~~~~~~~~~~~~~~
`

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/all/CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/connector/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
index 21c9f3a973a0..92188b9bac5c 100644
--- a/tools/testing/selftests/connector/Makefile
+++ b/tools/testing/selftests/connector/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall
+CFLAGS += -Wall $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS = proc_filter
 
-- 
2.39.2


