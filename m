Return-Path: <netdev+bounces-87430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994308A31CA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1CEB20DD0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FE146D71;
	Fri, 12 Apr 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO6wswCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF4146D68
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934348; cv=none; b=aPnOB+WKg9llT47HB8zHFecOyRS1V+njAL/dQTQugsVhtIMswdNunpZZkO0S1TTryxCMiFnYlzIIxq69H8xNcivBNluLfXJXpoD5M3x5lm/Ke1GrlQshK+a/G9RHVNBw2GMipvzbV4rPI9tYCbtwb+EL6+kU4RzmzxOmiyLg+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934348; c=relaxed/simple;
	bh=mRqZqn8as8GUJmH8zKG2QteQL+8hStyZbIBan4rVFgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfOx5kz6qLwAKAoIMlHpZ3W6QnKFKB8Lq5iu85qQHkm302yQ59jRYOVwQHFV9rLxT5Kvh9TxvQoC70koOCaqFpTLRbwIGwPKseMQkyiclN0dUClB30Qx3RnEy0Rm4JVN9+vpdA0ndKEhbJLyNOm2nz8N4N5cYGKdk+DxbeS0hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO6wswCS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-346f4266e59so743214f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712934345; x=1713539145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mtujX/v2puiC5cyqQ+Y+nhs0gB4tbgQetr8KZghqpE=;
        b=FO6wswCSmoU5vMPwjqjIdTqeC025Lb0WTxM3af15aZL8HMnQyU3wOGqCFSQPX+wWGa
         Q4YrPBnVosjX5rzGRwbIHkbBXUpbOntzed+IQYnbNVfYZh+DRryqWPomnMGi4gNDiYs+
         tPAbrTRYCv2Iq76VdzB1vE0zTC4uHSEd7ipdomQjsLGGr81zep5WQHnb4xXiy1uY3OML
         sF/jl7r4pawcBz9VwZik3DuOxjnLZ+E6e6qqPu6QwQYfCDuOmXFt3IVi4vfbZJGKR8PI
         LFPI2cssYjsw43o0yRhzQTPx4uwlcE0VUQQGAwAg8G2N0sNG2xkzgA+XWupa8le3YB6Y
         VwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934345; x=1713539145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mtujX/v2puiC5cyqQ+Y+nhs0gB4tbgQetr8KZghqpE=;
        b=oZZUzDE7HaLnjm461fadODXKkDBp+UWlBHWZ815LnebysVep5k0skSsK70P5+SX7Wy
         ooKVs9bSypyzsmQEd/tpIjlY0L9GIvuDhGGkB2Rg8gAOdKUG00GSvB4d2GYq0Sd4HDyN
         xePeRfysgSb5m0vUVaNPahT6eDARIHj4TB6Hbjhzshlp4Gz3sMT3VcGawvXZeVgo0iVT
         qe1fiqgGWqOEpNApmmYOUxRIwX5Br/U0N5KZrSk6HbMyACDHEiKW1G9Ixe+skKsOx7yl
         zfex7j4bxGKAFaK/UcDYWwphrNW/fCJFI9/SD04IIZQzroGsZQaPtVcvCvNFdP7VaAfo
         Lpiw==
X-Gm-Message-State: AOJu0YzGmYMIpsD/HM6Xm2KMqgNZs7tK/o3AdAZX1BoVKBIfFv/5AfWp
	ABL4kmlRprbg7BC/V0XP8nh9Wo83dtNkjW7I3xP9k4WX+DVU22glO9zHC2RSBzrO05qbpKAMyQP
	YlgsawFqgysjvYLenr8sg+cT8cYgDMw==
X-Google-Smtp-Source: AGHT+IFjQRLwcjVq3pXrY51fjper6bLGiO9BRuc06VbO+RIJyeDHc/N9BLTFzJk4SFmDpGXZeMliL1cOkPjp5dCmz1U=
X-Received: by 2002:a05:6000:1ac5:b0:343:6f87:fe33 with SMTP id
 i5-20020a0560001ac500b003436f87fe33mr2203570wry.7.1712934344697; Fri, 12 Apr
 2024 08:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
