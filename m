Return-Path: <netdev+bounces-221122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70210B4A5FA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4FD1C22CAD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C721274B5D;
	Tue,  9 Sep 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PK9TY+4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD095262FC5
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407911; cv=none; b=JwJTEOAxbbZo4h0TcTDs+Ax8itqvD29JBIjuflgLnbMIFHGgQ8mgzaQeR6zigWScO3NzM2n3RvrodpMBY1lSWQWahJbZ+zh14sKh8+frAigKpwUXjeTianJbGaY/Qyfwr3THEqtfvO1PMbjPZXfjQ0FthfMDmGaip62ov+KUKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407911; c=relaxed/simple;
	bh=BvhoIaB48iqJp7gZQQU8b3NGtD08zn2rcVNqP+Vgvu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE9MhurUIB7I/5ZZwK1kVpYS3xfHeq8ON+vKxsBIrxsltAbUIRSg5AMMMcqgx9gUZBzBX8WZHL0oi1QvyRxcdcN5HRFK4BHd72H+RR8OUFD13VAjDGwhZ605kQn1XcQGT/H7kVzQ7ptEmS9JZBk8lCnJRCIPQ+kkVl+acBJz/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PK9TY+4l; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-40032bf3feeso12378995ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 01:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407908; x=1758012708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsnhjPIQ9wDO47dUnd0EHwk0YmyzgPjAQKwk1GV0RaY=;
        b=m5c/cY9FXcL7jbN07u4ES7wjuGxJAJZ2PxQIFgtEOO8W04ECKgyQGgqSBdzvFoISt2
         Tl3mBpQGzJNzUkpqNCQv3m8DlUWauzqXW5gQwJ0ylo/R4FVwW+MWjVUlCCFrLQYcT91o
         guxZXKsbgnPTHdHOW+G7orX6XPEGdZZu7AE7X2/Ifi2aG9bv18sGWpqqgYW0xBPhk4xc
         TbuBSWrIburJMrFMmLXPibPijFQD+Clnfjh0wPrDKM0yFAcE6mElhJlNK/9IhGz2PL82
         NRTWfV9N4ln7+IgjmDmlUVHYYBcqUkxSL5cerVOYK+KVRO+imv2Y+KpvUKQ0jmO4qHE6
         1zQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9SOZpFzQ2Y2BfgZwhSbBQvWso1RXSYzTupSMz94T/BBMQ4lCgE7gUbzce3O+6ZabzEZfsZJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPGtMqV3lqyWYHIWytvhadjiBJa6GxYk7YD1SFJpvHZ/x5LbH
	ImpgI1ztcoyPzxcjIsebBS2NZAiNDZ591gUZiB5+gX4NFPejl5VuzIQGuldvtHyIOYs126bQKAq
	ItN+ulNc+pETAKmf2EgxZJg5KRKqkQLIcGJvag+yateiE1HYCQyq8ugc4xjxeasF7fZ6+Z4Q7c0
	AjtdQf8TEFoJkNDL0lrgP8SPS4+dc0nuIarWBHX7taNGyfA6W7zWxbT+Sp29FichgDYcxdgbDxY
	SlRhL4XatCYhaUtajh4+lVZ
X-Gm-Gg: ASbGncvUOD0FqRYiLb9dqtSAxb2m8FUtCaddQ9GwbPBveAnT+hPg1owf1su9owh4Cph
	yrqm6qEr50hZQoNo9EpC7B3V0Di32s0n10TH0EaJpLcADB1MnKXsV+JzYrWzFx89IeueIKtKcvn
	VRepWJjK7QfYGFfu3MQeKxPgsJHAOOMcB5eqydEG+RaFVG3GJ32mN8abV6fJeATR5kUb4fQBZDd
	Z9u3g102LmxTQPwZ+tlSDPCoKMpl/KiJEaO5MPiJ71IR6pkh1+1UzqGVKUc9gjM43aAHJdO1oQ9
	CgPRrF5CECchVINDb4crzhpUyL9iDgB+dcwIlA3mNJe4WAzDxP1t9z4EhHC6PWuR7wZYhGgRrul
	Al4D7NR0Vj0WNO9TgW1GzCKmj/gmpKeXdnXYE71B8J2j1KfFh76dVmgv4Df3xDKmMjzPSbKw+NK
	mnrZ3s50eGoO2M
X-Google-Smtp-Source: AGHT+IEc4u3BGLNWRJ/Qsq3ZyBOQIU07Z6Jz739WlOxrlD59uyz7RiCmQhaxH5XquhCzmcQv2n9uSal7Eawx
X-Received: by 2002:a05:6e02:2281:b0:40a:c2dc:283e with SMTP id e9e14a558f8ab-40ac2eb7d7bmr60541255ab.15.1757407907589;
        Tue, 09 Sep 2025 01:51:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-402440d8646sm6105255ab.10.2025.09.09.01.51.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:51:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32bc286bc1eso7388967a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757407906; x=1758012706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AsnhjPIQ9wDO47dUnd0EHwk0YmyzgPjAQKwk1GV0RaY=;
        b=PK9TY+4lUxpYQi0nwp0XyGERaFD5IzyoswjZrZK2HxLZXah6HwPcIm1X6V3PZA5Zkl
         UD/qt3c6HwJtQnBrDrX4smx8mp4ZsaUJizoeCcy+/trYroeq0qHMB8/ApkpuYWVmol63
         UhV6SbVrmLQtfiQy1hwh3CovtazXAEr3RRc9c=
