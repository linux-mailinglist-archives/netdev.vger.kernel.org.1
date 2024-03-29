Return-Path: <netdev+bounces-83668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64570893486
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FE91C24168
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735B14A4D1;
	Sun, 31 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho+OjBNb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A315ECC1
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903424; cv=fail; b=e71B4Pv4f48k43OaPt+6JXO2i4w34oI014PZIgfce+1ZqlRXq0FdC6OpcXuPjzJ5Bk/HI1njHwhRVPXlDEZdyJOE8ho4yux1SoPktbMyn3wOxhFfjJp9bmNFwCKkkroExFrv2Uy11ELWzb6v13mvrQv/Nwdmc5915dK+nKBtN60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903424; c=relaxed/simple;
	bh=okKFJ5KpXdQbhytNu+zNFuEbpNd3zvy3mFF/IbgFdNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5VSomS7MtCI/43zVrHz5eI/rps+6Ps2b7HMWCKzuZ0KVuUJ3OKstuV/NpiG/m7jeAuqNmKQ0He1w6xlpg+9DUe/YH3jEiDsvQv68PY7MiVPvYe0pKYKZDjP0GiX5ZeG/pXTjGUQk3HkOp8v5hKy4vQczR07Roi2QpWdReuL018=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho+OjBNb reason="signature verification failed"; arc=none smtp.client-ip=209.85.160.45; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 02AED208CE;
	Sun, 31 Mar 2024 18:43:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bpC7UTwNeI1; Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 722D92083B;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 722D92083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 64A1E800060;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:39 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83462-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAxkamlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAXAAAAzIoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16433
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83462-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E41512082B
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746083; cv=none; b=UYQIxJbF0iMH3ZsdAKsR2WhSOeVLknz6XBqGSZdIqglT4g0x+m1+iQAJgbpeDx4K/GP6IKrlLH6vUPW6kiO0E+mH+NyxvPsUhWQ2SDOSQlNMqnuxKt6p8AImZ9ZLnPja0WglzYtRgaxLdCFXDb/++aF693jqKAp/aq43EgHoYI0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746083; c=relaxed/simple;
	bh=1F336ycsZ/DeFmR3ip4gKdMLUxslUjLhibn8LWK2nsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqczGxbj+vc5Ex8+YOql2W5MFQyEyJDvs+VvKZxCZX/YbWFRDEeuR5cJnie4QDZZdUKkWF4hgxcR/Gn3m5DexMqEqSVK1Agq4Gr2DSCmglk4vO609sLx9zCF9KTbdIqb0rfTy0Qw8GBCP3KZDb0Qs3tYWRyoxcTbXU+z3FW17iA=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho+OjBNb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746080; x=1712350880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=;
        b=ho+OjBNbnc3h384Al3xJv2eDnLkMbeh8PklqJBE+HkNQYmq+u3NA3WEUXY6ntS1oum
         BbDLftW/w1L3bnRUkzfKGFj6NOD91Ao5B7w8TbHmTTWygGGJMaI5oluhe6pXWRKlcwQE
         eal66+QsD61hUSz7DafBrrpV7r44uiME3jzCun3upnTJCiz+CzfvihUtTLxPyGFkXtzB
         2XpAMIxS+WY4coIS9d3qLyHgN1MUdr9S9ZepzVwPYxull2EILd3FX8/YV0IsDk1Olzh8
         4VhId5UWqiDJuZFox6GjK+EahBBbT5idHwBSumTfjPybPSAbMGWWeY+vfuxETCQO+JPu
         21+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746080; x=1712350880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=;
        b=mmXVo9v3DV+2/oxtG3OebzaU3GXy2AOrXBmmxq3it5M9egIWB6464eze8fJefK6BIP
         4pVPO0njIslLwBaciyjuicRAS0q5IO2vziESOt8OJMs7B+cupw3i+uzxiQ07vrsp/ok0
         KgXjIm7hYGtVo/vW2SYeLFBgtjr8wsYTLK30/iJ8DKvuIO07W4Vy215kpZfuDl1NGbWb
         zuTwYiVaKaQ1nwPZCV5BHV9cEVqsFYmN0p892Jpnt2Hrtpd8GRxNXMIWRGoy3UPYuE5P
         crdfjhOsuna/vY51d/Vdscks5gpZjbvLR3v/IZZ2W4enAtVGjnilS3Up6N69FPesoi6d
         9hFQ==
