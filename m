Return-Path: <netdev+bounces-31588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7D78EEFE
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23801C20AFC
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8311736;
	Thu, 31 Aug 2023 13:52:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE27111BF
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:17 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC4E4F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7c676651c7so2626825276.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489936; x=1694094736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tToM142v4b+jJlkTK0egAbSAxH3/FE9LsbN2e+T6MxI=;
        b=XEgeEddKjIVjvlHeS+k6ad8F6EDK+DDgaT2HpASc+p1Vtk4++W804TiB8pGTFk9mcM
         OkIeh/UteA06m00D7kpcnX4r5sRSCNZStkjlff5rbi0ihz8AjNiEvkkGaWElS1KFjJM1
         9SAvub+GZY0GEO1iJP7OY95LGbIvGdehoJeO7W3E62y9aFOIsrdSRxZ48Cq7RxhzP23l
         o1Mob3m/8S1S2FqzvFg/3oiGoHlkN/K41aQ8sWJhySR6Yl5+mwjzu5J03hOdxLy06/Jj
         9kjKW9HQhGB7igQhSh3HKBB9Fl73IqokaF15kUu/B75emHqjMhVZCQzGxkWUdsdg+kKn
         eXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489936; x=1694094736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tToM142v4b+jJlkTK0egAbSAxH3/FE9LsbN2e+T6MxI=;
        b=RSE4spJTUSRtxIVG8NQRvKhJKL4Rj2n3Ud56U3EVW8VArCLesA3wrj8WrWwpQ4Ma7l
         xhac1KpDy0WDFT8TZDtqkSrYOq3KuKMO0YbvqyH5F6Ttw695Jf5Jp1H/8n+GaZN7wNv1
         gQ+ngLR4X/Obe3ZGi0KQ1dA+ngDKy2vd6/WXoUta/HZRMw47HB3dc7fLjPkI+mVSWQE8
         hQ/hER/aOSDhb7jWuLnuuJLRWOfQDW8u4fR5hQS7Tg37pQVLyDgMPGeBl3GRbLBvuMWK
         bAblK6Cuh27wsNhMW/hBQ53zoL+RiXOw6W5uwymrN1d49P0gYa7SoHCDYmcT+eCqw95F
         F34Q==
X-Gm-Message-State: AOJu0YxSvAznU5JnlZO9umtWngGIkJVDDAtGMsh/lgBzO5NSluRwFzfX
	maeSZFRZfZ2VasIWm8Mlez2SUSEL+DaT7w==
X-Google-Smtp-Source: AGHT+IGN8ZldIcT46ENNzZ0shJc+K9Pln2xedJvJdVXH1P0Hp8LO/pwimhrUHKJqsGOOYeqE8nHFx9UhyNIbXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1823:b0:d78:28d0:15bc with SMTP
 id cf35-20020a056902182300b00d7828d015bcmr90522ybb.4.1693489935917; Thu, 31
 Aug 2023 06:52:15 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-1-edumazet@google.com>
Subject: [PATCH net 0/5] net: another round of data-race annotations
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

Series inspired by some syzbot reports, taking care
of 4 socket fields that can be read locklessly.

Eric Dumazet (5):
  net: use sk_forward_alloc_get() in sk_get_meminfo()
  net: annotate data-races around sk->sk_forward_alloc
  mptcp: annotate data-races around msk->rmem_fwd_alloc
  net: annotate data-races around sk->sk_tsflags
  net: annotate data-races around sk->sk_bind_phc

 include/net/ip.h       |  2 +-
 include/net/sock.h     | 29 +++++++++++++++++++----------
 net/can/j1939/socket.c | 10 ++++++----
 net/core/skbuff.c      | 10 ++++++----
 net/core/sock.c        | 18 +++++++++---------
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv4/tcp.c         |  4 ++--
 net/ipv4/tcp_output.c  |  2 +-
 net/ipv4/udp.c         |  6 +++---
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/ping.c        |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/ipv6/udp.c         |  2 +-
 net/mptcp/protocol.c   | 23 +++++++++++++++--------
 net/socket.c           | 15 ++++++++-------
 16 files changed, 76 insertions(+), 55 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


