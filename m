Return-Path: <netdev+bounces-193453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01AAC41A7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3725817805B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4223211488;
	Mon, 26 May 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIataHlC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D7210F5A;
	Mon, 26 May 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270519; cv=none; b=C55ezwMMzJTObUpRdMV5AgCdzNFgtCm1Dvcqu13z61joLj2wABWb7F3TA4OL4IbKn+a5dexqKQ0J/C3a1t9EIXuqCTtiYkjHykb2VSnHn8VyJRpOuW5bQ9kUbVaTGctkUQSXX9E7ClVcXQpWUfDanwEE+7DyFDhZxPpBnW/kyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270519; c=relaxed/simple;
	bh=xRH5cJQC0BxojTkJ0c2qP/M631Inr5m2Uc9jQRhRE6A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iOMF98XQmq5owT9aDeuuEuPx7JK/dR/oj/IvjaVhBVRHsVs4kdXhgvnx9CvK0yw5j9zv+L97AY4JD1DcEAxkXEMY5S/0aZlN1f1m1iKiMX16qHdpafyvV4rM0niWedhhU/NbAfGI7Wcw0gloNW9isWmtzD0PnFdHjen0laeoHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIataHlC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c59e7039eeso304162785a.2;
        Mon, 26 May 2025 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748270517; x=1748875317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6huNXGJCACa92UVvHf3qC3hkVPFS+g7gKSrPhimVrE=;
        b=QIataHlCJVReC5dvfCqcANHcIEq/LW44GFxCvBNbSG+UD8+vLCthIgR6bhUw1LVU52
         43bSWfr1Na6WJgY50DKXjAYLRqlbxqXmAf686l5wc66TLDHgqkX4KXIHqDgEjc6Usawg
         6UUMuzdIn23U68WKOIC7W22mkPQ6YnEuDQWicH+VLhbP+oVSQSR44cSXJnXgKEjmPSFR
         G3ZJRet4avc8G9orvjkPYjMN97ywEjBUvDiAM4avPAeDKvA2itreGtOSaQKb6hmK8TDI
         lq23AvBucgGATj5tmewa0E4he6DCm0w8NSn95q5caoNffUf1nvuPvjZ0i7IftF9221Pp
         C0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270517; x=1748875317;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6huNXGJCACa92UVvHf3qC3hkVPFS+g7gKSrPhimVrE=;
        b=GQH5eKnDIKLDNMecGvRcCVBmZ0e/YlczLdkA5oS/ZzNK3cjuRJbFSZZXUz8UkVZ+G0
         N4JiZcIrfk2iCN/7xW//n04OgwlNZpI95+eKE5a3RFh3Dgogy7vv7jatp327+cNMlNSh
         K25aHvJeyhMJ39DD8nsfTzo6hTU+PyDGApT+xW6Rv6OONC2krMjwr3ZPQNzUDOKaX2kr
         Wf5LFKHw9M45S2RVjyCIHFMIkebBoU6Ag0giuvvU33QuMXMmnQbV5FH9Mm07TaTqQbGy
         bHILHuUiLCkRh6xzA9tevpAjOthDVQmeMVrUXzBihCC3ywPNxq1tuEz7V9/yVnr+0wXh
         GNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLi/GvFcWw3+b9bLyusCwX3OzwgBFrlUtwbbbxYB/Jr39tJdJdIIZR38+wmY0Aq3chnkBIrO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8s4ijRKxXtBljEUZPpWd+RhnZxEf5VJn38RpMzzW8TkB2/WF
	0gOYIgAd9oi8+xbej4ThXzmu2lhWa4U5SGIBGkxYv3/DpO8Rrhje5ORz
