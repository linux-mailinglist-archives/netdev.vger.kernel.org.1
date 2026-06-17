Return-Path: <netdev+bounces-300132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JKiId+EMmqg1QUAu9opvQ
	(envelope-from <netdev+bounces-300132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:28:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AA699137
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YybreMs0;
	dkim=pass header.d=redhat.com header.s=google header.b=KpgQTlEw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300132-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300132-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ECCA30131A3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4CA39F162;
	Wed, 17 Jun 2026 10:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85B3B6BF1
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693727; cv=none; b=aliaWVubnE0Xc/xOUL7BuELrbjVe5hdG+O3T079/31ogkDACXN7VBGUP/639rFXhJEZCShETQzFU/tXK4NS+wG/bl2gIfaEisyaZZCKOM6zHdCJ9fhZHNWQ16ARhjjUJg8lRtV/XfI+Mys+WpITmXk05uLOk2BGQgwep5BdYv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693727; c=relaxed/simple;
	bh=o4IDyqsIkp4ke7FAFeoPSlssBcMB9tDWRD06iMFMg3A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EdPidKpN6Q6CKIRoWtWQmX29ff4pCpPYHSNhQ63mULv6xFDNl5/iABzviojQvP9VJz6L4eaDvMBlNexgwytPaidxCRxdn7M7tkccCNmQRwUN2pbzKnRAJbhpkwcWPQkgdNx0Zbd1iSHPfS0Ij1WmpYLhav7mdzUU+phGWPvfwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YybreMs0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpgQTlEw; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781693725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IH7ay2N+E2zA4nRJyMLO1X7bzBBBVG5OqoVU7vY8dTI=;
	b=YybreMs0B5M+Lnb1ubNalEACnaUaMKJ9qvkpPCQjeuaiQ7Ak4a25fscNv9mzZ3IWGGN3pg
	dj70ZqMLzy3HAhKaDVSKKPlgnw3ApzL8XibZyEaMurJ32rtSGyenwHIfiEKoen81dJzsE9
	4wLedP3gr3Yddt5NjmcR/N84PfMFtPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-T5sFyDFGP5Wv2H9Lz2t_yA-1; Wed, 17 Jun 2026 06:55:24 -0400
X-MC-Unique: T5sFyDFGP5Wv2H9Lz2t_yA-1
X-Mimecast-MFC-AGG-ID: T5sFyDFGP5Wv2H9Lz2t_yA_1781693723
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so37316885e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781693723; x=1782298523; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IH7ay2N+E2zA4nRJyMLO1X7bzBBBVG5OqoVU7vY8dTI=;
        b=KpgQTlEwvilsU4cXH0CLRihJzQcl0CbM6RwpMYvn3MhLKjGb8i9/oQ8nvGWc5Md5wJ
         5n3BTg9XzjaOTxdiNevMP2DaRXbO+aQBYdq2/x4if9bcx2hYY9+Z/jlZo+dLsTY8j30h
         qwDlIFo+wJo0K0Xp0wFtqtv+PA28bQ0LTwR8PCBMSE4x9Rnd+jADme/N8yKWHzthgir3
         cKj4Nf0/7U4+NuQJwvN9N8CNAhvjqJzScx9Gve1eGrdcDl1C1ybqe88MFVPaayNjykO0
         fVObN3ZOyzsbwoNurRh3lJANbgCCliwCqfbLdw39QUHKUzsXXrrZc4EfCPKFQe/hyjbL
         8K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693723; x=1782298523;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH7ay2N+E2zA4nRJyMLO1X7bzBBBVG5OqoVU7vY8dTI=;
        b=N/oVXO/VkTHxlYLpCz0AUXnzvMQ05uO8ya0hv6kme05x/c+8F2mJjgZy1UQ1pTJDNW
         qR64ys36VSIokSSSZ4e0UBo8ZGv8ecEQ8twUo7SgxGBHVqLafVxkAC1tgx95pQV9eUKH
         MlZWfnFKYM0AaAgZx5wx7k4KOmVkLrQJvLDHfDS0T3lSoAYDmwBu7dIzdFyHAu2Arbvt
         dF+z3a92UwjUo0IZqNz94eUoYoVZCZP66NNg4IWkRukx29IgLI95bk1r6mftGdpmp+/F
         b30VenO2Ua//696IU6S/g9cEaJs8kdzcy1MqAoYFQvsoYo629lC5WqDEdO5862LLl7Jx
         /YUg==
X-Forwarded-Encrypted: i=1; AFNElJ93u5+siJnhYdIIIvAA/8QjWpwO1pOA6QoaOVt3ee6HtGsWvupAAZGan9s5YuLlkB4Lbq9GIvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztU4yFALVpNf13QenZHFHv487k2JEt7S2+Oy3c0Lif4ChNnwSm
	uiIlzqozi0XaalHQEs2v+cHTlUK2b4KRmzj7+PQL1MdNUaMa1dzYws1LNUgPWe5g36IGnpfZ4Ox
	K+68/6oUIaF0PkOov7hjgt7dH28guiJttJPcL7jampgGIbp2MSca3TOKVBg==
X-Gm-Gg: Acq92OFCN5vbZDA2GEwyGtpG5hL4uSzSMEbyulqmupOt9I6cNE1VRXYZeIc8ueov9ST
	p6Jm5Mtpknm8tkv6bjsvr0uXLZ9HmyzT8TZtDgyFzQ8T1tnVRAcTQAp1hBKw4rwNmIHm/FDkcKn
	gmYNV/MqsiyPGtHJP7a/8xv7wpKYcmk8uGvAPrHXSHETpI4v11H6hx9l52uqMgSxZDMzBcobZiY
	lVVuGA9phBwIGNPbheqWbIzhkLDGcDzpO8Wiasf+dWlSlSTlOC2Yql21SJySz9Jyzzcm6Kj/3Y8
	/U6D1w7kb+EOEzJEpHBsmQ5CVdcIx09Yx3y10rR3W5zXCEZFWqJXrLBu+CxkL+w8qThxHxNhUif
	opfyPLePiaCKh3OH1cX3hgNveuibeZAFs
X-Received: by 2002:a05:600c:37c3:b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-492333cf91cmr52522035e9.19.1781693722771;
        Wed, 17 Jun 2026 03:55:22 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-492333cf91cmr52521245e9.19.1781693722197;
        Wed, 17 Jun 2026 03:55:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4f8d7sm146613065e9.5.2026.06.17.03.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:55:21 -0700 (PDT)
Date: Wed, 17 Jun 2026 06:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, a0yami@mailbox.org,
	ammarfaizi2@openresty.com, arnd@arndb.de, chenhuacai@kernel.org,
	chenhuacai@loongson.cn, christfontanez@gmail.com,
	Damir.Shaikhutdinov@opensynergy.com, david@kernel.org,
	den@openvz.org, enelsonmoore@gmail.com, eperezma@redhat.com,
	ethan@ethancedwards.com, evg28bur@yandex.ru, filip.hejsek@gmail.com,
	francesco@valla.it, graf@amazon.com, harald.mommer@oss.qualcomm.com,
	jasowang@redhat.com, jiri@nvidia.com, johan@kernel.org,
	johannes.thumshirn@wdc.com, lingshan.zhu@kernel.org,
	luis.hernandez093@gmail.com, lulu@redhat.com, mhi@mailbox.org,
	michael.bommarito@gmail.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com, mkl@pengutronix.de,
	mst@redhat.com, mvaralar@redhat.com, nathan@kernel.org,
	oleg@redhat.com, pawel.moll@arm.com, physicalmtea@gmail.com,
	polina.vishneva@virtuozzo.com, q.h.hack.winter@gmail.com,
	rosenp@gmail.com, schalla@marvell.com, shuangyu@yunyoo.cc,
	stefanha@redhat.com, vattunuru@marvell.com, yanlonglong@kylinos.cn,
	yichun@openresty.com, yui.washidu@gmail.com, yuka@umeyashiki.org,
	zhangtianci.1997@bytedance.com
Subject: [GIT PULL] virtio,vhost,vdpa: features, fixes
Message-ID: <20260617065516-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:a0yami@mailbox.org,m:ammarfaizi2@openresty.com,m:arnd@arndb.de,m:chenhuacai@kernel.org,m:chenhuacai@loongson.cn,m:christfontanez@gmail.com,m:Damir.Shaikhutdinov@opensynergy.com,m:david@kernel.org,m:den@openvz.org,m:enelsonmoore@gmail.com,m:eperezma@redhat.com,m:ethan@ethancedwards.com,m:evg28bur@yandex.ru,m:filip.hejsek@gmail.com,m:francesco@valla.it,m:graf@amazon.com,m:harald.mommer@oss.qualcomm.com,m:jasowang@redhat.com,m:jiri@nvidia.com,m:johan@kernel.org,m:johannes.thumshirn@wdc.com,m:lingshan.zhu@kernel.org,m:luis.hernandez093@gmail.com,m:lulu@redhat.com,m:mhi@mailbox.org,m:michael.bommarito@gmail.com,m:mikhail.golubev-ciuchea@oss.qualcomm.com,m:mkl@pengutronix.de,m:mst@redhat.com,m:mvaralar@redhat.com,m:nathan@kernel.org,m:oleg@redhat.com,m:pawel.moll@arm.com,m:physicalmtea@gmail.com,m:polina.vishnev
 a@virtuozzo.com,m:q.h.hack.winter@gmail.com,m:rosenp@gmail.com,m:schalla@marvell.com,m:shuangyu@yunyoo.cc,m:stefanha@redhat.com,m:vattunuru@marvell.com,m:yanlonglong@kylinos.cn,m:yichun@openresty.com,m:yui.washidu@gmail.com,m:yuka@umeyashiki.org,m:zhangtianci.1997@bytedance.com,m:filiphejsek@gmail.com,m:luishernandez093@gmail.com,m:michaelbommarito@gmail.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,vger.kernel.org,lists.linux-foundation.org,mailbox.org,openresty.com,arndb.de,kernel.org,loongson.cn,gmail.com,opensynergy.com,openvz.org,redhat.com,ethancedwards.com,yandex.ru,valla.it,amazon.com,oss.qualcomm.com,nvidia.com,wdc.com,pengutronix.de,arm.com,virtuozzo.com,marvell.com,yunyoo.cc,kylinos.cn,umeyashiki.org,bytedance.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 857AA699137

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf:

  can: virtio: Fix comment in UAPI header (2026-06-10 02:17:00 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: features, fixes

- new virtio CAN driver
- support for LoongArch architecture in fw_cfg
- support for firmware notifications in vdpa/octeon_ep
- support for VFs in virtio core

- fixes, cleanups all over the place, notably
    - vhost: fix vhost_get_avail_idx for a non empty ring
      fixing an significant old perf regression
    - plus READ_ONCE annotations mean virtio ring is now
      free of KCSAN warnings

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Graf (1):
      virtio_ring: Add READ_ONCE annotations for device-writable fields

Ammar Faizi (1):
      virtio_pci: fix vq info pointer lookup via wrong index

Arnd Bergmann (1):
      vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO

Christian Fontanez (1):
      virtio: add missing kernel-doc for map and vmap members

Cindy Lu (2):
      vdpa/mlx5: update mlx_features with driver state check
      vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()

Denis V. Lunev (1):
      vhost/vsock: Refuse the connection immediately when guest isn't ready

Ethan Carter Edwards (1):
      virtio_console: Fix spelling mistake "colums" -> "columns"

Ethan Nelson-Moore (1):
      vhost: remove unnecessary module_init/exit functions

Evgenii Burenchev (1):
      vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()

Filip Hejsek (1):
      virtio_console: read size from config space during device init

Huacai Chen (1):
      fw_cfg: Add support for LoongArch architecture

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jia Jia (1):
      virtio: rtc: tear down old virtqueues before restore

Johan Hovold (3):
      virtio-mmio: fix device release warning on module unload
      vdpa_sim_blk: switch to dynamic root device
      vdpa_sim_net: switch to dynamic root device

Matias Ezequiel Vara Larsen (1):
      can: virtio: Add virtio CAN driver

Maurice Hieronymus (2):
      virtio-balloon: Destroy mutex before freeing virtio_balloon
      virtio-mem: Destroy mutex before freeing virtio_mem

Michael Bommarito (1):
      hwrng: virtio: clamp device-reported used.len at copy_data()

Michael S. Tsirkin (2):
      vhost: fix vhost_get_avail_idx for a non empty ring
      tools/virtio: fix build for kmalloc_obj API and missing stubs

Nathan Chancellor (1):
      can: virtio: Fix comment in UAPI header

Oleg Nesterov (1):
      vhost_task_create: kill unnecessary .exit_signal initialization

Qihang Tang (2):
      vduse: hold vduse_lock across IDR lookup in open path
      vhost/vdpa: validate virtqueue index in mmap and fault paths

Qing Ming (1):
      vhost/net: complete zerocopy ubufs only once

Rosen Penev (1):
      vdpa/mlx5: Use kvzalloc_flex() for MTT command memory

Srujana Challa (2):
      vdpa/octeon_ep: Fix PF->VF mailbox data address calculation
      vdpa/octeon_ep: fix IRQ-to-ring mapping in interrupt handler

Vamsi Attunuru (2):
      vdpa/octeon_ep: Use 4 bytes for mailbox signature
      vdpa/octeon_ep: Add vDPA device event handling for firmware notifications

Yui Washizu (1):
      virtio: add num_vf callback to virtio_bus

Zhang Tianci (2):
      vduse: Requeue failed read to send_list head
      vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

longlong yan (1):
      tools/virtio: check mmap return value in vringh_test

 MAINTAINERS                              |    9 +
 drivers/char/hw_random/virtio-rng.c      |   23 +-
 drivers/char/virtio_console.c            |   52 +-
 drivers/firmware/Kconfig                 |    2 +-
 drivers/firmware/qemu_fw_cfg.c           |    2 +-
 drivers/net/can/Kconfig                  |   12 +
 drivers/net/can/Makefile                 |    1 +
 drivers/net/can/virtio_can.c             | 1022 ++++++++++++++++++++++++++++++
 drivers/vdpa/ifcvf/ifcvf_main.c          |   11 +-
 drivers/vdpa/mlx5/core/mr.c              |    7 +-
 drivers/vdpa/octeon_ep/octep_vdpa.h      |   22 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  131 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c     |   24 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c     |   23 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |    2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  197 +++++-
 drivers/vhost/net.c                      |   15 +-
 drivers/vhost/vdpa.c                     |   29 +-
 drivers/vhost/vhost.c                    |   23 +-
 drivers/vhost/vsock.c                    |   16 +
 drivers/virtio/virtio.c                  |    9 +
 drivers/virtio/virtio_balloon.c          |    2 +
 drivers/virtio/virtio_mem.c              |    2 +
 drivers/virtio/virtio_mmio.c             |   26 +-
 drivers/virtio/virtio_pci_common.c       |   10 +-
 drivers/virtio/virtio_ring.c             |   77 ++-
 drivers/virtio/virtio_rtc_driver.c       |   28 +-
 include/linux/virtio.h                   |    2 +
 include/uapi/linux/virtio_can.h          |   78 +++
 include/uapi/linux/virtio_console.h      |    2 +-
 kernel/vhost_task.c                      |    1 -
 tools/virtio/linux/dma-mapping.h         |    2 +
 tools/virtio/linux/err.h                 |    1 +
 tools/virtio/linux/kernel.h              |    6 +
 tools/virtio/vringh_test.c               |    5 +
 35 files changed, 1690 insertions(+), 184 deletions(-)
 create mode 100644 drivers/net/can/virtio_can.c
 create mode 100644 include/uapi/linux/virtio_can.h


