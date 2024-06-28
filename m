Return-Path: <netdev+bounces-107645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06191BCE8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B0528310C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239415572D;
	Fri, 28 Jun 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE8Ib2/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A72139A8
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572172; cv=none; b=YUXuzbQZgrB41nXWbzfi0ibmErVT28LwJ9IosV40bAiff11P8PvCsA9wuLGQ7TpJpT+pX4bLkPeZrekTx7B27A3tN29Uu76IVM95FiVGvWqYknOMluNSfB7Dxdc8oV06HUgFARrm9Vrk2iEqZY+mDHFkFrwUGtHuIA7Ruu9ZZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572172; c=relaxed/simple;
	bh=A8WaDu35AUZYEIkYxTsTGxlj23bX8nqmCAlUG64TOw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA6OyVA7JE/k7ce9ocOvcDxQnvMC6D0xSmcBqItU+ieFRbZgU2HOhq/bf/iS5X69Rgl/7waBvwlIgpbZrbnfhXd03E074jfZATxaJp2YX5PcU32W7BDI7up0tLeYbZv42rG52JYIdUKKCSaZMTEloXckUaMiTadALNASyd527aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE8Ib2/q; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80f59ebd021so124647241.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719572169; x=1720176969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVm0Ps97+3S913qJYsjmf+xMucI0VyuE0uS2okFVo9Y=;
        b=YE8Ib2/qjCuySPVIkPGiXhCBT86M/QlldBMWzp4BXqfatr7E7/PT7+ZuEhbl2C8DTE
         fKh60wuNBglT0qZi/Jod34k0qi1gkEmCDf4L7WQz6wc8e7WwOGhAe74+BHbdt3/UISyg
         iRIfD89Gjdiqj7+eL55FabpVzNr/UIIMpSXxU+vYlf3qHtcI0GUgRDyI4uaKrG5yBa3G
         ov9xcdjnkgtn493AfNpHdzPMBRAREnn27boUg8rG51CWBbaOvLPO8qRkW5WcFUpBz0Qf
         TsaBiytgS32x31VWfcBZyH2fqhQfAnYyYxx/RZkC11r5Jx6VROySV4+GoguahT5WF99i
         16cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719572169; x=1720176969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVm0Ps97+3S913qJYsjmf+xMucI0VyuE0uS2okFVo9Y=;
        b=AXj8zX3c2bUc/MZ9AoTwhuTe2NQKNIaRuVcxY2b6pIaRA/HyQakFPUaoLYzh6ZLqfL
         +19IqfMHBhnrVvXscriWMzS73uXm8GHXMgY0jtZWiOISndwZMXhK8G0BYtsgRgCnU51j
         /MqAKcJf0vS43XQaITbo8wZnBQkN8nn3SsFVa34il8crW/jxDxE9iT9/iJu1Ww5TmkrL
         /TwpJEEXOel8nAUyaieGFeIJY/NDQnhgiXYcTl0BjiX007o+Y4hR6aIy5tYrjsqqgtF0
         PdcL9QXV5x/+Bz3ZA777pg9XiIu+qyVrsED0txPpjFy0z2ziOZ/jTz/HHtPs7VU+KxTz
         YSkA==
X-Gm-Message-State: AOJu0Yz4MxRRgEb0hwViIyPQG9/IODa36nF69tWyMlwoSrbcJ5ZVGgIg
	y1yeuJICSWybK5thb7ttuaamjSbUfR4sIf5tLczbv7/oXxD3VVIqb8jYndKFlTJGN06zN/zPhRW
	JWq2eevi5bq074vdBDycX6j4MUPW4wRwe
X-Google-Smtp-Source: AGHT+IF2asAUmRtN17aW+Nn5ETBHxDH/9PkWiAtyIrpcLXHT3ampwZP8KubLOjO3z+84MX8SzkZxjbvDKvImlu6147k=
X-Received: by 2002:a05:6102:b14:b0:48f:4580:fb0c with SMTP id
 ada2fe7eead31-48f52b50e78mr19170357137.24.1719572169393; Fri, 28 Jun 2024
 03:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc>
In-Reply-To: <20240628105343.GA14296@breakpoint.cc>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 12:55:58 +0200
Message-ID: <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:53=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > Hi,
> >
> > In net/ipv4/ip_fragment.c line 412:
> > static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> >                          struct sk_buff *prev_tail, struct net_device *=
dev)
> > {
> > ...
> >         len =3D ip_hdrlen(skb) + qp->q.len;
> >         err =3D -E2BIG;
> >         if (len > 65535)
> >                 goto out_oversize;
> > ....
> >
> > We can expand the expression to:
> > len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
> >
> > But it's still weird since the definition of q->len is: "total length
> > of the original datagram"
>
> AFAICS datagram =3D=3D l4 payload, so adding ihl is correct.

But then it should be added and multiplied by the count of fragments?
which doesn't make sense to me...

I have a security scanner that generates big packets (looking for
overflows using nmap nasl) that causes this to happen on send....

