Return-Path: <netdev+bounces-207412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C5B070FA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C457ADC90
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0882EF9DC;
	Wed, 16 Jul 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MofX2jhP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D82EF9BA
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656142; cv=none; b=M97v1YO9N/xXc4YSh1aG6WxsO8QO25lsjLSiJ4eXOoum7cKPgE4Nd/Vdu/Ba6y5Gjxytl6elhe++CTlXhYwy9figPWLa3++KwSg439L50ijgRKCJsO9BB2MXk/MuK5kG4Q9Igft5uVygMCSPBH3rMfqucQQaXX6as1V/AAk/QsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656142; c=relaxed/simple;
	bh=3XujhVuiu4yaKX8VdtoT8L7ry694S9HL3N/1pn8FpHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/G+5hFAQw8Vx36/HGIildi0S7irrJciiX8iUQdR8xjpi4jZlYX/rQN+YTGbAGzQxq/d+EFuxyoZeSlTzUpn3zwNBS/SH+iz//tNbOL0QhqRa6yWrocGY9CR0hZcm1Zb0hrfdtHhvOWc/xah7+Q1WjYDyGKnpmkxTe0gLdB5ULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MofX2jhP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJc5h/pWyKQ+w9Bq81OUahiAahZ/ZW6ST7tvA1a1o5A=;
	b=MofX2jhP2x9BdHouCnHX8ytqk0oPBfFw+jPS/f2lyZ6QaWEBFONZmL4xoE+Z/73uAF/ZJA
	fcGFQis42QroSYEvFyAoMq7lINccV0SO7uAiZDm1rXkk77tzxsH/Zp7rBENDeXdgMjiWGs
	Eh36WmhyiQYeB8MAq/fpGYNBnJKvF8E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-oTNTsiHaP3miKgFFCaAaJQ-1; Wed, 16 Jul 2025 04:55:37 -0400
X-MC-Unique: oTNTsiHaP3miKgFFCaAaJQ-1
X-Mimecast-MFC-AGG-ID: oTNTsiHaP3miKgFFCaAaJQ_1752656136
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso39494785e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656135; x=1753260935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJc5h/pWyKQ+w9Bq81OUahiAahZ/ZW6ST7tvA1a1o5A=;
        b=NRBP1Y7yPFzO/Cv/ffjvWS9Kpj1+Hih4pPSG+SDtaggCLwkeas1UuEutYN+Rg41pqq
         HZCgrbtoxfvC1789X6LBlD7vqaDLi4dkolsXfzaVl8orYDYZRm/pClRuF80p0kA8In56
         XRYSiLOhXGXVlO5dON1X+Fgq0A1U2aQVGrxZHIp7YZxZucxuEz9cx3WkNYVxpDGPE4Fm
         Sr9EPcHHtwiJclgC3YoJb1cSOjEKqPN8okcsoi28WrWqN9iNj+aO2/r3SMNVcZkCB2WF
         Mt6V1snM86QacOWtBagYE0hTThYc+aDTkgxrK8Tu7TW4togN9rrj4NEWHwpzJKni/hwy
         lKLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0bxQGt/r6+y2yG9WW6VBdLWjR5m9Yr1O9LfMjgzA8ezWEunOu/y+FfzddJxXXKhiGWStF5Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pFn61CkSLuKt/M1gshwl9NEihilAQWoqDpt/g/ATlrexIUSn
	crV0/RCqazW3xx8tXiYmwEz3ryPkHznVjuhH3Ot2nejeY7Maz+2/cC6OsP/QOAu7ZY/qR8zovsQ
	HMwaAIzJZf/f5MzYn093LptlIi2960qTsk/A8p4O87Mz7l+lJ4C7N+x4nlQ==
X-Gm-Gg: ASbGncuwXdoYgAoyhbS0QvSitLKmwKuFWBz1UIqbMUXW2VuMQoY0pH9Lob5v2OUFvf3
	ugDTU2hS+fIoG9rzFyRjQb9BSmWYu4Tpxb4+jlK9c3DLCvCxBI+6RU4x5g95PV/CnsvM5q+PmKm
	gaCzFOlR80pugUSDxSPLxsrzW+p1Ba3G7zS7Nv5F8Lgd6TdeYy2QBolJ2+c68yDmJJN8OYwWmBm
	+Ew63W2bKpRIs/QI++CGhHHSaKEuy3XrSpCW0EhnhILwE2p4uoHdtNs5GEtf2X6vNCkNbSS33nI
	BzNrBuio94TXxEVP1GEtS5ZEht6fax6q
