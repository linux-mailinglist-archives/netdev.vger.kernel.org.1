Return-Path: <netdev+bounces-240842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1496C7B06D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7623B35E542
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48EF1A3BD7;
	Fri, 21 Nov 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="whq4ZY09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72521771C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744884; cv=none; b=RiQ4Z3aBLAirrwVJ7tMWr7beIoG2HKNa9noBhKOvhnE155jwBA+gMPR1H/892F+ymrPVJ/HlBQWVoFjwBCWLUf2EyvOJpwCIaxhHGmArWmov/1KznSsiINRQpaMIbthAo2OYVDbYVdcqudmX6EZVY3bc+O16aoxZ/o4TN7Zvwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744884; c=relaxed/simple;
	bh=1auCa1RxEKcFDg9AxDDX42yca4RVULNr5t1KI7cNADI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bScqfwElTWbQlQuAg3+i2/TOjHBiyRMubq1WEIp9o9fjOnEz2996IXPqRBaIFw5RZ+Gc27XntkyGrgHJXZs1UdgT1hqot6cy4P7hZw+glduO/mKWKlZosU23D11rUuEr/Pq/cm9oZTT39RXne6EonxY3Fj4BwPPEYFrkrA2Wg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=whq4ZY09; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29516a36affso31644805ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763744882; x=1764349682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUlz30EyaM3mcQ4eUluqZp6Sq+g/W6QNwpjYYqJN4RY=;
        b=whq4ZY09ANr8+kJhbmp3o9TaVKVP8IvJ5ordycFAob4VD0BCunYAi3l/KuobGI7hfm
         xa8Q0yOtJ39cORQyPRjgDXD6IBorJefOWU3ehGovEU0BwpI3eS/GWEKL+MmVR/FY3Ppu
         pdQw57ercnkwLPoFJ3n9J2Cnr3aXSFQFVaw0qxWPFY6kaPfvwojYAEuvOWNcZctJAMIS
         ENX73bUMZqdNc4HdcdfFBNE5k8HktFJBZgPCac2IvbvGCNq5NO2WQoBuEHDi8j+tRJeb
         OlgubdXmmT5raDOMSPQ+TCmVDNAAK7GIkgY8KwMTQWP5jq9OThtJE/VmqTpZ9rKqMc0v
         CBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744882; x=1764349682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUlz30EyaM3mcQ4eUluqZp6Sq+g/W6QNwpjYYqJN4RY=;
        b=uRhwb0ieSxmKcIHYRKWVPT5OkxeRAakPEKMDmVbkfUJRL/5OqPAXKsd8JysFQkQVBR
         JgdGCxYGq9iC13LQXDdEiRtukjk9zzD1wq3j/stPBmx8YHhPPxAkbvKl4vNoKsrQro1X
         8kaA+g0k0/XGnV4Wiuh79uHR4GNJeogpiZKEqZRJXRcVICIT2hhOeXpZiaBa7KiZpoZh
         PyeeTrXDYdMx9bFkk8k6UsenEX+aZm/xdsn7Ony2ExJvvOSNxVo74l6xkl5Tp4Gs7eLT
         GOjConAa7ZgqIX59P54e6dPhr7yrOfxxMHArjmG24rr6F/kRGb23GTQ0Jhv4Gm1yZdXP
         HObw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7fk87fZN15UWERt0WZvA0nD2tlSTniLg4psJNpOk/saj4qOQEGP3Za5SnCF5MQ4n41G+pBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWUiqqFl5YtD045A65uB4nh14ls3W1lLK5tsiHhv76mWjqNwD
	wck5e57GhA8q/aflX83/YohCZ+WpWQre/e8RNOM1T3JZGHQchBYcVrSe6RmhOTAVpcsAguWiCw5
	KYUnPfhoVPXSfbGkam6mRIT2zzCVrZRfvG0bw7CKs
X-Gm-Gg: ASbGncvajv7owBokgBxlZlLilOzV7uD5QPwRj+oojtuqoDfz04iP7olOxO2TTYfOXwU
	7WTGNDQRgrg2EstnpsctsRlaUDVAC4LoblXU9BDO0bF3y59lbecvwE78koteH+bC6AV2YdV3BpJ
	kdvQGTMjgsHsvp0408UpgYAS3bZP7O2rBXVRmBmbYBIoWwb8bbTUIPxGME5uasDrXrvlnZRsi1s
	1m8oLOwJX/3NtS+z3XBrj8N1z6PcKtpPzTCsc49gQBAQnOHux3rv90G3AReBkhkbO7yh67+S3Hd
	BXA=
X-Google-Smtp-Source: AGHT+IEV3la6NXwNJYZQykyfivCVrlP9CKWgNZcO5B4+Uua6dEeDizI+4rTgMUd9UBFFMOzW/aqgzbS+ZbO8yh9YJdA=
X-Received: by 2002:a17:90b:5291:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-34733e2cf72mr3640309a91.6.1763744882053; Fri, 21 Nov 2025
 09:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121154100.1616228-1-edumazet@google.com>
