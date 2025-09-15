Return-Path: <netdev+bounces-223000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B55B57733
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B191650A1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159823002D9;
	Mon, 15 Sep 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNjg3BuK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBF2AD24
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933460; cv=none; b=SN97/rcqLSWFF9bI0QH5U1qbBcwkcUhaJFr74oLATgWA7NW0GsClqX7bwoTIWWhT5viGtMd0C3rQWtCmm8NM03/Oxq4zCXj9iyw0JWBpq1Pn1bNY4OdG2PjvrLG7DmI5Hbs1j7+0bqw8wzBJlY8divqfzgBV9OeSjCsFZ4HWuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933460; c=relaxed/simple;
	bh=OeQ9IpcIgY6LuQ+H/vwv6HoMGf9i92u1oM3pZdgDcDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kErwg8lmb27Gc9/jNtQ8x2LWW10G1wYjh7syFovv61h62lLwkAbRI+wIF4mMCXFtKehHuHXoNLFVH17nwoLQVr4673I0frL+Y3H5A2ohO9ZtCs+uVcd50bLF50SxWI0kuK7DGFDN2NFojs4YK0XgOpU4eHQsGu/jkkmHGqnpsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNjg3BuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757933455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIotmOhuWaawwyuguxFvpeivsv2Is6XSpz6kCrw27oI=;
	b=PNjg3BuKWG829jXBBW3NkzjzZFVPp3twu3TAAg2WJMvCGe38kxMZDz7OI8H+Duu3YMVCNF
	U/xyeOtuMi00NG6aBxF4/uM1mAo51Kzyomjfe7z9A5ioxN/uJCCkz3S+LFXYbwY61UYsSX
	eMmciOtTS+axIwHbnn3oshHrlQd8WdQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-jntQMNM-OgGp487yaqxIyw-1; Mon, 15 Sep 2025 06:50:54 -0400
X-MC-Unique: jntQMNM-OgGp487yaqxIyw-1
X-Mimecast-MFC-AGG-ID: jntQMNM-OgGp487yaqxIyw_1757933453
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b0438a5f20fso468360366b.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933453; x=1758538253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIotmOhuWaawwyuguxFvpeivsv2Is6XSpz6kCrw27oI=;
        b=qhsu1Xc0zGFhCOlIxtErJuYawU2x5CJyDq+ptcjaSuTO24/OiBkhgKKLz21ILUJ2Xd
         S+8u0N50Meb6dek8EN+fUE8WzvvkOkX3mBQlxS5TdRPc4ZOUZhnmeYi2qSjNpv6FpU9J
         yI93XM7+vUn6Q9m2McWgzs8pnmvvUr7dXFBECs0b/2LrjjOyY1bdi8BwxS72QGv1zBJ1
         aBtOrZOBgAKlJRu6g0nUG0Eue2WDY4L1/lf2yeJkLqNRsJ+Thq201zoaqvGG/WicwcGQ
         s530BPA+7WmoABDb6354STOvK4AbpDdvBSbJrp9LjkYCbpKVpksIg7vAJPnJ+cq+0POu
         pZJA==
X-Forwarded-Encrypted: i=1; AJvYcCX41N85gQ11lkmWkZ5OKo8683WOaq9nR1aAftdUyH/S0CEeXRtbpmV1RT/lZ58cim9LmJCbbqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3oQ9QJZMQ7MSkuJ/hPan1E2kBXpHJjMKyBbi3+ZxTVHnf7Sl
	dIUF5phDVP5JSvwWZe31SgH++murcaiNl7daeUdXeKxsnkxxbL9Jo+Uq0fw+fPTismHqvB0iEYF
	IZzIoXOfWkkHjmJ1I3qdEUSzeCH+rlctYrZPMCgaU0Ab11NUtk2dwb9bI8z8/OXi4Z1r1/uqVEd
	U/QOrfqBgkrpkp26zbb1nNkWjUs0p45lSv
X-Gm-Gg: ASbGnctfNN1AL75ByF0xTTK9JqRjH9Wz321OuChijApYmhMgeErnZawkxuHQ5Q8IXV4
	0ECQ5jw5Tud3IgPpTXfs4U8QiWUutDUGtKMQalmTF50WBLaTLifNRIhTl5ZXd7zqVkEaPTRnxNV
	oVDCeSynCC/QmW+l5GHlcYJw==
