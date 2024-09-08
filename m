Return-Path: <netdev+bounces-126288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268009708A0
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3434281EBE
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FEB174EDF;
	Sun,  8 Sep 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jJF3pSgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90417332B
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811715; cv=none; b=I5SKKJ/rLWg2vPjFQRVJOMzZ+3WBnyhqZ61iILHNbEI6XuvMTQKzg5qYjPn8mkHC/8Ug3X335J8HRaHMXUGG4KbUU59PIVhW3jBEkFsalu8k9VYa4di19zHaKKjIUr435IAFhuOVwOJSiEJKpqlYjdAyj3Xgo6eh9jlRKaufleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811715; c=relaxed/simple;
	bh=d1SJ6LoFe2aycIS8zlcPtlL3qEn0YKyAHK6GBjmi9hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jSek5E4YihLx88tDZh68yvmaQL7P4BVg8KceXz+Dm4VCWTVWyWCaDjYEAVargqu+pOMVvF1W5Kwqa5zIGy1phZhqOD7n/dZArcjO0TgbZJashtLcxF4FJjT0phMfXF11fzbCdfDzIY4o8SNy1RHtq0EVgojaSGt1G25qHj9mOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jJF3pSgM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20543fdb7acso24994625ad.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811712; x=1726416512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SomZmziGpMGXIekwEZ/hOQ49E7ojTswYIcqey4fsQv8=;
        b=jJF3pSgMZXvQXhLqBBoRnICxQXRLk//3lrwSQShoxkxgriMnGgv+ZiSuTqM3/CGOmb
         /S0Dz6wrxsgPebX8fhzAkvW8EfcudYtpH+nBbVGmDJmioKfBtzS9UpqStGKxliqeyBbm
         pu02ihIo1T4Zqduu/+nyv/LuTNEmB/VkaBiEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811712; x=1726416512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SomZmziGpMGXIekwEZ/hOQ49E7ojTswYIcqey4fsQv8=;
        b=NdA0AEM1Wv7RmyYxqDFb806+0oIz13V+v+rFdq8tFdcFe1naUqAFxXkt462vLCKxiI
         AMY90oMH1k3M8lCYIj8wCfAAjTkZX8Gq4PiSlHsvCKAAwdy1NlDpzkkvsc/deZfgImSm
         ce/OsoSi8aKmbX47ASu8qNgnGv2dgceai1Eie8ObDaNln45T7yM3G71tj/GFkjrMpNMe
         C+otsxQfd3hkqmDxlCx1L+fUUPf1on/Wus8cydn2if4JD8dP5okhqk1JtOOpPtV2X/lg
         SUv4S844DYnaACinfsK3/LjRdPgFhwi9Wh0Jz0VNmWRKRxX+VcRzUX4VpEqHMazadkVI
         msIw==
X-Gm-Message-State: AOJu0YzsZOQDs6QFnX3bi2gv4iDfCzTxmyiiD3iU/xVyu0/1+gGHZGsA
	ri/UVFwQcSR4/ip41CF/+t/DKx81EdydqAJobHumrJo4EVPid3Xm6o6rwqlFp2JymEPdz5UM4d7
	OZ8AxTa07pG8Rtlhk8YnRfLnrJIvCRFJhLL4NkJtTXdRvfCMxWkBp4Hx4PFUW7Q+pjbUy6g7j77
	cu0tpvH2l1yu1oEQ36ZiEUqxN2u0VzzhT13ip/MYoR
X-Google-Smtp-Source: AGHT+IEy/oRO5KRQG8CMK08JMPDBnNoUtQepErYccQ4Mj9OfucS7wZYm98qQCTryJjm6EjpI0lFPmQ==
X-Received: by 2002:a17:902:ccc1:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-206f05f67acmr85788925ad.41.1725811712026;
        Sun, 08 Sep 2024 09:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:31 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Daniel Jurgens <danielj@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC net-next v2 0/9] Add support for per-NAPI config via netlink
Date: Sun,  8 Sep 2024 16:06:34 +0000
Message-Id: <20240908160702.56618-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2, converted to RFC.... which is definitely incorrect, but
hopefully can serve as a basis for discussion to get to something
better.

This implementation allocates "struct napi_storage" and each NAPI
instance is assigned an index into the storage array.

