Return-Path: <netdev+bounces-205179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C979AFDB48
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC863A7175
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67B31E3769;
	Tue,  8 Jul 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="U2Kbck1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF171B4257
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014719; cv=none; b=kNZj3oFHY6sSxZ5r6aoJmwdgH0qFCH7CykUlSjtKczv0YOo/33X5kKagW/oAOVYVzZRK5ymvL39Fk9rBELDgV8fh+KDhI24EUXphADvZ7qeFqT2XxhwktPeOuDdrQqqPAf5LslWGh+kxb/Ll8r8ENhTZUYSzMDcPR0nRdJv6Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014719; c=relaxed/simple;
	bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHQR3P8ma+ceI/t6dkUyHRvIus1jqK3Lmk6B+/f8ahv4RviTvJ0I866NWePzheTunjTLSFYt9v/KIYazH6T/P1QRv3fzLGJXcIcGnMuUuzH4GZUkMHsLuwK8ZNjH/6LWLnw7Pjaztdvqt5qi4Gw62sAlnA/M9keEVBkehD6nBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=U2Kbck1p; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3f1bd7121so504935885a.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752014716; x=1752619516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
        b=U2Kbck1pHc3eQ2r5EwEUNp5PMaNGQ/CjHa6DynV9SazDNeP6o6mbX2Mx6TlrE+L5hz
         y03EEOaxdx04uaZEuYq9gAOKvDzNjsuCQt87Hh7rXgoMdpiX2WGqLrGbZgrmp/1hltWl
         B3w9bwOFjh9o4fHYwHT27PUy8jAr6yiVhQ6QSLBbL97S4B0V/ihy6pneQ3RwI2WPFXYc
         rB+lRmEW9JSxpGc+vYMgZTnMMDTRCZ8rbhDLZlJ/D4achJykTHpjb95zF9blhDTrz6sQ
         UgVk7l9DXLsIob6k8Ro/WgPuQgjuPyRBF74F/8WXtFzTEjak++DwYQI1pNWX8LbrUwpV
         Z8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014716; x=1752619516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
        b=IyHFbWxAjKfks94fC6Ol3CnPWJgqETtimgXKF36/n1eLtpg167Ig/HuwWWXNgQnf4Z
         x4ImBkGx3ANQdTDL6EoGlTeFXRXZCShgv6Y+qQ19rUWDVEE3qBB6puH14cgfetLntVVm
         xcP0a4F+Ra5fGAXiuLyAI1EQDAyw/MswgPiRZ2FCK1U+Bgqnf3LpP8x6FZfxiC/UMjXZ
         BTbrjHkVd8G7n0vjZ0oFQAxbupKUn2qSAttaAORNIM74fdddKhNB07MFVInivmBTTUbO
         rebWxoSrTcWPlPwrr6oeKXYCJO7bhzc4sgfXIlat0n72A9SVXUUE24qImkntdAOrrcNz
         AULA==
X-Forwarded-Encrypted: i=1; AJvYcCXjNJrOJ4SzXaYHACoW4EdbEYlKmWIbLoy1qJYSgsy3nBv1DXz5gG0K6dBGoVElEKTGF2szWEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSk33PVqP6kBj6738AaybG2lwxcTsgZuk24Y1JMhxy/djndy0
	6/tWn/6mjZyTqtLNOxhqk7+rc3MZYFL7Qprm0FO8KULSYJkznVqlXkS6iX+QMdNANgs=
X-Gm-Gg: ASbGnctxzzzZual9Jx6stnhDgi1zxcnBOEKGETHH7c/hK6kC145ZBNJI1BDGxIRM/wz
	mMR8pNKQoTL+moYncrobjQBPOZKIfWAQAoBuImI2eoxOSttz9DNI73hTf21eGjik2L9u67fLilB
	oFUNXH71EUzEc00eyWsYYVdsDDmL/d3/Wd2PncxaEwcQ7hcqzlvkg5pGNReRPYAXFGpXS8oPodc
	g7tyNr8YOq68BigeTFwoVKyXJDE5aHTC38M4xGYKmjqAJxgZobCyWFQvg5cpD4Gh1mTVmIUDFSd
	zDZDbS4HX3h+sOkQjOfftKGnx8vQ2snE7hwPkf3MbXAQsDfEc5Oh6vE92Hb9ncaEBt/B5kXEvfN
	WjT97bAvSeHzV/bsrCspBsREH4ZgjH0YnX1n91qE=
