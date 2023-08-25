Return-Path: <netdev+bounces-30742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EA788CD2
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3490F2815F6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB2174EC;
	Fri, 25 Aug 2023 15:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2EA5249
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:52:14 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F010D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a7d7df4e67so737134b6e.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692978732; x=1693583532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCgtddnWBjeVaOuWV5U5vyL440m4EpyKdXs9LYeocEo=;
        b=2rQO54lSIadB8xB7dYTVyMLFDc5zLoWNjMF/9rI8oZRQO+yPgpOBwLHakThEOqpUUu
         TsRWduNAG5OMIvFZ/mKw3wh5ehNvrGZghKqZkAKNfOz6VeXaPiok+gJw5zne1cJjI80s
         a0C6n16VCPeKryckqetmbVsMZGJSu+v84B2KUeJ68Fwfi6h5GvithhNVDJW4wJ1Q/2qu
         5JJTcX1gIqXDXCec++weZdFk8y5ps6wnMh5g2tqt8NoiyQDStYqtGFfRgITEvHnHxKGt
         ur16Njpa8dIHLeuKMGuLyrEXoLqrcoM6BeUknMBAiq+4m0y1SPU/JYuwkeP3Z6j7b5tm
         ybCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978732; x=1693583532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCgtddnWBjeVaOuWV5U5vyL440m4EpyKdXs9LYeocEo=;
        b=hOS2ThvlIBGcKNo35WLqfs8wenKyQX8oOoWpLFQFgk8EoDDfBEl9XmFrQwJvVccgHZ
         fmLI1/xguFgjE7W2WkyG/5E+WX86x2+NgCks53OzJ47GOUDo/QGeMHmcO7Q8dk4WTbXW
         yPYUM2J58Z3ffakiX3ybVj2L2y6GnfdYGWCnEcrKQy7PQK0tURurd+r3s/W4uOF94RDk
         5/he+sTszBpziZMzKMoTBRg9OucVU31bo8VI2z+0O0qPyq8aDBT/RuArhYoQ8bDDHI6A
         Va3XFaEkOOL0WTMfstlr71ij6MPwqmAHqyWzvN4Q4bHUfn/bSMYNl5likU/Uj/gupc8W
         89Uw==
X-Gm-Message-State: AOJu0YyJgcHRm5Hjc6U3ciBRRPixTvDZ97irWkqd5WPtDGI4V24mJt/g
	6RNyTEG0g5pclbTPLMqU9uyvbP+HXvzAye1J7CE=
X-Google-Smtp-Source: AGHT+IHQ+HOqAPzZ9jSws21OSQjeAKgABfgWfkwy38mVjj0qMFbf6fOr64gnVLeH00OI33BlSqPGIA==
X-Received: by 2002:a05:6808:1825:b0:3a7:aaf3:77f with SMTP id bh37-20020a056808182500b003a7aaf3077fmr3843689oib.28.1692978732345;
        Fri, 25 Aug 2023 08:52:12 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:6001:c5a2:ad40:e52a])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003a88a9af01esm856678oib.49.2023.08.25.08.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:52:11 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 0/4] selftests/tc-testing: add tests covering classid
Date: Fri, 25 Aug 2023 12:51:44 -0300
Message-Id: <20230825155148.659895-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patches 1-3 add missing tests covering classid behaviour on tdc for cls_fw,
cls_route and cls_fw. This behaviour was recently fixed by valis[0].

Patch 4 comes from the development done in the previous patches as it turns out
cls_route never returns meaningful errors.

[0] https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com/

v1->v2: https://lore.kernel.org/all/20230818163544.351104-1-pctammela@mojatatu.com/
   - Drop u32 updates

Pedro Tammela (4):
  selftests/tc-testing: cls_fw: add tests for classid
  selftest/tc-testing: cls_route: add tests for classid
  selftest/tc-testing: cls_u32: add tests for classid
  net/sched: cls_route: make netlink errors meaningful

 net/sched/cls_route.c                         | 27 +++++-----
 .../tc-testing/tc-tests/filters/fw.json       | 49 +++++++++++++++++++
 .../tc-testing/tc-tests/filters/route.json    | 25 ++++++++++
 .../tc-testing/tc-tests/filters/u32.json      | 25 ++++++++++
 4 files changed, 114 insertions(+), 12 deletions(-)

-- 
2.39.2