X-Received: by 2002:a17:906:3714:b0:b07:c715:31 with SMTP id a640c23a62f3a-b07c7151ae3mr888505266b.65.1757933453325;
        Mon, 15 Sep 2025 03:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwFXUMPhAfyOyWhskdT4TwFZdYDKzqZ9x9X/pura5VoVKpLkZNrGTRxBMnHJGvlHr1k7JI+yYLa/zNh3SQB5Q=
X-Received: by 2002:a17:906:3714:b0:b07:c715:31 with SMTP id
 a640c23a62f3a-b07c7151ae3mr888502166b.65.1757933452849; Mon, 15 Sep 2025
 03:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 18:50:15 +0800
X-Gm-Features: AS18NWDF1ZgPv9MjjdEfNagbJ6NFrcc2o78etskRgD59xtA91YySZUY1aQQZh_w
Message-ID: <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno

This series of patches introduced a kernel panic bug. The tests are
based on the linux-next commit [1]. I tried it a few times and found
that if I didn't apply the current patch, the issue wouldn't be
triggered. After applying the current patch, the probability of
triggering the issue was 3/3.

Reproduced steps:
1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
2. applied this series of patches
3. compile and install
4. reboot server(A kernel panic occurs at this step)

[1] commit 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1 (tag:
next-20250912, origin/master, origin/HEAD)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Sep 12 15:15:12 2025 +1000

    Add linux-next specific files for 20250912

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

kernel panic messages:
[   13.769667] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   13.840778] systemd-rc-local-generator[1084]: /etc/rc.d/rc.local is
not marked executable, skipping.
[   13.892736]  slab kmalloc-64 start ffff8b3784459940 pointer offset 40 si=
ze 64
[   13.899909] list_add corruption. prev->next should be next
(ffffffffb5a91608), but was dead000000000100. (prev=3Dffff8b3784459968).
[   13.911570] ------------[ cut here ]------------
[   13.916185] kernel BUG at lib/list_debug.c:32!
[   13.920637] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   13.925708] CPU: 26 UID: 0 PID: 325 Comm: kworker/26:1 Tainted: G S
         E       6.17.0-rc5-next-20250912+ #2 PREEMPT(voluntary)
