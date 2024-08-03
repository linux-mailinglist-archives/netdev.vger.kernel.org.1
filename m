Return-Path: <netdev+bounces-115491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA294698C
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C391C20B0A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567B14E2E8;
	Sat,  3 Aug 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ide347Gr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9F1396;
	Sat,  3 Aug 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685891; cv=none; b=AfX36SXIzvxGClSBwhy8NJlB2ecfmh8HDjo/exyFNGCkMGss+XYRIB1l8XOSRirm10zB96KCZVlD37EYFI2KXCxx0vyzJQJapdIkrqPxnaFE+mLnlBhIOjl348OOvcfYA5MPFLcJJ+fV2x/yAJv47s6z1sUiNIXAJpNQZ5VeySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685891; c=relaxed/simple;
	bh=qw0pCT4Wt3v4iGOiyhsSkyg4SHhVmvVz5gQzE4haFkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFhqrGW9+X4qwSWn1F/tvpMnLO0ELC4D414Z+hU4dQ8oRRxyVWh5Hd48UPlS5xT21RHwamLdIHitSC1UXUjCqUMOb2Cywlt3C68dpgpkzxK/Qp3BiDNo8wJjZZuj6Mbwl6fAj3UC7eKvP6oHZKfP6JMRhfaQOi9CPlyY4zWZZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ide347Gr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc65329979so79292565ad.0;
        Sat, 03 Aug 2024 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722685889; x=1723290689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3idf2yAMdQlba58LsLncc+6NRs2Wf6G3OFW/g+kMYKc=;
        b=Ide347GrC9mKnL2J01p/By2rYIKRBlXxH9D9s14IuEVpTsgrbn7JpMUzRo74zPfEYY
         4l5VMj/0OEyNH1qeGJg0mi6gpXvGPhFzF2JeKmgf4riW7TDC4zv0V5/YyqB9Nn0Q0CMa
         zDvH+tOxY2iYhBjE/xMjspzvr6kdzvrzoowJ+/n+I1q0OYOdAIK+2iGQicvUJl3QUIDx
         T7ZKKQJ4jb04jW1B/lAD6dXve5gGg/fEnUGPwzn5kDSGYsdTY3Muo4Ax5sEeqzELib9x
         WbWZ8fJkTdCSKN4W02+MlxlQQT6Tc16hkbBYZaVQ/fMNWdZ855NQbQ4Q/wLYivRUap+p
         f5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722685889; x=1723290689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3idf2yAMdQlba58LsLncc+6NRs2Wf6G3OFW/g+kMYKc=;
        b=vFoQPm/Sswn4WUsD7mbnD1VgovAphHUS1JRdAg5gwAz0K8svyd6n0eaGCTyY3lRyut
         nkZQ4erTDps0LF39yzVCPHC/GnpjxkSFWJEfxzudZN0/7h2WaEBkx7s2u/5d6lPSWUGY
         zqfbDY7iNaq6kFROpxRZxtRMDm01J8ajb+kxFWpyKSm4PerG47hY3CNQwJNn6LyRrWmC
         RJ/abnZaxMP3GSyZcR1doHRNr2wd4cXVbAzUs5qsjnqBjPrduxdgty3dTWjkfG8mmTtI
         0dOiENRQ+Tv+0I+LrK9pCK/5s8ju321K3Z4NkrP93xb5DCmFv6gHoRQ6cXPrluYRVTrp
         lwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA99NthhHNWLIgem9lSqQtXDo8FieqDOqetxVjZrb7Rt7CauZbA8M6VYtmGB+hZZFFndpeb2fvHPNtdRt0Xc5r5NalM5B5JNtcC7bDZytkBKKq2xcaS6YfGdi9IUbyJYcxiTBG