In-Reply-To: <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 12 Apr 2024 08:05:07 -0700
Message-ID: <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:43=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/10 23:03, Alexander Duyck wrote:
> > On Wed, Apr 10, 2024 at 4:54=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/4/9 23:08, Alexander Duyck wrote:
> >>> On Tue, Apr 9, 2024 at 4:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>>
> >>>> On 2024/4/4 4:09, Alexander Duyck wrote:
> >>>>> From: Alexander Duyck <alexanderduyck@fb.com>
> >>>
> >>> [...]
> >>>
> >>>>> +     /* Unmap and free processed buffers */
> >>>>> +     if (head0 >=3D 0)
> >>>>> +             fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
> >>>>> +     fbnic_fill_bdq(nv, &qt->sub0);
> >>>>> +
> >>>>> +     if (head1 >=3D 0)
> >>>>> +             fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
> >>>>> +     fbnic_fill_bdq(nv, &qt->sub1);
> >>>>
> >>>> I am not sure how complicated the rx handling will be for the advanc=
ed
> >>>> feature. For the current code, for each entry/desc in both qt->sub0 =
and
> >>>> qt->sub1 at least need one page, and the page seems to be only used =
once
> >>>> no matter however small the page is used?
> >>>>
> >>>> I am assuming you want to do 'tightly optimized' operation for this =
by
> >>>> calling page_pool_fragment_page(), but manipulating page->pp_ref_cou=
nt
> >>>> directly does not seems to add any value for the current code, but s=
eem
> >>>> to waste a lot of memory by not using the frag API, especially PAGE_=
SIZE
> >>>>> 4K?
> >>>
> >>> On this hardware both the header and payload buffers are fragmentable=
.
> >>> The hardware decides the partitioning and we just follow it. So for
> >>> example it wouldn't be uncommon to have a jumbo frame split up such
> >>> that the header is less than 128B plus SKB overhead while the actual
> >>> data in the payload is just over 1400. So for us fragmenting the page=
s
> >>> is a very likely case especially with smaller packets.
> >>
> >> I understand that is what you are trying to do, but the code above doe=
s
> >> not seems to match the description, as the fbnic_clean_bdq() and
> >> fbnic_fill_bdq() are called for qt->sub0 and qt->sub1, so the old page=
s
> >> of qt->sub0 and qt->sub1 just cleaned are drained and refill each sub
> >> with new pages, which does not seems to have any fragmenting?
> >
> > That is because it is all taken care of by the completion queue. Take
> > a look in fbnic_pkt_prepare. We are taking the buffer from the header
> > descriptor and taking a slice out of it there via fbnic_page_pool_get.
> > Basically we store the fragment count locally in the rx_buf and then
> > subtract what is leftover when the device is done with it.
>
> The above seems look a lot like the prepare/commit API in [1], the prepar=
e
> is done in fbnic_fill_bdq() and commit is done by fbnic_page_pool_get() i=
n
> fbnic_pkt_prepare() and fbnic_add_rx_frag().
>
> If page_pool is able to provide a central place for pagecnt_bias of all t=
he
> fragmemts of the same page, we may provide a similar prepare/commit API f=
or
> frag API, I am not sure how to handle it for now.
>
> From the below macro, this hw seems to be only able to handle 4K memory f=
or
> each entry/desc in qt->sub0 and qt->sub1, so there seems to be a lot of m=
emory
> that is unused for PAGE_SIZE > 4K as it is allocating memory based on pag=
e
> granularity for each rx_buf in qt->sub0 and qt->sub1.
>
> +#define FBNIC_RCD_AL_BUFF_OFF_MASK             DESC_GENMASK(43, 32)

The advantage of being a purpose built driver is that we aren't
running on any architectures where the PAGE_SIZE > 4K. If it came to
that we could probably look at splitting the pages within the
descriptors by simply having a single page span multiple descriptors.

> It is still possible to reserve enough pagecnt_bias for each fragment, so=
 that
> the caller can still do its own fragmenting on fragment granularity as we
> seems to have enough pagecnt_bias for each page.
>
> If we provide a proper frag API to reserve enough pagecnt_bias for caller=
 to
