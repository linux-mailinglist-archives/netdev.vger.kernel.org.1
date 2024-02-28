Return-Path: <netdev+bounces-75740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A186B0EB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8901F26998
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6514F98E;
	Wed, 28 Feb 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjFOEmlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B00130AEF
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128483; cv=none; b=fmdddqHdeEJ5RazdISLbwwCb7WA3Ria+A23kDUDZAZ1X0s8XnKIJyDkU2bFU2itGrjyV6dzIiGrO/P3bqDlqHNjjKrE7MP7Bj7RKkbJzdgGW+1NnL40tZKc6g1z3i6dpmHqG/nQIkOurbUNNObhlolRaQ2TKnV4EiUtCIk/jjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128483; c=relaxed/simple;
	bh=4g3h/FW43x0m8CfwVdCfynekyYL3GuWMmbOtfSgDIno=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g3Nrp0VlcTgjO8Dqbo4yOfBlaRlZwCnnmVelC25DLfJ7AvAKiFZcaZeIfS84Nt6iMLYS724fichvch04zOliO62q+ckzPJ2rPoOs64+i7yNaa9UwtX/kTQUthNPQ02vMeWO1933wMqjX45k8nGizWUXUs/bmrVnrtrVzDUzvyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjFOEmlP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso8886134276.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128481; x=1709733281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vjva/Utm3bAR61lNOaFCCSuojsQxscPQvCyX0jd3DAE=;
        b=yjFOEmlPpviebX5hDppihHMvzSQSEdvD3eqmmvn5roXSlwxZ3d2w8KPBSNv3gGf9DL
         B5Jv5LJ+hd+I5CTpYh0aIczBOjQ8e9EBPTLMp390WVzRer2xNOYTp5b+0a+zsmL59qa6
         BSbo79KTp3HzbCkZMZaTUkFMBkg8YlrjS/EHWPDFEQNixEbiGBlZGbp6kvOtL4yT/vBp
         oFYLMUQxGDX6EUfU6vF1uTECZHO8Y2rJ8St/98XmNusshcdz0tW1aTFbvQ/8C2J6v8bx
         /QNaAPrBqQmHibuOkzUf73hsRAolDPsFpv8DRiicynKS9cG+gEBO9DHifnKF/JVXAVBe
         f8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128481; x=1709733281;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjva/Utm3bAR61lNOaFCCSuojsQxscPQvCyX0jd3DAE=;
        b=UsHYh2uB9bKyLpWs/SRbhIGDJGJ9VDyThHvwvGdlnZPCyWeR+BXmu7s+6H+DOgxns4
         0rwtWLHbzZwDbR2CcHGNObkoBqxAoPkelo+hM4jHrs29Mku8Lzpxs55WEo2TUcsHBvqm
         53SR+3iemm25QQU3RnXcUqwoOPmvgtiDiIaqvhKUgyBQ+kz1meC22cQk6IMZluijhF3Z
         KE3CmPGdVGhpBjkKzpry7dyDoM0B7u1o4mfgBzss7Y/rQHu8C52Z/j6ymEbx+QqfyorV
         SaXTcRFfUdfNQ3T8ejWMhyhxLpb9zfDpRkzl6FNp6++6wJFydEfgc4y5y2FdVqZFJMvn
         fnfQ==
X-Gm-Message-State: AOJu0Ywh8PALgk0CrERqRb7ms4ARAwUcc5IcW6ZgnMH7eesU0DDM1mpO
	10D6SydCMe+RUN5Yi+IwgRENUvSzMPqj/d1YXxHCRLKYOPH4THYg9ZF4fBtNtutjeSbsROLvOoF
	xMpNMEHD6bg==
X-Google-Smtp-Source: AGHT+IELyNrA+00M3me/mM8nhC2B/zgwZDzr2XHmSki4yaMpFDLIBh7EQQRqEnJ/+Z227Nx2qDHgCj5Aobdklw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dcd:b593:6503 with SMTP
 id w1-20020a056902100100b00dcdb5936503mr147294ybt.2.1709128481122; Wed, 28
 Feb 2024 05:54:41 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/15] ipv6: lockless accesses to devconf
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

- First patch puts in a cacheline_group the fields used in fast paths.

- Annotate all data races around idev->cnf fields.

- Last patch in this series removes RTNL use for RTM_GETNETCONF dumps.

v3: addressed Jakub Kicinski feedback in addrconf_disable_ipv6()
    Added tags from Jiri and Florian.

v2: addressed Jiri Pirko feedback
 - Added "ipv6: addrconf_disable_ipv6() optimizations"
   and "ipv6: addrconf_disable_policy() optimization"


Eric Dumazet (15):
  ipv6: add ipv6_devconf_read_txrx cacheline_group
  ipv6: annotate data-races around cnf.disable_ipv6
  ipv6: addrconf_disable_ipv6() optimization
  ipv6: annotate data-races around cnf.mtu6
  ipv6: annotate data-races around cnf.hop_limit
  ipv6: annotate data-races around cnf.forwarding
  ipv6: annotate data-races in ndisc_router_discovery()
  ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
  ipv6: annotate data-races in rt6_probe()
  ipv6: annotate data-races around devconf->proxy_ndp
  ipv6: annotate data-races around devconf->disable_policy
  ipv6: addrconf_disable_policy() optimization
  ipv6/addrconf: annotate data-races around devconf fields (I)
  ipv6/addrconf: annotate data-races around devconf fields (II)
  ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()

 .../ethernet/netronome/nfp/flower/action.c    |   2 +-
 drivers/net/usb/cdc_mbim.c                    |   2 +-
 include/linux/ipv6.h                          |  13 +-
 include/net/addrconf.h                        |   2 +-
 include/net/ip6_route.h                       |   2 +-
 include/net/ipv6.h                            |   8 +-
 net/core/filter.c                             |   2 +-
 net/ipv6/addrconf.c                           | 280 +++++++++---------
 net/ipv6/exthdrs.c                            |  16 +-
 net/ipv6/ioam6.c                              |   8 +-
 net/ipv6/ip6_input.c                          |   6 +-
 net/ipv6/ip6_output.c                         |  10 +-
 net/ipv6/ipv6_sockglue.c                      |   2 +-
 net/ipv6/mcast.c                              |  14 +-
 net/ipv6/ndisc.c                              |  69 +++--
 net/ipv6/netfilter/nf_reject_ipv6.c           |   4 +-
 net/ipv6/output_core.c                        |   4 +-
 net/ipv6/route.c                              |  20 +-
 net/ipv6/seg6_hmac.c                          |   8 +-
 net/netfilter/nf_synproxy_core.c              |   2 +-
 20 files changed, 245 insertions(+), 229 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


