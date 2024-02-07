Return-Path: <netdev+bounces-69897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF084CEF7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A11C20895
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C48062A;
	Wed,  7 Feb 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph/vRCT/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BE7C6C1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323780; cv=none; b=Wd3sZNS8yyfq12OGRDEjo51eF+OpLFXz95w8dRS8rwn+DUNmIsBm6s+nPZoqxd+eVzsqf67k8SQMh2j3lQDPJvLSRQ1C6OfzWXmGuBAzXfQCYJNvQ07v4bc16oX+ZRlKKnfvKPzcsJe2LMuFoBGneTVCtAxjIWe7P1tLWWfMuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323780; c=relaxed/simple;
	bh=LTvQ8UytGms4z18MJFSnrvSmLzr7jckMp1fggva1jic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/tD1uzEJWWppF7OZo3TpJj0/0YkR2uS5U0x3DnxLhlFFLc2+d57fm9vFlK+DuiUBaw1sXHvnfNZrpfWcbEBnv+0DLjFQIRAKDToxBbOnRHf1peGvQMtszYghH51oOJsFZNnfEBjiDNyxPy1il7KvXJG5MX0WQWk1kmZluz95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph/vRCT/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so115550666b.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323777; x=1707928577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nzlc7xangBB4VvsClxXEvqxKVOB7kvhjhDlYeoPuOBw=;
        b=Ph/vRCT/QXB05vXNbihfBInCK1wHelmXbcKaljkzIes2zA74VR3lOYqqX6GBySagvB
         GrPRq5dlf5SHbpCuZhknsFmsVNgH9KTNabzPn/sWkSKseJWym62yfxSnnjJpCAdtmeaI
         lQP7BaaXRWUyVYNBy28ioOkL5B9QeTa1HJCuNiR9Ul7R+O4Z6nniBQ4Myrh9KllLi++j
         OBUIIuC2qT/1AXfKqIqZh0l9S6M/r1ejhgyXIfJ39UVZo+CX+kfVKw3tO0imzJl9+zOY
         zw1JNRyqiBYrwO1WmAonNu/W80TWhE7V313txxc2PposAAkR4O468jDa5hXXN5cEc2CJ
         BT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323777; x=1707928577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzlc7xangBB4VvsClxXEvqxKVOB7kvhjhDlYeoPuOBw=;
        b=JwdIV1SS2AN3RpIH70gabMG3/9Nk1eG1xLEVbFjqiRPgb7uJVqJ8anNkdHvbOFe9rn
         6tVmXQ8YcrTcrosCdbn/HQktS25uFcx7FIYaLWsxbe/71Z5xTHGMkG46SW2DUeDpywzV
         YszHlJ3NnhoiNn42onhuff4jP148MIudvmZ5/CmANvpZhrKpPxofmZ+biVKNPNtkZTLy
         jiUDMxIriqIQLEiA0JL4lXdWuuijjb2ZNpc0EE7PQRiXgdJH5QJGLwM3rir2KSoJGfSi
         iOQgyZ94U14rNmHJWz3jT++F6sbIaoYMeFTN7WbnI6LGiQ8QteVyo6IoqZMcVAyfDglE
         liyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUvDEpcTmBy1KLsL4OrisSBE/KMBzjmGEOOTVd9N10DxoebdZqykH0Hx5bsJS3MxBxqYA8pna8zp834D9Dc0B2YxCwN0/U
X-Gm-Message-State: AOJu0YwbutrgQoItLeUlP/Wd6aPbFc6K4+aGeBQvWiu9fCWQWVooVqHY
	GdSq3QXY0LvmKPpU4rmApbeJRiPkhXocPhIceoLVHdhQHhKp61qh
X-Google-Smtp-Source: AGHT+IGPHbnQVii17iUUvbKr4b5B1HRPiP20c/L+rQDnDBhQkjo1fwDsdrK9iPc5wpXxyIp4/mE88w==
X-Received: by 2002:a17:906:5d:b0:a36:3c59:3449 with SMTP id 29-20020a170906005d00b00a363c593449mr4935585ejg.56.1707323776662;
        Wed, 07 Feb 2024 08:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPO9rzsgSb2RPo58SUzWqLSBnsDDw/xyeMSmzWFyRM6/8Cl8TUw6LTElhB3iMbez2kFhz+9rDU39no0ChhrY02CoLSH6lWEwaTH47ddFi22CbCXucUdAPcp6TUTxlTaiIs10yK+TwtFCt+RErRBR96/9YXQrOO1So+z4CB1IBAfCFxKWdal0H2QHCFMXFz/2XWOWlVwXfnFee8R+jjwicZO+ggGkmW7AMt7v94meVu4Mk1wCHAmjiTw7pRhJFKCrd8totr8QwogPdy+2VIV+7r
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a3617097f49sm925564ejc.101.2024.02.07.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:36:16 -0800 (PST)
Date: Wed, 7 Feb 2024 18:36:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240207163614.irxeoowoapglbnxj@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240205114138.uiwioqstybmzq77b@skbuf>
 <87v871skwu.fsf@waldekranz.com>
 <20240206193111.pm265ffzkmd7jbyo@skbuf>
 <87sf25s1ad.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf25s1ad.fsf@waldekranz.com>

