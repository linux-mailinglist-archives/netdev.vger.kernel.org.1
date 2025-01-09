Return-Path: <netdev+bounces-156547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58705A06EB9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45704167879
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8F2144A3;
	Thu,  9 Jan 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="eUC9z/QX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC20102E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406849; cv=none; b=Lj85csxIbitpeNZuteXa0W7ED4Y0dHOLWeziDADEovgeHBGVk8y7jnLPwleJC7YOybcQwUQZfmIp5lpci/jxrflbSkTQAdkQXf+FNw9tg69TKiUVdID4+zki29/OBXwJWdE/4zY8Px20l++8QqYLAC7f+PWk6b67T5TBO5uNvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406849; c=relaxed/simple;
	bh=LqvxA5ftiyTpqtyco60E1+2R8PkBLlpmDEhHjtL9mxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=hnWIGfidmGYvA4j/3Qf4uq48bkjkOo/zl68klVzynIqsmsVC/06PMZz34YdkqyuR+RLpkG9rdwymOK7bXCeMYfIhSb+ex4OSuAn6/Fa3qTfTr3gzzKSDplcHqKoGZM1cWdnNwtK857Jtc9/TEbhQzkfgW1Qt1Ldj2iF1FKCLaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=eUC9z/QX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso787004a91.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406847; x=1737011647; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ja/03/V9ZzSisHs2kOKIjRXGVbNIxLyyvnfSlbsG0Y=;
        b=eUC9z/QXatG3ZBxGA8FcBWGGYdLDZGlIBAJ0J819pD3x1FxqUGlg3zgFLfHZ2D5jLl
         PDhA8iMOSw6mQdgjUHTGmLWjQgWrljWdQJsnfxhL9Zo2Sh5Tm23PYGiTXjYr7EqljkZH
         Zf2QVefem2456U5gg2X+ZWfIHM6zGdvvjqrQsfekFikdqnpE+Wjwg3I8OuGmYDuO+r38
         JP1RM5J8wGFVWOkHTwR+U43EBUEfZlenCEsQeYnsNHJsCornNuIxpd0fUyV0gP8FZwEJ
         VbBLGpUpSn/fnC/ZQUYFvbfOrTF3+ZYVKjQT9zr3fwb3SMlgqKfkCT8PSCwuTcQBrOl4
         +R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406847; x=1737011647;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ja/03/V9ZzSisHs2kOKIjRXGVbNIxLyyvnfSlbsG0Y=;
        b=tPFUbFFxAc31X+RhcXk55IRLBEhTye0wqZ8Fushv1SqGXR3MsJHHKhOo5OodOUUm3u
         7m5umEvypiqvGa/GoGirYKhh7jChC2G4NxDE+7f06ev4YzGUjPh4DtGyLLUc4nQyilXj
         QRHxqYvkeLPBcNR3iSaJwWcqDR8miDeFyYB5ZkSvacchHd0yS4/6p9gol69Cs+YIo9pi
         3qriEDbfvZofY5DLzVzIYQ6V2A/EI4hGuOQdPzCSCIhadSrtDlpaDRB7xrW6ES+JEWp2
         GT0rewnFOLq69vcOd7SGqxWTtztQ/mfHUJvuWpnNgiSpMGr+xGx83IHy2X4anTkJSJhE
         Hkvw==
X-Forwarded-Encrypted: i=1; AJvYcCXHQNhU54AlCg8aCKv5wEf1MOwXs2n5T6qvUtFLcHjOWwBJen8HZ4ZwiKKH5hYHYsUSp1ZCkVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPb2/9FneYekOK2/sbxGcOI8XIROXtyWZ67lFabOxK6vxwtoo
	Q43uw2UH4eGwjyZA9ZRzRgDcwU2gm9v3J3rhz6kwRjICto6/oQmNo7yyt37tkmM=
X-Gm-Gg: ASbGncttBI3hCT8d+HEJr/eDnAk+sIpa8utALXEM9kxMHh9rYOKJ0ukPMStxeKljyYX
	Y8gWNCv/9VeU+Vs4NehiPmujmcZt9OEaoClPvm6mDhk6BIqH5rpLaPeMQ51EoGk8OfQVsrXFME5
	mN2mQuKdIfAiB1FN1bxZIcjkj7DIelebxxodNMqUUdCdM/h2RPZ7adLKT/DnXa307YPo9pyPzgg
	uZPBg0vUNMd8hiVzp3vbX5lFKMVKTRnRFGCoVNCl6Db1SSNUEjimyqswZI=
X-Google-Smtp-Source: AGHT+IFJUP6kT2nk/Shr8HhgnublEXClAdP2xLMbF7YF7Q3uJCPF52tP7YCh+wLuw1haRrn273Yx8A==
X-Received: by 2002:a17:90b:540f:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2f548eb321emr9251390a91.15.1736406847130;
        Wed, 08 Jan 2025 23:14:07 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f559404c43sm633599a91.16.2025.01.08.23.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
