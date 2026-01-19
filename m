Return-Path: <netdev+bounces-251042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634FD3A51E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F173004789
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF12DB799;
	Mon, 19 Jan 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awTR0jBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBC2D97B9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818823; cv=none; b=drhfvLx0Aob6arcy7j30a7Z/EOR2WgpgOupFMXOyAZGMLkWshXQOqYeRlLOsUR6RPT79YWtNFG7RbxwdkUpd4KGiC7FDITO1pUsTzPnG6xXF4YNOWFt8/U9D8KOOZai1CX+3ugTA4vveYIZ2IwWmiJQ5OQTzRuwsexhIyvYvgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818823; c=relaxed/simple;
	bh=vQAmXS2ig1Dknm+22HOa0e/7D6qyBIAgi9jy0gu38YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxYcYRyCH3puWNrxVFg/nP8y589pwt8le8/gCsIkhGO6dABe5Z7zuBaxp54Qm+bLrEJeHHeANCvPzJxAn2cWGpQhI9NNuKmQSSSOrx34TbQHO98GRR48GqtKe78XkTVe88njvR4RjQkUCOTvcdKUcBy+ZaVYB4KuD4yFYInTKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awTR0jBH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a2370e4fso24885601cf.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768818821; x=1769423621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/p2DrTvdVpnGHhLThyzGuArcO0U7ZuxhVdRDGOx7js=;
        b=awTR0jBHknQIw0vEz+AN8C249Wi8jSStQDtE6F6cexuzTzuEoQeBDtsmqdAJvLKnfS
         9rs/ifUqgeZCmZA594vHbBvPf+elVJ8TC8hNqGlIoOFzaWYCCRtyJnebEUrTdCbnWYml
         SP9y+5JbqT4/nOqjAmWXuXxeOeP5GNpChLp61/NSPE+7A8AA1wmJwBUHE7YwXOb6eLAn
         e2YiKzaeS11x8rRzKzRfh2BzqqS+WFfXGnllNGFvivs8Gcb0yKzpmXlIt9HW7xJ8tN+7
         5t+93D7xRLkl4oMI+xOE7/tx/y6NbmuGkN/EZz7QENw7vimDgSLJioGHDB1W5LYNlNW3
         vnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818821; x=1769423621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/p2DrTvdVpnGHhLThyzGuArcO0U7ZuxhVdRDGOx7js=;
        b=D7s8DdWAHfULLD98uvaXf677pY0N3QFLJ9lDpEZbQSeIY7Fr3Xldkpmh//H9+7R99J
         S8DTfbnz/tzOFctEhv7y87VfqTYvgSS96jhExrMQn1915OhMnwOn6lgfQlZ4W5HmOl1Z
         AlFrT5tEVhrXFWhXeLxFv98b9M2u3jjjMO8QHiiesXvmOhxpWIK0htZKX7MjSeWwZm0M
         eRaVlJjlQv7H2Nm9jPS2gpS6EYXs1zEbWsGzNe0Bsachd9SJQboi4yuq0fmbRtz4WYp+
         3T6/igs9kismO8QTWu6d4XBbZX21gncaMgZsct1AYyYTwmkL2hmVMKRCAsn0NM4fyPrX
         d30g==
X-Forwarded-Encrypted: i=1; AJvYcCXRgZH0BwS/raqWj9Yqz4ZpJsNC0KvteC5PU6Z+hbe1Xh22VB/QweviqX2oKTokB+xzP+qOljw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFKQ1wt0Mly9Yd2iJKSM4hab6DkRBcAd/dvLP/GEv7gAWzQst
	Y/Wqi8crBOlQajtUkZp/mMI9bVR+S8f4+ToXCxjy3B8D4P1GAeM3QNVDlxbGadUzzVGdldQMAgD
	hL0kInQ4zwXPC9IEnAKatCu96YE23Mm8BHfjLSGoi
X-Gm-Gg: AY/fxX7cHVFC8sXBbxriD4HIL6WuvUuBVUrIFzviOYauIr54RuZGKclnZlRMWeBXy3N
	d89RsTtKSSXP5umHkV2peL+GpoCBPqJwPwSdfm7JGoC/v9z/7yd6ceOBck0yKwTPV+/fC0vxl+9
	14fjl5MPPhuwJmFevYkIWjG/h/jVqaO3F4R5W/VZ/6se0JdL/u2ReHapyWxWDsb1w135p4mPWCs
	NAPbY4yDNNJduEgUPGtWeqIQGKyf9vw5rEZ48OJrMAemI48A+8AkHEQeSnFTLvzb7tbYg0=