It seemed like this storage area should persist even if different HW
queues are created, but should be cleared when queue counts are resized
(ethtool -L).

What I did is flat out incorrect: memset the struct to 0
on napi_enable.

I am not totally clear if I understand the part of the previous
conversation about mapping rings to NAPIs and so on, but I wanted to
make sure the rest of the implementation was starting to vaguely look
like what was discussed in the previous thread.

To help illustrate how this would end up working, I've added patches for
3 drivers, of which I have access to only 1:
  - mlx5 which is the basis of the examples below
  - mlx4 which has TX only NAPIs, just to highlight that case. I have
    only compile tested this patch; I don't have this hardware.
  - bnxt which I have only compiled tested.

Zeroing on napi_enable is incorrect because, at the very least, it
breaks sysfs (the sysfs settings should be inherited). It's not clear
to me how we achieve persistence with the zero-ing unless we assume the
drivers are changed somehow? IIRC, there was a suggestion in the
previous thread to memset the napi_storage to 0 on queue resize, but
I've definitely gotten the nuance in what was desired wrong.

Anyway, sending what I have before iterating further to see if this is
even remotely the right direction before going too deep down this path.

I hope that's OK.

Here's an example of how it works on my mlx5 as is:

# start with 4 queues

$ ethtool -l eth4 | grep Combined | tail -1
Combined:	4

First, output the current NAPI settings:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Now, set the global sysfs parameters:

$ sudo bash -c 'echo 20000 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 100 >/sys/class/net/eth4/napi_defer_hard_irqs'

Output current NAPI settings again:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Now set NAPI ID 927, via its ifindex and index to specific values:

$ sudo ./tools/net/ynl/cli.py \
          --spec Documentation/netlink/specs/netdev.yaml \
          --do napi-set \
          --json='{"ifindex": 7, "index": 2,
                   "defer-hard-irqs": 111,
                   "gro-flush-timeout": 11111}'
None

Now output current NAPI settings again to ensure only 927 changed:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 11111,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Now, increase gro-flush-timeout only:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"ifindex": 7, "index": 2,
                              "gro-flush-timeout": 44444}
None

Now output the current NAPI settings once more:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 44444,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Now set NAPI ID 927, via its ifindex and index, to have
gro_flush_timeout of 0:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"ifindex": 7, "index": 2,
                              "gro-flush-timeout": 0}'
None

Check that NAPI ID 927 has a value of 0:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Last, but not least, let's try writing the sysfs parameters to ensure
all NAPIs are rewritten:

$ sudo bash -c 'echo 33333 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 222 >/sys/class/net/eth4/napi_defer_hard_irqs'

Check that worked:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 928,
  'ifindex': 7,
  'index': 3,
  'irq': 529},
 {'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 927,
  'ifindex': 7,
  'index': 2,
  'irq': 528},
[...]

Resizing the queues (ethtool -L) resets everything to 0, which is wrong
because it breaks sysfs and it breaks the persistence goal.

I hope though that his code can still be discussed to ensure that I am
moving in the correct direction toward solving these issues before going
too far down the rabbit hole :)

Thanks,
Joe

Joe Damato (9):
  net: napi: Add napi_storage
  netdev-genl: Export NAPI index
  net: napi: Make napi_defer_hard_irqs per-NAPI
  netdev-genl: Dump napi_defer_hard_irqs
  net: napi: Make gro_flush_timeout per-NAPI
  netdev-genl: Support setting per-NAPI config values
  bnxt: Add support for napi storage
  mlx5: Add support for napi storage
  mlx4: Add support for napi storage to RX CQs

 Documentation/netlink/specs/netdev.yaml       | 35 ++++++++
 .../networking/net_cachelines/net_device.rst  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/linux/netdevice.h                     | 38 ++++++++-
 include/uapi/linux/netdev.h                   |  4 +
 net/core/dev.c                                | 36 +++++---
 net/core/dev.h                                | 83 +++++++++++++++++++
 net/core/net-sysfs.c                          |  4 +-
 net/core/netdev-genl-gen.c                    | 15 ++++
 net/core/netdev-genl-gen.h                    |  1 +
 net/core/netdev-genl.c                        | 65 +++++++++++++++
 tools/include/uapi/linux/netdev.h             |  3 +
 14 files changed, 276 insertions(+), 19 deletions(-)

-- 
2.25.1