X-Gm-Message-State: AOJu0Yxy1Z1OQwgYOlgx6qQOrRpezxRv9fa1TVH11l25zaM22mXmBbSm
	AeQFFbIL2e6QZxC+BatQg1inIxrP8xE3ArNrMah7H0eVgXvXHFwIXqQ0/+4c6/0T85Bl/6xNwxN
	aa6cs7TpBTZPmb37LWn9+9ETHiq3WJK4j0cHKkg==
X-Google-Smtp-Source: AGHT+IFNOkfSs1BURB1rlpqe3TL2grutEAtJuWGFXQ3+Z6VLEkc3CSL1O9fqzu1ibdOxjluwMoca7IZvOR8xkQpFSqc=
X-Received: by 2002:a05:6870:6124:b0:229:eb17:3c19 with SMTP id
 s36-20020a056870612400b00229eb173c19mr3037666oae.35.1711746080466; Fri, 29
 Mar 2024 14:01:20 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327181700.77940-1-donald.hunter@gmail.com>
 <20240327181700.77940-3-donald.hunter@gmail.com> <20240328175729.15208f4a@kernel.org>
 <m234s9jh0k.fsf@gmail.com> <20240329084346.7a744d1e@kernel.org> <m2plvcj27b.fsf@gmail.com>
In-Reply-To: <m2plvcj27b.fsf@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 29 Mar 2024 21:01:09 +0000
Message-ID: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message support
 to ynl
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jacob Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 at 18:58, Donald Hunter <donald.hunter@gmail.com> wrote=
:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > Looking at the code again, are you sure we'll process all the responses
> > not just the first one?
> >
> > Shouldn't this:
> >
> > +                    del reqs_by_seq[nl_msg.nl_seq]
> >                      done =3D True
> >
> > be something like:
> >
> >               del reqs_by_seq[nl_msg.nl_seq]
> >               done =3D len(reqs_by_seq) =3D=3D 0
> >
>
> Hmm yes, that's a good catch. I need to check the DONE semantics for
> these nftables batch operations.

Well that's a problem:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi batch-begin '{"res-id": 10}' \
     --multi newtable '{"name": "test", "nfgen-family": 1}' \
     --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1=
}' \
     --multi batch-end '{"res-id": 10}'
Adding: 20778
Adding: 20779
Adding: 20780
Adding: 20781
Done: 20779
Done: 20780

There's no response for 'batch-begin' or 'batch-end'. We may need a
per op spec property to tell us if a request will be acknowledged.

> > Would be good to add an example of multi executing some get operations.
>
> I think this was a blind spot on my part because nftables doesn't
> support batch for get operations:
>
> https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_ap=
i.c#L9092
>
> I'll need to try using multi for gets without any batch messages and see =
how
> everything behaves.

Okay, so it can be made to work. Will incorporate into the next revision:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi gettable '{"name": "test", "nfgen-family": 1}' \
     --multi getchain '{"name": "chain", "table": "test", "nfgen-family": 1=
}'
[{'flags': set(),
  'handle': 10,
  'name': 'test',
  'nfgen-family': 1,
  'res-id': 200,
  'use': 1,
  'version': 0},
 {'handle': 1,
  'name': 'chain',
  'nfgen-family': 1,
  'res-id': 200,
  'table': 'test',
  'use': 0,
  'version': 0}]

X-sender: <netdev+bounces-83462-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAxkamlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKABgAAADMigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 16461
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:01:56 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 22:01:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 3E45A2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:01:56 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D-2.749 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, FREEMAIL_FORGED_FROMDOMAIN=3D0.001,
	FREEMAIL_FROM=3D0.001, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fLkgBUKcTaam for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:01:55 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83462-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com CEC86200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.com head=
er.b=3D"ho+OjBNb"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id CEC86200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19968B2427F
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65213791F;
	Fri, 29 Mar 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.com head=