X-Received: by 2002:ac8:7d0a:0:b0:4f4:e15d:f220 with SMTP id
 d75a77b69052e-502b6ef8690mr75192001cf.25.1768818820706; Mon, 19 Jan 2026
 02:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118152448.2560414-1-edumazet@google.com> <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
 <20260118225802.5e658c2a@pumpkin> <20260118160125.82f645575f8327651be95070@linux-foundation.org>
 <20260119093339.024f8d57@pumpkin> <CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>
In-Reply-To: <CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 11:33:29 +0100
X-Gm-Features: AZwV_Qj7MK-0jI2uHicn43BCs2CIlmULheMBZtLZ1dlcFHqXSFz80ctgroMxt9Y
Message-ID: <CANn89i+goL82KC8uQoaNKxh=ap_16p7v1AAay1b2ekZAhPjEQg@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Jan 19, 2026 at 10:33=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 18 Jan 2026 16:01:25 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > On Sun, 18 Jan 2026 22:58:02 +0000 David Laight <david.laight.linux@g=
mail.com> wrote:
> > >
> > > > > mm/ alone has 74 __always_inlines, none are documented, I don't k=
now
> > > > > why they're present, many are probably wrong.
> > > > >
> > > > > Shit, uninlining only __get_user_pages_locked does this:
> > > > >
> > > > >    text      data     bss     dec     hex filename
> > > > >  115703     14018      64  129785   1faf9 mm/gup.o
> > > > >  103866     13058      64  116988   1c8fc mm/gup.o-after
> > > >
> > > > The next questions are does anything actually run faster (either wa=
y),
> > > > and should anything at all be marked 'inline' rather than 'always_i=
nline'.
> > > >
> > > > After all, if you call a function twice (not in a loop) you may
> > > > want a real function in order to avoid I-cache misses.
> > >
> > > yup
> >
> > I had two adjacent strlen() calls in a bit of code, the first was an
> > array (in a structure) and gcc inlined the 'word at a time' code, the
> > second was a pointer and it called the library function.
> > That had to be sub-optimal...
> >
> > > > But I'm sure there is a lot of code that is 'inline_for_bloat' :-)
> > >
> > > ooh, can we please have that?
> >
> > Or 'inline_to_speed_up_benchmark' and the associated 'unroll this loop
> > because that must make it faster'.
> >
> > > I do think that every always_inline should be justified and commented=
,
> > > but I haven't been energetic about asking for that.
> >
> > Apart from the 4-line functions where it is clearly obvious.
> > Especially since the compiler can still decide to not-inline them
> > if they are only 'inline'.
> >
> > > A fun little project would be go through each one, figure out whether
> > > were good reasons and if not, just remove them and see if anyone
> > > explains why that was incorrect.
> >
> > It's not just always_inline, a lot of the inline are dubious.
> > Probably why the networking code doesn't like it.
>
> Many __always_inline came because of clang's reluctance to inline
> small things, even if the resulting code size is bigger and slower.
>
> It is a bit unclear, this seems to happen when callers are 'big
> enough'. noinstr (callers) functions are also a problem.
>
> Let's take the list_add() call from dev_gro_receive() : clang does not
> inline it, for some reason.
>
> After adding __always_inline to list_add() and __list_add() we have
> smaller and more efficient code,
> for real workloads, not only benchmarks.
>
> $ scripts/bloat-o-meter -t net/core/gro.o.old net/core/gro.o.new
> add/remove: 2/4 grow/shrink: 2/1 up/down: 86/-130 (-44)
> Function                                     old     new   delta
> dev_gro_receive                             1795    1845     +50
> .Ltmp93                                        -      16     +16
> .Ltmp89                                        -      16     +16
> napi_gro_frags                               968     972      +4
> .Ltmp94                                       16       -     -16
> .Ltmp90                                       16       -     -16
> .Ltmp83                                       16       -     -16
> .Ltmp0                                      8396    8364     -32
> list_add                                      50       -     -50
>
> Over the whole kernel (and also using __always_inline for
> list_add_tail(), __list_del(), list_del()) we have a similar outcome:
>
> $ size vmlinux.old vmlinux.new
>    text    data     bss     dec     hex filename
> 39037635 23688605 4254712 66980952 3fe0c58 vmlinux.old
> 39035644 23688605 4254712 66978961 3fe0491 vmlinux.new
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 2/6 grow/shrink: 103/52 up/down: 6179/-6473 (-294)
> Function                                     old     new   delta
> __list_del_entry                               -     672    +672