> do its own fragmenting, then the memory waste may be avoided for this hw =
in
> system with PAGE_SIZE > 4K.
>
> 1. https://lore.kernel.org/lkml/20240407130850.19625-10-linyunsheng@huawe=
i.com/

That isn't a concern for us as we are only using the device on x86
systems at this time.

> >
> >> The fragmenting can only happen when there is continuous small packet
> >> coming from wire so that hw can report the same pg_id for different
> >> packet with pg_offset before fbnic_clean_bdq() and fbnic_fill_bdq()
> >> is called? I am not sure how to ensure that considering that we might
> >> break out of while loop in fbnic_clean_rcq() because of 'packets < bud=
get'
> >> checking.
> >
> > We don't free the page until we have moved one past it, or the
> > hardware has indicated it will take no more slices via a PAGE_FIN bit
> > in the descriptor.
>
>
> I look more closely at it, I am not able to figure it out how it is done
> yet, as the PAGE_FIN bit mentioned above seems to be only used to calcula=
te
> the hdr_pg_end and truesize in fbnic_pkt_prepare() and fbnic_add_rx_frag(=
).
>
> For the below flow in fbnic_clean_rcq(), fbnic_clean_bdq() will be called
> to drain the page in rx_buf just cleaned when head0/head1 >=3D 0, so I am=
 not
> sure how it do the fragmenting yet, am I missing something obvious here?
>
>         while (likely(packets < budget)) {
>                 switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
>                 case FBNIC_RCD_TYPE_HDR_AL:
>                         head0 =3D FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rc=
d);
>                         fbnic_pkt_prepare(nv, rcd, pkt, qt);
>
>                         break;
>                 case FBNIC_RCD_TYPE_PAY_AL:
>                         head1 =3D FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rc=
d);
>                         fbnic_add_rx_frag(nv, rcd, pkt, qt);
>
>                         break;
>
>                 case FBNIC_RCD_TYPE_META:
>                         if (likely(!fbnic_rcd_metadata_err(rcd)))
>                                 skb =3D fbnic_build_skb(nv, pkt);
>
>                         /* populate skb and invalidate XDP */
>                         if (!IS_ERR_OR_NULL(skb)) {
>                                 fbnic_populate_skb_fields(nv, rcd, skb, q=
t);
>
>                                 packets++;
>
>                                 napi_gro_receive(&nv->napi, skb);
>                         }
>
>                         pkt->buff.data_hard_start =3D NULL;
>
>                         break;
>                 }
>
>         /* Unmap and free processed buffers */
>         if (head0 >=3D 0)
>                 fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
>         fbnic_fill_bdq(nv, &qt->sub0);
>
>         if (head1 >=3D 0)
>                 fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
>         fbnic_fill_bdq(nv, &qt->sub1);
>
>         }

The cleanup logic cleans everything up to but not including the
head0/head1 offsets. So the pages are left on the ring until they are
fully consumed.

> >
> >>> It is better for us to optimize for the small packet scenario than
> >>> optimize for the case where 4K slices are getting taken. That way whe=
n
> >>> we are CPU constrained handling small packets we are the most
> >>> optimized whereas for the larger frames we can spare a few cycles to
> >>> account for the extra overhead. The result should be a higher overall
> >>> packets per second.
> >>
> >> The problem is that small packet means low utilization of the bandwidt=
h
> >> as more bandwidth is used to send header instead of payload that is us=
eful
> >> for the user, so the question seems to be how often the small packet i=
s
> >> seen in the wire?
> >
> > Very often. Especially when you are running something like servers
> > where the flow usually consists of an incoming request which is often
> > only a few hundred bytes, followed by us sending a response which then
> > leads to a flow of control frames for it.
>
> I think this is depending on the use case, if it is video streaming serve=
r,
> I guess most of the packet is mtu-sized?

For the transmit side, yes. For the server side no. A typical TCP flow
has two sides two it. One sending SYN/ACK/FIN requests and the initial
get request and the other basically sending the response data.