er.b=3D"ho+OjBNb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160=
.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8954BCC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.160.45
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711746083; cv=3Dnone; b=3DUYQIxJbF0iMH3ZsdAKsR2WhSOeVLknz6XBqGSZdIqgl=
T4g0x+m1+iQAJgbpeDx4K/GP6IKrlLH6vUPW6kiO0E+mH+NyxvPsUhWQ2SDOSQlNMqnuxKt6p8A=
ImZ9ZLnPja0WglzYtRgaxLdCFXDb/++aF693jqKAp/aq43EgHoYI0=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711746083; c=3Drelaxed/simple;
	bh=3D1F336ycsZ/DeFmR3ip4gKdMLUxslUjLhibn8LWK2nsQ=3D;
	h=3DMIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DdqczGxbj+vc5Ex8+YOql2W5MFQyEyJDvs+VvKZxCZX/YbWFRD=
EeuR5cJnie4QDZZdUKkWF4hgxcR/Gn3m5DexMqEqSVK1Agq4Gr2DSCmglk4vO609sLx9zCF9KTb=
dIqb0rfTy0Qw8GBCP3KZDb0Qs3tYWRyoxcTbXU+z3FW17iA=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dgmail.com; spf=3Dpass smtp.mailfrom=3Dgm=
ail.com; dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.=
com header.b=3Dho+OjBNb; arc=3Dnone smtp.client-ip=3D209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dgmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dgmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2218a0f55e1=
so1281980fac.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:01:21 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dgmail.com; s=3D20230601; t=3D1711746080; x=3D1712350880; darn=
=3Dvger.kernel.org;
        h=3Dcc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dyf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=3D;
        b=3Dho+OjBNbnc3h384Al3xJv2eDnLkMbeh8PklqJBE+HkNQYmq+u3NA3WEUXY6ntS1=
oum
         BbDLftW/w1L3bnRUkzfKGFj6NOD91Ao5B7w8TbHmTTWygGGJMaI5oluhe6pXWRKlcw=
QE
         eal66+QsD61hUSz7DafBrrpV7r44uiME3jzCun3upnTJCiz+CzfvihUtTLxPyGFkXt=
zB
         2XpAMIxS+WY4coIS9d3qLyHgN1MUdr9S9ZepzVwPYxull2EILd3FX8/YV0IsDk1Olz=
h8
         4VhId5UWqiDJuZFox6GjK+EahBBbT5idHwBSumTfjPybPSAbMGWWeY+vfuxETCQO+J=
Pu
         21+A=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711746080; x=3D1712350880;
        h=3Dcc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-i=
d
         :reply-to;
        bh=3Dyf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=3D;
        b=3DmmXVo9v3DV+2/oxtG3OebzaU3GXy2AOrXBmmxq3it5M9egIWB6464eze8fJefK6=
BIP
         4pVPO0njIslLwBaciyjuicRAS0q5IO2vziESOt8OJMs7B+cupw3i+uzxiQ07vrsp/o=
k0
         KgXjIm7hYGtVo/vW2SYeLFBgtjr8wsYTLK30/iJ8DKvuIO07W4Vy215kpZfuDl1NGb=
Wb
         zuTwYiVaKaQ1nwPZCV5BHV9cEVqsFYmN0p892Jpnt2Hrtpd8GRxNXMIWRGoy3UPYuE=
5P
         crdfjhOsuna/vY51d/Vdscks5gpZjbvLR3v/IZZ2W4enAtVGjnilS3Up6N69FPesoi=
6d
         9hFQ=3D=3D
X-Gm-Message-State: AOJu0Yxy1Z1OQwgYOlgx6qQOrRpezxRv9fa1TVH11l25zaM22mXmBbS=
m
	AeQFFbIL2e6QZxC+BatQg1inIxrP8xE3ArNrMah7H0eVgXvXHFwIXqQ0/+4c6/0T85Bl/6xNwx=
N
	aa6cs7TpBTZPmb37LWn9+9ETHiq3WJK4j0cHKkg=3D=3D
