Return-Path: <netdev+bounces-190683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52056AB8495
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF21BC17F8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB3298982;
	Thu, 15 May 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SFf3VIG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7B298270
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307665; cv=none; b=BVbhLd8gtj6+YKpRu21P32RcybsGfpdXy3kCqjBWUh6cFAvtB9v3ywC4W0oEybYBK8tDdRaNDbJCxupNQxGT1VjQxXwxJooeF6YoW/WxRwyIFgJmcvW4zOc0fqbWhGKWgdurtNxnXI7S2E0MXfKm9Co5wWT6c6CxEqgbdGyYhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307665; c=relaxed/simple;
	bh=LZYzIYQmDhfFcD0cuuZUyb+XWN0rMRafpVf+2Te1sN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8wMufB0LlVcBRVSPGlZSekbmqQWvndzv3Dn3ReJxoSyaP+sj0eczaZQjQsu08xKDIYUhoPU4WyfjrJbjAqkQq3EVTtrrjKCxFlf8GoIn+H39HmWzhbLOFIMQSA8k108AlDoPEfyGxgz9TUBUip2kH1UzkLemkVdymIy0lAzkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SFf3VIG4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso8905005e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307661; x=1747912461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ0fZklSKYYaigNRIc1pgX5R1Z/RpRHE5NdpnnPNC4M=;
        b=SFf3VIG4p3/zol1BFZLS0dySVgG0xysljKpxZYb4pYhYLQr629zdPDmiq1v8tG/wOu
         XL3TGmSU08PrEgLPPxhskCsExoUBgC4nT3OYIhEVWJAkl3q82BXbGzUVP+Up30cf9d18
         uQCWVqHECMbp0FzGhEiEuxSYYpxvX7xvVAy74iPex7/2h9RMc/kJWsquVauGlunNpsyA
         Deybq52WZlyUG1G86/6GhBPk7Bwbn9lb8zHLBPkRlFCiL6gTglHIL8eu+V3BZW5DMteL
         QOvWd0vxrmJcsGmArmsJmQI3Zrr9g18jrXEzy64W89Mu3H5bv2MqyZtsQ9xrzBg79tiy
         9ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307661; x=1747912461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ0fZklSKYYaigNRIc1pgX5R1Z/RpRHE5NdpnnPNC4M=;
        b=ai+QuD2UClcMqkvoYkj7RdyxY4DP4phfrjroYXYCBJorSGIHUABXwp7gc6UV6/no7c
         ykk/N/990zGfpUS5QtW0+m5u+bUdDP6HzjjGh8tCYlVJra/ybNPp5weqhaOydV9SqwAu
         v3hX3fDiFIae9pcfwHprw76puXqbNRrpQti61+GVbtxXB6Gqg3BTt4oTAgxgUoJDd+r9
         s29W7mYW8XFVwNzZ3wYqEsHR0VOpJ8S9dCXtPDSgeBf4CQQ6IAmMb89Aq0XCXyj6EwEE
         gxPmGOFpwV5T8npwz+Y8xFE0T3ycm73Pwm2Amsb9aqYWnrwX+koSdyHZyqoYsDpzwOyz
         19EA==
X-Gm-Message-State: AOJu0YzElgDSHo4FzzTQH4ScoySY/mUD+5RIDQk33POQlUIphrBTKVqr
	JH1OhqTNJvocJ1VnTDiFVB+y2ICRD16IUSacEoti41gtZjRvJz2+TcMI5cSKFNrzaP9i5g4swyi
	kfAtaWkAxxiSRCAIv6TrjRLWwgjYNKPxDyqCnkZNnSt2MIUgrg4NLk2LTudFD
