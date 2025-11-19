Return-Path: <netdev+bounces-239876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BCFC6D776
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F03952D80E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DD32B9A6;
	Wed, 19 Nov 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9RPEOK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144E32AACA
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541510; cv=none; b=LFQK9i5SEJp2X/B+i0DPvNvbaDzZOl/A52d+nxiGnOQ0cbkmZVmIXqP/iVA9WHjr7+DVUv/+pMXfii/rX8Wje795sGUcClFLXlq4A2uHFBRBW9DWCYAYmPptsmuQ1Aeyo+D7nbqViHQnmDM+bCkaw8z2Yi4hWyfPn/Fb4taS9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541510; c=relaxed/simple;
	bh=qLzL2oGkT5uzDHzUXHQnhEffBkQRas4G657f/VDU8c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jabaiFcUuXRqIrMBh9k//Mia7XUq8pBtbYH/KVsYPkDHgF71mGDC9M9M9EyYOTz0zeinz613l+aydhfxCRyEDNt7+R9hNoh54GLOQerIFjiAfnNm0mOwKtpaTUBPSYYzI/YKKk7JXufnd+n8uNB5ZtvvTMQwlw9XYV9N0TAHgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9RPEOK6; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640d0895d7cso937616d50.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763541504; x=1764146304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhtdHkv5QkeMRpoBN++09mu3J6uyWjVJ3S/Ouasvn9o=;
        b=D9RPEOK6KNMaoN0iZkg/KrTaoXZL0M+Fvacs24opifh0XFlcVc4+HZPHTHDKau2wiW
         htxQbZA5zlbk1/z908FVcHW08lXpD4OZTSabZvJElHYY+1hI2/mBCN6JMu/GNfA+bzVU
         L+3UM7rTvks8KSno6oOkcujgZxHniESl2RJ7V+eEcFI+XXrdVKa2QkePy2iML7znS6DU
         dBD9l6o9Fz9JMIXaOKHBDsVSkbFr9q1F4D7aUsHPuCH0wjnK+9bdPcwJdN1qe0q1LjiH
         uYLy4eSCY1UcRsyFq5aY2AsOwPWe1n3IgUY0C2i1Dvhidu1A0s5UgvN3a3FYXs328yKt
         u1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541504; x=1764146304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YhtdHkv5QkeMRpoBN++09mu3J6uyWjVJ3S/Ouasvn9o=;
        b=Ojd340yf+71EeameLe3u11p2g/0WZKVENKd1yZ0+FBZ7hybpZB+VhzB9rU+PS3hDqR
         6OkAPGT58gaBc88KGFPK7bAx3XL7T/YRC4eReGCPr5coSvflzrX9nfv6sM83VchLnLNi
         80eLlHOBKDSm70kPUNC8mJ2h6FPGKtvs8rHIMqj13Wjt5cUOVl1IhWeFPxb0gS0hbcDx
         LK/Rx8cgPZyneJhxsiZyrZQ0LZ8qqiKrZGvg3BOVZzGVpJZOu9adWurAe8f2gO8FEqKC
         eL3sboKJiixaqGml36ZnTEw+FX8ixF10/3M4RtNTqmKcDfarHEwH0gof7c/dt2Px2EUw
         R/Aw==
X-Gm-Message-State: AOJu0YyqNsKM5Bg+TaS6Dnv5h2gVg7itFMhYg3PjCEe2FS7BQzJOrh2L
	hjD4FMNCv28T/w8Ziho/H78QYKcxtv8ivTUSthd+otRl6fX4MyHIebeDW4a9lsZOgk64I8v5EVV
	YqUfhq0xmbxL/wR+CgvViHj3+wzj9rhg=
X-Gm-Gg: ASbGncvrFz+l6GmP9wi+eA/9q2r5iCHsvjaRqc6Bh5Z0G1eWq1wSt3SB4dxNbC9cVVD
	r9neIOhg8jsbsDc0MRr496gv60rez5QKqhtbHjWPkeBWT03q8MU2ne/tCtl7quUip5xF75MKjV1
	UHMVjSAcBeQIgmtiwfMZkyn6AMjfIr5BRV3YoVxKZj0N9JAo5PoB0mEnDUcwtX/g1DQfQkOikZM
	XBo9qVGtHV4zCfEFOxt00N0sEzsphcqmj1U53NUaNBIrTQTTbDN5BAorVVmrJUDJx91+MOb5apF
	3c2WifBvKX3DLi0sOw==
X-Google-Smtp-Source: AGHT+IEsD+/GspMJKAXlQ3H3BchxjMnMXNGw30iJrlji7g772BASaY02PjWXYWNBBGyCRUnNx6C6Tj5stFCBWTay/tQ=
X-Received: by 2002:a05:690e:d85:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-642ed3f6cc1mr1172071d50.9.1763541504420; Wed, 19 Nov 2025
 00:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com> <20251118122430.65cc5738@kernel.org>
In-Reply-To: <20251118122430.65cc5738@kernel.org>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Wed, 19 Nov 2025 16:38:13 +0800
X-Gm-Features: AWmQ_bl_x3X_hT14mtYABcSV-rkmGJnn9Ien0NlDHrrQFNq_Y0SfmDYXz6Ich4s
Message-ID: <CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org, 
	irusskikh@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Nov 2025 15:04:02 +0800 jiefeng.z.zhang@gmail.com wrote:
> > From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
> >
> > The atlantic driver can receive packets with more than MAX_SKB_FRAGS (1=
7)
> > fragments when handling large multi-descriptor packets. This causes an
> > out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic=
.
> >
> > The issue occurs because the driver doesn't check the total number of
> > fragments before calling skb_add_rx_frag(). When a packet requires more
> > than MAX_SKB_FRAGS fragments, the fragment index exceeds the array boun=
ds.
> >
> > Add a check in __aq_ring_rx_clean() to ensure the total number of fragm=
ents
> > (including the initial header fragment and subsequent descriptor fragme=
nts)
> > does not exceed MAX_SKB_FRAGS. If it does, drop the packet gracefully
> > and increment the error counter.
>
> First off, some basic Linux mailing list savoir vivre:
>  - please don't top post
>  - please don't resubmit your code within 24h of previous posting
>  - please wait for a discussion to close before you send another version
>
> Quoting your response:
>
> https://lore.kernel.org/all/CADEc0q6iLdpwYsyGAwH4qzST8G7asjdqgR6+ymXMy1k0=
wRwhNQ@mail.gmail.com/
>
> > I have used git send-email to send my code.
> >
> > As for the patch --The aquantia/atlantic driver supports a maximum of
> > AQ_CFG_SKB_FRAGS_MAX (32U) fragments, while the kernel limits the
> > maximum number of fragments to MAX_SKB_FRAGS (17).
>
> Frag count limits in drivers are usually for Tx not Rx.
> Again, why do you think this driver can generate more frags than 17?
> --
> pw-bot: cr

Thank you for the feedback. You're right that fragment limits are
usually for TX, but this is a special case in the RX path.

Also, I apologize for resubmitting the patch within 24 hours. The
initial submission had formatting issues, so I resubmitted it using
git send-email to ensure proper formatting. I understand the mailing
list etiquette and will wait for discussion before sending another
version in the future.

The atlantic hardware supports multi-descriptor packet reception
(RSC). When a large packet arrives, the hardware splits it across
multiple descriptors, where each descriptor can hold up to 2048 bytes
(AQ_CFG_RX_FRAME_MAX).

There is a logic bug in the code. The code already counts fragments in
the multi-descriptor loop
(frag_cnt at aq_ring.c:559), but the check at aq_ring.c:568 only considers
frag_cnt, not the additional fragment from the first buffer
(if buff->len > hdr_len). The actual fragment addition happens later
(aq_ring.c:634-667):
- One fragment from the first buffer (if hdr_len < buff->len)
- Plus frag_cnt fragments from subsequent descriptors

This can exceed MAX_SKB_FRAGS (17) in edge cases:
- If frag_cnt =3D 17 (the check passes)
- And the first buffer has a fragment (buff->len > hdr_len)
- Then total =3D 1 + 17 =3D 18 > MAX_SKB_FRAGS

While the hardware MTU limit is 16334 bytes (B0/ATL2), which should
only need ~8 fragments, there are edge cases like LRO aggregation
or hardware anomalies that could produce more descriptors.

The panic occurred because skb_add_rx_frag() was called with an index
>=3D MAX_SKB_FRAGS, causing an out-of-bounds write. The fix ensures
we check the total fragment count (first buffer fragment + frag_cnt)
before calling skb_add_rx_frag().

And I have encountered this crash in production with an
Aquantia(AQtion AQC113) 10G NIC[Antigua 10G]:

```
<4>[175432.612171] RIP: 0010:skb_add_rx_frag_netmem+0x29/0xd0
<4>[175432.612193] Code: 90 f3 0f 1e fa 0f 1f 44 00 00 48 89 f8 41 89
ca 48 89 d7 48 63 ce 8b 90 c0 00 00 00 48 c1 e1 04 48 01 ca 48 03 90
c8 00 00 00 <48> 89 7a 30 44 89 52 3c 44 89 42 38 40 f6 c7 01 75 74 48
89 fa 83
<4>[175432.612212] RSP: 0018:ffffa9bec02a8d50 EFLAGS: 00010287
<4>[175432.612223] RAX: ffff925b22e80a00 RBX: ffff925ad38d2700 RCX:
fffffffe0a0c8000
<4>[175432.612234] RDX: ffff9258ea95bac0 RSI: ffff925ae0a0c800 RDI:
0000000000037a40
<4>[175432.612244] RBP: 0000000000000024 R08: 0000000000000000 R09:
0000000000000021
<4>[175432.612254] R10: 0000000000000848 R11: 0000000000000000 R12:
ffffa9bec02a8e24
<4>[175432.612264] R13: ffff925ad8615570 R14: 0000000000000000 R15:
ffff925b22e80a00
<4>[175432.612274] FS: 0000000000000000(0000)
GS:ffff925e47880000(0000) knlGS:0000000000000000
<4>[175432.612287] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[175432.612296] CR2: ffff9258ea95baf0 CR3: 0000000166022004 CR4:
0000000000f72ef0
<4>[175432.612307] PKRU: 55555554
<4>[175432.612314] Call Trace:
<4>[175432.612323] <IRQ>
<4>[175432.612334] aq_ring_rx_clean+0x175/0xe60 [atlantic]
<4>[175432.612398] ? aq_ring_rx_clean+0x14d/0xe60 [atlantic]
<4>[175432.612455] ? aq_ring_tx_clean+0xdf/0x190 [atlantic]
<4>[175432.612508] ? kmem_cache_free+0x348/0x450
<4>[175432.612525] ? aq_vec_poll+0x81/0x1d0 [atlantic]
<4>[175432.612575] ? __napi_poll+0x28/0x1c0
<4>[175432.612587] ? net_rx_action+0x337/0x420
```

