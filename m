Return-Path: <netdev+bounces-245543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDACD0E78
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3573050980
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F037C0EE;
	Fri, 19 Dec 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2dT+k23i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D87437C0F0
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159990; cv=pass; b=Bt1icNsPz2fSWU7LMcKPDZJ/GaIPUzPXzoA6n+OHZOIGm+d5PZrOCeL8+jS7JJQ/m/gt+cYJuMTspw39Kx6DyJca842aiKoxbLUGvAYPUsj/WM8PKW//esGQgffjBsQHseE3bccMsa2PAjVKzN+6+v3abCusM21o149tDjR8hBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159990; c=relaxed/simple;
	bh=tFakOyriUKjYNudxrW0hOhHn0ijXLPejKekeuihaG6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn8aRS5CFDgJTAbmnskYO8WMsknhOoWq5UTFqeSL0+o2MJPE6XC4ly9P3/R9bFhiMwhEw2eohYIxcMZzEjQXuUG2fS1CK66i17Ta0vEL9pUF1+XY6uojAVQw7JyiNr4qtOdNwlCQXgD2LNtDFCXczrC09FBvCswAdoSePxL8eRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2dT+k23i; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee243b98caso393631cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 07:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766159987; cv=none;
        d=google.com; s=arc-20240605;
        b=P4u944X/f4Yg6XHA9ntOJnkJRcdQcKi/vsurPKIpvpy5I4aiGX40PEdELJtJ4b2WPW
         nZOPNwRXpPy1tBkg+I8XeLc7uunkkHLBAGqWeGSgzJGWvOwe7v+RLcxdkpxyYf9xw6TM
         WaTGbn13sTjJE2zBZOcuohEYkJyfDP2x/eLCElVuR/mOs2ClV3na38ye7gvKVI3BcVPa
         RLLlngRyAaYbC7pjHAbrFZoOasexMrcBacGB1DNbyfiQMebU2rUusLWmc7FGe/qAAXC4
         1jkR0wLm/gN2W/aeLWJfhd/ZAIQuyPRgaWkrBIK+bZ5jP1JEdEG7ErrwCMagvRaZJgTy
         FHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IPLd4Lgnu4UsV4GXpUkqeXZezz5jKXOE9e2cJdpylI=;
        fh=noJhJtoV5j9AxPYeWDg0CHDLXracpM7II4+C8uQBIiM=;
        b=cuPFaEO/hmo62kUxSOO7BlZftqsgdwvxfPkBMe9h2cgCmpRzUy3qyoVHg8Z/b55c8T
         saDcteJwhI8JNBa8UxY8N313YNRSgVJx4svWH97GuyfYgL54Qc3gjLQrHqUyuCUHvUGV
         +2i4+kl+i2QBNSJz5olsElUkNgeZWZN5no3DPxwELeIFNAHI3KPcAb2ryIvQgQx79V7b
         UnKwR75UiFDFOdayf3nWgcUlyN5v7vlIBSqMW1kfh9MuKWfH4xb+nTQ2wI3ZY7Y+RUvC
         HUGaULz2XL+h2KxJ1axLQKIB2/FP/wKvZaEqRPvs5/0+1MKbNq/hoyLlnQEkY2zbT0iD
         N9NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159987; x=1766764787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IPLd4Lgnu4UsV4GXpUkqeXZezz5jKXOE9e2cJdpylI=;
        b=2dT+k23iKVBMdnocWDJzvjOwe6rYjKSCxsm4ND5E+38UCYmt0MLDW1/YWr/wCDLQzt
         eqwhEDE7VpQ92Gu0E68TblW0v8zYs5aFwkbrACcRtn2aibF56R0Xx25dlK2HKqKk+V5q
         nGteV9g9gSYCoOeYPv/dQgprNu3DfcCOtdgvX13zGozUXpS06t3eRxLK882pLZa+BZXF
         hYNeuVYoKxKP41ddeod8wq69sqY2OU+EBi77kyTYwDAqqFkTiAmvItRj/ABJiP1cP57c
         ANdTXgHxyi/zQ2gzHIMJ+/SJLZhXALBjPCkXgpR2nN6r4BHIGi9hlQGTa5HkMZvrVtPX
         GL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159987; x=1766764787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IPLd4Lgnu4UsV4GXpUkqeXZezz5jKXOE9e2cJdpylI=;
        b=wlzuRMpVMmOzGryRcfV8b0fUk3YW4cEWMLgMpmfBPG+EAkkfQ/6ucwwuwgsCZ6o9M5
         3gGPV+oX+327hHTkGvHxYG0IPLnysthOxQAIqVlyjzpPxLM5OTDT18MsB8wM8oqUTq88
         DQB4BYbENRHfom0r01W8TYmQ79LxcB/1u8b2XcfLvoxVkAOsSHbLA1QbTzaiEUeD+PKU
         wF1U1xNXxeB9O/w30sia4z+p7qulxNqnAjVNrSZlcC0Fizfsg7v9ibWp2k9u6pc3E1++
         4xGu6HBL8xxrWxkCOaA2SUzvZNfFpSEUNKKKBViOZKQZXxoE7WgW3CE0wJ4zmPkbO7Ev
         RPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7qs1eCX+WJYHtGfxdCofLVcwH2yW+8vxCxbYB6YVHXw0CKUCJb4w8ZoWr278oYLQNxh0KtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpHRIfbMT77JqZLrr5+W8/KPm1/d2QZfEKKP3J/owIAsjnUp6
	uP7jVxLYb9yAkk2DmK6FxgzVu2hTzcv5VBtyGIcmm5uWx9PgMy/0F1BTloVFSQQ8FsSNRHlp7/v
	WHn8bbPDpso+BGgfHTQQ9wGyG5HJnYH+sRGhmURew
