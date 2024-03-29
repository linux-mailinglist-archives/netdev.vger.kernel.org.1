Return-Path: <netdev+bounces-83358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C8892141
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D6EB21240
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358571C0DF3;
	Fri, 29 Mar 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrEWWNEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE51C0DCC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726950; cv=none; b=Oxp/A/dnNuATfg7NNfXyNjggeW3WYd86ZMzMquuER1FW/BzubLY6/tkjgXTT5Hr2n3BDZuJ8vNF44WyY9jSeNLkZz7krQpoNCjHIM7BaYPgud90mGT7hv2EZfuZNmAuFyOJRsw13eIHMcpNqcTQuRvVZc0jXGgeRLGw4sw9eJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726950; c=relaxed/simple;
	bh=Q1aIiiTvZUHCCY7f1tQ2XhaHnfGTBN/MGRGkfB9w+vY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j7w1vBYaXxdkfP9JnqbkN9KaJ6vDEwQ95ccjA+ESoZyFDiAPmeBNxOrwcfI3ghZQ7D7hAl01OQnu2Rw1FctNXh6YuZhwPKYlIi501WxyJSU4wFe57daET28y/2dCjS3yLJj7Zf5Uel48xKzDaP2sbCkEEXmcA8J+TrEaKxy4C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrEWWNEM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso3042919276.2
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726947; x=1712331747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIqaPdLLyO4kMv9x7Tvn3UdOtxtcOUtnCOVpVlu2/Ow=;
        b=xrEWWNEMFaCLLKqwNF3CXOZHCSwoyOHo/2MS57wVVWun29QyZs+GQPDxH6DL/8DtAB
         f6Ttjcmzow3Zu401SF28demnj0VbxezErLVQfHXNtatCmmJgKtxb1SX123k4s3rX1Tdo
         uBOuEe/gSLAQzdIe/P89kWtXE1PiVphAHmEuN3jEsj4S1gKReQNpK1f2buMsnDYEd/ya
         nXkHscLgF5IjcMUViqPMRBgP6KnIm8aeqEzr8b4JgcxVk6snc5Ku1M1w3akWMBW63N1V
         oh+j8RYaaRW3wq68oH4y2la48QkhJ/S0h14JBAWoRg76rj8mT2MXsdJuHgNKnhqXVD8b
         HoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726947; x=1712331747;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIqaPdLLyO4kMv9x7Tvn3UdOtxtcOUtnCOVpVlu2/Ow=;
        b=Rl3kaa01lwFykhYOZfnqkyqm6i3eq75UOOFi4zqKHRSHh/4JQnWDI7KCPIK98ciKSF
         qrKgS2GbaKAVhgaiK7NkvdQlYPZ1wgW/geQVLwnUcASPWoxlhC0HAFjuBtPFBeYb6RHN
         2rEMz7UMqIBglLaEZFa/d0DxyO8dtRNDUzKXbBlRKCRYD3PMXdQKb+6NpXSDn9Uo1cBo
         7WPk5f1zy1GSi7fwVf2CJaaZwU8f3nhngw9i+E/wMwfVYcriDmTyyHcRxAI0t5nI/AIV
         dPHjTZRsk0RZL0ygYn8aXV/KIQN85VpIpAEFCMpzdQZ2LeUJWMfKGrdO/LO/W7ck+uWS
         ke1Q==
X-Gm-Message-State: AOJu0Yy4JZ1W7z4zo2qN9rw+VRwTzqUvpAx5vltgycfU3znCVLvF/TX3
	V6lfKFQehQYFnV5ihFXTD8ic6nZ++qIymEQn5dy1FhbKKT0hlsWRXIXbc5mDi0NpXYohiovOQ8u
	lLvWC0I1Qcg==
X-Google-Smtp-Source: AGHT+IE07ZWs02rfl7xCds+qF202lh2RZtlg+0kLsgfWypMKttaDk3bf4rlilakIuoqg/s3H6wzEoEACW3KScw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:248a:b0:dc6:dd76:34cc with SMTP
 id ds10-20020a056902248a00b00dc6dd7634ccmr192476ybb.1.1711726947795; Fri, 29
 Mar 2024 08:42:27 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/8] net: rps: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make RPS/RFS a bit more efficient with better cache locality
and heuristics.

Aso shrink include/linux/netdevice.h a bit.

v2: fixed a build issue in patch 6/8 with CONFIG_RPS=n
    (Jakub and kernel build bots)

Eric Dumazet (8):
  net: move kick_defer_list_purge() to net/core/dev.h
  net: move dev_xmit_recursion() helpers to net/core/dev.h
  net: enqueue_to_backlog() change vs not running device
  net: make softnet_data.dropped an atomic_t
  net: enqueue_to_backlog() cleanup
  net: rps: change input_queue_tail_incr_save()
  net: rps: add rps_input_queue_head_add() helper
  net: rps: move received_rps field to a better location

 include/linux/netdevice.h | 38 ++------------------
 include/net/rps.h         | 28 +++++++++++++++
 net/core/dev.c            | 73 ++++++++++++++++++++++-----------------
 net/core/dev.h            | 23 ++++++++++--
 net/core/net-procfs.c     |  3 +-
 5 files changed, 95 insertions(+), 70 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


