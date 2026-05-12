Return-Path: <netdev+bounces-286893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFhMLet/AmoZtwEAu9opvQ
	(envelope-from <netdev+bounces-286893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:18:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1F518199
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820A9301FD43
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CE2737F9;
	Tue, 12 May 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk2TYgMz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECB1E5B9A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548695; cv=none; b=QBeDnDv4HiCF4rJcDXwJcSyIZWlT5Z5h6x91FVaICe/Ilyrf91A0D21XtYziD2xQwhYgfq6Tgxjh71QeaJzYKpHWTwEd8Nrgx4O/obDKSZc+ZxxbT4uhnIqNiza1jMEaR78WF5DzkG4dC64lH9UAbCMmN+q/6KSos/ySF5saLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548695; c=relaxed/simple;
	bh=k22e2d7ydwM5+BRlgnIeMIVIVxSRDq6EuvJzHYecFCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bmYW/EaCu0LgWNJRJfXX8X7AQx/ZUKeqQAxNos7kT/vS8EfyFdP0qbvkig9TQR9ZoosIGW8t+pYI/nIce+9S8dB3Pjg6y/W5J9AguBHVLBylkt8YJqGEtAn0X6PsDupBEO/QBayghGs9SwrPfdBJzck1mItZBrFr7mfr0X8HJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk2TYgMz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c58e6eb3edso504617b3.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548691; x=1779153491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdgbEEx+qb0Rapz5r4af/IYN3xl7J9o9EZhfZP7ZY8g=;
        b=Nk2TYgMzP4HB2pBVuaVbfu6f1mTn8o9PRDhHDeDKoLz36mBd6ZPWRENiInHWvGPGQz
         +Lpaq4DwMRaEuY6FvLYP9pWASIiDEpMdkim9bZcJjay4Hi437U2kQVqSXzluFd04riuz
         Zv9NaRJFVa++mfG1MaivvnuaKvAXkC8p9Y3SRDN4O7lB1ZOtUFAm83zj7Zke4lMNxDHD
         2O4xBRyr2y9q0yzPXlTtgCL/lEjlzymWUoz8pZOZr5zNb9Qhz3P5irt8owavFgXiupqM
         0U2LPZCQ/Vk4ghmbmYCIHX23IpstHjdjy8147SqpSpuN/oVrZ/if/SMalv1VzzhlXuNV
         +ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548691; x=1779153491;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdgbEEx+qb0Rapz5r4af/IYN3xl7J9o9EZhfZP7ZY8g=;
        b=BKtYUiwoIhuqj83395WtSPZYAx9F1tmPtOwcy/cY0DpnQYzVLBeNP7rNmYKJoyP9Vi
         6qQciXi1VvfXZq5nmNYT46ZgV6mLk66pEHo4E/fD5Q0CRJ+Xoviuiw+8UxC9hujNUmQo
         ftVgJPm7qejTiaVz0T++WHT3XohKXd3WFtEqXnn7gX+cdzy+RnbENp34yP+kxdfUeMpi
         jwLkZ/FnjQKQditYKsUNXpAB8DRno/C4ihTkIOq7izjfNsnA2JANjNjfNaQ1kJmXumrb
         YabJuP5V2L7E+IsdqkyfV1rZEd5RPHGy6FylPx9oZiNkn1k4H49ZK3Ix1SP2RjgZjjCe
         Ec1g==
X-Forwarded-Encrypted: i=1; AFNElJ/auSbs0wMGTR1tzKPsjKcGYdZNSE9QRoPDxqUA4ju3s/ep8p77s5wpVGEmQDN3k+PftoNz2gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXRuRLJ1GLftBy01AcLNmmcH8LWzBL3lJRMOjNeSxXQ8Um49Y
	FpzDaT7IuS3LHf3TjEskG/s8zX7UGSSBXPWDg56oPIjduIrWg8MFRIou
X-Gm-Gg: Acq92OGx5LNbKJlH4ECGmcb7zISnIWPV3DxjtljdrGU5H07mXzWzkUvbn3d4Mc5CZ9e
	+gwNLbOA5aXtGoJPd2c+XJJWwQe6pLzfAaHEprn38wfUoXeIFS00G8jm/kvlef+xq+rsBRUTZmW
	ftF8eg0fyyeiSO9A68fkjEIBXzRkqIaOatvWZ5mFYQxmrIyylGAR7GJccX6TqUb0l4HI4fVUfBF
	JBAKsIshhDse18D2/tBFtFgMY1YIi6EBJVN1q5Rn2ulE8yjAaUJ1jTJmxERmddQCZjtXGMpEFzC
	Sk5T+BtYVITPGLTUTIBeNFfOMB48zyRTkQUUXu5jD+5knkWdOwmmFjhyIDusj+EFgDWkd0oyLOO
	//cLi1iK4TGuAkSV3OoH+tlvRtl29hogesJwEsGhML21V7zkUfO9SMPcXTH5XcDLJGqrQjoNsCy
	iPP1FJeP4poxlHj1CqaryZ7g==
X-Received: by 2002:a05:690c:4989:b0:7bf:3b0:27f0 with SMTP id 00721157ae682-7bf03b03675mr234228857b3.19.1778548691352;
        Mon, 11 May 2026 18:18:11 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:1a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665298b4sm156310017b3.7.2026.05.11.18.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v4 0/8] net: devmem: support devmem with netkit
 devices
