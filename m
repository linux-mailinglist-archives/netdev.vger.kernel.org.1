Return-Path: <netdev+bounces-221959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0254B526D8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906373BB2A1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E11C84DC;
	Thu, 11 Sep 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5QxP2xV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AF19C54B
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559990; cv=none; b=RIKYGGkJ9cHHPaCjwqnPwSL3biNtoHbwc/xd94dbvoA95PIcVRRXMXZpmYxYEadyibRKEmPu2x8CSV6hbv3jn3EJfgwP2Ljhi6AP8F9boiTBDFe0+xLbqwtwsNFv+KVbhZkhZNfVP1n/NJ2fz/Rfj6s41+zSfXsae7uhEM04tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559990; c=relaxed/simple;
	bh=4lrIP2oIT2KQMLPlYoqy4xiumHfWOaeZsBrg602rDxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wc/NUii8SKYD7gJy/vstWebnk+Jwxnw9bGFCqDNaExQgNtWx8GHJkjrtV2Sj8vqfy1Q4gmnhrqsXmrehp316X/E8odmCDGhVyoEoAXUQ47+2CpHN+dCK8qkf2Ef1a6cnazBkT83WMQs3UCq2RBK8qOcxgaGQuWYAFvT3nJeA7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5QxP2xV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so201008a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559988; x=1758164788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMNcUzlFWQ1JYPUFpxY4C/RjKhz5EYBknYsBxEqkRj8=;
        b=b5QxP2xV/uCzs5kQHUT/qEI+1tVRnOJobzLNFgmY6TLmxzUWdrq9ZObsZ5ttAbhANd
         OOMTumTthgXFODK0e4vjlf7/fpz0JpnNTKmCXrjfIXSRhyZQsr8OscJd53bOSMnoOa9K
         j/r9Hws4PptI+cw7Vfo/9Tq+v2bcNvqp2yNKseeaTkzuljGZc5vsB51X7LA50tQDTWTN
         Ph+nCNsO6CU5B5yfH7F3gR7XxtELXrSeELcGO3c346EWbRWj6X9b0VcZBfYKmVGGxkuA
         /Yho+XhoQM0ZUcaJn3tBbNCzSfbfU0hR36hoUtIDRdiJPr+9hteJW52cfGZoiWkNuIJj
         i66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559988; x=1758164788;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMNcUzlFWQ1JYPUFpxY4C/RjKhz5EYBknYsBxEqkRj8=;
        b=cDPBqv0uWdS1DDzo6faX1UxjiohyD6MNNF3PfNmnY38efNXaM8SYkVwNQZchxoDXBG
         7OGXGbfbaXHbwqZrUN+IdPotRNGLB7RkeFP4H0qsK3TfXC4SDaWstJ0qdtfQCUOaKnIX
         RBxMVF7H3lO76sr3meTFXcGddezzhbjfevAy/NLKu3Z/ahiUhyG4H0ZKrN4/rucJnHS9
         jFmhQBjgIFELjF5f1eegPl/9w8t81TJQO/xWxe86N66vYX3M6gF0e7+w3DTSb13Oa1c+
         FN87G17kPbm8e0IrFueKDAij5oCbHhrrGP9D5hqyjnPnRo1y22dicJ594ju809iLbptA
         77ag==
X-Forwarded-Encrypted: i=1; AJvYcCW5lag5QvL+96UQsbn5R1jjsmvcCf3KI06Q6nBeMUefe/6tbBfMQNaoM/2hxnjpa6zwdm+7bys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlA7t3c68amDyIhg7OL2Y9KH7YXbUp9z4sNRENMTMOhsk4bjK6
	zDEvtfL3VGrr3Yg4ajlqB8bF3jek0TbUfoN/+LrgtM4BzBt+RF7eRNIqkSuRv+Hu/3vFgftmlb+
	haQ+0KA==
X-Google-Smtp-Source: AGHT+IGhYThxtMqANI2ALRL3OuTWD/0qISYYhVSXBNbra3EipiRnOZ0qMh47FtuKL40zJV3d8D8aJqLqUBo=
X-Received: from pjbsx7.prod.google.com ([2002:a17:90b:2cc7:b0:329:815c:ea84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a3:b0:243:c36f:6a71
 with SMTP id adf61e73a8af0-2533d226078mr26077683637.21.1757559987975; Wed, 10
 Sep 2025 20:06:27 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/8] net: Fix UAF of sk_dst_get(sk)->dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot caught use-after-free of sk_dst_get(sk)->dev,
which was not fetched under RCU nor RTNL. [0]

Patch 1 adds 2 helpers to fetch __sk_dst_get(sk)->dev safely
Patch 2 ~ 8 fix UAF in smc, tcp, ktls, mptcp

[0]: https://lore.kernel.org/netdev/68c237c7.050a0220.3c6139.0036.GAE@google.com/


Kuniyuki Iwashima (8):
  net: Add sk_dst_dev_rcu() and sk_dst_dev_get().
  smc: Fix use-after-free in __pnet_find_base_ndev().
  smc: Use sk_dst_dev_rcu() in in smc_clc_prfx_set().
  smc: Use sk_dst_dev_rcu() in smc_clc_prfx_match().
  smc: Use sk_dst_dev_rcu() in smc_vlan_by_tcpsk().
  tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
  tls: Use sk_dst_dev_rcu() in get_netdev_for_sock().
  mptcp: Use sk_dst_dev_rcu() in mptcp_active_enable().

 include/net/sock.h      | 19 +++++++++++++
 net/ipv4/tcp_fastopen.c |  7 ++---
 net/mptcp/ctrl.c        |  7 +++--
 net/smc/smc_clc.c       | 63 ++++++++++++++++++++---------------------
 net/smc/smc_core.c      | 25 +++++++---------
 net/smc/smc_pnet.c      | 35 ++++++++---------------
 net/tls/tls_device.c    | 16 +++++------
 7 files changed, 88 insertions(+), 84 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