X-Forwarded-Encrypted: i=1; AJvYcCXnhdcYSWtMamJik+aZzGq4w8K7Q/0pjEEfzkLZz1+bFbQtllb75I/pZGE9selTtXH0GGd7rRU=@vger.kernel.org
X-Received: by 2002:a17:90b:5783:b0:32b:c610:6ef6 with SMTP id 98e67ed59e1d1-32d43fb706amr14182042a91.21.1757407905653;
        Tue, 09 Sep 2025 01:51:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5783:b0:32b:c610:6ef6 with SMTP id
 98e67ed59e1d1-32d43fb706amr14182010a91.21.1757407905182; Tue, 09 Sep 2025
 01:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
 <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
 <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com> <20250909081709.GB341237@unreal>
In-Reply-To: <20250909081709.GB341237@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 9 Sep 2025 14:21:32 +0530
X-Gm-Features: Ac12FXyEHapK-NQ_OIZKekmMaT42Uj_r8sElaod3zCbOkuxOQE2l5OQwx4HCYxM
Message-ID: <CAH-L+nNut2mMh5vG=dBtJGDud4mD1W-VJCsQ87oa_74QhrW7fA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f86c4f063e5a6938"

--000000000000f86c4f063e5a6938
Content-Type: multipart/alternative; boundary="000000000000ea129f063e5a69d2"

--000000000000ea129f063e5a69d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:

> On Mon, Sep 08, 2025 at 09:24:39PM +0530, Kalesh Anakkur Purayil wrote:
> > Hi Leon,
> >
> > It looks like you have merged V1 of the series. I had already pushed a =
V2
> > of the series which fixes an issue in Patch#10.
> >
> > I can push the changes made in Patch#10 as a follow up patch. Please le=
t
> me
> > know.
>
> No need, I fixed it locally.
>

Thank you Leon.

