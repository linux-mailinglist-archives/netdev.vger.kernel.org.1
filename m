Return-Path: <netdev+bounces-75353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7F8699BE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B052229377B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDBE5645E;
	Tue, 27 Feb 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHL/1AWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1B146E83
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046126; cv=none; b=e9vyD8owft4thU7+RDSqeo4X0LvGvVrgUEe3/Vc2TDZk3Oz9hwaUQ6Daijg+8uT2ok9ySFXbzL+UvUCoyV8nUomuYWmUdP3DfXd8MJmp25Mq17A99KMXqt/hZXeV6vrWLsHTenTUDc/lcb9XQ+ooAcCgSXcAX30AozK5ZhBePZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046126; c=relaxed/simple;
	bh=j5b5/zmpDLBNMysBzUhloM12e0DULjwOojYdVX2+KjY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IIV5jlC4ovhkUj0g74uVQ3IOEWjIciupED5Eek46ScsVHXLKO9ESSth7wS8dS4fZH0iRV3ZmAXMcJ7UTch9mDuTROfk0FX8jPaXkbyQ0PnObbIYbBSvZEidVF1j/ZvRmfYLzjlRHhUQ/ltQUxNyDH/4p4CWErpOg+iOCyUEd2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHL/1AWY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso6898218276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046123; x=1709650923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ciVIxwtouCFGP+dO/6eeBnZfkql8cXZDKhKP4Ieato=;
        b=RHL/1AWYPWfNNTJwzDjduDVD8jZXeP/RNBNz0aMWUfffMQW0IKRalq/OTH9u3xrCsT
         041X5dsah9weTm21J3V9G1d6HpYXLJuAggkp9dFJUs6d6xEDPmFqYKMcua8iMyeXvnGI
         baBnMeeI7q444OK3aZR38SraAF/iTUO8ATuQ9uFerh0LhUo+bKghgjIoqGArbEX9rRg3
         meh4SvwbuCfy2sexhm3RRXHkhEnj9+0VM10vd0tcDHtBrX/y/4s2OWZCUz4RMwKQXtja
         TqVVUX1aPF+feattMmp+b7577qgeWXCoAZOcA7juXS89lQawpUGj9RtzMaziK3+VDy1a
         HJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046123; x=1709650923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ciVIxwtouCFGP+dO/6eeBnZfkql8cXZDKhKP4Ieato=;
        b=Sq7CvemwEi7pZtNzqrqsZQ70OZzRTXP7dSW1Ujtk7q6Z2Aji2NmASPAda01XuVjx4V
         J7seAxKyCq3yRE9Sk0iMrIsddIGnQQ3YW/te/MylDSVaFK+WOa+5mNSyJuulqo3wvq99
         N1gkE1gdT0/q2GOTOYCMCTyOtlMlqFrwKrGlwmgOif1VEnlIVmNJHy1xz4/rpyNXFNDK
         hViyMBgMr4cUOedRTEJ4WsjOJNK08w/3W55vtiGunRjJpJ0u/bAbKTitUU1oPXUiAtdx
         WtG4DcTl7YyAWyAGhty9k0Xjx3JZaHLnIIEV6O8R00qL8mPjyEH2u7edQX8BkNfl9Lm/
         MINw==
X-Forwarded-Encrypted: i=1; AJvYcCU4GVlm4bwKmzp8mjR3NeQW4k6YDszK/zCF4OzvL5C0flGJIb3oKqV+K2R1LGINfO2mdyMREepJgbtAw2ngIiWm2kUaz9dN
X-Gm-Message-State: AOJu0Ywo14+dYrbFyTNJGoQ42mU17v+xwZhjuOydfktarGypNSnaqQhK
	pRx3TnWDsYE3ZfOKX5r0CBUxJIcXDO5TxInu4sythx6teBB3SFHHWcT0ORunRf/XIHtCvAEvUZ7
	fPDbRy0z8Bw==
X-Google-Smtp-Source: AGHT+IErqUDwXoQrXXB56HFyzArjXPw5WU1O7JQshHjwx8s/R9rHQ4n75WPCtiU6Guu9erWpA4bpPCN+C1D8Lg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1005:b0:dc2:5273:53f9 with SMTP
 id w5-20020a056902100500b00dc2527353f9mr126583ybt.1.1709046122936; Tue, 27
 Feb 2024 07:02:02 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/15] ipv6: lockless accesses to devconf
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

- First patch puts in a cacheline_group the fields used in fast paths.

- Annotate all data races around idev->cnf fields.

- Last patch in this series removes RTNL use for RTM_GETNETCONF dumps.

v2: addressed Jiri Pirko feedback
 - Added "ipv6: addrconf_disable_ipv6() optimizations"
   and "ipv6: addrconf_disable_policy() optimization"

Eric Dumazet (15):
  ipv6: add ipv6_devconf_read_txrx cacheline_group
  ipv6: annotate data-races around cnf.disable_ipv6
  ipv6: addrconf_disable_ipv6() optimizations
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
 net/ipv6/addrconf.c                           | 283 +++++++++---------
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
 20 files changed, 246 insertions(+), 231 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


