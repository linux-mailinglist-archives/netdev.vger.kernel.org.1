Return-Path: <netdev+bounces-163642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5EA2B21D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CF43A6B20
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6419D062;
	Thu,  6 Feb 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb7CYwIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786C1A08C5;
	Thu,  6 Feb 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869649; cv=none; b=kLRysoOLqnQhwpRY2SjEUTsAPwj3qHn07va2USnJijmvKFALdvT5ZayNxL5FCRYA6VS/WApJVdBsejZA1bEoTE70gxhjQvU/XU9lQdqVFHkG86iIiP+6uYY2d1r31GhuCAjOTfFy4m0nQyYss+pwvU6rGMme/bKz+2lwalpVUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869649; c=relaxed/simple;
	bh=wLyTuczLfkJDgb7Vqt7YmTXPbJB+eUIqMjkE90T2FQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm+my0h7bLWsKnRMoT5SdE9A37tYs/dtiXmTvbaErnK9kEMCivTVWYlSH/MdMbrAMRasiZNkH1NkHo8RzeaRzLkh14qZ4yH/ho6lKVbr0QHHndvztMv3zjKbcERzDpeQXSlRXYZC5+pxrCZJmubUrU1SXUTob1YB+sdTPUHUHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb7CYwIb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38db8f8786fso692914f8f.1;
        Thu, 06 Feb 2025 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738869646; x=1739474446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ipiY7d7hdZ2wnm287iZMz9BMFpfsuHEv4SR3ZYPhk=;
        b=Hb7CYwIbgUCpJG9IYvbILrPhYyeGYF5DzeCZg2ftNat76CdFZNoLbu8IeAmjl54bRe
         VFWrRXvi8/une5+3owJqGgeYguv1crdJAHmDlWFVSlCFt6nV/Z5xrjg8IejtwACkSA5E
         y7RDa7goo9Hxp1dAw10LM/CtfKTKGEV9Y/UzDEu2uOHD9HZvSywc00isBT/oTcJgPElt
         x5BhjUUwcpPr/8HZPjCc4nwDdsCYf8k2znbzQV5bGs7eRKCuI4760QvxDhMVvdR0ILXG
         B3qe1CHma321IWalQtxJEeAsakcIF6J0QAlKdvCQy2kczSUJfuxClQaTaieUW9wxemyG
         ddGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738869646; x=1739474446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5ipiY7d7hdZ2wnm287iZMz9BMFpfsuHEv4SR3ZYPhk=;
        b=iy/Uh+mQ1nAQKRv9OF2t5f5S7l78dQjlbTCoWW4Oc/6a3tLeFde1hfbkwoqBkI+EJR
         od3tDdXcB/2f1bXMPNjS6sbPAUVVhDbj/AGGwLc5TRKXH3cc2lI6vbX/lzxaHn/Nq20V
         4LBgXF9teUbm/scEZTzpls59NQDEkbVtppvB/m9Yaaaw2DQbiXDvlWuU1q0T7FikC0mQ
         XkhiigmGK5kDvb67pDaVEqUdqHlaIlIC6VF0n5cCi+9bMaBMisTvIlAXkgM/3PL0CCGP
         dreqxBsUr849uMhf8fU/NOVf71IAgahdNXM3VgeesgxmXOXQPRC3JkdZ9byQP4sgx9X/
         BoZg==
X-Forwarded-Encrypted: i=1; AJvYcCWstSRHlZoR11xJxDWgxua1ZjGQV3FzglYMKil7MlNsrPA3OzDGDRieA/5QylbrJNXoTCYbaWgI@vger.kernel.org, AJvYcCX8YkpNzLhBek8uTHEPLGYhHnnihxocSILDbqkSGnGMT7HAfpwNniUq7GE22ruY2sW1oIb04538Le/SiAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxUSOjbf1utEwGVviFSJYG+8U8rn8VSWYeOgj8fFV0n5l0xN38
	bS4YCKLrKPU+IpnUHTb2hDfSISoPZLBjaol56l0ADicTpDSZdkXR
