Return-Path: <netdev+bounces-170689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB4A499B8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA083A9961
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC726A1CB;
	Fri, 28 Feb 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCMBOVPu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5831A3BD7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746790; cv=none; b=OChUO0k9IkQLLBk8FwtbrgSy5zZoC/tYLjzWhf5TKNwhS+KH70a2ljGUUvr9fIt5J5Wn7TCXMgHjURTlFPcEKMAdguIBL8zwsgmh8Wnz3pE1SjYX4FuZwaY3F1DN3eZ66CeHzfL7jvZSvgozFCfWvp67TSqSl8VWGZqSFWlQn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746790; c=relaxed/simple;
	bh=mP1rMoOApiNkmA7fDw//U+k2M+ObeEMISj2+tCzviEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qar8x+EoROkmzwDjHaPDVB9q1osS4tJ1Dn8PkVBI0wSTVdUM+p+rpjws/LXIuEMLrqKpg29CxPqUvseHgWDm6OBbzS2ei+czDwgAoCbQ6YLao6xfto9+gBciX2MWBHN5goC2bBrv2u94pzWCYV6zomPW78/D4qIdKHRIiqGINa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCMBOVPu; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8670fd79990so787357241.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740746787; x=1741351587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQRgrsDzVIknUEE7rhDu5Vvh/UhahpMz4ezGu0waEaI=;
        b=lCMBOVPuTb1crewsSMl79IoAhlVDAHLrtSDAGAPOH/dKMreQxucdrtC6QfJY2yhdam
         UQUWX4eqzSCP+AbL3A6aoUGxobQhwFA1+1NCfZvJpzJcNiMDdnGPGk1vDxXgm6Fl0rrQ
         +B6MXcBwlWqdNjvpemYvp/dZEnUBrpGbpGB8z8NK4CJeyCeGFExDlInhIdDYua0VLaUh
         vJ94/gji7UzIsNHnMmyjeB48OBGra15oZ48Uzl0hQAUa5alIpKk+eThd6WmXLDV6GTfC
         EYCyK1kXWeBu989ppj/yrWTDHmQH9/Y4kTtVqS/8tEWQqnsSmdTbkoFBUwK+y7onyzNo
         ZtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746787; x=1741351587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQRgrsDzVIknUEE7rhDu5Vvh/UhahpMz4ezGu0waEaI=;
        b=KLU8Om07DP9M6gz3nMAF3EWqy3psuG7/XtaDyngGPBxgFMN7gGbk8iEVzC0csDqclA
         jPzMPWUd0MelxEKNaXM9kuNiADzdaGYTrP05GGjvcqefrzoYu4BCE8eYJ22WAFWiYlEg
         GwNjE0psP/tJBxGUwnxmkR/aJKyGGfS/++9tKPnnRB8GbABLH97bZePG8MC/VAQxX7X2
         6CrAWRdIZ03/erb+PvTJnEfvmmWIhaF7k5FYuXJa7SsqyftFavQxQqnnYsSL6DekCF2/
         BjUHHQ2YtIOuOl0azoJL9h24BBGtZYshbxxWC2ZA7m9VjM5GkDlZVl5PGo5S1siUR2N1
         u70A==
X-Gm-Message-State: AOJu0YwxNgoF0U8FifUCM3ZbqhPv7CLfSgW+UU0wv9KYs2rHSzJbf6UE
	yvEJ0505fn7zivII5XuMSeZRp1KO6/V/v4UHQUwmfHg4QkpeW2v9tezneD6pvwjUcLutekIsSka
	3LoR6UvhAMAfBn8WXOVLQRiNgxktETdq9su0ZFg==
X-Gm-Gg: ASbGncsVl6fm7Ro06m58FoiAjfQhNPcgTAOzMG8S2ZxHb61yAgB4NMH5RiuFOD0QZEx
	uXf7B2o3IowHrABufG2bcLbAFL63o510KPNuK0Y//RoF4rbCd1aBRoqXHCDXGAZIuE/b7gKMs0Y
	yuQ5pXtw==
X-Google-Smtp-Source: AGHT+IFhaiwhHpPYHahihIgcf5rRxTI6zv4ltyn4JZ4ZQJBEthjMQp8NmVjl/6no5uSgT1ZdX6rQj0DCr2Knn6cd+M4=
X-Received: by 2002:a05:6102:440b:b0:4bb:dfd8:418f with SMTP id
 ada2fe7eead31-4c044f481c5mr1931125137.23.1740746786365; Fri, 28 Feb 2025
 04:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227164129.1201164-1-razor@blackwall.org>
