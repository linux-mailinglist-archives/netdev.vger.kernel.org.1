Return-Path: <netdev+bounces-211246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1FB175CE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC36A84044
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8528DEE4;
	Thu, 31 Jul 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI5Fj0bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3123C51F
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984381; cv=none; b=JvVEiWir7OX0dO4uijMj5Fm8omSTjOdhD34zByHuWKiEMoYxnM6Sq3Rc54BuoxViXX3GcgcxU0+N1L8IqvdE4Z4wgtWShfmfYD95eU7Vpy0vPKrtunbPFlZBU6VZlJqpSN7p6xiq8WTkdpqTs3IFZ5CRjYcAF2FscJLGGrxnUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984381; c=relaxed/simple;
	bh=f7I4D5bRrFpVUSnKKWjwbljVl0Vn4LWBPJ3cbkOT234=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+LJCnFijFrwXSDoGrvQ0RBY4zMFUTXQiJrtRn/RHlCLY9zQMmb31WMBG+N70MgG+YIr+2q/41tI9YHGgvuRshdotpRhJ5xlsk5Gijz/h0R5JpRlu7w8OvqhTgsU5oGFcGP2sym+WEs1rdHZWSMztq2gQlzr806ZioLJewKnR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI5Fj0bl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so3767a91.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753984379; x=1754589179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i96hflCH6rE1VrfIns9QcxJpVAhOLAwN1mOSX1dDKg=;
        b=ZI5Fj0blrzWfUtPy6doWH9En27RMOyJyqQEfB4ZpaF7N/l42z8avGpucQ6FIE2HZZe
         jEjUq8FFM9/SCsJ+HPxydGc6BZcYAqM8pCjZRKKjIi5+HkIrSSEs26pVOvOGOT33AnI+
         Xe0v9gncfn0cl/xhprE7a1LiYEcLvdsApcgGeZQuBCcpzrrSeKvsb5D2Ceh265zCmI3R
         yuqDID81syK8cxdPOTwbSRImRk7m+kfra1jiU+u76J9bFW4fFIXHSlw0hfxD4SjwQUB5
         lCrWqTmW8gPqek/v0wZa4HG1CLUpNoMU3hq/mzotoGGIp9UOf28QjILetRqCfuCxiT3Q
         2nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753984379; x=1754589179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i96hflCH6rE1VrfIns9QcxJpVAhOLAwN1mOSX1dDKg=;
        b=XlGAhQlEa0/fXc+Y/tLwvaKWBoOCC6jTDB8XBwmUzimu+whZupRoEY9yzKFWPGZ3b6
         HTeJP2eRu+05gXaBD+nGuiIpJqIaKfIHwHmVBiOXKSI+kSrYdK+93sV2A7DHBZBvZWik
         ssvTmbUJADFHMHJ8zVlI7G2ziJMZmalsUtJsGT2T7yrGR1Lgm0oPdfHS6fUzOxv3mKMh
         ygFJ5H6sK/z74JogIeeN0EytWKdZQA12Nb1xj1XVkhsuaWBVeAX5jA8W2SkuN1j3bTQZ
         ZA24DuJxu66cvpsTHrphKC1PgAVbsY7i1JoD0bORa4lr3uw0XMFBZ/NCf243cmb+xMFB
         0UpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJQN7VNnfGZdPfZ7UVeSA8sLskIoiQxYBdSDGiEMzJyoBDJQbb6KDAVgr5/NI0wp7YV/Qdp5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GM7SdQh5tKpzP8BmCv3DgekM2TCf87ihBQo3w5fH1P4Q3YPy
	P/30uwfyZBC0j/9zqQAWoxeP0Y8F0m+PUZRp2FvTR8rh9J4diyIZhfaAGQ8W0QVwwsTwuoWjulm
	OCX6miiuMJS2L5G+LoqUjp9cSluZlr0nWPLnEuUpZ
X-Gm-Gg: ASbGncvL2QKczmFMv+/WZKAWHIkzheqaajuV4H0xLgiyW4Cl2dq7DafbiHTaVWX2Gjk
	qzQ3u8OTYl10zBbfAnHsBJfI6elQw311Njf3kYu4fKbhgTmbVJGgzE57XcsRkWQAWVzyABqXRlo
	8dIk8D1HGfPGMf7Lk9i2yeIP5T418UjjJZQHAYHWB3pLJ+LJl06ZCaB4vPeyhqj48nPUFVSZL3G
	q6fEjIYIdeqrG2MYYP23chY+/BylQvophqFRVbZZE9PhQ==
