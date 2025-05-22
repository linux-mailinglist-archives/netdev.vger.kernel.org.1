Return-Path: <netdev+bounces-192698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4BBAC0DA2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A033A40812
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA1228C5C2;
	Thu, 22 May 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RvSNMeVG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737C28C2BD
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922820; cv=none; b=a2osj21Rl6mGam5UVCXD45sKZFMK1oiVKxasvcOFU4TKd6ex3lF7z+sqcnfWxgzp7gZobQJPVPgj4l9vgdynohT7l5+Cnfoji3JgpaqnX9tL3T/GfgO077X4l3ahZO/6MPQwPXmoaRlp6aELg9YxNKVb+jYNphPq2fxsilFwovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922820; c=relaxed/simple;
	bh=YyzFlTVCqzaLb9SvGwqng1Tjqs/BJRqk8dNRE72Kb+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtJWnSmypFbNR4hc7AXOcCEytwK7S1kPTwAy0fVjFUbdgy/ptWlU5BaEzj06ej8BIIqPZSsqQP6kUAsKWZwaEC0nRnuZgykWZ51jKga9O492AvIixZdQ44oKxgMuDho1fvfvZiG6JK3ADV4rzVc5dXdO3ou7MLj3eqhdKy4zGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RvSNMeVG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a37a243388so3017132f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747922815; x=1748527615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNQax49gVEzfbKp+CJgka6dEJ33V2s7TjVnwy4ljdEI=;
        b=RvSNMeVG2vYLaFwW2vywCWMSSYF4TmPqJDvM0oDGNiFr8wZGYfNn8y+botdP8mGz3/
         CZoYpgqmzgdiSfHLoDP1ES9E5Y48jmCE71B2wHFQyMqmelo/D9FacJ5eMaB5GMpnpXb6
         /tCLLHM6WfLiZvuueqbTNwxmvCKz29esBq8AZK1XzkqrL0NAatWIXQCcbppZRSQ5Shqd
         aenkZZ86vCxdCU3F5wjJquv+X4jr9Wl8L5E9Gv0kc+g5YoVq92W7UdX4eySGSHMiubkV
         Wl3bXZoTfrCqz8OEfR+xegGmnJKYr/MgAVfSrsTyOklGgO9PTKOTmXVwZESsV25OtTQs
         +FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922815; x=1748527615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNQax49gVEzfbKp+CJgka6dEJ33V2s7TjVnwy4ljdEI=;
        b=mmJAi6V6pkIqSx4Q1TobYpKAD0Kvt5z0Rrk+EWdFtbaofuWUryid/cShUQWbbHE/rz
         YDR7j3tSn+MflUrSF6iL90YZ8jfP4VcavryWbl/sWXUul/+lcWIG8uDZEIVZXloBs6B0
         uuFQTxBccX5C5r1xAMfgAYntN/H8PyTZ70CzBMmqmg0r0QLvs/wca2yS1CQK8tEWdkaX
         jlyb00n3HfnuPwqWis+ra1ZMLcTrBH+7mCkmfHVXJz+u/lFmW4ct83mOKc30AUezYaBD
         PWc1Axktx5o4X0csN9ihDeDzyzIdwHAiSeamC87S6w55L2cQFu7MZxFWVEImqLMRGepz
         Kazg==
X-Gm-Message-State: AOJu0Yw/a7l6LaB3w86KPETwQSkDD3p89fCd3rj914nBFLPDgSQShu8N
	IduN3l+WxjW+VvWGXKc4KTSAoP88TB3fK0voZIF8gHzHyuzjmXHhTyyjPkhiYLvXHH7X3ZkP2AB
	61fqwlIuDQXxsJUdl+8iqQDhfBEWn8keZuajywWAHRvNaClxui8U/wuXACyh4eK1R
X-Gm-Gg: ASbGnctHX3W7hDyisIF+u7irj6VDp9rbfR6Ogn2tyXW12vH0y+AEV4rXAIxILvxLONb
	ZqvK3LXfhd0djnlk2TWqlkB9jCcg2WU7B8N1E+5H2kOnw2NkCMsXGSIOjgga1VRF3szlsBXleQ7
	dJxb0QAJuPjxuqO6rKrIu7R4NCp25EBgDoYZGotn8FttxEHQWYtvUG2E4lcKqMCWJDQqO0u+Bub
	cb3NnODaTOl9gXCW3MOGsTq9Nfb0fhp+t8kAXw+rVRkjCgzwfKGpRl3C/C4cxFGuDevsLZfYZ7d
	38mLjDzM5P+BoLlyFm9dqX10Y8TnglWymXvQBaRiTPHyxP2lhLZjTlBKMUmU/jKqffSX4nzeLn8
	=
