Return-Path: <netdev+bounces-127757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C09765C3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5933BB2317D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F219E98B;
	Thu, 12 Sep 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="tEpjkT3e"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C319E981;
	Thu, 12 Sep 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133773; cv=none; b=M82x/qJ6o0eCnOj1hPf+Xka466rhsRSpAuKLk6P0sgmOoqippDld4AyZhKLVq58Ocz5EGfR6BrQdvdw8SA8bdkllqo9/fRRPHuU1RHBQBb8lW/Nnk1X0hcw3EKv3aYbv7L1c27MyFzsdDmuICtZT2HiCJNLr97o8+kcm+HmEYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133773; c=relaxed/simple;
	bh=0B/HTcZAjFJQ/TI2gZYoPjdvaxMxvzApfSEC+vNdUfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV2rIacatcv/AMN3aXvIdgvQ5b13sP1ZhAR5OnqW148/bsk1ES0gaMw6kd57ldjSTq9+h6nGCLFepxhlkZmcUjrG97sliJHA8ncaaNpv+nydE9q9GELJzezwPMApiYfiHB1YQiZo+PFxfFrev6wTcSjjG/fHQE3Qse1u4shD/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=tEpjkT3e; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726133720; x=1726738520; i=ps.report@gmx.net;
	bh=hvUwuCji2FVWW+lSXytJRqaFIqI73lvVq/rqcH0isKs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tEpjkT3eMCVn+uqnviql4xVq45/gmXweOJQKxu4Ak1uJshzATi6jxCsBgTxo4Spt
	 SBeqEL4EgItJ4tShEN4Ht8NMHm6rlHDhKb7q7eQiXp3bP0Rnty+JlcEPgqCje5Ese
	 ETcA1MyFAu83Ax6rmcZXKxKpLE+7dVA9IMyRZDLDOlrVaLB2tUkKg2TjMaR9Dbg0P
	 ngy5tEhl4OD9C97MPMEPfXt6VE+qo8J0xTHMO1+S6QCaxV9Wocr8j/8gSJtbOOgJP
	 XTxYA9mqXH5v491Ohlp+ZN9qr7GKfJY5gCpSSD5UHkPgmLW8jokC0TT2B0QN2j0rE
	 2pT2ra65RButXZC04g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.136]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1svXqj15nl-00DIiJ; Thu, 12
 Sep 2024 11:35:20 +0200
Date: Thu, 12 Sep 2024 11:35:18 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kai.heng.feng@canonical.com, chia-lin.kao@canonical.com,
 anthony.wong@canonical.com, kuan-ying.lee@canonical.com,
 chris.chiu@canonical.com
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
Message-ID: <20240912113518.5941b0cf@gmx.net>
In-Reply-To: <20240912071702.221128-1-en-wei.wu@canonical.com>
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5t4f8lAHgnAMeehsF/T2jDXsBATlVB+wehZLyQF51TDtIESMH5/
 DPHRQNUUtBpZtGkR/uTz/NMRya1hwxZonDcwpS8pJC43IP5uFXVM/3sHO7eBEdVTJh03ypg
 o2mZVwNDz+uNmaC/rNXYzcogxYVNh+NfjWM9u2TMMMPrRpJPUe9sFvPsxxjUjdo1REHqGiV
 /qMalDmVhQ7DoVXqa++GQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rTO7R1njQ20=;jXIBLPu1J88IO3iKqntBIN5UYZh
 tnCvSZJ6LWNoHISVvvO2euO2zNc1OYqe5iudFgkPAZgEtCLSOkSXUfWeh+y2TR6HboBdgNUAg
 Cfa8YcWfIOTvsp02pPoscFmr6Dfy8JYdGpjIEtYbpAiY2mx3ycoJ26m5z/qCG7yG4j92UcSqB
 fUbxCgpWlqWusDYMWoONA4fOo028h8wDLGDi+68bv4nJ5IdG4e5D8FdQgDqCNsgfndY5jlTPX
 NItKFeewKSRhQ44ZDIpSiOp/T0em6kRl4T9N+J3tRqmZyx2di/xmIO0+80dlVjsdwMdo4xV9G
 z5OsB/GTOXfeLMVCsEaNVc0+YS6PLSVukktEHyYwyQn57nTbEyCwmFHGNQL3MkZ5B2Oj8VpJZ
 fHwgRbkULItBmIhIlxDfEad8oRhFG9OznrHb7PrOqDkupoyDbDgh32o5moOlvFGNpfcLuWA10
 3Q6YTR/xciRfcPTLQ51JHcNlLBM/LkpW2XMA2H2pc+KGWKhS6Qw+4H/fEIFDJzMJcKZYwyW9o
 2anDPyrJm7ycOr/W8Tup5GOHW+4cX5GxlpR3DaVVg4bw6mBZqG0NlNxfzmmX5kyLBH9/BXjE1
 IIacJArtKFuaGn62Cfw3L4WEVmYQMv/FF5xzE3A6s9OzadEYEw+vGD5H6BmE+HCsYK/7sLSwo
 h1LcA5E2KPmq0yG/2SwDeMMqbjZ69BIOzJnmCkiGn9KqzrW2cFt2BT1N09kM46n2Byk6X9jsk
 QUKxUxbPbSQ2Oj5p6x2p+DGyYvfUFaPJPoTs+B7xC10ShSe2EpdmlCy+BeX4SNVIYaDCBCRHg
 AAtCbqxfzqnFW5NbLYMxD45QzI4WTV3J9o7xb9unLAVLs=

