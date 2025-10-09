Return-Path: <netdev+bounces-228335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F7BC8127
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B785A344CE5
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646F28935C;
	Thu,  9 Oct 2025 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHEK6i2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8342857F2
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999116; cv=none; b=fh09Xft1V6foCvQUKtDiajokDdb83/Bajujue9R2W5XpS49EwK09PI+nm+lnoMa+ErYsdpVAsvcwXI6qkzMAHj5RdnQrvhivTL2mJYyxfz5M/z/LyAMXBrsB58h0joKrkVi6pXs4aRZnF6FSPLgikdAK70WCJgf/Gx+FNzxZAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999116; c=relaxed/simple;
	bh=FQ+shGWmBVc44oL0Bqn7e7fPtD4QN75FTnqke7XtEdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWEEzD9EUdG5L46QjqwKqm184yK2NnafmYVkGoSmBVT0H8A8x+6YxG0nUlCWNfV49+ktfoUtTRsifYS+y+i6YnANvWmF0GMKLqs5h5FHc8BlK2lmTEDfMxbT9FgxvpazyjoMpa3FOvbgxGE6uxr5UTevRnunxD8Pt2sbWdQIGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHEK6i2R; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42486ed0706so4254605ab.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999114; x=1760603914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJdA2wzrVpL1AvGn+9fzAMMPbIvnSOMtWQ2QiUJOEpk=;
        b=XHEK6i2RlrET375+xk7wrU/UER/6YNZ7h7+O1pqleAxDbvKgBbaHrX8rdVYXAbHcpt
         hmghsEvIQ9Py8NX6IbP6NS0cHQmCb+jbK1C2i/gm7mcJHj4EzNsydTYmA0DVj2S+KBkx
         cNd+vJaA+mb0itJvsjDkm75NCuZdHCPvOhCz4QqW/uW0bvuSM7UCtBDZiyFI53trHw2k
         egwmFkFcjXcy2jeteMKKHodUlLfPIiL40ytQC1WeGlfkKbZTqT1ge9gnrEwNtnXM1p7q
         sQw0S1XACLlUpwUsZ0E4nE+xj7xqcJwi5PGEcxug3TDhUpm/8OkwHhdQDD3r3hfCcfMg
         I0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999114; x=1760603914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJdA2wzrVpL1AvGn+9fzAMMPbIvnSOMtWQ2QiUJOEpk=;
        b=cY0qLZt3c2URuiLqAe2/D6G5Jtgx331XBTKGbpo0YzdVSpyg3djUEFp4zORmxS/qDs
         uej3ePYlqc9T/6JktzZ3mXCIN3lEFUf1c0Up7WFDsnZxtesV7s9Ii57DkoekLYp1QzzW
         WCsi4ByfjysYUbLM4kRX5EDSiHhFQBD02MfnCSTVuERlkXKhL+XKedesAsE/l9rMM8d8
         0kNq/0FMYZEYYzysdkWFZWup2S0xOW2NBg1+IDPZnhPejvcOsfV2RlpmnW/e6PFHgzjd
         8xs9U8juv9a50MFZ3x5nyIL8YdYgEGB/PpFt07KFuLIbBEWgqg0EwkSquA5LVFATbTvG
         KyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUS1Tvyhfz6cK5IYytArVnz5g65iXh8u5c4PkPk8SwFa6IeZ0yOtH93Dt7p8BFMMBVGvPR9MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/GI+HqSg4kPfRIRjGDVrnhWiS+ALwQVcK8zlGQjeWu9Mqg4T
	nBlsFDgoHnoRBRCAtWEYLRmAUbbMeh6mb9JOJLb5F7lelHyMfq2GR5Uu8JVsryHqSG/Tbe7vM9V
	iueS8TilEZf6Efo1gAakqFNl8NknhC+aIav0vUEA=
X-Gm-Gg: ASbGncsZjSP6wTXynuNotpvd2wanQRAJZg/ibKWKPsvTEnTLFsmv7ePcQd8D2q3jSjB
	RTw6YZbK6hJ8IKcGzSlsIP/qmXEhIYsBe+nSZdlB/QdeEPoSm3SEcPxjzEvkvdK8HgXOPMVMvaZ
	2eCXVm8e1Kz3b8q/kS+EX9EtyLfOIrOINAROn7WZkv3cMeZFdwqwV0ouP78+lMjwkadpsYY6RJ1
	vxHVrqFa+fGm/bmMoJv65EDSRsRTNk=
X-Google-Smtp-Source: AGHT+IGgDpJZw70+gYM2+AKgrpw+FhwIc7t9dLrpTQ7TwmqH2Zts3lJgbj9Alx5YVex6vzAB8wLcj4rDf/aonrKTWhE=
X-Received: by 2002:a05:6e02:1529:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-42f8736a83fmr67845345ab.10.1759999113970; Thu, 09 Oct 2025
 01:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-2-edumazet@google.com>
 <4e997355-1c76-429b-b67f-2c543fd0853a@intel.com> <aOVs9yvrwkH0dCDJ@boxer>
In-Reply-To: <aOVs9yvrwkH0dCDJ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Oct 2025 16:37:56 +0800
X-Gm-Features: AS18NWC8efYUnEY9e0cb7Vv3Mwf0SN7TrGBcblA2wqV-4AJlPgqo93F1_Ry2deY
Message-ID: <CAL+tcoBN9puWX-sTGvTiBN0Hg5oXKR3mjv783YXeR4Bsovuxkw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/5] net: add add indirect call wrapper in skb_release_head_state()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:42=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Oct 07, 2025 at 05:26:46PM +0200, Alexander Lobakin wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Mon,  6 Oct 2025 19:30:59 +0000
> >
> > > While stress testing UDP senders on a host with expensive indirect
> > > calls, I found cpus processing TX completions where showing
> > > a very high cost (20%) in sock_wfree() due to
> > > CONFIG_MITIGATION_RETPOLINE=3Dy.
> > >
> > > Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() mac=
ro.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/core/skbuff.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..c9c06f9a8d6085f8d0907=
b412e050a60c835a6e8 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -1136,7 +1136,9 @@ void skb_release_head_state(struct sk_buff *skb=
)
> > >     skb_dst_drop(skb);
> > >     if (skb->destructor) {
> > >             DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> > > -           skb->destructor(skb);
> > > +           INDIRECT_CALL_3(skb->destructor,
> > > +                           tcp_wfree, __sock_wfree, sock_wfree,
> > > +                           skb);
> >
> > Not sure, but maybe we could add generic XSk skb destructor here as
> > well?

I added the following snippet[1] and only saw a stable ~1% improvement
when sending 64 size packets with xdpsock.

I'm not so sure it deserves a follow-up patch to Eric's series. Better
than nothing? Any ideas on this one?

[1]
INDIRECT_CALL_4(skb->destructor, tcp_wfree, __sock_wfree, sock_wfree,
xsk_destruct_skb, skb);

>>  Or it's not that important as generic XSk is not the best way to
> > use XDP sockets?

Yes, it surely matters. At least, virtio_net and veth need this copy
mode. And I've been working on batch xmit to ramp up the generic path.

> >
> > Maciej, what do you think?
>
> I would appreciate it as there has been various attempts to optmize xsk
> generic xmit path.

So do I!

Thanks,
Jason


>
> >
> > >     }
> > >  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
> > >     nf_conntrack_put(skb_nfct(skb));
> >
> > Thanks,
> > Olek
>

