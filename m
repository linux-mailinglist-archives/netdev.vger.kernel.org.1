Return-Path: <netdev+bounces-194421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BFAC9631
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E230AA22782
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB56281520;
	Fri, 30 May 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="w9k/DXk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A822820A3
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634319; cv=none; b=Dj+fTpPsMxD2XHV7iwyPC9q+SSmJSldZ+AWJdpPH2Hnwj5Q53pDeERS498y892AtsOrN0prPJtvec0wt0RLOIk9lWfjCqtqsK8QYnh6opnx7JjQ/1VoursaI3Y0qPHDWi3SEHeRd+pkjScAMNDGAoYVI1Xeu+p46Kz5i0l99+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634319; c=relaxed/simple;
	bh=EeaHwLJP1b7aP+52eOMG2kzLLIkpJvV79sAdphPmorA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3q1JIQl88K/pj3z00US+lo9YEnkmIO0GWKfZgPuKtZf0+joqa6mQ8Wnk0IturPvyjh3MUKKl3CO0BrN2IIL5EnEPG9jNWu2D9zTmNdqCC1gl7kw7MTFDSyER7nbVO7jdFbv7ybGrJRqa/yjh4e5BHSqGqqWgmu8LyDXzMx7wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=w9k/DXk8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e09f57ed4so32163895ad.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748634317; x=1749239117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lb9gK19lVJostbWgjUDtmKKqX07Lhy5W7Dpk4jXPzU=;
        b=w9k/DXk8vhEH9jbsDTSchcwbOWLXEUOympSaBegMXXmm2u/pzD8CsXjnwLIKDmiVWH
         aMXTv516zXtDK0mwxU7phZdzIuYJ6K99eTLAVy+xByKQfy/wcDoBnuMaD7Qt+k2WR0RE
         7TkKT1JmiqDGKhIllzYw++xg5NIhjqjJ5zsck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748634317; x=1749239117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lb9gK19lVJostbWgjUDtmKKqX07Lhy5W7Dpk4jXPzU=;
        b=gKhVmBCicym9WqYfoNlVtdgCzt3b7fj9SUoEdCzSKep2JrDIn5hKcPgkF0/78Qdter
         fgXl1Pb/NvkdPcGfIqr+OgX9eMg0l12AuSKEEl4cdn/J3zO225yYhlV4a1abxmrFKUlm
         RGj0Sx6BEI03FRvV/BdFAXAvibu3zJefx7DDmeonGYp4nen08wGp2g7WUa1P8NjTOHtv
         lMN3Dw9nDaDYl/TUiB7wUjKbcA4NnO0rZD8g0/dHzFu4wz2iKCh4Gb41a6LDIHIqCmyc
         cwFCcHIUbjQtg4ThFCxGm5TJaLNS7XZrn1Lh6OvI/fMnsqtR7cK0HNkCzmGmLkao10P3
         n6Xg==
X-Gm-Message-State: AOJu0YwCEVVh7o0NWwPAc1dfqkwXIxJF1W1Jr3nDciX9LIClUOqxIVt0
	67apwJOh6nAuE42u0wlf3o+SsbAkyPbMKlSod9bEtYExXdaD0QpoM5MMyBejOtA9AQg=
X-Gm-Gg: ASbGnctQuvPTaJrGmeFSLE8Tvq/UCxMuTeUYYimHga7rDp7kYEd5cGPvsaVg1Ih/+0y
	YkB86D/mAHu7AWyWSGYgplCsOC0aMrtHGJ94twnmENe5yeR1kS9OF2NiL3HsMZlQTMsj9LKKTpv
	QbBMiQQ3qvw5u2/J3QojpNDGjtF4VbHk+gyet219W8aNfiqKpwlMqQqFnAsvLWcMvV5kZ8YD+sg
	nUK0SEqYbmAuZupL+mztY8cfCCwi6h2klLvQkmzzV5mGHVPbim2f6Cjgq3BhN0WCVhcaIOKp196
	JE0I3thHIUINLkn8/+ZTsljWUNQODWx1CtssUAtMhpAja+QrXs3tDN8E7WP+fpzyQuhGWHK2oJh
	PW3QSXgr1mZheHp0rTBHUBFOYIv5Y
X-Google-Smtp-Source: AGHT+IHYTayKgzes3pjEfxOEGOjuYQP5EzWW8jYaSd2BCsF4cWtCCGGULvjBHzBwuqDa1X7eSLYeOw==
X-Received: by 2002:a17:903:1a68:b0:234:6b1f:6356 with SMTP id d9443c01a7336-234f6a1eab0mr135626485ad.22.1748634316752;
        Fri, 30 May 2025 12:45:16 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd7602sm32040845ad.109.2025.05.30.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 12:45:16 -0700 (PDT)
Date: Fri, 30 May 2025 12:45:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, john.cs.hey@gmail.com,
	jacob.e.keller@intel.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] e1000: Move cancel_work_sync to avoid deadlock
Message-ID: <aDoKyVE7_hVENi4O@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, john.cs.hey@gmail.com, jacob.e.keller@intel.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250530014949.215112-1-jdamato@fastly.com>
 <aDnJsSb-DNBJPNUM@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDnJsSb-DNBJPNUM@mini-arch>

On Fri, May 30, 2025 at 08:07:29AM -0700, Stanislav Fomichev wrote:
> On 05/30, Joe Damato wrote:
> > Previously, e1000_down called cancel_work_sync for the e1000 reset task
> > (via e1000_down_and_stop), which takes RTNL.
> > 
> > As reported by users and syzbot, a deadlock is possible due to lock
> > inversion in the following scenario:
> > 
> > CPU 0:
> >   - RTNL is held
> >   - e1000_close
> >   - e1000_down
> >   - cancel_work_sync (takes the work queue mutex)
> >   - e1000_reset_task
> > 
> > CPU 1:
> >   - process_one_work (takes the work queue mutex)
> >   - e1000_reset_task (takes RTNL)
> 
> nit: as Jakub mentioned in another thread, it seems more about the
> flush_work waiting for the reset_task to complete rather than
> wq mutexes (which are fake)?

Hm, I probably misunderstood something. Also, not sure what you
meant by the wq mutexes being fake?

My understanding (which is prob wrong) from the syzbot and user
report was that the order of wq mutex and rtnl are inverted in the
two paths, which can cause a deadlock if both paths run.

In the case you describe below, wouldn't cpu0's __flush_work
eventually finish, releasing RTNL, and allowing CPU 1 to proceed? It
seemed to me that the only way for deadlock to happen was with the
inversion described above -- but I'm probably missing something.
 
> CPU 0:
>   - RTNL is held
>   - e1000_close
>   - e1000_down
>   - cancel_work_sync
>   - __flush_work
>   - <wait here for the reset_task to finish>
> 
> CPU 1:
>   - process_one_work
>   - e1000_reset_task (takes RTNL)
>   - <but cpu 0 already holds rtnl>
> 
> The fix looks good!

Thanks for taking a look.

> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

