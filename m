Return-Path: <netdev+bounces-69624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE284BE21
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3802028B1DB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD8175AA;
	Tue,  6 Feb 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJojyx7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2E171CE
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247878; cv=none; b=J8HPRoPk29Avdgy9VUiEY6q4b/fKsbzXXODHl8X8on48ge2vcWDMo00bR4cjk2ActNDW0sxzqIf3XdlWUS7KTVIWVWyHxBB8fUk1l8DOHYu4MxtA8heUfEyMSKrwAxlg8+rpO3irJ8kr5Oz/taIjW3foPQzssazVsVDlYCYgB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247878; c=relaxed/simple;
	bh=RLD9SF/xK2+/t4JQNjPUmX9kpzc8NNEzIz/4ydwoMBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b20XKF4zGgPHbV10P6C0+EuBDCHMLtKOPaamN+WEUsJG690oqXsjHjy7lECwHeJRyvnepWmhte8HpQHDcaMgDE6+jk2+UolevWq3RPtQoC6737ywQkNoeJe6E4n6Enu1Vlptd9jxwRh/BY0/fS4GaFtg6LIPhjXPBVERwrBXkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJojyx7m; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511413e52d4so4293799e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707247875; x=1707852675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1JV4T6ZQOp9MfCMuXE7oyM9YwxELoXT4mIbuZJenh4=;
        b=TJojyx7mAGFgZUpne31wM0R/Dncvv36xpGKCpDhb/5dApDZW8ko48rYb+szn7DXntW
         Eq+TxS2+Wyu7RVhQt1Cu0FDGyZ5iRF72aTUKtbO0Oa9ETBl63Io3S4VEUe4DOwAsuxOk
         5uVhNvQcwiRlxNXwPxIcc3VqhxPb6Jyf42wWAalCN35UaPS29pA2aZTf4J8q5vs6HJJW
         pOOQOoRqGPmREMBzUEcQQs2FgMFZdQpXuIGCSg1cb8uUR9pWeH/W/WlLLsEx/HWWQlag
         UW1/q5aTuDFGfPvRsijbf5tbp2TyLa7zrbQCx8yygTY+Cu14Ub+QSiedA5EvZQv4Zc09
         fJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247875; x=1707852675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1JV4T6ZQOp9MfCMuXE7oyM9YwxELoXT4mIbuZJenh4=;
        b=IG4wr22bYPqjBLKRihlsmVlq1+4bmrqpVIN+g3BxtfLzKpDZtQXNeDv6oXhRXl5QKr
         5xpdiBLqbRYMjyqD1KiXaMjmsj5xubcqxf7CmDqf2D8hw/rdEGCOj8vhTSPtuJCEWWja
         1Y4au/n2Q2Yf7bkQHy/HtJ/NhyUGcu3211sRRpL/zPExA5mUmpwVaAfkK2KXrg2lDnu7
         cM122vGvKuV6pkdXS7l0bFgA5F3tynWmzIw3FftpJTWbpJhHtM68bttGE/QFRSXbib7p
         +14JPk1UGCubPsuFmwOJRMNLTM9oUSDw/YQ1hqeNw8HhdlBTkwVzBH1drPSjIOZ8wZ6l
         y5hg==
X-Gm-Message-State: AOJu0YzPDMowpnSMff1gqOt1jVHjjAvPG+ArYVmMhGS0Ffd0nvNffb0m
	6B7KnnJWfxlHvw0xNnKreFJXEYWokP3qSNHldZlsmJAXlUWP4t2kiONJIwao4UvzRw==
X-Google-Smtp-Source: AGHT+IFNy2u3t+0UEyEOqR+3km5J1v2mu8CWSwaK6P3ztrOpcifAOECAP3QxLC2EYj36dvt2mzvmKg==
X-Received: by 2002:a19:6511:0:b0:511:4da9:ee7d with SMTP id z17-20020a196511000000b005114da9ee7dmr2411724lfb.14.1707247874374;
        Tue, 06 Feb 2024 11:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAz1+XxZ5xrtpKCTWpn230UvPrVaVt1eAJMMK7MjOXdj3EjcM3NoKa9LsM5PfIOmZ2o+0QHSviiuMQ5NtnRR0aP4nxKBmTgz5pF6tspiddEJtHnCpATXwU4J9mN+c704V+8+f7sSrMgpY9ZW/mSA08Wmx6e1tK4QvDX1AtwIPC8MdECPoHxaeJf69jeq1g/ac3nT4I1Cntw6q28MptiUljJMiVqXaPBaDL2C8IoHbxFkV1rpAh2Z8UBM0DUxMSRx99CrPNH8M/E79nob2xx9yy
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id l7-20020a056402344700b0055f4d7ceafasm1320286edc.19.2024.02.06.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 11:31:14 -0800 (PST)
Date: Tue, 6 Feb 2024 21:31:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240206193111.pm265ffzkmd7jbyo@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240205114138.uiwioqstybmzq77b@skbuf>
 <87v871skwu.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v871skwu.fsf@waldekranz.com>

