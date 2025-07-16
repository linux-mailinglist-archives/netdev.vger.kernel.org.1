Return-Path: <netdev+bounces-207361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A83EB06D0E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA4F7AE55F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE32701CB;
	Wed, 16 Jul 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ayQNE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864B265637;
	Wed, 16 Jul 2025 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642760; cv=none; b=V1kyLQ64koBN+3GTNeYyjjJfBaACvXNK/eToICBqHQLRCCVxMFKwu7YPIcGGGQW88q13HBmIxWATB9yFZRW+8NYQ1Jyn4fQA2Zz3wNYOQKKBUipcGa0FYYFmyKwqn8jziFJ6cEK5BGLUglAxTHhUD5LHaDrXkbdPAbyIUfTjSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642760; c=relaxed/simple;
	bh=ahY39kA4/GdhCBCf1OgJc2964cn1f3MWXDmo3UIOqKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYeFwXhdD+jUJnwxvR3H4QGz27Ao9e3c20LMZaBvZV84z47KzoG9wlsc6q+i3hpmTfnxbHk5MSFUyAqbR40oFQZOFA41v2NgHHw7kx/UCvrLU3ILEykyk0TLEAI/riDV2N6MOKDb+zfCR5M71eWe7V7rEAUPX2sggrFPiYkaNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ayQNE0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236192f8770so3392845ad.0;
        Tue, 15 Jul 2025 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752642759; x=1753247559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGq8gh8YJJj7VRgjTYum73G2tm35yu1h3rAMJLROjF8=;
        b=D8ayQNE0cC69UP+m8WgZHTlT4qCFVzff56k6HL7EpXUmQUFj7UPOUSKQGrBKxKu5k6
         Js36rv6GhyshEj/uZa+4riwMxgTYFjNJteetFo6lQanFs7ZbMMHchesoXsw7zxyquVIq
         aYmXAoZm7p/aX2kthf4zBqcmY2u/a30FJ+Y/z5lytT09engY+ZV1Gx4KNrW2jb+yPl+5
         lwO0XUYo937ZvlORbf1Io2MLcRP4IhMXOwFEiWcv/So0cT8gGAXGe7U3qNNGZwPC5PtX
         hhLpymzsqVsC6NfkpnorEYPStuAEHLo21d7xzP6CUcJcSTAoDhpaq4LHxhGRh+5D29Ck
         dKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752642759; x=1753247559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGq8gh8YJJj7VRgjTYum73G2tm35yu1h3rAMJLROjF8=;
        b=BDYM6u4j+fHEa/KHIpHGt62EW85siWBSIYndLEMGnLB9F562wLqH0TjiovszHshbr0
         bqBsrF7lp6k8ozJjV3H0YAjQuDkHDkQpJzx09UUcGX39MAj5XPyX4jHkld3xCzAdE+PO
         Q2JSC616ZTBnEBRTNjPmM33Oo065Qb5pPWRL14iSqg0eAFEnuNIfmJJFNdD2Z9Fblrpr
         RA7Sw+aO080whi7aCiUgDsyWEqM1mcJAJ657c+o/08RPc13Vx2bYM0AVnntbchXPp6mc
         NmiYG2eBDSfJKA71J72RLOvQNTFg3WguzViTqQIxCTBDYS4N7TTEOvRBw374coShVvbj
         GwQA==
X-Forwarded-Encrypted: i=1; AJvYcCUZJXWDv1HmXI0ePE/zkwBlnjfsdn2gRHau6uCK/6tBCp63u7ZdTjzqabD2uBKG6UxIFiR/DH2F@vger.kernel.org, AJvYcCV9xOMOkgWG1He9Nlbv4fz+pCVrMV1UY2QeT4rFDRjqdnMil3TStw7/3fQ49D89GpfPQy3HFdLvXR0LZVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1tZdQRkdYR7RHNLURg8HxRmkEtGt3uSnq9T2LLRaV+Qq9LoO
	Ckezvc7I6Z4oVaMlCVIq5936ht20D+LCSwbDuZCtYzFTqoQunjMThfEn655otjFRHSj1thHd9uf
	H7vkxcWpUWVtkRErxyYRAJTTancKpgUo=
X-Gm-Gg: ASbGncvZSBE/G3PywgU0+X/UqTrK6yB8cuJFd+XUIZQzfR7sIU3QhbcTYURJoNQ+JLH
	vVx+0nt48kHIQsQBtILgP7ZVl9VfEkPIsti8J6GU/Akhwv1JQA02+3Zh97eBPMLwAs0C6V7/OnN
	sPxcZfwv4IJLqwlYYX/Rv0Y0Htvo52HiRDii0B7b+XgHtfVsejpo+tXhG662IE6U3mNEaIOaN+G
	yEVxM7OjDeTBUeZNA==
X-Google-Smtp-Source: AGHT+IERLnP0cUDJM5lmJTdDDKFfNHKyZXlbGmV4mkPrTGgHja8s8AxyWFfKBX+0tgpCsAVihL4oVBlBEqJRASlo/5U=
X-Received: by 2002:a17:902:fc4d:b0:235:f059:17de with SMTP id
 d9443c01a7336-23e1a4ab102mr87062845ad.15.1752642758539; Tue, 15 Jul 2025
 22:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705145031.140571-1-aha310510@gmail.com> <20250707171118.55fc88cc@kernel.org>
In-Reply-To: <20250707171118.55fc88cc@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 16 Jul 2025 14:12:27 +0900
X-Gm-Features: Ac12FXwndjp3ARCRHwgBaow85_Xhx6Eh_EXZT8i8UvveeojiwsvEgyFJX6n1gfM
Message-ID: <CAO9qdTHdZnD5fC-V8E2JqKiM+ijOj15GRZjfwO+aAg_CUhNDnw@mail.gmail.com>
Subject: Re: [PATCH net] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat,  5 Jul 2025 23:50:31 +0900 Jeongjun Park wrote:
> > ABBA deadlock occurs in the following scenario:
> >
> >        CPU0                           CPU1
> >        ----                           ----
> >   n_vclocks_store()
> >     lock(&ptp->n_vclocks_mux) [1]
> >                                      pc_clock_adjtime()
> >                                        lock(&clk->rwsem) [2]
> >                                        ...
> >                                        ptp_clock_freerun()
> >                                          ptp_vclock_in_use()
> >                                            lock(&ptp->n_vclocks_mux) [3]
> >     ptp_clock_unregister()
> >       posix_clock_unregister()
> >         lock(&clk->rwsem) [4]
> >
> > To solve this with minimal patches, we should change ptp_clock_freerun()
> > to briefly release the read lock before calling ptp_vclock_in_use() and
> > then re-lock it when we're done.
>
> Dropping locks randomly is very rarely the correct fix.

Of course, we can change it to lock clk->rwsem before calling
ptp_clock_unregister(), but it would require a lot of code modifications,
and posix_clock_unregister() would also have to be modified, so I don't
think it's very appropriate.

That's why I suggested a way to briefly release the lock in
ptp_clock_freerun().

>
> Either way - you forgot to CC Vladimir, again.

No need to reference Vladimir, as this bug is a structural issue that has
been around since the n_vclocks feature was added, as indicated in the
Fixes tag.

> --
> pw-bot: cr

Regards,

Jeongjun Park