On Tue, Feb 06, 2024 at 10:58:18PM +0100, Tobias Waldekranz wrote:
> On tis, feb 06, 2024 at 21:31, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Tue, Feb 06, 2024 at 03:54:25PM +0100, Tobias Waldekranz wrote:
> >> On mån, feb 05, 2024 at 13:41, Vladimir Oltean <olteanv@gmail.com> wrote:
> >> > On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
> >> >> Before this change, generation of the list of events MDB to replay
> >> >
> >> > s/events MDB/MDB events/
> >> >
> >> >> would race against the IGMP/MLD snooping logic, which could concurrently
> >> >
> >> > logic. This could (...)
> >> >
> >> >> enqueue events to the switchdev deferred queue, leading to duplicate
> >> >> events being sent to drivers. As a consequence of this, drivers which
> >> >> reference count memberships (at least DSA), would be left with orphan
> >> >> groups in their hardware database when the bridge was destroyed.
> >> >
> >> > Still missing the user impact description, aka "when would this be
> >> > noticed by, and actively bother an user?". Something that would justify
> >> > handling this via net.git rather than net-next.git.
> >> 
> >> Other than moving up the example to this point, what do you feel is
> >> missing? Or are you saying that you don't think this belongs on net.git?
> >
> > I just don't have enough data to be able to judge (it's missing from the
> > commit message). I'm looking at Documentation/process/stable-kernel-rules.rst
> > as a reference. It lists a series of guidelines from which I gather,
> > generally speaking, that there should exist a user impact on
> > functionality. The "mvls atu" command is a debug program, it just dumps
> > hardware tables. It is enough to point out that multicast entries leak,
> > but not what will be broken as a result of that.
> 
> Fair enough.
> 
> I originally discovered the issue while developing a kselftest for
> another improvement I want to make to switchdev multicast offloading
> (related to router ports). I thought my new code was causing these
> orphan entries, but then realized that the issue existed on a plain -net
> and -net-next kernel.
> 
> I can imagine scenarios in which a user _could_ be impacted by this, but
> they are all quite esoteric. Maybe that is an indication that I should
> just target net-next instead.

Again, I'm not discouraging you to send this patch to net.git. I've been
saying (since v1, apparently: https://lore.kernel.org/netdev/20240131135157.ddrtt4swvz5y3nbz@skbuf/)
that if there is a reason to do it, just say it in the commit message,
so that we're all on the same page.

Be verbose when calculating the cost/benefit ratio calculation
(preferably also in the commit message). I would analyze the complexity
of the change as "medium", since it does change the locking scheme to
fix an underdesigned mechanism. And the fact that mlxsw also uses
replays through a slightly different code path means something you
(probably) can't test, and potentially risky.

> >> > The race has 2 components, one comes from the fact that during replay,
> >> > we iterate using RCU, which does not halt concurrent updates, and the
> >> > other comes from the fact that the MDB addition procedure is non-atomic.
> >> > Elements are first added to the br->mdb_list, but are notified to
> >> > switchdev in a deferred context.
> >> >
> >> > Grabbing the bridge multicast spinlock only solves the first problem: it
> >> > stops new enqueues of deferred events. We also need special handling of
> >> > the pending deferred events. The idea there is that we cannot cancel
> >> > them, since that would lead to complications for other potential
> >> > listeners on the switchdev chain. And we cannot flush them either, since
> >> > that wouldn't actually help: flushing needs sleepable context, which is
> >> > incompatible with holding br->multicast_lock, and without
> >> > br->multicast_lock held, we haven't actually solved anything, since new
> >> > deferred events can still be enqueued at any time.
> >> >
> >> > So the only simple solution is to let the pending deferred events
> >> > execute (eventually), but during event replay on joining port, exclude
> >> > replaying those multicast elements which are in the bridge's multicast
> >> > list, but were not yet added through switchdev. Eventually they will be.
> >> 
> >> In my opinion, your three paragraphs above say pretty much the same
> >> thing as my single paragraph. But sure, I will try to provide more
> >> details in v4.
> >
> > It's not about word count, I'm notoriously bad at summarizing. If you
> > could still say in a single paragraph what I did in 3, it would be great.
> >
> > The difference is that the above 3 paragraphs only explore the race on
> > MDB addition events. It is of a different nature that the one on deletion.
> > Your analysis clumps them together, and the code follows suit. There is
> > code to supposedly handle the race between deferred deletion events and
> > replay on port removal, but I don't think it does.
> 
> That's the thing though: I did not lump them together, I simply did not
> think about the deletion issue at all. An issue which you yourself state
> should probably be fixed in a separate patch, presumably becuase you
> think of them as two very closely related, but ultimately separate,
> issues. Which is why I think it was needlessly harsh to say that my
> analysis of the duplicate-events-issue was too simplistic, because it
> did not address a related issue that I had not considered.

So in the comments for your v1, one of the things I told you was that
"there's one more race to deal with" on removal.
https://lore.kernel.org/netdev/20240131150642.mxcssv7l5qfiejkl@skbuf/

At the time, the idea had not crystalized in my mind either that it's
not "one more" race on removal, but that on removal it's _the only_
race.

You then submitted v2 and v3, not taking this comment into consideration,
not even to explore it. Exploring it thoroughly would have revealed that
your approach - to apply the algorithm of excluding objects from replay
if events on them are pending in switchdev - is completely unnecessary
when "adding=false".

In light of my comment and the lack of a detailed analysis on your side
on removal, it _appears_, by looking at this change, that the patch
handles a race on removal, but the code actually runs through the
algorithm that handles a race that doesn't exist, and doesn't handle the
race that _does_ exist.

My part of the fault is doing spotty review, giving ideas piecemeal, and
getting frustrated you aren't picking all of them up. It's still going
to be a really busy few weeks/months for me ahead, and there's nothing I
can do about that. I'm faced with the alternatives of either doing a
shit job reviewing and leaving comments/ideas in the little time I have,
or not reviewing at all. I'll think about my options some more.