Hello *,

On Thu, 12 Sep 2024 15:17:02 +0800, En-Wei Wu <en-wei.wu@canonical.com> wr=
ote:

> When we use Intel WWAN with xfrm, our system always hangs after
> browsing websites for a few seconds. The error message shows that
> it is a slab-out-of-bounds error:
>
> [ 67.162014] BUG: KASAN: slab-out-of-bounds in xfrm_input+0x426e/0x6740
> [ 67.162030] Write of size 2 at addr ffff888156cb814b by task ksoftirqd/=
2/26
>
> [ 67.162043] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Not tainted 6.11.0-=
rc6-c763c4339688+ #2
> [ 67.162053] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS 1.15.0 =
07/15/2024
> [ 67.162058] Call Trace:
> [ 67.162062] <TASK>
> [ 67.162068] dump_stack_lvl+0x76/0xa0
> [ 67.162079] print_report+0xce/0x5f0
> [ 67.162088] ? xfrm_input+0x426e/0x6740
> [ 67.162096] ? kasan_complete_mode_report_info+0x26/0x200
> [ 67.162105] ? xfrm_input+0x426e/0x6740
> [ 67.162112] kasan_report+0xbe/0x110
> [ 67.162119] ? xfrm_input+0x426e/0x6740
> [ 67.162129] __asan_report_store_n_noabort+0x12/0x30
> [ 67.162138] xfrm_input+0x426e/0x6740
> [ 67.162149] ? __pfx_xfrm_input+0x10/0x10
> [ 67.162160] ? __kasan_check_read+0x11/0x20
> [ 67.162168] ? __call_rcu_common+0x3e7/0x15b0
> [ 67.162178] xfrm4_rcv_encap+0x214/0x470
> [ 67.162186] ? __xfrm4_udp_encap_rcv.part.0+0x3cd/0x560
> [ 67.162195] xfrm4_udp_encap_rcv+0xdd/0xf0
> [ 67.162203] udp_queue_rcv_one_skb+0x880/0x12f0
> [ 67.162212] udp_queue_rcv_skb+0x139/0xa90
> [ 67.162221] udp_unicast_rcv_skb+0x116/0x350
> [ 67.162229] __udp4_lib_rcv+0x213b/0x3410
> [ 67.162237] ? ldsem_down_write+0x211/0x4ed
> [ 67.162246] ? __pfx___udp4_lib_rcv+0x10/0x10
> [ 67.162254] ? __pfx_raw_local_deliver+0x10/0x10
> [ 67.162262] ? __pfx_cache_tag_flush_range_np+0x10/0x10
> [ 67.162273] udp_rcv+0x86/0xb0
> [ 67.162280] ip_protocol_deliver_rcu+0x152/0x380
> [ 67.162289] ip_local_deliver_finish+0x282/0x370
> [ 67.162296] ip_local_deliver+0x1a8/0x380
> [ 67.162303] ? __pfx_ip_local_deliver+0x10/0x10
> [ 67.162310] ? ip_rcv_finish_core.constprop.0+0x481/0x1ce0
> [ 67.162317] ? ip_rcv_core+0x5df/0xd60
> [ 67.162325] ip_rcv+0x2fc/0x380
> [ 67.162332] ? __pfx_ip_rcv+0x10/0x10
> [ 67.162338] ? __pfx_dma_map_page_attrs+0x10/0x10
> [ 67.162346] ? __kasan_check_write+0x14/0x30
> [ 67.162354] ? __build_skb_around+0x23a/0x350
> [ 67.162363] ? __pfx_ip_rcv+0x10/0x10
> [ 67.162369] __netif_receive_skb_one_core+0x173/0x1d0
> [ 67.162377] ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [ 67.162386] ? __kasan_check_write+0x14/0x30
> [ 67.162394] ? _raw_spin_lock_irq+0x8b/0x100
> [ 67.162402] __netif_receive_skb+0x21/0x160
> [ 67.162409] process_backlog+0x1c0/0x590
> [ 67.162417] __napi_poll+0xab/0x550
> [ 67.162425] net_rx_action+0x53e/0xd10
> [ 67.162434] ? __pfx_net_rx_action+0x10/0x10
> [ 67.162443] ? __pfx_wake_up_var+0x10/0x10
> [ 67.162453] ? tasklet_action_common.constprop.0+0x22c/0x670
> [ 67.162463] handle_softirqs+0x18f/0x5d0
> [ 67.162472] ? __pfx_run_ksoftirqd+0x10/0x10
> [ 67.162480] run_ksoftirqd+0x3c/0x60
> [ 67.162487] smpboot_thread_fn+0x2f3/0x700
> [ 67.162497] kthread+0x2b5/0x390
> [ 67.162505] ? __pfx_smpboot_thread_fn+0x10/0x10
> [ 67.162512] ? __pfx_kthread+0x10/0x10
> [ 67.162519] ret_from_fork+0x43/0x90
> [ 67.162527] ? __pfx_kthread+0x10/0x10
> [ 67.162534] ret_from_fork_asm+0x1a/0x30
> [ 67.162544] </TASK>
>
> [ 67.162551] The buggy address belongs to the object at ffff888156cb8000
>                 which belongs to the cache kmalloc-rnd-09-8k of size 819=
2
> [ 67.162557] The buggy address is located 331 bytes inside of
>                 allocated 8192-byte region [ffff888156cb8000, ffff888156=
cba000)
>
> [ 67.162566] The buggy address belongs to the physical page:
> [ 67.162570] page: refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x156cb8
> [ 67.162578] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:=
0 pincount:0
> [ 67.162583] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=
=3D0x1fffff)
> [ 67.162591] page_type: 0xfdffffff(slab)
> [ 67.162599] raw: 0017ffffc0000040 ffff888100056780 dead000000000122 000=
0000000000000
> [ 67.162605] raw: 0000000000000000 0000000080020002 00000001fdffffff 000=
0000000000000
> [ 67.162611] head: 0017ffffc0000040 ffff888100056780 dead000000000122 00=
00000000000000
> [ 67.162616] head: 0000000000000000 0000000080020002 00000001fdffffff 00=
00000000000000
> [ 67.162621] head: 0017ffffc0000003 ffffea00055b2e01 ffffffffffffffff 00=
00000000000000
> [ 67.162626] head: 0000000000000008 0000000000000000 00000000ffffffff 00=
00000000000000
> [ 67.162630] page dumped because: kasan: bad access detected
>
> [ 67.162636] Memory state around the buggy address:
> [ 67.162640] ffff888156cb8000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
> [ 67.162645] ffff888156cb8080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
> [ 67.162650] >ffff888156cb8100: fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> [ 67.162653] ^
> [ 67.162658] ffff888156cb8180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
> [ 67.162663] ffff888156cb8200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
>
> The reason is that the eth_hdr(skb) inside if statement evaluated
> to an unexpected address with skb->mac_header =3D ~0U (indicating there
> is no MAC header). The unreliability of skb->mac_len causes the if
> statement to become true even if there is no MAC header inside the
> skb data buffer.
>
> Check both the skb->mac_len and skb_mac_header_was_set(skb) fixes this i=
ssue.
>
> Fixes: 87cdf3148b11 ("xfrm: Verify MAC header exists before overwriting =
eth_hdr(skb)->h_proto")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> * Change the title from "xfrm: avoid using skb->mac_len to decide if mac=
 header is shown"
> * Remain skb->mac_len check
> * Apply fix on ipv6 path too
> ---
>  net/xfrm/xfrm_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 749e7eea99e4..eef0145c73a7 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -251,7 +251,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_sta=
te *x, struct sk_buff *skb)
>
>  	skb_reset_network_header(skb);
>  	skb_mac_header_rebuild(skb);
> -	if (skb->mac_len)
> +	if (skb->mac_len && skb_mac_header_was_set(skb))
>  		eth_hdr(skb)->h_proto =3D skb->protocol;
>
>  	err =3D 0;
> @@ -288,7 +288,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_sta=
te *x, struct sk_buff *skb)
>
>  	skb_reset_network_header(skb);
>  	skb_mac_header_rebuild(skb);
> -	if (skb->mac_len)
> +	if (skb->mac_len && skb_mac_header_was_set(skb))
>  		eth_hdr(skb)->h_proto =3D skb->protocol;
>
>  	err =3D 0;

Same change (and request for more debugging) already suggested in 2023, se=
e [1]...

Regards,
Peter

[1] https://lore.kernel.org/netdev/d1cf5a66-03e1-44b8-929d-ac123b1bbd7b@sy=
lv.io/T/

