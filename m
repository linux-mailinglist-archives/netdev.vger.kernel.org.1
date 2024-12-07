Return-Path: <netdev+bounces-149898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347379E80FE
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D121881BB5
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545691494AD;
	Sat,  7 Dec 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKiuvT0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48781AAC4
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588579; cv=none; b=UBilbUnBJyo1oD1KxKspvACnRYhXOAfMjiCo+zFWU07z4pGdj5PffMz5kL7a6eRknuLZY5dfM/bh/1+dAS4SIhflzhcfMytF3Flc3rCa/eLr07QtGtLfMztr6xgnZKvNSH9+leP1lpZwPoQqF0NX3khNB1gz8NTTI/5cnz6CimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588579; c=relaxed/simple;
	bh=zhO5oEg5At6PXtbhlwT18QCmioCBuXqfzExmAOQRJdI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LAslj5Q71dOy6mTrdvyi8slD8dFhXcEnymB78OtMAOeHyaw3bGVbzwK1kcXgh/sv4e6v+P33AMe2lUPqxXiFNqf3k2hfTGzRUNw7T6unIlxIYF0Zn7hT9UTQch4hI8Zl1ww0x8vNri9egSiBrYDRHg3s1q/e4zogrVLdfsd1QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKiuvT0g; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-466911d43f4so58982491cf.3
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 08:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733588576; x=1734193376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4TvG+p1C7qCnLqD+Fv8OolvBoauxFac0cbA9qC66rGo=;
        b=IKiuvT0gGqcO5WrmZz15a3FSwR1G5jlOG3mOt2YmTE/SLV+nskCPp1IuVVK7klx3kJ
         s3DjIBVDrFlLjicrF+Bp+C99D1O0Fb4FpXw8xx+nCcvC7JkNeIGp60ZQX5Lto3S9/S4M
         ainGcd8IEcUMPbCAS2gjJk+LR7e3tEftH81vxC/PC9DNP1AMBY0jLLXs8QaFG3Ld+r1Y
         ifhv6fTvW5rBKwezyopITBB+S4TxLeE3+alnkA9HxPb2637JJu28MPZHiweIWSe3in6p
         DL7vyr/akbR0wHKGo7iimf4yzXrj44zd5DckNX9qJt7NkIqkpgYl6hHZ5G/ULBsRX2m8
         5BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588576; x=1734193376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TvG+p1C7qCnLqD+Fv8OolvBoauxFac0cbA9qC66rGo=;
        b=FBSpLaNJolTpdtcn23rjTpypJGtIqya2kNqua940RUK4hUxJ3AMBCJhpGEdhheeYzK
         u/d2CVDNJKmZVooprwOELNEVICix10/NzQNqFTRQ7U1Q31i/zLou7BfQGvGZVJeKNN65
         1CtduN44QACXoh/9+yj8e+lrUalsxZebW6zDSCIgmhtVQeptaPp4O29zYh7jq3GOlA6c
         GC3bjJUvBP5EcEuHSXGVgHUJ6EpT/vZJh6+71PuFYz0vXgaaSECEs+Qtwu+M6t57lejJ
         j9A74Sdp28rYJ2sI8+Aifl2vBZomxuMZ1bZRmsAramGUzIJHAzNe4CuALO32WT7w5iq/
         K2wA==
X-Gm-Message-State: AOJu0Yz1So8zZ3+CJZKDEnN9kPgSaBftr0BkNZac1Iy4E+PH9mfw8mWB
	bJ1KAvrYRrN+OBvKJv5Rce9eNzOehxsp0J2DipekZhGF6IHD9gHgvr/JClWZVE3zzy4kgC4u4qQ
	ZW7m8aES+Vg==
X-Google-Smtp-Source: AGHT+IFIib9OTt3mIm/Cf+pbY+tjRb7pq5ZyFT6gKe5DGyzxS+d5du0gUVLlNUkkH2sgtC61H4OWhxxKaiPWvg==
X-Received: from qtcw37.prod.google.com ([2002:a05:622a:1925:b0:462:ac63:5263])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:191c:b0:465:3a8b:3fce with SMTP id d75a77b69052e-46734db89b4mr125111791cf.44.1733588576680;
 Sat, 07 Dec 2024 08:22:56 -0800 (PST)
Date: Sat,  7 Dec 2024 16:22:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207162248.18536-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: prepare for removal of net->dev_index_head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series changes rtnl_fdb_dump, last iterator using net->dev_index_head[]

First patch creates ndo_fdb_dump_context structure, to no longer
assume specific layout for the arguments.

Second patch adopts for_each_netdev_dump() in rtnl_fdb_dump(),
while changing two first fields of ndo_fdb_dump_context.

Third patch removes the padding, thus changing the location
of ctx->fdb_idx now that all users agree on how to retrive it.

After this series, the only users of net->dev_index_head
are __dev_get_by_index() and dev_get_by_index_rcu().

We have to evaluate if switching them to dev_by_index xarray
would be sensible.

Eric Dumazet (3):
  rtnetlink: add ndo_fdb_dump_context
  rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
  rtnetlink: remove pad field in ndo_fdb_dump_context

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |   3 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |   3 +-
 drivers/net/vxlan/vxlan_core.c                |   5 +-
 include/linux/rtnetlink.h                     |   6 +
 net/bridge/br_fdb.c                           |   3 +-
 net/core/rtnetlink.c                          | 106 +++++++-----------
 net/dsa/user.c                                |   3 +-
 7 files changed, 59 insertions(+), 70 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


