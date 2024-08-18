Return-Path: <netdev+bounces-119476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6475955D19
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB96F1C20DA7
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B61448E0;
	Sun, 18 Aug 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hnHKkNw9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490552D600
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993794; cv=none; b=qO1B/qGtyxObZtSB4VaBmi51RpABSiJ01sgpXva4X9t16KqRSCJXjgBt35Q/no8BRSqwYLUCEO3Eu9duQsCyMMwYSTpe8yHNOaREZ2A306kLDJpu9VgS7gbfjosXlhIs0/xlX/IbTATDAdrsRYhxH4s7VP8RC1JTIKoS63vlyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993794; c=relaxed/simple;
	bh=QrxhNiXLXBb6Ubd7tyT1tmJIl/OpNkbpDL+INCJu9cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQrrFmiSB5wvzgFBn7jedUEEihTJpQy/KWKbnY98SYYxQ5dKfoe+sak8aJtLs//MWRok63zbsO3U4F77OsgS4YnZyfO8adZZfFzLTrHAfOC6ruyPZEIsqAL/Etm6JSKMWxdyb7U/McqZCRb2/XdplCaWuflDQFNCwq30TAoyGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hnHKkNw9; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1eb76702so2622992b6e.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723993791; x=1724598591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqahmoMTVYUFe3lXrqR1sv+4nYG5/Mx4DO/C2s5tQxY=;
        b=hnHKkNw9K9utwjSgFlJ4UAR55o+BHKXro42edEuJEzJjdv2PsrOpbLAmuzFjAY1k/u
         Na2Sm3rN/+h1etQWNyQqu/Q4eEjS7h04O3j21TGrzyi7/Ffzn47r98dGdhqwYI/5IgHQ
         x+KMPhMTtjXRMqt3QR3fIhZKgV2N2daYDm5yfknE+LWZqaO9soqSnsfirGP0h4b2Qtfa
         Y8kUtcNQqtgADWpsPQvWPjtInjA2tHf9WTt9gYMkaljLWZGNl89bJPBrCYQH073mZPZl
         sk3I/00w2cots048JDLh1JojbGLAJCy+YUKNndb/WRD1dgnBb/xuSn7Flei5qCRAN1yy
         66nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993791; x=1724598591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqahmoMTVYUFe3lXrqR1sv+4nYG5/Mx4DO/C2s5tQxY=;
        b=oMUmQOA4XNAd40/8GWE/CAVNdgJo1ZvafzJcrp++ocUi+f6wLUyG4ikui1RdI5MEDa
         UMVqJCvFFLUSMtxvuJL6ERt9QfUBYA0zKP5XYlS18KvQMlkP2U3/9k0dKUxuXCAXsiFg
         IKD6WxbZZbww3gIhwHsLKNOFyWkWZRqOyxmyUc/+2YTFZvYAl5OUANc2v//Xo3+Ju/SG
         6bfhAi8YfQ/ceTP7e4IFT5RNP7LzWN1wuz7CpB/LzF7JGb09earSwXp0XE5pz0eoNpHa
         FNbXxx5jpNAxEq0b0XvcHxi0DdGYzruEcY/lknOP9vS57THSsq00EyFnSpAhjC6B7Rn+
         dg+w==
X-Forwarded-Encrypted: i=1; AJvYcCXddmJR+iux1iUYpTfflx2/WytpwMkrSTog1FiuEqiND4y6aVQ0HoySLAyetdQaRHZvVaRDK50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZeThLWTaUY05mP/hTdB7nZANzhS0YHVUTFDOi5lHbu+hmMk7
	P+72MNR8NbNqEll0GgRSNxiAg3vjDeknqPT+sP5RdqxYPPmwv1e7PJu19p+sjFA=
X-Google-Smtp-Source: AGHT+IHQgEgJaNzyy0NTH4G9osAbEWTFKM1nXnW/vY8TZXwcH3ykdELGmXS4WDrwp/xHoV8/XRt3BA==
X-Received: by 2002:a05:6870:b253:b0:270:187e:f481 with SMTP id 586e51a60fabf-2701c3dd2b4mr10169680fac.26.1723993791114;
        Sun, 18 Aug 2024 08:09:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c5aasm5319445b3a.199.2024.08.18.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:09:50 -0700 (PDT)
Date: Sun, 18 Aug 2024 08:09:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: Silence false field-spanning write
 warning in metadata_dst memcpy
Message-ID: <20240818080944.4c19255e@hermes.local>
In-Reply-To: <20240818114351.3612692-1-gal@nvidia.com>
References: <20240818114351.3612692-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 14:43:51 +0300
Gal Pressman <gal@nvidia.com> wrote:

