Return-Path: <netdev+bounces-159457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4855AA158C4
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BF3A93BC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB01A9B5C;
	Fri, 17 Jan 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="Xnrm+O1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD781A00FE
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147766; cv=none; b=QMV+pVIUF1EwaLcjIrdMZiSWdQJZIbaajCNK0vCVks3QwZ+27yeZzRIr9xiOggA7xew9pEGh3NzqIKUmDJcxMOonEsTIGTAy199Hxdd8DBNN3+beOupYglEDvReO6hdOFv9SSAbC5+O9rpm+wRdV54NWhgb1C267Xa3+MgeScOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147766; c=relaxed/simple;
	bh=ykYFv7D2l5CSH/8Szp7jSzr2Dbd1rc9jlcpuqI8NFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUnkzFVldvOY0tyMSU1esEIfJa0LeUrmkoJA389B9QfkCvdxFEDZkdbYDKci5/vgFcKNDF9Y5OCBJ9Wrghe2n8QCAtY13sDJUF7fnztvde5b6Hgdi6xHYxyolDmXUTSWSbWT8sR+JsdKcnNCEozZMfGyxUQ4gxw9FH5CqjZZW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=Xnrm+O1H; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so5011972276.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1737147763; x=1737752563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykYFv7D2l5CSH/8Szp7jSzr2Dbd1rc9jlcpuqI8NFGM=;
        b=Xnrm+O1HldfVH+WAySLH+nJdMvIftzSOzlObW17Ng0zs54WLFW6nml2wyWYZec6x60
         TyjQaYBSBNnA+WGk4zVaid9DnebXgJO8W4RtESCUszJzFSDk3E4Ov2rU44TXZJClTqT3
         ZctwnnafpcSZ8F8lDUoYsUg3PK9hf73KiyQYSBZTy4suZjDYiJfxPEYEWMGeB8tgRvAX
         dtIN5rNZgr7Ooe65ein5U+VwEjMW5dl8VvwmGKck33qNOCJRMVUea4GJxbpfNO7wQRzY
         KAzUYcW/rNJyUHPDAKMDP8wTcDW9B7iQA3fMnHomZ0mv0O4QYuloK7Ty6iwVr2z9BiLY
         +sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737147763; x=1737752563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykYFv7D2l5CSH/8Szp7jSzr2Dbd1rc9jlcpuqI8NFGM=;
        b=lteiXtyZgvVtWW+f/cM4HQ+SJeRn/as2++eEcUS2f5ouq/YHAKDnv4Wi5hlni66usu
         RSkQ3MXpUnYvTmgoCGaC79V2uLCEnajFTGeRfTyE59+hvCSByaZdB2fYO8tJBG7m/Wiw
         4WMFqTbZsM2LWQR5g+FoWfduJtcKRwE4YhGImhACHeqd7Vk2pm3lE1JLd+oPyyl89d0K
         yZoDqly28F8uqAvr1J3KTZDgr6pxYalXFbLU9JJaDuDyGWj2VLtKiy07O1ji5fwVui+R
         QJ7OtQF93s/scJnO0huLU0bElYAkjAXR9bNjGTGvYapGyrUbT6C50SKeZrfni1nv1vF8
         jXWA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqIDFs3JLgtivPSd8ZI3qu/39usYASjPw5yzilS/eS7cDj4iqeiV6FmNWflTMTk3ZVun+H6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCWBRIwF3r4h6/jLRhqC1rms1SEuGqmAe3Dr2H3a8jp/a+ubo
	JJ16f0kO/KeyXxOwUCukKL15I1agOnB2AnZoNv8zY/T2AzNBonkaXRFk8D0pgtkHUR1eEl+E0Yi
	SXwXoYrD3X3Vzzo8Sp6yYsKXsUoi9yHyR8TsB0w==
X-Gm-Gg: ASbGncvIcSqVNRwGoG8H4R/LSNPFiHQDN+ZAs421CKSQNK6lx9XpZhpB/rAcDWmIvWw
	st6VVG8XLuRjNeW7h0FrniWx0pTicEtubF9w5Cw==
X-Google-Smtp-Source: AGHT+IG0q5q150cz3MWREN8ebvGF7IsCV1LatE2MPWdIzRNNDzMMNCGsynoCLzRXFa0f+3mpl0QNmE2lUTxasuPtj30=
X-Received: by 2002:a05:690c:6501:b0:6ef:77e3:efe6 with SMTP id
 00721157ae682-6f6eb671ae3mr35386387b3.13.1737147762650; Fri, 17 Jan 2025
 13:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf> <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf> <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com> <20250117161334.ail2fyjuq75ef5to@skbuf>
In-Reply-To: <20250117161334.ail2fyjuq75ef5to@skbuf>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 17 Jan 2025 13:02:31 -0800
X-Gm-Features: AbW1kvZSO_JE7r5tB6tAvOG0pwVkUMKMoliKrR2EhJEFTq0mSv1tcTlmcPWJScA
Message-ID: <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com, andrew@lunn.ch, 
	davem@davemloft.net, Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com, 
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:13=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Jan 16, 2025 at 05:25:49PM -0800, Tim Harvey wrote:
> > On Thu, Jan 16, 2025 at 5:09=E2=80=AFPM <Tristram.Ha@microchip.com> wro=
te:
> > >
> > > > Hi Tim,
> > > >
> > > > > Hi Arun,
> > > > >
> > > > > Ok, that makes sense to me and falls in line with what my patch h=
ere
> > > > > was trying to do. When you enable the reserved multicast table it
> > > > > makes sense to update the entire table right? You are only updati=
ng
> > > > > one address/group. Can you please review and comment on my patch
> > > > > here?
> > > >
> > > >
> > > > During my testing of STP protocol, I found that Group 0 of reserved
> > > > multicast table needs to be updated. Since I have not worked on oth=
er
> > > > groups in the multicast table, I didn't update it.
> > > >
> > > > I could not find the original patch to review, it shows "not found"=
 in
