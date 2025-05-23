Return-Path: <netdev+bounces-193064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007AAAC24A2
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF37189CE85
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA029347F;
	Fri, 23 May 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH5OtQBR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6D248F73;
	Fri, 23 May 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009086; cv=none; b=YIF6LJAZtYO8bGOAtOyoYiSoiUIZjSI7fYosIWzZiy7HIDQwEQ2ct2WjrgTCxP3QDvv4ZUjzwTz4bHYmGtH6vZ50FKV46tUkkeG9GgW7DWlB+OTa2h0Mg0KUcTZ+5xBcw1reJKE598Ql6lS0MOAfAxJ6GH/zPgWlX+gV5xLhepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009086; c=relaxed/simple;
	bh=6lpWK6Drr5+vgLOx0u+DvG+Bvx3CrrEBBgCjEtzjwkM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o+mRoC3StdhUJId3QpunhbHZCLdDz9LDYMKpr/V5r21yGBrhWG7JnBJ76yn3HmdGKljZfXeBEMFnujSs9i/Z92/Z9eKcKGMlcdfY+EtmzGWoSk8Rx06cGbvyh4O1VrGebFCuvi4NFgZ4pqDOTUMBnXso3ST3L3/NJThGmNGpCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH5OtQBR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c53b9d66fdso1247588085a.3;
        Fri, 23 May 2025 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748009083; x=1748613883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SPYA6KKr4FKQPVcBeIbQ/FN9mi6kl/TZynKGB3TdfU=;
        b=jH5OtQBRx5200qoamF4fwdIcEYl/uVnROqynsQSWQb2h8/ai4PaXosokboSMAmXwyS
         CpQqMu+oXyubfCMYn+uaH+a6M32xbrdGZCo+kQ/63g48Na0PV0jBNwS/iMc0PYOVKX9u
         KfUmgd8lXDw7NNCSBEgsOVWzEBVnVnEOVmQUuaI2CsHBrU33vIUzEO9pTcGYKOyQPB7a
         S4PUKgNkX4qoUN9lyJ4clAEuYdJ3pibyOrAIDC4fdgcBJpFeoZzlyGITC54fOMRgLMJY
         mQQF3UzXpM5pPkas3hpVlEybg45b8S/QEzMixyX8UOA46Tz7PvM2GsIjhx3uJZNSro2i
         hpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748009083; x=1748613883;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6SPYA6KKr4FKQPVcBeIbQ/FN9mi6kl/TZynKGB3TdfU=;
        b=nBTiJjUek5VTGLaaSNWknxXdoqTfHEcflV4QYgUlXexdxhkIRBqNvsK8aHs9HOYG7a
         NS4QMpHaPG2XBEMrWeMfLTQirI5EyIQHkl/32orvk90rMzyfCZSkyb1XTbwBPZW125Hk
         W/C7KaZtej7yB3U8npb801il87qaVd18Mf2LNGz5cPgwnIYyHI4/t7VWQuKTAhQKFC5d
         huIbJ5rOKD+IhosxbAmpUshbpBZSf9rYQjNC4LSm3R/FLZcQlZfzVv/ajaffYUxMmOAs
         D1GimRKzueNbNDrpOkpKtnEKQneOOF+y74Wp+Q3h7ME9qmN1OYpyTYqtpipFQuHPFX84
         xFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf4TPV17ffk6RGlBKUyr3sE6ZA4+VV1WnBTGleFE6ZUABLe3bnTjutEh5pSudVRhK5AF/s0gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUIo7ID7acH8JzI3JWvT2f/wLN7z2kbzq6u0QcZ36lcl/d6by
	raUZfc9ka+vhzNZBcmsCtLOy53DwKAxBSlaDS8fTVWq9jqjTK0uOhzpE
