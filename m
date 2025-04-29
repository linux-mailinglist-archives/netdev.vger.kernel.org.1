Return-Path: <netdev+bounces-186656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94EEAA020D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0A41B60235
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBB274647;
	Tue, 29 Apr 2025 05:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048E270ECD
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905818; cv=none; b=EUdGcrn+Dbfs7D8C9BB3G9IwvlgGAtKaPDq7eYdBzsHt2S3OM+LjTjJZ7uf1FFJDeCvHfOkR2sLJeKVYpvxU0pGDfctogKaLqytXCff4kt6p3tiPXOzLxE3Fw2OfEFpKHdNAbTsJDl5Q3pqDhe/O8++qKgIMEmhNQJvpewoWyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905818; c=relaxed/simple;
	bh=MbUdQJ8uMDoDJtp7jwLtx4jR1eO9ZMl8f/GioT48EzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1hr6zOmnyex9M7gMUdMLBU3wz8hYwamSnTFsIOim/3DEHBi7kVkeUOKWAEWACnRmtCCA3ExWsX2J90DXIEZYTTgpUwDNeMf6JnSYQo9aeC9P7B4g7xGC+UiQNVLyaV4YXoaGHcJiw6WcwRU1i8fskctin4uPnZvDEW0HpHW+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3630193f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745905813; x=1746510613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbUdQJ8uMDoDJtp7jwLtx4jR1eO9ZMl8f/GioT48EzI=;
        b=AxDS7gKrAras+cnuu/oH1pAYVKEVTERzDM1GPgdsTOAGQmEZBIS2floba4sZi1zSNn
         Efa6s63XZ5E79rq0aqPIgcsBqqKKp9mSbLxeaIJmklWDLwmghf1pBOrI+0e+U7o0BHFI
         YaE0vasg3JTBRHiMciX7S0RBIJzK0llFE8nz5MoWF0hwB3GNpbzNVPEy7phhXOh+4XaN
         TIVrxgmGpNSVA7wwyOVvBkXS+BpDb8eZ1h5Wj5Bj7B9YLJFDNOvUT/SsfghVF9OKdBJ9
         4tExLj6Kso8U3Y8/jg+7heaAmfpV1Qwlmfhf+YpdpAvDZVhHPlTUx5btD0QeCeniHDoh
         uuKg==
X-Forwarded-Encrypted: i=1; AJvYcCWqJBtFRp0C5NfHNd58UIVjc5vzSsPmaK6xJ7VV3dyijBpTDSgYIprAGy2jcUDFXDe/1Tc18pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLoXXx86IPf7mWEPItAON3rH+0yEariL1YVdhnk8XF+HvtlU4
	CQl/3wibiWVpjjHuz97p1v3g0OYTI54mg/raEKDrLzQjPeWUlX+8kzsCtOBE
X-Gm-Gg: ASbGncs3niWHl0x5ppT0iG6WTiiT+tXDbGeBRqxwNK32S5pyP5y4z7MJ3PevaTcaSRl
	YFeK1oU3G0rKTf0zpgQpzS2QwxY9/LwIwZqKJJDfhviSMvQwo/1mu0ZFnxOkuXx6FKVdVBAxL2w
	AUTd/LIHSfZOLcle974C7outAZln1v0gp/JNbIRyOKiL9fKHo/YaVe7G/m6/RMWVTLR6hEgzrLH
	kZ+um7ncrjOFV/vG/BxpTDmgKudPFmxT4sndBCBCYu4miQF4Ex/WLX3rKgTT3WByfWwbJhIx94+
	Es21OyF5/f7T49mn0EuSfdjKj5m+g2hhWBEaMs2l9eOun2zY
X-Google-Smtp-Source: AGHT+IEsolNMrMqby68BQtbvzflIWNvjRzwqXWu+usXNv7vpWH0CC4VHp85OIXnKXHy01Lv1V8dlng==
X-Received: by 2002:a05:6000:1286:b0:39c:1f04:a646 with SMTP id ffacd0b85a97d-3a07aa6d787mr7642501f8f.13.1745905813146;
        Mon, 28 Apr 2025 22:50:13 -0700 (PDT)
