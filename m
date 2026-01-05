Return-Path: <netdev+bounces-247160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B390CF51DB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 916E130082C8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9830DEC1;
	Mon,  5 Jan 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFnr/aKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB99331A61
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635901; cv=none; b=qt4kqOZkIHZdguHy7SQ0Ub80+uXWTPWJ9Jy9CezgVBIZaLg3p0cN7Yn6zlF8NNMb6XxfFH+g64rMIa1P3S1qeOq52/yk68VbW/P1T4a5OILiQmMxGz6nXgtYJ+E1Gr4pCx3WuHE5pEPgZkGyyP8kng+6WauNWhUYgrD/Mv5Lx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635901; c=relaxed/simple;
	bh=6ObVIurIwgsxEohLHY9m2f13XGr+hqOSo5+OdNz+S0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quoq9lxp6Z0sEX31TO3OV0Znl6S1j9C0aEWQ20ja25YwxIpgsnqXjwrQh61BHZmzkipNZ7dijVMEZWeZ+ipwDkTt2JJ60PT1EvuwKjstVrLdES65JfUT1moET9WPDAg/m/EHs5WvrNaguUMNcqBp+/JGBEqX8tCtY/umAC1jO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFnr/aKz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda77e2358so1389141cf.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767635898; x=1768240698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZQaMNXad5jvC3Y2UL+gnaKf44MFLYoluELtVp1wLo8=;
        b=uFnr/aKzwzPh07hdwCuq+/w3bLixSP3SWGJ9tvLZkOwLyznoulLVVofJCoR099j2xp
         n5QWZPNDjOTal2FcwvejG1m2Zg+K4pca6x8DyTaCVhIDyFqPKZYFyoqOEPZ2EBZga6lZ
         ppQ+amMGHbWmrcYJ5sSDr92UFTzG2Z7286G0GWFIlp1rV9rDjugWbxeb60oeDVHvgw9k
         mY8f0y09xtNZcGht6iv3jmXGwBfRbEZVIEFF8hsr0usR89AviUO18QuiGT4//9anZaHH
         DstIdMOoZ4KaMFD5bQA5+YIgksPHFyLYX9HVl6Ru8lRl9WIQE38uSGcbCkfQYo/pdp4o
         Cj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635898; x=1768240698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZQaMNXad5jvC3Y2UL+gnaKf44MFLYoluELtVp1wLo8=;
        b=WoQE5A6pp9zOugJz4JhgRk0Wy9cpeegcRIOI7QIXr9lU1w/FER9rIuuOO40GWk+RBT
         52WJXl44te3OeV1oFytTowM0kBMd9g6jKdKnf9vjND4Fnyrx1oFPlZSuLtUe8zA6aWxq
         /sgH8iV+xLd7NIMaWfJOXZLGrmyh1nygm4yDwQl0Mt9JOJPqlmkLzrhhuZxltlOzAshe
         4h4KflqL469Zfr8mjGTOUzQTWcwmfC9Ie26okQPHXpQbVsfyYvDCZVK5sSN7NL3/OBb3
         1ZhBliKwlfQfrwV9G/5hOyjR9ycjqrHp9pLyFt4w34BfT77W0xBcY0JNXc1YUAb0Abnz
         5Cuw==
X-Forwarded-Encrypted: i=1; AJvYcCUaOhgywNPjYF4ZSH3KzLwPfGieqTMRf5+yWoUW8VqCzo7FAxDxfeMJUj1gvJ2N4OSdCal29kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgtj4kEFC5Oadyh0LaTPYk2F4HKRQpmC6XRqP4g5LW6NRBJ+SO
	PMONRgo7uFkX4njO0wq1I3phfIjb2moR7Jz+8fKZaBlmSTovkflyRsec2nUvgncXJPlISvTdkYT
	yf0HFyY2mAYSoMyJXxl2fqGLaB0RdNJUq7HfJnmgk