X-Google-Smtp-Source: AGHT+IHHJNgTXn1xO2sPFLyp93PTpotSGSo81fSVhS4SVjQibHk7NIROlH5Y4cfOnvzF4UbY388QdA==
X-Received: by 2002:a05:6000:2913:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3a365b5534cmr19127142f8f.26.1747922815354;
        Thu, 22 May 2025 07:06:55 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:3ef2:f0df:bea2:574b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b1bsm23671269f8f.53.2025.05.22.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:06:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 0/4] pull request: ovpn 2025-05-22
Date: Thu, 22 May 2025 16:06:09 +0200
Message-ID: <20250522140613.877-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

Here is (most likely) the last pull request for net-next for this
round.

Patch 1 substitutes a call to setup_udp_tunnel_sock() along the
cleanup path with cleanup_udp_tunnel_sock(). The latter is introduced
in this patch as well, with attention to the CONFIG_IPV6=m case.

Patch 2 fixes a critical race condition (leading to null-ptr-deref)
triggered by ovpn removing a peer, while userspace is concurrently
closing the transport socket.
An earlier revision of this patch was already discussed on the
netdev mailing list and this version is the final result.

Patch 3 is fixing the TCP test case in the ovpn kselftests,
accidentally broken by the introduction of the UDP IPv6 test case.

Patch 4 is adding a missing kselftest script which is already
referenced by the Makefile.

Please pull or let me know of any issue.

Thanks a lot!
Antonio,


Antonio Quartulli (4):
  ovpn: properly deconfigure UDP-tunnel
  ovpn: ensure sk is still valid during cleanup
  selftest/net/ovpn: fix TCP socket creation
  selftest/net/ovpn: fix missing file

 drivers/net/ovpn/io.c                         |  8 +--
 drivers/net/ovpn/netlink.c                    | 25 ++++---
 drivers/net/ovpn/peer.c                       |  4 +-
 drivers/net/ovpn/socket.c                     | 68 +++++++++++--------
 drivers/net/ovpn/socket.h                     |  4 +-
 drivers/net/ovpn/tcp.c                        | 65 +++++++++---------
 drivers/net/ovpn/tcp.h                        |  3 +-
 drivers/net/ovpn/udp.c                        | 37 ++++------
 drivers/net/ovpn/udp.h                        |  4 +-
 include/net/ipv6_stubs.h                      |  1 +
 include/net/udp.h                             |  1 +
 include/net/udp_tunnel.h                      | 13 ++++
 net/ipv4/udp_tunnel_core.c                    | 22 ++++++
 net/ipv6/af_inet6.c                           |  1 +
 net/ipv6/udp.c                                |  6 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  1 +
 .../selftests/net/ovpn/test-large-mtu.sh      |  9 +++
 17 files changed, 163 insertions(+), 109 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

-- 
2.49.0

The following changes since commit 9ab0ac0e532afd167b3bec39b2eb25c53486dcb5:

  octeontx2-pf: Add tracepoint for NIX_PARSE_S (2025-05-20 12:37:37 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-next-20250522

for you to fetch changes up to 35c3e81b334ed76093d5318238e869b46e3a0e21:

  selftest/net/ovpn: fix missing file (2025-05-22 15:59:08 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* dropped call to setup_udp_tunnel_sock() during cleanup
** substituted by new cleanup_udp_tunnel_sock()
* fixed race condition between peer removal (by kernel
  space) and socket closing (by userspace)
* minor fixes for ovpn kselftests

----------------------------------------------------------------
Antonio Quartulli (4):
      ovpn: properly deconfigure UDP-tunnel
      ovpn: ensure sk is still valid during cleanup
      selftest/net/ovpn: fix TCP socket creation
      selftest/net/ovpn: fix missing file

 drivers/net/ovpn/io.c                              |  8 +--
 drivers/net/ovpn/netlink.c                         | 25 ++++----
 drivers/net/ovpn/peer.c                            |  4 +-
 drivers/net/ovpn/socket.c                          | 68 ++++++++++++----------
 drivers/net/ovpn/socket.h                          |  4 +-
 drivers/net/ovpn/tcp.c                             | 65 ++++++++++-----------
 drivers/net/ovpn/tcp.h                             |  3 +-
 drivers/net/ovpn/udp.c                             | 37 ++++--------
 drivers/net/ovpn/udp.h                             |  4 +-
 include/net/ipv6_stubs.h                           |  1 +
 include/net/udp.h                                  |  1 +
 include/net/udp_tunnel.h                           | 13 +++++
 net/ipv4/udp_tunnel_core.c                         | 22 +++++++
 net/ipv6/af_inet6.c                                |  1 +
 net/ipv6/udp.c                                     |  6 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  1 +
 tools/testing/selftests/net/ovpn/test-large-mtu.sh |  9 +++
 17 files changed, 163 insertions(+), 109 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