Ah, and of course after adding __always_inline to __list_del_entry ()
as well we have something even better.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 1/6 grow/shrink: 105/51 up/down: 5838/-6464 (-626)
Function                                     old     new   delta
__do_semtimedop                             1819    2204    +385
tracer_alloc_buffers                         760     920    +160
__bmc_get_device_id                         3332    3486    +154
power_supply_register_extension              540     692    +152
ext4_orphan_add                             1122    1254    +132
madvise_cold_or_pageout_pte_range           2202    2328    +126
lru_lazyfree                                 784     906    +122
iommu_sva_bind_device                        744     865    +121
copy_page_range                            12353   12473    +120
psi_trigger_create                           767     886    +119
srcu_gp_start_if_needed                     1440    1548    +108
fanout_add                                   996    1101    +105
seccomp_notify_ioctl                        1882    1986    +104
mlock_folio_batch                           3137    3234     +97
kvm_dev_ioctl                               1507    1599     +92
handle_userfault                            2035    2118     +83
relay_open                                   681     761     +80
input_register_device                       1602    1680     +78
__iommu_probe_device                        1203    1279     +76
spi_register_controller                     1748    1823     +75
copy_process                                4112    4186     +74
newseg                                       825     898     +73
optimize_kprobe                              210     282     +72
do_msgsnd                                   1290    1362     +72
iscsi_queuecommand                           948    1019     +71
hci_register_dev                             667     737     +70
rdtgroup_mkdir                              1500    1569     +69
p9_read_work                                 961    1030     +69
tcf_register_action                          518     586     +68
mntput_no_expire_slowpath                    603     669     +66
netdev_run_todo                             1341    1405     +64
memcg_write_event_control                   1083    1147     +64
handle_one_recv_msg                         3307    3371     +64
btf_module_notify                           1669    1733     +64
tcf_mirred_init                             1229    1292     +63
register_stat_tracer                         340     403     +63
qdisc_get_stab                               596     658     +62
io_submit_one                               2056    2117     +61
fuse_dev_do_read                            1186    1247     +61
bpf_map_offload_map_alloc                    622     683     +61
zswap_setup                                  584     644     +60
register_acpi_bus_type                       109     169     +60
ipv6_add_addr                               1007    1067     +60
mraid_mm_register_adp                       1379    1438     +59
register_ife_op                              230     288     +58
perf_event_alloc                            2591    2649     +58
intel_iommu_domain_alloc_nested              498     556     +58
do_msgrcv                                   1536    1593     +57
lru_deactivate_file                         1280    1336     +56
fib_create_info                             2567    2623     +56
acpi_device_add                              859     915     +56
iscsi_register_transport                     533     588     +55
ext4_register_li_request                     448     503     +55
net_devmem_bind_dmabuf                      1036    1088     +52
init_one_iommu                               309     360     +51
shmem_get_folio_gfp                         1379    1429     +50
dev_gro_receive                             1795    1845     +50
.Ltmp68                                      160     208     +48
.Ltmp337                                      48      96     +48
.Ltmp204                                      48      96     +48
vmemmap_remap_pte                            499     546     +47
dm_get_device                                501     548     +47
vfs_move_mount                               509     555     +46
intel_nested_attach_dev                      391     435     +44
fw_devlink_dev_sync_state                    212     255     +43
bond_ipsec_add_sa                            406     447     +41
bd_link_disk_holder                          459     499     +40
bcm_tx_setup                                1414    1454     +40
devl_linecard_create                         401     440     +39
copy_tree                                    677     716     +39
fscrypt_setup_encryption_info               1479    1517     +38
region_del                                   631     668     +37
devlink_nl_rate_new_doit                     501     536     +35
__down_common                                549     583     +34
__softirqentry_text_end                        -      32     +32
.Ltmp57                                       48      80     +32
.Ltmp126                                      48      80     +32
ipmi_create_user                             411     442     +31
pci_register_host_bridge                    1675    1705     +30
move_cluster                                 160     184     +24
isolate_migratepages_block                  4113    4136     +23
clk_notifier_register                        474     489     +15
bpf_event_notify                             311     326     +15
dm_register_path_selector                    245     256     +11
bpf_crypto_register_type                     209     220     +11
usb_driver_set_configuration                 232     242     +10
parse_gate_list                              912     921      +9
devl_rate_leaf_create                        266     274      +8
bt_accept_enqueue                            465     473      +8
__flush_workqueue                           1233    1240      +7
dev_forward_change                           772     778      +6
thermal_add_hwmon_sysfs                      861     865      +4
set_node_memory_tier                        1027    1031      +4
napi_gro_frags                               968     972      +4
mei_cl_notify_request                       1067    1071      +4
mb_cache_shrink                              447     451      +4
kfence_guarded_free                          764     768      +4
blk_mq_try_issue_directly                    606     610      +4
__neigh_update                              2452    2456      +4
__folio_freeze_and_split_unmapped           3198    3202      +4
rwsem_down_write_slowpath                   1595    1598      +3
eventfs_create_dir                           477     480      +3
alloc_vmap_area                             1967    1970      +3
unix_add_edges                               618     620      +2
hid_connect                                 1529    1530      +1
dwc_prep_dma_memcpy                          637     638      +1
scsi_eh_test_devices                         700     699      -1
acpi_extract_power_resources                 559     558      -1
deactivate_slab                              758     756      -2
__team_options_change_check                  220     218      -2
sock_map_update_common                       524     521      -3
rcu_nocb_gp_kthread                         2710    2707      -3
memsw_cgroup_usage_register_event             19      16      -3
kthread                                      564     561      -3
st_add_path                                  457     453      -4
flow_block_cb_setup_simple                   543     539      -4
ep_try_send_events                           875     871      -4
elv_register                                 524     520      -4
__mptcp_move_skbs_from_subflow              1318    1314      -4
__check_limbo                                460     456      -4
__bpf_list_add                               277     273      -4
trim_marked                                  375     370      -5
megaraid_mbox_runpendq                       345     340      -5
ipmi_timeout_work                           1813    1808      -5
handle_new_recv_msgs                         419     414      -5
mei_cl_send_disconnect                       186     180      -6
mei_cl_send_connect                          186     180      -6
mptcp_sendmsg                               1776    1769      -7
deferred_split_folio                         561     554      -7
pcibios_allocate_resources                   879     871      -8
find_css_set                                1690    1682      -8
af_alg_sendmsg                              2384    2376      -8
posixtimer_send_sigqueue                     950     939     -11
mei_irq_write_handler                       1350    1338     -12
dpm_prepare                                 1173    1161     -12
dpll_xa_ref_pin_add                          679     667     -12
css_set_move_task                            513     501     -12
cache_mark                                   583     571     -12
scsi_queue_rq                               3449    3434     -15
mtd_queue_rq                                1068    1053     -15
link_css_set                                 323     308     -15
key_garbage_collector                       1119    1104     -15
do_dma_probe                                1664    1649     -15
configfs_new_dirent                          306     290     -16
.Ltmp69                                      208     192     -16
xfrm_state_walk                              677     660     -17
__dpll_pin_register                          761     742     -19
i2c_do_add_adapter                          1018     998     -20
complete_io                                  421     401     -20
fsnotify_insert_event                        390     368     -22
scsi_eh_ready_devs                          3026    2997     -29
.Ltmp71                                      128      96     -32
.Ltmp58                                      128      96     -32
.Ltmp127                                      80      48     -32
migrate_pages_batch                         4623    4584     -39
.Ltmp338                                      96      48     -48
.Ltmp205                                      96      48     -48
__pfx_list_del                               256       -    -256
__pfx_list_add_tail                          384       -    -384
__pfx_list_add                               656       -    -656
list_del                                     944       -    -944
list_add_tail                               1360       -   -1360
list_add                                    2212       -   -2212
Total: Before=3D25509319, After=3D25508693, chg -0.00%

