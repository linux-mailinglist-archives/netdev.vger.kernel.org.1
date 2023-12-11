Return-Path: <netdev+bounces-56022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D333680D520
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E61F219E9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F45100A;
	Mon, 11 Dec 2023 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yHFDyAXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA019D
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d075392ff6so37023125ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702318712; x=1702923512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1R8ruOJwLygU0KnRvD7gjerVvrePJsG55q91CnU+v3g=;
        b=yHFDyAXvcswMaONaNHjuDu5teuAoDv8/IQNqMPO2aU1VKcoeUYhHQBdG1WX1hO75u+
         gnpOu8sYWSKdS8EvadCRJk5Sdt+p1vV1YgBzwa41/A03RyRMyz3W2EmvtwlubnpFP75S
         yhjNm2sqigWNhRXHqWgbIRsX9iYUgJzbDYkdtxZqcKN0H7TNUrLGRzdZLNbsJov1g2JV
         PlApeeI5ilHxc4MH8fu911cr61rKxxwEDAmNZ7XYjWHdShfpB9II4sdEhPZnF+TlwuL9
         p2/ICK2yc680DBcpUFKqswKnOHLl+HajN3AtwVhAACv8IwfULxgunZv5UwyULq77OHNy
         0n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318712; x=1702923512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R8ruOJwLygU0KnRvD7gjerVvrePJsG55q91CnU+v3g=;
        b=IhNPeBIG8pmqoOD+PEsGODoTtdnoRtKcOxw4VrArAsAxb6SaIOcqf/k6ie/VIuVyGH
         n9/SJD7RvM7Q5PqQI00JjcDB+8LCf7ygTbCOQYnI4jrTnQVYn2sjveoL6iZ013ZDVgKS
         r0mBrR2W6eLy9ojXFJJH2ofmwSvQLqS9SwGsQr1yMlX0DDWUg1yY46eJh8I0MNXJdbyW
         PzOtE0nTLe1LvyMc9XPX2fsIrE/U6jfyjkpQZwK6YA1WOyMEXnQGtC42XM6yXMz86Wkk
         xXc+Vm+iT0xljT1URG2Of1KyoCTOTdsjO6g+H8fg1c8D3k8K+PXQ30RXvV8+36/o7YjH
         jcjg==
X-Gm-Message-State: AOJu0YwFN9mJf6ESZ2ECOdl0G/jqOp0ly72Di4MNpvN66VlMBG1jQzvP
	uAncexy9Cibinqp8szJMvjIyJotzNozi+Y4e6gc=
X-Google-Smtp-Source: AGHT+IGDb8Djwa2IaJq3fGO70miEp5lwRS/FxQ6DxUQ8os0NoKAfZ+3bKDRgUopeEiMvrVdNbkZdAw==
X-Received: by 2002:a17:903:22ca:b0:1d0:700b:3f7b with SMTP id y10-20020a17090322ca00b001d0700b3f7bmr7538537plg.53.1702318711778;
        Mon, 11 Dec 2023 10:18:31 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5756139pgv.37.2023.12.11.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:18:31 -0800 (PST)
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
Subject: [PATCH net-next v2 0/2] net/sched: optimizations around action binding and init
Date: Mon, 11 Dec 2023 15:18:05 -0300
Message-Id: <20231211181807.96028-1-pctammela@mojatatu.com>
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

v1->v2:
- Address comments from Vlad

Pedro Tammela (2):
  net/sched: act_api: rely on rcu in tcf_idr_check_alloc
  net/sched: act_api: skip idr replace on bound actions

 include/net/act_api.h |  2 +-
 net/sched/act_api.c   | 76 ++++++++++++++++++++++++++++---------------
 net/sched/cls_api.c   |  2 +-
 3 files changed, 51 insertions(+), 29 deletions(-)

-- 
2.40.1


