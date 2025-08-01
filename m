Return-Path: <netdev+bounces-211297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB7B17AD9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 03:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A40566CAD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D82E630;
	Fri,  1 Aug 2025 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/VwyaxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F623AD;
	Fri,  1 Aug 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011917; cv=none; b=FO0qnLceuFBas8MbGpylgzy1NAIfe9rObdp5q6U9dyT7u7wajXooIH7Nk8jrCIjNlAy0sRLuevwFErGgHJbbNBqSjtH/8qiNO76c+tvCWoGJoQiu9l1/tK843vmEcAidlOwtlq/aC74jFDXWr9LvbSZSApWbjB/jeoiCETZSARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011917; c=relaxed/simple;
	bh=EtR6yO9UZ08THx1170S3dNDVswMAMNqtMzZAAJm8t0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe07oWqjTWBrEyKEwKlNzs66Bl0dZ8wFe0u8XdPc0fSv9sumqE23b+mnQR+eRVf7T8YlxgwZM1rz/nY3mJOEL9ysERZjcvbITK3s/cKbD7ZheR8fEOuQt0K1MCxTiDSzDueYufBFJ/WOpd5AR3wMsM+B9J88tzrh0Ajpm1QGh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/VwyaxC; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71a455096e0so2459087b3.0;
        Thu, 31 Jul 2025 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754011914; x=1754616714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltQZSrmt8WbjklX3MF3CrZkM7vHQwZHQPu8k4QbMARo=;
        b=j/VwyaxCw5IYPkPqmoOHNQnvF8R859EbK1b/1JO9ciqAWo34DpBMwjWFldZGG0iSiV
         p4I+SUpd59chLpV9meO1Hhe6JCxH9gFX9QyVCFNnBqFvmtNi1q4vUtxsROsOoIJsrs+X
         W0yO/lVyhRGtDshviqsaiANzpsgVn4/xVtGJmHt6WbYY8edDtnCr2sPQGH07Sv4Q81Kg
         VCCXgmSfVNqYtbysQRP47DkZcNzn74gmRmj4Rl7X0CaV0gb0QjTL0fdm0ipRpK7iBYsu
         jWn6KeBjU96filxEcv5jROiUxG7ce59tLToYA1iUWWC6Jo4dScwKiTt8s5v+IsdDMPzL
         g/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754011914; x=1754616714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltQZSrmt8WbjklX3MF3CrZkM7vHQwZHQPu8k4QbMARo=;
        b=vWLamZSVq8UptnYUo9YZIKfKNw1M8wLvW4LmjkG56ol3GOno0tiQ0/2CKSfL8oBN81
         zs6TNgQZoXM6kA4sdQdNVM2/ZezW+RpLKsItIKBlOE91oXq3KSuQOIgor8290Lr1mGSN
         Hf6IcPZbskrmrOEk4wwjy91E4Fk8KhK4bYDERh5mzMf9ae1bbxEAETrah5Eb1BN7PTJe
         8ulkbw9b51hOqFwb10qtTnk7v+RLdibiAnPmjky4BaLbIcNnid2c/imi9vm3memYanBi
         x7w0tUsVDak4OkXTiQ6FWb/Z79yILLBdkSg92w/onAsd04AH2O1EDa+aeFJt2e02zLHg
         30hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7bBEzKAv0bpQ3ZMYfb3x7ZOnQ0GEpitEHiHDTIAlZlMBkoETSw0Vc9z91NRa1mGqj2gsUnBeJs546kw=@vger.kernel.org, AJvYcCXVl8JUMvnbGKWIfoFrs0NveWo55q/tLW3nVml02wTARLHldwR3iyeLOom1jQUnWQRUIiXX9tbd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jh23qfIypHHp1rS7JVzgzjzmBnlKg+iV2XxAtjx42cBun7jz
	6n0Of80rcCTxHUyAEkskCQQLXYKffw4mCDcDasOeNWHNeA74HUk7VI3BUvkbxtGdWwpOqxvsdzP
	g3MeoksxKLtXmhk2+rPssKhGTz/u6or0=
X-Gm-Gg: ASbGncvMQHRXw6J9cRMm+ZRAaw1lMOrgv2LIqMyj73ZJOxIDsIt93TyFKrgH3ZfFpGA
	oUXZAKoYm/dM+niOZV0KsHNINRGkWiXY9y43CS3YnYg9sctFt+3WmBv1m9xIDUtSae0h1IlA5KF
	e2ppC2Rf1eMIwIubL3O0FZlbNxJPqh86pJCD1A0VWZxkK7IaSy5wagISwl07CfcD6nAebkvlLV7
	HT559I=
