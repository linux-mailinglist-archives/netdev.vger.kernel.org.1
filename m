Return-Path: <netdev+bounces-89397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9638AA39A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EA0B298CD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641D18131D;
	Thu, 18 Apr 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKqxI5nq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703817B4ED
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469935; cv=none; b=WON7PBbFTwpt9FgdRVTQVwDlArqcMvR8RCFDgFhavnuqET4hXYK0Xqk+eLNtJJgpaCUjK9JxVwdM+h5IJho2THed1BcFAhRf8fkf8PrazCRsHBQpjBydkpA1Zb7a1q33ILMV5GxeXbjJ1cNtWq71IvrNjnDAKjxwVI4qSl21hX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469935; c=relaxed/simple;
	bh=4RNfOBr5nqELPj6sUi2A+81JS+EfTHxWt9g5RtNPAmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ey6r5NuPFq+k5+1ehT2aMLebEg94ZBbTUGb9HG36EfJAeO/ns8z/FttLQ606MLkAfODfVOhs11sfSeY6vgti36rmy0stU+fhXVd6bUPeav4azaXyoAUXSKov2KzLQPUG8OXB5mOpF1EEQFqzzBpw3fdJunpChatXOZERM6eRTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKqxI5nq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so2246738276.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469933; x=1714074733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd+4GgJRGKxU/QWd6mgfFt8NB/GIv5aVw3cJbYsN/AQ=;
        b=TKqxI5nqYxTttBSGMsQstKjLk6hbRtiso4vdy/r+8pkaZsFEAIrvWbo1FW93YNx+xS
         Sy9KDYkhn1EoF3dstHJ6BhMgOG+2KGxG3gLv7+2RoEHvYilsAIQv+pKcPTUk9oRthJ0x
         zr0oGKoy4/m25DM9orw0k8O9qvKdR3KYWzekbBpA5FBSu9H1M6ejhCm1F75ZHM4s49JL
         rxosukm8RmpkDXU5xJLLlMLhmH/CByy24oJHI4r6jJhg8SpaCrSDxVdbwva41UzO7tIt
         JRecWWME7MKXkqbJC2bGwNxRerA1q9TH+5HLgv58TZdzEZaehaXr556DmoTMuwT290gf
         Fang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469933; x=1714074733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd+4GgJRGKxU/QWd6mgfFt8NB/GIv5aVw3cJbYsN/AQ=;
        b=u/JOHoPQ/yfugzIKaEw4q5AcvUR1UT9IkMqtsPmMfk69UFDshazQ6nbyltEHZL/6wt
         5g4wJcu+wOQGGMaQVK9mch4gbbkStTKcbAo1SB/JGexqI0LjZ+BHSiOiSEVTyW+0A6Pe
         lrMfc5wLpe2zp6xqqnGGLjZpO0qwXXHM6FF0w2O7eAcU55oY5xFYN5PekEmxf/8QBZN/
         AfEF5bTxh/0HqB08I6Lyh+o6TWxfL76GrWu+4/yGj9cJ5IL67bQU4uerzXASowmKReIq
         X4EFCZ7irzOGtPwcRkxYrT5YKwskSUdsQiE/cA4MpaUox2k7odH2VaCtz9nFoFtlY7YV
         2FJw==
X-Gm-Message-State: AOJu0Yx3B3bxjUCP6S4Mc5kFxvOHSRlSTwIxuf3ZrlWoRU2GGiY+yv56
	3/kWJMR/47guGAT4OqOvfxmXotMCtDwsuCQmVVV+5CI0GJspm+CrFqAdCbwBIAYgmwe3EAFEnDV
	/dr0xXWBKHSb6UD1F6lAv9BmBTkqwNFGPcKDxg4L6CGoG3AiLcKY6j+y5c/tDmvQXUyRjSfK4jf
	tGPitfJqswinEuVaynVhz1HsASLdG+5VNrsYKCd5ivtk8=
X-Google-Smtp-Source: AGHT+IHh5NbwwAoI5T50Nl02L5B4uhp8WjA/Fkb6OG5VxQGtPz16Rs+7/nqlpKBvfPavHQPbrhdmWmy9oXkuBQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:1209:b0:dc6:dfd9:d423 with SMTP
 id s9-20020a056902120900b00dc6dfd9d423mr430464ybu.3.1713469933121; Thu, 18
 Apr 2024 12:52:13 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-1-shailend@google.com>
Subject: [RFC PATCH net-next 0/9] gve: Implement netdev queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the discussion on
https://patchwork.kernel.org/project/linux-media/patch/20240305020153.2787423-2-almasrymina@google.com/,
the queue api defined by Mina is implemented for gve.

The first patch is just Mina's introduction of the api. The rest of the
patches make surgical changes in gve to enable it to work correctly with
only a subset of queues present (thus far it had assumed that either all
queues are up or all are down). The final patch has the api
implementation.

Mina Almasry (1):
  queue_api: define queue api

Shailend Chand (8):
  gve: Make the RX free queue funcs idempotent
  gve: Add adminq funcs to add/remove a single Rx queue
  gve: Make gve_turn(up|down) ignore stopped queues
  gve: Make gve_turnup work for nonempty queues
  gve: Avoid rescheduling napi if on wrong cpu
  gve: Reset Rx ring state in the ring-stop funcs
  gve: Account for stopped queues when reading NIC stats
  gve: Implement queue api

 drivers/net/ethernet/google/gve/gve.h         |   7 +
 drivers/net/ethernet/google/gve/gve_adminq.c  |  79 +++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |   2 +
 drivers/net/ethernet/google/gve/gve_dqo.h     |   6 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  13 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 200 +++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_rx.c      |  89 +++++---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 114 +++++++---
 include/linux/netdevice.h                     |   3 +
 include/net/netdev_queues.h                   |  27 +++
 10 files changed, 459 insertions(+), 81 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


