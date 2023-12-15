Return-Path: <netdev+bounces-58074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D18814F61
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B44DB2464B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DD3FB1D;
	Fri, 15 Dec 2023 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EYaLE286"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B447767
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c664652339so628215a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702663060; x=1703267860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cC3qIY7fgUlPmVk5BBf4sPopoT6JSZSLBmCXtEI2go=;
        b=EYaLE2860Wm8qtcuGQgiIAjBoVFLhwyuQ5fW/ffogRZVmODnr0JqWucXNK/B1wTJ8U
         VgHQdXEDkedKwHv01Ir5UdnaOAvfyLzcRNHf2XGidTa6H5CY/qdpntFz+fuqN/7bt1lx
         xalJmHHgF1M91EWZIeMjZCHfkCrkcAJ3wh1b68avfFAzJnvQtfsK4CGRqDaIhSp5JvIp
         KzP3f+aVh6jYTHcsRvEnc4DR6Y1RB7KVyIdk8PTEa0NAlDd4Kc0v8Hn2B5bHPtzOV79z
         ZmWJD3mrPuvFOZmsCl4HD3pfz48JQKMmdjdjcraeqcJC3SR4QwX0NMSNsKfJUeJJx/Mk
         oeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663060; x=1703267860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cC3qIY7fgUlPmVk5BBf4sPopoT6JSZSLBmCXtEI2go=;
        b=d7nt0wchT9OhHlRo8otNPyQ67OoUeOXSwpHkNoUepK94E/7AJqq/KHNoHbp9hG760H
         V11QEFFD/yHHkDAwSdbke5tAfe245S6PSvFE2dCUWyYErFTtpseITWbRLuNJl/n8nk5p
         e3BeSCouuz101bBN16UjGkTL7HhG0HQdshInMihLrxq5zEI7GH10T2bl+5M45rMhMM1s
         t2u8WGOydbWu9bOLVzB2a9GZ7Us6PbsllifE1sqTrOWGBoYSS6diTsAm2+l/fm9h26ka
         Zgs6Y2pQBjkQyRBxDSlJLdQ9es+NG3RKDBS0zlegnwb0Mm0nFxuUQ1qQ3Ax9A1+RZsNJ
         v9PQ==
X-Gm-Message-State: AOJu0YyPGE/Zo4SuUsPIsAfyeaLyB/vLJro6M2kEXXFZ0z5z6jXaoTQS
	pNMpkWjcvbBteszdXMEr9Q4ecQtbWATqbUXCuh8=
X-Google-Smtp-Source: AGHT+IFUTVRqee3UhuMf7btg6ZfWEwlsUz9HEYdzAVjIdsGRKwYtJ3echGo/VGnwDhPGc+vk9iP28w==
X-Received: by 2002:a05:6a20:1047:b0:187:1015:bf9c with SMTP id gt7-20020a056a20104700b001871015bf9cmr6750596pzc.10.1702663060432;
        Fri, 15 Dec 2023 09:57:40 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id sm9-20020a17090b2e4900b0028b0848f0edsm711799pjb.9.2023.12.15.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:57:40 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	martin@strongswan.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	lucien.xin@gmail.com,
	edwin.peer@broadcom.com,
	amcohen@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/2] net: rtnl: introduce rcu_replace_pointer_rtnl
Date: Fri, 15 Dec 2023 14:57:09 -0300
Message-Id: <20231215175711.323784-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the rcu_replace_pointer_rtnl helper to lockdep check rtnl lock
rcu replacements, alongside the already existing helpers.

Patch 2 uses the new helper in the rtnl_unregister_* functions.

Originally this change was part of the P4TC series, as it's a recurrent
pattern there, but since it has a use case in mainline we are pushing it
separately.

Jamal Hadi Salim (1):
  net: rtnl: introduce rcu_replace_pointer_rtnl

Pedro Tammela (1):
  net: rtnl: use rcu_replace_pointer_rtnl in rtnl_unregister_*

 include/linux/rtnetlink.h | 12 ++++++++++++
 net/core/rtnetlink.c      | 12 +++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.40.1


