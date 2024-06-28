Return-Path: <netdev+bounces-107693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4891BFA2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75B9B21324
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC701C0046;
	Fri, 28 Jun 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPSPTQrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0891BF32A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581748; cv=none; b=Z1aS5w08/KF0Bvl44k0j1VjlvJobn59ef+LqMO8IcO7LlUk9pBk3TpJr4kQylEWh6hXX6Y31a2TQywV3G5SPh0w7R+s/8TR2qrD3GOVQaSzh2DLkQOeHK4B4e0Bmfv8wxi+Fk0UZ0F29S0G6fI9eBiqM1Plg5oFVyFjmXr8aVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581748; c=relaxed/simple;
	bh=fx5E4V+REMJk64n7EjvQe4y1mdyJj9mO5NLSwIQHrr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpiXc+D2bBPzk44HJKAWbouuqi3R6SNRyCdmHzh+KuKOi+MzcfPyE1Kar6z+wOv3sj6UKHWmI+Vf+p3iVmBDW2RQ6bex0gbJAoADXhBvZQLt0i37x/UeDQl1KQLuHxga7x2PALbRpKevmqQUmYDJPyoUPaRjOCwwIKdcJCD5HTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPSPTQrZ; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef780ae561so356966e0c.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719581746; x=1720186546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHG1LOn3hrBgFRnYg1GtYpsgaVX8OyWVAvddS89Sd98=;
        b=LPSPTQrZ/IAc+tKz4/iNiDuAdI6mJXNvUdVkotYzthCmqUp0RK9tsVn53qNgBsbgvy
         7DYv+62lTUj9kZeC/qFKzNfnEG6Evyaa8Z6oR2yXQ8NFo/CnOpx5uw/Et/XXDTrFsiyv
         vntASux7+dDPWRxwwWZULUQDshbeCAY/RvXduM6DXsymkJIvtMF+POKR1QMsLbh7n5Ul
         gYWFk2Ho59e9y476JZpF1xN7iNFmIkUOVRopl9drTgEgMERJveymQqEUcgXaRxy24uOR
         pJMujcJd3tHtOjlEO1MaAYcYTcSUWFJyApzhMANkqaKttngbHe5Gq5NHkZO9feoHVUpK
         YOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581746; x=1720186546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHG1LOn3hrBgFRnYg1GtYpsgaVX8OyWVAvddS89Sd98=;
        b=IAQtYBFx1auum4HpKsw6Zb3fu5PK3g6skednAc26BI95Q2D//7GMjd1rjh4cjIx7kZ
         VXEwa7vYTws0Wd1We2VNbFJpVgqxmzw3S9amNYEDmXLtYfw0X2AHTVWxqm2L8CYGucjk
         rKSw7BvCBomRgE7E+j1r31s6lNnheZnrVk3QagLc7outMCNsatjkM/BQR1nPFyKa7r8t
         Qaqb+xmyUEPyDL4DqyoHMXnRyXMVgmaVZ4/E+yfRnNjtb2Q5o3HuWJt+OOK7jdwGvSGt
         S+/liDD5dn28r2ESMt0DodiqIiNj3gtSMms+cxGGwGirdwte6Gjnj7XwYl+xCTwSc+St
         avSQ==
X-Gm-Message-State: AOJu0YwAgQWd0VoCSTEsvKMHaWWOT0o4V6vwAULAaDlEe8cyHyYOETkZ
	ekiA6cd446uBndX+dyGHXBjnuz0A76xusEneIBiX/NuS5jV7xHD4e9O8NyPc8o/8GcH8JCNziNS
	OpORzqi8+gKX8X0hH99tNX9dW45hbvn6P
X-Google-Smtp-Source: AGHT+IGtwqGBHbP5W1ni+175kSYh/WHEek1BZ6z/sauLYc1VJ7Fb7VNSPE/DeBHE2ITXfdMftSxDepqGR7OZijNOP8c=
X-Received: by 2002:a05:6122:d23:b0:4d3:34f4:7e99 with SMTP id
 71dfb90a1353d-4f295c5650fmr1105874e0c.0.1719581745810; Fri, 28 Jun 2024
 06:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc> <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
 <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com> <CAA85sZt1kX6RdmCsEiUabpV0-y_O3a0yku6H7QyCZCOs=7VBQg@mail.gmail.com>
In-Reply-To: <CAA85sZt1kX6RdmCsEiUabpV0-y_O3a0yku6H7QyCZCOs=7VBQg@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 15:35:34 +0200
Message-ID: <CAA85sZscQ0f1Ew+qugkO6x6cL6OSuPpR1uU2Q6X=cSD2O2yUkA@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So this bug predates 2.6.12-rc2, been digging a bit now... Unless
gp->len has been pointing to something else weird.

On Fri, Jun 28, 2024 at 1:44=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
> On Fri, Jun 28, 2024 at 1:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.co=
m> wrote:
> > On Fri, Jun 28, 2024 at 12:55=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail=
.com> wrote:
> > > On Fri, Jun 28, 2024 at 12:53=E2=80=AFPM Florian Westphal <fw@strlen.=
de> wrote:
> > > > Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > > Hi,
> > > > >
> > > > > In net/ipv4/ip_fragment.c line 412:
> > > > > static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> > > > >                          struct sk_buff *prev_tail, struct net_de=
vice *dev)
> > > > > {
> > > > > ...
> > > > >         len =3D ip_hdrlen(skb) + qp->q.len;
> > > > >         err =3D -E2BIG;
> > > > >         if (len > 65535)
> > > > >                 goto out_oversize;
> > > > > ....
> > > > >
> > > > > We can expand the expression to:
> > > > > len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
> > > > >
> > > > > But it's still weird since the definition of q->len is: "total le=
ngth
> > > > > of the original datagram"
> > > >
> > > > AFAICS datagram =3D=3D l4 payload, so adding ihl is correct.
> > >
> > > But then it should be added and multiplied by the count of fragments?
> > > which doesn't make sense to me...
> > >
> > > I have a security scanner that generates big packets (looking for
> > > overflows using nmap nasl) that causes this to happen on send....
> >
> > So my thinking is that the packet is 65535 or thereabouts which would
> > mean 44 segments, 43 would be 1500 bytes while the last one would be
> > 1035
> >
> > To me it seems extremely unlikely that we would hit the limit in the
> > case of all packets being l4 - but I'll do some more testing
>
> So, I realize that i'm not the best at this but I can't get this to fit.
>
> The 65535 comes from the 16 bit ip total length field, which includes
> header and data.
> The minimum length is 20 which would be just the IP header.
>
> Now, IF we are comparing to 65535 then it HAS to be the full packet (ie l=
3)
>
> If we are making this comparison with l4 data, then we are not RFC
> compliant IMHO