Date: Mon, 11 May 2026 18:17:54 -0700
Message-Id: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMR/AmoC/13NQQ6DIBCF4auQWUtDB0TjqvdoulAYK2lEA4TYG
 O/elJVx/fL9b4dIwVGEju0QKLvoFg8dUxUDM/X+TdxZ6BigQC0USp7Myu3MPaWPSxwH27SDlq2
 VAioGa6DRbaX3BE+Je9oSvCoGk4tpCd9ylLHspVkLdWlm5ILX2tbYmwZHqx4zpf5mlrmEsjzj5
 orlH2OLd6XqVjfmhI/j+AGIyDGK8AAAAA==
X-Change-ID: 20260423-tcp-dm-netkit-2bd78b638d30
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 5FC1F518199
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-286893-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nk_devmem.py:url]
X-Rspamd-Action: no action

This series enables TCP devmem TX through netkit devices.

Netkit now supports queue leasing. A physical NIC's RX queue can be
leased to a netkit guest interface inside a container namespace. This
gives the container a devmem-capable data path on the RX side (bind-rx,
etc...). On the TX side, the container process binds to its netkit guest
interface and sends traffic that netkit redirects (via BPF or ip
forwarding) to the physical NIC for DMA.

Two things in the existing devmem TX path prevent this from working:

1. validate_xmit_unreadable_skb() requires dev->netmem_tx before it will
   forward a dmabuf-backed (unreadable) skb. This protects skbs from
   landing on devices that don't have the IOMMU mappings for the backing
   dmabuf or that don't speak netmem. Netkit, however, does not support
   DMA, doesn't attempt to read unreadable skb pages and so doesn't
   break netmem (it is pure skb routing and redirection). It is
   functionally capable of routing unreadable skbs, but there is no way
   for the TX validation pathway to distinguish between a device that
   will actually attempt DMA-ing the skb and another device
   (like netkit) that does not DMA but also does not break
   netmem.

2. bind_tx_doit uses the bound device as the DMA device.  When the user
   binds devmem TX to the netkit guest, the bind handler attempts to
   create DMA mappings against netkit, which has no DMA capability and
   no IOMMU mappings.

This series solves these problems as follows:

1. Extend netmem_tx to two bits, assigned to one of three values:

   NETMEM_TX_NONE   - netmem not supported
   NETMEM_TX_DMA    - netmem supported and performs DMA
   NETMEM_TX_NO_DMA - netmem supported, but does not DMA

   With these bits, phys devices can set NETMEM_TX_DMA and devices like
   netkit set NETMEM_TX_NO_DMA. The validation TX path ensures that any
   DMA-capable netdev exactly matches the bound device, guaranteeing the
   correct mapping of the bound dmabuf. The validation TX path also
   allows devices with NETMEM_TX_NO_DMA to pass, knowing these devices
   will not misuse netmem or run into IOMMU faults. After redirection or
   routing and the skb finally makes its way through the stack to a
   physical device's TX path, the above NETMEM_TX_DMA check is performed
   again to guarantee the device has the appropriate binding/mappings.

2. On TX bind, the bind handler recognizes NETMEM_TX_NO_DMA devices and
   finds the phys TX device and binds to that instead. For the netkit
   case, if it has been leased a queue from a DMA-capable device
   already, then the bind action is performed on the DMA-capable device
   instead and the dmabuf is mapped correctly.

---
Changes in v4:
- remove enum list from netmem_tx comment (Stan)
- fold NETMEM_TX_NO_DMA check in validate_xmit_unreadable_skb() into
  skb_frags_readable check (Stan, Jakub)
- change binding->vdev to void ptr cookie with comment (Jakub)
- Fixed the bad change list version number (Stan)
- Link to v3: https://lore.kernel.org/r/20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com

Changes in v3:
- Fix validate_xmit_unreadable_skb() logic for non-devmem
  unreadable niovs (should not be dropped) (Sashiko)
- Simplify lock handling in bind_tx, no premature release (Jakub)
- split NO_DMA changes into separate patch (Jakub)
- fixed some pylint issues, one required an additional patch ("selftests:
  drv-net: make attr _nk_guest_ifname public") to rename a variable from
  private to public
- see per-patch changelist for more detailed changes
- Link to v2: https://lore.kernel.org/r/20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com

Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
- In validate_xmit_unreadable_skb() to check netmem_tx mode before inspecting
  frags (Jakub)
- Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev != netdev to
  fix lockdep (Sashiko)
- Move require_devmem() into individual test functions so KsftSkipEx goes up to
  ksft_run() (Sashiko)
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
- Link to v1:
  https://lore.kernel.org/all/20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Bobby Eshleman (8):
      net: convert netmem_tx flag to enum
      net: netkit: declare NETMEM_TX_NO_DMA mode
      net: devmem: support TX over NETMEM_TX_NO_DMA devices
      selftests: drv-net: ncdevmem: add -n flag to skip NIC configuration
      selftests: drv-net: make attr _nk_guest_ifname public
      selftests: drv-net: refactor devmem command builders into lib module
      selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem tests

 .../networking/net_cachelines/net_device.rst       |   2 +-
 Documentation/networking/netmem.rst                |   8 +-
 .../translations/zh_CN/networking/netmem.rst       |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   2 +-
 drivers/net/netkit.c                               |   1 +
 include/linux/netdevice.h                          |  10 +-
 net/core/dev.c                                     |   5 +-
 net/core/devmem.c                                  |   6 +-
 net/core/devmem.h                                  |  10 +-
 net/core/netdev-genl.c                             |  65 +++++-
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 +++---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  55 ++++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  39 ++++
 .../testing/selftests/drivers/net/hw/nk_qlease.py  |   8 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  | 109 ++++++++---
 21 files changed, 548 insertions(+), 139 deletions(-)
---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260423-tcp-dm-netkit-2bd78b638d30

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


