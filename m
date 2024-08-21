Return-Path: <netdev+bounces-120560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC89959C5D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30A61C21940
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51918199920;
	Wed, 21 Aug 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbReuA+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29F194149;
	Wed, 21 Aug 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244679; cv=none; b=u/30+Uy6f3yQmWvoL8iMRg/K5RDzSAaUjVM7jjRuUjkAvPnRiImIuK+72stZSBKOb2e5fhr7mJUR0dh8OCEiYmG1Ubd7TuWg4Q6CgN4T/1tZEHlAxEaYS1nsJFFr5UAJApLN9YbCteE2NJejNQ2X8cbbOtEY9tk8MJwNJ9pSde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244679; c=relaxed/simple;
	bh=Rc2cFQqSSkeKecWE2PK134m4tNeSj3uwEtJwvX22JVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiVDnDNUB1on+py/ILLTZdgatbc47+E7Zxe8cosIwr2rx3ufz++5c0djApR+qfGHhpobkCrFBHYYize2liN6RZmGPCDz5ZeBur5Hl6JdELLPlJ4YvjmEWw+GcbwosevzGUGyzj5sNWIsisW/2PsfE+Q6dIXdHOlnuOiT64H5tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbReuA+P; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so6880765276.2;
        Wed, 21 Aug 2024 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244677; x=1724849477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOG++QJ0OGWqR78GWEt1ZiOHgTX65k5yfxlanPv90zo=;
        b=cbReuA+P9TGarG9p6DV7iH7fAUEMnjaUSGsrlfIbQrSYB+vJeBIFW+P2QkqKu4BKLM
         EIOYaCdmwnRfq28IQsi1g7qIGHYhJaxAa4OmnDPKkkoz5s0ySyrHD+/W6aBExTLjIvU7
         finhCbM1L8q+xl70Dz502GkwHxDcAiv5JDigqIYZVFvWyqc+crbvcnx8vr9y9qtAR9x1
         qn8L9tPcg0b/Sa4y8epc9poEaYWRW44GXK5EGxgNHgnx4THRZGx3JqTXzG+2hhQNGysm
         GpnQi8Ti47Iec6P5BpaM4rUitKV+6A061unqwzV18Pj4aOa11opzesbYdL8l0+51wIcV
         1Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244677; x=1724849477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOG++QJ0OGWqR78GWEt1ZiOHgTX65k5yfxlanPv90zo=;
        b=pJsOu/hFAXh4a8HlNTBDLTzCFpkFOM+L38A4Cv0MmdiKDIleHOQw6mPQYtcnJSIX+g
         aH4Pa4SvXcpf1t19/+XZTmm0exyki/QYxXDDJX9R7QeQk5bf73DaoezbXkNrIfKJ8pYB
         SvbUyE/G+q567gmB49/SQEoP8azQc81O+Ee3P/V2KfKe4p1gNFImk87LEvX4vAuCP2Z6
         WMfnu7fv7IRAujD5scAS/E123zi0srypgxJFyBXGov493JSpHUT621TPn0gB+Zn8Z+ZU
         Yzbh5aMdeTXltxW5ggZpg1Xh5oC1CBXX3sbEDYKZSfdLYQKCSB2Rc27ZVzKCGWzULYLZ
         wAyA==
X-Forwarded-Encrypted: i=1; AJvYcCUBkknkyG4pBANTgwNokAjJPlG95TanhssOSBfXJqxYkMSo/IE15wvO1ue5Ih3lbR8L8FQBlK+u+99q9lc=@vger.kernel.org, AJvYcCXI+7i/pW8yhnddCfEcbukcPOrbd0eDo14QD1FQ7JzSh7Nbw+gja0dyw9Hz2txk1uvVDe4vIH6L@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmHOGwtRevjfirlABA2ZQ0qk1c079U6KUSeh3wV/wWXRu0Q0D
	J73cok+sK3JkNLDRhNF+PQGdwAnMuuYjgS+sxE6qGYhrNa9IX2ktLsfQLU+pktcZB2oZvtIw0KP
	lgNXJkZlUPNanPaLmA3H7RrSZp1Q=