X-Gm-Gg: ASbGnct9nkqk9ijafwjzgVZmP7bFuaZDqsDgiOuDek8MGQVcRAEUuMDWQCpKxanZdaf
	r3bKaeaGwlCeBFu4F+/OKyEuWYLo27WjkR7coxun3P7I0CqQYm4vr9nBRfg7zZwCiIFajc8S0Aq
	InyhX0AZWpVilLUuoFBcFY5iS/UubpSEs3vYxAGJy7bqFJNgjANv2tNSsLWKj+3PbuB+UMRLSlD
	otVheIlMJHhQRYFIS1XgsD/2dm6m8porILMvNN4Nds4lP5jZCMFlE86zt83ij/xSBTQNBUubojc
	/ZYt6vm1Q0k4w+KKRbhvsY0lS0taDGRyr0gY6flhd9R6aRQysnJrAyolAPFDj9Xe/TGYeuOKuWd
	qva+fqyeQmYZjwmcIBeQ/euM=
X-Google-Smtp-Source: AGHT+IHTW7Q1kaM21zc7kq0hywZYrnLWu+scqiNqNrhx6gk3UC71vn1S6SqidpsLv5nA7y23BX09eA==
X-Received: by 2002:a05:620a:6013:b0:7c5:674c:eecc with SMTP id af79cd13be357-7ceecbe8957mr1359044685a.32.1748270516715;
        Mon, 26 May 2025 07:41:56 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467eedbfsm1563096585a.58.2025.05.26.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:41:55 -0700 (PDT)
Date: Mon, 26 May 2025 10:41:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 lena.wang@mediatek.com
Message-ID: <68347db362e10_28cacc29479@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250526062638.20539-1-shiming.cheng@mediatek.com>
References: <20250526062638.20539-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v2] t: fix udp gso skb_segment after pull from frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

s/t/net

s/[PATCH vX]/[PATCH net vX]

Shiming Cheng wrote:
> Detect invalid geometry due to pull from frag_list, and pass to
> regular skb_segment. if only part of the fraglist payload is pulled
> into head_skb, When splitting packets in the skb_segment function,

Punctuation is off

> it will always cause exception as below.
> =

> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> =

> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify fraglist skbs, breaking these invariants.
> =

> In extreme cases they pull one part of data into skb linear. For UDP,
> this  causes three payloads with lengths of (11,11,10) bytes were
> pulled tail to become (12,10,10) bytes.
> =

> When splitting packets in the skb_segment function, the first two
> packets of (11,11) bytes are split using skb_copy_bits. But when
> the last packet of 10 bytes is split, because hsize becomes nagative,
> it enters the skb_clone process instead of continuing to use
> skb_copy_bits. In fact, the data for skb_clone has already been
> copied into the second packet.
> =

> when hsize < 0,  the payload of the fraglist has already been copied
> (with skb_copy_bits), so there is no need to enter skb_clone to
> process this packet. Instead, continue using skb_copy_bits to process
> the next packet.

No longer matches the current patch

