Return-Path: <netdev+bounces-206459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55DB03321
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723F5189792A
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D47DA6C;
	Sun, 13 Jul 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAv5y2oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61DEC5
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752443287; cv=none; b=LD/ltJAacxH8e0p1sq2jtqSO9794eB1pc9hHXWGEWq/Do6Wma+AQIInvwXN4r0GQ/iU20rnAIdWO/Xy0AmdVe3DQW9WaRbwgDFNlSv5VZAAjcI4UAaEsEYACZVDMHTZ/yqPzI1TmlXjx3QyIkewBi0vLQbHVgdicnBiOfzQjEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752443287; c=relaxed/simple;
	bh=rIxI758nOS4KLLEpElZJgvF387W1fF/xqG+h+DBmP2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gN2cAGx5FSrRfg5KZsXvtDP2RgCA1nA7Th+1HRJ7ddMSRLV22Q84bBYt8U8MwB/dFo3Q7wHD8cB4H8xVzZcvuAZWrlnnfExGNgaBl6Rm1mOMWVSL4MXEhQQ72f/tpqZVFc7JO2CaWCyaPDCj8w5QNiwWt+I4TZmPSiMIX6HIv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAv5y2oe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7481600130eso4242129b3a.3
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752443285; x=1753048085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLQYVdkxs8yiC4r4Uw2Fh4mnqaeis0mdFpE//EzPQ/w=;
        b=XAv5y2oeDLTKeE67oadzs0MREFT4Z0uR2MKxmw1wMsdMt67SdiKrNF7jL2Ccaev1oP
         yKwSIShodC2d/P3EVSpIn+jljN2hjey7vqDXpAI8Nvmtx4MhpyAnTdp93i+SgSSkVC2I
         +OYZurYLOS/7gYYnOJnfROjWDkZxmptAe5UNSBJQ1qvRZeDB5JLfzJOC953BR6sP8b5Q
         qMaMCkVGaQc1RmvLv0O87zqfJvCaSLIwUhD/RUch5acwUE1iU7kPsKaXavRgjp/8A3F+
         o/NU/4U9zXbuylnMkVLxy67TtoiAtQnZlTDpe2dOu0Orp0n8wMXIU6v2khyBnFDTlYRB
         eeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752443285; x=1753048085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLQYVdkxs8yiC4r4Uw2Fh4mnqaeis0mdFpE//EzPQ/w=;
        b=ieCugronCjCrkzLywYCZTHVeQilIy8vd+h9d/ve12B5J0FisTyPFuo45DqsoBwoakS
         LcFVs9DkAM1u2acjIJNyArabBH2nzhQ+CjqvaeSo1+hw6ZogXfSb72T5MlgLK9zO5v7i
         GdsHh1k7PBghB+wdhvK5h/l9HfyCeX6YT7MGoEobrzrXxxAclBEc7aB4vAPTS65Sjzla
         K7u2qtfNDe8DDjujNJxOLc4TWU2h7yAvVn9mYoJt4Dr4yjPZpttp0vS/mmIuINw3HIv+
         M+M62vUOyfEmuNq9TRm56xaVJAMMY5xx8Jct3+OAw+H35Gs5WM9bj5po602dszckqW0k
         41mA==
X-Gm-Message-State: AOJu0Yx/Y5qyAIAX0eMS3JX93Rka0NG0Ab/nRSMmxRlsjK5LBzY99hd8
	SnQzlNE8oz5CSleHtOOhLmJS/snZxZ1GSNt98LmJgwdQVkPpar1/lEtIxHsJ1g==
X-Gm-Gg: ASbGncug1Hg3A0Vg5htcpMF01PgDdWMVNdkKS2DTT51PUySKvzqtTooVOEWAa6djSib
	mo8nPsnrcZnU0PZfbLVOfRt8OteUqtIOCKovo8/YuzCaSTzLbzpqlu+VuDIfBAO0EBIccz+1JmF
	zrROtOCSK0ILrMAyKkO9q2KilK5DhO0W9W9R82TR2ah2AfCbY03BK5u2Dgi9BLp8Ih3kcokdkPd
	DNer4u9IemDKBKJmiEmNj5gc/1RnsQbcgSIn3FIZvQvM7f1IoUh7Yh8PaKgTDco/MK/AwYPDldJ
	i8SIwZHJ7yxd+qaz2htS3/2h6Ck8ySISkxijcWpyr1Jr3wsG/QkeD62kjIvHsPTCmxUwQ5rTsvc
	ArG/lhVysHO5oN/rR8e3rVFjb6Bs=
X-Google-Smtp-Source: AGHT+IEl3KhCG6qrFjZh1ZUBFehH2WQaZg3nvYR0sIC1QlFn22pq+vUUvHzHZb6dzApTcwmRnZhfEA==
X-Received: by 2002:a05:6a00:1304:b0:747:bd28:1ca1 with SMTP id d2e1a72fcca58-74ee04ae627mr16957092b3a.3.1752443285130;
        Sun, 13 Jul 2025 14:48:05 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f1fd0sm8628370a12.53.2025.07.13.14.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:48:04 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 net 0/4] netem: Fix skb duplication logic and prevent infinite loops
Date: Sun, 13 Jul 2025 14:47:44 -0700
Message-Id: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to duplication in netem, the
real root cause of this problem is enqueuing to the root qdisc, which is
now changed to enqueuing to the same qdisc. This is more reasonable,
more predictable from users' perspective, and more elegant.

Please see more details in patch 1/4 which contains two pages of
detailed explanation including why it is safe and better.

This replaces the patches from William, with much less code and without
any workaround. More importantly, this does not break any use case at
all.

---
v3: Fixed the root cause of enqueuing to root
    Switched back to netem_skb_cb safely
    Added two more test cases

v2: Fixed a typo
    Improved tdc selftest to check sent bytes

Cong Wang (4):
  net_sched: Implement the right netem duplication behavior
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for piro with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate

 net/sched/sch_netem.c                         | 26 ++++----
 .../tc-testing/tc-tests/infra/qdiscs.json     | 59 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/netem.json     | 25 ++++++++
 3 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.34.1


