Return-Path: <netdev+bounces-74993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423B867ABD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79CF1F2B0DF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0AF12BEBA;
	Mon, 26 Feb 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnijSpEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621112AAD8
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962667; cv=none; b=HhfafMOtu2p1PRZc4JKcWG/N/x5bzKQuqwLdZTy7JrvCa7TTpWBLWTqRQoT7Qa5O4puFua/W8rzuAKDf/MrrQePmQdZAOel6vIJ5rP7luHIDqrtM9rdw6NrZixmlqmY3GhTYBzUHWBimhrxRP1gkwIEtziFLL1m7zJJfJfokVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962667; c=relaxed/simple;
	bh=WWgnZ/T/uz36k/bisotJuU+H6/Y1uGUsXWr5Hznhebk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i4c8Tf0FiHKUxK09iqDC3yaCA5EJ4iUqkXXKFtPVHnTgJ91CNamyuNG7pHHAgtECf9r16MteMXr2D1JzJgrPGtTOLvsyBEJ7B0E7NHFhNuOXz2GJ6k5SuIsq8+VKhGH8Gv6QV3xEuUgoQEr0bXPBBssfwUuFqqiAIb/nmqust4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnijSpEY; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42e3fa7e328so39821581cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962664; x=1709567464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23nnpLadNZyuqDQ7rfqLMhqNpA9sR3M/DBIB5GmZiiQ=;
        b=hnijSpEYksEnchr+YaJb8s/6fv1anKMmeftwy34Ai0BNPgmkZArK7Zh2DcudajEPQN
         bx1ZMko0sx/Tu7MV5DDFfmrW1cjcQ+22v5giuwRtbp/IlI5MxgD+7O397smpqUYPM1hs
         pEh18ZKGnT8zkTlf+0d/svPAKg+2rNDbBm9Kgw9gNiUX1fILruglpXgZHWEDSW9v6bwZ
         ZROyQZ3fM8I4PYtSmMqssAeLVnoSWC0si+4crug+E9oPMaBLUN1n3P5P4FRd4uPhwD/3
         fM7pkE2oN8VyRbSdY8++EULjMJ9RF+arwF9GT/elB3P+o3HyoW4JRIjghZkWWiOQ5bcP
         i8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962664; x=1709567464;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23nnpLadNZyuqDQ7rfqLMhqNpA9sR3M/DBIB5GmZiiQ=;
        b=IosBqzyytGCz1+diopaTxMLK0RW0I99jYBGJjrpKwtr86e1aae6hiQ0+2BO2CmGs9s
         cMgyfVMauj2sbXOpJ0A5xiTEzh3fSKbJ9TYBCXn7LrcpCcw1WHqNYcban1qGHhCSA1YQ
         d8O4lwcdw4hj97sROJtPozaK7U3mxuyUC5jF/BEXa4+r46zM4vftQ3Wh9PhBwPLmfzac
         wl40pn1DHXwFECJlJXL3vWflKtkqiNfVVmrF9sK8YA3g0AjCYKQZkZFAKWv59Z7isM0c
         zTrWruIegOPVoOA7K1qB7NB0jG1B567ytSGbndLkrJA5gDH0YeCluEK1HXuPaUaS78Y5
         kmgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMhswVtcjyYnYHFTHZpeBw//JdrrRD9CkuiqdlpcStePFrEiOdjGzv5T8BkSGKMqxWVO2n66kEnPx/a4F+fMdE1f7a3DYf
X-Gm-Message-State: AOJu0YxifRgyE21T7+w4NMbl1XBSuZDRg/lxPVrDYjFnvK3ga+b7THVn
	b6cxyaE2ev/+g/5YbSivvmP3p5YLPDuKMXzaki8nJS7m1TsPHkBUr4AxqiHhZvnNOfhSVDVAiX4
	WpUKWP5rpqQ==
X-Google-Smtp-Source: AGHT+IHJoM4mt8QpPzZuzDTe81Z9wVKFhAxXxAOelPhqUm7f8L3Dt++JhFEnT1QPe1Wxua+D+hMIlxqA9Ywpbw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:5c84:0:b0:42e:68d3:177f with SMTP id
 r4-20020ac85c84000000b0042e68d3177fmr28774qta.0.1708962664687; Mon, 26 Feb
 2024 07:51:04 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-1-edumazet@google.com>
Subject: [PATCH net-next 00/13] ipv6: lockless accesses to devconf
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

- First patch puts in a cacheline_group the fields used in fast paths.

- Annotate all data races around idev->cnf fields.

- Last patch in this series removes RTNL use for RTM_GETNETCONF dumps.

Eric Dumazet (13):
  ipv6: add ipv6_devconf_read_txrx cacheline_group
  ipv6: annotate data-races around cnf.disable_ipv6
  ipv6: annotate data-races around cnf.mtu6
  ipv6: annotate data-races around cnf.hop_limit
  ipv6: annotate data-races around cnf.forwarding
  ipv6: annotate data-races in ndisc_router_discovery()
  ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
  ipv6: annotate data-races in rt6_probe()
  ipv6: annotate data-races around devconf->proxy_ndp
  ipv6: annotate data-races around devconf->disable_policy
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
 net/ipv6/addrconf.c                           | 258 +++++++++---------
 net/ipv6/exthdrs.c                            |  16 +-
 net/ipv6/ioam6.c                              |   8 +-
 net/ipv6/ip6_input.c                          |   6 +-
 net/ipv6/ip6_output.c                         |  10 +-
 net/ipv6/ipv6_sockglue.c                      |   2 +-
 net/ipv6/mcast.c                              |  14 +-
 net/ipv6/ndisc.c                              |  69 ++---
 net/ipv6/netfilter/nf_reject_ipv6.c           |   4 +-
 net/ipv6/output_core.c                        |   4 +-
 net/ipv6/route.c                              |  20 +-
 net/ipv6/seg6_hmac.c                          |   8 +-
 net/netfilter/nf_synproxy_core.c              |   2 +-
 20 files changed, 234 insertions(+), 218 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


