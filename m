Return-Path: <netdev+bounces-35608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B927A9FF9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D801C20B25
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDC18B17;
	Thu, 21 Sep 2023 20:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35E18C1C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:59 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132BAE244
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d817775453dso1791013276.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328100; x=1695932900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HHw6xnVnjQuVDLv+4aeNPmQAMonTpCMIxY11LxWZswM=;
        b=y7RSwrCdVwo2gBJCqhgBMlAUHyTr1U1Z4yb1UM0ZAbNNHbkvFxoZVn/2DbaEBoJ2Z4
         HylUElrc3LYSsl13T3zoSYBzUm0hM6gmvSiUQbbdTiScoTSsImvtl3YWu3Re6NM03C5d
         QFGZC/EhkMEBFu/ctV0xh3CXbNgqiPSj2jhp6JMQc3RLXLDX+my0/kpiwvp6bCSCyErc
         q5i46oBhaYetRTJCI85S6dy9qLKmaul8rNCX9TdqgF8roudfB39kUEvyT0vUfvSA8Bft
         K6+kLI/7M7M4kBzTfYM/jvDSsBl8vH+wxFCI6yyxciPYzGOd1ti2P+Rd+YKcl+866h54
         R65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328100; x=1695932900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHw6xnVnjQuVDLv+4aeNPmQAMonTpCMIxY11LxWZswM=;
        b=VOXkoVQAiCgXPr/B3+AYKwgynmcOPnXUss1RTgxF3v58XDoe2EdvIhuZO0I3/K5D2u
         7N0cRW5IJul8On5rZ8KsWwS15eoxnt09gPXkTPUFifE0B/RCbnGXd4HchA7S1IusFx6z
         vOf/nYeCahKCLZnOXiRRkhI9HhrLQO1C1QaUtzyOedgLrMBbMET2H19GWdzpiJQ/eLk1
         QDAvS2L44qVBSQm1drACARtJ3qqvNCsER6T0XiwsRMChVZSUQ0jxFNaxBcRHVVr7wyUI
         fJCIDYhkl24mehjtQ6++sGzFmVUIqCirf2EkbR8TmaiaO7rwmKDhJcTK1SSK1Qpf0IIF
         yJnw==
X-Gm-Message-State: AOJu0YzfrA75FTOnCKBvxqyw1MtnbLHWotX20W0+efCkeAO8RTwk+Twu
	NArv2ATJl+H2AkXHSKNXdMNPFBlz8Nb4jQ==
X-Google-Smtp-Source: AGHT+IEy+SXRRMq9XJWQB5Znj3UnFPXK8MBDg1UDkm++qArqm5RGaYUUra+awuLMRpRS55KMhwBmdC860opErA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:15c4:b0:d7a:6a4c:b657 with SMTP
 id l4-20020a05690215c400b00d7a6a4cb657mr101213ybu.0.1695328100331; Thu, 21
 Sep 2023 13:28:20 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] net: more data-races fixes and lockless socket options
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is yet another round of data-races fixes,
and lockless socket options.

Eric Dumazet (8):
  net: implement lockless SO_PRIORITY
  net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
  net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
  net: lockless implementation of SO_BUSY_POLL, SO_PREFER_BUSY_POLL,
    SO_BUSY_POLL_BUDGET
  net: implement lockless SO_MAX_PACING_RATE
  net: lockless implementation of SO_TXREHASH
  net: annotate data-races around sk->sk_tx_queue_mapping
  net: annotate data-races around sk->sk_dst_pending_confirm

 drivers/net/ppp/pppoe.c           |   2 +-
 include/net/bluetooth/bluetooth.h |   2 +-
 include/net/sock.h                |  26 +++--
 include/trace/events/mptcp.h      |   2 +-
 net/appletalk/aarp.c              |   2 +-
 net/ax25/af_ax25.c                |   2 +-
 net/bluetooth/l2cap_sock.c        |   2 +-
 net/can/j1939/socket.c            |   2 +-
 net/can/raw.c                     |   2 +-
 net/core/sock.c                   | 163 ++++++++++++++----------------
 net/dccp/ipv6.c                   |   2 +-
 net/ipv4/inet_diag.c              |   2 +-
 net/ipv4/ip_output.c              |   2 +-
 net/ipv4/tcp_bbr.c                |  13 +--
 net/ipv4/tcp_input.c              |   4 +-
 net/ipv4/tcp_ipv4.c               |   2 +-
 net/ipv4/tcp_minisocks.c          |   2 +-
 net/ipv4/tcp_output.c             |  11 +-
 net/ipv6/inet6_connection_sock.c  |   2 +-
 net/ipv6/ip6_output.c             |   2 +-
 net/ipv6/tcp_ipv6.c               |   4 +-
 net/mptcp/sockopt.c               |   2 +-
 net/netrom/af_netrom.c            |   2 +-
 net/rose/af_rose.c                |   2 +-
 net/sched/em_meta.c               |   2 +-
 net/sched/sch_fq.c                |   2 +-
 net/sctp/ipv6.c                   |   2 +-
 net/smc/af_smc.c                  |   2 +-
 net/x25/af_x25.c                  |   2 +-
 net/xdp/xsk.c                     |   2 +-
 30 files changed, 138 insertions(+), 131 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog


