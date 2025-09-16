Return-Path: <netdev+bounces-223743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D5B5A435
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA4B84E1DA0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C10306B2E;
	Tue, 16 Sep 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HX1tdxO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D7284695
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059285; cv=none; b=aZrs8jVja4mvoajnj0uF3W2K34kd4uo/RwRqMBzhAXZLdjVeZ5eh79LmDkFyFK63m+sBi8iz3/ThFO9AwmiZ2TGIo/aOqQPWCbscXRKcXJjgGMXGnbYpOebnsWg6gMYst65CuGOyP/z1WbLIJTL6XQbw2SGFxMXpEDlX4PmrBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059285; c=relaxed/simple;
	bh=CObait3kFGFpvsvNCdCyH9uYzuTFkkgSxCm0HusgqfM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e2FANPNiRfMobgoYfuvMFPXyT8bpQT9483s4WchQLUe+f7wGfeo/aQUAVoPqUuDvUaJbBUHGSrKMsv0rmgqZrwA/AGaiuACHL2g3rCus5qqcGF6iL5UifasFG3ACgq60nkFDhAMijblJvWZy4adW6LXYJ/e9bwRVG0ucdnczuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HX1tdxO/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso7797916a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059282; x=1758664082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcM/YJBIHy8sjmemES5vmSV7YGZnZX3rkycIaGM0nZM=;
        b=HX1tdxO/lEXTuie04vFWX5gEff2rnKBdj9NX0PSl3RD2kxkkZQhFfTUkyeAA6Xh49i
         IlMIO7fAtuxGNFzQsLvCYWjqPOIQPfukZaMBJjxPj0uh9V6W4jibWberzcWx1P49ho9J
         Dk7tPzmvFTKQyPCg4RNi7ZjzXTI+vHRQEln3GKNsL50oIXJ802PtzVbA3lmWcz42kYOJ
         SLv//SWB41lc1mYk5urGZgp5ugfNDbuFEhqaTr1cHhPf+/Mlu/c1aNseI1MOAPUHRoVI
         nMnP/eDHuTU+p7byAwI5Zxg25Joe1mozccYLJ5FfDjk6PcMEqjbkyNSxz2xwevFQ0EiM
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059282; x=1758664082;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcM/YJBIHy8sjmemES5vmSV7YGZnZX3rkycIaGM0nZM=;
        b=IQmzN21Ndln8JArvIITpNIB7LfICg/P7sOuS7+PrWgBg/FXEguRVTZC+K0D6t+RZuI
         sbtyxkqSjqeBWr8bH1rDJry5NLbVS9eBT4+KqCCsdQt2uPKBnHsfduZMg3uQDPZ9FUpB
         MbOscxLz7c5EW5o/NaFFGu70+cakoB273NvHJ15D53RI7gESgYFW3qYTebQXiOYBDo4i
         rhKF+04D4YMNVxiOGT9Ev9L0phB6pxVd7r5jzkbUGwQI0HvrLonaIC026bs6OO+m9dQu
         CJYAkZk2gM2o9zwEVL0Gj2cqunoLohct36DkRG8NMOrfAliDhbUut1rpj7/gw5T8EVAT
         iIuw==
X-Forwarded-Encrypted: i=1; AJvYcCVP9239DkRwUwyto5yxmrOfKqOqwDRi5+XPsXlArD4JQI+wM+iOTgdB0CiScp9Exm5nVFg82Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4lKSSZJOEp3HhRt4n5EOgaAQun+fCoUKdQ8QUuJR0YxPwZNo
	Ej7XZTvHMlO1UegkK9SUInti/TYslyLSTtPq0QosdddEnIZSxOcxBd6J5XyUfjgXopEOBXKMP8s
	FBjFqVQ==
X-Google-Smtp-Source: AGHT+IE9Y+G+OaoRIZTgQtrRADW+TE2mjmfZXkD0ji1q5+kvjXQyjtUIJrGNM1ouCArsYZtq+KggBgdy5hs=
X-Received: from pfhz15.prod.google.com ([2002:a05:6a00:240f:b0:772:908:b5c2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328d:b0:264:10e4:fbe
 with SMTP id adf61e73a8af0-26410e41368mr11043254637.52.1758059282439; Tue, 16
 Sep 2025 14:48:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/7] net: Fix UAF of sk_dst_get(sk)->dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot caught use-after-free of sk_dst_get(sk)->dev,
which was not fetched under RCU nor RTNL. [0]

Patch 1 ~ 5, 7 fix UAF in smc, tcp, ktls, mptcp
Patch 6 fixes dst ref leak in mptcp


[0]: https://lore.kernel.org/netdev/68c237c7.050a0220.3c6139.0036.GAE@google.com/


Changes:
  v2:
    * Rebase to net-next (Eric)
    * Drop tcp patch as it's already fixed in net-next (Eric)
    * Drop sk_dst_dev_rcu() helper patch and use dst_dev_rcu() directly (Eric)
    * Split mptcp dst_release() patch (Matthieu)

  v1: https://lore.kernel.org/netdev/20250911030620.1284754-1-kuniyu@google.com/


Kuniyuki Iwashima (7):
  smc: Fix use-after-free in __pnet_find_base_ndev().
  smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
  smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
  smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
  mptcp: Call dst_release() in mptcp_active_enable().
  mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().

 net/mptcp/ctrl.c     |  9 ++++--
 net/smc/smc_clc.c    | 67 +++++++++++++++++++++++---------------------
 net/smc/smc_core.c   | 27 ++++++++----------
 net/smc/smc_pnet.c   | 43 ++++++++++++++--------------
 net/tls/tls_device.c | 18 ++++++------
 5 files changed, 86 insertions(+), 78 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


