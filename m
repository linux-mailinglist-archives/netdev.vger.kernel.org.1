Return-Path: <netdev+bounces-194334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B71AC8BF0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BEF17C77B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81207220F4B;
	Fri, 30 May 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SHUkQw6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C371C2334
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599986; cv=none; b=A7mZ4VppNBguOWHVFAa6f8COadpPVaAsl+Qrmv6HHfDzhYSec0ud6mqhz8PLq5Kro0mcLzQZaKIBjJ9Kj03CH7vrroFuvEQYVK6SVAYT1kHHP0kIK+G/wjlw2lkYtGTGbEM9qpCr3EPwGFjroboa7DQ797iEx6DresuolODzP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599986; c=relaxed/simple;
	bh=I1qDj1TG7eyrrc552sgpADlPVclQ7mg8hCRIXScqIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky1wcCl+TcTsPBdETAN3JdfWqLhjowNevebwF5FdY86LbQ7KHnnJwJC6Z/r7pYJZIpRarQ5nULu99pSrzZ+uOhmnfZ7KFZ4kdV4BJxwGSwtNsTqDDscBpJIUM8E73QI91Si+QmlDXtmtW3+YhaPY+ACaFs09FL7xjssMw2sB/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SHUkQw6B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4508287895dso16486045e9.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599982; x=1749204782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2Fi7jNb7BbAVf6lTHucFT7wZvgSFGLSC0+CASDpUpc=;
        b=SHUkQw6BRyjBBIBn9glDyL3z16493Fs8ZZNZWEzBRo8ZpJi0BFHQIYR8FxwifCH1H+
         nu54ufKdCbsf8kNY2z1RGi80iYPNYB0LRv7pKNJ+W/q8eZDmFHlMS2oUN72gCJbBMqpy
         V2fHREA2JR+03StMHnIMYGCHWP/nEX8vILaOrfSH+TVRR884VFzB2uH2TapixaEYPa7O
         oIsNfgUueLW3eHvISj7qD2bQakMbSs+jitG3GHK8C7PdQo4sTRcjU8iEHNPD4d/NRGUo
         +Qaqs6KjYOaI3mC653q2M4KGfQ0YSR2PN+mppnk2upDGazC3hB9TF/YP7SlQC18wIYz7
         pzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599982; x=1749204782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2Fi7jNb7BbAVf6lTHucFT7wZvgSFGLSC0+CASDpUpc=;
        b=ZP0E55amMZvufNpugDYVWcpjrd3fZZt6yNp+JUy3wpXyHBRiNtBxWypOnRzf9QtF6j
         8LWovcymwpDfcCSK1dGCDc6DKmqkTVKNn3YNUprg6UJvXERLbl/8xHQn2o5q6E/oJuN3
         GeThVrOqy4r3zGbtgxZRpPr2LgzQMQpRQrF0hHod+h8vXGiIMe0/xyM3L1rHvIb4zSc9
         tO7UaIJOHegfXmTWnhaVFkwelVo+MAKfpNLwyZqrRT7JGyqyaMHwuj7yt4/iue9RuSNO
         Sf6LT1qgNgER3qECSUbXbVWrcInlTV7o4HljaTm9MgarX08bejVmLT60Q51IWhhysdAz
         f0Xg==
X-Gm-Message-State: AOJu0YyO1gjFmeH+XItL1x24INTIazIoY/9TLl0C7RPzatd3vj/NojZV
	E3uM1Garm61yIhwssX8a1A/MAHWtTEw6nPOEm+M5Kgp+49PJxSLSfHjiK10KEFMBzAZITEdvxH8
	lBUvMrq6lAA/9LtEXNbIimmYycPwuyfiuatPyFyhgDmJZCyfwTw4zDW6HYLCDfeiz