In-Reply-To: <20251121154100.1616228-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Nov 2025 12:07:51 -0500
X-Gm-Features: AWmQ_bmybVGZVIrORa1Y4TA9kBMp3QrlgXdE_Zil7murYXAedVvfLvMx1XShElc
Message-ID: <CAM0EoMmof-15_1car5Taws79h=v7jyOtDWtPxTwMp1590iXrYw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 10:41=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot reported that tcf_get_base_ptr() can be called while transport
> header is not set [1].
>
> Instead of returning a dangling pointer, return NULL.
>
> Fix tcf_get_base_ptr() callers to handle this NULL value.
>
> [1]
>  WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 skb_transport=
_header include/linux/skbuff.h:3071 [inline]
>  WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 tcf_get_base_=
ptr include/net/pkt_cls.h:539 [inline]
>  WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 em_nbyte_matc=
h+0x2d8/0x3f0 net/sched/em_nbyte.c:43
> Modules linked in:
> CPU: 1 UID: 0 PID: 6019 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Call Trace:
>  <TASK>
>   tcf_em_match net/sched/ematch.c:494 [inline]
>   __tcf_em_tree_match+0x1ac/0x770 net/sched/ematch.c:520
>   tcf_em_tree_match include/net/pkt_cls.h:512 [inline]
>   basic_classify+0x115/0x2d0 net/sched/cls_basic.c:50
>   tc_classify include/net/tc_wrapper.h:197 [inline]
>   __tcf_classify net/sched/cls_api.c:1764 [inline]
>   tcf_classify+0x4cf/0x1140 net/sched/cls_api.c:1860
>   multiq_classify net/sched/sch_multiq.c:39 [inline]
>   multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
>   dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
>   __dev_xmit_skb net/core/dev.c:4214 [inline]
>   __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
>   packet_snd net/packet/af_packet.c:3076 [inline]
>   packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
>   sock_sendmsg_nosec net/socket.c:727 [inline]
>   __sock_sendmsg+0x21c/0x270 net/socket.c:742
>   ____sys_sendmsg+0x505/0x830 net/socket.c:2630
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6920855a.a70a0220.2ea503.0058.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  include/net/pkt_cls.h |  2 ++
>  net/sched/em_cmp.c    |  5 ++++-
>  net/sched/em_nbyte.c  |  2 ++
>  net/sched/em_text.c   | 11 +++++++++--
>  4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index c64fd896b1f985c5f6a5b50cbb42ded640d0c9fe..99ac747b7906074c43b3eb8e3=
4cf6c07235cc81d 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -536,6 +536,8 @@ static inline unsigned char * tcf_get_base_ptr(struct=
 sk_buff *skb, int layer)
>                 case TCF_LAYER_NETWORK:
>                         return skb_network_header(skb);
>                 case TCF_LAYER_TRANSPORT:
> +                       if (!skb_transport_header_was_set(skb))
> +                               break;
>                         return skb_transport_header(skb);
>         }
>
> diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
> index 64b637f18bc7d40509bf5c9f7679cfbc2922af1c..48c1bce74f498d0b4ee3d1efd=
e96459b0dac5896 100644
> --- a/net/sched/em_cmp.c
> +++ b/net/sched/em_cmp.c
> @@ -22,9 +22,12 @@ static int em_cmp_match(struct sk_buff *skb, struct tc=
f_ematch *em,
>                         struct tcf_pkt_info *info)
>  {
>         struct tcf_em_cmp *cmp =3D (struct tcf_em_cmp *) em->data;
> -       unsigned char *ptr =3D tcf_get_base_ptr(skb, cmp->layer) + cmp->o=
ff;
> +       unsigned char *ptr =3D tcf_get_base_ptr(skb, cmp->layer);
>         u32 val =3D 0;
>
> +       if (!ptr)
> +               return 0;
> +       ptr +=3D cmp->off;
>         if (!tcf_valid_offset(skb, ptr, cmp->align))
>                 return 0;
>
> diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
> index 4f9f21a05d5e40aadfdc4c339b8178ad43dc2c8b..c65ffa5fff946edbc30a65ad9=
9087bf664665e32 100644
> --- a/net/sched/em_nbyte.c
> +++ b/net/sched/em_nbyte.c
> @@ -42,6 +42,8 @@ static int em_nbyte_match(struct sk_buff *skb, struct t=
cf_ematch *em,
>         struct nbyte_data *nbyte =3D (struct nbyte_data *) em->data;
>         unsigned char *ptr =3D tcf_get_base_ptr(skb, nbyte->hdr.layer);
>
> +       if (!ptr)
> +               return 0;
>         ptr +=3D nbyte->hdr.off;
>
>         if (!tcf_valid_offset(skb, ptr, nbyte->hdr.len))
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 6b3d0af72c39c7fb1e3290e24bf94f5bf9e0b358..692e2be1793e9961bcd4516ba=
f54a05341f6ac5d 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -29,12 +29,19 @@ static int em_text_match(struct sk_buff *skb, struct =
tcf_ematch *m,
>                          struct tcf_pkt_info *info)
>  {
>         struct text_match *tm =3D EM_TEXT_PRIV(m);
> +       unsigned char *ptr;
>         int from, to;
>
> -       from =3D tcf_get_base_ptr(skb, tm->from_layer) - skb->data;
> +       ptr =3D tcf_get_base_ptr(skb, tm->from_layer);
> +       if (!ptr)
> +               return 0;
> +       from =3D ptr - skb->data;
>         from +=3D tm->from_offset;
>
> -       to =3D tcf_get_base_ptr(skb, tm->to_layer) - skb->data;
> +       ptr =3D tcf_get_base_ptr(skb, tm->to_layer);
> +       if (!ptr)
> +               return 0;
> +       to =3D ptr - skb->data;
>         to +=3D tm->to_offset;
>
>         return skb_find_text(skb, from, to, tm->config) !=3D UINT_MAX;
> --
> 2.52.0.460.gd25c4c69ec-goog
>

