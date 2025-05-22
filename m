Return-Path: <netdev+bounces-192813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39696AC131E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622F11890C73
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88457F510;
	Thu, 22 May 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="V2vtiRdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7D1EF394
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937707; cv=none; b=H/HqMkQRyrbH4DzVDg3Ly5snS1EdbbTfRNxNqEsXStToMbOhlI0RKcjqeCnK/YA0u9vQKeXDpMqP04hj48dBTdQM6uES16TqlDeLYCAuWpEPS9o/s/SepQwTTySxbONlTD0DrOInNEY9sxuXZszMr8OYb/J6KYjyhy8LZMLsshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937707; c=relaxed/simple;
	bh=1639AByB5QtdAagpTpiQARa5DcZw3+47PwM+RXrYDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZouZJINMgnrG/1p628to/WEVMROkhVwriYUsz4cifIfzKEV7E923ws9CctWRqW5W0O/YsX/aUD+/5PG+zb+i0zq2uINsofhnYOXOnV/z/Mbp6llwedmqTerHDBA6kEAxh4tKmeyncgjo/FOwMoIaVEBPKFB7vnMNDqGxZvZqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=V2vtiRdj; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e041582fd2so2472436137.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747937704; x=1748542504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl2AXWX5EmBWaQb9ZY838sHKZ9pce4PmeqXM62E0CI4=;
        b=V2vtiRdjY/Z2dOgItCWnYPZXkp96mSWr/1A648lHf9yeZL2YXKDl/Cg4Gh9DiVBU6i
         w3eptV09kuUEXLGScdAnGp2t74vOmEunTFcJaAaEAQPNX6k5HJukBxdW6Ct/KpoDs8w7
         dthKGwO/uERSv+RuTjVlU2DJbXoPtcQDzFk8tmfREE0mrGBVXQ1rnmYJpLWM2cKfCpTq
         JOjGNoXOggyXksi4gSr5VqVvg73nw6pEf6kGCMeYOHUCCDiylUETP+zGtS0IInp9ljgL
         8NdT7SI+Xjasr0llX2usi0ZlhN0T1+DWJwx/90Ku+XAo1AehV0fAmTNySe6ynmomTuQx
         48dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747937704; x=1748542504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nl2AXWX5EmBWaQb9ZY838sHKZ9pce4PmeqXM62E0CI4=;
        b=LbOmE7IpErr3MvdhqfbZKaeKxJDJleULE8NTPaqu2AsN6JQfbbzPwAKIVOvGBjFwo2
         BY4OBTApaQZVSv2+ogPBIXG5kGUErgLyP0hO6hxrN9xBWW6gzd/9LPS2hh+YlAKBAbMF
         YNyymUlnH+my/yDcjgC9MI3cI1WeF82ZFahHpyizE5WvKaOWP3DzI1npJUJMZpEt9myq
         +qY3VxRjYS2Yeg+ktDvHK8Oms8scZ86GAbXpYu6BOBwJDC6yeeKpFeTZa9A+FRAVmFaX
         xHS2cTnPxGKNsQp7EpGmW4Tw6FQS0k3K0mmIEVTFQikp0FxPRubZiyIzYqJ3npMIQ2sL
         uQ2Q==
X-Gm-Message-State: AOJu0Yz4vmK4kLdFVQtSfcmCCvs8IIuKfkaQ3IJSLiiNBtK7rFacCFeE
	FDW8zM9lTQyG8OVza0in/HStPf5OMMXM9UIDdZPa1RojPtwPDluaSkYi9FoS+5OsqCa8rJ3tOoa
	LYp7PPA==
X-Gm-Gg: ASbGncs+NC63TqSUxm/Lf/pmE36EJ+FcW988kHU3I4iZCbz8QqHmnbya/hbVnNkTVLg
	MMa3oO5eZJXCa4/+WIshrnxmYn6noaF3oeuKgFdJeQGMXeqaMzC57TIR2Tx5S5ktxexarX4Rd1b
	iA74Ku3xhLqTw9JFjeuwh3sGPbymmh1az6Byb/3kQ1cOK4+svtqI+7/d6Gx7ovOIasvbkKnd82U
	DVYqm4W87jU7xifgEH+NX8q9gsz9emFJ4Ll/rBxCuQM5eeaOkdezXax456Ak1WPLuXr/2f8SQ+W
	e/soVIJBk7e2vNF8AxJQmlw0VicfHBrAEUOzBjgLqF3+ZqOQ8ScfHbn3Z9kZ8YVZc5jDpyFXaQ0
	=
X-Google-Smtp-Source: AGHT+IG4XE19PrYoU+ttzUiNvbElp3hDEERjY9IEVVOxt+KITEFFDZ+BAIGYA15SxN0RinjAOKga3A==
X-Received: by 2002:a05:6102:2088:b0:4e2:86e6:3785 with SMTP id ada2fe7eead31-4e286e63831mr11482057137.5.1747937704439;
        Thu, 22 May 2025 11:15:04 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e125de337bsm10573695137.17.2025.05.22.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:15:04 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v2 0/2] net_sched: hfsc: Address reentrant enqueue adding class to eltree twice
Date: Thu, 22 May 2025 15:14:46 -0300
Message-ID: <20250522181448.1439717-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Savino says:
    "We are writing to report that this recent patch
    (141d34391abbb315d68556b7c67ad97885407547)
    can be bypassed, and a UAF can still occur when HFSC is utilized with
    NETEM.

    The patch only checks the cl->cl_nactive field to determine whether
    it is the first insertion or not, but this field is only
    incremented by init_vf.

    By using HFSC_RSC (which uses init_ed), it is possible to bypass the
    check and insert the class twice in the eltree.
    Under normal conditions, this would lead to an infinite loop in
    hfsc_dequeue for the reasons we already explained in this report.

    However, if TBF is added as root qdisc and it is configured with a
    very low rate,
    it can be utilized to prevent packets from being dequeued.
    This behavior can be exploited to perform subsequent insertions in the
    HFSC eltree and cause a UAF."

To fix both the UAF and the infinite loop, with netem as an hfsc child,
check explicitly in hfsc_enqueue whether the class is already in the eltree
whenever the HFSC_RSC flag is set.

Also add a TDC test to reproduce the UAF scenario.

v1 -> v2:
- Added Jamal's Acked-by
- Added Victor's Tested-by
- Added a TDC test
- Called RB_CLEAR_NODE right after class allocation (Eric)

Pedro Tammela (2):
  net_sched: hfsc: Address reentrant enqueue adding class to eltree
    twice
  selftests/tc-testing: Add a test for HFSC eltree double add with
    reentrant enqueue behaviour on netem

 net/sched/sch_hfsc.c                          |  9 ++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 35 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.43.0


