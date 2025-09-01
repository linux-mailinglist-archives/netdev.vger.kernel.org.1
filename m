Return-Path: <netdev+bounces-218599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353ABB3D853
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD973B6E72
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BC1A76BB;
	Mon,  1 Sep 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rD494zNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB93C17
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756701934; cv=none; b=G4xdp8X9LCeN24RDyRjEdSNOWSBePw5sjOundbPjUG6g6oCSa6DVpzbKAu0y8X74oQRrnQ8ZbzP59qRfZY+4OGucWuS+UIjKv9mQPu4RmDnRTOHDDhf7JydIT2I8+i+rCa/LfSSOeIIda4bKtP65pb4xm/1rTTyAgqRZKSBq+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756701934; c=relaxed/simple;
	bh=OLFkg6tp/PvyNcYp4KP9jhHoXvCTw41vEVpu6I7zKzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d13m1zaQcTreZDSUfVbJB5oFrVwt0w25YLn2pz9WIS4AfjutiKA0Ph0Z7UxS8Zo9n9QmwrJMQCeqGC2RBPlbhb1AbBPA2dRwtWlhLLdbMYn/RjxhQmscG6kZcY1fGG+fsNR1FUkFV+WWth/w/myZk61Rj8qKnN237hmYT0eqYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rD494zNf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24abf0215e8so5775675ad.1
        for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756701932; x=1757306732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbapeueXg6drB+/nHRCP41k9F/G30yuZGmcMPytXvnY=;
        b=rD494zNfXmpH4oACNzRpnf5gIq40HzXBJsY9QC+wBqORq1QuCN1R2P/Wnj5qOu9EzZ
         PBvewj4wBiTm0V19hsQmT0HxQwR/KHWI0DNcXga4ZdmGd5hHnfvitcyPOJ2qb+4IhRi8
         OKw4GAfkd/V1lNcpM4R6TNY5IFxDkOng/DlxejIcz98WU5p2GXTLIkMMkcwqa3ssQ2dW
         9v86oQe3id89/paeyAbe6LTWE89lrlHt6TNifhSECD131o6DpqblxA3gJ2HO510KYVQb
         F4v9jL69FrGqW3KL45Vm/Wudz6Vl5NPRfoN/rwegMEuYEOv/OmiezaO54vt68u3cv3ZV
         EEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756701932; x=1757306732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbapeueXg6drB+/nHRCP41k9F/G30yuZGmcMPytXvnY=;
        b=ot04SUAHyfnSSQl2x7W1eg7sZRHwdd4JiaGJxaHyEF4zjCsa2ml6kg8jSNyvtZ5Y4W
         IxOUuspa4dANIwdN4lBbKNd/VcxA73R0R9oV/sTYnOV6EhsN9jyTRXlm52hbLo8+GGtO
         JbD4nzCqfTv18G+W/DGJCmfZgsyiQRFzTsoOgd1Ybw3NRTJrVIIW1M9iEBW9KZTBIp+I
         YCF3sNVGpfI2PfBc1s02P2EaXW/hbm1H2GjsIs5rbv3xgZO8/RqtpJy0Rz1hzxKns89F
         HHGQM5rtehWhoweYvMv83otAfmDdGlxXI827CkeJbxhj4QD0g0OYLsKIPwF+yVzH3VPV
         z45A==
X-Forwarded-Encrypted: i=1; AJvYcCUT6gqoKwlB/p9Ej0huoCGl2HizTTfLXIbmdmCbZwN4x6WgYdDZ1NcM4msXZ0j+2go8oQ98rOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NF/Yk3a1T70YlgBydsNdbGAKS4Fij+TPb7kw+BZaydW/YBj2
	9dOBw2qhRllv0eiLHWhHBD4EVpPLUkn+cmpy4Jgf8yBMxyEj7RcrMm9qR2fqaNDeVCbOfMHXeBh
	8BKym+C3El7KHigf39iGeNs51xPbmlfPGKbMYiSjs
X-Gm-Gg: ASbGncsKvZ89r8EG8RXEvOV/LZOk9kX0OFPI5jdalA1s/0HnMV8f130H/Z9ffnntTjL
	l3jA92rQy0OiwUDtrCqlFr33ZGwoZMNUJ1xixE+Eq8WS1izYG7i5IRdFt4Z2Ay6TBqziYDkqbBL
	MYrOxQTHnxNtMh5K5wxizlNl6T5n3hiWhL1JoXuACglpY4TTFs5FD2Biv+DmkPvOcd2tnlX4QeE
	ij/769xMI9rjg2NLZXuTgm6pa8ofCYnuD0VxCs=
X-Google-Smtp-Source: AGHT+IG47NvdCuw48KmtpZx1/xVfQ2dsw01smyCPscsBb6fOcJcu+M9Z6UOPBuqEFP5NWVez2oPDbaI9wVpKJpzJmEI=
X-Received: by 2002:a17:902:cccd:b0:246:2ab3:fd7d with SMTP id
 d9443c01a7336-249448f9c28mr85988795ad.25.1756701932387; Sun, 31 Aug 2025
 21:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
 <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
 <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com>
 <CANn89i+-Qz9QQxBt4s2HFMo-DavOnki-UqSRRGuT8K1mw1T5yg@mail.gmail.com> <CANn89i+nNZx3QftApMcyb2PBopO=v+4rR-gKZZTbUReZjT41Fg@mail.gmail.com>
In-Reply-To: <CANn89i+nNZx3QftApMcyb2PBopO=v+4rR-gKZZTbUReZjT41Fg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 1 Sep 2025 00:45:20 -0400
X-Gm-Features: Ac12FXzLbgyhQznc2XntNYdNGDLqEb4JAF0AtMwvwlnaq7yBbGH_iHz4jATsSmc
Message-ID: <CAM0EoMknB8MwZ_nPgpjH3N50ahRLsENr4HibKQHdwNGNO5sf9w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:03=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Aug 29, 2025 at 12:19=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Aug 28, 2025 at 8:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 11:26=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Wed, Aug 27, 2025 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > Followup of f45b45cbfae3 ("Merge branch
> > > > > 'net_sched-act-extend-rcu-use-in-dump-methods'")
> > > > >
> > > > > We never grab tcf_lock from BH context in these modules:
> > > > >
> > > > >  act_connmark
> > > > >  act_csum
> > > > >  act_ct
> > > > >  act_ctinfo
> > > > >  act_mpls
> > > > >  act_nat
> > > > >  act_pedit
> > > > >  act_skbedit
> > > > >
> > > > > No longer block BH when acquiring tcf_lock from init functions.
> > > > >
> > > >
> > > > Brief glance: isnt  the lock still held in BH context for some acti=
ons
> > > > like pedit and nat (albeit in corner cases)? Both actions call
> > > > tcf_action_update_bstats in their act callbacks.
> > > > i.e if the action instance was not created with percpu stats,
> > > > tcf_action_update_bstats will grab the lock.
> > > >
> > >
> > > Testing with lockdep should illustrate this..
> >
> > Thanks, I will take a look shortly !
>
> I guess I missed this because the lock has two names (tcfa_lock and tcf_l=
ock)
>
> Also, it is unclear why a spinlock is taken for updating stats
> as dumps do not seem to acquire this lock.
>

action stats dump does start in tcf_action_copy_stats which will grab
the lock (in either gnet_stats_start_copy_compat or
gnet_stats_start_copy) and releases when it terminates in
gnet_stats_finish_copy.

> This could be using atomic_inc() and atomic_add()...

Doable - could be involved...

cheers,
jamal

