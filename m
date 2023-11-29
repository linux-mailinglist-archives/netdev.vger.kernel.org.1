Return-Path: <netdev+bounces-52298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346927FE320
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97336B20FF9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DF3B1B1;
	Wed, 29 Nov 2023 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JeKeSyOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327ED10EA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfabcbda7bso11540815ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296686; x=1701901486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVpR0IvniY+kstE90A1PQqhW/E4iWnd4RrGkFh8q6BI=;
        b=JeKeSyOehWuZQMxZqJhUjXlcX8gEDi9WAM01N2txLoyvDZN5djgQfbU678Rs8w3HM+
         c60C59u7rBk7zBa9oiN4nYmnwsODoBF2wQAyJkrPcPwHWWC1KnZQDpDDpkd8IXK3G6Py
         xz2JXeT6ZMzIcjkgakWtm138KOAkyf5uJeTi8oR5/i2VAME7apQ3HaIH6dGsPAn4IdaZ
         1b70YlZpmbLXzjTip7yInfKOWf9Yl6M7dPnBIIIPQO+cmaBxTR+mgmBXUleOlYNnRaQz
         ADwbAKa7jIQzGbz5T9X2zOLhxTSkhSuFFKP9QbSQrGEchiIqUdFPowyuRb8IVF1rNPTx
         gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296686; x=1701901486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVpR0IvniY+kstE90A1PQqhW/E4iWnd4RrGkFh8q6BI=;
        b=T1fyn6x48Du4pGfTY6c9x4HqBAIBPPmLnWQXmTcc5Xx6M6QvW+pQh1QbJF5Utnkp7J
         Or4UfvnIgDlAQrbTBb3e0YA5WjESEioPKaJX8730qk544r9jui+A/MGNwiG6w8Xi5V0u
         9VCOgkI/3OkDvGnhRGaExkoGn7KdGv9uax4Tw0WjuLZjeQFu+bPm10Y41vyOEKELEFAA
         9Twc9RJRPZMEuMR5mzI96lE/oJ6OvFZ38cq063cTavwvDJ+t77rkdE1b0DHyQVyarifS
         qIOzAJSBrlwZOUPqyWEu0+cabU+DrSYtTHC/e/ZHGfxDL3DKvn1DManx9tfsbYkHkGw+
         RmmQ==
X-Gm-Message-State: AOJu0YzVtSwlBgyHLalf2j2n1lcmhIo+NNQn40QGGIvOz7lqyAOW1WHK
	ja7P+XhrT+R3nI60bjH98PhnAUvFu4lEfIaJWeg=
X-Google-Smtp-Source: AGHT+IFClV4b7JkVRjSMctCqetKwaxnf7eXFOh+Igz9VqrhJWsfakYYRWHRsaNBmBLlbn2kZMOnaGg==
X-Received: by 2002:a17:902:f681:b0:1cf:a652:471f with SMTP id l1-20020a170902f68100b001cfa652471fmr29761107plg.26.1701296686007;
        Wed, 29 Nov 2023 14:24:46 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:45 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/4] selftests: tc-testing: more tdc updates
Date: Wed, 29 Nov 2023 19:24:20 -0300
Message-Id: <20231129222424.910148-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up on a feedback from Jakub and random cleanups from related
net/sched patches

Pedro Tammela (4):
  selftests: tc-testing: remove spurious nsPlugin usage
  selftests: tc-testing: remove spurious './' from Makefile
  selftests: tc-testing: rename concurrency.json to flower.json
  selftests: tc-testing: remove filters/tests.json

 tools/testing/selftests/tc-testing/Makefile   |   2 +-
 .../filters/{concurrency.json => flower.json} |  98 +++++++++++++
 .../tc-testing/tc-tests/filters/matchall.json |  23 ++++
 .../tc-testing/tc-tests/filters/tests.json    | 129 ------------------
 4 files changed, 122 insertions(+), 130 deletions(-)
 rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.json => flower.json} (65%)
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json

-- 
2.40.1


