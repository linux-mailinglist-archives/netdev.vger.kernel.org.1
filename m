Return-Path: <netdev+bounces-71379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7D85321C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B84D1C224A9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC73A1D9;
	Tue, 13 Feb 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuSgXzQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8756444
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831746; cv=none; b=XWnxfI7D7xN3dcwyP6kiGbF+dlmq4Qpm83sbZHtNctrXFkhSVbSg0c8UK6E/Nhk7H3vYhhRQoB4fPOd/duPdcIMFEMZQxp1fPUdbdlPGJozSmUBVo+116mikA/k56RVTosXq9luiuVqJMvohaFn2Afjbe9jBKL7KfMg6zrmQ6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831746; c=relaxed/simple;
	bh=UsewyOqdaVBvnTM+01AKKfNtHxmHFr61XDfT5dexoPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TL20bnjRXeFzX+MIY5fTHDsp9s9W93bW/yfZ5BjUtpBbRLzT8KhfOHyW2tMtt2EoNYfaj1dnA4EQ6mJQNoHJLb1G3I3lVpJcXZKtvo9vJzjbp6RVXhzhU4J0DLLC0FnoZPs6eG0qWmrV0Z2x0LBkG9DA0zR+ZvQ8jh2u7JerIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuSgXzQ4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso2017148b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831744; x=1708436544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSMkhCkKKpDhWnul0rZ1JtXn7l83fMeVCcAn01e7ffY=;
        b=VuSgXzQ462ZlwwkMCEQj3ehpSTwTPC9xi+Mgl2WYajK4ZG4jVQiYNAUBzU9UBIBWMC
         8U5F2Xq/UcvS2ZZjyTMPDfT09IPXczsPqs1qHPo7oQGJGAoE2f6X+q/lkYgESlkBBiFN
         NKf+6lcraYekJfQHZXOyoCJWozdeMypMI7WzmzGuXLaxN2N84D77IVIUhu9TohK4GNNZ
         ch8q+bgwzjLScIp6ezBl2kVGS/nyHehcRSYioOsKfQi31BDy84zvkMN8KoHKk6u3Dwm4
         JcBhdbAf5Bfs7hHEzQdAcZnFrFID31g8zZJUPi0nm503uLi9lKgTaDzYQT6455Rdaz9I
         GviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831744; x=1708436544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSMkhCkKKpDhWnul0rZ1JtXn7l83fMeVCcAn01e7ffY=;
        b=U2chhKaa9GLJLAWh6hP131Ad/7zVGqkXfiVxHW2atz1hyZvaf+CPf1E4w7dbOayCwd
         nE/7iItA9en0gSC1Caav10lxL2qGDtn5j1ekz5uaejj41qmtf/AamZU0cudbQYmOgwzS
         9ioGXWt0MyHm0w81UH1aJz3ysi8ekCEb3NWCJfip/y7NA8mHMMKUmyOGanHqH3JNk9K3
         Z2cgsiXy/1vxlebV+xEJl0AE+1ETUmHPYNBgZoivoa7V2Y2SqQuXB3JLBie7d0xthsr+
         9DAAomO4gWX2ZVX9xm035US6dsvYSk3eKKG2bXEqfOnfUTVr6KV8W25OFnIwgsG2qmH/
         HEjw==
X-Gm-Message-State: AOJu0YzjpU+v+b4TinTYPHG9uR8iAEdBWI5qDqPN2XYDEsOL3zVkgUBT
	h+U9p1X0xpREa7c/cDYoar/0a7gnIhPhwc70RmsgqYBZ50B3XJUg
X-Google-Smtp-Source: AGHT+IGxShfyL+QZ4FagOv4T2zGtPXcmQUWjieSuQhw70BmUhn4ycsHVVWYRnCVmnksGmAvQYvi+Mw==
X-Received: by 2002:a05:6a20:d48c:b0:19e:b1c0:5bb4 with SMTP id im12-20020a056a20d48c00b0019eb1c05bb4mr10764689pzb.47.1707831744050;
        Tue, 13 Feb 2024 05:42:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+n0uKhukGvGi8MKu5wr0BJYhYrr0+2+wQKSGUhVgTxYdv55B/2eOWtNxAWlVoR3e2b8FbrsQDoHmBIuGLgfRK4868/3qHgfe069xyd2DvLiszrYADPOGYL9MalqFWRU7UquDJcKvFx+ubU6fCNc7CcoypKiNX6ak/dT3047g57vnJEeaROg6cFSIQmwWMLyYQPSH6kSiS3hSJjZuOW4Cqr0csWs83FJ6LW5t1tfG1KtDm2RrNUtJx99TvC1oINs3C
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:23 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/5] introduce drop reasons for cookie check
Date: Tue, 13 Feb 2024 21:42:00 +0800
Message-Id: <20240213134205.8705-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was debugging the reason about why the skb should be dropped in
syn cookie mode, I found out that this NOT_SPECIFIED reason is too
general. Thus I decided to refine it.

Previously I submitted one patch series which is too large/risky, so I
split that one series into two seires. For another one, I will submit
later.

Summary
1. introduce all the dropreasons we need, [1/5] patch.
2. use new dropreasons in ipv4 cookie check, [2/5],[3/5] patch.
3. use new dropreasons ipv6 cookie check, [4/5],[5/5] patch.

v4:
Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
1. Fix misspelled name in Kdoc as suggested by Jakub.

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.


Jason Xing (5):
  tcp: add dropreasons definitions and prepare for cookie check
  tcp: directly drop skb in cookie check for ipv4
  tcp: use drop reasons in cookie check for ipv4
  tcp: directly drop skb in cookie check for ipv6
  tcp: use drop reasons in cookie check for ipv6

 include/net/dropreason-core.h | 21 +++++++++++++++++++++
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           |  7 +++++--
 5 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.37.3


