Return-Path: <netdev+bounces-67554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2CB84402E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AD1297DC4
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89317B3CB;
	Wed, 31 Jan 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS36poGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1627AE75
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706654; cv=none; b=o/CnIsw9RdcZBZtgvQfgjhrTqcJrslEBD8MAwBBtQ3JqEU7nuJzHFC7NHSHpActSn7YGewiJbNvuZuHB6OHKZ8zVZUbEbpii+RfModjP+U9oGhToyOV6vtPDqZw+lXWPhhn9WwN8WYMBNJjf+WxFvQes8F0p6O/ck1uG25iY1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706654; c=relaxed/simple;
	bh=d9djXh8YHyVzsz+5SiwPrTgVQxpKPQjTgBSMiG9miD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEJQTszoyZvbG+x5yMRpFQnuqI+rDs84Uh9iWNG19d85SB9Hvr4rEdzstIn99Bz7Y6bPHPdIpPe03Ir89M+ocACPYrK786sR24jHoTF9FCtDaKtLpR0x+xG9Ik9WqTv6R0Urht4M70FseCWfaMiRQwCfMfCkKIv1gQjgmPRBXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS36poGg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fafced243so12060035e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706706651; x=1707311451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z63eJUVdfgj6U9DgTOj9Nxua6onnJk5BZ9w81YFRoNU=;
        b=iS36poGg7SwQFUwA9yBh1EY2Wcm9mlgTaNk5DX+MkH6uxadQofgwWGQnyrVE61VvGr
         zC7F197xozf3Fm4e9GSBWg0jWXpcf6sXQqSRvUnK2/Jzchl7Z2hLB3h80wwrbuogBOU9
         tYEkvNzcHTb24KZswQQisXVyqntD6AxO8VJbsrjqBxK6UrPiw+r9Vjj2+4tN0H95arZY
         KCbhHlaVR57vn+YVan1990kV4AYlXYRJQF4ralRb6/GZtfRqMJyV65RHtJxY+6weKE7/
         l6PncOb//lRrnAOe9XgY52I+tEzsp5vfunZ/avqnAY/0bIHUi64U6sFDK80dwy7lAWVo
         CP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706651; x=1707311451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z63eJUVdfgj6U9DgTOj9Nxua6onnJk5BZ9w81YFRoNU=;
        b=aoYlp5zPWU5wzE8wS4HzOpFFoAdI3dZgVC90uAFxREw/C31sbxwPc2I/lnbFzVOcxX
         Z8FV8Ey9yNecgv0+gOntqNe+HjlKkjgvkHQjhHzOY9myKGX+uYtKO5UKyeE+LomnM9db
         YM0ENLXLzVAisKby3+AZ0eJbmVQKBe9cMVoUzFeCruVG3jiW2Kux7WvjTfxtn+iFfSce
         VcR6L3UVwaf9tCYHeCyLleG+pSitjeTW2FX7qp7dfslTvDlDl6H62AZzNtu5uwnaJnkc
         ZYaQrZCfh/F+0Rv2f0u0iMc9ikFd5VyqFXTZ+gXoxxv/KvMdBbmw9VeZ7ldEdFLLYvDa
         eK+w==
X-Gm-Message-State: AOJu0Yzcn66cJvC11QhmME1iW0KqI3X+Fw4Sx7htHVTugISSv087lujk
	FyXDJuLnpQ13UCzsW/szrcsrsAFEl1ngS1E6EVKoWz6OcFHQc4DC
X-Google-Smtp-Source: AGHT+IHI5lJ3ZaUC/kHnExkVNW5swAto6oeg7CQXEKlBUyvkob/axCNt5Fm/9ar1Zf0nd11we9OfqA==
X-Received: by 2002:a05:600c:a384:b0:40e:a479:fed1 with SMTP id hn4-20020a05600ca38400b0040ea479fed1mr1385982wmb.7.1706706650987;
        Wed, 31 Jan 2024 05:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZaxNtDeNFnK21vACUdSHGOsGaKEK7/7wLg+/Hp4wG2i1Wf+pA3lPCCfduA+9ztlJoxwpKXPF0MwsIu9uQqWhyKiaYn9HcarBG3oMt7lwUrE8t4V3PiE1bJlnb6SGJJLK+l8faCjZbFScXlNCa7clCrdB62eNnqiA4kTJLR17rroQcu0TLjWIzhFJ6uiZpsKwwJXc6vh5EOos=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b0040d5ae2906esm1590900wmo.30.2024.01.31.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:10:50 -0800 (PST)
Date: Wed, 31 Jan 2024 15:10:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
	razor@blackwall.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: net: switchdev: Port-to-Bridge Synchronization
Message-ID: <20240131130003.bpqd23eepjlt7di7@skbuf>
References: <87fryl6l2a.fsf@waldekranz.com>
 <20240129121739.3ppum5ewok6atckz@skbuf>
 <87bk927bxl.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk927bxl.fsf@waldekranz.com>

On Tue, Jan 30, 2024 at 10:23:34PM +0100, Tobias Waldekranz wrote:
> On mån, jan 29, 2024 at 14:17, Vladimir Oltean <olteanv@gmail.com> wrote:
> > I'm thinking we could do something like this in br_switchdev_mdb_replay().
> > We could block concurrent callers to br_switchdev_mdb_notify() by
> > acquiring br->multicast_lock, so that br->mdb_list stays constant for a
> > while.
> >
> > Then, after constructing the local mdb_list, the problem is that it
> > still contains some SWITCHDEV_F_DEFER elements which are pending a call
> > switchdev_deferred_process(). But that can't run currently, so we can
> > iterate through switchdev's "deferred" list and remove them from the
> > replay list, if we figure out some sort of reliable switchdev object
> > comparison function. Then we can safely release br->multicast_lock.
> 
> That would _almost_ work, I think. But instead of purging the deferred
> items, I think we have to skip queuing the replay events in these
> cases. Otherwise we limit the scope of the notification to the
> requesting driver, when it ought to reach all registered callbacks on
> the notifier chain.
> 
> This matters if a driver wants to handle foreign group memberships the
> same way we do with FDB entries, which I want to add to DSA once this
> race has been taken care of.

Yes, not purging the deferred items (for the reasons you mention), but
as I said, "remove them from the replay list" (the local mdb_list).
Similar to what you've done in the series you just posted
(https://lore.kernel.org/netdev/20240131123544.462597-3-tobias@waldekranz.com/),
only that instead of removing from the list, what you do is you never
call list_add_tail().

> > The big problem I see is that FDB notifications don't work that way.
> > They are also deferred, but all the deferred processing is on the
> > switchdev driver side, not on the bridge side. One of the reasons is
> > that the deferred side should not need rtnl_lock() at all. I don't see
> > how this model would scale to FDB processing.
> 
> Yeah, that's where I threw in the towel as well. That issue will just
> have to go unsolved for now.

I mean I have some ideas for FDB replays as well, but they all revolve
around making the interface more similar to how MDBs are handled, while
also maintaining the rtnl-lockless behavior. It's a lot more rework,
potentially involves maintaining 2 parallel mechanisms for switchdev FDB
notifications, and very likely something to handle in net-next.