X-Gm-Gg: ASbGncujACRVVU8TvdWEEzVYN4mUhQHPrhpgBIfcxAGyL5XNm3UQaFBGwjASFWGyfGl
	QMOuGoa4Py5RDKbFwY8b0eFp0A3k7dcqNy7VA8xCgE8aWwaVcDexREd4qac+hzERqFRj4+TdNu2
	BqoMXUnst56W6vNwUx7QchOyOPM4QEgZcxwS9FcerWsdyC9GpOwk7NkZr1/tf0oodEQA2x6FqxF
	Gam4ddYXH0SzFS/dh2wkAUCB6C5Vs+0eHYcZ24muDG76CV7gwXCh7Zzh5P50luifQHrKuRLZYAd
	nA/eJbUq6TYzHX5IIKDCwKvOiFrqVHRVZlfYn0JAV7msKXJ7/07XNsPsRrCuNqUnqtGuVqiqrfN
	rnGesbAIoqmZs8g9kr1C+Tc+4eg1G2i5R6w==
X-Google-Smtp-Source: AGHT+IGaymca1YezxsOIulTSN/Q8v3bR9qw2SFi/1IXzriNtN485FsSdroLT5pauvjI/40BAAf6kLw==
X-Received: by 2002:ad4:404d:0:b0:6fa:9a6a:7d03 with SMTP id 6a1803df08f44-6fa9a6a7db2mr11984946d6.7.1748009083128;
        Fri, 23 May 2025 07:04:43 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883ef7sm116259006d6.21.2025.05.23.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:04:42 -0700 (PDT)
Date: Fri, 23 May 2025 10:04:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemdebruijin.kernel@gmail.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 lena.wang@mediatek.com
Message-ID: <6830807a4a4b1_180c78294e7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250522031835.4395-1-shiming.cheng@mediatek.com>
References: <20250522031835.4395-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiming Cheng wrote:
>     Detect invalid geometry due to pull from frag_list, and pass to
>     regular skb_segment. if only part of the fraglist payload is pulled=


This does not match the patch.

This is quoted from another patch that moves skb handling from
skb_segment_list to skb_segment.

This patch does not do that.

Btw, don't forget to target the right list. [PATCH net]

>     into head_skb, When splitting packets in the skb_segment function,
>     it will always cause exception as below.
> =

>     Valid SKB_GSO_FRAGLIST skbs
>     - consist of two or more segments
>     - the head_skb holds the protocol headers plus first gso_size
>     - one or more frag_list skbs hold exactly one segment
>     - all but the last must be gso_size
> =

>     Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can=

>     modify fraglist skbs, breaking these invariants.
> =

>     In extreme cases they pull one part of data into skb linear. For UD=
P,
>     this  causes three payloads with lengths of (11,11,10) bytes were
>     pulled tail to become (12,10,10) bytes.
> =

>     When splitting packets in the skb_segment function, the first two
>     packets of (11,11) bytes are split using skb_copy_bits. But when
>     the last packet of 10 bytes is split, because hsize becomes nagativ=
e,
>     it enters the skb_clone process instead of continuing to use
>     skb_copy_bits. In fact, the data for skb_clone has already been
>     copied into the second packet.
> =

>     when hsize < 0,  the payload of the fraglist has already been copie=
d
>     (with skb_copy_bits), so there is no need to enter skb_clone to
>     process this packet. Instead, continue using skb_copy_bits to proce=
ss
>     the next packet.

I don't fully follow this. And as always with skb_segment am concerned
that changing this condition may break other valid uses of this code.

If this is a fraglist gso packet (SKB_GSO_FRAGLIST), I have a mind to
just flag those that fail to meet the four invariants at the top, and
in that case take a slow path that linearizes the skb and passes that
to skb_segment.

That should take care of a whole host of such bad fraglist gso skbs,
without possibly breaking existing gso skb handling.

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
> =

>     BUG_ON=EF=BC=9A
>          pos +=3D skb_headlen(list_skb);
>          while (pos < offset + len) {
>             BUG_ON(i >=3D nfrags);
>             size =3D skb_frag_size(frag);
> =

> Fixes: dbd50f238dec ("net: move the hsize check to the else block in sk=
b_segment")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6841e61a6bd0..f9888f8dc3fa 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4808,7 +4808,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>  =

>  		hsize =3D skb_headlen(head_skb) - offset;
>  =

> -		if (hsize <=3D 0 && i >=3D nfrags && skb_headlen(list_skb) &&
> +		if (hsize =3D=3D 0 && i >=3D nfrags && skb_headlen(list_skb) &&
>  		    (skb_headlen(list_skb) =3D=3D len || sg)) {
>  			BUG_ON(skb_headlen(list_skb) > len);
>  =

> -- =

> 2.45.2
> =




