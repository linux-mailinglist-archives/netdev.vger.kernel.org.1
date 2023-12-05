Return-Path: <netdev+bounces-53994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 753858058BB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A835B20D73
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F55F1CD;
	Tue,  5 Dec 2023 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SsWGdpSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6735BA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:30:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce28faa92dso23225265ad.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701790227; x=1702395027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLmURYpAhDgCiKukuJU+wwugu669LleWtssEH22sc1c=;
        b=SsWGdpSHtoEThRzT1tQQPwrBu9PSWZ1dHkmGvvB4qhsNjHtGmA3hqWJ8Yp+9IvY6GU
         VF3B3Bm/UMCdFyGgB+tQUuBSaQRuPDWPLtXVhuTvDYKv0fp6NsaRrWdASUDUX1jbODL2
         ih4Co6ZTpLz4yIYkp9Z4oaF6nZWHVxGKub6Vqx5rVsQwjH5UiDZRPpsnplvl0Y5U10rw
         kXRREbsZguytppmqrW0xQ5u9JVi6B2hkohQ/jwNGeQEgUW1fbnpuXzzSR3p71SwCpIun
         ojqkQczSErNOnuvdaUIGdSpqPNDHx2LaBxCHzYx/+/jqNoVj8iSTCNNLQ8QsC4UlGZwB
         WZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790227; x=1702395027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLmURYpAhDgCiKukuJU+wwugu669LleWtssEH22sc1c=;
        b=vtD+bZYwZvZj6hIrHrNSiOErCHOmugEpcmp2UR74RSQDQhX2YQWqpd5UFUkDVyb7wJ
         xLsqjR1ZmSKbc7e07h1dSvNq2QGPAd0Z7xsocpVO6FkX9IOoRmaJxoRTXMXHITBWNmXK
         Shs81YqrWkHeC5AfJyhoL9jzqvGs/it8fbr8zqp7J/4QajtFZgO7YAa6vN9Eo/1Cexuw
         RT9Zg5GafdaoP5Tf4T7mCkuZFyFLHu50nX99T+SVtICM2sjNUEypMw7P6chtPESOjG2G
         Di+R/cW9WMEyufygPudsBu10y0qPlXN30hv249drpqbH5arhiGdK/USuie6BEVBYA0cs
         wr4A==
X-Gm-Message-State: AOJu0YxgHJY/j9+8zc6jNiF2tIKWMH9gFkwAxy6mNnq/EmftQ/EOZcSa
	HeJQQfiiDo6F5GXyhWivVcqySLg9ZGDS8lCyfus=
X-Google-Smtp-Source: AGHT+IFQKKALvmdSJ+/5AfDuaqrPR7fqlgeoysOYY+9LODIKSdqLyNJ39weF6ACQcYsViW7NbD7CxA==
X-Received: by 2002:a17:903:41cc:b0:1d0:8383:7433 with SMTP id u12-20020a17090341cc00b001d083837433mr3046638ple.36.1701790227185;
        Tue, 05 Dec 2023 07:30:27 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001cfc34965aesm10384427plq.50.2023.12.05.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:30:26 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/2] net/sched: optimizations around action binding and init
Date: Tue,  5 Dec 2023 12:30:10 -0300
Message-Id: <20231205153012.484687-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scaling optimizations for action binding in rtnl-less filters.
We saw a noticeable lock contention around idrinfo->lock when
testing in a 56 core system, which disappeared after the patches.

Pedro Tammela (2):
  net/sched: act_api: rely on rcu in tcf_idr_check_alloc
  net/sched: act_api: skip idr replace on bound actions

 include/net/act_api.h |  2 +-
 net/sched/act_api.c   | 67 ++++++++++++++++++++++++++-----------------
 net/sched/cls_api.c   |  2 +-
 3 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.40.1


