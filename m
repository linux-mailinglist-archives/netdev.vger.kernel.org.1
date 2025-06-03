Return-Path: <netdev+bounces-194765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C2DACC513
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6210417378D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E922FAF4;
	Tue,  3 Jun 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MrS446hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F6149C41
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949092; cv=none; b=DZWtpa+QlEXljkOdddPWTZ56y6+aMOSoSo21HVTmZf1FMmthK604YRucwDScdkX1n78CLbcfJOBQUV3WUq41cpo1iQH1Za9iVt5wPL+vmWc6I1UxQCYlH5/kaIWmFs8Wy+Q7Y5buiwIx19zzlGMsnyFCh7y5i0ctAC6BjvrVhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949092; c=relaxed/simple;
	bh=ddSx87j2b/wethd973Bjs84NER0mKR9D5FDWt1Wtgb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ79AqASMNsxs0hty9VhuZvIgJ26M4AyyAMf6Flowk4MLlFwoH8T8FBqWH5yCHvhUc+TtqL2wdMC0Jw2f8+zean8veF16wLNDoJKGKXd2LGlIsOmMDg9AqQKIjjQQreMzwHJTySj4R3rmNf0AmlK2XBRM+Ztv6/PoNcxX5KVPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MrS446hd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d54214adso21172415e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748949087; x=1749553887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1O+G39zuQ0j4f3Im1BQ0ByTPG2i2UdQAzgJhKcuUgEo=;
        b=MrS446hdVLvXhTegZG5KGjqo919K6/OVjEIH5EAOo91Rdjm2ZEHtqawXe92ktXDa/f
         UT5qK+B7HQMn3CYqtX90q0G45Cc+BDhvrqZlu72hkrlme55B3lZ0LHFFdQe6x32AC+zn
         sw9B6BDYThuYFT+M6zFa9BJO0GYJvFfA5zctJQRTmWJygLAPBEAYwT89VzMvrVta3q95
         Gfpim7zLle2oJmjBdI+KLbPVXE1dak3lCGTdSc6Xhz4OpUzOQIeijmrx0nV09g5H97lw
         Xjo5hSUpTkQYMuCYUlRZMxpDnXReaEFK09yKAvN95GfMgCeYmXWDUV1yVJe+6ciwXET6
         +PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949087; x=1749553887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O+G39zuQ0j4f3Im1BQ0ByTPG2i2UdQAzgJhKcuUgEo=;
        b=ofVwMzdb/eyi4WQOYcvykwiE+j9w+6Fq/ZI4Q3QsN+Rfzs+dAn2li/+EWTf/rfkqf3
         ukAxFipVNqN/XLZhvee9lhV9e/AINysUB1O/ESJM9UbJzR5ZJMX2D1vvarbx98h/QFcS
         kXopxz+q2fD17+EphlTo8Vv2MMsFWjmuPbBvObhUff2DpHeZoXoYDRRzpcLvVMZ0/l1s
         ZkuypZ79LSdoZtbdoZeOiw1sGViAvmI+0T1kKMSS2ESZuNf0U3kGe/WMBgntfq6PZNXi
         H7Td2JEzKAGbkwAlIEfgxbi3Q1ZfVUC47c29p1byVyGEfGYP059SW6kPraG2DZglVQrD
         Rk3g==
X-Gm-Message-State: AOJu0Yy1WaOmraWv4dulSrHs+j4b0gLVL1Oj0eHEyqCGSL6ebTSpFRvZ
	of137VT9cGZ1eCbf4V2vczLLofTzXI3293Zg6IY5bNssz967CrUZjWw5p2fLpPPvmRP6ajdkdWb
	w8F+5KJ2/SmgbIbPj2Hoy4Ds8Ik+bzB09VNvRyy+oUKUtnmivfW6ysfK55XfnFAsx
X-Gm-Gg: ASbGncsT11KnH8TlWEbnvprH3wYvEpRlNMqFscBBUx7ut5R4nDt6WEC1YmwjFsxs0W6
	gKOv7Bl8yFT/qFJYSMGiGAHlUq02P3kHEML8az3SbgkKGydBmVu6a7Grp6xd++bhkWVUf5LuAlV
	ram6/5liyVCnoI2IItoi+Rzw4BNPvsFzkryu2XEvcxB56hf+ncbxfqeZTM94kxk5frpFX6Co96W
	6U5orGcThUe21YF+3r3m2WQ4lKpuih8ECJIwAZSXug1kXAxyOc9dMi9+JKq3Jf8jBPRj2R5EqQp
	1rnJOhtAn/eqQRFkKcilYdohX6Y1wS34v8O6mWH2qxCIJx9/Mlv+AJI30RiQIRP65I9BE4wzSmi
	9m5JMip1AGQ==
X-Google-Smtp-Source: AGHT+IFDKwI0xPJArN1iMwhcxgYZSAKN0i5t+bPVbf7n5ut9hEEZMbt56KnvjwnlXSX/nZvTC8jkdA==
X-Received: by 2002:a05:600c:358c:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-450d655fa64mr138477725e9.29.1748949087558;
        Tue, 03 Jun 2025 04:11:27 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm163244525e9.13.2025.06.03.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:11:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/5] pull request: fixes for ovpn 2025-06-03
Date: Tue,  3 Jun 2025 13:11:05 +0200
Message-ID: <20250603111110.4575-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi netdev-team,
[2025-06-03: added WRITE_ONCE() to 1/5]

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


Antonio Quartulli (5):
  ovpn: properly deconfigure UDP-tunnel
  ovpn: ensure sk is still valid during cleanup
  ovpn: avoid sleep in atomic context in TCP RX error path
  selftest/net/ovpn: fix TCP socket creation
  selftest/net/ovpn: fix missing file

 drivers/net/ovpn/io.c                         |  8 +-
 drivers/net/ovpn/netlink.c                    | 16 ++--
 drivers/net/ovpn/peer.c                       |  4 +-
 drivers/net/ovpn/socket.c                     | 68 +++++++++--------
 drivers/net/ovpn/socket.h                     |  4 +-
 drivers/net/ovpn/tcp.c                        | 73 ++++++++++---------
 drivers/net/ovpn/tcp.h                        |  3 +-
 drivers/net/ovpn/udp.c                        | 46 ++++++------
 drivers/net/ovpn/udp.h                        |  4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  1 +
 .../selftests/net/ovpn/test-large-mtu.sh      |  9 +++
 11 files changed, 128 insertions(+), 108 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

-- 
2.49.0

The following changes since commit 408da3a0f89d581421ca9bd6ff39c7dd05bc4b2f:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2025-06-02 18:44:37 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-20250603

for you to fetch changes up to 9c7e8b31da035fe81399891b2630a8e0c4b09137:

  selftest/net/ovpn: fix missing file (2025-06-03 13:08:15 +0200)

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

