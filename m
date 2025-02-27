Return-Path: <netdev+bounces-170091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29738A47404
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C5F188C1EB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420D1EB5C4;
	Thu, 27 Feb 2025 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eh5DP0+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C531E5200
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629535; cv=none; b=VZQ080QN8KahLivYghOb2NKx0g9XZp/KA3JdGp35cLb1jXh8iLE81B/Ru3K7e1emnKVHvizXnX7idNcCOI1tuGF6lJIH89r1dUybhCGu2Ut+V4BY52NJPZKQwvE3N70xgp+34zhdKOSvwH0hK56+FynPspOzbvX6V45Rt0cIfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629535; c=relaxed/simple;
	bh=Z1x9cBAckNAGgXsh1KnLoyHiDSqdyqilemzDU/Dtrzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OeuLBrgTzIYcsOKgLUCUW1Oau0Y7dVgtN+dhfTOxqghjd/LN38NdHQ4QQmCs2oI2PalJJrqH0zO4OoWJQhDIkQLuEvm/8zDJnFFvFcvNkL7rqHNOjectnXHnNsbIsD2rRsNr3d0ommmGOaImxpnp63L0nY8GR0Eo3y7spMXOau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eh5DP0+B; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-728a436797bso328925a34.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629532; x=1741234332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3g5LjBldgpfT3/dJj9/PNfchsdoxXJ5s3FXfsdFv20U=;
        b=Eh5DP0+BBnHAwNwzpN2HVNz66RPt7/DNhJdMwBPWh7StPEL6ikIQeHwCpkb3JwjCZa
         8qlnGf27ZTfRCNnrAH9KrmbaPg7aOkYiDfMVw/HYXWu4+3dffTpRFcK7exUem4KhT7Va
         EMYoNJYFxCuZFkeZq4dNhng62Jniz9EGDQLOujt5/QuVhzCyd6lu1BAxHfEuAeloUD0K
         LTonPhqQm49EZFelzbertcdadE33ZHx+Lm1+6PFkK0CNrVMNJ7t6Rwo4Z4QGK3cVtgle
         TP8kNoe/BsiWvdaESjgW/RpCSofAvzAPmhEkDNmEKnlWXF+6gs3lMBQEzRRbUCP+5S/N
         T9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629532; x=1741234332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3g5LjBldgpfT3/dJj9/PNfchsdoxXJ5s3FXfsdFv20U=;
        b=j5V4eNN6aU0A/p6CipHIw3p2xPPssxToF6iEfcMmGZ6611D3iuARFI/XAOyCKEMBeJ
         UqobvZ+8imxgSGp8Ht45I0nC3jsgyHCLnAAyJYPtsJFZnhAfjtG4t6waJh6TksgLAljI
         zOtlJNhNmNNV2tx0q2T2Pj4MFewDuGsmCzzszmnWegzvbUux55lC32pcq1muSnjTUBSM
         G8HSlYUq5vojtoD+PatkjojUZ3LMrxNdgtnYYCggBDTUA73By02MmqnFoGioeX0JnVOq
         p1XtQoqONSK/KUAZxwnSYBy3ytvnww2jXbekqmoQV7DYk83EuI4pPqXG7Ve/t7Ut3JMt
         Orww==
X-Gm-Message-State: AOJu0Yzb7JrxyaXZQxZixjBMdDbck+bFaXfk6Pju8N2iNVMWPgLm6l/f
	m6AoQKsu8uiWFj+9t5SMy5oBOBlXRK/P177FI/SKC/jHjehQZCP15h5c9SqKKVIub2kJ+I/smiF
	lT25bq66kMX/qBmy82F78te9DIO6ZlGNUcl1YfNJVd5bZvPCJKUZ+HtQssDkLQt9sl++rPHpdao
	eT1CasZSWYmIg4ih4o2naCp2M/+glFHYtkmBM43KKy2fmCB+KSukPv4kvW1BA=
