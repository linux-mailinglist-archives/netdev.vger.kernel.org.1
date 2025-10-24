Return-Path: <netdev+bounces-232503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF6C06175
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E65D3577F8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491772D3226;
	Fri, 24 Oct 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THBKORSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801EC23C8C5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306610; cv=none; b=SWbY4f5F7uaN9TIho9IneFo+/lVKI+ZhvBK6+U30B2mpZUGGle9ZxqK9szgUNhA3t9lYMK59xrY+N4x4UQyePc5zkCa1sxZdLyO06ilYmLtIwjl0mVvIZJuedU4QNaNXh5MZKtFwO24kex6lgZZ/xJ7b0ueTmhJ5Nkq4UCKcrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306610; c=relaxed/simple;
	bh=JyNPoOflrd09KImJzGn+Oa6R2et+UXAyI1HgrMWnlrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emzo+q+2UdlBOmtMr310vy9FNFDm6eInAyZ6zp2TYPm5MfCpCOffU1WmGGcUPVmGLKq+05zAbxmj5KZdWth4QYbSS2uTv/V5ZE4z2M/HJuiIwKMFzLXSzs7IJ3htpc4ywHxHm6cmK93RFNbhP7WXme6jbnYgvVnUBEFDDXw8cZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THBKORSJ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63bbf5f77daso2228920d50.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761306607; x=1761911407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPu7vN1calUWS9Gz7jrsKnKSCyFmaW2kq8XMxDii/Ww=;
        b=THBKORSJHmb2r0wEkEg4vLDxBhzZNXJ06lh/v4ndf7RrKUw6f7FFFU5n+wbq7o+ONa
         lyR3opdpVcoz34/rnDcpAHwd+ovhsoxjbIXgyfp0zWu0chNnDxPnKmt8Pa2rGPoxGFM3
         S9tKWGvPHRex65AJ7zDwUQR18+Or/TDmtLbvcXrqUrxXMZTdcVASJ8MNZm+cPisyrGt8
         ymsZwaVkrdBtVWn6Z+nTb+L2p2qxsoBgxUQpR2FHhBLR5+1llqVV3Q/d+8n5bJAThEWZ
         wDqY/TigG7de52PcbeFDWcri0KF2ngxwd5+Sm3sCDVfGCbbNs34MKsvxQDaRmy2GnOY5
         psOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306607; x=1761911407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPu7vN1calUWS9Gz7jrsKnKSCyFmaW2kq8XMxDii/Ww=;
        b=VanAS0rdzWH5CnVkLjicrapcIrzqlmUKhnILbtaHF3YFyjybnuSocd9cvhnFI+n8RT
         kBYRvpkXb/cWbDpnOh+L99GG0M2NuaLVUAc5zVZY8G2weZFWFHsasogShhfWUQ6fDIHF
         JLnIFUwhQyoqnCJtJdaFcIOOxUFCAhN7nWt5SA1TejIVzsQ/MKdPwL0HRFKEaZaXOyCd
         15Md8g4gE5WD07wZR7ak3RHqW6Z9qNSAa1V1mbCOt89n5EdSd28rp8ZJ6w/lXLu6tMWm
         aWvWCAzRV7HrKiDQ/YZzTXjoaxrL2FuxbtQt9axahDcZo6UGiSg8g6xqJ1f5dChDuKCT
         sv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPsyyO6wtxPkySNppFpX8Lbe406hDsqdaVmBaCNQXWHmqut3FjweMF1BMy8K+R2XqB8FVaS6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yOswy9EWiQMq+1mweDfJVxyDXxSizb+StL7o3cc/YUekCw96
	iXWo2p1CAKWSBrQaFheFofFHc+P3srsxM65wI/MWWNerQgWQn7mHdszXovtCdiesYCJobNFJyMN
	aotcFkWrFrdTjfQUzl96M6LzswyvKozgLIDVrRauN
X-Gm-Gg: ASbGncsJsb6bndTMlbNQY7kXTbqCLNqzSRWIAH0MtSWSfkbw73S15QBn8DHpZVw0/xv
	QOElaG69YaOsmnhw6oKjgT33CEbee3GXakD59VUU/YPCCUCNj00SbbOCdRKirKZIFCU7HjZbOPo
	xF6K3qt5NWytqRIXQC0nfFJx2s4ODL8sJf8cWAjFCUXQGIAKvnZR7rO15USOXj4BU87IdMem2Q+
	y5oikpk+opID1whJYXgmENt1VZRWVELvl+GcywskcVDVh6TaA+fwgBkVbty1l1QAAYPCw==
X-Google-Smtp-Source: AGHT+IFiXZPFoW3XumCylfcB7j13+foGPrt/PBXHdC1d5im6TR7Pl10kLZ/EEoKE1RNBjalMg75qFAT+YfmAMkkUFZ0=
X-Received: by 2002:a05:690e:1c08:b0:63e:4150:4a0b with SMTP id
 956f58d0204a3-63e41504b4cmr12608126d50.64.1761306607028; Fri, 24 Oct 2025
 04:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024093901.1202924-1-lizhi.xu@windriver.com>
In-Reply-To: <20251024093901.1202924-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 04:49:55 -0700
X-Gm-Features: AS18NWCyXWglYAph4MhDJQMx_rCfCfaeUc5A_R94Ms8hmdKV9GKUS6s1Tfgfq_I
Message-ID: <CANn89iKxjOPyP7h-8bCtx1SwCM1FaXDAXfcdCW7uXxKsy49L3w@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, horms@kernel.org, jreuter@yaina.de, kuba@kernel.org, 
	kuniyu@google.com, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:39=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2=
.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat=
,
> a UAF is triggered.
>
> To avoid this UAF, defer the put operation to rose_t0timer_expiry() and
> stop restarting t0timer after putting the neighbor.
>
> When putting the neighbor, set the neighbor to NULL. Setting neighbor to
> NULL prevents rose_t0timer_expiry() from restarting t0timer.
>
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_a=
x25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
>
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>
> Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: Putting the neighbor stops t0timer from automatically starting
> V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
>
>  include/net/rose.h   | 12 ++++++++++++
>  net/rose/rose_link.c |  5 +++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..33de310ba778 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct rose_neigh =
*rose_neigh)
>         }
>  }
>
> +static inline void rose_neigh_putex(struct rose_neigh **roseneigh)
> +{
> +       struct rose_neigh *rose_neigh =3D *roseneigh;
> +       if (refcount_dec_and_test(&rose_neigh->use)) {
> +               if (rose_neigh->ax25)
> +                       ax25_cb_put(rose_neigh->ax25);
> +               kfree(rose_neigh->digipeat);
> +               kfree(rose_neigh);
> +               *roseneigh =3D NULL;
> +       }
> +}

You have not even compiled this patch.

Also please carefully read Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

