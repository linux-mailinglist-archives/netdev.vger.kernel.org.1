Return-Path: <netdev+bounces-151845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F59F1452
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB6C280E21
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6929188596;
	Fri, 13 Dec 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmaQdNIT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE080B
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112229; cv=none; b=p7gFxxlngkHGND2MX/SNouVwNOaJ6Z4MaR8hkzQ4/D/8lNxFoIS5V8e1bj5LY8cV6BJ0ScxQP+WaeORV4z7Ce8vzp90CKWzR+oxhMNdERtuZmae3WFUsuChs+LmVm7NvBVkDAGJKRiiL76XZl+xLyzj31mv8WubICdlYVCc04wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112229; c=relaxed/simple;
	bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMydVsEDPlLLvQFZ9su04qHkulW2doG1q5PamM9E7J6je42OZd4C5BrCVUX8cdPWRmTd1yEoESTSjJ6HmFDk+fD36dAsdWhaf0+4n8HzBAlO2DPk30Ep/IzGqXZSTGVQYQocUKsJ95Dy7JylckreiVBNKTgJjF4PSyM2bTIi6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmaQdNIT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678c9310afso2271cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734112227; x=1734717027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
        b=SmaQdNITYYXqfjbdDZPfPpK5X4IZLXR3qURAxuhHLo5MYEhqQu1ulktkJkN29KX1BV
         zOWEdb8Rg2PVWXJ/4srs2mSW2digDqd5mWjXGzAWmBs1dxBd1OSF3zQtPvySCIhuIlL2
         pkLtrwkOMYAp9gwVidzO99gwxEfrIwNG+Pv2w0kaOBoOMa44P1xa0sELzCWsdrw/u3B0
         wwb394TDXttIOzpzLzLiW2cDCIU/12BmHZAsE5nDn6hNqHE5M88RZ49viXhLJUIIx6rs
         Y+gnzTBQ/oo7VoL59xIh+3noR4sUMUVzdZMdPyGxNb9ZF15KUGVgi+8KB1DjkffIqH+n
         /YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112227; x=1734717027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djylv9F8tywainvff5k2EtKJPF0tmivJOjhfTKasg6o=;
        b=wKoamiYrby4790/WgmbkzwJHIYuDh+5m7DdnRIFKxNZtNd1dVZ+i0imsz/Fs6je7HW
         SmiYATQQcRuGOimfGOkp9dUQnT+mIP2UusSGFeefepHa523zFzt+gbtGARfCorEfqqTL
         a+UXlrLQh0wuSIuR0B0d4Iimp1Ub3SRenm3E+rIwP17H3aAktahDeFqFRdHXoe3Zf1NY
         j61GtfDwgoZ4EOcYLXcitrW5uInychFS6622jfpiXWrFKiHqdsd2vWeQlcdIkBNAzS8z
         PshY7xKVLz4hJTIXeEmJTYyyeR/58TcUr/OC6qLj/ROJu/diOUj/cLbCwALHyjtHy68g
         Nx+g==
X-Gm-Message-State: AOJu0Yw3Uv/wj7Cww1O6wmEb2Bke9fFGluN/OpXhaLapo+BR2H3JedHj
	WS0fDO5+sM7oo54UBKf8MJGC3EJdBHfdgn6RjIW0NJuTeaRxXtF3LTLtIiMGJSokbSzFFH/lD6n
	E4M/4rDCj7QxNsOTwtMA5iDKRD0GkmPiPuso7
X-Gm-Gg: ASbGncs+oeNJoW3N6BJo6I/LMj1tDhDohbPTHuyZ5d4vyrwy2/tYz4UxI2BjJXpWI2j
	1wh3EeF1eFmyBhImyNCYznmKRA9H7HeoG7vAUFw==
X-Google-Smtp-Source: AGHT+IGSMO8zA0jUSoUVkBiSa/a2+eUBQaIEGDaJyWLq1DM/iNvCaHfDBGc1H2AIsmpq46WzgQc7IWV2n1YjCglPVY4=
X-Received: by 2002:a05:622a:4d8a:b0:467:84a1:df08 with SMTP id
 d75a77b69052e-467a59ccc94mr3694131cf.23.1734112227024; Fri, 13 Dec 2024
 09:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
 <20241209172308.1212819-6-almasrymina@google.com> <20241210195513.116337b9@kernel.org>
 <CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com> <20241211182813.789616ce@kernel.org>
In-Reply-To: <20241211182813.789616ce@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 09:50:15 -0800
Message-ID: <CAHS8izO0ELODoGJCz49q-9y1EF0fEauo2h7y177D_vL6x82VVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 6:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Dec 2024 09:53:36 -0800 Mina Almasry wrote:
> > Drivers doing their own recycling is not currently supported, AFAICT.
> > Adding support for it in the future and maintaining it is doable, but
> > a headache. I also noticed with IDPF you're nacking drivers doing
> > their own recycling anyway, so I thought why not just declare all such
> > use cases as not supported to make the whole thing much simpler.
> > Drivers can deprecate their recycling while adding support for netmem
> > which brings them in line with what you're enforcing for new drivers
> > anyway.
>
> IIRC IDPF was doing recycling based on the old page ref tricks,
> without any use of page pool at all. But without using page pool
> the driver will never acquire a netmem_ref in the first place.
>
> > The specific reason: currently drivers will get_page pp pages to hold
> > on to them to do their own recycling, right? We don't even have a
> > get_netmem equivalent. We could add one (and for the TX path, which is
> > coming along, I do add one), but even then, the pp needs to detect
> > elevated references on net_iovs to exclude them from pp recycling. The
> > mp also needs to understand/keep track of elevated refcounts and make
> > sure the page is returned to it when the elevated refcounts from the
> > driver are dropped.
>
> No? It should all just work. The page may get split / fragmented by
> the driver or page_pool_alloc_netmem() which you're adding in this
> series. A fragmented net_iov will have an elevated refcount in exactly
> the same way as if the driver was stashing one ref to release later.

Ah, I had not considered that the driver may recycle the page by
holding onto a pp ref count, rather than a page refcount. The former
should indeed just work, although I don't have a driver that does
this, so test coverage may be a bit lacking.

But you mentioned you like the rule above. Do you want this removed
from the docs entirely? Or clarified to something like "driver's can't
perform their own recycling by holding onto page refs, but can hold
onto page_pool refs"?

--
Thanks,
Mina