X-Google-Smtp-Source: AGHT+IHrV92yExpjiYbr6k5wfu4F8hEv9JS3M/1Mh+7JebKT/GmHzDJlkHT5YzyPimtkV08vdLWrhJPoBqzggMNI9to=
X-Received: by 2002:a17:90b:288b:b0:31e:fac5:5d3f with SMTP id
 98e67ed59e1d1-31f5de54b78mr11144099a91.16.1753984379015; Thu, 31 Jul 2025
 10:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123309.184496-1-dongml2@chinatelecom.cn> <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com>
In-Reply-To: <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 31 Jul 2025 10:52:46 -0700
X-Gm-Features: Ac12FXxk6hY81yp_ALLyLIm98qzun7sjQ1BoLWVkmdVqhsT_9Zm5JxGeq6NpJqU
Message-ID: <CAAVpQUD-x1rCZNvPb1nTpzn276gZZKC1DDNxagdiLdpOp=KLHg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
To: Eric Dumazet <edumazet@google.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Craig Gallek <kraig@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, the socket lookup will terminate if the socket is reuse port i=
n
> > inet_lhash2_lookup(), which makes the socket is not the best match.
> >
> > For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> > but socket1 bind on "eth0". We create socket1 first, and then socket2.
> > Then, all connections will goto socket2, which is not expected, as sock=
et1
> > has higher priority.
> >
> > This can cause unexpected behavior if TCP MD5 keys is used, as describe=
d
> > in Documentation/networking/vrf.rst -> Applications.
> >
> > Therefor, we lookup the best matched socket first, and then do the reus=
e
> > port logic. This can increase some overhead if there are many reuse por=
t
> > socket :/

This kills O(1) lookup for reuseport...

Another option would be to try hard in __inet_hash() to sort
reuseport groups.


> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> I do not think net-next is open yet ?
>
> It seems this would be net material.
>
> Any way you could provide a test ?

Probably it will look like below and make sure we get
the opposite result:

# python3
>>> from socket import *
>>>
>>> s1 =3D socket()
>>> s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
>>> s1.bind(('localhost', 8000))
>>> s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
>>> s1.listen()
>>>
>>> s2 =3D socket()
>>> s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
>>> s2.bind(('localhost', 8000))
>>> s2.listen()
>>>
>>> cs =3D []
>>> for i in range(3):
...     c =3D socket()
...     c.connect(('localhost', 8000))
...     cs.append(c)
...
>>> s1.setblocking(False)
>>> s1.accept()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib/python3.12/socket.py", line 295, in accept
    fd, addr =3D self._accept()
               ^^^^^^^^^^^^^^
BlockingIOError: [Errno 11] Resource temporarily unavailable
>>>
>>> s2.accept()
(<socket.socket fd=3D15, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0.0=
.1',
8000), raddr=3D('127.0.0.1', 44580)>, ('127.0.0.1', 44580))
>>> s2.accept()
(<socket.socket fd=3D16, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0.0=
.1',
8000), raddr=3D('127.0.0.1', 44584)>, ('127.0.0.1', 44584))
>>> s2.accept()
(<socket.socket fd=3D15, family=3D2, type=3D1, proto=3D0, laddr=3D('127.0.0=
.1',
8000), raddr=3D('127.0.0.1', 44588)>, ('127.0.0.1', 44588))



>
> Please CC Martin KaFai Lau <kafai@fb.com>, as this was added in :
>
> commit 61b7c691c7317529375f90f0a81a331990b1ec1b
> Author: Martin KaFai Lau <kafai@fb.com>
> Date:   Fri Dec 1 12:52:31 2017 -0800
>
>     inet: Add a 2nd listener hashtable (port+addr)

I think this issue exists from day 1 of reuseport support

commit c125e80b88687b25b321795457309eaaee4bf270
Author: Craig Gallek <kraig@google.com>
Date:   Wed Feb 10 16:50:40 2016

    soreuseport: fast reuseport TCP socket selection

