Return-Path: <netdev+bounces-171090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91878A4B71F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 05:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FBC3AC1E8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 04:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5013C9D4;
	Mon,  3 Mar 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIDuOour"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965D2AE89
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975800; cv=none; b=LccTXbREquSN8Lc1hIqWTkRcSOf3fjPZOixy6UTLQOIYk5bKwqgBVznxKiBH7hFKTCokmkotIt4IIzuZ7Q1o2gNTOfdAJrK8vKAnDNmusE2nZKLiNHIAUxptydqY0mLoU0bABw/KJA5NrgVDvh5Yp3yFk6RsPupD+ng8sOdJXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975800; c=relaxed/simple;
	bh=JziNQeEvfXttN4oqsDPukjpuJTb2Su8Ahshl20o7Mg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qidb6ckMznT4OkB6RPgZK2vDUJwNOiTG4LmR0O1Cz0xTWbsfh2s8MaN8UCEImW5bbCgnUf4BKigjbbGRFGY0Isr42q4VBPCyPSiBllAUrm/vx7LXgey+/TNSQpNcRtz6Z/WEqE/9eCZwXDPgqOt66qJ36MZurpa/Lt6p9mVu4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIDuOour; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740975797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z5DP5mFPC0y911JzdcyQSaaeFbFkFkrH1ZSkKvQX2I=;
	b=CIDuOour16lb7DfU6BblFl9h9Grqwb4pTQdZC7JExs5h0nLTJrgAWkHEW7ZSXHt+4kis1V
	B9A96rRD2KZERg+4YxynlE08AjZ2QoB4Yob8xzGVfnx6SEZkTqDTgx/mZ7e4ELYXROs1bO
	HoE5Pb23tj+UX/6ekjioQV7ndjDzpF8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-8ySa4AnsOBmrR8GaknUrmg-1; Sun, 02 Mar 2025 23:23:16 -0500
X-MC-Unique: 8ySa4AnsOBmrR8GaknUrmg-1
X-Mimecast-MFC-AGG-ID: 8ySa4AnsOBmrR8GaknUrmg_1740975795
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf681786dfso93163866b.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 20:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740975795; x=1741580595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z5DP5mFPC0y911JzdcyQSaaeFbFkFkrH1ZSkKvQX2I=;
        b=o5c99GeHq2PiEVsREF/McwQ5LZHopT3DX/neYuqsSBiY2FPse6a06LIQpw0S9Gyp3q
         diCBVbC4B/J9qVX0XyV8Qq/CFVBH8m0wkX8VKHX5ImfBupMb2pDVCSOcjvcQdTdhcKhh
         EO94NvTKWpP4/996EBvHRX4vLoybtVsB3CTkbBU7Y33tjyQxAFUqa4lUvrmyyM1TNFQw
         yeKK5OpWZbskIgL3lcocLFAOtDeq7fGMyO8NtGN9aDsr2ExXzFRK05VmqqxVER1YmFr3
         CnEx8klkLkgZPFB10NrDiMd0v8j2sOaqL+eDS7XtgfqlWIx+df+Sw8TxxXitGOgV6KAT
         J27g==
X-Gm-Message-State: AOJu0YzvdnmKo5hju9K2qKzYWk0q2+sNAJVzBZbZ/5IrzOCAO9KaLvR1
	Qy6zaT2vY3Gru47DyNGlqaksRj9JLpcuiE3fptCdPK1nkUzKnosCioKpyqLUcWwRMJoecAJ83QP
	csT8O/uoqewihNh95ZZIT6Xxx2OwaQEp3cxdCh3SWvaoJCJzPuJVzC7EdIYmQTz1oYYLiQ1uJl8
	XFmBPkM3olEvxa+SMkwq01FPyXdJud
X-Gm-Gg: ASbGncuDeTUb/0PEnLCn5XLo+wnEl4Sm2qI3HCPIfio40vzEmn8Tn5ZRO4Aa2hctlcc
	SJTnWuRRd1enL+uLKYiont4KneSmF3tODWWk/1LXn1Ls4xWVxZBnQPVKh7iqrg+NZBKKpO5U/9A
	==