>
> Thanks
>
> >
> > On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> >
> > >
> > > On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> > > > The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> > > > QPs, which receive plain Ethernet packets. This patch adds
> > > ib_create_flow()
> > > > and ib_destroy_flow() support in the bnxt_re driver. For now, only
> the
> > > > sniffer rule is supported to receive all port traffic. This is to
> support
> > > > tcpdump over the RDMA devices to capture the packets.
> > > >
> > > > Patch#1 is Ethernet driver change to reserve more stats context to
> RDMA
> > > device.
> > > > Patch#2, #3 and #4 are code refactoring changes in preparation for
> > > subsequent patches.
> > > > Patch#5 adds support for unique GID.
> > > > Patch#6 adds support for mirror vnic.
> > > > Patch#7 adds support for flow create/destroy.
> > > > Patch#8 enables the feature by initializing FW with roce_mirror
> support.
> > > > Patch#9 is to improve the timeout value for the commands by using
> > > firmware provided message timeout value.
> > > > Patch#10 is another related cleanup patch to remove unnecessary
> checks.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [01/10] bnxt_en: Enhance stats context reservation logic
> > >         https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
> > > [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
> > >         https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
> > > [03/10] RDMA/bnxt_re: Refactor hw context memory allocation
> > >         https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
> > > [04/10] RDMA/bnxt_re: Refactor stats context memory allocation
> > >         https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
> > > [05/10] RDMA/bnxt_re: Add support for unique GID
> > >         https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
> > > [06/10] RDMA/bnxt_re: Add support for mirror vnic
> > >         https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
> > > [07/10] RDMA/bnxt_re: Add support for flow create/destroy
> > >         https://git.kernel.org/rdma/rdma/c/525b4368864c7e
> > > [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
> > >         https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
> > > [09/10] RDMA/bnxt_re: Use firmware provided message timeout value
> > >         https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
> > > [10/10] RDMA/bnxt_re: Remove unnecessary condition checks
> > >         https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50
> > >
> > > Best regards,
> > > --
> > > Leon Romanovsky <leon@kernel.org>
> > >
> > >
> > >
> >
> > --
> > Regards,
> > Kalesh AP
>
>
>

--=20
Regards,
Kalesh AP

--000000000000ea129f063e5a69d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 9, =
2025 at 1:47=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.o=
rg">leon@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Mon, Sep 08, 2025 at 09:24:39PM +0530, Kalesh Anakkur=
 Purayil wrote:<br>
&gt; Hi Leon,<br>
&gt; <br>
&gt; It looks like you have merged V1 of the series. I had already pushed a=
 V2<br>
&gt; of the series which fixes an issue in Patch#10.<br>
&gt; <br>
&gt; I can push the changes made in Patch#10 as a follow up patch. Please l=
et me<br>
&gt; know.<br>
<br>
No need, I fixed it locally.<br></blockquote><div><br></div><div>Thank you =
Leon.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
<br>
&gt; <br>
&gt; On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"=
mailto:leon@kernel.org" target=3D"_blank">leon@kernel.org</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:<br>
&gt; &gt; &gt; The RDMA stack allows for applications to create IB_QPT_RAW_=
PACKET<br>
&gt; &gt; &gt; QPs, which receive plain Ethernet packets. This patch adds<b=
r>
&gt; &gt; ib_create_flow()<br>
&gt; &gt; &gt; and ib_destroy_flow() support in the bnxt_re driver. For now=
, only the<br>
&gt; &gt; &gt; sniffer rule is supported to receive all port traffic. This =
is to support<br>
&gt; &gt; &gt; tcpdump over the RDMA devices to capture the packets.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Patch#1 is Ethernet driver change to reserve more stats cont=
ext to RDMA<br>
&gt; &gt; device.<br>
&gt; &gt; &gt; Patch#2, #3 and #4 are code refactoring changes in preparati=
on for<br>
&gt; &gt; subsequent patches.<br>
&gt; &gt; &gt; Patch#5 adds support for unique GID.<br>
&gt; &gt; &gt; Patch#6 adds support for mirror vnic.<br>
&gt; &gt; &gt; Patch#7 adds support for flow create/destroy.<br>
&gt; &gt; &gt; Patch#8 enables the feature by initializing FW with roce_mir=
ror support.<br>
&gt; &gt; &gt; Patch#9 is to improve the timeout value for the commands by =
using<br>
&gt; &gt; firmware provided message timeout value.<br>
&gt; &gt; &gt; Patch#10 is another related cleanup patch to remove unnecess=
ary checks.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [...]<br>
&gt; &gt;<br>
&gt; &gt; Applied, thanks!<br>
&gt; &gt;<br>
&gt; &gt; [01/10] bnxt_en: Enhance stats context reservation logic<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/47bd8cafcbf007" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/47bd8cafcbf007</a><br>
&gt; &gt; [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/a99b2425cc6091" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/a99b2425cc6091</a><br>
&gt; &gt; [03/10] RDMA/bnxt_re: Refactor hw context memory allocation<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/877d90abaa9eae" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/877d90abaa9eae</a><br>
&gt; &gt; [04/10] RDMA/bnxt_re: Refactor stats context memory allocation<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/bebe1a1bb1cff3" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3</a><br>
&gt; &gt; [05/10] RDMA/bnxt_re: Add support for unique GID<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/b8f4e7f1a275ba" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba</a><br>
&gt; &gt; [06/10] RDMA/bnxt_re: Add support for mirror vnic<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/c23c893e3a02a5" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/c23c893e3a02a5</a><br>
&gt; &gt; [07/10] RDMA/bnxt_re: Add support for flow create/destroy<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/525b4368864c7e" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/525b4368864c7e</a><br>
&gt; &gt; [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/d1dde88622b99c" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/d1dde88622b99c</a><br>
&gt; &gt; [09/10] RDMA/bnxt_re: Use firmware provided message timeout value=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/d7fc2e1a321cf7" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7</a><br>
&gt; &gt; [10/10] RDMA/bnxt_re: Remove unnecessary condition checks<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/dfc78ee86d8f50" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/dfc78ee86d8f50</a><br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; --<br>
&gt; &gt; Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org" target=3D"=
_blank">leon@kernel.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; -- <br>
&gt; Regards,<br>
&gt; Kalesh AP<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div></div>

--000000000000ea129f063e5a69d2--

--000000000000f86c4f063e5a6938
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIJ0vzxenbEiWPU0krWqdYZNCm0WceULp4zaWfK7GEUVGMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwOTA4NTE0NlowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAe4vg09L7L1VCr9gEA99E9WBk1e
SW59YTRknRhJ+XC9gk3YKm5P84A3SBwLQp80AKal2APd0KSR4Wra7wmQ9LA/p0OL77fPpAMz3of+
REErqfqsdHq92wvvk02GMS1sg7J5SN51QLXTKorUIHoY85R8go4NryhBl28vCHZPtWgUPyAaoTXY
JK3kuR4y4HRM6t6NXvIsG6XZD1zP00cXQDp6bNg7zqvXcLQe4y4XhFF41gs3ATejkNIw3q+JC8Hw
U5UxIi3ZhR1fz/eO83WxPkXi1n5D7rXV3+FvSlBJwzFa2sCwiOcBk/mpB/cKUwxm+SfHuNIUow4m
HsIG9eeXjSI=
--000000000000f86c4f063e5a6938--

