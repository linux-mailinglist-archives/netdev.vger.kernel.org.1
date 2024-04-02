Return-Path: <netdev+bounces-84063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FEF895673
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565EE1F235A7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC0786128;
	Tue,  2 Apr 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjcJXQ6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551180BEE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067477; cv=none; b=CqNaTTr+59bKaFj4MkyckLtYXjANk6t1LX1EV3yOQgvfnVvbmZz8Pc3XPZyA+eMuSDgA5Ne+ALI6jNn7Ffaj/wwO2v6uTQGZCWmpuxlVV7PyclY3mzDHN9VgCogy06LpnqiZPlQWburevwexFVyDCIajTYeGtvxb8Z/wskF4zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067477; c=relaxed/simple;
	bh=4wDYGXF3qBb5heugmB/VLY8Ah3sg4Fw7K8zwbaZO4lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbG8mFHzVLfZeT/7kRaU+ab8I+Ed/jtOrAAASZZv4+Bst5Qco6Nwz/y6yA88KmEFIf4sowM5Egf7uzTOyluAa6yRqpUuu/5shp0QYvHuJf9P58Cr+9h17sRVNJMLPKQKQERqIPWJSk5PFaKQYzfMcMYoRAQGN3drkPcV2OBPxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjcJXQ6U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so950815166b.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712067473; x=1712672273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU/JuDrAaOTA53CCd3uRtNygkcK53/BSVb1OWXmyIoY=;
        b=kjcJXQ6ULGxlI/HWfUh3Jvi0Bffr5D7N9Cw+iKyKM1plF3DSK7BfV6V98hEXipcYrg
         SmLYIJYjg6bUPvU050QavJARoWD0zWOUpingxpeABNTQPa2EcOyb4h6THNUMSVbXH9e/
         ov2shoh7odP+bVH5qfpIANLou21MEFdOvsvHjD8HXV6KVtI7aky44wPjPnChpxtNrvnb
         cj9phDkH6FB+mwJC/0ekLCec/xCgiuSh9sKkwC1/zERzetM3JxRj9nI3SrlV0ET+sF+4
         8VZL2vCW3/Qe27MYcCFkWfsRnB6DMP+CwuAhg5AJ/Y/nOnf5/0xLKLFCGn/syaGZ7yq7
         oACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067473; x=1712672273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU/JuDrAaOTA53CCd3uRtNygkcK53/BSVb1OWXmyIoY=;
        b=rNDQUnRM2fNIKzqUQdlFtphNztwA+8QRmd8Jvh6Q5JiXlh7s18ZBjcE3y5CTtWJ8v4
         R0zvNISIn3jkZClpPKr41nRybHU9pROL5y4NC46pQzHs3dndtQU9Wi6pSnnUL/u1GBhC
         zSQuL4gt8qnTP0oBPPymwGiwZii3rUjjuwKw+tixmkUH470D9fDeDt/fB5r3B0m1m3l/
         6IQPYcxfMRovdu+PxMFEdNQSZoZju54iHDQIZWffMCJJskWMCNzDAgonLbl5qr4FSBFW
         kPcvcKKx9MuvQ5KTO+ef7KvLiqMSO6Gq29+m3ovEnyiW6P1FBtchF8oV8lpzFAf6+wnr
         UejQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfhmDlWSJWOH4LqxAWsQv3No4dPt8LNob0Gr86WJ6iBuPCmp8Bogu9yQqM8aIdTiOE9HiadawsqaJqciLaGtsLDoIZSLWz
X-Gm-Message-State: AOJu0Yz/z1TCc85xLOEhE53Qz9ox0vutRPSXpLWIZQMDXuGFfv++vFN0
	4P6/m9EhfnHFyXc3hdS1m44g8pGJDcQQYkt157noVHsN0EvbHKbGEjKAI6IQFFEZaJE5BxVa2Sk
	Qqhzzzeb/nnPeqliaWC/WyMc+aOI=
X-Google-Smtp-Source: AGHT+IEqIwgbvgYB6ZjIL2o6tcfeklNs53lK9jr+R5G062sAFur+wGlDxjtySz6h8qrN/zN5gX4/oXUa70wUJnhriq4=
X-Received: by 2002:a17:906:fe06:b0:a4e:e4:7b66 with SMTP id
 wy6-20020a170906fe0600b00a4e00e47b66mr15930802ejb.19.1712067473391; Tue, 02
 Apr 2024 07:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326133412.47cf6d99@kernel.org> <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
 <20240326165554.541551c3@kernel.org> <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>
 <20240402132137.GJ11187@unreal> <CANn89i+=MOmFzLzdwTX4k8Bc1mrXXzpOzgpAe8KSnjAmuX3kLA@mail.gmail.com>