X-Google-Smtp-Source: AGHT+IH783qYzy8zqnAN9qy+ZgGK9lxDY+qeDhB++EerNVKBi0iW0nYVUAd0UY8jwXAselzgbS5EQUX7E0eXV9iZuQ==
X-Received: from oabxe11.prod.google.com ([2002:a05:6870:ce8b:b0:295:f44d:8dfa])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:6a90:b0:727:2f79:ce32 with SMTP id 46e09a7af769-7274c563d40mr15643474a34.22.1740629531553;
 Wed, 26 Feb 2025 20:12:11 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-1-almasrymina@google.com>
Subject: [PATCH net-next v6 0/8] Device memory TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

v6: https://lore.kernel.org/netdev/20250222191517.743530-1-almasrymina@google.com/
===

v6 has no major changes. Addressed a few issues from Paolo and David,
and collected Acks from Stan. Thank you everyone for the review!

Changes:
- retain behavior to process MSG_FASTOPEN even if the provided cmsg is
  invalid (Paolo).
- Rework the freeing of tx_vec slightly (it now has its own err label).
  (Paolo).
- Squash the commit that makes dmabuf unbinding scheduled work into the
  same one which implements the TX path so we don't run into future
  errors on bisecting (Paolo).
- Fix/add comments to explain how dmabuf binding refcounting works
  (David).

v5: https://lore.kernel.org/netdev/20250220020914.895431-1-almasrymina@google.com/
===

v5 has no major changes; it clears up the relatively minor issues
pointed out to in v4, and rebases the series on top of net-next to
resolve the conflict with a patch that raced to the tree. It also
collects the review tags from v4.

Changes:
- Rebase to net-next
- Fix issues in selftest (Stan).
- Address comments in the devmem and netmem driver docs (Stan and Bagas)
- Fix zerocopy_fill_skb_from_devmem return error code (Stan).

v4: https://lore.kernel.org/netdev/20250203223916.1064540-1-almasrymina@google.com/
===

v4 mainly addresses the critical driver support issue surfaced in v3 by
Paolo and Stan. Drivers aiming to support netmem_tx should make sure not
to pass the netmem dma-addrs to the dma-mapping APIs, as these dma-addrs
may come from dma-bufs.

Additionally other feedback from v3 is addressed.

Major changes:
- Add helpers to handle netmem dma-addrs. Add GVE support for
  netmem_tx.
- Fix binding->tx_vec not being freed on error paths during the
  tx binding.
- Add a minimal devmem_tx test to devmem.py.
- Clean up everything obsolete from the cover letter (Paolo).

v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=929401&state=*
===

Address minor comments from RFCv2 and fix a few build warnings and
ynl-regen issues. No major changes.

RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=920056&state=*
=======

RFC v2 addresses much of the feedback from RFC v1. I plan on sending
something close to this as net-next  reopens, sending it slightly early
to get feedback if any.

Major changes:
--------------

- much improved UAPI as suggested by Stan. We now interpret the iov_base
  of the passed in iov from userspace as the offset into the dmabuf to
  send from. This removes the need to set iov.iov_base = NULL which may
  be confusing to users, and enables us to send multiple iovs in the
  same sendmsg() call. ncdevmem and the docs show a sample use of that.

- Removed the duplicate dmabuf iov_iter in binding->iov_iter. I think
  this is good improvment as it was confusing to keep track of
  2 iterators for the same sendmsg, and mistracking both iterators
  caused a couple of bugs reported in the last iteration that are now
  resolved with this streamlining.

- Improved test coverage in ncdevmem. Now multiple sendmsg() are tested,
  and sending multiple iovs in the same sendmsg() is tested.

- Fixed issue where dmabuf unmapping was happening in invalid context
  (Stan).

====================================================================