X-Google-Smtp-Source: AGHT+IFNOkfSs1BURB1rlpqe3TL2grutEAtJuWGFXQ3+Z6VLEkc3C=
SL1O9fqzu1ibdOxjluwMoca7IZvOR8xkQpFSqc=3D
X-Received: by 2002:a05:6870:6124:b0:229:eb17:3c19 with SMTP id
 s36-20020a056870612400b00229eb173c19mr3037666oae.35.1711746080466; Fri, 29
 Mar 2024 14:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327181700.77940-1-donald.hunter@gmail.com>
 <20240327181700.77940-3-donald.hunter@gmail.com> <20240328175729.15208f4a@=
kernel.org>
 <m234s9jh0k.fsf@gmail.com> <20240329084346.7a744d1e@kernel.org> <m2plvcj27=
b.fsf@gmail.com>
In-Reply-To: <m2plvcj27b.fsf@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 29 Mar 2024 21:01:09 +0000
Message-ID: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=3DcjK37CPLJsKg@mail.gma=
il.com>
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message suppo=
rt
 to ynl
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,=20
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri =
Pirko <jiri@resnulli.us>,=20
	Jacob Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.co=
m>, donald.hunter@redhat.com
Content-Type: text/plain; charset=3D"UTF-8"
Return-Path: netdev+bounces-83462-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:01:56.2893
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 474836ca-b8ec-45fc-ee52-08dc=
503377c7
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.213|SMR=3D0.137(SMRDE=3D0.005|SMRC=3D0.131(=
SMRCL=3D0.102|X-SMRCR=3D0.131))|CAT=3D0.075(CATOS=3D0.001
 |CATRESL=3D0.026(CATRESLP2R=3D0.018)|CATORES=3D0.045(CATRS=3D0.045(CATRS-I=
ndex
 Routing Agent=3D0.043 )));2024-03-29T21:01:56.520Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10422
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.017|SMR=3D0.007(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.004))=
|SMS=3D0.011
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAV0FAAAPAAADH4sIAAAAAAAEAL1UbW8b=
RRDei31+ucRNhU
 DwCUZB6Frh2G4EahK1pUgFtVCoBJXyoVTR+m5sL77bde/26lhV/x0/
 jJld27HbUFEqYZ3vZmbn5Zm3/ev6Ew0/FqoLRyfwiyzgaHD0DUgLt4
 5Pvz3uwgOjZZbCw0pbLOBO6tjexLH3x7lUWS8x+T2YF8biaSe6Rw/8
 JKfVEH5WidLlVMEd4uT9KRYas54pxqytLJYr9Xvw2Jip0mOOaycIiU
 kR5Fgq3QVZICxMBWVFxBzjLINZYRIsS5BEs3qB5czoEkvvTBsLf1al
 dzVSBVFG43fu0Gv8PjFVluqYVZSDsTr5Gq74pZhRjBfl+XBxXuKLZz
 o7z8txjz7EPfeGV/6oWgh34WlR4UaMIUJpcqTQlHGmprgJ4EMjL0Nm
 qG9sGN6Eu3dhsArD34d5Dgssu1QBaWOqJYyNSSGRNpn04BFoxBSsgW
 SCydRV8sGTX3+AEnOprUpKGJmC/dBJiaBHVg4zLGHI9mBmWEirqCe9
 TtSJztA1ahmHukeq+Smf9PrWmKzsa7T9hc76SaZ6swX80YlcMoeH5Q
 wTmsGkylFb55J1M6WnfT4iy2Xk3kLm2YZhXmVWeTiHQxwrDfGrAxqU
 Q5UenMKtwev4LWWNc+eLNbXMkfQOaErtQRcO9GiM+nAkc5Ut2P5q82
 QifaCVuROwvXP8ng49eNTpW9A70fdpStNzStt6+/bxNnuyxR4Pttlb
 nYhWGteqa4YVO9HTCRZIbdJmvVXcaYg3KhnDpYDQxT04Q8jlws+M7E
 TUfRoBcL2jbhNrFzxLluegKkGNaAxoOiuqBcwVCWklZDLVZp5hOsbU
 TQ3P9hnvKZ+64SQXMqUIGvBC5jPqlBmBrxVeYFJZXiheLRij3R5CN/
 OPeN311C09zCUP45BGKSWkhu8IyBcwk4WlgImsNsc6NVjSdcFOymo2
 M6zjJp1rsx1sdalNrJ2Vp/0+ZupCFb2hMTy2fFn26Vtd9DPJs9AvTV
 Uk6DaA/iOV0cVKU33uI5/LmeolXz4+GZwcrbLgK3C1nrZYUEU5b1+H
 JR5KT1m65CwVa7GEmtOVKceUjOSMEWFi5uwPX2Kx8JfRECfyJfqlfT
 KViy5VE5SlW0FzE3JJ1zIFnZtiSk3nximdmILqQbkQzYDoptB4Yam/
 L1VJBflf9pxS/pDVJfMPWt1O9OxVPMrkuIxPqbT2xs0uR4gnVOoMY1
 5aL2DnxMbsKl6KNryxppf6dY95M5emNI+Xx9Qyri0JBq9Z8moj1HYk
 l8Z7hnIZvwHThx+8Hf4591eIHVGriXAnELv0MF2vM1sLhQhFs8FPqx
 GITx0digYph6JDREtE9UDsi5DkNX5fb4rWzspDyML6im7QkWfbYt8L
 6e287bfJj/iKhQwg9B4IT9sT/P6iLpp1sU+0U/78ncqf1V3oS4WgFQ
 gRiI4DwGgDseMReoJ0HBJGRf5rLs2WaNM7Evv1lUlTXAsD8bHT9M+O
 6NBpJxA3xTVK0FsRTiJCjt4IRbsWiAYjpChU6n2ns1cXLXpIZ080Gk
 Hbwbu2Pgo5dPtKhZAzJQDNbbek01r265+JetDYJtq+X4SZe7oE3Nyh
 viyjNNbdDFblJZr0PUFvelxlWp7dE5+Ezqq+bo2o+Sgkd73jvkfiI7
 IiiWfXtHdIBJm0GN6ur6qvNlkRjt9oGkXTjxMduflsurmKyNbTziFV
 MlzD4NKtWry2dYn7VjYjjkUmDY9hnax7M7Zd59B7aFEf//Uk/Nd2k5
 xw7hLrWtxyTna3dS7HoCZEjYet4eXNIPJO1pou0N67zR2M3Ted/A02
 dvMXaQwAAAEKzwI8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPS
 J1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4w
 LjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YX
 J0SW5kZXg9IjQ1IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAg
 IDxFbWFpbFN0cmluZz5kb25hbGQuaHVudGVyQGdtYWlsLmNvbTwvRW
 1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3Rh
 cnRJbmRleD0iOTkiPg0KICAgICAgPEVtYWlsU3RyaW5nPmt1YmFAa2
 VybmVsLm9yZzwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAg
 PC9FbWFpbHM+DQo8L0VtYWlsU2V0PgELgQM8P3htbCB2ZXJzaW9uPS
 IxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxVcmxTZXQ+DQogIDxW
 ZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8VXJscz4NCiAgIC
 A8VXJsIFN0YXJ0SW5kZXg9IjMwNiIgVHlwZT0iVXJsIj4NCiAgICAg
 IDxVcmxTdHJpbmc+bmxfbXNnLm5sPC9VcmxTdHJpbmc+DQogICAgPC
 9Vcmw+DQogICAgPFVybCBTdGFydEluZGV4PSIxMzY3IiBQb3NpdGlv
 bj0iT3RoZXIiIFR5cGU9IlVybCI+DQogICAgICA8VXJsU3RyaW5nPm
 h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9z
 b3VyY2UvbmV0L25ldGZpbHRlci9uZl90YWJsZXNfYXBpLmMjTDkwOT
 I8L1VybFN0cmluZz4NCiAgICA8L1VybD4NCiAgPC9VcmxzPg0KPC9V
 cmxTZXQ+AQydBzw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9In
 V0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAu
 MC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbnRhY3
 QgU3RhcnRJbmRleD0iMzAiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0K
 ICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIzMCIgUG9zaXRpb249Il
 NpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+RG9uYWxk
 IEh1bnRlcjwvUGVyc29uU3RyaW5nPg0KICAgICAgPC9QZXJzb24+DQ
 ogICAgICA8RW1haWxzPg0KICAgICAgICA8RW1haWwgU3RhcnRJbmRl
 eD0iNDUiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICAgID
 xFbWFpbFN0cmluZz5kb25hbGQuaHVudGVyQGdtYWlsLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYW
 lscz4NCiAgICAgIDxDb250YWN0U3RyaW5nPkRvbmFsZCBIdW50ZXIg
 Jmx0O2RvbmFsZC5odW50ZXJAZ21haWwuY29tPC9Db250YWN0U3RyaW
 5nPg0KICAgIDwvQ29udGFjdD4NCiAgICA8Q29udGFjdCBTdGFydElu
 ZGV4PSI4MyI+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjgzIj
 4NCiAgICAgICAgPFBlcnNvblN0cmluZz5KYWt1YiBLaWNpbnNraTwv
 UGVyc29uU3RyaW5nPg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW
 1haWxzPg0KICAgICAgICA8RW1haWwgU3RhcnRJbmRleD0iOTkiPg0K
 ICAgICAgICAgIDxFbWFpbFN0cmluZz5rdWJhQGtlcm5lbC5vcmc8L0
 VtYWlsU3RyaW5nPg0KICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9F
 bWFpbHM+DQogICAgICA8Q29udGFjdFN0cmluZz5KYWt1YiBLaWNpbn
 NraSAmbHQ7a3ViYUBrZXJuZWwub3JnPC9Db250YWN0U3RyaW5nPg0K
 ICAgIDwvQ29udGFjdD4NCiAgPC9Db250YWN0cz4NCjwvQ29udGFjdF
 NldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAsMjtSZXRyaWV2ZXJP
 cGVyYXRvciwxMSwyO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwxO1
 Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtl
 ckRpYWdub3N0aWNPcGVyYXRvciwxMCwzO1Bvc3RXb3JkQnJlYWtlck
 RpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclBy b2R1Y2VyLDIwLDE3
