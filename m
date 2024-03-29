Return-Path: <netdev+bounces-83622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5263893344
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3BE283DA1
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F4155758;
	Sun, 31 Mar 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC621552F8;
	Sun, 31 Mar 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902521; cv=fail; b=dZURQHO0Pw8zA/CKMsJ1z1xjBkvT6Eosd4NU4xdBwFIuIQc7rsrZTs4dW/DtIPyOyHVYO5egageYl7fnPDBCo7h59mxW760r3sww1MBXdvmELBl8cjDZ91NHcBNAeTlRsrhdaKFA/4XsRq+eCGFcIaViN6YAEGe7AzISbp22LxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902521; c=relaxed/simple;
	bh=PsFO1FMw5hnntPRnMKOaKjRwVASCvx6bLvn3qH2unjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbqwYthmzMs0JHrstYb9oPauO22D7RIzkkzWl+hesyziPFllWAoQW09MGTDiHQd1f6kbZtF010ZMXWEgvRdZwLAYSgpT05iXKQcNTPEaHDG3snn1SQKRa/g4hXvj3jatG8hbAuniiXyJFYNT6eShRXUssLrDuQ7rVltfCQZvrh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com; spf=fail smtp.mailfrom=paul-moore.com; dkim=fail (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO reason="signature verification failed"; arc=none smtp.client-ip=209.85.128.171; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=paul-moore.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6968E208DB;
	Sun, 31 Mar 2024 18:28:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y6CCrgg6n-rc; Sun, 31 Mar 2024 18:28:33 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C3FC1208CC;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C3FC1208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B6C1B800058;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:28 +0000
X-sender: <netdev+bounces-83463-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAi5Hp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBPAAAAi4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 16957
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83463-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com DDBC9200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747073; cv=none; b=IEFpzL+j6s4ROoZ9m+WmRtsDbZPWvRPaAOlVul1gnl+922OJOoBjb/HuCJ3iwPEDK1mF78WeWA2yuFgsFHBrCRseNrUIdkld7b6M1n5XUBTydlOahTDDwsLfuL7ySFyoJqk9bIJUeJ23RDhu4gE9DfMFDCA3hZRkhoyIXuxxLsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747073; c=relaxed/simple;
	bh=qXxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnpzyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BIvO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711747070; x=1712351870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=eh3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKau
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wYi9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7rb6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM9C
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747070; x=1712351870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=e7cVRi3/WlH6zhm2UHjhxjMNGMzCdBw0kiRNGZrD3F9Sy2FYI6dT0JzxAm6Q8e6/Y4
         N3+Uhs00X1PHInoevWtoON7kMo8YWAkAs4VfYnTFSThnVc4wethbrw0HVWBw0e/Ww8oP
         2EHTf37tsviNgSPAsg1JCId8d2geyyarVnyRYeZCsBQTTglBD/mlMiy2m2I4yB/sB6H1
         bYnryK66excoEb9oSigbbsNp5+vkXgQw7SzIZXX1nq1+dSgmDcEhlO/DuoioUPXVaBc0
         LXX7/KWDbTf9Q3O0NH+g7IOBDp/X/SNjkr3lY+cQM6yuiJnb9QzodPZNl8FR24dTed+C
         yheg==
X-Forwarded-Encrypted: i=1; AJvYcCUERtuOlGCNh+VMXzI33ZvBPsWzR2U2kdDvLuwNR7FnXsCvMA6GzCyTrDZsc8eU//coZbvHPe7F+R6hGzULlGg4z+TFtqPj
X-Gm-Message-State: AOJu0YzcaDsBlcNbpASJA/SjYACTyIQrziKr/0R/QADNO9vmVTVlTSYN
	fBH5u2AgnCCd3ByQxdGLKpOww36/eR1eh479SZIeXMFtTJ1As+WzAcJV4BnOch2p+YzXPFxySgk
	ocDfstnl3/uh1PiAfXlkT8RCWbKlGKStG4TJy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEg=
X-Received: by 2002:a05:690c:dd0:b0:614:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com

X-sender: <linux-security-module+bounces-2441-steffen.klassert=3Dcunet.com@=
vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAi5Hp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBQAAAAi4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 17034
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:18:02 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:18:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 83C28208A3
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:18:02 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D.051 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_MED=3D.3, SPF_HELO_NONE=3D001,
	SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rWfpHsXJeIC for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:17:58 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=139=
.178.88.99; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-security-module=
+bounces-2441-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7949C20897
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7949C20897
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F93284999
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173B13B2B8;
	Fri, 29 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com header.i=3Daul-moore.com =
header.b=3Dh3CqDiO"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.1=
28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05413792C
	for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 21:17:51 +00=
00 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.128.173
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711747073; cv=3Dne; b=3D0xxMrCvFvLIw7D410s0q3glAahyW/+EQm15kv5rP/KobURH=
q0XpJsVzIHhLpPhUSQAMe5xP95NbG3uA6gS4o20mk3XEe+Ax+xauQ5EXkCwaDrt/OEtSIcWdQQe=
Jbtc07hUGIFEY59MEey0aIPa2ekWA73VosMT7YiXtHX6MVAARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711747073; c=3Dlaxed/simple;
	bh=3DxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnp=
zyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BI=
vO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18ARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dul=
-moore.com; spf=3Dss smtp.mailfrom=3Dul-moore.com; dkim=3Dss (2048-bit key)=
 header.d=3Dul-moore.com header.i=3Daul-moore.com header.b=3D3CqDiO; arc=3D=
ne smtp.client-ip 9.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61149e5060=
2so17688927b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 14:17=
:51 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dul-moore.com; s=3Dogle; t=1711747070; x=1712351870; darn=3Der.k=
ernel.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=3D=0A=
        b=3D3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKa=
u
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+=
vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wY=
i9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7r=
b6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM=
9C
         rJYg=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711747070; x=1712351870;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=3D=0A=
        b=3D7gkbCbMPuVxTRRjx9JBP4VfAihO2hPCp2YXAEWnSLdbiDiZ4DTWU6L5BH7XcDUS=
B
         /wU+n3p5Aj/p+cQpX5QEXfTzDlmXh+oLF7kC/OHUSw2L+D1kVUoA7TYv/ofQqvilgD=
Qm
         /IM+U3tX7wvz2mCkRpMF/8DOnhzRs/6R4RdbwmdnhEE028sOQnGFPGRHLv+j1JSRPo=
4+
         5fyk3JjZaV8SJ6c2JZtr27PKwVLIuxBTlDE41KlhYvxXJ5+VX+kn0AXM3cfmbGJje8=
JI
         51LflsTAAX2hdaXgqzPSidnVT4nviYPyQaqDYdLBN8bdF680rKvzulj7IPIpcu1LU8=
OS
         19MA=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCW1iHuqoUPf8eeB4lTRfg9A+9rDZzuxqsat70M7Y8L=
7BtDcZdIgYuLy+9RGTx/ryj6FiQGpKCzMI05nIjQcjpdJhG5OIZH6isoZv548gSfOilUMblfw
X-Gm-Message-State: AOJu0YyCrk2d1/wzo8za3da7BrXdJ0hNdy0nji6DM1yDcbRysdDzVVc=
6
	xJv8eOMJ6jTZ7UBEroyfLUYyL47RnAK4xXX2WrY89pXneGxcq01Sz1w5BICx1w8zubHrziIdwk=
V
	jyuOikvzrduDLkAiUHxfxmX3A0TmD8gSjvxWy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0=
N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEgX-Received: by 2002:a05:690c:dd0:b0:6=
14:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org=
>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-6=
39a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=3DU96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=3DU96H2qB0xv+0d6ekEA@mail.gmai=
l.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail=
.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =3DTF-8?B?TWlja2HDq2wgU2FsYcO8bg=3D=3Dic@digikod.net>,=20
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,=20
	Eric Dumazet <edumazet@google.com>, =3DTF-8?Q?G=C3=BCnther_Noack?=3Dnoack@=
google.com>,=20
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,=20
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serg=
e@hallyn.com>,=20
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-security-module+bounces-2441-steffen.klassert=3Dcunet.co=
m@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:18:02.5569
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: da0fa88a-324e-4f61-834d-08dc=
5035b7b8
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D442|SMR=3D358(SMRDE=3D034|SMRC=3D323(SMRCL=3D=
101|X-SMRCR=3D323))|CAT=3D083(CATOS=3D012
 (CATSM=3D012(CATSM-Malware
 Agent=3D012))|CATRESL=3D039(CATRESLP2R=3D021)|CATORES=3D027
 (CATRS=3D027(CATRS-Index Routing
 Agent=3D026))|CATORT=3D002(CATRT=3D002(CATRT-Journal Agent=3D001
 )));2024-03-29T21:18:03.005Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10697
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D008|SMR=3D008(SMRPI=3D006(SMRPI-FrontendProxyAgent=3D006))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAdkFAAAPAAADH4sIAAAAAAAEAHVVy24b=
NxSlrLdk2S3STX
 cX6SJJYSu2EyCtEbhp0QdUxGiAdFcUBjVDeViNSJXkSNGuv9Dv6KI/
 0F3+pF/Sc8mRrCYIMBpwSN7Dc8+5l/rz+CdD3zt9QtfS0cWXJ3Rxdv
 GUZKCnl2fP/v3j71fX9EpWJV1b6xQ9X2L8gl+nC54YZ3ZxRWtng7oc
 Da7wEPB+Lqoa74s7vPPzy/NzAH59TZOVNHZF13peSF1y0HMdp8aLNH
 X+oqjkWunTpXTBKOffOYfiMU8eXzx7HOGfXJ6d0atrHKqzuXz7V0mv
 ZSnf/mP+F3JF36hMVl5RKBR5lVVOh82Nt9lchZupNjlJ/D64WFg79y
 Sd2sJlsixVTlM1Y204zqiwtm5OPshsfkI6kPakpN9QsKRNcDavMkXK
 Oesos/kOSpvMGq99UCbTyo9pYjCWOdkZyTzX5hbYa8oKlYEDwMDPKR
 Mi41kVqjtWL19f+xMqVXjgaabfRF5OlTKolALOitBj+KT2UZEZydJh
 abPFesgGaKS5eUR6sSzVAmdyyht6/d1Lbao3kcBLvErLGfMXsvaFrc
 qcjA07rQppbhVBfUd+KSHCVBVypaHDtAoM7uxqXxm6E2SzoxzREuQk
 0DoegsCpnJYbAOIJAQdAH3C26/c94aWlcjBsQb7KioRVC1Abybay4B
 Ayec5KwceF3EBWeAKMmWV83lUzZ2H8tgfG43E9uroLdcpXJTI1+4Yu
 VChsREyVdnpll34bPKHcmgcBWWgz51xADmCS7t/h3SeejqW21mVJnz
 v1e6Wd+hzbcADDJOTLS/AM9gb4KBiTBW0NPQQVd7OSpc5RH189GhNN
 ZrSxFa0liovFqpyvYm0FTmStQ7FVNVcr1iHVo1fgNuOlTe0L7GBGnC
 n7kdtlLAZWHWVCcgk+EuPJLj8Z7kIl3aISIVeuJFj9WPkQEaUzKj9J
 fFgP1BDbrgzlejbTGSRB/7DKzHIpEbYusBrcpmZyq7hrNpDFRULoMH
 ZaZrhjFhY6QBhI5OzivURhzGjwy7fOLpcMJkv1Rm3GcwQZtXphnczK
 eCVSXik+Si1wmaWa9vSwMnNj1wbGZXqpUS+PfmW8yYMFlSiziBgSbe
 u9nuoSNxDTy22kjgU55SZJtxTcwONRhiX6Fafypmld4wvsir6sC/iR
 ZOJSQvtpW3l0S3BabWGiWKMBq8UVwDcHWpcRfOx6Hm27whqFLlipEr
 SQDC41mEu72hoNdsUV0JWozJjQ+6UXV2u/AztklIqN8Fu1WI4Ge+Co
 FY8a1vEGi0jvoIDzD07Giwmp4hpDpqNBkGXUFO2O/xFuAYJ4rkAHn8
 Q7Z4KcTCzcqALfRmwBtJO+cgw8GiB9mSHQ8HVkVDzUP8bfgzVcpiYr
 FtKhA9aFRimXeq4grfYs9a2tC24KHAlmJTxS9UUYK+n0lDXf/y/lWS
 EORLMp2s2GOMQjWgei1RLtg0azK0RX9DBui26rIe6Jdhx3mvwefSiq
 J0RP9Dui2xWHnYb4THTTJ94x8BCBjYbo4xEHGLca7XhQH2dhW1scYd
 AUrV5DfBIDAYvPd2YijSHGeLCEEJAEGgOChmj2xQB7WuLwWHyMVcyk
 nZ24LR3REUct0YlQrQSC2C7zbKWdcfKjvhgOI+2amBg0Od8EONzxiQ
 kmJji3jZCuuIdtaSntT5+7bQmzJQYpkYTf3qa8S+RQUJpJCPuJdDhk
 2BAH7ZhIwmywNdgA5E4UpNNlvQ+afEqvzcp3UiKwdSTavdrN+sQO5q
 PX6ZSEmVJOmSbaMZd+CulF/JT4lkP67G4xh2kVz+HecXhSIknzVoTF
 4Egc7xEYcgk1xKdRopR+4gNMZITJvjhOqqbw5FeSOr23NHqdLaXdk6
 AiSKqZdqrt1taInXdbg+pEOMdaTGjYb0die/L2kyNpczJiNx5EQeKe
 3rY+eQDhBjHrVGbRtaQMC4XPAdoqkhnGQcJJNiXlD2JUFOoYo6PULP
 8Btex2bXoLAAABCskDPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGlu
 Zz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1Lj
 AuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBT
 dGFydEluZGV4PSI0NCIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogIC
 AgICA8RW1haWxTdHJpbmc+cGF1bEBwYXVsLW1vb3JlLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3Rhcn
 RJbmRleD0iMTMwIj4NCiAgICAgIDxFbWFpbFN0cmluZz5pdmFub3Yu
 bWlraGFpbDFAaHVhd2VpLXBhcnRuZXJzLmNvbTwvRW1haWxTdHJpbm
 c+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0i
 MTMzMyI+DQogICAgICA8RW1haWxTdHJpbmc+YWxleGV5LmtvZGFuZX
 ZAb3JhY2xlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4N
 CiAgPC9FbWFpbHM+DQo8L0VtYWlsU2V0PgEL0QE8P3htbCB2ZXJzaW
 9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxVcmxTZXQ+DQog
 IDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8VXJscz4NCi
 AgICA8VXJsIFN0YXJ0SW5kZXg9IjE5MTMiIFR5cGU9IlVybCI+DQog
 ICAgICA8VXJsU3RyaW5nPnBhdWwtbW9vcmUuY29tPC9VcmxTdHJpbm
 c+DQogICAgPC9Vcmw+DQogIDwvVXJscz4NCjwvVXJsU2V0PgEMwAc8
 P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCj
 xDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lv
 bj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZX
 g9IjMyIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJz
 b24gU3RhcnRJbmRleD0iMzIiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICA8UGVyc29uU3RyaW5nPlBhdWwgTW9vcmU8L1BlcnNv
 blN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz
 4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjQ0IiBQb3NpdGlv
 bj0iU2lnbmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+cG
 F1bEBwYXVsLW1vb3JlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgICAg
 IDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YW
 N0U3RyaW5nPlBhdWwgTW9vcmUgJmx0O3BhdWxAcGF1bC1tb29yZS5j
 b208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICAgID
 xDb250YWN0IFN0YXJ0SW5kZXg9IjExMSI+DQogICAgICA8UGVyc29u
 IFN0YXJ0SW5kZXg9IjExMSI+DQogICAgICAgIDxQZXJzb25TdHJpbm
 c+SXZhbm92IE1pa2hhaWw8L1BlcnNvblN0cmluZz4NCiAgICAgIDwv
 UGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjEzMCI+DQogICAgICAgICAgPEVtYWlsU3RyaW5n
 Pml2YW5vdi5taWtoYWlsMUBodWF3ZWktcGFydG5lcnMuY29tPC9FbW
 FpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1h
 aWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+SXZhbm92IE1pa2hhaW
 wNCiZndDsgJmx0O2l2YW5vdi5taWtoYWlsMUBodWF3ZWktcGFydG5l
 cnMuY29tPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCi
 AgPC9Db250YWN0cz4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmlldmVy
 T3BlcmF0b3IsMTAsMDtSZXRyaWV2ZXJPcGVyYXRvciwxMSwxO1Bvc3
 REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJzZXJPcGVy
 YXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYX
 RvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRv
 ciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDE1
X-MS-Exchange-Forest-IndexAgent: 1 3357
X-MS-Exchange-Forest-EmailMessageHash: 7C7AEC4C
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com

X-sender: <netdev+bounces-83463-steffen.klassert=3Dcunet.com@vger.kernel.or=
g>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAi5Hp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBRAAAAi4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16836
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:18:06 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:18:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id ED14E208A3
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:18:06 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D.751 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDDZ24243v52 for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:18:03 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.48.161; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83463-=
steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klassert@sec=
unet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C717420897
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C717420897
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA490B2280D
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A813BAEF;
	Fri, 29 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com header.i=3Daul-moore.com =
header.b=3Dh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.1=
28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE238FAD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.128.171
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711747073; cv=3Dne; b=3DFpzL+j6s4ROoZ9m+WmRtsDbZPWvRPaAOlVul1gnl+922OJO=
oBjb/HuCJ3iwPEDK1mF78WeWA2yuFgsFHBrCRseNrUIdkld7b6M1n5XUBTydlOahTDDwsLfuL7y=
SFyoJqk9bIJUeJ23RDhu4gE9DfMFDCA3hZRkhoyIXuxxLsQARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711747073; c=3Dlaxed/simple;
	bh=3DxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnp=
zyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BI=
vO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18ARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dul=
-moore.com; spf=3Dss smtp.mailfrom=3Dul-moore.com; dkim=3Dss (2048-bit key)=
 header.d=3Dul-moore.com header.i=3Daul-moore.com header.b=3D3CqDiO; arc=3D=
ne smtp.client-ip 9.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-611639a0e4=
eso21177477b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:17:51 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dul-moore.com; s=3Dogle; t=1711747070; x=1712351870; darn=3Der.k=
ernel.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=3D=0A=
        b=3D3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKa=
u
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+=
vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wY=
i9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7r=
b6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM=
9C
         rJYg=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711747070; x=1712351870;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=3D=0A=
        b=E7cVRi3/WlH6zhm2UHjhxjMNGMzCdBw0kiRNGZrD3F9Sy2FYI6dT0JzxAm6Q8e6/Y=
4
         N3+Uhs00X1PHInoevWtoON7kMo8YWAkAs4VfYnTFSThnVc4wethbrw0HVWBw0e/Ww8=
oP
         2EHTf37tsviNgSPAsg1JCId8d2geyyarVnyRYeZCsBQTTglBD/mlMiy2m2I4yB/sB6=
H1
         bYnryK66excoEb9oSigbbsNp5+vkXgQw7SzIZXX1nq1+dSgmDcEhlO/DuoioUPXVaB=
c0
         LXX7/KWDbTf9Q3O0NH+g7IOBDp/X/SNjkr3lY+cQM6yuiJnb9QzodPZNl8FR24dTed=
+C
         yheg=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCUERtuOlGCNh+VMXzI33ZvBPsWzR2U2kdDvLuwNR7F=
nXsCvMA6GzCyTrDZsc8eU//coZbvHPe7F+R6hGzULlGg4z+TFtqPj
X-Gm-Message-State: AOJu0YzcaDsBlcNbpASJA/SjYACTyIQrziKr/0R/QADNO9vmVTVlTSY=
N
	fBH5u2AgnCCd3ByQxdGLKpOww36/eR1eh479SZIeXMFtTJ1As+WzAcJV4BnOch2p+YzXPFxySg=
k
	ocDfstnl3/uh1PiAfXlkT8RCWbKlGKStG4TJy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0=
N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEgX-Received: by 2002:a05:690c:dd0:b0:6=
14:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-6=
39a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=3DU96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=3DU96H2qB0xv+0d6ekEA@mail.gmai=
l.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail=
.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =3DTF-8?B?TWlja2HDq2wgU2FsYcO8bg=3D=3Dic@digikod.net>,=20
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,=20
	Eric Dumazet <edumazet@google.com>, =3DTF-8?Q?G=C3=BCnther_Noack?=3Dnoack@=
google.com>,=20
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,=20
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serg=
e@hallyn.com>,=20
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83463-steffen.klassert=3Dcunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:18:06.9907
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: bb0b4948-f2f7-4c56-35b5-08dc=
5035ba5d
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D412|SMR=3D344(SMRDE=3D034|SMRC=3D309(SMRCL=3D=
101|X-SMRCR=3D310))|CAT=3D067(CATOS=3D015
 (CATSM=3D014(CATSM-Malware
 Agent=3D014))|CATRESL=3D020(CATRESLP2R=3D017)|CATORES=3D030
 (CATRS=3D030(CATRS-Index Routing Agent=3D029)));2024-03-29T21:18:07.405Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10555
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D005|SMR=3D005(SMRPI=3D003(SMRPI-FrontendProxyAgent=3D003))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAdkFAAAPAAADH4sIAAAAAAAEAHVVy24b=
NxSlrLdk2S3STX
 cX6SJJYSu2EyCtEbhp0QdUxGiAdFcUBjVDeViNSJXkSNGuv9Dv6KI/
 0F3+pF/Sc8mRrCYIMBpwSN7Dc8+5l/rz+CdD3zt9QtfS0cWXJ3Rxdv
 GUZKCnl2fP/v3j71fX9EpWJV1b6xQ9X2L8gl+nC54YZ3ZxRWtng7oc
 Da7wEPB+Lqoa74s7vPPzy/NzAH59TZOVNHZF13peSF1y0HMdp8aLNH
 X+oqjkWunTpXTBKOffOYfiMU8eXzx7HOGfXJ6d0atrHKqzuXz7V0mv
 ZSnf/mP+F3JF36hMVl5RKBR5lVVOh82Nt9lchZupNjlJ/D64WFg79y
 Sd2sJlsixVTlM1Y204zqiwtm5OPshsfkI6kPakpN9QsKRNcDavMkXK
 Oesos/kOSpvMGq99UCbTyo9pYjCWOdkZyTzX5hbYa8oKlYEDwMDPKR
 Mi41kVqjtWL19f+xMqVXjgaabfRF5OlTKolALOitBj+KT2UZEZydJh
 abPFesgGaKS5eUR6sSzVAmdyyht6/d1Lbao3kcBLvErLGfMXsvaFrc
 qcjA07rQppbhVBfUd+KSHCVBVypaHDtAoM7uxqXxm6E2SzoxzREuQk
 0DoegsCpnJYbAOIJAQdAH3C26/c94aWlcjBsQb7KioRVC1Abybay4B
 Ayec5KwceF3EBWeAKMmWV83lUzZ2H8tgfG43E9uroLdcpXJTI1+4Yu
 VChsREyVdnpll34bPKHcmgcBWWgz51xADmCS7t/h3SeejqW21mVJnz
 v1e6Wd+hzbcADDJOTLS/AM9gb4KBiTBW0NPQQVd7OSpc5RH189GhNN
 ZrSxFa0liovFqpyvYm0FTmStQ7FVNVcr1iHVo1fgNuOlTe0L7GBGnC
 n7kdtlLAZWHWVCcgk+EuPJLj8Z7kIl3aISIVeuJFj9WPkQEaUzKj9J
 fFgP1BDbrgzlejbTGSRB/7DKzHIpEbYusBrcpmZyq7hrNpDFRULoMH
 ZaZrhjFhY6QBhI5OzivURhzGjwy7fOLpcMJkv1Rm3GcwQZtXphnczK
 eCVSXik+Si1wmaWa9vSwMnNj1wbGZXqpUS+PfmW8yYMFlSiziBgSbe
 u9nuoSNxDTy22kjgU55SZJtxTcwONRhiX6Fafypmld4wvsir6sC/iR
 ZOJSQvtpW3l0S3BabWGiWKMBq8UVwDcHWpcRfOx6Hm27whqFLlipEr
 SQDC41mEu72hoNdsUV0JWozJjQ+6UXV2u/AztklIqN8Fu1WI4Ge+Co
 FY8a1vEGi0jvoIDzD07Giwmp4hpDpqNBkGXUFO2O/xFuAYJ4rkAHn8
 Q7Z4KcTCzcqALfRmwBtJO+cgw8GiB9mSHQ8HVkVDzUP8bfgzVcpiYr
 FtKhA9aFRimXeq4grfYs9a2tC24KHAlmJTxS9UUYK+n0lDXf/y/lWS
 EORLMp2s2GOMQjWgei1RLtg0azK0RX9DBui26rIe6Jdhx3mvwefSiq
 J0RP9Dui2xWHnYb4THTTJ94x8BCBjYbo4xEHGLca7XhQH2dhW1scYd
 AUrV5DfBIDAYvPd2YijSHGeLCEEJAEGgOChmj2xQB7WuLwWHyMVcyk
 nZ24LR3REUct0YlQrQSC2C7zbKWdcfKjvhgOI+2amBg0Od8EONzxiQ
 kmJji3jZCuuIdtaSntT5+7bQmzJQYpkYTf3qa8S+RQUJpJCPuJdDhk
 2BAH7ZhIwmywNdgA5E4UpNNlvQ+afEqvzcp3UiKwdSTavdrN+sQO5q
 PX6ZSEmVJOmSbaMZd+CulF/JT4lkP67G4xh2kVz+HecXhSIknzVoTF
 4Egc7xEYcgk1xKdRopR+4gNMZITJvjhOqqbw5FeSOr23NHqdLaXdk6
 AiSKqZdqrt1taInXdbg+pEOMdaTGjYb0die/L2kyNpczJiNx5EQeKe
 3rY+eQDhBjHrVGbRtaQMC4XPAdoqkhnGQcJJNiXlD2JUFOoYo6PULP
 8Btex2bXoLAAABCskDPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGlu
 Zz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1Lj
 AuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBT
 dGFydEluZGV4PSI0NCIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogIC
 AgICA8RW1haWxTdHJpbmc+cGF1bEBwYXVsLW1vb3JlLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3Rhcn
 RJbmRleD0iMTMwIj4NCiAgICAgIDxFbWFpbFN0cmluZz5pdmFub3Yu
 bWlraGFpbDFAaHVhd2VpLXBhcnRuZXJzLmNvbTwvRW1haWxTdHJpbm
 c+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0i
 MTMzMyI+DQogICAgICA8RW1haWxTdHJpbmc+YWxleGV5LmtvZGFuZX
 ZAb3JhY2xlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4N
 CiAgPC9FbWFpbHM+DQo8L0VtYWlsU2V0PgEL0QE8P3htbCB2ZXJzaW
 9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxVcmxTZXQ+DQog
 IDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8VXJscz4NCi
 AgICA8VXJsIFN0YXJ0SW5kZXg9IjE5MTMiIFR5cGU9IlVybCI+DQog
 ICAgICA8VXJsU3RyaW5nPnBhdWwtbW9vcmUuY29tPC9VcmxTdHJpbm
 c+DQogICAgPC9Vcmw+DQogIDwvVXJscz4NCjwvVXJsU2V0PgEMwAc8
 P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCj
 xDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lv
 bj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZX
 g9IjMyIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJz
 b24gU3RhcnRJbmRleD0iMzIiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICA8UGVyc29uU3RyaW5nPlBhdWwgTW9vcmU8L1BlcnNv
 blN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz
 4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjQ0IiBQb3NpdGlv
 bj0iU2lnbmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+cG
 F1bEBwYXVsLW1vb3JlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgICAg
 IDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YW
 N0U3RyaW5nPlBhdWwgTW9vcmUgJmx0O3BhdWxAcGF1bC1tb29yZS5j
 b208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICAgID
 xDb250YWN0IFN0YXJ0SW5kZXg9IjExMSI+DQogICAgICA8UGVyc29u
 IFN0YXJ0SW5kZXg9IjExMSI+DQogICAgICAgIDxQZXJzb25TdHJpbm
 c+SXZhbm92IE1pa2hhaWw8L1BlcnNvblN0cmluZz4NCiAgICAgIDwv
 UGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjEzMCI+DQogICAgICAgICAgPEVtYWlsU3RyaW5n
 Pml2YW5vdi5taWtoYWlsMUBodWF3ZWktcGFydG5lcnMuY29tPC9FbW
 FpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1h
 aWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+SXZhbm92IE1pa2hhaW
 wNCiZndDsgJmx0O2l2YW5vdi5taWtoYWlsMUBodWF3ZWktcGFydG5l
 cnMuY29tPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCi
 AgPC9Db250YWN0cz4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmlldmVy
 T3BlcmF0b3IsMTAsMTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwxO1Bvc3
 REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJzZXJPcGVy
 YXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYX
 RvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRv
 ciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDE4
X-MS-Exchange-Forest-IndexAgent: 1 3357
X-MS-Exchange-Forest-EmailMessageHash: 7C7AEC4C
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com


