Return-Path: <netdev+bounces-141463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CA9BB082
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2571C20FB6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D041ABEB1;
	Mon,  4 Nov 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCb78BQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B518B462
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714646; cv=none; b=He/nNGqRBneuFOJT1KQpk0EdBVCTcbDCGK/TgPI+/PB2iYG1HeWFOoc2PePOpnvljoC93EmbrYmkkn823on9T6LGshsFd8gM1qcy0vP9rgr5AYPFAjam/xHgQe4ObCvQ1LMlzRL4r7QZrT8xrktjpTvf/WROfH5TqhZbBO2iuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714646; c=relaxed/simple;
	bh=MhSgiDRe9kWlu3krkcq44QnT0I6xrXTBB2qUzTIjdbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl5tsMNKBnw213zm99ZONLSJZvSkC1EC2wgtYEHRzsl/HU6U0RJMuCrZtu1IcCSqEUCA8FHpxiEsUb968iM8epjvSPAqR6/TLtprMbQ1+hjGmXQHEK7ObMCj3YchrLE0mvCqeMyqg9c1Nqg0VQy/FeQMw+MA5r3VX9wnluTSjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCb78BQj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso1511015a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730714643; x=1731319443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWHQXABSdBQg/uFBmbjMbidGd580f14Xd7VejbWBnfw=;
        b=TCb78BQjrcfRHuP+ehX0iyTN/N0hvk6WFSpJVpHRABoE2yuBrVQ+X7ilw7sUNoCjVQ
         Vha2Cp263Spvn8pMeJnCFIn9EYsfJzMeL928GrDlxefHgp8jPdJx/pqIYxodhGveePJX
         SLLtcNGmAZOxncjtS1Vo/HkdUR8Z7d30Xtg3Z3qp268V2HG/8jAiBNXpSdLUqIt+54ZL
         3nkF1X8ZtWb/ik9WGgnZW++bouZaH7KLfwnSq7A9NXsojXsuxuHA+B0FZDqHjAazUwPe
         TzCGhAEUuDq9lUdrfa/mFWNtwtKMMVeen1jh+2O9EZeB75UuJbtjudQwzhBvgz6FiEcm
         F8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714643; x=1731319443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWHQXABSdBQg/uFBmbjMbidGd580f14Xd7VejbWBnfw=;
        b=bLdcH07MJUp9ctSTjo8ej7s5BdWBon5cdsogkNI1f6Le0NCVdYRfXQD0/Z3SvlZgyB
         N8/6HqHsi61TCo3+elEkcyRdaDnIqqhMUP9R+Rforu1m8ExaAFvXQz2NoDCSbC4H/rVG
         kzT5RXPQx209zbP9GY5M21iOq9xpXWEbJJEt7eieTXs9NnxoJUZLNy2eURwv3BijjuJo
         3/8G85CUWEpubzjQ/UoYY82NPGg4zEjILWk9b9UBv3gp03MMrVEu/+oKBlFSnCKQCKpE
         OrICtMqJPNhQMbTzJhQYWPHfwlZ8hShmFSm4eo6W1X8VxM+Rn/+qgZDcJQoA9bj6oDuV
         kTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20EqNl6IDFzOIgOL5sWJSpic1I3nV3nxmxQ8cGjBx26g0gAA7Q9R+UH9y/FeDEaDGP1lBevk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qXhGDN4+UA6dvwmLCNVHpZJk4/XGoZ/YsdITxGKXFPvQ/RnI
	BQI9EIysvduDjZ5lj3vzSM0UAm5whEm07/qHhVrRKDWU+gGtESRUAqJh6Pgc5Ok4CyckpIg1wFO
	tUZjMXz+FfX9ORjX951s20onUwl77HQQ5IlaX
X-Google-Smtp-Source: AGHT+IGWCN4mosqMf3EbabWrtqPlRv2GtYs4xdwKhJRvXbfP1X66v9dmfnGhmhV6cyrmOqK3QuBDpmNc0jWAqJFJDCU=
X-Received: by 2002:a05:6402:2105:b0:5c9:5ac1:df6c with SMTP id
 4fb4d7f45d1cf-5cea9732262mr12444587a12.33.1730714642898; Mon, 04 Nov 2024
 02:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104040218.193632-1-danielyangkang@gmail.com>
In-Reply-To: <20241104040218.193632-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 11:03:51 +0100
Message-ID: <CANn89iJCccfcfAFxMO3NhpVwF87OPLQAFQPxnyBkbvSf=WAM0Q@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:02=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> KMSAN detects uninitialized memory stored to memory by
> bpf_clone_redirect(). Adding a check to the transmission path to find
> malformed headers prevents this issue. Specifically, we check if the leng=
th
> of the data stored in skb is less than the minimum device header length. =
If
> so, drop the packet since the skb cannot contain a valid device header.
> Also check if mac_header_len(skb) is outside the range provided of valid
> device header lengths.
>
> Testing this patch with syzbot removes the bug.
>
> Macro added to not affect normal builds.
>
> Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.=
org/pub/scm/linux/kernel/git/tj/sched_ext")
> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D346474e3bf0b26bd3090
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> v1: Enclosed in macro to not affect normal builds
>
>  net/core/filter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cd3524cb3..9c5786f9c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2191,6 +2191,14 @@ static int __bpf_redirect_common(struct sk_buff *s=
kb, struct net_device *dev,
>                 return -ERANGE;
>         }
>
> +#if IS_ENABLED(CONFIG_KMSAN)
> +       if (unlikely(skb->len < dev->min_header_len ||
> +                    skb_mac_header_len(skb) < dev->min_header_len ||
> +                    skb_mac_header_len(skb) > dev->hard_header_len)) {
> +               kfree_skb(skb);
> +               return -ERANGE;
> +       }
> +#endif
>         bpf_push_mac_rcsum(skb);
>         return flags & BPF_F_INGRESS ?
>                __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
> --
> 2.39.2
>

I am not a BPF maintainer, but for the record I think it is wrong to
silence KMSAN and give the impression a bug is 'removed'.

