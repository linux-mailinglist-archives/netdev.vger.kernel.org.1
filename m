Return-Path: <netdev+bounces-110519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBD992CCA1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D88FB213BE
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DE85654;
	Wed, 10 Jul 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WnH3Mf7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB983CBA
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599327; cv=none; b=p/On7I66wqP3MQkaSVjNZPgVH/7bh7nXkBr23A9kcSrLLcBcXzv2K5Ag80bAwgW7jWnmS/62GmQPY8Lqh4RqHtnswNGVV8FGOeK7258giLEZg3MbxbNw+EKoVcN17UP33w4tr6vosfUZ82BftiHTINEoqFJCk6yxVXtBHcRBZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599327; c=relaxed/simple;
	bh=57B8Y6owy+vWSbDil1WMNBKbvM+cAjEwnrgsJKliVYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa9dS0nKGzMbzHpC78MdSN5HfjMjQjlGo3TI+RI65dT3D1X/UmQwjayK13K5lQ2iRMdjFs6fXmBlZW7bbo593I3duIn1BwrE2SocuTRK1uvFr8ykT/HKsnUXjYlCFN+1h8EVXEO/39ch1copEqT1N2y0NqrN/Z9vX3nIf1PJ/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=WnH3Mf7j; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso8236207e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720599324; x=1721204124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsrq20ArRlBG0ztM3gYJh4L7fx5rkCI7EzZlzuc+aZw=;
        b=WnH3Mf7jRMG00IcVWEdpK+6GHUM73BG/XZnduSsG6QanfMghIHKyGxHhBWBz/qLShp
         GFXkl5KZ1dn2PjE2ngOnW8twjvd0IvPyHJHLmwgJaNIzCGliuaiCC0M/mVFUgAnAkmDv
         xw0BB+Fob5OKDuvRS+K+FyFblqkm5CbHLA2RhXtY9cRgRN8MqUVT8TkTiqP7Y/NESyH4
         DEdhowo6gu53c1fr1CNxPH0bjwhC+fip8aS0QGfKEBSLYlIZvm9HDJykki2K6sc2SLsQ
         A7TQeyci9QL8hbrH4Ytf8ggBx538a0EvLJ9Yu0BuScjxqOspaR+ZNw+NsHHIQHBE7SVA
         fiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599324; x=1721204124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsrq20ArRlBG0ztM3gYJh4L7fx5rkCI7EzZlzuc+aZw=;
        b=gCL4+1GVHAkIRYROiN0r37tA1NS+Xy7GlhN6SmDGckjqQv9o8edrNTXz/Z7rCSsmXr
         Y2nX8VPuPGVQ70DQboVZ7lskeG70kbQCN73YxTDvvWiNcDXrc18VOvo2ob8omuot1rhP
         iGSHrMKTDt9RSAPV7iuqYRg88KXH9Ze28hBRptOG9jxqjKmcazNK8a4lARbKb1uDjxLo
         guHyL+aZNHCq4OzHMgdrISjGFGyk3mfYFU6uJZ84aC96tjqgqMIroJuFuXM4QQc24yKj
         ZDoDgsnRARHLGKgO32R3cvTsSLWL03/GDX361OsYglVIVaNM+rhKc+JE80JJTlpsBKuC
         Ribw==
X-Forwarded-Encrypted: i=1; AJvYcCU/q6O0mcJEoFMx7Pdz288lCQnyDOXW3TD7JrmADhjf7BBadKNoH/e7buiMPXjpadMK0cmeXyL9XRSBWAbjCH/QPN2m6fuJ
X-Gm-Message-State: AOJu0YyL376E3X3IYgheajhZj8ErhoSoHkmBDJdi1j5mJw0kZnkzzG7G
	nXPXLk54BjNj8UdMMN9BYdQIZTBhxndonO7vz1a9DSgcARvDmCHzFiRzzR2PsOuL4NCblXs2Ngx
	dLWcK8gDutbWXe2NK6nk5wbvxQJWDtrSi
X-Google-Smtp-Source: AGHT+IE3+KjILt++j2BLqudhfhl2a1nlppRX59WUkTuppe3puVVLXX0/ElKIRoExASb8LUjr+4m6WHOlQbdU
X-Received: by 2002:a05:6512:10ce:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-52eb99d1ff7mr3886357e87.53.1720599323914;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4266f6f08afsm1145685e9.17.2024.07.10.01.15.23;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 7F4636002D;
	Wed, 10 Jul 2024 10:15:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sRSTz-00Fz6u-6v; Wed, 10 Jul 2024 10:15:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net v4 0/4] vrf: fix source address selection with route leak
Date: Wed, 10 Jul 2024 10:14:26 +0200
Message-ID: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
I suspect it has been here since the first version. I arbitrarily choose one.

v3 -> v4:
 patch 2: set 'dev' only when needed

v2 -> v3:
 patch 1: enforce 80 columns limit
 patch 2: fix coding style
 patch 4: add tcp and udp tests

v1 -> v2:
 patch 2: Fix 'same_vrf' calculation in patch
 patch 4: remove test about the topology type (only symmetric topology is
          supported now).

 include/net/ip6_route.h                          | 22 ++++--
 net/ipv4/fib_semantics.c                         | 13 +++-
 net/ipv6/addrconf.c                              |  3 +-
 net/ipv6/ip6_output.c                            |  1 +
 net/ipv6/route.c                                 |  2 +-
 tools/testing/selftests/net/vrf_route_leaking.sh | 93 +++++++++++++++++++++++-
 6 files changed, 121 insertions(+), 13 deletions(-)

Comments are welcome.

Regards,
Nicolas

