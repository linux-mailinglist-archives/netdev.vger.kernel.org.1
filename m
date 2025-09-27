Return-Path: <netdev+bounces-226946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F821BA646E
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 00:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D293118995E1
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715023AB88;
	Sat, 27 Sep 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNyQ0oNF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4E14A91;
	Sat, 27 Sep 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013668; cv=none; b=kjtIgBUjQ0dUXKmnNXu3qHEANwYAu6Cwukp9iu5hYe5gQEdGsqwt0uEipiZ9Givr4n631akKX4+FAl5hEqZG2gzBokmwLVSshdcjuDQj8oeSIKDt4O/EdAqy4VmDkr5V8KIpdF5XaGuej+56llXERcVpB9oH0wqG2TM4yLjSc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013668; c=relaxed/simple;
	bh=Eq8l19aTjPjUmDSY3trBDrWZJJQ4aLX1n7crA2gTYWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQ3/BiUjFzIYVKY8aDUUTgDjbQtHqmEooNf3IMPrk4rxTqoQ/rvqpLSd5sr7rr4SEF6Wr9CSoPjr5O/KTD0f9JeByZi4/zu32jMic2aZJYoOqVmEPoW7ZifIAJglHIfobE9vvt9W76rpJ82oYJbp1P9k0LmrWgXYmIs/luJseyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNyQ0oNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC80BC4CEE7;
	Sat, 27 Sep 2025 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759013668;
	bh=Eq8l19aTjPjUmDSY3trBDrWZJJQ4aLX1n7crA2gTYWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lNyQ0oNFAIZDKylXEi6DikyJbjaRPM860fEka922kd0n6+MznxRytYgZTuNe7TIfL
	 8QgOuPw4GFG2sFWLq9RBjsswim3Lbevzy/+7L3AOo0yGtVdmwJLMeWCC9X9Mi1oE8N
	 +ElV5omaHRgfQteeW+yj8d6dAyS1iIm1Rc8jc5OO5zHjMA8QWdp8dIwVCGnRTazCPi
	 5fCCwHGBkP2B2n08MklPPvuH91ROOATn5OxtLsSKIog5ZWHw7QSv5ObBWw7G0sA6LE
	 slrWuLkIyPsuiAfKOVOQJloxVgA4PLqt+07ULtwpi83QHCg0ghlbGrxtOu5Ej8MSPP
	 RRgtdvXyD2j2w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	shuah@kernel.org,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/8] psp: add a kselftest suite and netdevsim implementation
Date: Sat, 27 Sep 2025 15:54:12 -0700
Message-ID: <20250927225420.1443468-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic test suite for drivers that support PSP. Also, add a PSP
implementation in the netdevsim driver.

The netdevsim implementation does encapsulation and decapsulation of
PSP packets, but no crypto.

The tests cover the basic usage of the uapi, and demonstrate key
exchange and connection setup. The tests and netdevsim support IPv4
and IPv6. Here is an example run on a system with a CX7 NIC.

    TAP version 13
    1..28
    ok 1 psp.data_basic_send_v0_ip4
    ok 2 psp.data_basic_send_v0_ip6
    ok 3 psp.data_basic_send_v1_ip4
    ok 4 psp.data_basic_send_v1_ip6
    ok 5 psp.data_basic_send_v2_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
    ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
    ok 7 psp.data_basic_send_v3_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
    ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
    ok 9 psp.data_mss_adjust_ip4
    ok 10 psp.data_mss_adjust_ip6
    ok 11 psp.dev_list_devices
    ok 12 psp.dev_get_device
    ok 13 psp.dev_get_device_bad
    ok 14 psp.dev_rotate
    ok 15 psp.dev_rotate_spi
    ok 16 psp.assoc_basic
    ok 17 psp.assoc_bad_dev
    ok 18 psp.assoc_sk_only_conn
    ok 19 psp.assoc_sk_only_mismatch
    ok 20 psp.assoc_sk_only_mismatch_tx
    ok 21 psp.assoc_sk_only_unconn
    ok 22 psp.assoc_version_mismatch
    ok 23 psp.assoc_twice
    ok 24 psp.data_send_bad_key
    ok 25 psp.data_send_disconnect
    ok 26 psp.data_stale_key
    ok 27 psp.removal_device_rx # XFAIL Test only works on netdevsim
    ok 28 psp.removal_device_bi # XFAIL Test only works on netdevsim
    # Totals: pass:22 fail:0 xfail:2 xpass:0 skip:4 error:0
    # 
    # Responder logs (0):
    # STDERR:
    #  Set PSP enable on device 1 to 0x3
    #  Set PSP enable on device 1 to 0x0

v3:
 - fix netdevsim bugs
 - rework the skipping
 - use errno
 - remove duplicated condition
v2: https://lore.kernel.org/20250925211647.3450332-1-daniel.zahka@gmail.com
  - fix pylint warnings
  - insert CONFIG_INET_PSP in alphebetical order
  - use branch to skip all tests
  - fix compilation error when CONFIG_INET_PSP is not set
v1: https://lore.kernel.org/20250924194959.2845473-1-daniel.zahka@gmail.com

Jakub Kicinski (8):
  netdevsim: a basic test PSP implementation
  selftests: drv-net: base device access API test
  selftests: drv-net: add PSP responder
  selftests: drv-net: psp: add basic data transfer and key rotation
    tests
  selftests: drv-net: psp: add association tests
  selftests: drv-net: psp: add connection breaking tests
  selftests: drv-net: psp: add test for auto-adjusting TCP MSS
  selftests: drv-net: psp: add tests for destroying devices

 drivers/net/netdevsim/Makefile                |   4 +
 tools/testing/selftests/drivers/net/Makefile  |  10 +
 drivers/net/netdevsim/netdevsim.h             |  27 +
 drivers/net/netdevsim/netdev.c                |  43 +-
 drivers/net/netdevsim/psp.c                   | 225 +++++++
 net/core/skbuff.c                             |   1 +
 .../selftests/drivers/net/psp_responder.c     | 483 ++++++++++++++
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |   4 +
 tools/testing/selftests/drivers/net/psp.py    | 627 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  10 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 16 files changed, 1440 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/netdevsim/psp.c
 create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c
 create mode 100755 tools/testing/selftests/drivers/net/psp.py

-- 
2.51.0