X-Google-Smtp-Source: AGHT+IFShhXAcE2WpXk6hmJXVDhg0nd8THEMBUPGls6mk3mwrVGCadfHo/LViWOs4YP6ymvT4rv+POJ2M7PJoI6Hf8I=
X-Received: by 2002:a05:6902:18d0:b0:e11:baf6:a323 with SMTP id
 3f1490d57ef6-e16664c873dmr2478013276.39.1724244676458; Wed, 21 Aug 2024
 05:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-7-dongml2@chinatelecom.cn> <20240816192243.050d0b1f@kernel.org>
 <CADxym3ZEvUYwfvh2O5M+aYmLSMe_eZ8n=X_qBj8DiN8hh2OkaQ@mail.gmail.com> <20240819155945.19871372@kernel.org>
In-Reply-To: <20240819155945.19871372@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 20:51:12 +0800
Message-ID: <CADxym3YTH_AGnr6AZUO5PWL0nWDak7Kx+x-niA+Z-fmdsZ_OUA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to vxlan_rcv()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, idosch@nvidia.com, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 6:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 17 Aug 2024 19:33:23 +0800 Menglong Dong wrote:
> > On Sat, Aug 17, 2024 at 10:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Thu, 15 Aug 2024 20:42:58 +0800 Menglong Dong wrote:
> > > >  #define VXLAN_DROP_REASONS(R)                        \
> > > > +     R(VXLAN_DROP_FLAGS)                     \
> > > > +     R(VXLAN_DROP_VNI)                       \
> > > > +     R(VXLAN_DROP_MAC)                       \
> > >
> > > Drop reasons should be documented.
> >
> > Yeah, I wrote the code here just like what we did in
> > net/openvswitch/drop.h, which makes the definition of
> > enum ovs_drop_reason a call of VXLAN_DROP_REASONS().
> >
> > I think that we can define the enum ovs_drop_reason just like
> > what we do in include/net/dropreason-core.h, which can make
> > it easier to document the reasons.
> >
> > > I don't think name of a header field is a great fit for a reason.
> > >
> >
> > Enn...Do you mean the "VXLAN_DROP_" prefix?
>
> No, I mean the thing after VXLAN_DROP_, it's FLAGS, VNI, MAC,
> those are names of header fields.
>

Yeah, the reason here seems too simple. I use VXLAN_DROP_FLAGS
for any dropping out of vxlan flags. Just like what Ido advised, we can use
more descriptive reasons here, such as VXLAN_DROP_INVALID_HDR
for FLAGS, VXLAN_DROP_NO_VNI for vni not found, etc.

> > > > @@ -1815,8 +1831,9 @@ static int vxlan_rcv(struct sock *sk, struct =
sk_buff *skb)
> > > >       return 0;
> > > >
> > > >  drop:
> > > > +     SKB_DR_RESET(reason);
> > >
> > > the name of this macro is very confusing, I don't think it should exi=
st
> > > in the first place. nothing should goto drop without initialing reaso=
n
> > >
> >
> > It's for the case that we call a function which returns drop reasons.
> > For example, the reason now is assigned from:
> >
> >   reason =3D pskb_may_pull_reason(skb, VXLAN_HLEN);
> >   if (reason) goto drop;
> >
> >   xxxxxx
> >   if (xx) goto drop;
> >
> > The reason now is SKB_NOT_DROPPED_YET when we "goto drop",
> > as we don't set a drop reason here, which is unnecessary in some cases.
> > And, we can't set the drop reason for every "drop" code path, can we?
>
> Why? It's like saying "we can't set return code before jumping to
> an error label". In my mind drop reasons and function return codes
> are very similar. So IDK why we need all the SK_DR_ macros when
> we are just fine without them for function return codes.

Of course we can. In my example above, we need to set
reason to SKB_DROP_REASON_NOT_SPECIFIED before we
jump to an error label:

reason =3D pskb_may_pull_reason(skb, VXLAN_HLEN);
if (reason) goto drop;

xxxxxx
// we need to set reason here, or a WARN will be printed in
// kfree_skb_reason(), as reason now is SKB_NOT_DROPPED_YET.
reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
if (xx) goto drop;

Should it be better to do it this way?

Thanks!
Menglong Dong

