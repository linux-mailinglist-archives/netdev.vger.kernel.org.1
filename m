Return-Path: <netdev+bounces-202521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA8AEE1BE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A9173AFB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2028B7E7;
	Mon, 30 Jun 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3RRp75I7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B1244688
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295489; cv=none; b=U00t7yKYbAQ5Ov3aQowsH/RfyBnMZcTyMw3vCfe0VeSeFOahl+VYc9g24HhgfqMLxsEkHTySn6W29aqjJjTDw+DMpT48fxEZ8vWy7+zmflnHpr4vV/LZwENeFSSE2AciYiXgEHwzEDqY//f6+c1DQJPV+gOql7c50J9jAuNjwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295489; c=relaxed/simple;
	bh=KYBxFPXHV1nJsiR/7TVtufEz1kbj0cD4Ln+3aLCC35c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTy3nBFbiVSK2E8KTVe+LU4MXqZg7RgHl1L9oKqxB8Bt2k8WCd7WlpmN8FJqewTgGGZs0+t8QF1VFQUeC4YruyCIJGdWUUeuCn68gGxJIBtQJtfvmYQfyQ/9v7Ba22azABQBiIbVrHXswWXM2IKRWssg4RR48WZvotJzsqoPPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3RRp75I7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747ef5996edso1974036b3a.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751295487; x=1751900287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7FDpQN2j3zSDt5uX76G9r5bMW9lAyygUBGW2kmzwt0=;
        b=3RRp75I7OlpTQtF0rXTGwYRzUqOhfULNxoSHt57Oh78suj5kKMsbD+yIQtt/4brVlF
         hiz6osN+uQkLaL2hd4Eq93OAzeGIATmxYGTe4e8dm9lmEL1BOuki64oe9NBBns0zpsJD
         U30KiK3LsyX6cyLZndjbAb5fQ6nUTziudEeKmOPsXa5bz2b+Dn3tfCt4AAq0i/+pfFLj
         /sGEOqC+qOHsEN1TC+IlI2S2L8T+dm2qP75n/q5FYRzkj/xzojweQw3ln63oN/H9lg3r
         /5sKnRz6DSKponV/4YKiaO7lGWa0RW2dNH+I4Pmr/wa6mzfgUZISKKF+/TAxpzp1FQJy
         dqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295487; x=1751900287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7FDpQN2j3zSDt5uX76G9r5bMW9lAyygUBGW2kmzwt0=;
        b=BvzcS1w8c9wfTh8jFH8cVCUpt841yUdUuZcD3O4mDlHv+xoRqZKtUg1N5g4a2Kp36p
         444PzleKFIkjC2KojByX3r4cOq76ZDNm93hz9zzD5tLDg9U4ubm+MDXKizDtc0kHkFSX
         ordsPIgDuTEGkW7Yo93XR24uXRf7hjoHfnVB8PoxbyW8WY9B5OS+wY5ConZVW80fRD42
         BtLWF9Zpy0avf281RZ1o4cIkwJzki0JVVPvcv+uN/lspIfoaOjzd0P4NYjcYHJ6yy2+4
         2WL+kvRXb4Ox0ndrDXVqiKUFWWGiKAl19on39qnSjXR2okzKMT+sn8a4ReFVuf4xlFJZ
         VyWw==
X-Forwarded-Encrypted: i=1; AJvYcCVtsFdFIHSeXQGT2692Y3Zc0DQEJ/EWo71zsFM97KsyRULQxk8Te5G/9fOZd7/70QP8TZvEDR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtoUZCR4Dxf0feDV1Ua3Pg7+x2obnjaT5tYXXGe5cYbnvhl1k
	rnZpnOvfH2AqXiFELJlLDeL75u/OytdlEh2Sjd30BePVF40epiSuKqKjDt6VvpaLHcC4Uq27kJw
	TdXv73bXiaxrGpYk1UYMQrxaoSk9SnubXwpGE18Vi
X-Gm-Gg: ASbGnctRuS92be7GG8JiDEHaw//X3il/dnL5GXduV6HLF4N6J/WrKRI5Cub2YaPD/tI
	D8sgPfnOnyF4jz5tO9dk8VgdPZP9swdKq9uAMmRw3RpYHbhPztVrhYeoSSSR1ftKTuIU/vD+x7u
	RClDJhbMgRxMO/XLrk3MW2HsFgm/9XAhqh3mgD2R8mwg==