> > > > lore.kernel.org.
> > > >
> > > > Below are my comments,
> > > >
> > > > - Why override bit is not set in REG_SW_ALU_VAL_B register.
> > > > - ksz9477_enable_stp_addr() can be renamed since it updates all the
> > > > table entries.
> > >
> > > The reserved multicast table has only 8 entries that apply to 48
> > > multicast addresses, so some addresses share one entry.
> > >
> > > Some entries that are supposed to forward only to the host port or sk=
ip
> > > should be updated when that host port is not the default one.
> > >
> > > The override bit should be set for the STP address as that is require=
d
> > > for receiving when the port is closed.
> > >
> > > Some entries for MVRP/MSRP should forward to the host port when the h=
ost
> > > can process those messages and broadcast to all ports when the host d=
oes
> > > not process those messages, but that is not controllable by the switc=
h
> > > driver so I do not know how to handle in this situation.
> > >
> >
> > Hi Tristram,
> >
> > Thanks for your feedback.
> >
> > What is the behavior when the reserved multicast table is not enabled
> > (does it forward to all ports, drop all mcast, something else?)
> >
> > > The default reserved multicast table forwards to host port on entries=
 0,
> > > 2, and 6; skips host port on entries 4, 5, and 7; forwards to all por=
ts
> > > on entry 3; and drops on entry 1.
> > >
> >
> > Is this behavior the desired behavior as far as the Linux DSA folks wou=
ld want?
> >
> > commit 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
> > pointer in ksz_dev_ops") enables the reserved multicast table and
> > adjusts the cpu port for entry 0 leaving the rest the same (and wrong
> > if the cpu port is not the highest port in the switch).
> >
> > My patch adjusts the entries but keeps the rules the same and the
> > question that is posed is that the right thing to do with respect to
> > Linux DSA?
> >
> > Best Regard,
> >
> > Tim
>
> Not sure if that's a question for the DSA maintainers or for Tristram,
> because I've expressed already earlier in this thread what is the
> current way in which the Linux bridge expects this mechanism to work.
> This is not the Microchip KSZ SDK, and thus, following the network stack
> rules is not optional, and inventing local conventions when there
> already exist global ones is a no-go. If you don't like the conventions
> you are of course free to challenge them, but this is not the right
> audience to do that.

Vladimir,

The question to Tristram was what is the behavior if the multicast
address table is disabled which was the case prior to commit
331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
pointer in ksz_dev_ops"). I have tested and been able to determine
that the behavior without the multicast address table enabled is that
multicast packets are forwarded to all ports.

What commit 331d64f752bb ("net: dsa: microchip: add the
enable_stp_addr pointer in ksz_dev_ops") does is to effectively
'disable' forwarding of packets to 01-80-C2-00-00-00 (group 0) to
downstream ports. I misread or confused the commit log by thinking the
patch was 'enabling' forwarding... it's the opposite.

The flaw with that patch is that enabling the multicast address table
invokes other default rules in the table that need to be re-configured
for the cpu port but the patch only configures group 0
(01-80-C2-00-00-00). It fails to configure group 6 (01-80-C2-00-00-08)
which is also used for STP so I would argue that it doesn't even do
what the commit log says it does. It also has the side effect of
disabling forwarding of other groups that were previously forwarded:
- group 1 01-80-C2-00-00-01 (MAC Control Frame) (previously were
forwarded, now are dropped)
- group 2 01-80-C2-00-00-03 (802.1X access control) (previously were
forwarded, now are forwarded to the highest port which may not be the
cpu port)
- group 4 01-80-C2-00-00-20 (GMRP) (previously were forwarded, now
forwarded to all except the highest port number which may not be the
cpu port)
- group 5 01-80-C2-00-00-21 (GVRP) (previously were forwarded, now
forwarded to all except the highest port number which may not be the
cpu port)
- group 6 01-80-C2-00-00-02, 01-80-C2-00-00-04 - 01-80-C2-00-00-0F
(previously were forwarded, now are forwarded to the highest port
which may not be the cpu port)
- group 7 01-80-C2-00-00-11 - 01-80-C2-00-00-1F, 01-80-C2-00-00-22 -
01-80-C2-00-00-2F (previously were forwarded, now forwarded to all
except the highest port number which may not be the cpu port)

To fix this, I propose adding a function to configure each of the
above groups (which are hardware filtering functions of the switch)
with proper port masks but I need to know from the DSA experts what is
desired for the port mask of those groups. The multicast address table
can only invoke rules based on those groups of addresses so if that is
not flexible enough then the multicast address table should instead be
disabled.

Obviously Alun felt that forwarding STP packets to only the cpu port
instead of all ports was desired and there were no complaints about
that. If that is wrong then I can revert the enabling of the multicast
address table for ksz9477 and restore the default forwarding of
multicast packets to all ports.

I am not that familiar with Linux DSA so I don't know if it's normal
to forward multicast packets to upstream cpu port only, all ports, or
no ports. If there is some software table where the decision making is
done then the multicast address table should not have been enabled at
all in order to allow the software to determine the course of action.

My goal was to restore multicast packets flowing through to the CPU
port which in my board's case is not the highest number port so the
above default rules are just wrong and would need to be updated if the
multicast address table is to be used.

How would you like me to proceed?

Best Regards,

Tim

