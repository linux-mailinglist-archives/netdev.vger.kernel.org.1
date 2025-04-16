Return-Path: <netdev+bounces-183371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53CA9083C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4958444AE0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B22080F6;
	Wed, 16 Apr 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="G+1qwj+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06A2045B7
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819463; cv=none; b=SJ7S46EDYQM0fKaFJhGvryVLMLDdmsh7m5LvjJPKCo/ouv3jvhjuTgB/FHYXLHYiusHzPZ6bUjwuhzwOplUPMi0x5p3NqwUELyDSXGVjHnB9GL1YYZn1XEpUOjt5J8lzYh9EiOYOuGSn8RfFKyfhI1phDzTJT40/hK1tlXsI9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819463; c=relaxed/simple;
	bh=AyZFMadPI/Z+Z7dlFpNs8FHsLclQZSkIQL3vUPmb7KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oScWqiPVt7A0IDnar0mve6taBjSNi0Du6z+hDeok/llrzfrYhSHebkVpk2E8+hd9zP/yMBU627GldVx6fmZp6qONOinKTBrX+c9r6OAAsOgmwFfaWutOF6t/O/jjH2j5DQaoautU6XLHkj7M40A4CO4MbfaKDCZ167MpJ5ZNKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=G+1qwj+C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso13766350a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1744819459; x=1745424259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYV2YfoZxV6cmlZYG1eaRjyp1P5MIDzBdiE9loxsevs=;
        b=G+1qwj+C917LxML8vGCcHyV+v1QgByS3Tl2CX3HoXiww0VOeKP4mSXycUHxVQb4hug
         JDS0Ze9Gi1M25QzfHm0x/m4WmQ9dOZuFH1rAYmU1y1jJd7z7b9lN4EId3ZaSiHUByyXw
         1GmLriqPCrbAxBwv8HoRupjBvQk4jPLLnKtoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819459; x=1745424259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYV2YfoZxV6cmlZYG1eaRjyp1P5MIDzBdiE9loxsevs=;
        b=jaF63bI88uf8QPpD58QhOo6lIyFplE4ikcCGUFwE3xPqlWFcM9KPuYrPsMvkNJd5Cu
         HY9rv3trnl9z+dNvbqwJs7o6RkoeqYx2haYzBmdgq4zcuOS2ffXVAz01xtBMDchdBubJ
         5lK/7FCxzG6YokZO97vM4nH0AAUGAn2GaJubWxZpVDUq/6VXZlaAim9A0aW1cUKswBBd
         Vs+QImA31xks4M6rYCig/4rj33D2c/Lw26PVH5oqSbQ35VwEX+J2wMohJHPloy7Lq5Bb
         q9pZqQePQmE7kzFuZmWnAqrC//oKtr4w25crdVYjrAv4GItKr11CLnS3FpS9nmAdLOnn
         ufHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdn9AtaiBYHeyXxWcFtopQItiNVI2JxzDCMsKMZDJ80DZY+3PRkDAPNJljIJfiqM58C2cMNMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9ZqjSyRtOhOJ07BQMPg4t41IqRJ+h8eQoi6IfHY0pT+dfpie
	swx01sL/3EFRs0ZwbAkLwfc19RzotzIsNfGDQd8tOlKdFKpjx7J4VvwEyZC7YMXa3z8EALyMsA+
	xP5Mlhq92l/uPtL6WBfnk7xdfm3lMabVD6OxE
X-Gm-Gg: ASbGncu0ocUim81vK7lLMHiXIhTAWl/gjmFjIzdypFjM9AVM04cQklAeqQmxycPb85P
	zUjrWQHnheYwjLkhgN6gphvxFfLcTRu8OCEUWcW+3dlYlo4+jPAgYByH1mwSCUijGEs5xz1LCl6
	IX6Sbb1Dh8vtz90xSaFt9KUR0=
X-Google-Smtp-Source: AGHT+IGncNZvmh1zggR2ZA5SYcwXb/6jZ7bilseZP7TepYPQc+1RvP/za9Wavn8V2PX769uLjcKWc6BbJXunJuVgov0=
X-Received: by 2002:a17:907:9689:b0:aca:a539:be04 with SMTP id
 a640c23a62f3a-acb42869efdmr267496166b.4.1744819459018; Wed, 16 Apr 2025
 09:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com> <20250415175359.3c6117c9@kernel.org>
 <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com> <20250416064852.39fd4b8f@kernel.org>
In-Reply-To: <20250416064852.39fd4b8f@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 16 Apr 2025 18:03:52 +0200
X-Gm-Features: ATxdqUFIO7SEg8KIulZBKOWrb3zZAW3bG1D6EzHU7dm30dFH8OsgyiorAAvSh6Y
Message-ID: <CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
Subject: Re: Increased memory usage on NUMA nodes with ICE driver after
 upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, jdamato@fastly.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Eric Dumazet <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, 16 Apr 2025 09:13:23 +0200 Jaroslav Pulchart wrote:
> > By "traced" I mean using the kernel and checking memory situation on
> > numa nodes with and without production load.  Numa nodes, with X810
> > NIC, showing a quite less available memory with default queue length
> > (num of all cpus) and it needs to be lowered to 1-2 (for unused
> > interfaces) and up-to-count of numa node cores on used interfaces to
> > make the memory allocation reasonable and server avoiding "kswapd"...
> >
> > See "MemFree" on numa 0 + 1 on different/smaller but utilized (running
> > VMs + using network) host server with 8 numa nodes (32GB RAM each, 28G
> > in Hugepase for VMs and 4GB for host os):
>
> FWIW you can also try the tools/net/ynl/samples/page-pool
> application, not sure if Intel NICs init page pools appropriately
> but this will show you exactly how much memory is sitting on Rx rings
> of the driver (and in net socket buffers).

I'm not familiar with the page-pool tool, I try to build it, run it
and nothing is shown. Any hint/menual how to use it?

>
> > 6.13.y vanilla (lot of kswapd0 in background):
> >     NUMA nodes:     0       1       2       3       4       5       6       7
> >     HPTotalGiB:     28      28      28      28      28      28      28      28
> >     HPFreeGiB:      0       0       0       0       0       0       0       0
> >     MemTotal:       32220   32701   32701   32686   32701   32701
> > 32701   32696
> >     MemFree:        274     254     1327    1928    1949    2683    2624    2769
> > 6.13.y + Revert (no memory issues at all):
> >     NUMA nodes: 0 1 2 3 4 5 6 7
> >     HPTotalGiB: 28 28 28 28 28 28 28 28
> >     HPFreeGiB: 0 0 0 0 0 0 0 0
> >     MemTotal: 32220 32701 32701 32686 32701 32701 32701 32696
> >     MemFree: 2213 2438 3402 3108 2846 2672 2592 3063
> >
> > We need to lower the queue on all X810 interfaces from default (64 in
> > this case), to ensure we have memory available for host OS services.
> >     ethtool -L em2 combined 1
> >     ethtool -L p3p2 combined 1
> >     ethtool -L em1 combined 6
> >     ethtool -L p3p1 combined 6
> > This trick "does not work" without the revert.
>
> And you're reverting just and exactly 492a044508ad13 ?
> The memory for persistent config is allocated in alloc_netdev_mqs()
> unconditionally. I'm lost as to how this commit could make any
> difference :(

Yes, reverted the 492a044508ad13.