> BUG_ON here=EF=BC=9A
> pos +=3D skb_headlen(list_skb);
> while (pos < offset + len) {
>     BUG_ON(i >=3D nfrags);
>     size =3D skb_frag_size(frag);
> =

>     el1h_64_sync_handler+0x3c/0x90
>     el1h_64_sync+0x68/0x6c
>     skb_segment+0xcd0/0xd14
>     __udp_gso_segment+0x334/0x5f4
>     udp4_ufo_fragment+0x118/0x15c
>     inet_gso_segment+0x164/0x338
>     skb_mac_gso_segment+0xc4/0x13c
>     __skb_gso_segment+0xc4/0x124
>     validate_xmit_skb+0x9c/0x2c0
>     validate_xmit_skb_list+0x4c/0x80
>     sch_direct_xmit+0x70/0x404
>     __dev_queue_xmit+0x64c/0xe5c
>     neigh_resolve_output+0x178/0x1c4
>     ip_finish_output2+0x37c/0x47c
>     __ip_finish_output+0x194/0x240
>     ip_finish_output+0x20/0xf4
>     ip_output+0x100/0x1a0
>     NF_HOOK+0xc4/0x16c
>     ip_forward+0x314/0x32c
>     ip_rcv+0x90/0x118
>     __netif_receive_skb+0x74/0x124
>     process_backlog+0xe8/0x1a4
>     __napi_poll+0x5c/0x1f8
>     net_rx_action+0x154/0x314
>     handle_softirqs+0x154/0x4b8
>     __do_softirq+0x14/0x20
> =

>     [  118.376811] [C201134] dpmaif_rxq0_pus: [name:bug&]kernel BUG at =
net/core/skbuff.c:4278!
>     [  118.376829] [C201134] dpmaif_rxq0_pus: [name:traps&]Internal err=
or: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>     [  118.376858] [C201134] dpmaif_rxq0_pus: [name:mediatek_cpufreq_hw=
&]cpufreq stop DVFS log done
>     [  118.470774] [C201134] dpmaif_rxq0_pus: [name:mrdump&]Kernel Offs=
et: 0x178cc00000 from 0xffffffc008000000
>     [  118.470810] [C201134] dpmaif_rxq0_pus: [name:mrdump&]PHYS_OFFSET=
: 0x40000000
>     [  118.470827] [C201134] dpmaif_rxq0_pus: [name:mrdump&]pstate: 604=
00005 (nZCv daif +PAN -UAO)
>     [  118.470848] [C201134] dpmaif_rxq0_pus: [name:mrdump&]pc : [0xfff=
fffd79598aefc] skb_segment+0xcd0/0xd14
>     [  118.470900] [C201134] dpmaif_rxq0_pus: [name:mrdump&]lr : [0xfff=
fffd79598a5e8] skb_segment+0x3bc/0xd14
>     [  118.470928] [C201134] dpmaif_rxq0_pus: [name:mrdump&]sp : ffffff=
c008013770
>     [  118.470941] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x29: ffffff=
c008013810 x28: 0000000000000040
>     [  118.470961] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x27: 000000=
000000002a x26: faffff81338f5500
>     [  118.470976] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x25: f9ffff=
800c87e000 x24: 0000000000000000
>     [  118.470991] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x23: 000000=
000000004b x22: f4ffff81338f4c00
>     [  118.471005] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x21: 000000=
000000000b x20: 0000000000000000
>     [  118.471019] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x19: fdffff=
8077db5dc8 x18: 0000000000000000
>     [  118.471033] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x17: 000000=
00ad6b63b6 x16: 00000000ad6b63b6
>     [  118.471047] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x15: ffffff=
d795aa59d4 x14: ffffffd795aa7bc4
>     [  118.471061] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x13: f4ffff=
806d40bc00 x12: 0000000100000000
>     [  118.471075] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x11: 005400=
0800000000 x10: 0000000000000040
>     [  118.471089] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x9 : 000000=
0000000040 x8 : 0000000000000055
>     [  118.471104] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x7 : ffffff=
d7959b0868 x6 : ffffffd7959aeebc
>     [  118.471118] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x5 : f8ffff=
8132ac5720 x4 : ffffffc0080134a8
>     [  118.471131] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x3 : 000000=
0000000a20 x2 : 0000000000000001
>     [  118.471145] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x1 : 000000=
000000000a x0 : faffff81338f5500

Please truncate to the most relevant information.

That [name:..] stuff looks odd too? Is this normal dmesg? If so, what
is the platform.

In this case, the (possibly somewhat truncated) stack trace and explicit
kernel BUG at statement probably suffice.

> Fixes: a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after=
 pull from frag_list")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/ipv4/udp_offload.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a5be6e4ed326..ec05bb7d1e22 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -273,6 +273,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *g=
so_skb,
>  	bool copy_dtor;
>  	__sum16 check;
>  	__be16 newlen;
> +	int ret =3D 0;
>  =

>  	mss =3D skb_shinfo(gso_skb)->gso_size;
>  	if (gso_skb->len <=3D sizeof(*uh) + mss)
> @@ -301,6 +302,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *g=
so_skb,
>  		if (skb_pagelen(gso_skb) - sizeof(*uh) =3D=3D skb_shinfo(gso_skb)->g=
so_size)
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>  =

> +		ret =3D __skb_linearize(gso_skb);
> +		if (ret)
> +			return ERR_PTR(ret);

code LGTM, thanks.

>  		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
>  		gso_skb->csum_start =3D skb_transport_header(gso_skb) - gso_skb->hea=
d;
>  		gso_skb->csum_offset =3D offsetof(struct udphdr, check);
> -- =

> 2.45.2
> =