In-Reply-To: <20250227164129.1201164-1-razor@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Feb 2025 13:46:15 +0100
X-Gm-Features: AQ5f1JoIlytsp-XG_hZhlGK_bkmIWIJomaXnsdgE79pvyAuiSmWuCDpXq2zrYaA
Message-ID: <CAA85sZva1SbT_HDbAHgZEDeCgjcbTX_rBzj-RZQmsvST3Ky3LA@mail.gmail.com>
Subject: Re: [PATCH net] be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Actually, while you might already have realized this, I didn't quite
understand how important this fix seems to be....

From another machine i found this:
[l=C3=B6r feb 22 23:46:32 2025] mlx5_core 0000:02:00.1 enp2s0f1np1: hw csum=
 failure
[l=C3=B6r feb 22 23:46:32 2025] skb len=3D2488 headroom=3D78 headlen=3D1480=
 tailroom=3D0
                            mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=
=3D98
                            shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D1452
type=3D393216 segs=3D2))
                            csum(0x2baef95d start=3D63837 offset=3D11182
ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
                            hash(0xb9a84019 sw=3D0 l4=3D1) proto=3D0x0800
pkttype=3D0 iif=3D8
                            priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_al=
l=3D0x0
                            encapsulation=3D0 inner(proto=3D0x0000, mac=3D0=
,
net=3D0, trans=3D0)
[l=C3=B6r feb 22 23:46:32 2025] dev name=3Denp2s0f1np1 feat=3D0x0e12a1c21cd=
14ba9

And:
[l=C3=B6r feb 22 23:46:33 2025] skb fraglist:
[l=C3=B6r feb 22 23:46:33 2025] skb len=3D1008 headroom=3D106 headlen=3D100=
8 tailroom=3D38
                            mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=
=3D98
                            shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0
type=3D0 segs=3D0))
                            csum(0x86f9 start=3D34553 offset=3D0
ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
                            hash(0xb9a84019 sw=3D0 l4=3D1) proto=3D0x0800
pkttype=3D0 iif=3D0
                            priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_al=
l=3D0x0
                            encapsulation=3D0 inner(proto=3D0x0000, mac=3D0=
,
net=3D0, trans=3D0)
[l=C3=B6r feb 22 23:46:33 2025] dev name=3Denp2s0f1np1 feat=3D0x0e12a1c21cd=
14ba9

Including:
[l=C3=B6r feb 22 23:46:34 2025] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not
tainted 6.13.4 #449
[l=C3=B6r feb 22 23:46:34 2025] Hardware name: Supermicro Super
Server/A2SDi-12C-HLN4F, BIOS 1.9a 12/25/2023
[l=C3=B6r feb 22 23:46:34 2025] Call Trace:
[l=C3=B6r feb 22 23:46:34 2025]  <IRQ>
[l=C3=B6r feb 22 23:46:34 2025]  dump_stack_lvl+0x47/0x70
[l=C3=B6r feb 22 23:46:34 2025]  __skb_checksum_complete+0xda/0xf0
[l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_csum_partial_ext+0x10/0x10
[l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_csum_block_add_ext+0x10/0x10
[l=C3=B6r feb 22 23:46:34 2025]  nf_conntrack_udp_packet+0x171/0x260
[l=C3=B6r feb 22 23:46:34 2025]  nf_conntrack_in+0x391/0x590
[l=C3=B6r feb 22 23:46:34 2025]  nf_hook_slow+0x3c/0xf0
[l=C3=B6r feb 22 23:46:34 2025]  nf_hook_slow_list+0x70/0xf0
[l=C3=B6r feb 22 23:46:34 2025]  ip_sublist_rcv+0x1ee/0x200
[l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_ip_rcv_finish+0x10/0x10
[l=C3=B6r feb 22 23:46:34 2025]  ip_list_rcv+0xf8/0x130
[l=C3=B6r feb 22 23:46:34 2025]  __netif_receive_skb_list_core+0x24c/0x270
[l=C3=B6r feb 22 23:46:34 2025]  netif_receive_skb_list_internal+0x18f/0x2b=
0
[l=C3=B6r feb 22 23:46:34 2025]  ? mlx5e_handle_rx_cqe_mpwrq+0x116/0x210
[l=C3=B6r feb 22 23:46:34 2025]  napi_complete_done+0x65/0x260
[l=C3=B6r feb 22 23:46:34 2025]  mlx5e_napi_poll+0x172/0x760
[l=C3=B6r feb 22 23:46:34 2025]  __napi_poll+0x26/0x160
[l=C3=B6r feb 22 23:46:34 2025]  net_rx_action+0x173/0x300
[l=C3=B6r feb 22 23:46:34 2025]  ? notifier_call_chain+0x54/0xc0
[l=C3=B6r feb 22 23:46:34 2025]  ? atomic_notifier_call_chain+0x30/0x40
[l=C3=B6r feb 22 23:46:34 2025]  handle_softirqs+0xcd/0x270
[l=C3=B6r feb 22 23:46:34 2025]  irq_exit_rcu+0x85/0xa0
[l=C3=B6r feb 22 23:46:34 2025]  common_interrupt+0x81/0xa0
[l=C3=B6r feb 22 23:46:34 2025]  </IRQ>
[l=C3=B6r feb 22 23:46:34 2025]  <TASK>
[l=C3=B6r feb 22 23:46:34 2025]  asm_common_interrupt+0x22/0x40
[l=C3=B6r feb 22 23:46:34 2025] RIP: 0010:cpuidle_enter_state+0xbc/0x430
[l=C3=B6r feb 22 23:46:34 2025] Code: 77 02 00 00 e8 65 31 ec fe e8 60 f8
ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a1 68 eb fe 45 84 ff 0f 85 49
02 00 00 fb 45 85 f6 <0f> 88 8d 01 00 00 49 63 ce 4c 8b 14 24 48 8d 04
49 48 8d 14 81 48
[l=C3=B6r feb 22 23:46:34 2025] RSP: 0018:ffffb504000b7e88 EFLAGS: 00000202
[l=C3=B6r feb 22 23:46:34 2025] RAX: ffff9c0a2fa40000 RBX: ffff9c0a2fa76e60
RCX: 0000000000000000
[l=C3=B6r feb 22 23:46:34 2025] RDX: 0000252e1dcfee30 RSI: fffffff3c1a65ecc
RDI: 0000000000000000
[l=C3=B6r feb 22 23:46:34 2025] RBP: 0000000000000002 R08: 0000000000000000
R09: 00000000000001f6
[l=C3=B6r feb 22 23:46:34 2025] R10: 0000000000000018 R11: ffff9c0a2fa6c3ac
R12: ffffffffaac2de60
[l=C3=B6r feb 22 23:46:34 2025] R13: 0000252e1dcfee30 R14: 0000000000000002
R15: 0000000000000000
[l=C3=B6r feb 22 23:46:34 2025]  ? cpuidle_enter_state+0xaf/0x430
[l=C3=B6r feb 22 23:46:34 2025]  cpuidle_enter+0x24/0x40
[l=C3=B6r feb 22 23:46:34 2025]  do_idle+0x16e/0x1b0
[l=C3=B6r feb 22 23:46:34 2025]  cpu_startup_entry+0x20/0x30
[l=C3=B6r feb 22 23:46:34 2025]  start_secondary+0xf3/0x100
[l=C3=B6r feb 22 23:46:34 2025]  common_startup_64+0x13e/0x148
[l=C3=B6r feb 22 23:46:34 2025]  </TASK>
---

Asking gemini for help identified the machine in the basement as the
culprit - so it seems like it could send corrupt data - i haven't had
a closer look though

On Thu, Feb 27, 2025 at 5:41=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> Partially revert commit b71724147e73 ("be2net: replace polling with
> sleeping in the FW completion path") w.r.t mcc mutex it introduces and th=
e
> use of usleep_range. The be2net be_ndo_bridge_getlink() callback is
> called with rcu_read_lock, so this code has been broken for a long time.
> Both the mutex_lock and the usleep_range can cause the issue Ian Kumlien
> reported[1]. The call path is:
> be_ndo_bridge_getlink -> be_cmd_get_hsw_config -> be_mcc_notify_wait ->
> be_mcc_wait_compl -> usleep_range()
>
> [1] https://lore.kernel.org/netdev/CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+=
jWrMtXmwqefGA@mail.gmail.com/
>
> Tested-by: Ian Kumlien <ian.kumlien@gmail.com>
> Fixes: b71724147e73 ("be2net: replace polling with sleeping in the FW com=
pletion path")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Note I haven't included the original patch author in the CC list because
> the email bounces.
>
>  drivers/net/ethernet/emulex/benet/be.h      |   2 +-
>  drivers/net/ethernet/emulex/benet/be_cmds.c | 197 ++++++++++----------
>  drivers/net/ethernet/emulex/benet/be_main.c |   2 +-
>  3 files changed, 100 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/etherne=
t/emulex/benet/be.h
> index e48b861e4ce1..270ff9aab335 100644
> --- a/drivers/net/ethernet/emulex/benet/be.h
> +++ b/drivers/net/ethernet/emulex/benet/be.h
> @@ -562,7 +562,7 @@ struct be_adapter {
>         struct be_dma_mem mbox_mem_alloced;
>
>         struct be_mcc_obj mcc_obj;
> -       struct mutex mcc_lock;  /* For serializing mcc cmds to BE card */
> +       spinlock_t mcc_lock;    /* For serializing mcc cmds to BE card */
>         spinlock_t mcc_cq_lock;
>
>         u16 cfg_num_rx_irqs;            /* configured via set-channels */
> diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/et=
hernet/emulex/benet/be_cmds.c
> index 61adcebeef01..51b8377edd1d 100644
> --- a/drivers/net/ethernet/emulex/benet/be_cmds.c
> +++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
> @@ -575,7 +575,7 @@ int be_process_mcc(struct be_adapter *adapter)
>  /* Wait till no more pending mcc requests are present */
>  static int be_mcc_wait_compl(struct be_adapter *adapter)
>  {
> -#define mcc_timeout            12000 /* 12s timeout */
> +#define mcc_timeout            120000 /* 12s timeout */
>         int i, status =3D 0;
>         struct be_mcc_obj *mcc_obj =3D &adapter->mcc_obj;
>
> @@ -589,7 +589,7 @@ static int be_mcc_wait_compl(struct be_adapter *adapt=
er)
>
>                 if (atomic_read(&mcc_obj->q.used) =3D=3D 0)
>                         break;
> -               usleep_range(500, 1000);
> +               udelay(100);
>         }
>         if (i =3D=3D mcc_timeout) {
>                 dev_err(&adapter->pdev->dev, "FW not responding\n");
> @@ -866,7 +866,7 @@ static bool use_mcc(struct be_adapter *adapter)
>  static int be_cmd_lock(struct be_adapter *adapter)
>  {
>         if (use_mcc(adapter)) {
> -               mutex_lock(&adapter->mcc_lock);
> +               spin_lock_bh(&adapter->mcc_lock);
>                 return 0;
>         } else {
>                 return mutex_lock_interruptible(&adapter->mbox_lock);
> @@ -877,7 +877,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
>  static void be_cmd_unlock(struct be_adapter *adapter)
>  {
>         if (use_mcc(adapter))
> -               return mutex_unlock(&adapter->mcc_lock);
> +               return spin_unlock_bh(&adapter->mcc_lock);
>         else
>                 return mutex_unlock(&adapter->mbox_lock);
>  }
> @@ -1047,7 +1047,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapte=
r, u8 *mac_addr,
>         struct be_cmd_req_mac_query *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1076,7 +1076,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapte=
r, u8 *mac_addr,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1088,7 +1088,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, con=
st u8 *mac_addr,
>         struct be_cmd_req_pmac_add *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1113,7 +1113,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, con=
st u8 *mac_addr,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         if (base_status(status) =3D=3D MCC_STATUS_UNAUTHORIZED_REQUEST)
>                 status =3D -EPERM;
> @@ -1131,7 +1131,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32=
 if_id, int pmac_id, u32 dom)
>         if (pmac_id =3D=3D -1)
>                 return 0;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1151,7 +1151,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32=
 if_id, int pmac_id, u32 dom)
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1414,7 +1414,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
>         struct be_dma_mem *q_mem =3D &rxq->dma_mem;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1444,7 +1444,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1508,7 +1508,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, =
struct be_queue_info *q)
>         struct be_cmd_req_q_destroy *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1525,7 +1525,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, =
struct be_queue_info *q)
>         q->created =3D false;
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1593,7 +1593,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, st=
ruct be_dma_mem *nonemb_cmd)
>         struct be_cmd_req_hdr *hdr;
>         int status =3D 0;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1621,7 +1621,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, st=
ruct be_dma_mem *nonemb_cmd)
>         adapter->stats_cmd_sent =3D true;
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1637,7 +1637,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *a=
dapter,
>                             CMD_SUBSYSTEM_ETH))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1660,7 +1660,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *a=
dapter,
>         adapter->stats_cmd_sent =3D true;
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1697,7 +1697,7 @@ int be_cmd_link_status_query(struct be_adapter *ada=
pter, u16 *link_speed,
>         struct be_cmd_req_link_status *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         if (link_status)
>                 *link_status =3D LINK_DOWN;
> @@ -1736,7 +1736,7 @@ int be_cmd_link_status_query(struct be_adapter *ada=
pter, u16 *link_speed,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1747,7 +1747,7 @@ int be_cmd_get_die_temperature(struct be_adapter *a=
dapter)
>         struct be_cmd_req_get_cntl_addnl_attribs *req;
>         int status =3D 0;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1762,7 +1762,7 @@ int be_cmd_get_die_temperature(struct be_adapter *a=
dapter)
>
>         status =3D be_mcc_notify(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1811,7 +1811,7 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter,=
 u32 buf_len, void *buf)
>         if (!get_fat_cmd.va)
>                 return -ENOMEM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         while (total_size) {
>                 buf_size =3D min(total_size, (u32)60 * 1024);
> @@ -1849,9 +1849,9 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter,=
 u32 buf_len, void *buf)
>                 log_offset +=3D buf_size;
>         }
>  err:
> +       spin_unlock_bh(&adapter->mcc_lock);
>         dma_free_coherent(&adapter->pdev->dev, get_fat_cmd.size,
>                           get_fat_cmd.va, get_fat_cmd.dma);
> -       mutex_unlock(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1862,7 +1862,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
>         struct be_cmd_req_get_fw_version *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1885,7 +1885,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
>                         sizeof(adapter->fw_on_flash));
>         }
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1899,7 +1899,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *a=
dapter,
>         struct be_cmd_req_modify_eq_delay *req;
>         int status =3D 0, i;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1922,7 +1922,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *a=
dapter,
>
>         status =3D be_mcc_notify(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1949,7 +1949,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, =
u32 if_id, u16 *vtag_array,
>         struct be_cmd_req_vlan_config *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -1971,7 +1971,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, =
u32 if_id, u16 *vtag_array,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -1982,7 +1982,7 @@ static int __be_cmd_rx_filter(struct be_adapter *ad=
apter, u32 flags, u32 value)
>         struct be_cmd_req_rx_filter *req =3D mem->va;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2015,7 +2015,7 @@ static int __be_cmd_rx_filter(struct be_adapter *ad=
apter, u32 flags, u32 value)
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2046,7 +2046,7 @@ int be_cmd_set_flow_control(struct be_adapter *adap=
ter, u32 tx_fc, u32 rx_fc)
>                             CMD_SUBSYSTEM_COMMON))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2066,7 +2066,7 @@ int be_cmd_set_flow_control(struct be_adapter *adap=
ter, u32 tx_fc, u32 rx_fc)
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         if (base_status(status) =3D=3D MCC_STATUS_FEATURE_NOT_SUPPORTED)
>                 return  -EOPNOTSUPP;
> @@ -2085,7 +2085,7 @@ int be_cmd_get_flow_control(struct be_adapter *adap=
ter, u32 *tx_fc, u32 *rx_fc)
>                             CMD_SUBSYSTEM_COMMON))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2108,7 +2108,7 @@ int be_cmd_get_flow_control(struct be_adapter *adap=
ter, u32 *tx_fc, u32 *rx_fc)
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2189,7 +2189,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u=
8 *rsstable,
>         if (!(be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
>                 return 0;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2214,7 +2214,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u=
8 *rsstable,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2226,7 +2226,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adap=
ter, u8 port_num,
>         struct be_cmd_req_enable_disable_beacon *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2247,7 +2247,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adap=
ter, u8 port_num,
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2258,7 +2258,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adap=
ter, u8 port_num, u32 *state)
>         struct be_cmd_req_get_beacon_state *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2282,7 +2282,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adap=
ter, u8 port_num, u32 *state)
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2306,7 +2306,7 @@ int be_cmd_read_port_transceiver_data(struct be_ada=
pter *adapter,
>                 return -ENOMEM;
>         }
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2328,7 +2328,7 @@ int be_cmd_read_port_transceiver_data(struct be_ada=
pter *adapter,
>                 memcpy(data, resp->page_data + off, len);
>         }
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
>         return status;
>  }
> @@ -2345,7 +2345,7 @@ static int lancer_cmd_write_object(struct be_adapte=
r *adapter,
>         void *ctxt =3D NULL;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>         adapter->flash_status =3D 0;
>
>         wrb =3D wrb_from_mccq(adapter);
> @@ -2387,7 +2387,7 @@ static int lancer_cmd_write_object(struct be_adapte=
r *adapter,
>         if (status)
>                 goto err_unlock;
>
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
>                                          msecs_to_jiffies(60000)))
> @@ -2406,7 +2406,7 @@ static int lancer_cmd_write_object(struct be_adapte=
r *adapter,
>         return status;
>
>  err_unlock:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2460,7 +2460,7 @@ static int lancer_cmd_delete_object(struct be_adapt=
er *adapter,
>         struct be_mcc_wrb *wrb;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2478,7 +2478,7 @@ static int lancer_cmd_delete_object(struct be_adapt=
er *adapter,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2491,7 +2491,7 @@ int lancer_cmd_read_object(struct be_adapter *adapt=
er, struct be_dma_mem *cmd,
>         struct lancer_cmd_resp_read_object *resp;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2525,7 +2525,7 @@ int lancer_cmd_read_object(struct be_adapter *adapt=
er, struct be_dma_mem *cmd,
>         }
>
>  err_unlock:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2537,7 +2537,7 @@ static int be_cmd_write_flashrom(struct be_adapter =
*adapter,
>         struct be_cmd_write_flashrom *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>         adapter->flash_status =3D 0;
>
>         wrb =3D wrb_from_mccq(adapter);
> @@ -2562,7 +2562,7 @@ static int be_cmd_write_flashrom(struct be_adapter =
*adapter,
>         if (status)
>                 goto err_unlock;
>
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
>                                          msecs_to_jiffies(40000)))
> @@ -2573,7 +2573,7 @@ static int be_cmd_write_flashrom(struct be_adapter =
*adapter,
>         return status;
>
>  err_unlock:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -2584,7 +2584,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *=
adapter, u8 *flashed_crc,
>         struct be_mcc_wrb *wrb;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -2611,7 +2611,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *=
adapter, u8 *flashed_crc,
>                 memcpy(flashed_crc, req->crc, 4);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3217,7 +3217,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adap=
ter, u8 *mac,
>         struct be_cmd_req_acpi_wol_magic_config *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3234,7 +3234,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adap=
ter, u8 *mac,
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3249,7 +3249,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter,=
 u8 port_num,
>                             CMD_SUBSYSTEM_LOWLEVEL))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3272,7 +3272,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter,=
 u8 port_num,
>         if (status)
>                 goto err_unlock;
>
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
>                                          msecs_to_jiffies(SET_LB_MODE_TIM=
EOUT)))
> @@ -3281,7 +3281,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter,=
 u8 port_num,
>         return status;
>
>  err_unlock:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3298,7 +3298,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter=
, u32 port_num,
>                             CMD_SUBSYSTEM_LOWLEVEL))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3324,7 +3324,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter=
, u32 port_num,
>         if (status)
>                 goto err;
>
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>
>         wait_for_completion(&adapter->et_cmd_compl);
>         resp =3D embedded_payload(wrb);
> @@ -3332,7 +3332,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter=
, u32 port_num,
>
>         return status;
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3348,7 +3348,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter,=
 u64 pattern,