X-MS-Exchange-Forest-IndexAgent: 1 3252
X-MS-Exchange-Forest-EmailMessageHash: 130014E9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 at 18:58, Donald Hunter <donald.hunter@gmail.com> wrote=
:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > Looking at the code again, are you sure we'll process all the responses
> > not just the first one?
> >
> > Shouldn't this:
> >
> > +                    del reqs_by_seq[nl_msg.nl_seq]
> >                      done =3D True
> >
> > be something like:
> >
> >               del reqs_by_seq[nl_msg.nl_seq]
> >               done =3D len(reqs_by_seq) =3D=3D 0
> >
>
> Hmm yes, that's a good catch. I need to check the DONE semantics for
> these nftables batch operations.

Well that's a problem:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi batch-begin '{"res-id": 10}' \
     --multi newtable '{"name": "test", "nfgen-family": 1}' \
     --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1=
}' \
     --multi batch-end '{"res-id": 10}'
Adding: 20778
Adding: 20779
Adding: 20780
Adding: 20781
Done: 20779
Done: 20780

There's no response for 'batch-begin' or 'batch-end'. We may need a
per op spec property to tell us if a request will be acknowledged.

> > Would be good to add an example of multi executing some get operations.
>
> I think this was a blind spot on my part because nftables doesn't
> support batch for get operations:
>
> https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_ap=
i.c#L9092
>
> I'll need to try using multi for gets without any batch messages and see =
how
> everything behaves.

Okay, so it can be made to work. Will incorporate into the next revision:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi gettable '{"name": "test", "nfgen-family": 1}' \
     --multi getchain '{"name": "chain", "table": "test", "nfgen-family": 1=
}'
[{'flags': set(),
  'handle': 10,
  'name': 'test',
  'nfgen-family': 1,
  'res-id': 200,
  'use': 1,
  'version': 0},
 {'handle': 1,
  'name': 'chain',
  'nfgen-family': 1,
  'res-id': 200,
  'table': 'test',
  'use': 0,
  'version': 0}]