On Tue, Feb 06, 2024 at 03:54:25PM +0100, Tobias Waldekranz wrote:
> On mån, feb 05, 2024 at 13:41, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
> >> Before this change, generation of the list of events MDB to replay
> >
> > s/events MDB/MDB events/
> >
> >> would race against the IGMP/MLD snooping logic, which could concurrently
> >
> > logic. This could (...)
> >
> >> enqueue events to the switchdev deferred queue, leading to duplicate
> >> events being sent to drivers. As a consequence of this, drivers which
> >> reference count memberships (at least DSA), would be left with orphan
> >> groups in their hardware database when the bridge was destroyed.
> >
> > Still missing the user impact description, aka "when would this be
> > noticed by, and actively bother an user?". Something that would justify
> > handling this via net.git rather than net-next.git.
> 
> Other than moving up the example to this point, what do you feel is
> missing? Or are you saying that you don't think this belongs on net.git?

I just don't have enough data to be able to judge (it's missing from the
commit message). I'm looking at Documentation/process/stable-kernel-rules.rst
as a reference. It lists a series of guidelines from which I gather,
generally speaking, that there should exist a user impact on
functionality. The "mvls atu" command is a debug program, it just dumps
hardware tables. It is enough to point out that multicast entries leak,
but not what will be broken as a result of that.

> >> Avoid this by grabbing the write-side lock of the MDB while generating
> >> the replay list, making sure that no deferred version of a replay
> >> event is already enqueued to the switchdev deferred queue, before
> >> adding it to the replay list.
> >
> > The description of the solution is actually not very satisfactory to me.
> > I would have liked to see a more thorough analysis.
> 
> Sorry to disappoint.
> 
> > The race has 2 components, one comes from the fact that during replay,
> > we iterate using RCU, which does not halt concurrent updates, and the
> > other comes from the fact that the MDB addition procedure is non-atomic.
> > Elements are first added to the br->mdb_list, but are notified to
> > switchdev in a deferred context.
> >
> > Grabbing the bridge multicast spinlock only solves the first problem: it
> > stops new enqueues of deferred events. We also need special handling of
> > the pending deferred events. The idea there is that we cannot cancel
> > them, since that would lead to complications for other potential
> > listeners on the switchdev chain. And we cannot flush them either, since
> > that wouldn't actually help: flushing needs sleepable context, which is
> > incompatible with holding br->multicast_lock, and without
> > br->multicast_lock held, we haven't actually solved anything, since new
> > deferred events can still be enqueued at any time.
> >
> > So the only simple solution is to let the pending deferred events
> > execute (eventually), but during event replay on joining port, exclude
> > replaying those multicast elements which are in the bridge's multicast
> > list, but were not yet added through switchdev. Eventually they will be.
> 
> In my opinion, your three paragraphs above say pretty much the same
> thing as my single paragraph. But sure, I will try to provide more
> details in v4.

It's not about word count, I'm notoriously bad at summarizing. If you
could still say in a single paragraph what I did in 3, it would be great.

The difference is that the above 3 paragraphs only explore the race on
MDB addition events. It is of a different nature that the one on deletion.
Your analysis clumps them together, and the code follows suit. There is
code to supposedly handle the race between deferred deletion events and
replay on port removal, but I don't think it does.

> > (side note: the handling code for excluding replays on pending event
> > deletion seems to not actually help, because)
> >
> > Event replays on a switchdev port leaving the bridge are also
> > problematic, but in a different way. The deletion procedure is also
> > non-atomic, they are first removed from br->mdb_list then the switchdev
> > notification is deferred. So, the replay procedure cannot enter a
> > condition where it replays the deletion twice. But, there is no
> > switchdev_deferred_process() call when the switchdev port unoffloads an
> > intermediary LAG bridge port, and this can lead to the situation where
> > neither the replay, nor the deferred switchdev object, trickle down to a
> > call in the switchdev driver. So for event deletion, we need to force a
> > synchronous call to switchdev_deferred_process().
> 
> Good catch!
> 
> What does this mean for v4? Is this still one logical change that
> ensures that MDB events are always delivered exactly once, or a series
> where one patch fixes the duplicates and one ensures that no events
> are missed?

I'm not saying I know how you can satisfy everyone's review requests.
Once it is clear that deferred additions and deferred removals need
separate treatment, it would probably be preferable to treat them in
separate patches.

> > See how the analysis in the commit message changes the patch?
> 
> Suddenly the novice was enlightened.

This, to me, reads like unnecessary sarcasm.

I just mean that I don't think you spent enough time to explore the
problem space in the commit message. It is a very important element of
a patch, because it is very rare for someone to solve a problem which
is not even formulated. I actually tried to be helpful by pointing out
where things might not work out. I'm sorry if it did not appear that way.