X-Gm-Gg: ASbGnctepk8pWVe/CcRDVpFhT2UJKFx1H0KjQMFS2xZrig0FcwptTZTHiHXhcr98Hpr
	thMYXHePoyUiufQmH88YcBr55v8/gr4doEezrgjr+7SB2kSZDWqZA0rD+3Y+1WC41Oa/DDxTW8X
	MSkkqsSs6FXJgHRG+eZjgDeyhznikX3PdDvgiGqILqQWW2VGVP3GhL7LRvmJQ33Ss+yTgvHw4WF
	Rt8qggAV8ZVaQ6jT0kAgYhfv2AXgs84jnzcQBZph6SZXjbaOocVyetP7e9f3/XHRl/S7AAD199e
	r1Iwet//9KUiH7Wvcsm3GL9DpOE6yRlCcHG+8FfNwkVRLWUAw6gH4zOP2zujqBA1NAzRR1hvuw=
	=
X-Google-Smtp-Source: AGHT+IHDLDKVeroixzuOKlpZifiKFZ30U9kBiPWBCVJOmDifR2HvJbxzk73ENrrZVlhPiHYpZblRhg==
X-Received: by 2002:a05:6000:2512:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3a4f797d7c4mr2147103f8f.10.1748599981702;
        Fri, 30 May 2025 03:13:01 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/5] pull request: fixes for ovpn 2025-05-30
Date: Fri, 30 May 2025 12:12:49 +0200
Message-ID: <20250530101254.24044-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi netdev-team,
I am targeting net this time as I see that ovpn has landed there.

In this batch you can find the following bug fixes:

Patch 1: when releasing a UDP socket we were wrongly invoking
setup_udp_tunnel_sock() with an empty config. This was not
properly shutting down the UDP encap state.
With this patch we simply undo what was done during setup.

Patch 2: ovpn was holding a reference to a 'struct socket'
without increasing its reference counter. This was intended
and worked as expected until we hit a race condition where
user space tries to close the socket while kernel space is
also releasing it. In this case the (struct socket *)->sk
member would disappear under our feet leading to a null-ptr-deref.
This patch fixes this issue by having struct ovpn_socket hold
a reference directly to the sk member while also increasing
its reference counter.

Patch 3: in case of errors along the TCP RX path (softirq)
we want to immediately delete the peer, but this operation may
sleep. With this patch we move the peer deletion to a scheduled
worker.

Patch 4 and 5 are instead fixing minor issues in the ovpn
kselftests.


Please pull or let me know of any issue


Thanks a lot,
Antonio



The following changes since commit f65dca1752b70ec4f678ae4dbdd5892335bcbbd8:

  Merge tag 'linux-can-fixes-for-6.16-20250529' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-05-29 12:55:34 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-next-20250530

for you to fetch changes up to 64a63e888318cf3259a549662411fa1bd8babb44:

  selftest/net/ovpn: fix missing file (2025-05-30 11:45:27 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* dropped bogus call to setup_udp_tunnel_sock() during
  cleanup, substituted by proper state unwind
* fixed race condition between peer removal (by kernel
  space) and socket closing (by user space)
* fixed sleep in atomic context along TCP RX error path
* fixes for ovpn kselftests

----------------------------------------------------------------
Antonio Quartulli (5):
      ovpn: properly deconfigure UDP-tunnel
      ovpn: ensure sk is still valid during cleanup
      ovpn: avoid sleep in atomic context in TCP RX error path
      selftest/net/ovpn: fix TCP socket creation
      selftest/net/ovpn: fix missing file

 drivers/net/ovpn/io.c                              |  8 +--
 drivers/net/ovpn/netlink.c                         | 16 ++---
 drivers/net/ovpn/peer.c                            |  4 +-
 drivers/net/ovpn/socket.c                          | 68 +++++++++++---------
 drivers/net/ovpn/socket.h                          |  4 +-
 drivers/net/ovpn/tcp.c                             | 73 +++++++++++-----------
 drivers/net/ovpn/tcp.h                             |  3 +-
 drivers/net/ovpn/udp.c                             | 46 +++++++-------
 drivers/net/ovpn/udp.h                             |  4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  1 +
 tools/testing/selftests/net/ovpn/test-large-mtu.sh |  9 +++
 11 files changed, 128 insertions(+), 108 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