X-Google-Smtp-Source: AGHT+IF4wXl2gF2bNDBfpUr3Sx/LmtF/RJrAmrCT4V745yrZ/LASV8QGoXyGsnHeRQXFaBkaWXaMCNcBjISugiuFhrc=
X-Received: by 2002:a05:6a00:2ea0:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-74af6f4323fmr18092650b3a.16.1751295486847; Mon, 30 Jun 2025
 07:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com> <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain> <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com> <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
In-Reply-To: <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 10:57:55 -0400
X-Gm-Features: Ac12FXwWKx5K21Dcn_KYNrbnCBaQHlHoQvkG0b5ZMENELHDf-pLotTgAO-ZhwhY
Message-ID: <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 9:36=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Hi,
>
> On 6/30/25 1:34 PM, Jamal Hadi Salim wrote:
> > Hi,
> >
> > On Mon, Jun 30, 2025 at 5:04=E2=80=AFAM Lion Ackermann <nnamrec@gmail.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> On 6/29/25 9:50 PM, Cong Wang wrote:
> >>> On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
> >>>>> On "What do you think the root cause is here?"
> >>>>>
> >>>>> I believe the root cause is that qdiscs like hfsc and qfq are dropp=
ing
> >>>>> all packets in enqueue (mostly in relation to peek()) and that resu=
lt
> >>>>> is not being reflected in the return code returned to its parent
> >>>>> qdisc.
> >>>>> So, in the example you described in this thread, drr is oblivious t=
o
> >>>>> the fact that the child qdisc dropped its packet because the call t=
o
> >>>>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
> >>>>> activate a class that shouldn't have been activated at all.
> >>>>>
> >>>>> You can argue that drr (and other similar qdiscs) may detect this b=
y
> >>>>> checking the call to qlen_notify (as the drr patch was
> >>>>> doing), but that seems really counter-intuitive. Imagine writing a =
new
> >>>>> qdisc and having to check for that every time you call a child's
> >>>>> enqueue. Sure  your patch solves this, but it also seems like it's =
not
> >>>>> fixing the underlying issue (which is drr activating the class in t=
he
> >>>>> first place). Your patch is simply removing all the classes from th=
eir
> >>>>> active lists when you delete them. And your patch may seem ok for n=
ow,
> >>>>> but I am worried it might break something else in the future that w=
e
> >>>>> are not seeing.
> >>>>>
> >>>>> And do note: All of the examples of the hierarchy I have seen so fa=
r,
> >>>>> that put us in this situation, are nonsensical
> >>>>>
> >>>>
> >>>> At this point my thinking is to apply your patch and then we discuss=
 a
> >>>> longer term solution. Cong?
> >>>
> >>> I agree. If Lion's patch works, it is certainly much better as a bug =
fix
> >>> for both -net and -stable.
> >>>
> >>> Also for all of those ->qlen_notify() craziness, I think we need to
> >>> rethink about the architecture, _maybe_ there are better architectura=
l
> >>> solutions.
> >>>
> >>> Thanks!
> >>
> >> Just for the record, I agree with all your points and as was stated th=
is
> >> patch really only does damage prevention. Your proposal of preventing
> >> hierarchies sounds useful in the long run to keep the backlogs sane.
> >>
> >> I did run all the tdc tests on the latest net tree and they passed. Al=
so
> >> my HFSC reproducer does not trigger with the proposed patch. I do not =
have
> >> a simple reproducer at hand for the QFQ tree case that you mentioned. =
So
> >> please verify this too if you can.
> >>
> >> Otherwise please feel free to go forward with the patch. If I can add
> >> anything else to the discussion please let me know.
> >>
> >
> > Please post the patch formally as per Cong request. A tdc test case of
> > the reproducer would also help.
> >
> > cheers,
> > jamal
>
> I sent a patch, though I am not terribly familiar with the tdc test case
> infrastructure. If it is a no-op for you to translate the repro above int=
o
> the required format, please feel free to do that and post a patch for tha=
t.
> Otherwise I can have a closer look at it tomorrow.
>

We'll help out this time - but it is a good idea to for you to learn
how to do it if you are going to keep finding issues on tc ;->

cheers,
jamal
> Thanks,
> Lion

