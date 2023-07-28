Return-Path: <netdev+bounces-22373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61764767353
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3AF282491
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13E156D6;
	Fri, 28 Jul 2023 17:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55C156D4
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:29:32 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DF35B6
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78706966220so23467239f.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=bP89L6dvIsj5o9kT4HZvJTW4rK3q1szR6j8h5AZVFErx80ziNL/0QSsSH0FzC5C7fE
         8wIjQLGud6CG1XEsMSUDxjnvq+IAFaBOVMbtwQGI+2u3qnecAY8kMMCWGvEgOhIRthZP
         NQVqr1kjTFzatLhzQDTlaAfpvh91DjUUQYdus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=gNuU43Pm7a6mtaNeFgVjLd84eRkw+BVYyKh0LX1kJ9N2RrV6LvaoN4LNvNE/Yw0jmj
         JZ2icSBC+Tw+QSIYAJKsVZJMQk1opBmcLmYzv6XLPQ/YQzMKRhBQwbaGXIxl55DrKSie
         /uDblo0NnkUrnIBiCB76bnj4npW1gjNNjiClrPfLWM/PdWZaX4h2kviNfZn+clyKqKtz
         0fWOXFBPZHW5rU+4m0X5fL6cdIpzZErN5iHZ40bsUuXJuYeZAb7FzqxNzRgoToIOZ+7z
         5WGCFDMHz7P/SWy6eHuj757agykmlL1j8MtDSL8KRDTlBEglag3EDyrg+Sucw0CEGvsP
         bV6Q==
X-Gm-Message-State: ABy/qLY+Cd3ibY+ootk/MBawtn+nPfR7hJdPXI3V/0l2Zun36gJlOKDB
	5gkmSxA4NJsTrpwm+SlZyKGkHg==
X-Google-Smtp-Source: APBJJlG++dQGjr9Fm6NWZbXMUUHRFA6B5WaaKhVtSvn74pz3s9HPc7XbjI4la4/GVLUyqkW+AyakaQ==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr248459iof.0.1690565370474;
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.29
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
Subject: [PATCH next 0/3] Connector/proc_filter test fixes 
Date: Fri, 28 Jul 2023 11:29:25 -0600
Message-Id: <cover.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
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

This 3 patch series consists of fixes to proc_filter test
found during linun-next testing.

The first patch fixes the LKFT reported compile error, second
one adds .gitignore and the third fixes error paths to skip
instead of fail (root check, and argument checks)

Shuah Khan (3):
  selftests:connector: Fix Makefile to include KHDR_INCLUDES
  selftests:connector: Add .gitignore and poupulate it with test
  selftests:connector: Add root check and fix arg error paths to skip

 tools/testing/selftests/connector/.gitignore    | 1 +
 tools/testing/selftests/connector/Makefile      | 2 +-
 tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/connector/.gitignore

-- 
2.39.2


