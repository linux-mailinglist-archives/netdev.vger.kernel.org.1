Return-Path: <netdev+bounces-138763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C519AECAD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FC91C2318C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BB1F669F;
	Thu, 24 Oct 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej5PbCYH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11E1BD504
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788778; cv=none; b=ARwDwdsCuHQ6hWUmsJXT6dbJhVXFUswZ7HKq5kuQqIRnl3xIvHv5gmnwo+yrv8Q1Rdl8VQZsFfvPRSOyyKa/Z5XX9k+phOt/gk66MAdRC5cIGc4SOdpis7pcQtuXzDXf4HTJWvjsmtwD2sDbt45CDa1ytu/BYmz1CIAQ2cIOhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788778; c=relaxed/simple;
	bh=VgkTXrdCrekHQu/borXsMoReTje3sO7Bo/Y6rrL8lzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS3aalXXdlcPjyTjK3qMgksiT8/kfTU96x94SfvFMmFNW+KZp/BOBeKJ879RuwuaLUyTXf3hk173ipZs3ad72vETO3YXw+iFt35thfrueOm1xI2lbZGy1G70u7Zt1AZebpn2dpDHVtzKCK8vmgnwUkSO0WMROnfiiy2/pTJYOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ej5PbCYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729788774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw2joPSZBRAcPknHCGCTPBKVECnGNXOC9xb77trAjAo=;
	b=ej5PbCYHaH8IqdZTlHkxjZ4lN7V6yD5NRSiNK5Fp3NOIBYGG7QljNO6sdIhUgjUituOOsx
	6UEwUDL2EWSsoM3TTiI6te/sdnTTQDH3mn0ePhJkhTh8tn7o1I4zMhFI+bTthduSA08Fxi
	Dh/0ic2a8PF46FpSsibIFCfadKpWFHM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-VVCmsK7MO8KwOB-A-pCLdw-1; Thu, 24 Oct 2024 12:52:52 -0400
X-MC-Unique: VVCmsK7MO8KwOB-A-pCLdw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7180d9a3693so222795a34.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788771; x=1730393571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw2joPSZBRAcPknHCGCTPBKVECnGNXOC9xb77trAjAo=;
        b=c5ccOaJ42qEqgpXOMHBLOMQDXzUYvaPigXQYPYrtH2id/S38/srMXXstxOpLO6p/+u
         LjNmMNt1owOYYzMSrpOXRQxImKw6C9p1F45vLUN9TBTuyjcFgKbCKOx10ucY6kc65Zxa
         LJ70NFfbZSqOJqXA9tOFRTmsGgT+23b30MpgeeP/GTQq4tIFI9IDbzRZoa/DG9HyJTn6
         IaXRMj3gv4F7U3jPlZe4i3Rv1bYN7DXnXiWJDfLFL7YPW8AnSczs5Hp8YRx5XGbhxMy+
         klJFIw9CenrA35PkD97gEGkKwQZI2anyHnFmIS4R3nYjUFTHkxwjQxjhD2UXEULJ+7AL
         Iepg==
X-Forwarded-Encrypted: i=1; AJvYcCVNa4+1NYxKTJmrOVp6iNKqiiW/787727BO+K8vkf8o6avtYG/Rddo9Q7jZudOMvZcRHrFm66w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLTZ8RvRhltFIpF5q1J/jyW0Ab/FEu8ara6WQpzte4BrKy/tY
	0+P7cxTUZXbOO9kaYbo80vOB+Ym30fAXOQlOQ16NJm+6RPsEL1o/+CyWE+uMNey/EoD2D2AYYeg
	vbBOzhtLjsw38nSnAzGMnHQNd7fBF7Sh+V13ZNbadHh/0behnC3rY6xl3zn6raw5EJ3Qoa1WEk7
	6GgdMSVj2kSpeiYyzRr7ThrrXLgnGfbnAqd4KmmYo=
X-Received: by 2002:a05:6871:5cf:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-28ccb452718mr1644224fac.6.1729788771301;
        Thu, 24 Oct 2024 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1FeOeqVI5RDdJcGP1OgTiiacmQCe/R6h2GxVLiVTbW18yiDFdJFq8LQK9/RlJpfpEMvuN0EvOZ+D7OkZlso8=
X-Received: by 2002:a05:6871:5cf:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-28ccb452718mr1644215fac.6.1729788770943; Thu, 24 Oct 2024
 09:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016093011.318078-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20241016093011.318078-1-aleksandr.loktionov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 24 Oct 2024 18:52:39 +0200
Message-ID: <CADEbmW0N+7xNt_DaBcYsK9=A3f4kWnNS4tEV_gAcE3r_7aWgOA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix race condition by
 adding filter's intermediate sync state
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:30=E2=80=AFAM Aleksandr Loktionov
<aleksandr.loktionov@intel.com> wrote:
>
> Fix a race condition in the i40e driver that leads to MAC/VLAN filters
> becoming corrupted and leaking. Address the issue that occurs under
> heavy load when multiple threads are concurrently modifying MAC/VLAN
> filters by setting mac and port VLAN.
>
> 1. Thread T0 allocates a filter in i40e_add_filter() within
>         i40e_ndo_set_vf_port_vlan().
> 2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
>         i40e_ndo_set_vf_mac().
> 3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
>         refers to the already freed filter memory, causing corruption.
>
> Reproduction steps:
> 1. Spawn multiple VFs.
> 2. Apply a concurrent heavy load by running parallel operations to change
>         MAC addresses on the VFs and change port VLANs on the host.
> 3. Observe errors in dmesg:
> "Error I40E_AQ_RC_ENOSPC adding RX filters on VF XX,
>         please set promiscuous on manually for VF XX".
>
> Exact code for stable reproduction Intel can't open-source now.