The TX path had been dropped from the Device Memory TCP patch series
post RFCv1 [1], to make that series slightly easier to review. This
series rebases the implementation of the TX path on top of the
net_iov/netmem framework agreed upon and merged. The motivation for
the feature is thoroughly described in the docs & cover letter of the
original proposal, so I don't repeat the lengthy descriptions here, but
they are available in [1].

Full outline on usage of the TX path is detailed in the documentation
included with this series.

Test example is available via the kselftest included in the series as well.

The series is relatively small, as the TX path for this feature largely
piggybacks on the existing MSG_ZEROCOPY implementation.

Patch Overview:
---------------

1. Documentation & tests to give high level overview of the feature
   being added.

1. Add netmem refcounting needed for the TX path.

2. Devmem TX netlink API.

3. Devmem TX net stack implementation.

4. Make dma-buf unbinding scheduled work to handle TX cases where it gets
   freed from contexts where we can't sleep.

5. Add devmem TX documentation.

6. Add scaffolding enabling driver support for netmem_tx. Add helpers, driver
feature flag, and docs to enable drivers to declare netmem_tx support.

7. Guard netmem_tx against being enabled against drivers that don't
   support it.

8. Add devmem_tx selftests. Add TX path to ncdevmem and add a test to
   devmem.py.

Testing:
--------

Testing is very similar to devmem TCP RX path. The ncdevmem test used
for the RX path is now augemented with client functionality to test TX
path.

* Test Setup:

Kernel: net-next with this RFC and memory provider API cherry-picked
locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Performance results are not included with this version, unfortunately.
I'm having issues running the dma-buf exporter driver against the
upstream kernel on my test setup. The issues are specific to that
dma-buf exporter and do not affect this patch series. I plan to follow
up this series with perf fixes if the tests point to issues once they're
up and running.

Special thanks to Stan who took a stab at rebasing the TX implementation
on top of the netmem/net_iov framework merged. Parts of his proposal [2]
that are reused as-is are forked off into their own patches to give full
credit.

[1] https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@google.com/
[2] https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd

Cc: sdf@fomichev.me
Cc: asml.silence@gmail.com
Cc: dw@davidwei.uk
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>
Cc: Samiullah Khawaja <skhawaja@google.com>


Mina Almasry (7):
  net: add get_netmem/put_netmem support
  net: devmem: Implement TX path
  net: add devmem TCP TX documentation
  net: enable driver support for netmem TX
  gve: add netmem TX support to GVE DQO-RDA mode
  net: check for driver support in netmem TX
  selftests: ncdevmem: Implement devmem TCP TX

Stanislav Fomichev (1):
  net: devmem: TCP tx netlink api

 Documentation/netlink/specs/netdev.yaml       |  12 +
 Documentation/networking/devmem.rst           | 150 ++++++++-
 .../networking/net_cachelines/net_device.rst  |   1 +
 Documentation/networking/netdev-features.rst  |   5 +
 Documentation/networking/netmem.rst           |  23 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   4 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   8 +-
 include/linux/netdevice.h                     |   2 +
 include/linux/skbuff.h                        |  17 +-
 include/linux/skbuff_ref.h                    |   4 +-
 include/net/netmem.h                          |  23 ++
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/datagram.c                           |  48 ++-
 net/core/dev.c                                |   3 +
 net/core/devmem.c                             | 115 ++++++-
 net/core/devmem.h                             |  77 ++++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  73 ++++-
 net/core/skbuff.c                             |  48 ++-
 net/core/sock.c                               |   6 +
 net/ipv4/ip_output.c                          |   3 +-
 net/ipv4/tcp.c                                |  50 ++-
 net/ipv6/ip6_output.c                         |   3 +-
 net/vmw_vsock/virtio_transport_common.c       |   5 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/devmem.py        |  26 +-
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 29 files changed, 950 insertions(+), 73 deletions(-)


base-commit: 80c4a0015ce249cf0917a04dbb3cc652a6811079
-- 
2.48.1.658.g4767266eb4-goog