X-Gm-Message-State: AOJu0YwGWo7vJbxuw6g1394XDiWNvtgJmP01NUGoOpmxDqvb+rVCXRu5
	PWr3h9UpUtqmWBkK4lBz1ZUL3TWfA6ioWp3GxEIBN0L7k9DC+enAYKtm/R76qY7b783dY2dor2s
	Kk+LoWS2Y4Quw8Gd2BNlFypOb7SQ=
X-Google-Smtp-Source: AGHT+IE0nNDazsdKrSQgDmF0m5QcPhdsM3W7+OMUO9VuCgylfGZhhqI7y/pvofGBt2qVDLqHn8P1lcfsCh8wMWuMGCI=
X-Received: by 2002:a17:903:2306:b0:1ff:3c45:48dd with SMTP id
 d9443c01a7336-1ff57298462mr74948475ad.30.1722685888629; Sat, 03 Aug 2024
 04:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zq0akdhiSeoiOLsY@nanopsycho.orion> <4E6F3146-AE8D-4C70-A068-A6EE8588F13D@gmail.com>
 <Zq3VLwc51pmn9ToA@nanopsycho.orion>
In-Reply-To: <Zq3VLwc51pmn9ToA@nanopsycho.orion>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 3 Aug 2024 20:51:16 +0900
Message-ID: <CAO9qdTGLs8_1vi_s-87e-WOBmzzDEXQnx0eWcTwQibUBujiFug@mail.gmail.com>
Subject: Re: [PATCH net,v2] team: fix possible deadlock in team_port_change_check
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiri Pirko wrote:
>
> Sat, Aug 03, 2024 at 03:36:48AM CEST, aha310510@gmail.com wrote:
> >
> >
> >> Jiri Pirko wrote:
> >>
> >> =EF=BB=BFFri, Aug 02, 2024 at 06:25:31PM CEST, aha310510@gmail.com wro=
te:
> >>> Eric Dumazet wrote:
> >>>>
> >>>>> On Fri, Aug 2, 2024 at 5:00=E2=80=AFPM Jeongjun Park <aha310510@gma=
il.com> wrote:
> >>>>>>
> >>>
> >>> [..]
> >>>
> >>> @@ -2501,6 +2470,11 @@ int team_nl_options_get_doit(struct sk_buff *s=
kb, struct genl_info *info)
> >>>    int err;
> >>>    LIST_HEAD(sel_opt_inst_list);
> >>>
> >>> +    if (!rtnl_is_locked()) {
> >>
> >> This is completely wrong, other thread may hold the lock.
> >>
> >>
> >>> +        rtnl_lock();
> >>
> >> NACK! I wrote it in the other thread. Don't take rtnl for get options
> >> command. It is used for repeated fetch of stats. It's read only. Shoul=
d
> >> be converted to RCU.
> >>
> >
> >I see. But, in the current, when called through the following path:
> >team_nl_send_event_options_get()->
> >team_nl_send_options_get()->
> >team_nl_fill_one_option_get()
> >, it was protected through rtnl. Does this mean that rcu should be
>
> Not true. team_nl_send_event_options_get() is sometimes called without
> rtnl (from lb_stats_refresh() for example).
>
>
> >used instead of rtnl in this case as well?
> >
> >> Why are you so obsessed by this hypothetical syzcaller bug? Are you
> >> hitting this in real? If not, please let it go. I will fix it myself
> >> when I find some spare cycles.
> >
> >Sorry for the inconvenience, but I don't want to give up on this bug
> >so easily since it is a valid bug that we have started analyzing
> >anyway and the direction of how to fix it is clear. I hope you
> >understand and I will send you a patch that uses rcu instead
>
> I don't understand, sorry. Apparently you don't have any clue what you
> are doing and only waste people time. Can't you find another toy to
> play?
>
> Please add my
> Nacked-by: Jiri Pirko <jiri@nvidia.com>
> tag to your any future attempt, as I'm sure it won't be correct.
>

I am truly sorry. I feel like I wasted people time by sending meaningless
patches repeatedly, approaching this issue recklessly. I will be more
careful in my analysis and sending emails in the future.

Regards,
Jeongjun Park