X-Gm-Gg: ASbGncscMHEchMJopSzLJisgEdOC/nzAxpvzzeFEseHr6WbNlQLSnPDpKewldUpwKqt
	4gllfadigsAkrQQ9RfG3zK2NMdqqjtlCExxBusbFey2pBPIVTJ6yGYsifeGAElvanYAvAQx+tEd
	gI8ka6SO/rG0HR3NTsjvD83Fa1HrHsvIQMJGZ4XbSrFmpYnYKpjhU8nxPzDKNPlkrS94ZsML4lm
	i1uNOpryYmzd0hCVy2a7v3ojmEmpFLb4WWAWvY9gvqOFQ4dRHAjg/gQVszGQUWtJegUZFH2GX/k
	g3jr+hVHR5Pr12l3/JJGDs9m3CdcDegQy1oqWvIEaI92pkofaWTLmw==
X-Google-Smtp-Source: AGHT+IEjcBTkGjCYu5heAFU4gvfnsZm0P6S3ocyUKdQRoRKMMhpLgBrw1Kc78T/PBxC089sCBIN1LA==
X-Received: by 2002:a5d:6da5:0:b0:38d:c88e:d576 with SMTP id ffacd0b85a97d-38dc8dc37d7mr125756f8f.5.1738869646132;
        Thu, 06 Feb 2025 11:20:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc17e278bsm1785856f8f.48.2025.02.06.11.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:20:45 -0800 (PST)
Date: Thu, 6 Feb 2025 19:20:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Liang Jie <buaajxlj@163.com>
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, liangjie@lixiang.com,
 linux-kernel@vger.kernel.org, mhal@rbox.co, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind
 identifier length
Message-ID: <20250206192044.14173597@pumpkin>
In-Reply-To: <20250205100904.2534565-1-buaajxlj@163.com>
References: <20250205082841.94701-1-kuniyu@amazon.com>
	<20250205100904.2534565-1-buaajxlj@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Feb 2025 18:09:04 +0800
Liang Jie <buaajxlj@163.com> wrote:

> On Wed, 5 Feb 2025 17:28:41 +0900, Kuniyuki Iwashima <kuniyu@amazon.com> =
wrote:
> > From: Liang Jie <buaajxlj@163.com>
> > Date: Wed,  5 Feb 2025 14:06:53 +0800 =20
> > > From: Liang Jie <liangjie@lixiang.com>
> > >=20
> > > Refines autobind identifier length for UNIX domain sockets, addressing
> > > issues of memory waste and code readability.
> > >=20
> > > The previous implementation in the unix_autobind function of UNIX dom=
ain
> > > sockets used hardcoded values such as 16, 6, and 5 for memory allocat=
ion
> > > and setting the length of the autobind identifier, which was not only
> > > inflexible but also led to reduced code clarity. Additionally, alloca=
ting
> > > 16 bytes of memory for the autobind path was excessive, given that on=
ly 6
> > > bytes were ultimately used.
> > >=20
> > > To mitigate these issues, introduces the following changes:
> > >  - A new macro AUTOBIND_LEN is defined to clearly represent the total
> > >    length of the autobind identifier, which improves code readability=
 and