X-Received: by 2002:a17:906:6a17:b0:ac1:d878:f877 with SMTP id a640c23a62f3a-ac1d878fb5bmr94744266b.49.1740975795160;
        Sun, 02 Mar 2025 20:23:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWyzI0AOlANf2bYKVyZJngeeUnLJOv2Dv45IaKQgCjsC57L7Mk4bv8JVqD3WvpZNQQYSz2NLK2R0KBLE+Nza4=
X-Received: by 2002:a17:906:6a17:b0:ac1:d878:f877 with SMTP id
 a640c23a62f3a-ac1d878fb5bmr94743166b.49.1740975794836; Sun, 02 Mar 2025
 20:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302000901.2729164-1-sdf@fomichev.me>
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:22:38 +0800
X-Gm-Features: AQ5f1Jr4ALoGLW3NOFIdIJ4T_a9UZ82LrWndBAN6ky0C-yDtSUDHLpwaoIiqTWE
Message-ID: <CAPpAL=w0+x1Mj3iHRkeiktXjY3FTt-pz9qHk9f0KF-EL2FOCxw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 00/14] net: Hold netdev instance lock during
 ndo operations
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>, 
	David Wei <dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Mar 2, 2025 at 8:09=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> As the gradual purging of rtnl continues, start grabbing netdev
