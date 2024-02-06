Return-Path: <netdev+bounces-69606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7984BCCD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D101C24B53
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9BDF5C;
	Tue,  6 Feb 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofAMUZFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80759134AA
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243467; cv=none; b=g72Aexv06D1aMwwTU9vmzEsaZl46+yMyFdsMyg1VJxKjNUXyecaDzUvnhTIfUOO7KSg7013SNOPUjhD5E0fyIbzI4MJFw40cRsx8L2R+sT9Yk+FxIthZmTP8sHgmNewZew0fjwJTY6kyaTzQijY6KFN/9yJ7YNadzbzEqvFyX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243467; c=relaxed/simple;
	bh=hdKmjhASF46rbObskXulPw+dctUILb9sWSBGdEm2MkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FswDRyRfzu9tuuB4aadXb882MfejelC9J25YlPGv9aOeKGoRcaK83zl7wAr7XVYhgsgGzH5AMoCroPsXtdC81X3hcUh5zS65oWusDwZQIhDMeC88Tr9ytnLnDjO9bZjiqTUZXLl+5CzAv/UHT7oDa2osFe+TkbL9XEfvLJAEMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofAMUZFH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a38291dbe65so102173366b.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707243464; x=1707848264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJxm5o5JwedjLGG4ET8BuqK0l6wSaCzMfVG0K+Iz704=;
        b=ofAMUZFHsJegEgvbCEwdotHB/me2r+0g0wLAGyzbz40zY0IHVtvASI7EI9bD8XLrrE
         W9PKow7thoHuUlvrxgF+3o0WjTKMQZ5SHvRmL/fy4mpLpOXyWpdFv2YNjo4JdyKgtPLh
         eU1uT+U9oTF2lBk7BwMNo3Nqg5m8LcXe9xZBp7lVkv73LhsNpNcA7JokG1EPQlw2IJ7A
         cmmhMNAq3B3rhIGFx+ib/9K/gXJSl6ItXfA4NFStL/SELUxa+mxGeDfYHTQbZJPo0IpG
         kmR0C2oikckLSacDtGUbC5JUFhg317HS85NNwYnE5TD7iWPx5Qsql/iwTZg8Cs7sNFdw
         uBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707243464; x=1707848264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJxm5o5JwedjLGG4ET8BuqK0l6wSaCzMfVG0K+Iz704=;
        b=SPHMXncO8nfpHeSkj/WcA5Jsd4yC+dtunJHecGVKj/ORo8zD/dxPXt2CPvW5UNxgd4
         spBcWF3zAfh0x93KflMCXVvuzUhAfmMNTcqnS3Ohm3xtG0+bFckv6yfHsPMm9S1BH6hT
         iJ+zeWEDTcfPEjumj2Subq14EUFSK8t57NcWGm1QqJW8o0cfrGb70TmVH/qQuaCjhNH4
         aSF7C1oQh6XfqEq6gKL/rmys+Qj2/lI6CKXkfEHcaBytFO5TSqWNr1CUnmW/E+B+fNKo
         lL334vPNfgXB07yySQs+LJy5TNUr3dW0BYi5PmvBwIlsGS8zlnfUIJ8znpTGc+WZXETs
         DMRQ==
X-Gm-Message-State: AOJu0Yzmiav/CLGt+k7SVhjF+Uv1a4IbiL4TtY1F/ma/42TRO6IhXwq4
	hi6C8IhKB/7FlXXodFX8fxz312C57qc2RmmpR/Zn37nBl3wcwzi6FBH4K9SDO2j4rmoQH4lXiZE
	vgSZrCRr06ErJGZQAGsl0K5wevIdadGiFdPh+
X-Google-Smtp-Source: AGHT+IGWmPcNjm+wpDbul+AOT67RZaICat9JknWnwinU+ss7qWQ27bTyn7o4GQeZ3P1FafwEylGLQlPwraAAnqMleUs=
X-Received: by 2002:a17:906:710e:b0:a36:5079:d6c9 with SMTP id
 x14-20020a170906710e00b00a365079d6c9mr2033956ejj.76.1707243463572; Tue, 06
 Feb 2024 10:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201213429.4120839-1-almasrymina@google.com>
 <20240201213429.4120839-3-almasrymina@google.com> <1560533cb4eb3f36e640c9931fba93e0d0378652.camel@redhat.com>
In-Reply-To: <1560533cb4eb3f36e640c9931fba93e0d0378652.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 6 Feb 2024 10:17:30 -0800
Message-ID: <CAHS8izM-QqyiYz100sC-QPhVOnD0zbc4TZhcTxZzritOa_z7FA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] net: add netmem to skb_frag_t
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2024-02-01 at 13:34 -0800, Mina Almasry wrote:
> > @@ -2528,8 +2562,25 @@ static inline void skb_fill_page_desc_noacc(stru=
ct sk_buff *skb, int i,
> >       shinfo->nr_frags =3D i + 1;
> >  }
> >
> > -void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, in=
t off,
> > -                  int size, unsigned int truesize);
> > +static inline void skb_add_rx_frag_netmem(struct sk_buff *skb, int i,
> > +                                       netmem_ref netmem, int off, int=
 size,
> > +                                       unsigned int truesize)
> > +{
> > +     DEBUG_NET_WARN_ON_ONCE(size > truesize);
> > +
> > +     skb_fill_netmem_desc(skb, i, netmem, off, size);
> > +     skb->len +=3D size;
> > +     skb->data_len +=3D size;
> > +     skb->truesize +=3D truesize;
> > +}
>
> > +
> > +static inline void skb_add_rx_frag(struct sk_buff *skb, int i,
> > +                                struct page *page, int off, int size,
> > +                                unsigned int truesize)
> > +{
> > +     skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
> > +                            truesize);
> > +}
>
> I'm very sorry, I was not clear in my previous feedback: only
> skb_add_rx_frag() was supposed to be 'static inline'.
>
> skb_add_rx_frag_netmem() contains a few more instructions and there are
> a lot of callers, always inline it does not look the best option.
>
> I'm sorry for requiring an additional iteration, but feel free to ad my
> Acked-by with the above change.
>

No worries, minor miscommunication. I'm happy to respin with the change. Th=
anks!



--=20
Thanks,
Mina