> > >    maintainability. It is set to 6 bytes to accommodate the unique au=
tobind
> > >    process identifier.
> > >  - Memory allocation for the autobind path is now precisely based on
> > >    AUTOBIND_LEN, thereby preventing memory waste.
> > >  - The sprintf() function call is updated to dynamically format the
> > >    autobind identifier according to the defined length, further enhan=
cing
> > >    code consistency and readability.
> > >=20
> > > The modifications result in a leaner memory footprint and elevated co=
de
> > > quality, ensuring that the functional aspect of autobind behavior in =
UNIX
> > > domain sockets remains intact.
> > >=20
> > > Signed-off-by: Liang Jie <liangjie@lixiang.com>
> > > ---
> > >  net/unix/af_unix.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 34945de1fb1f..5dcc55f2e3a1 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -1186,6 +1186,13 @@ static struct sock *unix_find_other(struct net=
 *net,
> > >  	return sk;
> > >  }
> > > =20
> > > +/*
> > > + * Define the total length of the autobind identifier for UNIX domai=
n sockets.
> > > + * - The first byte distinguishes abstract sockets from filesystem-b=
ased sockets. =20
> >=20
> > Now it's called pathname socket, but I think we don't need a comment he=
re.
> > We already have enough comment/doc in other places and the man page.
> >=20
> > $ man 7 unix
> > ...
> > The address consists of a null byte followed by 5 bytes in the characte=
r set [0-9a-f].
> >=20
> >  =20
> > > + * - The subsequent five bytes store a unique identifier for the aut=
obinding process.
> > > + */
> > > +#define AUTOBIND_LEN 6 =20
> >=20
> > UNIX_AUTOBIND_LEN
> >=20
> >  =20
> > > +
> > >  static int unix_autobind(struct sock *sk)
> > >  {
> > >  	struct unix_sock *u =3D unix_sk(sk);
> > > @@ -1204,11 +1211,11 @@ static int unix_autobind(struct sock *sk)
> > > =20
> > >  	err =3D -ENOMEM;
> > >  	addr =3D kzalloc(sizeof(*addr) +
> > > -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> > > +		       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_=
KERNEL);
> > >  	if (!addr)
> > >  		goto out;
> > > =20
> > > -	addr->len =3D offsetof(struct sockaddr_un, sun_path) + 6;
> > > +	addr->len =3D offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
> > >  	addr->name->sun_family =3D AF_UNIX;
> > >  	refcount_set(&addr->refcnt, 1);
> > > =20
> > > @@ -1217,7 +1224,7 @@ static int unix_autobind(struct sock *sk)
> > >  	lastnum =3D ordernum & 0xFFFFF;
> > >  retry:
> > >  	ordernum =3D (ordernum + 1) & 0xFFFFF;
> > > -	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
> > > +	sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernu=
m); =20
> >=20
> > I feel %05 is easier to read.  Note that man page mentions 5 bytes.
> >=20
> > 1 is also hard-coded here, but I don't think we should write
> >=20
> > sprintf(addr->name->sun_path + UNIX_ABSTRACT_NAME_OFFSET,
> >         "%0*x", UNIX_AUTOBIND_LEN - 1, ordernum)
> >  =20
>=20
> Hi Kuniyuki,
>=20
> Thank you very much for your suggestions. I will incorporate them and
> submit [PATCH v2] accordingly.
>=20
> The logs from 'netdev/build_allmodconfig_warn' indicate that the patch has
> given rise to the following warning:
>=20
>  - ../net/unix/af_unix.c: In function =E2=80=98unix_autobind=E2=80=99:
>  - ../net/unix/af_unix.c:1227:48: warning: =E2=80=98sprintf=E2=80=99 writ=
ing a terminating nul past the end of the destination [-Wformat-overflow=3D]
>  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN=
 - 1, ordernum);
>  -       |                                                ^
>  - ../net/unix/af_unix.c:1227:9: note: =E2=80=98sprintf=E2=80=99 output 6=
 bytes into a destination of size 5
>  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN=
 - 1, ordernum);
>  -       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
>=20
> It appears that the 'sprintf' call attempts to write a terminating null
> byte past the end of the 'sun_path' array, potentially causing an overflo=
w.
>=20
> To address this issue, I am considering the following approach:
>=20
> 	char orderstring[6];
>=20
> 	sprintf(orderstring, "%05x", ordernum);
> 	memcpy(addr->name->sun_path + 1, orderstring, 5);
>=20
> This would prevent the buffer overflow by using 'memcpy' to safely copy t=
he
> formatted string into 'sun_path'.

Except that the compiler is very likely to bleat about sprintf() possibly
writing more than 5 hex digits.

By far the best thing to do is just make the kmalloc() 'a bit too long'
so that there is space for snprintf() to write the '\0'.

The kmalloc() size is rounded up anyway.
It is extremely unlikely that changing to 16 to 7 (or 6 as you are doing)
makes any difference to the amount of memory actually alloced.

OTOH the code size changes are real.

	David


>=20
> Before proceeding with a patch submission, I wanted to consult with you to
> see if you have any suggestions for a better or more elegant solution to
> this problem.
>=20
> Thank you for your time and assistance. I look forward to your guidance on
> this matter.
>=20
> Best regards,
> Liang Jie
>=20
> >  =20
> > > =20
> > >  	new_hash =3D unix_abstract_hash(addr->name, addr->len, sk->sk_type);
> > >  	unix_table_double_lock(net, old_hash, new_hash);
> > > --=20
> > > 2.25.1 =20
>=20
>=20