Received: from [10.148.85.1] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca557bsm13024951f8f.35.2025.04.28.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 22:50:11 -0700 (PDT)
Message-ID: <1d99d7ccfc3a7a18840948ab6ba1c0b5fad90901.camel@fejes.dev>
Subject: Re: [question] robust netns association with fib4 lookup
From: Ferenc Fejes <ferenc@fejes.dev>
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@gmail.com, netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
Date: Tue, 29 Apr 2025 07:50:10 +0200
In-Reply-To: <aA-gNpCWG2XJaf-X@shredder>
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
	 <aAvRxOGcyaEx0_V2@shredder>
	 <2eb4b72dc5578407715e91f87116d2385598fa82.camel@fejes.dev>
	 <aA-gNpCWG2XJaf-X@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-28 at 18:35 +0300, Ido Schimmel wrote:
> On Mon, Apr 28, 2025 at 12:20:06PM +0200, Ferenc Fejes wrote:
> > On Fri, 2025-04-25 at 21:17 +0300, Ido Schimmel wrote:
> > > On Thu, Apr 24, 2025 at 01:33:08PM +0200, Ferenc Fejes wrote:

...

> > > > Unfortunately this includes some callers to fib_table_lookup. The
> > > > netns id would also be presented in the existing tracepoints ([1] a=
nd
> > > > [2]). Thanks in advance for any suggestion.
> > >=20
> > > By "netns id" you mean the netns cookie? It seems that some TCP trace
> > > events already expose it (see include/trace/events/tcp.h). It would b=
e
> > > nice to finally have "perf" filter these FIB events based on netns.
> >=20
> > No, by netns id I mean struct net::ns::inum, which is the inode number
> > associated with the netns. This is convenient since it's easy to look u=
p
> > this
> > value in userspace with the lsns tool or just stat through the procfs f=
or
> > the
> > inode.
> >=20
> > Looks like struct net::net_cookie is for similar purpose and can be use=
d
> > from
> > restricted context (e.g.: xdp/tc/cls eBPF progs) where rich context (st=
ruct
> > net
> > for example) as in a fexit/fentry probe is not available.
>=20
> I'm not sure the inode number is a good identifier for a namespace. See
> this comment from the namespace maintainer for a patch that tried to add
> a BPF helper to read this value:
>=20
> https://lore.kernel.org/all/87efzq8jbi.fsf@xmission.com/

Thanks for the pointer, this makes it crystal clear why the cookie is the w=
ay to
go. The TCP tracepoints also stick with the coockie.=20

>=20
> More here:
>=20
> https://lore.kernel.org/netdev/87h93xqlui.fsf@xmission.com/
>=20
> Which I suspect is why Daniel added the netns cookie:
>=20
> https://lore.kernel.org/bpf/c47d2346982693a9cf9da0e12690453aded4c788.1585=
323121.git.daniel@iogearbox.net/
>=20
> Regarding retrieval of this cookie, there is SO_NETNS_COOKIE:
>=20
> https://lore.kernel.org/all/20210623135646.1632083-1-m@lambda.lt/
>=20
> Seems to work fine [1]. Maybe ip-netns can be extended to retrieve the
> cookie with something like:
>=20
> ip netns cookie [ NETNSNAME | PID ]

Agree, the exposure of the cookie for the userspace with ip netns or lsns w=
ould
be useful. Luckily [1] is straightforward enough and makes the netns
identification trivial.

>=20
> [1]
> # cat so_netns_cookie.c
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>=20
> int main(int argc, char *argvp[])
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 socklen_t vallen;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t cookie;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int sock;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock =3D socket(AF_INET, SOCK_=
STREAM, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sock < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return sock;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vallen =3D sizeof(cookie);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (getsockopt(sock, SOL_SOCKE=
T, SO_NETNS_COOKIE, &cookie, &vallen) !=3D
> 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("cookie =3D %lu\n", coo=
kie);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(sock);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> }
> # gcc -Wall so_netns_cookie.c -o so_netns_cookie
> # ip netns add ns1
> # ip netns add ns2
> # ./so_netns_cookie
> cookie =3D 1
> # ip netns exec ns1 ./so_netns_cookie
> cookie =3D 2
> # ip netns exec ns2 ./so_netns_cookie
> cookie =3D 3

