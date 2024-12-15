Return-Path: <netdev+bounces-152006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A89F2527
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F8F18860FC
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913C1B3926;
	Sun, 15 Dec 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19KkyEXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992F1922D4
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285412; cv=none; b=SskIrdKFcBEp8Y+LX73LCsl3FEnGBQVojjNei57I52wtkZbYiqbk3quJVC0rJuLODr6h7amFSy11GbVSl3F1DA5BLS3NMOA1wR66H98oVc/n3WIkU+o9yrykctPXMkdM13I4NAxHlTWMJo5T/AFFIIQraViQZwb7MFdmBeQjeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285412; c=relaxed/simple;
	bh=E/XN4RrrV257sD/ZdAV+QOeUXSMb8jKKdwuF0Re3rso=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RsDTbV/4/vAUNQo7BjLKEGWFxw/xznFS3Xp6L0FeVdbRegqPndBAzSsylzQ0H3Ao3dTaBxKsW3KSkLi79D2Knw9pEmjlWrE3qSX2ZYbvXAuWIDDfxgtVApN4KIWTUxoxnNMnohxqrF5WC0M7ylioAUj/KBT9PGG1d1kudwTEFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19KkyEXl; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6ef2163d9so727022385a.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734285410; x=1734890210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8DV8PYOVs0Rz4aCkkB/Pp4z24yZPj5L7wSkPLQt3fI=;
        b=19KkyEXlurSGfIFFCcR037odRWFEcU0La//oi+V5AQM1FwOGqiHU7zU4nYqLxYePMf
         tT1nBQN4zzOwvQxwOL939wUt+0DVKZ5ke2W2s+/EuAFq5S92AxjIQnU/xaI9IYgmrynv
         JKIf3vKKH/DbfLxua6zxUeeRciA4+torzvJsqa5B8Djd+Un5Xka/4UdXtMP1y5a3Lril
         4BzShf95+E7ks8TkgQKzhvvfgWHfzoAHKteUDPJL7klbElscnOeN9B4VrR8rHnmnSZjr
         z9w4VgQBRbPFBqyhDdUpbJXOhDCeiJlfOkyAgD00bXUHrZxKHvQlQPlGi50x38A1ZpCf
         /IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734285410; x=1734890210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8DV8PYOVs0Rz4aCkkB/Pp4z24yZPj5L7wSkPLQt3fI=;
        b=tnLAXsPXYSLOcKaHZBGvK5zcmHt8hgXeTemb41Q7RGV4Q/V02TmtoopP/rnDpe8UVm
         dPRWPljcm/u8K+xkyjhBVchvr6+bZ1KXnrdBB6MUyJAbaAPqXFJWBairnji2eCP9O2yw
         HJ1oDmRJwHfg9UIMXazrvn1Qy5F4kfhcGuhAwmBbRvJCgH6mlFtc0JelJB/ewiMTMm0K
         h9zVW70ONPd4ttrSZ991T45/IR9N1a9RZ8mY5c3G7S9+fG6i4Jw1cO0dtduCUfQxwCWQ
         lnvof6Kz4YGmhkWiYqSuFqRYZyjlq2wBLpecUkpSsjTja4aTpzI1XRqQgbhuU6PLN4Ye
         /hzQ==
X-Gm-Message-State: AOJu0YxsnfeX998oJYwHRY3kEisofcNrhMAhPoJEJNQImYN9BBGf6QgV
	azB/oQVUej0qNFpdOkgvHap8QIdqBt82VRJ+yeJ/iGhDCHPDFTk0Awfr1X3NsPXAvcI+Vh4TmjK
	csouHAYkZKg==
X-Google-Smtp-Source: AGHT+IHQKtYjybr9XSKs2o9FOIa3m1JxIvtcm34yOKZiGh3biCJh0la0CdQfTnKonXzt8SJWGbPJUPQh0O9tsA==
X-Received: from qtbay16.prod.google.com ([2002:a05:622a:2290:b0:467:7214:12b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4555:b0:7b1:462f:46f7 with SMTP id af79cd13be357-7b6fbf158cfmr1661563185a.30.1734285409944;
 Sun, 15 Dec 2024 09:56:49 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215175629.1248773-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] inetpeer: reduce false sharing and atomic operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit 8c2bd38b95f7 ("icmp: change the order of rate limits"),
there is a risk that a host receiving packets from an unique
source targeting closed ports is using a common inet_peer structure
from many cpus.

All these cpus have to acquire/release a refcount and update
the inet_peer timestamp (p->dtime)

Switch to pure RCU to avoid changing the refcount, and update
p->dtime only once per jiffy.

Tested:
  DUT : 128 cores, 32 hw rx queues.
  receiving 8,400,000 UDP packets per second, targeting closed ports.

Before the series:
- napi poll can not keep up, NIC drops 1,200,000 packets
  per second. 
- We use 20 % of cpu cycles

After this series:
- All packets are received (no more hw drops)
- We use 12 % of cpu cycles.

v2: addded Simon and Ido feedback from v1
v1: https://lore.kernel.org/netdev/20241213130212.1783302-1-edumazet@google.com/T/#mc6b32422714235f8608580a7dbf464c203300578

Eric Dumazet (4):
  inetpeer: remove create argument of inet_getpeer_v[46]()
  inetpeer: remove create argument of inet_getpeer()
  inetpeer: update inetpeer timestamp in inet_getpeer()
  inetpeer: do not get a refcount in inet_getpeer()

 include/net/inetpeer.h | 12 +++++-------
 net/ipv4/icmp.c        |  9 ++++-----
 net/ipv4/inetpeer.c    | 31 ++++++++-----------------------
 net/ipv4/ip_fragment.c | 15 ++++++++++-----
 net/ipv4/route.c       | 17 +++++++++--------
 net/ipv6/icmp.c        |  6 +++---
 net/ipv6/ip6_output.c  |  6 +++---
 net/ipv6/ndisc.c       |  8 +++++---
 8 files changed, 47 insertions(+), 57 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