Date: Thu, 09 Jan 2025 16:13:38 +0900
Message-Id: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ3f2cC/4XQQW7DIBAF0KtYrIs1wBiwV71H1QWGoUFR7dY4V
 qIody+21TZVFt0xiPeBf2WZpkSZddWVTbSknMahDPqpYv7ghjfiKZSZSZAICIpPOXMyygTbUnT
 GsHLyY6KYzlvKy2uZDynP43TZQhex7q5eCQALjRQgaoGIUnLB3TEd0nGsx1BWz8FdhnSu/fjO1
 pxF3lnRCBQasZYaNOp/rfq2CK1otncvigP3WkEJCz1Y+YDwDkncERZkkVolyQNp/4CaH7T+cEd
 NQVH5qG2IAE34g257ZxN9nkrh817cb99dtWVJBXw+DVxrEuCw7cGbrlRScO8y8RL1nuauansZo
 9MCbS8IsdwINhoCMqSM8Ki8822MVO69fQE99LhV8AEAAA==
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
and fill full vnet header"
https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Introduce the code to compute hashes to the kernel in order to overcome
thse challenges.

An alternative solution is to extend the eBPF steering program so that it
will be able to report to the userspace, but it is based on context
rewrites, which is in feature freeze. We can adopt kfuncs, but they will
not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
and vhost_net).

The patches for QEMU to use this new feature was submitted as RFC and
is available at:
https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v6:
- Extracted changes to fill vnet header holes into another series.
- Squashed patches "skbuff: Introduce SKB_EXT_TUN_VNET_HASH", "tun:
  Introduce virtio-net hash reporting feature", and "tun: Introduce
  virtio-net RSS" into patch "tun: Introduce virtio-net hash feature".
- Dropped the RFC tag.
- Link to v5: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com

Changes in v5:
- Fixed a compilation error with CONFIG_TUN_VNET_CROSS_LE.
- Optimized the calculation of the hash value according to:
  https://git.dpdk.org/dpdk/commit/?id=3fb1ea032bd6ff8317af5dac9af901f1f324cab4
- Added patch "tun: Unify vnet implementation".
- Dropped patch "tap: Pad virtio header with zero".
- Added patch "selftest: tun: Test vnet ioctls without device".
- Reworked selftests to skip for older kernels.
- Documented the case when the underlying device is deleted and packets
  have queue_mapping set by TC.
- Reordered test harness arguments.
- Added code to handle fragmented packets.
- Link to v4: https://lore.kernel.org/r/20240924-rss-v4-0-84e932ec0e6c@daynix.com

Changes in v4:
- Moved tun_vnet_hash_ext to if_tun.h.
- Renamed virtio_net_toeplitz() to virtio_net_toeplitz_calc().
- Replaced htons() with cpu_to_be16().
- Changed virtio_net_hash_rss() to return void.
- Reordered variable declarations in virtio_net_hash_rss().
- Removed virtio_net_hdr_v1_hash_from_skb().
- Updated messages of "tap: Pad virtio header with zero" and
  "tun: Pad virtio header with zero".
- Fixed vnet_hash allocation size.
- Ensured to free vnet_hash when destructing tun_struct.
- Link to v3: https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com

Changes in v3:
- Reverted back to add ioctl.
- Split patch "tun: Introduce virtio-net hashing feature" into
  "tun: Introduce virtio-net hash reporting feature" and
  "tun: Introduce virtio-net RSS".
- Changed to reuse hash values computed for automq instead of performing
  RSS hashing when hash reporting is requested but RSS is not.
- Extracted relevant data from struct tun_struct to keep it minimal.
- Added kernel-doc.
- Changed to allow calling TUNGETVNETHASHCAP before TUNSETIFF.
- Initialized num_buffers with 1.
- Added a test case for unclassified packets.
- Fixed error handling in tests.
- Changed tests to verify that the queue index will not overflow.
- Rebased.
- Link to v2: https://lore.kernel.org/r/20231015141644.260646-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (6):
      virtio_net: Add functions for hashing
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Introduce virtio-net hash feature
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |  50 ++-
 drivers/net/tun.c                    |  93 ++++--
 drivers/net/tun_vnet.c               | 167 +++++++++-
 drivers/net/tun_vnet.h               |  33 +-
 drivers/vhost/net.c                  |  16 +-
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 +++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  75 +++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 630 ++++++++++++++++++++++++++++++++++-
 16 files changed, 1224 insertions(+), 51 deletions(-)
---
base-commit: 9b2ffa6148b1e4468d08f7e0e7e371c43cac9ffe
change-id: 20240403-rss-e737d89efa77
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v2
prerequisite-patch-id: 057e888c371f2ce750064b7c40c2cc6abbdf6819
prerequisite-patch-id: 22d53dd3443a2c72496bffb90f19d429972550a3
prerequisite-patch-id: 1520f0c1f7b11559d0898bea556f745f6b8914ac

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


