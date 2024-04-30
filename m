Return-Path: <netdev+bounces-92636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A48B82EA
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968022834C2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD81BF6EC;
	Tue, 30 Apr 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTkcoa9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149C1A38DE
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518876; cv=none; b=Kc/lt3eIhcF2UBoW07BPN7A2Zp5wenRd/4g4eMT+Mwv1W7OjOkhquHmIKd60L9Fx845ZdaFrtk2MeBXi7q7GhiiAjlo87nZdEdz2Wkh2zLpgMq3QUQEfOI+9nEb054exYW4eElC7uNWVXHo8wSGErph5zZv1DZhabac5cbv4gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518876; c=relaxed/simple;
	bh=qe/WzovKHOAqR0NAZKzVmgP/A2IZzLAr52a/lPyhm/Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L1X3O8JjvDNnwTaqj0zMU3Mam3E3eHMyWCyTmtwADmofcG3gIfxI4lIdDMTpog9dy/Oj+tAdpsW52t9LyxrkaftLsROy779pm+dtkNWuhcXUyRjCKvQucp7c+I/5pIn7sMKzktEBugvc8wLLvmmEvIROsZdpfGD4yTgtxC5Deq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTkcoa9r; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61acc68c1bdso3636267b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518874; x=1715123674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwOiXEvSAp1Jx8Vi47U0K91IVJnqi8blxHUPPbC4sDE=;
        b=mTkcoa9r7nLJUu7ciV0f8Zig3hEyKNbKqNtYBUJXP/897S9pd+glvCqfmXuVJKo1Fr
         D3wPeQWJisYXBcUa89l5ASjqv35Nz959hTyIsgiprloekzaeEacUU4N+LDbVlhCFkLem
         V3cQbq9gehc0aG69Tq67wow3oWwUbQKnplfhXR4B1BuV6P+bQmyG3+9eeJwcJd9Pw+xN
         vc8mH5W/eM5Crh4NNqZPADjsjqYkpUSwBr3uAA+g/lls4NmAaQx0MUF7+gMbx2JfHZEi
         NekaPYHF69ntl/r+Cw6xfIqcghJhZc1/Vkf8g3e1czv6IMioFwbHbPxH6mu7eGyKYg0P
         PkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518874; x=1715123674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwOiXEvSAp1Jx8Vi47U0K91IVJnqi8blxHUPPbC4sDE=;
        b=F+GSK9/VfacVv+EJ5sbFvXhZujpZhm8uHjNIBxhK1R8X8zvxuv/HDxC3qkkKgSE3eU
         jW9v6LOSdAqNyz2cIHDAjFinhGBfwa+rT+3Gl193vjcfN9m1YSsdYS3rUaEM+Ua/uh7b
         LF4Ax2BWVVzQBRSAQTFnqDYNHZkzdULzgH8hWWrJQmmdkno7AtZWBH7aJiEUoyohth/l
         FoxkWX+IDtuqlKBg24xYY13arqxutXFVmEj9LG6jW7GIb9dkNonc1Pwz1dCdyOtVNm9I
         gzc8Q7WSM47n0B4LPlEtZpYiIl1jcAaNc6T82RycWX69KeyR8boelpuMuRmMugi7yTNt
         mg4Q==
X-Gm-Message-State: AOJu0Ywl6l5Sj15hJe0jn7et7axGl968k5gylxyrn4QaU4URKgBrNviQ
	I8N5kpYQWqKHxDwuh/9wdL8tHtF/dwGxyqDhK8IHOWk3PrSfqOPWtjlz5tSQ41zVtCFxJbpRN+U
	aYbKN9w6w6rzDDwJI+k4GDLtpi+7Ex8I8R3KwlB48vL8VBSpNjEHvj1FXGnKXdKXfWYvh9iFtoq
	kIbb6rwR+mGt6IoqDaSk1tOxTTI9iapkVEml+GsEOReZc=
X-Google-Smtp-Source: AGHT+IHVGM0yIJnEI1GIxKWpKS1vvJS7awZ1CcrNJ6yPJsBTlSm0oWaG0q+jHuNWnnsQFt3pKDtb2ZHcQdOdZw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:c543:0:b0:de6:569:325c with SMTP id
 v64-20020a25c543000000b00de60569325cmr905070ybe.4.1714518874257; Tue, 30 Apr
 2024 16:14:34 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-1-shailend@google.com>
Subject: [PATCH net-next 00/10] gve: Implement queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
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

Shailend Chand (9):
  gve: Make the GQ RX free queue funcs idempotent
  gve: Add adminq funcs to add/remove a single Rx queue
  gve: Make gve_turn(up|down) ignore stopped queues
  gve: Make gve_turnup work for nonempty queues
  gve: Avoid rescheduling napi if on wrong cpu
  gve: Reset Rx ring state in the ring-stop funcs
  gve: Account for stopped queues when reading NIC stats
  gve: Alloc and free QPLs with the rings
  gve: Implement queue api

 drivers/net/ethernet/google/gve/gve.h         |  37 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  79 ++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   2 +
 drivers/net/ethernet/google/gve/gve_dqo.h     |   6 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  48 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 570 ++++++++++--------
 drivers/net/ethernet/google/gve/gve_rx.c      | 130 ++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 137 +++--
 drivers/net/ethernet/google/gve/gve_tx.c      |  33 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  23 +-
 include/linux/netdevice.h                     |   3 +
 include/net/netdev_queues.h                   |  31 +
 12 files changed, 679 insertions(+), 420 deletions(-)

-- 
2.45.0.rc0.197.gbae5840b3b-goog


