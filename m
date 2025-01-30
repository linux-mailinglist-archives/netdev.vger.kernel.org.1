Return-Path: <netdev+bounces-161688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FFA23667
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D9F1665FB
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C01F131F;
	Thu, 30 Jan 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCYThilV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B519F101
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271746; cv=none; b=EeTsjsEH84038gjeP/CidBX39qoOUVc42z4BOax1rPLMKrP8wOBkz+dqsSA2F1UP/EVeX7hO9XLIc1OqICkIZms+jJb1rDU3HiIulmBzbskg95ILeO4/PsC8w7O8bAliGNg0BwKJYV/UJ/3FCT/Cm1jF8auhD68BVeS4vEt9djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271746; c=relaxed/simple;
	bh=AwWVGnUjXx8Wyr2wSxIpvnGC23tQdD0TlruChO0nSDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rT88SSe/UhyBwP3CDvhAlNv9VGdV3jaXRVEVqsa47hmorNQSOj4LqkGCirAQgQPp4bGm9F7OCPVDF8+j+UYHt4OOinUTIJrsxAUhsUmQAS70yu1cZ54p6xyfHiTOTVjW+/FfrhA81mxbEKyGfy1Coiq8bZfNOApGLF5uoItpAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCYThilV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso2518830a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271743; x=1738876543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w3LtRCOsgVaxwk2lW35j8j9VT58hbvzzlSooRGwM3eU=;
        b=HCYThilV/jL/AxeaW4ZEqM9qqhOhAPe+lUXOzdb+8ESn7OLsIc3/9+mKPQ0EY9cth1
         +cl0+JjgtlaAEuG0i18sILH8ayfOAWuITFAmNxiegRInVyoGe6gt+5jH+flR1P6/t9pn
         Bhs9+ddO2BPbiXOFtzbk87mRcSlLo+THMQ5meKH1+tX0g4aeSUrn/cyoDhxzpBhwR9pX
         dmNsc5DwSMXF6JCvjLHWt4yjMIzN0t5LWK5NjhBx7dd6Ley/9kZltInJYqW9AhuU1ijI
         cZpfJpPvrFsF0mOcuohCCymaV64u7Gb2U55yzz1qTH6Rny99L4Hl0GPkcx6JrVd7fgkP
         c0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271743; x=1738876543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3LtRCOsgVaxwk2lW35j8j9VT58hbvzzlSooRGwM3eU=;
        b=XyMQpk+s5Nxj85nvRRVE089Mj04Wihsj2M0Q9AipyBrlqtbnjORqd8zvZf93861OMz
         G14JbjiFKc7FgKJXY5WUUgPOMMM7YikT87TFETfMonIkuk1orue8FM2Q5RA2wIDNbGJK
         HqTTjrIGvxowzbLAZdRwnmy68TklSb0JFou+g4UXp1ajzp9DxKVngNChboYx1OsVHs5Y
         lFdgnlIHpyeV0s+rzMn3mDtQi5ucYnUSYSYLWGb8ZEoWdMrl1osF2YZuED5Gk9PN8wjJ
         t4hZdRf+fpB/2nDDfd2RTHDlh9DoerOeBrVBdhPmXiDEN83XfwjF3+/57pnjI07RvqMR
         3NlQ==
X-Gm-Message-State: AOJu0YxDKWW7nb2f2DDGLs6bKzaw+wb8Brk1KK61AxSU3z87MIA6bhzk
	j5g1nB/EeN4SC6esgQy0oydRIOFTfJDGSwRWUJh4M4EQ0Fjt3e51dk0UOiKXKMO5cfVxfkmkgjp
	/eohXrfGzQwzKlrdfHY89NVhzJrxbe2krVRuHN2kDYzOlqvVk9ynqXtQW6xtx0R91eGQaHowJit
	KqUAYB+pi1z99z9fUdW8w14+7W39759G6yXVrp6FVbYLbOcTHCxGaftBZibAk=
X-Google-Smtp-Source: AGHT+IFAUh3HgDFWfU9BpZZUgm7IQWEJxQLoEO7cPRsnwHf1sSQTIU5zqMQeWoi0D5sqPeyPGJf1oVuUeqG24fSw6A==
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:2ea:3a1b:f493])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5387:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2f83ac8ad6emr11624480a91.31.1738271742907;
 Thu, 30 Jan 2025 13:15:42 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-1-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 0/6] Device memory TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

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

- Improved test coverage in ncdevmem. Now muliple sendmsg() are tested,
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

Sending this series as RFC as the winder closure is immenient. I plan on
reposting as non-RFC once the tree re-opens, addressing any feedback
I receive in the meantime.

Full outline on usage of the TX path is detailed in the documentation
added in the first patch.

Test example is available via the kselftest included in the series as well.

The series is relatively small, as the TX path for this feature largely
piggybacks on the existing MSG_ZEROCOPY implementation.

Patch Overview:
---------------

1. Documentation & tests to give high level overview of the feature
   being added.

2. Add netmem refcounting needed for the TX path.

3. Devmem TX netlink API.

4. Devmem TX net stack implementation.

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


Mina Almasry (5):
  net: add devmem TCP TX documentation
  selftests: ncdevmem: Implement devmem TCP TX
  net: add get_netmem/put_netmem support
  net: devmem: Implement TX path
  net: devmem: make dmabuf unbinding scheduled work

Stanislav Fomichev (1):
  net: devmem: TCP tx netlink api

 Documentation/netlink/specs/netdev.yaml       |  12 +
 Documentation/networking/devmem.rst           | 144 ++++++++-
 include/linux/skbuff.h                        |  15 +-
 include/linux/skbuff_ref.h                    |   4 +-
 include/net/netmem.h                          |   3 +
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 include/uapi/linux/uio.h                      |   6 +-
 net/core/datagram.c                           |  41 ++-
 net/core/devmem.c                             | 110 ++++++-
 net/core/devmem.h                             |  70 ++++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  67 ++++-
 net/core/skbuff.c                             |  36 ++-
 net/core/sock.c                               |   8 +
 net/ipv4/tcp.c                                |  36 ++-
 net/vmw_vsock/virtio_transport_common.c       |   3 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
 20 files changed, 802 insertions(+), 46 deletions(-)

-- 
2.48.1.362.g079036d154-goog


