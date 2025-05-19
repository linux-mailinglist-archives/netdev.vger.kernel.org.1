Return-Path: <netdev+bounces-191614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6071ABC755
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18781B641F8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1A1E47CC;
	Mon, 19 May 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8dqOgy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A21DA21
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680335; cv=none; b=sw9Di2VtLAARsMMjnNqhbZFhTfeApv2BrB/MZkZfICCYW1ppwSjfdHMqdoc7WIMezLSnaaCvpIRdzOsQi2bMnJb5dNy7uT0G7T+JD8l6CoVMMR5RdrjapN6hAeZ1CO2lHdYpjbHwjMDnbEgck3xGANpBwBv/xiEr6e0Tkyg6798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680335; c=relaxed/simple;
	bh=qixL8WtENA/y47zs5WPsanzQIyfZpO1I0UpQSU7JL9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDD+CWf2biP8trgDmYnznadKFiiAQmrP4eZYh1Fq9GKYhIIl7ByOaSOCT8NeWQHvUvrCgPHq8pVvu52VKnurUklgP7vbZIUnXh4sX6v+2t91bEiY+GB2DE4FMx3CpLGimFwu4JEMUwjAwsr/Vdrjyp9OZEM1AGufJIYsilNyx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8dqOgy5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso118325e9.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747680331; x=1748285131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uI0u1meq1DSWC2d3l+uIBBA0xgtWtQ+JRUsL+sxc5w=;
        b=A8dqOgy5WOwmTLopIY1uJE5JRfMeEXR3OW7IVGSkoaUiu21IVlChnKFcDrAX+letcm
         l0b+WXOd6ugfq2rSkRool90cgqd9nD5xBZPNuVk+IITdN5jyVYZqNzqJzBEVY2HJSq7E
         3R4TNbjaVFJt2Il446hqbmB0KZshQZwbiVtVeEFsua0gHhudH40rtPel+z9p59EZNXyt
         fdlQfnTf1tAMI0Ohxb/+T8zGgyOuO0rTXtwHy042CWR+Jbdb9Gw2jlys+1IcZ9wEtSyE
         sgg4qSktXf/T+NScgjcC0uuV78idbMcyOvc+vrhzVM3ZdSAzKT3rfzK+VM0U2UraolCw
         dNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747680331; x=1748285131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uI0u1meq1DSWC2d3l+uIBBA0xgtWtQ+JRUsL+sxc5w=;
        b=TmqmgSRWEg8L0rut4acD8FhF05zOfFlRfYlcDFahkh1KFihCJJsrl4THb5z6ARbEDz
         xycg4cAcFr3kR0L9yKNgYDXWLGfJvthiTbSMbsTQUEMkBYMEQaSjV3Gtn9noJCnHz7BP
         LAHH5e9SDduzUFOplheL1VxoFiIyJMTeWdAUPSZG0M/kOXpAGtDgE5y6aZ8INQcbj705
         +dqmFafnZufkfNSlV5umqBG0+3EltxtHg/kO5eJdX5e/O+oSZUPDdyONy5SDWocntKdn
         Mvpnb+cSzQjdnn/lhwbrNFXCMJe191CzClNzHajT8JsAAhyeXINySIvksCeSId8c9/3r
         NZUg==
X-Forwarded-Encrypted: i=1; AJvYcCVUhoykoucYgpGUhrqZYliYdQArpdx/Q50C3q9TBk2TsngSgfihbvq/1s8oK8rUUuMSdf/cjsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwvTtpdz3qTsIsh/EvEHqA4jNmQpmoApDkD6EXqRrM+kwXZuG
	pvWUm+qkLdEkxKZxFCiYIBM2yLclUPCtpxwuNQznV3TBVPRdRl9wUddfnusjbWogU26rm2pRyCq
	YUU8ZiBF9e5LLqfLXCxJ0W4H8C0z1lUUVsSmAtd2y
X-Gm-Gg: ASbGncus8KkdSNiVfukQPt9WzEdCGVfXtAhAWZr17HWgEszwWW56ebGp+3NI+k9VJGv
	pq0+rI8jbzGcGJ1yzbd29OuxmxH2D2cin41feMODP/LIy6sHbYHVg984g6skEyNpOC1qA/ssiWM
	9s5KiG733CvAvB0xX0A0VBP+pFpp54lghtQtsCQ+m8DxvkzikThYW2YN6PipPE5GNUwPSlo0nmG
	w==