[   13.937692] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
[   13.943437] Hardware name: Dell Inc. PowerEdge R740xd/01YM03, BIOS
2.2.11 06/13/2019
[   13.951176] Workqueue: cgroup_free css_free_rwork_fn
[   13.956150] RIP: 0010:__list_add_valid_or_report+0x94/0xa0
[   13.961635] Code: cf 88 ff 0f 0b 48 89 f7 48 89 34 24 e8 45 ba c7
ff 48 8b 34 24 48 c7 c7 e8 fe e7 b4 48 8b 16 48 89 f1 48 89 de e8 8c
cf 88 ff <0f> 0b 90 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[   13.980381] RSP: 0018:ffffcdcb07397dc0 EFLAGS: 00010246
[   13.985605] RAX: 0000000000000075 RBX: ffffffffb5a91608 RCX: 00000000000=
00003
[   13.992740] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb59=
e45c8
[   13.999870] RBP: ffff8b3008a6e5b0 R08: 0000000000000000 R09: ffffcdcb073=
97c48
[   14.007001] R10: ffffffffb5924588 R11: 0000000000000003 R12: ffffffffb5a=
91600
[   14.014135] R13: ffff8b3784459968 R14: ffff8b3008a6e040 R15: ffff8b3004e=
5b468
[   14.021267] FS:  0000000000000000(0000) GS:ffff8b37a9be9000(0000)
knlGS:0000000000000000
[   14.029352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.035098] CR2: 00007fb1ef5862f4 CR3: 0000000ed3a24006 CR4: 00000000007=
706f0
[   14.042229] PKRU: 55555554
[   14.044942] Call Trace:
[   14.047395]  <TASK>
[   14.049501]  mem_cgroup_css_free+0x52/0x150
[   14.053688]  css_free_rwork_fn+0x4e/0x1f0
[   14.057701]  process_one_work+0x18b/0x340
[   14.061714]  worker_thread+0x256/0x3a0
[   14.065465]  ? __pfx_worker_thread+0x10/0x10
[   14.069737]  kthread+0xfc/0x240
[   14.072882]  ? __pfx_kthread+0x10/0x10
[   14.076633]  ? __pfx_kthread+0x10/0x10
[   14.080388]  ret_from_fork+0xf0/0x110
[   14.084053]  ? __pfx_kthread+0x10/0x10
[   14.087807]  ret_from_fork_asm+0x1a/0x30
[   14.091733]  </TASK>
[   14.093924] Modules linked in: xfs(E) sd_mod(E) ahci(E) libahci(E)
ghash_clmulni_intel(E) wdat_wdt(E) megaraid_sas(E) tg3(E) libata(E)
wmi(E) sunrpc(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
be2iscsi(E) iscsi_boot_sysfs(E) bnx2i(E) cnic(E) uio(E) cxgb4i(E)
cxgb4(E) tls(E) libcxgbi(E) libcxgb(E) iscsi_tcp(E) libiscsi_tcp(E)
libiscsi(E) scsi_transport_iscsi(E) nfnetlink(E)
[   14.093947] Unloaded tainted modules: fjes(E):1
[   14.132310] ---[ end trace 0000000000000000 ]---
[   14.177186] RIP: 0010:__list_add_valid_or_report+0x94/0xa0
[   14.182685] Code: cf 88 ff 0f 0b 48 89 f7 48 89 34 24 e8 45 ba c7
ff 48 8b 34 24 48 c7 c7 e8 fe e7 b4 48 8b 16 48 89 f1 48 89 de e8 8c
cf 88 ff <0f> 0b 90 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[   14.201432] RSP: 0018:ffffcdcb07397dc0 EFLAGS: 00010246
[   14.206666] RAX: 0000000000000075 RBX: ffffffffb5a91608 RCX: 00000000000=
00003
[   14.213803] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb59=
e45c8
[   14.220934] RBP: ffff8b3008a6e5b0 R08: 0000000000000000 R09: ffffcdcb073=
97c48
[   14.228067] R10: ffffffffb5924588 R11: 0000000000000003 R12: ffffffffb5a=
91600
[   14.235199] R13: ffff8b3784459968 R14: ffff8b3008a6e040 R15: ffff8b3004e=
5b468
[   14.242331] FS:  0000000000000000(0000) GS:ffff8b37a9be9000(0000)
knlGS:0000000000000000
[   14.250419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.256164] CR2: 00007fb1ef5862f4 CR3: 0000000ed3a24006 CR4: 00000000007=
706f0
[   14.263296] PKRU: 55555554
[   14.266011] Kernel panic - not syncing: Fatal exception
[   14.271323] Kernel Offset: 0x32600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   14.323149] ---[ end Kernel panic - not syncing: Fatal exception ]---

Thanks
Lei


On Fri, Sep 12, 2025 at 11:59=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> This patchset introduces a new dedicated ethtool_ops callback,
> .get_rx_ring_count, which enables drivers to provide the number of RX
> rings directly, improving efficiency and clarity in RX ring queries and
> RSS configuration.
>
> Number of drivers implements .get_rxnfc callback just to report the ring
> count, so, having a proper callback makes sense and simplify .get_rxnfc
> (in some cases remove it completely).
>
> This has been suggested by Jakub, and follow the same idea as RXFH
> driver callbacks [1].
>
> This also port virtio_net to this new callback. Once there is consensus
> on this approach, I can start moving the drivers to this new callback.
>
> Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.or=
g/ [1]
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
> Changes in v2:
> - rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
> - initialize struct ethtool_rxnfc() (Jakub)
> - Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a5=
4@debian.org
> ---
> Changes v1 from RFC:
> - Renaming and changing the return type of .get_rxrings() callback (Jakub=
)
> - Add the docstring format for the new callback (Simon)
> - Remove the unecessary WARN_ONCE() (Jakub)
> - Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f2=
8f@debian.org
>
> ---
> Breno Leitao (7):
>       net: ethtool: pass the num of RX rings directly to ethtool_copy_val=
idate_indir
>       net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
>       net: ethtool: remove the duplicated handling from ethtool_get_rxrin=
gs
>       net: ethtool: add get_rx_ring_count callback to optimize RX ring qu=
eries
>       net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count help=
er
>       net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_coun=
t helper
>       net: virtio_net: add get_rxrings ethtool callback for RX ring queri=
es
>
>  drivers/net/virtio_net.c | 15 ++-------
>  include/linux/ethtool.h  |  2 ++
>  net/ethtool/ioctl.c      | 81 +++++++++++++++++++++++++++++++++++++-----=
------
>  3 files changed, 68 insertions(+), 30 deletions(-)
> ---
> base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
> change-id: 20250905-gxrings-a2ec22ee2aec
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>