I wrote a reproducer that uses Systemtap to enlarge the race window in
i40e_sync_vsi_filters():
https://gitlab.com/mschmidt2/repro/-/tree/master/i40e-filters-uaf

With KASAN enabled, it looks like this when it triggers:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 BUG: KASAN: slab-use-after-free in i40e_sync_vsi_filters+0x37ee/0x3c10 [i4=
0e]
 Read of size 2 at addr ffff888120a43350 by task kworker/29:0/211

 CPU: 29 UID: 0 PID: 211 Comm: kworker/29:0 Tainted: G           OE
  6.11.4-301.fc41.x86_64+debug #1
 Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
 Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super
Server/H12SSW-iN, BIOS 2.7 10/25/2023
 Workqueue: i40e i40e_service_task [i40e]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x84/0xd0
  ? i40e_sync_vsi_filters+0x37ee/0x3c10 [i40e]
  print_report+0x174/0x505
  ? i40e_sync_vsi_filters+0x37ee/0x3c10 [i40e]
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __virt_addr_valid+0x231/0x420
  ? i40e_sync_vsi_filters+0x37ee/0x3c10 [i40e]
  kasan_report+0xab/0x180
  ? i40e_sync_vsi_filters+0x37ee/0x3c10 [i40e]
  i40e_sync_vsi_filters+0x37ee/0x3c10 [i40e]
  ? __pfx_i40e_sync_vsi_filters+0x10/0x10 [i40e]
  ? __pfx_register_lock_class+0x10/0x10
  ? srso_alias_return_thunk+0x5/0xfbef5
  i40e_sync_filters_subtask.part.0+0x1e0/0x260 [i40e]
  i40e_service_task+0x1b3/0x23a0 [i40e]
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? rethook_hook+0x19/0x90
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? pre_handler_kretprobe+0xc0/0x140
  ? __pfx_i40e_service_task+0x10/0x10 [i40e]
  ? aggr_pre_handler+0xd2/0x160
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? kprobe_ftrace_handler+0x371/0x480
  ? i40e_service_task+0x9/0x23a0 [i40e]
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? loop_init+0xce/0xff0 [loop]
  ? __pfx_i40e_service_task+0x10/0x10 [i40e]
  ? process_one_work+0x860/0x1450
  osnoise_arch_unregister+0x210/0x210
  ? worker_thread+0xe3/0xfc0
  ? __pfx_process_one_work+0x10/0x10
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? assign_work+0x16c/0x240
  worker_thread+0x5e6/0xfc0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x2d5/0x3a0
  ? _raw_spin_unlock_irq+0x28/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2198:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  __kasan_kmalloc+0x8f/0xa0
  i40e_add_filter+0x133/0x4c0 [i40e]
  i40e_add_vlan_all_mac+0x7e/0x160 [i40e]
  i40e_ndo_set_vf_port_vlan.cold+0x291/0x363 [i40e]
  do_setlink+0x1216/0x33e0
  __rtnl_newlink+0xb1d/0x1600
  rtnl_newlink+0xc0/0x100
  rtnetlink_rcv_msg+0x2f6/0xb20
  netlink_rcv_skb+0x140/0x3b0
  netlink_unicast+0x431/0x720
  netlink_sendmsg+0x765/0xc20
  ____sys_sendmsg+0x97f/0xc60
  ___sys_sendmsg+0xfd/0x180
  __sys_sendmsg+0x19c/0x220
  do_syscall_64+0x97/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 Freed by task 2198:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  kasan_save_free_info+0x3b/0x70
  poison_slab_object+0x109/0x180
  __kasan_slab_free+0x14/0x30
  kfree+0x11b/0x450
  i40e_vsi_release+0x38a/0xbd0 [i40e]
  i40e_free_vf_res+0x551/0x9e0 [i40e]
  i40e_cleanup_reset_vf+0x89/0x1620 [i40e]
  i40e_reset_vf+0x216/0x360 [i40e]
  i40e_ndo_set_vf_port_vlan+0x4a8/0x850 [i40e]
  do_setlink+0x1216/0x33e0
  __rtnl_newlink+0xb1d/0x1600
  rtnl_newlink+0xc0/0x100
  rtnetlink_rcv_msg+0x2f6/0xb20
  netlink_rcv_skb+0x140/0x3b0
  netlink_unicast+0x431/0x720
  netlink_sendmsg+0x765/0xc20
  ____sys_sendmsg+0x97f/0xc60
  ___sys_sendmsg+0xfd/0x180
  __sys_sendmsg+0x19c/0x220
  do_syscall_64+0x97/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff888120a43340
  which belongs to the cache kmalloc-rnd-02-32 of size 32
 The buggy address is located 16 bytes inside of
  freed 32-byte region [ffff888120a43340, ffff888120a43360)

 The buggy address belongs to the physical page:
 page: refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888120a43a00 pfn:0x120a43
 flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
 page_type: 0xfdffffff(slab)
 raw: 0017ffffc0000000 ffff88810004e800 dead000000000122 0000000000000000
 raw: ffff888120a43a00 0000000080400034 00000001fdffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff888120a43200: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
  ffff888120a43280: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 >ffff888120a43300: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                  ^
  ffff888120a43380: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888120a43400: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


> The fix involves implementing a new intermediate filter state,
> I40E_FILTER_NEW_SYNC, for the time when a filter is on a tmp_add_list.
> These filters cannot be deleted from the hash list directly but
> must be removed using the full process.
>
> Fixes: 278e7d0b9d68 ("i40e: store MAC/VLAN filters in a hash with the MAC=
 Address as key")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Michal Schmidt <mschmidt@redhat.com>

Michal