X-Received: by 2002:a05:600c:35d3:b0:456:18ca:68db with SMTP id 5b1f17b1804b1-4562e371b1fmr17014735e9.8.1752656134984;
        Wed, 16 Jul 2025 01:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIeeddWD/zXeNIK28bnOIs260/kSZeIsxuV6ecZ6mZpopBKmOyYwzIAIRkqbaMPhqIXtY3WA==
X-Received: by 2002:a05:600c:35d3:b0:456:18ca:68db with SMTP id 5b1f17b1804b1-4562e371b1fmr17014325e9.8.1752656134500;
        Wed, 16 Jul 2025 01:55:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e81ccb4sm14628415e9.17.2025.07.16.01.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:55:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:55:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v12 00/10] tun: Introduce virtio-net hashing
 feature
Message-ID: <20250716045513-mutt-send-email-mst@kernel.org>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>

On Fri, May 30, 2025 at 01:50:04PM +0900, Akihiko Odaki wrote:
> NOTE: I'm leaving Daynix Computing Ltd., for which I worked on this
> patch series, by the end of this month.
> 
> While net-next is closed, this is the last chance for me to send another
> version so let me send the local changes now.
> 
> Please contact Yuri Benditovich, who is CCed on this email, for anything
> about this series.
> 
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
> 
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
> 
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
> 
> The patches for QEMU to use this new feature was submitted as RFC and
> is available at:
> https://patchew.org/QEMU/20250530-hash-v5-0-343d7d7a8200@daynix.com/
> 
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/


It's been a while, do you intend to post v13?

