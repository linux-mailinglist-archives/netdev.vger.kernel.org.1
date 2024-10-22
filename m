Return-Path: <netdev+bounces-138024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D709AB855
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37D21F22444
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E11CACDC;
	Tue, 22 Oct 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wuEssT1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF3153565
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631839; cv=none; b=tQAIzkuUI2AEYIZywHmXJOMrlWedK6hK5zoWXMtbvWBKYqbnfifYa7fMcDnnIX9nPb8lLS8IwyXH79RLcC7nyiQLAPW5qmCGMDN/Cr9dKwIYlDbsYLSceVUi3vmMT/IfUWnTnYMmGhaiTv4V9FOAnpKm0gZv213Wcr6+ZiLWYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631839; c=relaxed/simple;
	bh=QmmkDDCXAG8vH2LuvuGGchAcSn4cqJqkERl20uX75rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS40wmu48eRXyzOQfv7DeHVxM2uFdvfQwhq7Vr4fOLzLtk+EPnYYft1h1MEDfp1F0MTuopayMW3MpiLSmEY6NSDM4SZYzyKMyzxcn38ZOuP3tjCVre1B5vDl95jb72kNAB4Vo2FZS+uAztaFOOyc1stvxoNGdBfhxKcs3SkXR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wuEssT1o; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c714cd9c8so61104165ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729631837; x=1730236637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYr64/ZMrEvmz5LKiZ/kP4LINn+F8DeQPo0l+Qm0N4U=;
        b=wuEssT1oqrfJzkLVB/E8Q+Zgun1NIPx26TFjcP8bBIo1Vy9TwOtDWAIEUiOHV1cAXy
         yaXoxwRdiEvW1pFGflelRpWE7wolkumI4Ibn5uGgeJM/l3aGLWRSx2da3cJhlGG6Stg5
         o2bTDwyKhiix+ZZfxqLPp8yunyHt6Whzcofk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631837; x=1730236637;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYr64/ZMrEvmz5LKiZ/kP4LINn+F8DeQPo0l+Qm0N4U=;
        b=G5Z9y/14dytt83eNbQcsnLSqn0z7tybnU5yCoHiRwWk79HmEsIyI6BUsuRCKWAwQoq
         vrMMxeDRw2TLmZ37tuKEDWfc8RrAodHjdpQVvD7JIuw5U+P1TrMXkryNBnL1pHogKMry
         7dE35ko631Cw8u1wvItKaygBxKXCOWU7kdoyfeZQ2J5QKHLsiIicWKret2KPyJybvqHx
         rVMOT8MFCeodKGe3/1t9tszjHju1hOPu6w2ydfsvG3WyISiBSNLpgKyf1kxpWJonpdbp
         t69GLSjmyxdnIa9ryTbhUEYQB9IDq7oif4ORbrDR5oTuThHAyX5ctWPH2BrRp80quPJv
         qnUQ==
X-Gm-Message-State: AOJu0Yxjctfff8upDXiA3yD8qBc2w1TcGOZRZfxDRjmHygrPXDl5iGV1
	WWlkCOHzJFZM25stjyBGSiH2Up7IAgklp0iCe3smv6CZNx0YACdLTrRO5gbRRpU=
X-Google-Smtp-Source: AGHT+IGi6HnkolQs9gyiaf/yt0J5Hxo52WSssx+MmkAvaoJ2SCUXBOL2PutgPzSeR1QzfzbnP4nzWQ==
X-Received: by 2002:a17:902:e5c4:b0:20c:637e:b28 with SMTP id d9443c01a7336-20fa9e9f461mr5423065ad.39.1729631837337;
        Tue, 22 Oct 2024 14:17:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f363esm46806005ad.269.2024.10.22.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:17:16 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:17:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, dmantipov@yandex.ru,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [RFC iwl-net] e1000: Hold RTNL when e1000_down
 can be called
Message-ID: <ZxgWWgJKx4h0Thfe@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	dmantipov@yandex.ru, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241022172153.217890-1-jdamato@fastly.com>
 <ZxgEb0N0cJt1BRte@LQ3V64L9R2>
 <ZxgVRX7Ne-lTjwiJ@LQ3V64L9R2>
 <270a914d-3b50-4eee-b564-1b8cff82facc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270a914d-3b50-4eee-b564-1b8cff82facc@intel.com>