X-Google-Smtp-Source: AGHT+IEi4No6J063KwsVoQNLxNxjrCv7jm/u9i3e5Q/uH+0pyHVkWYIXIES2WdEQ/sfu/KRTy3tguljTVJckDxdkD2Q=
X-Received: by 2002:a7b:ce8d:0:b0:43b:c2cc:5075 with SMTP id
 5b1f17b1804b1-4440027c1efmr3272695e9.5.1747680331414; Mon, 19 May 2025
 11:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
 <20250517001110.183077-7-hramamurthy@google.com> <50be88c9-2cb3-421d-a2bf-4ed9c7d58c58@linux.dev>
In-Reply-To: <50be88c9-2cb3-421d-a2bf-4ed9c7d58c58@linux.dev>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 19 May 2025 11:45:19 -0700
X-Gm-Features: AX0GCFtuTKgp1zKfAPn8KbknOLyEMpCOVc7hNlTvX5suHLNuXThS_kS4KxvyiPs
Message-ID: <CAG-FcCO7H=1Xj5B830RA-=+W8umUqq=WdOjwNqzeKvJLeMgywA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/8] gve: Add rx hardware timestamp expansion
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, richardcochran@gmail.com, 
	jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.


On Sun, May 18, 2025 at 2:45=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 17.05.2025 01:11, Harshitha Ramamurthy wrote:
> > From: John Fraker <jfraker@google.com>
> >
> > Allow the rx path to recover the high 32 bits of the full 64 bit rx
> > timestamp.
> >
> > Use the low 32 bits of the last synced nic time and the 32 bits of the
> > timestamp provided in the rx descriptor to generate a difference, which
> > is then applied to the last synced nic time to reconstruct the complete
> > 64-bit timestamp.
> >
> > This scheme remains accurate as long as no more than ~2 seconds have
> > passed between the last read of the nic clock and the timestamping
> > application of the received packet.
> >
> > Signed-off-by: John Fraker <jfraker@google.com>
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >   Changes in v2:
> >   - Add the missing READ_ONCE (Joe Damato)
> > ---
> >   drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 +++++++++++++++++++=
+
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index dcb0545baa50..c03c3741e0d4 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
> >       skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
> >   }
> >
> > +/* Expand the hardware timestamp to the full 64 bits of width, and add=
 it to the
> > + * skb.
> > + *
> > + * This algorithm works by using the passed hardware timestamp to gene=
rate a
> > + * diff relative to the last read of the nic clock. This diff can be p=
ositive or
> > + * negative, as it is possible that we have read the clock more recent=
ly than
> > + * the hardware has received this packet. To detect this, we use the h=
igh bit of
> > + * the diff, and assume that the read is more recent if the high bit i=
s set. In
> > + * this case we invert the process.
> > + *
> > + * Note that this means if the time delta between packet reception and=
 the last
> > + * clock read is greater than ~2 seconds, this will provide invalid re=
sults.
> > + */
> > +static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,=
 u32 hwts)
> > +{
> > +     s64 last_read =3D READ_ONCE(rx->gve->last_sync_nic_counter);
>
> I believe last_read should be u64 as last_sync_nic_counter is u64 and
> ns_to_ktime expects u64.
>
Thanks for the suggestion. The reason to choose s64 for `last_read`
here is to use signed addition explicitly with `last_read +
(s32)diff`. This allows diff (which can be positive or negative,
depending on whether hwts is ahead of or behind low(last_read)) to
directly adjust last_read without a conditional branch, which makes
the intent clear IMO. The s64 nanosecond value is not at risk of
overflow, and the positive s64 result is then safely converted to u64
for ns_to_ktime.

I'm happy to change last_read to u64 if that's preferred for type
consistency, or I can add a comment to clarify the rationale for the
current s64 approach. Please let me know what you think. Thanks!

> > +     struct sk_buff *skb =3D rx->ctx.skb_head;
> > +     u32 low =3D (u32)last_read;
> > +     s32 diff =3D hwts - low;
> > +
> > +     skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + diff);
> > +}
> > +
> >   static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_r=
ing *rx)
> >   {
> >       if (!rx->ctx.skb_head)
>