>                             CMD_SUBSYSTEM_LOWLEVEL))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3382,7 +3382,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter,=
 u64 pattern,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3393,7 +3393,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adap=
ter,
>         struct be_cmd_req_seeprom_read *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3409,7 +3409,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adap=
ter,
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3424,7 +3424,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
>                             CMD_SUBSYSTEM_COMMON))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3469,7 +3469,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
>         }
>         dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3479,7 +3479,7 @@ static int be_cmd_set_qos(struct be_adapter *adapte=
r, u32 bps, u32 domain)
>         struct be_cmd_req_set_qos *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3499,7 +3499,7 @@ static int be_cmd_set_qos(struct be_adapter *adapte=
r, u32 bps, u32 domain)
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3611,7 +3611,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *ada=
pter, u32 *privilege,
>         struct be_cmd_req_get_fn_privileges *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3643,7 +3643,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *ada=
pter, u32 *privilege,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3655,7 +3655,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *ada=
pter, u32 privileges,
>         struct be_cmd_req_set_fn_privileges *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3675,7 +3675,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *ada=
pter, u32 privileges,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3707,7 +3707,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *ada=
pter, u8 *mac,
>                 return -ENOMEM;
>         }
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3771,7 +3771,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *ada=
pter, u8 *mac,
>         }
>
>  out:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         dma_free_coherent(&adapter->pdev->dev, get_mac_list_cmd.size,
>                           get_mac_list_cmd.va, get_mac_list_cmd.dma);
>         return status;
> @@ -3831,7 +3831,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter,=
 u8 *mac_array,