On Tue, Oct 22, 2024 at 02:15:27PM -0700, Jacob Keller wrote:
> 
> 
> On 10/22/2024 2:12 PM, Joe Damato wrote:
> > On Tue, Oct 22, 2024 at 01:00:47PM -0700, Joe Damato wrote:
> >> On Tue, Oct 22, 2024 at 05:21:53PM +0000, Joe Damato wrote:
> >>> e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.
> >>>
> >>> There are a few paths for e1000_down to be called in e1000 where RTNL is
> >>> not currently being held:
> >>>   - e1000_shutdown (pci shutdown)
> >>>   - e1000_suspend (power management)
> >>>   - e1000_reinit_locked (via e1000_reset_task delayed work)
> >>>
> >>> Hold RTNL in two places to fix this issue:
> >>>   - e1000_reset_task
> >>>   - __e1000_shutdown (which is called from both e1000_shutdown and
> >>>     e1000_suspend).
> >>
> >> It looks like there's one other spot I missed:
> >>
> >> e1000_io_error_detected (pci error handler) which should also hold
> >> rtnl_lock:
> >>
> >> +       if (netif_running(netdev)) {
> >> +               rtnl_lock();
> >>                 e1000_down(adapter);
> >> +               rtnl_unlock();
> >> +       }
> >>
> >> I can send that update in the v2, but I'll wait to see if Intel has suggestions
> >> on the below.
> >>  
> >>> The other paths which call e1000_down seemingly hold RTNL and are OK:
> >>>   - e1000_close (ndo_stop)
> >>>   - e1000_change_mtu (ndo_change_mtu)
> >>>
> >>> I'm submitting this is as an RFC because:
> >>>   - the e1000_reinit_locked issue appears very similar to commit
> >>>     21f857f0321d ("e1000e: add rtnl_lock() to e1000_reset_task"), which
> >>>     fixes a similar issue in e1000e
> >>>
> >>> however
> >>>
> >>>   - adding rtnl to e1000_reinit_locked seemingly conflicts with an
> >>>     earlier e1000 commit b2f963bfaeba ("e1000: fix lockdep warning in
> >>>     e1000_reset_task").
> >>>
> >>> Hopefully Intel can weigh in and shed some light on the correct way to
> >>> go.
> > 
> > Regarding the above locations where rtnl_lock may need to be held,
> > comparing to other intel drivers:
> > 
> >   - e1000_reset_task: it appears that igc, igb, and e100e all hold
> >     rtnl_lock in their reset_task functions, so I think adding an
> >     rtnl_lock / rtnl_unlock to e1000_reset_task should be OK,
> >     despite the existence of commit b2f963bfaeba ("e1000: fix
> >     lockdep warning in e1000_reset_task").
> > 
> >   - e1000_io_error_detected:
> >       - e1000e temporarily obtains and drops rtnl in
> >         e1000e_pm_freeze
> >       - ixgbe holds rtnl in the same path (toward the bottom of
> >         ixgbe_io_error_detected)
> >       - igb does NOT hold rtnl in this path (as far as I can tell)
> >       - it was suggested in another thread to hold rtnl in this path
> >         for igc [1].
> >        
> >      Given that it will be added to igc and is held in this same
> >      path in e1000e and ixgbe, I think it is safe to add it for
> >      e1000, as well.
> > 
> >  - e1000_shutdown: 
> >    - igb holds rtnl in the same path,
> >    - e1000e temporarily holds it in this path (via
> >      e1000e_pm_freeze)
> >    - ixgbe holds rtnl in the same path
> > 
> > So based on the recommendation for igc [1], and the precedent set in
> > the other Intel drivers in most cases (except igb and the io_error
> > path), I think adding rtnl to all 3 locations described above is
> > correct.
> > 
> > Please let me know if you all agree. Thanks for reviewing this.
> > 
> > 
> [1]:
> https://lore.kernel.org/netdev/40242f59-139a-4b45-8949-1210039f881b@intel.com/
> 
> I agree with this assessment.

Thanks for taking a look. I will send an official iwl-net PATCH with
these changes once the 24 hour timer has expired.