X-Google-Smtp-Source: AGHT+IEtbwsoJrYGQ+Ccb91icHnvoehUzyR2ow+2qIQaZ6tFAvrCL19RKm6xbzLm8qGn08jPnkCJ/shPrNXJKTishNo=
X-Received: by 2002:a05:690c:6f8d:b0:71a:360d:2e43 with SMTP id
 00721157ae682-71a46680731mr117553857b3.27.1754011914428; Thu, 31 Jul 2025
 18:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123309.184496-1-dongml2@chinatelecom.cn>
 <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com> <CAAVpQUD-x1rCZNvPb1nTpzn276gZZKC1DDNxagdiLdpOp=KLHg@mail.gmail.com>
In-Reply-To: <CAAVpQUD-x1rCZNvPb1nTpzn276gZZKC1DDNxagdiLdpOp=KLHg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 09:31:43 +0800
X-Gm-Features: Ac12FXw3r6oeLoHvESISY8SsZDj_TWJHQI0jHRwhuvcruAhbDPNFe1dT4o5E6NU
Message-ID: <CADxym3YgyBpkEgDApyL4LXsLPBhO4r5DU+oX1pF_p6_BsvyVNw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Craig Gallek <kraig@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:52=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Thu, Jul 31, 2025 at 6:01=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > For now, the socket lookup will terminate if the socket is reuse port=
 in
> > > inet_lhash2_lookup(), which makes the socket is not the best match.
> > >
> > > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234=
",
> > > but socket1 bind on "eth0". We create socket1 first, and then socket2=
.
> > > Then, all connections will goto socket2, which is not expected, as so=
cket1
> > > has higher priority.
> > >
> > > This can cause unexpected behavior if TCP MD5 keys is used, as descri=
bed
> > > in Documentation/networking/vrf.rst -> Applications.
> > >
> > > Therefor, we lookup the best matched socket first, and then do the re=
use
> > > port logic. This can increase some overhead if there are many reuse p=
ort
> > > socket :/
>
> This kills O(1) lookup for reuseport...
>
> Another option would be to try hard in __inet_hash() to sort
> reuseport groups.

Good idea. For the reuse port case, we can compute a score
for the reuseport sockets and insert the high score to front of
the list. I'll have a try this way.

>
>
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > I do not think net-next is open yet ?
> >
> > It seems this would be net material.
> >
> > Any way you could provide a test ?
>
> Probably it will look like below and make sure we get
> the opposite result:
>
> # python3
> >>> from socket import *
> >>>
> >>> s1 =3D socket()
> >>> s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> >>> s1.bind(('localhost', 8000))
> >>> s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
> >>> s1.listen()
> >>>
> >>> s2 =3D socket()
> >>> s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> >>> s2.bind(('localhost', 8000))
> >>> s2.listen()
> >>>
> >>> cs =3D []
> >>> for i in range(3):
> ...     c =3D socket()
> ...     c.connect(('localhost', 8000))
> ...     cs.append(c)
> ...
> >>> s1.setblocking(False)
> >>> s1.accept()
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib/python3.12/socket.py", line 295, in accept
>     fd, addr =3D self._accept()
>                ^^^^^^^^^^^^^^
> BlockingIOError: [Errno 11] Resource temporarily unavailable
> >>>
> >>> s2.accept()
> (<socket.socket fd=3D15, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0=
.0.1',
> 8000), raddr=3D('127.0.0.1', 44580)>, ('127.0.0.1', 44580))
> >>> s2.accept()
> (<socket.socket fd=3D16, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0=
.0.1',
> 8000), raddr=3D('127.0.0.1', 44584)>, ('127.0.0.1', 44584))
> >>> s2.accept()
> (<socket.socket fd=3D15, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0=
.0.1',
> 8000), raddr=3D('127.0.0.1', 44588)>, ('127.0.0.1', 44588))

I have a C test case, but this test case is good enough.

>
>
>
> >
> > Please CC Martin KaFai Lau <kafai@fb.com>, as this was added in :
> >
> > commit 61b7c691c7317529375f90f0a81a331990b1ec1b
> > Author: Martin KaFai Lau <kafai@fb.com>
> > Date:   Fri Dec 1 12:52:31 2017 -0800
> >
> >     inet: Add a 2nd listener hashtable (port+addr)
>
> I think this issue exists from day 1 of reuseport support

Yeah, it seems that it exists from the beginning of the reuseport
support.

>
> commit c125e80b88687b25b321795457309eaaee4bf270
> Author: Craig Gallek <kraig@google.com>
> Date:   Wed Feb 10 16:50:40 2016
>
>     soreuseport: fast reuseport TCP socket selection