>         if (!cmd.va)
>                 return -ENOMEM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3853,7 +3853,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter,=
 u8 *mac_array,
>
>  err:
>         dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3889,7 +3889,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapte=
r, u16 pvid,
>                             CMD_SUBSYSTEM_COMMON))
>                 return -EPERM;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3930,7 +3930,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapte=
r, u16 pvid,
>         status =3D be_mcc_notify_wait(adapter);
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -3944,7 +3944,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapte=
r, u16 *pvid,
>         int status;
>         u16 vid;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -3991,7 +3991,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapte=
r, u16 *pvid,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -4190,7 +4190,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapte=
r *adapter,
>         struct be_cmd_req_set_ext_fat_caps *req;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -4206,7 +4206,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapte=
r *adapter,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -4684,7 +4684,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter,=
 u32 iface, u8 op)
>         if (iface =3D=3D 0xFFFFFFFF)
>                 return -1;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -4701,7 +4701,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter,=
 u32 iface, u8 op)
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -4735,7 +4735,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, st=
ruct be_vf_cfg *vf_cfg,
>         struct be_cmd_resp_get_iface_list *resp;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -4756,7 +4756,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, st=
ruct be_vf_cfg *vf_cfg,
>         }
>
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -4850,7 +4850,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8=
 domain)