X-Gm-Gg: AY/fxX7R7BsKUaRKFoFyATdXsSYwpOtt0aEFi3p6MXleTdvd4Oc0WKqCy3dRJjuEl9T
	7jyVbAbLHTUQapSqOVKmV4AsKhBlludEA34OXFQu0OZCuCIg8huJ71QF5BdI9DVwzhc0TPTIG6z
	PzI6YB5gshyr3PwuslcNjwIbtKkWUCkEj3XQ9975WWpHho+a0JclEy4sMGDK+mHxpUfbAfjaa4Y
	ghwjGF8lfXgFiCyPQTtJVdqyTPPw3HZTsU4avoLjT3AoxF2epwmnR2ZNk+L4cOMo+F5fzAxnFQe
	+Mv4MyxKi97UB7zwWDqWN65nM0xmDmxDKiq7PNtnjgXFyGDm8zVjjxjK3Y8=
X-Google-Smtp-Source: AGHT+IG12xBNmE1kRnIu/+egq+WUo0+aXxf8p3NgqB0lnb2WE0dVPFAMWGjYkBqulKf+0NpUovHwel91tPyvempbMOo=
X-Received: by 2002:ac8:5dc9:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4f4af0c2563mr7402971cf.18.1766159986399; Fri, 19 Dec 2025
 07:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
 <CADVnQy=-UP9jJ5-bv=aRYL5fEtpjscDEAC1G=_cCM4gF10W8ew@mail.gmail.com> <04828827-e664-4fbc-b96f-ce149da7c410@cdn77.com>
In-Reply-To: <04828827-e664-4fbc-b96f-ce149da7c410@cdn77.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 19 Dec 2025 10:59:29 -0500
X-Gm-Features: AQt7F2o0bLF5OvLKAPTmlfhcYnBMsM0_KAZH7-zSPWTvqliMh2hFl-cu385ZOdw
Message-ID: <CADVnQykeJh+TL1tbOVfcgAJvsk_2f3OpE2-K6m_yqc9Bu9PZEw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clarify tcp_congestion_ops functions comments
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 2:37=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> Hi Neal,
>
> On 12/18/25 2:37 PM, Neal Cardwell wrote:
>
> >
> > Perhaps something like the following.
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 10706a1753e96..d35908bc977db 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1326,12 +1326,28 @@ struct rate_sample {
> >   struct tcp_congestion_ops {
> >   /* fast path fields are put first to fill one cache line */
> >
> > +       /* A congestion control (CC) must provide one of either:
> > +        *
> > +        * (a) a cong_avoid function, if the CC wants to use the core T=
CP
> > +        *     stack's default functionality to implement a "classic"
> > +        *     (Reno/CUBIC-style) response to packet loss, RFC3168 ECN,
> > +        *     idle periods, pacing rate computations, etc.
> > +        *
> > +        * (b) a cong_control function, if the CC wants custom behavior=
 and
> > +        *      complete control of all congestion control behaviors
> > +        */
> > +       /* (a) "classic" response: calculate new cwnd.
> > +        */
> > +       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
> > +       /* (b) "custom" response: call when packets are delivered to up=
date
> > +        * cwnd and pacing rate, after all the ca_state processing.
> > +        */
> > +       void (*cong_control)(struct sock *sk, u32 ack, int flag,
> > +                            const struct rate_sample *rs);
> > +
> >          /* return slow start threshold (required) */
> >          u32 (*ssthresh)(struct sock *sk);
> >
> > -       /* do new cwnd calculation (required) */
> > -       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
> > -
> >          /* call before changing ca_state (optional) */
> >          void (*set_state)(struct sock *sk, u8 new_state);
> >
> > @@ -1347,12 +1363,6 @@ struct tcp_congestion_ops {
> >          /* pick target number of segments per TSO/GSO skb (optional): =
*/
> >          u32 (*tso_segs)(struct sock *sk, unsigned int mss_now);
> >
> > -       /* call when packets are delivered to update cwnd and pacing ra=
te,
> > -        * after all the ca_state processing. (optional)
> > -        */
> > -       void (*cong_control)(struct sock *sk, u32 ack, int flag, const
> > struct rate_sample *rs);
> > -
> > -
> >          /* new value of cwnd after loss (required) */
> >          u32  (*undo_cwnd)(struct sock *sk);
> >          /* returns the multiplier used in tcp_sndbuf_expand (optional)=
 */
> >
> > How does that sound?
> >
>
> Thank you for your response & suggestions. This sounds like really nice
> improvement, can I use it for v2 and add you as Co-developed-by (since
> you've done most of the heavy lifting)?

Sure, please feel free to use it for v2, and feel free to add me as
Co-developed-by. :-)

(BTW, you probably saw the "The net-next tree is closed...Please
repost when net-next reopens after Jan 2nd." note from Paolo, but I'm
mentioning it just in case.)

Thanks!
neal

