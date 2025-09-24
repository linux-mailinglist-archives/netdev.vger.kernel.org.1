Return-Path: <netdev+bounces-226076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD7B9BC35
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732D21896631
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0524DCE2;
	Wed, 24 Sep 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZKaEv6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596821FF46
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743403; cv=none; b=C+D54esjhRHNcEveBA2gbILcxnzjQ4wqrrcAFRAM9WZTSNS8ZyhSlARFNC07wtJBzX9ZbZdggJC9QhMZJuaRuQca42bq6tgUVq7bBhMQJw0e6vhXX7vYP5Ch40EpP30Fqha8dZqk/R7rAC3hf94QNJ7i3gcErPnU6IuDqUWXhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743403; c=relaxed/simple;
	bh=r753Y7v/HnEGHLVGshS1GkoSFLsdz0vXtz21Blb7cnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOdhoR7jmnICcJ7NXV6tbW/AmfYBM6Jzwp6dVKteM5WlVoTenQdUFgAje54OA9svdXtXFJ6uUxOA+hrpCTAH8LwPfWSI9Ix3kDdgV8XdBk8ZUaH/NFHExuR0sESIY9WZZg/fye68quZWL5zswtYE3qKI1AzhrcXdyU00ckc6r88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZKaEv6a; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d601859f5so2574747b3.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743400; x=1759348200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEUEgN71ZA4sRB5scDQfC5Em06mqQDj4FFf+ugAG1cg=;
        b=eZKaEv6aWRL5tWAKIMCS/Y+/Sz0DJtXrdDTPFyb+fJgZbAuk+ieR2lD5M9gbSFC3/h
         xjeRCshV6hQMOsGEggc3BhyEk1kpKkd6TRvyFrqfP6k5x0udskCYxDfCF8v+1U2e2t5f
         G1MWJRbxS8luDzalXcBt6NPmX8UeM8pLipAjYd83xDARVfmPmL9MCHVhMSKDXaauhv3C
         5gvh6nlcEVuS6tTNKsCENDCEWQjrSB1yUY8cbn5z5wYEsANmqkBj/meEL2Z5eoh6i/ul
         gaagSnBpzUlO6+sS7F0vDGEAYxj4A+eOrBkmT0z2moE0aGllp3BSzjC2pQ2pjO/U4B2W
         JSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743400; x=1759348200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEUEgN71ZA4sRB5scDQfC5Em06mqQDj4FFf+ugAG1cg=;
        b=bPOFewsH32RmU72smE0GGczMLv4kX8H2fE2dFUDKLNU7X1vInf0lnpluc4hsMTwIGv
         OChUJXf9l/pjN7AN1xbwNmYOIvxGZdRPTRHeGFonEPRbiESmBJGkwvdKdftC09SvmwIr
         o7FXfxpU2J1z5HMTd1ki1dakw/u51LPSs+P7cdL2Cffjq5HaKifjIM0S27p5n5Yc/4pb
         BoBwAFv0j3Ea0gAXM914JhTS01Es2QqudvMm+5icUM6AzOhoW/RgAhUqCQxvOtQbkUhp
         nX63H26DUEktW36twet+uqWLklukN1LPHKxXcD+3OCoX1axwycOGrJ+qvpKZ+gHAooRp
         q6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUJbKDAe5koVLHw6OjkaceMWLcfhc1G7hJjUgK+S39Utqo/ZY+PLXq3Dor144hEUCFdI5sOuqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNAfWofoc/vohq+6dzRYSdjbJ8p1u07/Q7cIn7sOf526g8OF1
	Zq0Xhzfb96bnUWf8hvLryYSscH/nwDo6VkJwyv9sV1sQM361s/Tex5nr
X-Gm-Gg: ASbGncuHzppqcoYqBcJXzYezC7rCDSH7gsNJVMAlrokxQ6KC/AjFgM0Y4d1lkVXXj/S
	sAEfD4/6weNqhlR+4B0rEzXkom5JGwBXJlq0SwtLDzvD20NTTE1scqTjQAtOahp5nij6J5H1P99
	gFhLIKjxZu4Qh2f5ZlfltsJQJgSQm/VZFe+UaX+JXc2gAlpc4GmekY9qAw3hMB17//dVzd1pHC0
	7ItlSbpOcTXVNT9Iir2nCTfIWLN7yIH8jP4dgFFgsGevwjkcZ8wd+JwkJhJNuajgXGzM9mPof50
	sTbirBwQTDtl4T6zqFlE3ewWmqsxjIwP3w5WhDxqEEopthsuM07zZJeG8TE2EbqIkKlPe8snzRT
	YPY3bdC/N65VV3fRzGgw=
X-Google-Smtp-Source: AGHT+IH/DaSMfQgo68HIXNoVMs0zIgKNlfrwiGAY7uGng6ZQ2VLl12YiYDT45M+Tk52gspgj9NQB2g==
X-Received: by 2002:a05:690c:3609:b0:723:adfc:5a4a with SMTP id 00721157ae682-764018539d0mr11110757b3.33.1758743400463;
        Wed, 24 Sep 2025 12:50:00 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716e7b26sm50822847b3.16.2025.09.24.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:00 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/9] psp: add a kselftest suite and netdevsim implementation.
Date: Wed, 24 Sep 2025 12:49:46 -0700
Message-ID: <20250924194959.2845473-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
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
    ok 1 psp.test_case # SKIP Test requires IPv4 connectivity
    ok 2 psp.data_basic_send_v0_ip6
    ok 3 psp.test_case # SKIP Test requires IPv4 connectivity
    ok 4 psp.data_basic_send_v1_ip6
    ok 5 psp.test_case # SKIP Test requires IPv4 connectivity
    ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
    ok 7 psp.test_case # SKIP Test requires IPv4 connectivity
    ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
    ok 9 psp.test_case # SKIP Test requires IPv4 connectivity
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
    # Totals: pass:19 fail:0 xfail:2 xpass:0 skip:7 error:0
    # 
    # Responder logs (0):
    # STDERR:
    #  Set PSP enable on device 1 to 0x3
    #  Set PSP enable on device 1 to 0x0

Daniel Zahka (1):
  selftests: net: add skip all feature to ksft_run()

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
 drivers/net/netdevsim/netdev.c                |  56 +-
 drivers/net/netdevsim/netdevsim.h             |  38 ++
 drivers/net/netdevsim/psp.c                   | 218 +++++++
 net/core/skbuff.c                             |   1 +
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |  10 +
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |   5 +
 tools/testing/selftests/drivers/net/psp.py    | 609 ++++++++++++++++++
 .../selftests/drivers/net/psp_responder.c     | 481 ++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  14 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 16 files changed, 1439 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/netdevsim/psp.c
 create mode 100755 tools/testing/selftests/drivers/net/psp.py
 create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c

-- 
2.47.3