X-Gm-Gg: ASbGncsaSkColnRPJ9cptYgiknl+1r9TFuXt+pSl+CDhTUCQIE1emPazCQuKcB5D2yM
	S1GaGr8jX3aVb37VD959gQXF06VSHRWVFs08qbisK30Cko1MtUWkjEOYyL+yGLwYT9q3X0DrGzQ
	O75ckT8Xdlb+b7QqahHObq9JzOKBgqTpcxCvqpY4owjH25Xmv6w49fu2jky/DiQDxbFl2SMgboP
	K+VtvxNro79bPihHOU7AKd2ohf0zUTZA5Kpt5FmoAMPjVTN1uTwjl1TM6aoiAEFcqxbYKUeKBr6
	lR78qNaRqTm3Z9J+YNO0ZzdWcgi9CI09Eq7EhqcjDPTQe/BdgVYUgTZYRyF9x2RwNGcbuiFRu3f
	4j4CLKBIc+w==
X-Google-Smtp-Source: AGHT+IFjJEDsQRVNCUjX2do22HrFFfBU46yk//Z3BxJyeUevGbhNRKKp9yrCWWML8gX1qC0R9PO4Bg==
X-Received: by 2002:a05:600c:3e88:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-442f20e33b0mr71849115e9.9.1747307661416;
        Thu, 15 May 2025 04:14:21 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:19 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 00/10] ovpn: pull request for net-next: ovpn 2025-05-15
Date: Thu, 15 May 2025 13:13:45 +0200
Message-ID: <20250515111355.15327-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

this is a new version of the previous pull request.
These time I have removed the fixes that we are still discussing,
so that we don't hold the entire series back.

There is a new fix though: it's about properly checking the return value
of skb_to_sgvec_nomark(). I spotted the issue while testing pings larger
than the iface's MTU on a TCP VPN connection.

I have added various Closes and Link tags where applicable, so
that we have references to GitHub tickets and other public discussions.

Since I have resent the PR, I have also added Andrew's Reviewed-by to
the first patch.

Please pull or let me know if something should be changed!

Thanks a lot,
Antonio

The following changes since commit 664bf117a30804b442a88a8462591bb23f5a0f22:

  net: enetc: fix implicit declaration of function FIELD_PREP (2025-05-14 09:48:49 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20250515

for you to fetch changes up to 40d48527a587b5c2bd4b7ba00974732a93052cae:

  ovpn: fix check for skb_to_sgvec_nomark() return value (2025-05-15 13:09:36 +0200)

----------------------------------------------------------------
Patchset highlights:
- update MAINTAINERS entry for ovpn
- extend selftest with more cases
- avoid crash in selftest in case of getaddrinfo() failure
- fix ndo_start_xmit return value on error
- set ignore_df flag for IPv6 packets
- drop useless reg_state check in keepalive worker
- retain skb's dst when entering xmit function
- fix check on skb_to_sgvec_nomark() return value

----------------------------------------------------------------
Antonio Quartulli (10):
      MAINTAINERS: add Sabrina as official reviewer for ovpn
      MAINTAINERS: update git URL for ovpn
      ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
      ovpn: don't drop skb's dst when xmitting packet
      selftest/net/ovpn: fix crash in case of getaddrinfo() failure
      ovpn: fix ndo_start_xmit return value on error
      selftest/net/ovpn: extend coverage with more test cases
      ovpn: drop useless reg_state check in keepalive worker
      ovpn: improve 'no route to host' debug message
      ovpn: fix check for skb_to_sgvec_nomark() return value

 MAINTAINERS                                    |  3 ++-
 drivers/net/ovpn/crypto_aead.c                 | 18 ++++++++++++------
 drivers/net/ovpn/io.c                          | 18 +++++++++++++++---
 drivers/net/ovpn/main.c                        |  5 +++++
 drivers/net/ovpn/peer.c                        |  5 ++---
 drivers/net/ovpn/udp.c                         | 10 ++++++++++
 tools/testing/selftests/net/ovpn/Makefile      |  1 +
 tools/testing/selftests/net/ovpn/common.sh     | 18 +++++++++++++++++-
 tools/testing/selftests/net/ovpn/ovpn-cli.c    | 19 +++++++++++++------
 tools/testing/selftests/net/ovpn/test.sh       |  6 +++++-
 tools/testing/selftests/net/ovpn/udp_peers.txt | 11 ++++++-----
 11 files changed, 88 insertions(+), 26 deletions(-)