> When metadata_dst struct is allocated (using metadata_dst_alloc()), it
> reserves room for options at the end of the struct.
> 
> Change the memcpy() to unsafe_memcpy() as it is guaranteed that enough
> room (md_size bytes) was allocated and the field-spanning write is
> intentional.
> 
> This resolves the following warning:
> 	------------[ cut here ]------------
> 	memcpy: detected field-spanning write (size 104) of single field "&new_md->u.tun_info" at include/net/dst_metadata.h:166 (size 96)
> 	WARNING: CPU: 2 PID: 391470 at include/net/dst_metadata.h:166 tun_dst_unclone+0x114/0x138 [geneve]
> 	Modules linked in: act_tunnel_key geneve ip6_udp_tunnel udp_tunnel act_vlan act_mirred act_skbedit cls_matchall nfnetlink_cttimeout act_gact cls_flower sch_ingress sbsa_gwdt ipmi_devintf ipmi_msghandler xfrm_interface xfrm6_tunnel tunnel6 tunnel4 xfrm_user xfrm_algo nvme_fabrics overlay optee openvswitch nsh nf_conncount ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser rdma_cm ib_umad iw_cm libiscsi ib_ipoib scsi_transport_iscsi ib_cm uio_pdrv_genirq uio mlxbf_pmc pwr_mlxbf mlxbf_bootctl bluefield_edac nft_chain_nat binfmt_misc xt_MASQUERADE nf_nat xt_tcpmss xt_NFLOG nfnetlink_log xt_recent xt_hashlimit xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_mark xt_comment ipt_REJECT nf_reject_ipv4 nft_compat nf_tables nfnetlink sch_fq_codel dm_multipath fuse efi_pstore ip_tables btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 nvme nvme_core mlx5_ib ib_uverbs ib_core ipv6 crc_ccitt mlx
 5_core crct10dif_ce mlxfw
> 	 psample i2c_mlxbf gpio_mlxbf2 mlxbf_gige mlxbf_tmfifo
> 	CPU: 2 PID: 391470 Comm: handler6 Not tainted 6.10.0-rc1 #1
> 	Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.5.0.12993 Dec  6 2023
> 	pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	pc : tun_dst_unclone+0x114/0x138 [geneve]
> 	lr : tun_dst_unclone+0x114/0x138 [geneve]
> 	sp : ffffffc0804533f0
> 	x29: ffffffc0804533f0 x28: 000000000000024e x27: 0000000000000000
> 	x26: ffffffdcfc0e8e40 x25: ffffff8086fa6600 x24: ffffff8096a0c000
> 	x23: 0000000000000068 x22: 0000000000000008 x21: ffffff8092ad7000
> 	x20: ffffff8081e17900 x19: ffffff8092ad7900 x18: 00000000fffffffd
> 	x17: 0000000000000000 x16: ffffffdcfa018488 x15: 695f6e75742e753e
> 	x14: 2d646d5f77656e26 x13: 6d5f77656e262220 x12: 646c65696620656c
> 	x11: ffffffdcfbe33ae8 x10: ffffffdcfbe1baa8 x9 : ffffffdcfa0a4c10
> 	x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> 	x5 : ffffff83fdeeb010 x4 : 0000000000000000 x3 : 0000000000000027
> 	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff80913f6780
> 	Call trace:
> 	 tun_dst_unclone+0x114/0x138 [geneve]
> 	 geneve_xmit+0x214/0x10e0 [geneve]
> 	 dev_hard_start_xmit+0xc0/0x220
> 	 __dev_queue_xmit+0xa14/0xd38
> 	 dev_queue_xmit+0x14/0x28 [openvswitch]
> 	 ovs_vport_send+0x98/0x1c8 [openvswitch]
> 	 do_output+0x80/0x1a0 [openvswitch]
> 	 do_execute_actions+0x172c/0x1958 [openvswitch]
> 	 ovs_execute_actions+0x64/0x1a8 [openvswitch]
> 	 ovs_packet_cmd_execute+0x258/0x2d8 [openvswitch]
> 	 genl_family_rcv_msg_doit+0xc8/0x138
> 	 genl_rcv_msg+0x1ec/0x280
> 	 netlink_rcv_skb+0x64/0x150
> 	 genl_rcv+0x40/0x60
> 	 netlink_unicast+0x2e4/0x348
> 	 netlink_sendmsg+0x1b0/0x400
> 	 __sock_sendmsg+0x64/0xc0
> 	 ____sys_sendmsg+0x284/0x308
> 	 ___sys_sendmsg+0x88/0xf0
> 	 __sys_sendmsg+0x70/0xd8
> 	 __arm64_sys_sendmsg+0x2c/0x40
> 	 invoke_syscall+0x50/0x128
> 	 el0_svc_common.constprop.0+0x48/0xf0
> 	 do_el0_svc+0x24/0x38
> 	 el0_svc+0x38/0x100
> 	 el0t_64_sync_handler+0xc0/0xc8
> 	 el0t_64_sync+0x1a4/0x1a8
> 	---[ end trace 0000000000000000 ]---
> 
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  include/net/dst_metadata.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 4160731dcb6e..84c15402931c 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -163,8 +163,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>  	if (!new_md)
>  		return ERR_PTR(-ENOMEM);
>  
> -	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -	       sizeof(struct ip_tunnel_info) + md_size);
> +	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> +		      sizeof(struct ip_tunnel_info) + md_size,
> +		      /* metadata_dst_alloc() reserves room (md_size bytes) for
> +		       * options right after the ip_tunnel_info struct.
> +		       */);

This is an awkward /* midsentence */ place to put a comment.