> V1 -> V2:
>   Changed to introduce a new BPF program type.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v12:
> - Updated tools/testing/selftests/net/config.
> - Split TUNSETVNETHASH.
> - Link to v11: https://lore.kernel.org/r/20250317-rss-v11-0-4cacca92f31f@daynix.com
> 
> Changes in v11:
> - Added the missing code to free vnet_hash in patch
>   "tap: Introduce virtio-net hash feature".
> - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af0@daynix.com
> 
> Changes in v10:
> - Split common code and TUN/TAP-specific code into separate patches.
> - Reverted a spurious style change in patch "tun: Introduce virtio-net
>   hash feature".
> - Added a comment explaining disable_ipv6 in tests.
> - Used AF_PACKET for patch "selftest: tun: Add tests for
>   virtio-net hashing". I also added the usage of FIXTURE_VARIANT() as
>   the testing function now needs access to more variant-specific
>   variables.
> - Corrected the message of patch "selftest: tun: Add tests for
>   virtio-net hashing"; it mentioned validation of configuration but
>   it is not scope of this patch.
> - Expanded the description of patch "selftest: tun: Add tests for
>   virtio-net hashing".
> - Added patch "tun: Allow steering eBPF program to fall back".
> - Changed to handle TUNGETVNETHASHCAP before taking the rtnl lock.
> - Removed redundant tests for tun_vnet_ioctl().
> - Added patch "selftest: tap: Add tests for virtio-net ioctls".
> - Added a design explanation of ioctls for extensibility and migration.
> - Removed a few branches in patch
>   "vhost/net: Support VIRTIO_NET_F_HASH_REPORT".
> - Link to v9: https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com
> 
> Changes in v9:
> - Added a missing return statement in patch
>   "tun: Introduce virtio-net hash feature".
> - Link to v8: https://lore.kernel.org/r/20250306-rss-v8-0-7ab4f56ff423@daynix.com
> 
> Changes in v8:
> - Disabled IPv6 to eliminate noises in tests.
> - Added a branch in tap to avoid unnecessary dissection when hash
>   reporting is disabled.
> - Removed unnecessary rtnl_lock().
> - Extracted code to handle new ioctls into separate functions to avoid
>   adding extra NULL checks to the code handling other ioctls.
> - Introduced variable named "fd" to __tun_chr_ioctl().
> - s/-/=/g in a patch message to avoid confusing Git.
> - Link to v7: https://lore.kernel.org/r/20250228-rss-v7-0-844205cbbdd6@daynix.com
> 
> Changes in v7:
> - Ensured to set hash_report to VIRTIO_NET_HASH_REPORT_NONE for
>   VHOST_NET_F_VIRTIO_NET_HDR.
> - s/4/sizeof(u32)/ in patch "virtio_net: Add functions for hashing".
> - Added tap_skb_cb type.
> - Rebased.
> - Link to v6: https://lore.kernel.org/r/20250109-rss-v6-0-b1c90ad708f6@daynix.com
> 
> Changes in v6:
> - Extracted changes to fill vnet header holes into another series.
> - Squashed patches "skbuff: Introduce SKB_EXT_TUN_VNET_HASH", "tun:
>   Introduce virtio-net hash reporting feature", and "tun: Introduce
>   virtio-net RSS" into patch "tun: Introduce virtio-net hash feature".
> - Dropped the RFC tag.
> - Link to v5: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> 
> Changes in v5:
> - Fixed a compilation error with CONFIG_TUN_VNET_CROSS_LE.
> - Optimized the calculation of the hash value according to:
>   https://git.dpdk.org/dpdk/commit/?id=3fb1ea032bd6ff8317af5dac9af901f1f324cab4
> - Added patch "tun: Unify vnet implementation".
> - Dropped patch "tap: Pad virtio header with zero".
> - Added patch "selftest: tun: Test vnet ioctls without device".
> - Reworked selftests to skip for older kernels.
> - Documented the case when the underlying device is deleted and packets
>   have queue_mapping set by TC.
> - Reordered test harness arguments.
> - Added code to handle fragmented packets.
> - Link to v4: https://lore.kernel.org/r/20240924-rss-v4-0-84e932ec0e6c@daynix.com
> 
> Changes in v4:
> - Moved tun_vnet_hash_ext to if_tun.h.
> - Renamed virtio_net_toeplitz() to virtio_net_toeplitz_calc().
> - Replaced htons() with cpu_to_be16().
> - Changed virtio_net_hash_rss() to return void.
> - Reordered variable declarations in virtio_net_hash_rss().
> - Removed virtio_net_hdr_v1_hash_from_skb().
> - Updated messages of "tap: Pad virtio header with zero" and
>   "tun: Pad virtio header with zero".
> - Fixed vnet_hash allocation size.
> - Ensured to free vnet_hash when destructing tun_struct.
> - Link to v3: https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com
> 
> Changes in v3:
> - Reverted back to add ioctl.
> - Split patch "tun: Introduce virtio-net hashing feature" into
>   "tun: Introduce virtio-net hash reporting feature" and
>   "tun: Introduce virtio-net RSS".
> - Changed to reuse hash values computed for automq instead of performing
>   RSS hashing when hash reporting is requested but RSS is not.
> - Extracted relevant data from struct tun_struct to keep it minimal.
> - Added kernel-doc.
> - Changed to allow calling TUNGETVNETHASHCAP before TUNSETIFF.
> - Initialized num_buffers with 1.
> - Added a test case for unclassified packets.
> - Fixed error handling in tests.
> - Changed tests to verify that the queue index will not overflow.
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231015141644.260646-1-akihiko.odaki@daynix.com
> 
> ---
> Akihiko Odaki (10):
>       virtio_net: Add functions for hashing
>       net: flow_dissector: Export flow_keys_dissector_symmetric
>       tun: Allow steering eBPF program to fall back
>       tun: Add common virtio-net hash feature code
>       tun: Introduce virtio-net hash feature
>       tap: Introduce virtio-net hash feature
>       selftest: tun: Test vnet ioctls without device
>       selftest: tun: Add tests for virtio-net hashing
>       selftest: tap: Add tests for virtio-net ioctls
>       vhost/net: Support VIRTIO_NET_F_HASH_REPORT
> 
>  Documentation/networking/tuntap.rst  |   7 +
>  drivers/net/Kconfig                  |   1 +
>  drivers/net/ipvlan/ipvtap.c          |   2 +-
>  drivers/net/macvtap.c                |   2 +-
>  drivers/net/tap.c                    |  80 +++++-
>  drivers/net/tun.c                    |  92 +++++--
>  drivers/net/tun_vnet.h               | 165 +++++++++++-
>  drivers/vhost/net.c                  |  68 ++---
>  include/linux/if_tap.h               |   4 +-
>  include/linux/skbuff.h               |   3 +
>  include/linux/virtio_net.h           | 188 ++++++++++++++
>  include/net/flow_dissector.h         |   1 +
>  include/uapi/linux/if_tun.h          |  80 ++++++
>  net/core/flow_dissector.c            |   3 +-
>  net/core/skbuff.c                    |   4 +
>  tools/testing/selftests/net/Makefile |   2 +-
>  tools/testing/selftests/net/config   |   1 +
>  tools/testing/selftests/net/tap.c    | 131 +++++++++-
>  tools/testing/selftests/net/tun.c    | 485 ++++++++++++++++++++++++++++++++++-
>  19 files changed, 1234 insertions(+), 85 deletions(-)
> ---
> base-commit: 5cb8274d66c611b7889565c418a8158517810f9b
> change-id: 20240403-rss-e737d89efa77
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