X-Gm-Gg: AY/fxX5YWOcHRgjXxFL9EOaodzQGv9buBY9y93UzhEu2l7JzqcTjRmFXZsVgX614iQi
	Wk0oF5LJaWXJY07burL9agRE2AVIRG2dcY3jErPtJSyWH9DDjXLCTmIB2Qc/rtGSzDnpEMdCND4
	fPuDXvSmkbf4I4eqv27NluEJUegIS9o/vZj98D9xrYhSArj+0eYhPcXtk96C5jRUCS8nTAZ7ZcH
	+lIXw7cnk/j90O0qZ7wGWvTa4It9IYR/wBypyWBXBZsWaKPbMVjBe7DdyFisChCCA7vLnX7
X-Google-Smtp-Source: AGHT+IGtttk9r/ligAXX6wzijmuNMwDzby8bScuxdu16Ai/oHlw0y7AH0OEPCdyHo3JpDyjqpNXQgQ6ZXvYeb11jCqE=
X-Received: by 2002:a05:622a:98f:b0:4ee:87a:4d0e with SMTP id
 d75a77b69052e-4ffa7809bccmr4211101cf.69.1767635898023; Mon, 05 Jan 2026
 09:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
 <willemdebruijn.kernel.2124bbf561b5e@gmail.com> <5ce5aea0-3700-4118-9657-7259f678f430@kernel.dk>
 <willemdebruijn.kernel.4358c58491d1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.4358c58491d1@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Jan 2026 18:58:07 +0100
X-Gm-Features: AQt7F2qsuxFSE1oCb_03W0YlplC6FUgW9ypDJR8XO4l87CYT0Pf2suYrDQtlEq0
Message-ID: <CANn89iKeksiX+cimHzm2GsQtfCE_i2ncs4GfO-WmUjRHXcWOXQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:57=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jens Axboe wrote:
> > On 1/5/26 10:42 AM, Willem de Bruijn wrote:
> > > Eric Dumazet wrote:
> > >> On Mon, Jan 5, 2026 at 5:33?PM Willem de Bruijn
> > >> <willemdebruijn.kernel@gmail.com> wrote:
> > >>>
> > >>> From: Willem de Bruijn <willemb@google.com>
> > >>>
> > >>> msg_get_inq is an input field from caller to callee. Don't set it i=
n
> > >>> the callee, as the caller may not clear it on struct reuse.
> > >>>
> > >>> This is a kernel-internal variant of msghdr only, and the only user
> > >>> does reinitialize the field. So this is not critical.
> > >>>
> > >>> But it is more robust to avoid the write, and slightly simpler code=
.
> > >>>
> > >>> Callers set msg_get_inq to request the input queue length to be
> > >>> returned in msg_inq. This is equivalent to but independent from the
> > >>> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq)=
.
> > >>> To reduce branching in the hot path the second also sets the msg_in=
q.
> > >>> That is WAI.
> > >>>
> > >>> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
> > >>> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
> > >>> inverse.
> > >>>
> > >>> Also collapse two branches using a bitwise or.
> > >>>
> > >>> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f=
7a3de@gmail.com/
> > >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >>> ---
> > >>
> > >> Patch looks sane to me, but the title is a bit confusing, I guess yo=
u meant
> > >>
> > >> "net: do not write to msg_get_inq in callee" ?
> > >
> > > Indeed, thanks. Will fix.
> > >
> > >>
> > >> Also, unix_stream_read_generic() is currently potentially adding a N=
ULL deref
> > >> if u->recvmsg_inq is non zero, but msg is NULL ?
> > >>
> > >> If this is the case  we need a Fixes: tag.
> > >
> > > Oh good point. state->msg can be NULL as of commit 2b514574f7e8 ("net=
:
> > > af_unix: implement splice for stream af_unix sockets"). That commit
> > > mentions "we mostly have to deal with a non-existing struct msghdr
> > > argument".
> >
> > Worth noting that this is currently not possible, as io_uring should
> > be the only one setting ->recvmsg_inq and it would not do that via
> > splice. Should still be fixed of course.
>
> recvmsg_inq is written from setsockopt SO_INQ. Do you mean
> msg_get_inq?
>
> I think this is reachable with a setsockopt + splice:
>
>         do_cmsg =3D READ_ONCE(u->recvmsg_inq);
>         if (do_cmsg)
>                 msg->msg_get_inq =3D 1;

It is a bit strange that syzbot did not find it yet.