> instance lock in more places so we can get to the state where
> most paths are working without rtnl. Start with requiring the
> drivers that use shaper api (and later queue mgmt api) to work
> with both rtnl and netdev instance lock. Eventually we might
> attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> netdev sim (as the drivers that implement shaper/queue mgmt)
> so those drivers are converted in the process.
>
> call_netdevice_notifiers locking is very inconsistent and might need
> a separate follow up. Some notified events are covered by the
> instance lock, some are not, which might complicate the driver
> expectations.
>
> Changes since v9:
> - rework ndo_setup_tc locking (Saeed)
>   - net: hold netdev instance lock during ndo_setup_tc
>     - keep only nft parts (hopefully ok to keep Eric's RB)
>   - 2 new patches to grab the lock at sch_api netlink level
>     - net: sched: wrap doit/dumpit methods
>       - general refactoring to make it easier to grab instance lock
>     - net: hold netdev instance lock during qdisc ndo_setup_tc
>   - net: ethtool: try to protect all callback with netdev instance lock
>     - remove the lock around get_ts_info
>
> Changes since v8:
> - rebase on top of net-next
>
> Changes since v7:
> - fix AA deadlock detection in netdev_lock_cmp_fn (Jakub)
>
> Changes since v6:
> - rebase on top of net-next
>
> Changes since v5:
> - fix comment in bnxt_lock_sp (Michael)
> - add netdev_lock/unlock around GVE suspend/resume (Sabrina)
> - grab netdev lock around ethtool_ops->reset in cmis_fw_update_reset (Sab=
rina)
>
> Changes since v4:
> - reword documentation about rtnl_lock and instance lock relation
>   (Jakub)
> - do s/RTNL/rtnl_lock/ in the documentation (Jakub)
> - mention dev_xxx/netif_xxx distinction (Paolo)
> - add new patch to add request_ops_lock opt-in (Jakub)
> - drop patch that adds shaper API to dummy (Jakub)
> - drop () around dev in netdev_need_ops_lock
>
> Changes since v3:
> - add instance lock to netdev_lockdep_set_classes,
>   move lock_set_cmp_fn to happen after set_class (NIPA)
>
> Changes since v2:
> - new patch to replace dev_addr_sem with instance lock (forwarding tests)
> - CONFIG_LOCKDEP around netdev_lock_cmp_fn (Jakub)
> - remove netif_device_present check from dev_setup_tc (bpf_offload.py)
> - reorder bpf_devs_locks and instance lock ordering in bpf map
>   offload (bpf_offload.py)
>
> Changes since v1:
> - fix netdev_set_mtu_ext_locked in the wrong place (lkp@intel.com)
> - add missing depend on CONFIG_NET_SHAPER for dummy device
>   (lkp@intel.com)
>   - not sure we need to apply dummy device patch..
> - need_netdev_ops_lock -> netdev_need_ops_lock (Jakub)
> - remove netdev_assert_locked near napi_xxx_locked calls (Jakub)
> - fix netdev_lock_cmp_fn comment and line length (Jakub)
> - fix kdoc style of dev_api.c routines (Jakub)
> - reflow dev_setup_tc to avoid indent (Jakub)
> - keep tc_can_offload checks outside of dev_setup_tc (Jakub)
>
> Changes since RFC:
> - other control paths are protected
> - bntx has been converted to mostly depend on netdev instance lock
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Cc: David Wei <dw@davidwei.uk>
>
> Jakub Kicinski (1):
>   net: ethtool: try to protect all callback with netdev instance lock
>
> Stanislav Fomichev (13):
>   net: hold netdev instance lock during ndo_open/ndo_stop
>   net: hold netdev instance lock during nft ndo_setup_tc
>   net: sched: wrap doit/dumpit methods
>   net: hold netdev instance lock during qdisc ndo_setup_tc
>   net: hold netdev instance lock during queue operations
>   net: hold netdev instance lock during rtnetlink operations
>   net: hold netdev instance lock during ioctl operations
>   net: hold netdev instance lock during sysfs operations
>   net: hold netdev instance lock during ndo_bpf
>   net: replace dev_addr_sem with netdev instance lock
>   net: add option to request netdev instance lock
>   docs: net: document new locking reality
>   eth: bnxt: remove most dependencies on RTNL
>
>  Documentation/networking/netdevices.rst       |  65 +++-
>  drivers/net/bonding/bond_main.c               |  16 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 133 ++++----
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 +
>  .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
>  drivers/net/ethernet/google/gve/gve_main.c    |  12 +-
>  drivers/net/ethernet/google/gve/gve_utils.c   |   6 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  16 +-
>  drivers/net/netdevsim/ethtool.c               |   2 -
>  drivers/net/netdevsim/netdev.c                |  39 ++-
>  drivers/net/tap.c                             |   2 +-
>  drivers/net/tun.c                             |   2 +-
>  include/linux/netdevice.h                     |  90 ++++-
>  kernel/bpf/offload.c                          |   6 +-
>  net/8021q/vlan_dev.c                          |   4 +-
>  net/core/Makefile                             |   2 +-
>  net/core/dev.c                                | 284 ++++++----------
>  net/core/dev.h                                |  22 +-
>  net/core/dev_api.c                            | 318 ++++++++++++++++++
>  net/core/dev_ioctl.c                          |  69 ++--
>  net/core/net-sysfs.c                          |   9 +-
>  net/core/netdev_rx_queue.c                    |   5 +
>  net/core/rtnetlink.c                          |  50 ++-
>  net/dsa/conduit.c                             |  16 +-
>  net/ethtool/cabletest.c                       |  20 +-
>  net/ethtool/cmis_fw_update.c                  |   7 +-
>  net/ethtool/features.c                        |   6 +-
>  net/ethtool/ioctl.c                           |   6 +
>  net/ethtool/module.c                          |   8 +-
>  net/ethtool/netlink.c                         |  12 +
>  net/ethtool/phy.c                             |  20 +-
>  net/ethtool/rss.c                             |   2 +
>  net/ethtool/tsinfo.c                          |   9 +-
>  net/netfilter/nf_flow_table_offload.c         |   2 +-
>  net/netfilter/nf_tables_offload.c             |   2 +-
>  net/sched/sch_api.c                           | 214 ++++++++----
>  net/xdp/xsk.c                                 |   3 +
>  net/xdp/xsk_buff_pool.c                       |   2 +
>  41 files changed, 1045 insertions(+), 488 deletions(-)
>  create mode 100644 net/core/dev_api.c
>
> --
> 2.48.1
>
>