X-Google-Smtp-Source: AGHT+IGaSttCcjmFBXaIxysGtD3+QOBaV/hmFGxA9/T2lYKyhnz52dWB4G9cv/PM5KVkkeqmFpNNpA==
X-Received: by 2002:a05:620a:2602:b0:7d4:5cea:83a3 with SMTP id af79cd13be357-7db7e34eabdmr79423285a.34.1752014715845;
        Tue, 08 Jul 2025 15:45:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdc4623sm842482285a.50.2025.07.08.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:45:15 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:45:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>,
 netdev@vger.kernel.org, victor@mojatatu.com, pctammela@mojatatu.com,
 pabeni@redhat.com, kuba@kernel.org, dcaratti@redhat.com,
 savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org
Subject: Re: This breaks netem use cases
Message-ID: <20250708154511.58862605@hermes.local>
In-Reply-To: <CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
References: <20250708164141.875402-1-will@willsroot.io>
	<aG10rqwjX6elG1Gx@pop-os.localdomain>
	<CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>
	<aG2OUoDD2m5MqdSz@pop-os.localdomain>
	<CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 18:26:28 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Tue, Jul 8, 2025 at 5:32=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
> >
> > (Cc Linus Torvalds)
> >
> > On Tue, Jul 08, 2025 at 04:35:37PM -0400, Jamal Hadi Salim wrote: =20
> > > On Tue, Jul 8, 2025 at 3:42=E2=80=AFPM Cong Wang <xiyou.wangcong@gmai=
l.com> wrote: =20
> > > >
> > > > (Cc LKML for more audience, since this clearly breaks potentially u=
seful
> > > > use cases)
> > > >
> > > > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote: =20
> > > > > netem_enqueue's duplication prevention logic breaks when a netem
> > > > > resides in a qdisc tree with other netems - this can lead to a
> > > > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > > > Ensure that a duplicating netem cannot exist in a tree with other
> > > > > netems. =20
> > > >
> > > > As I already warned in your previous patchset, this breaks the foll=
owing
> > > > potentially useful use case:
> > > >
> > > > sudo tc qdisc add dev eth0 root handle 1: mq
> > > > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 10=
0%
> > > > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 10=
0%
> > > >
> > > > I don't see any logical problem of such use case, therefore we shou=
ld
> > > > consider it as valid, we can't break it.
> > > > =20
> > >
> > > I thought we are trying to provide an intermediate solution to plug an
> > > existing hole and come up with a longer term solution. =20
> >
> > Breaking valid use cases even for a short period is still no way to go.
> > Sorry, Jamal. Since I can't convince you, please ask Linus.
> >
> > Also, I don't see you have proposed any long term solution. If you
> > really have one, please state it clearly and provide a clear timeline to
> > users.
> > =20
>=20
> I explained my approach a few times: We need to come up with a long
> term solution that looks at the sanity of hierarchies.
> Equivalent to init/change()
> Today we only look at netlink requests for a specific qdisc. The new
> approach (possibly an ops) will also look at the sanity of configs in
> relation to hierarchies.
> You can work on it or come with an alternative proposal.
> That is not the scope of this discussion though
>=20
> > > If there are users of such a "potential setup" you show above we are
> > > going to find out very quickly. =20
> >
> > Please read the above specific example. It is more than just valid, it
> > is very reasonable, installing netem for each queue is the right way of
> > using netem duplication to avoid the global root spinlock in a multique=
ue
> > setup.
> > =20
>=20
> In all my years working on tc I have never seen _anyone_ using
> duplication where netem is _not the root qdisc_. And i have done a lot
> of "support" in this area.
> You can craft any example you want but it needs to be practical - I
> dont see the practicality in your example.
> Just because we allow arbitrary crafting of hierarchies doesnt mean
> they are correct.
> The choice is between complicating things to fix a "potential" corner
> use case vs simplicity (especially of a short term approach that is
> intended to be obsoleted in the long term).

One of my initial examples was to use HTB and netem.
Where each class got a different loss rate etc.
But duplication is usually link wide.

