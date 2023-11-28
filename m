Return-Path: <netdev+bounces-51758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93837FBEF0
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732ED28278C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799C4D127;
	Tue, 28 Nov 2023 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fiUW/km2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574091BE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce627400f6so45707085ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701187609; x=1701792409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgX+epU9LfFEFrUvC+QkB4xbX7Lpt7qSSppDyOoJ7Xo=;
        b=fiUW/km2cTo8PvLbV2mlWe64NOFufhCrpYFdWJl14uGb0i0S17b0fsc0ZnxMW8Ekq6
         AEfQJFYFfvDckvtIUHuBeyCYtUzuqZFyeQxFyVy2Z+lKOsTDldkaW8kptyRHGN72G+UY
         gJDOrVepwqmWZLbcRxqOuCsKM0pJpX8qwRKSJud69mDjRm4vQrq1DHEDo/cEXlAeTh23
         0TpyaZ7yU9yY7lXSnsHDvQL2kbaw1AoYJ1x/P6+AcTd6mRIQTG3VMGfU0fKHVuHYtx/u
         00qHQr5nz46vfRIJa+PiGL2jj6XlAlkYJiaU0SxFPyH6aRW+K550pxbYa1Snwu9smNyB
         3bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187609; x=1701792409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgX+epU9LfFEFrUvC+QkB4xbX7Lpt7qSSppDyOoJ7Xo=;
        b=EFB2zE6V/O/2NkoH/3S8wvNVBxL5hGYxQyib/hVXVY2XRu98j/Arr3BDNQxC6Y29li
         e2v27EnBAZXVnk/xcQXfi3AK9DybJEsx8dIkFb5Mn6fQAg77ApItB8L9sCtktBw2FqMN
         nX4owAsihYge5iMymU/dANCTpTKNInalHccUbx50DpykrY6EEI4wjiLlvmLhNUxLZRLR
         zEx0RCmSqHU8my46YWH+O55P5K5bPXppSAhCojzrYouNWGBzeXpOVA29LE9jlAjXWQUI
         UMb7rYL8N8jtcZghZfGceIRIRpyaNwf8CBYRiuax+vuw9mvb8z8tIx8f+SgyR3RTui8E
         sTNg==
X-Gm-Message-State: AOJu0Yzp+OSYZJxs58BO2JtkyqoUAr70Qb7gn6eTS/DeTF0zvIEyg1Vp
	T2X5ONxlZ4raWHPu24USRPT2DMLPr9xgkP6OxrA=
X-Google-Smtp-Source: AGHT+IGH5ZpwIToH4kkLn9EMcZoWn+20039x7MJY0PUJmgDpDl3Fj1nf+Fs4t9STAyUoQXmqZ1hxNQ==
X-Received: by 2002:a17:902:ec88:b0:1cf:f73c:a700 with SMTP id x8-20020a170902ec8800b001cff73ca700mr2772437plg.64.1701187609483;
        Tue, 28 Nov 2023 08:06:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001bf52834696sm8510504pla.207.2023.11.28.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:06:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 0/4] net/sched: optimizations around action binding and init
Date: Tue, 28 Nov 2023 13:06:27 -0300
Message-Id: <20231128160631.663351-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 2 are scaling optimizations for action binding in
rtnl-less filters. We saw a noticeable lock contention when testing
in a 56 core system, which disappeared after the patches.

Patches 3 and 4 propagate the expectation that such arrays are contiguous
and don't admit holes in them into leaf functions.

Pedro Tammela (4):
  net/sched: act_api: rely on rcu in tcf_idr_check_alloc
  net/sched: act_api: skip idr replace on bound actions
  net/sched: act_api: stop loop over ops array on NULL in
    tcf_action_init
  net/sched: act_api: stop loop over actions array on NULL in
    tcf_idr_insert_many

 include/net/act_api.h |  2 +-
 net/sched/act_api.c   | 75 ++++++++++++++++++++++++-------------------
 net/sched/cls_api.c   |  2 +-
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.40.1


