Return-Path: <netdev+bounces-152865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A39F60B6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA17163C0E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215C195980;
	Wed, 18 Dec 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLDGEGCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16D18858E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512674; cv=none; b=TIDu/cDf8Q+ufpUkYt0sKH1EMH5WYivfTNeVJrE1nL3/k5xCQR18tKFEDWAD/J/bl3AHTzMR4w9vHenFENHlpYFQBXddgJA5SpRtubofu28xckJmRZUWdSl4kCv0uCWupjNqfCysBOiyw+Z56TpUYrbICMnlaviHAJZZOtlC5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512674; c=relaxed/simple;
	bh=TpDkR3fn5A334/XjGASErlPQW+raj/DFAaML7LST/gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhZ3TcDuuQUo05AthabcSDXSXD/HPO9XlN1OsHZycO5akWxZ/9epevUdPZaRbjaJYIqB1gVXrcGUQjSjyp+hC5P4kVz+l0uCZL7BFT5jGSH8wMnxsnhZpGEXY5JbYoqSlVVUYAUnZTw30H2T96uxNk0oWeOdhMgfmJNQk5TcUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLDGEGCS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so11194103a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734512671; x=1735117471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7aWbhA1TNSWoniLVgiWwLv1O2JsZ4E98s0k5Mlh8J0=;
        b=dLDGEGCSg9k5bNyz2w4OTYA3uA1AbFFjOpPhAWYlzmdgHbp5hBXOVJOjYv1NageuVI
         MpGkCDUCwbQNFWj7e+reGKpxkdw6ZodG2PP9PJXml9ZHP4cM5i2naSD7glHqGSrZv+jy
         UGXOLFb30c4+7pnnLG4MYCcf5TMC30/STbkXRE/o7GfKhlhsA599nohCrWzQbe9ZQhpm
         5oVtsb+xqiMrOX2nFp9LHRcEtjvkJBVoADJ2f5d0FbXND1Az5lHn1eh0WTDYAgyb/hwp
         VHG/0KURSLTCkiYipznIlcA6cEZX4fSeTCEb8x383Y+aMfbmAFtUGspdZ72lPzZ/gWru
         x+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512671; x=1735117471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7aWbhA1TNSWoniLVgiWwLv1O2JsZ4E98s0k5Mlh8J0=;
        b=PsSInA0Q7niYXio1RkDaJyJSvLZdAX5GEfblwTXJbqeknBEFgkaZM9PaxzRKw5VXwR
         b8byYU+GgBFQJOX3kSlJOGEhk09dxFZsbL4obp5qIQKye0MCLihFhmZIPWkPGE02Uq4b
         6t/jHSDdVXGTk8ybLtXuLnb6VikXqc43sDH7IKhCQaTs48e/wLY8VR7kbGw4HAvBfogA
         mJPkZD0Onl1G/oBZBC803gnzXlBX+gptOxrI58hzGtgCH5k2SkcPO8I5bTSFUnAA0WAd
         FUguA1K035ChFy/H4duXx6gWCn841ELlatY60pIo69HlOxvIE0erYkIIz+57gIzzAWch
         vbrg==
X-Forwarded-Encrypted: i=1; AJvYcCV0v9i1Gn83PZnXSszXGlQrILIq5mq6gfaT4RsuhoVIgcA3A8JF7vuegIxULrlLEU7YkyFl0II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWMHySYe8Jl5XR/BACHLlQ7ENUs8GhK/Ib2Wc/iXkBed5Y4xC
	fpIIMUIc/lPob3UAxrVmQ0fq5G/HLOEGwHzCg53bjJHNFc2lhL+u2jAHZtSaP7MYORbouL5G44I
	R3iHZpQM5uhFQJCiSPysFOeYSOaUVn25ImUqW
X-Gm-Gg: ASbGncuMjThDV/mo1VjglZGXCXtSG+Gu9SE9w1+5AbSVJrNmCoT1xt7HTka5x2nt7nt
	EyMmWiUHdILBItjnfmf7gPJdKJaot8hJQUIQivaHTK/B740m50z12+IC8wNSPDn+HOOa0Wqc=
X-Google-Smtp-Source: AGHT+IEO30UNhBINR8UjVfKZPYaxlfXK5IzIg1veUpetQBkaygbim5WmKA5+gY8aKANbWk9QWGrzPm7ocahajGqCstw=
X-Received: by 2002:a05:6402:524d:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5d7ee3eb36dmr1968109a12.26.1734512670785; Wed, 18 Dec 2024
 01:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
 <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
 <CANn89iKAZsG=RepuJmStFTH2QK+N5s9Cu=OnD2GmQAb1JKCfeQ@mail.gmail.com> <Z2KHMLJ4oTUwgBSo@gauss3.secunet.de>
In-Reply-To: <Z2KHMLJ4oTUwgBSo@gauss3.secunet.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 10:04:19 +0100
Message-ID: <CANn89iJGYFzHi7eUQo49hmo0eTZzHvDTTqKXTxrSZvKKJXHa7g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Shahar Shitrit <shshitrit@nvidia.com>, "brianvv@google.com" <brianvv@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"martin.lau@kernel.org" <martin.lau@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>, 
	Dror Tennenbaum <drort@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:26=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Mon, Dec 16, 2024 at 04:21:32PM +0100, Eric Dumazet wrote:
> > On Mon, Dec 16, 2024 at 2:29=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 2:18=E2=80=AFPM Shahar Shitrit <shshitrit@nvi=
dia.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > >
> > > >
> > > > We observe memory leaks reported by kmemleak when using IPSec in tr=
ansport mode with crypto offload.
> > > >
> > > > The leaks reproduce for TX offload, RX offload and both.
> > > >
> > > > The leaks as shown in stack trace can be seen below.
> > > >
> > > >
> > > >
> > > > The issue has been bisected to this commit 507a96737d99686ca1714c7b=
a1f60ac323178189.
> > > >
> > > >
> > >
> > > Nothing comes to mind. This might be an old bug in loopback paths.
> >
> > Or some XFRM assumption.
> >
> > Note that ip6_xmit() first parameter can be different than skb->sk
> >
> > Apparently, xfrm does not check this possibility.
>
> Can you provide a bit more context? I don't see the problem.


skb->sk is used in xfrm, and the assumption is that it is a full socket.

List of things that are supported, even for timewait and
request_sockets, and used in xfrm:

sk->sk_bound_dev_if
sock_net(skb->sk)
inet_sk(sk)->inet_dport;

But xfrmi_xmit2() for instance is doing :

err =3D dst_output(xi->net, skb->sk, skb);

Other dst_output() users use : dst_output(net, sk, skb), because sk
can be different than skb->sk

Also xfrm6_local_dontfrag() is assuming sk is an inet6 socket:

if (proto =3D=3D IPPROTO_UDP || proto =3D=3D IPPROTO_RAW)
     return inet6_test_bit(DONTFRAG, sk);

xfrm_lookup_with_ifid() seems ok (it uses sk_const_to_full_sk()), but
we probably miss some fixes.