In-Reply-To: <CANn89i+=MOmFzLzdwTX4k8Bc1mrXXzpOzgpAe8KSnjAmuX3kLA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Apr 2024 22:17:16 +0800
Message-ID: <CAL+tcoBKjPeHKv7OrxUVAppM+as+DANCeOYnfb1c2-2mqRqHCQ@mail.gmail.com>
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
To: Eric Dumazet <edumazet@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Apr 2, 2024 at 3:21=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 02:05:17PM +0100, Eric Dumazet wrote:
> > > On Wed, Mar 27, 2024 at 12:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > >
> > > > On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> > > > > On Tue, Mar 26, 2024 at 9:34=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > I got a report from a user surprised/displeased that ICMP_TIME_=
EXCEEDED
> > > > > > breaks connect(), while TCP RFCs say it shouldn't. Even pointin=
g a
> > > > > > finger at Linux, RFC5461:
> > > > > >
> > > > > >    A number of TCP implementations have modified their reaction=
 to all
> > > > > >    ICMP soft errors and treat them as hard errors when they are=
 received
> > > > > >    for connections in the SYN-SENT or SYN-RECEIVED states.  For=
 example,
> > > > > >    this workaround has been implemented in the Linux kernel sin=
ce
> > > > > >    version 2.0.0 (released in 1996) [Linux].  However, it shoul=
d be
> > > > > >    noted that this change violates section 4.2.3.9 of [RFC1122]=
, which
> > > > > >    states that these ICMP error messages indicate soft error co=
nditions
> > > > > >    and that, therefore, TCP MUST NOT abort the corresponding co=
nnection.
> > > > > >
> > > > > > Is there any reason we continue with this behavior or is it jus=
t that
> > > > > > nobody ever sent a patch?
> > > > >
> > > > > Back in November of 2023 Eric did merge a patch to bring the
> > > > > processing in line with section 4.2.3.9 of [RFC1122]:
> > > > >
> > > > > 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some IC=
MP
> > > > >
> > > > > However, the fixed behavior did not meet some expectations of Vag=
rant
> > > > > (see the netdev thread "Bug report connect to VM with Vagrant"), =
so
> > > > > for now it got reverted:
> > > > >
> > > > > b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving =
some ICMP
> > > > >
> > > > > I think the hope was to root-cause the Vagrant issue, fix Vagrant=
's
> > > > > assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8=
,
> > > > > 2024: "We will submit the patch again for 6.9, once we get to the=
 root
> > > > > cause." But I don't think anyone has had time to do that yet.
> > > >
> > > > Ah.
> > > >
> > > > Thank you!!
> > >
> > > For the record, Leon Romanovsky brought this issue directly to Linus
> > > Torvalds, stating that I broke things.
> >
> > Just to make it clear, Linus was involved after we didn't progress for
> > more than one month after initial starting "Bug report connect to VM wi=
th Vagrant",
> > while approaching to merge window.
> > https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@M=
N2PR12MB4486.namprd12.prod.outlook.com/
> >
> > Despite long standing netdev patch flow: apply fast -> revert fast, thi=
s
> > patch was treated differently.
>
> I was waiting input from you. I think you only waited for "revert first"
>
> >
> > >
> > > It tooks weeks before Shachar did some debugging, but with no
> > > conclusion I recall.
> >
> > Shachar didn't do debugging, she didn't write the bisected patch.
> > She is verification engineer who was ready to run ANY tests and try
> > ANY debug patch which you wanted.
> >
> > >
> > > This kind of stuff makes me not very eager to work on this point.
> > >
> >
> > OK, so it is not important at the end.
>
> I certainly do not want to waste time arguing with you on a valid
> patch, which happens to break some buggy user space.
>
> Apparently some people think RFC are not important.

RFC is important.

Honestly, I read those threads over and over again. Since she provided
some tcpdump logs which do not include ICMP, my question is still the
same as Eric: why does this breakage have a relationship with this
patch??? I get lost. It doesn't make sense really...

If someone is able to more easily reproduce this issue, I'm happy to help d=
ebug.

Thanks,
Jason