>         if (BEx_chip(adapter))
>                 return 0;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -4868,7 +4868,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8=
 domain)
>         req->enable =3D 1;
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -4941,7 +4941,7 @@ __be_cmd_set_logical_link_config(struct be_adapter =
*adapter,
>         u32 link_config =3D 0;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -4969,7 +4969,7 @@ __be_cmd_set_logical_link_config(struct be_adapter =
*adapter,
>
>         status =3D be_mcc_notify_wait(adapter);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -5000,8 +5000,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
>         struct be_mcc_wrb *wrb;
>         int status;
>
> -       if (mutex_lock_interruptible(&adapter->mcc_lock))
> -               return -1;
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -5039,7 +5038,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
>                 dev_info(&adapter->pdev->dev,
>                          "Adapter does not support HW error recovery\n");
>
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>
> @@ -5053,7 +5052,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_=
payload,
>         struct be_cmd_resp_hdr *resp;
>         int status;
>
> -       mutex_lock(&adapter->mcc_lock);
> +       spin_lock_bh(&adapter->mcc_lock);
>
>         wrb =3D wrb_from_mccq(adapter);
>         if (!wrb) {
> @@ -5076,7 +5075,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_=
payload,
>         memcpy(wrb_payload, resp, sizeof(*resp) + resp->response_length);
>         be_dws_le_to_cpu(wrb_payload, sizeof(*resp) + resp->response_leng=
th);
>  err:
> -       mutex_unlock(&adapter->mcc_lock);
> +       spin_unlock_bh(&adapter->mcc_lock);
>         return status;
>  }
>  EXPORT_SYMBOL(be_roce_mcc_cmd);
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/et=
hernet/emulex/benet/be_main.c
> index 875fe379eea2..3d2e21592119 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -5667,8 +5667,8 @@ static int be_drv_init(struct be_adapter *adapter)
>         }
>
>         mutex_init(&adapter->mbox_lock);
> -       mutex_init(&adapter->mcc_lock);
>         mutex_init(&adapter->rx_filter_lock);
> +       spin_lock_init(&adapter->mcc_lock);
>         spin_lock_init(&adapter->mcc_cq_lock);
>         init_completion(&adapter->et_cmd_compl);
>
> --
> 2.48.1
>

