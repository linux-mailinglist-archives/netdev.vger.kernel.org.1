Return-Path: <netdev+bounces-210185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9740B12449
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF73583205
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6782472AB;
	Fri, 25 Jul 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMpZHY1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0B155C97
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469471; cv=none; b=rXD49VB4nkBkTkrEpvkvCM4YwkIke6u+Oc7+dbsXjCJDUAC+WutJuP5gmfdWzrz/cBEHqUexfWS6hztSGm1CCLlejrYPKOhQ8mo62hzS/IWJASNsoXtVZR8Io/iqHNa+A2td7dc1Ct5bkDbwiKpzjqQ18URzMBDqfa3qke92rrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469471; c=relaxed/simple;
	bh=TQHVoOjY1yX/FYnoBKnhFCXugdVzoqtPM2+jcNrGPTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZEkTgQtEOWUmWrU02zjLCZU65F1D8IZOCxRMJnK56R8GTbJ8ED52mi6e4y4pNR+asiSYoG9wr6LCoczyEv9amma4QcsdNIjLdi2w3fXklZQMAFkDpGl9lKiHfCfcrRk7CmChbj9qmyjqZ2auv8Qf8eJ13YlDhE6NG0lowdPjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMpZHY1k; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1955030a91.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469469; x=1754074269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ6hAPUzBtzPSujGKOEvPiaHOeXzLH+v0q9XD3SFU4w=;
        b=uMpZHY1kvJxS2g6xkzha5eUredPoWMGnw0dmNBhGdTuizMUIl8YHP8s+vam7eU8Jms
         y9NBuG3N+/VVbLoJOI0fHrAS1Ml51TANwJ/3vzYdt0ySQoUHo9ZRxVo2s3hlGEFSduiE
         upBFEjNGrMYp2wZEgTynATHbJ3YKTAO0E6CcwPDsdnfhlPOlMXFXHkJBnFBEtA9bOfVM
         2q3DmcbAh/c9v4m6h0J+584nuOnIRyXCRvx+TM62jowXW/E8DKSe+1ewCCEQ/mQ3kWQN
         Ag0FwgaCQ7TA/TLGlTCcUiKojZkUDJNkQltpgGiJ0dF/+QMwpc5qGAORJ6CHq6UUks8c
         OBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469469; x=1754074269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ6hAPUzBtzPSujGKOEvPiaHOeXzLH+v0q9XD3SFU4w=;
        b=VRBZqSFMP8bW0YWpipUtRZn0bU9lXrsTqWsjqZyPIwJ496/9n3Iggj+A8gAK6+CEoW
         nDTUlhxcwqJcXE/5w4zKSIMPrRhv6+xS3/dVCrxZ2k+I8YCxUokiebAef9SnFVtS6Yxd
         TkQ91LD/Joo4AuBH0OTElmsN2TnVPUWXCzgRKUAqLvjmHUvWEB+prL88P2AE4JgMNIVf
         +e+qkLydbIoLsSE8Hv3d9rl1UfRu8pwc/dd64tDPitWSbVhk7uV4j3U91jV7TPLxRfQH
         jKqbhcHEhMn35/epcLik+6Yls7C5b4pwwWQbX+w81TGTpTg9/NqnYOJWvY+HDQ51ZZbI
         BIJw==
X-Forwarded-Encrypted: i=1; AJvYcCVaD/d61SbkRkSX+PcRETBzbMt247p9NlCa5PpGdrKOyFRoeHP7cfcFLz1FIufyUBSFvRy0+x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEHroG6Mie14Ew0zwM1EYKsiR7DvB4g892m7870O6N0ORjY9T
	NNOyqMNchQdDdaPiWgNZSzeCObeoL9FIDkhMUcYdmDLUgP5j1USwCs09dh7Ah6K9QpLer+yQ3JV
	c0oVCK4BuWWxP+DFM4zH8RdtxocrfCsdvPZDGfg5P
X-Gm-Gg: ASbGncufU/pYi42RMKtMbkXTtfEGGtsxHwTJ53QMiqwuKOblsPVuNrgGGtcPlAAJriU
	Obn6tPubjSJZojvYRz8QJjhGYXU9SJdHThz7AbKsxYVSt0to/yIMwzXTlonHiZw9dodVjwnWHqK
	i4xOfhYKYRIJ6WG51+qyxRCxrt6OkIxSr1qLBy1Qhnlo7vhkLuMWiaa/xMvVvJTwH7T/BSgNtyi
	dXOqwvvxsVpHg5BnIg4e1bphY2TsuwOI38bHYxMqO+vk19qdR8=
X-Google-Smtp-Source: AGHT+IFEO1MlBFe5fjVyy37Qgo8ReyTHSJ+VMkvacLifnhThyPfeUMVv64i2gb7SZvTFd27/Wgo6PmPyxhgCmiXTHZ4=
X-Received: by 2002:a17:90b:4ac5:b0:315:cc22:68d9 with SMTP id
 98e67ed59e1d1-31e77a4af86mr3944453a91.31.1753469468550; Fri, 25 Jul 2025
 11:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
 <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
 <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
 <e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
 <CAAVpQUDMj_1p6sVeo=bZ_u34HSX7V3WM6hYG3wHyyCACKrTKmQ@mail.gmail.com> <20250724184902.139eff3c@kernel.org>
In-Reply-To: <20250724184902.139eff3c@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 25 Jul 2025 11:50:57 -0700
X-Gm-Features: Ac12FXzjvKxZZ0TfulEtz2NxOb7G3ZS4IGZwElHwLN2QtXZe6QR7perh8RBHOCY
Message-ID: <CAAVpQUD36Wq7xcmdpeqCb3qpTzR7ZUDa=U4rUrfy7+JiE47Rsg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 6:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Jul 2025 11:06:14 -0700 Kuniyuki Iwashima wrote:
> > > 3. Will there ever be a reasonable use-case where there is non-isolat=
ed
> > >    sub-tree under an isolated ancestor?
> >
> > I think no, but again, we need to think about the scenario above,
> > otherwise, your ideal semantics is just broken.
> >
> > Also, "no reasonable scenario" does not always mean "we must
> > prevent the scenario".
> >
> > If there's nothing harmful, we can just let it be, especially if such
> > restriction gives nothing andrather hurts performance with no
> > good reason.
>
> Stating the obvious perhaps but it's probably too late in the release
> cycle to get enough agreement here to merge the series. So I'll mark
> it as Deferred.

Fair enough.

>
> While I'm typing, TBH I'm not sure I'm following the arguments about
> making the property hierarchical. Since the memory limit gets inherited
> I don't understand why the property of being isolated would not.
> Either I don't understand the memcg enough, or I don't understand your
> intended semantics. Anyway..

Inheriting a config is easy, but keeping the hierarchy complete isn't,
or maybe I'm thinking too hard :S

[root@fedora ~]# mkdir /sys/fs/cgroup/test1
[root@fedora ~]# mkdir /sys/fs/cgroup/test1/test2
[root@fedora ~]# echo +memory > /sys/fs/cgroup/test1/cgroup.subtree_control
[root@fedora ~]# echo 10000 > /sys/fs/cgroup/test1/test2/memory.max
[root@fedora ~]# echo 1000 > /sys/fs/cgroup/test1/memory.max
[  108.130895] bash invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),
order=3D0, oom_score_adj=3D0
...
[  108.260164] Out of memory and no killable processes...
[root@fedora ~]# cat /sys/fs/cgroup/test1/test2/memory.max
8192
[root@fedora ~]# cat /sys/fs/cgroup/test1/memory.max
0

