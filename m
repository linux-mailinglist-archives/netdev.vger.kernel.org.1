Return-Path: <netdev+bounces-224576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95276B864CD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C79B6014F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D631E880;
	Thu, 18 Sep 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP/RZYwM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79C31C564
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217236; cv=none; b=PwysLNiBOIV5YU9ArSVi6nMoXPzpB9xjB4vQ89+lqokgM6PWpauwUixRqk3V0jUvQMwZCK2ZQ+tbc5fDW/JeYGijUN8mC1Rc96On2uMX07Rff7da52LiwgtoZ8Vf/NKcJC4bZbT2teL8JJACjJUGChTownYvWFzag40vmOcWFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217236; c=relaxed/simple;
	bh=PAJGdxzVh+hSxDOx5VKS60t2Dt2GkMypMDcKSqxK0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCJ8rzJ4YtVcA6in2L/i8Cmt4l5ZQJ0FIW96LJTKkwtSqoNaZ7nyQj3zBwnK7jc0F32KmAldDOaKezNsafNy4pq/iY6CKpaayLMQkK7xfUNtwHNpoIPtWP2r7vj15HVbskwcBynjwfOtbCFYSBqv9fU+bdGHTE8Zp2vDVZAVWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP/RZYwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758217233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
	b=UP/RZYwM+LUN+9Ji8r6IBL1lsjeNvdQst7HVikKRnBqGpvWIsiASg8sYh+9zknMq4+Ywi7
	DruTl9tPYE6JLLqTxaPUAErII6ch61EYN3vH/Pf81co2Ms0M8YimF60Shr0tPKvn+xu+wC
	17q2qIdSn9kjgs/GkIPTRTNKUQLz93w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-gdq_dqUeOgqbugTY2g4XkQ-1; Thu, 18 Sep 2025 13:40:30 -0400
X-MC-Unique: gdq_dqUeOgqbugTY2g4XkQ-1
X-Mimecast-MFC-AGG-ID: gdq_dqUeOgqbugTY2g4XkQ_1758217229
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso8620105e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217229; x=1758822029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
        b=A5yiwvCCT/nBpfNVV6p1RGAmTRZ56T44+zNG4PXjELdNS5gVESDD2bHUn0imAho9DT
         gUUw+z2eadoWosDEvXs9j3b6Ig9tGcl7ka7uwwmOza5wMg9c57o7lNHTLhWrmUcjsyET
         c+g/lw5lMJgESCvFTxRnivvw0bfmgKd5iT1kBJZDd/sWqc9ICJlQTH9FXINMlX9XdJRF
         re1pQddlLHCngUkP/nw8ik5bkrM6enOFhveGlEYi2QXHc3DOltUj6qhZcpWSKYydKQXz
         hSP0uahBzrQlFNP9+c6s/Uj/P/YwrtQm5tEllAjLkUNr31nyc1MxEEbe2tqO2yMwf70x
         xF7A==
X-Forwarded-Encrypted: i=1; AJvYcCVPnKZo/0OVBMKqncUQeAyj5O/TlDFJ98SE50v1jTQKU1Vc9LrkR/eVR+KqrnI8gw5qXIGS7ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSi4aH+KS9nFCFzk1gAMToMqI1QZ3R7ZYFsyZ6mkAcCqoyrfa
	rGYsFhFehfR0bGd5tLrSIhV2fCFfrltXKTsCn5ymW8fzn8EJVBS/DVxYw1u1XBx9yabDRTGJ88K
	TBnSJ6my+Oj1uf2WBtCO/eXpfovwOBhT/OEv42eC3P6gDeLLxv/3LJoWANA==
X-Gm-Gg: ASbGncvwI20WTsWM6l21MLrg3HaOz2GXC3cq3qJtkqgKyDlOXvQTgaYQdEoIcrOLPfL
	SJMqDrmyMCkBfDeWl6pi/aJLDEJ7m4w3+KwhZZ++8sKONMKxdSJydXfOtPrRVgnRUIMIkOVYDJk
	HxDWCmHOYs+S3qm3QvJeV+RGL2XbneDVZsq6TDWNFWLU5ynWeMNchs/ythv+WYejn8Jfqcstvyc
	liXezWd7dOPZBcJiYNrHfpgLoL/Oz0NyxBoZD65Tlhpn8pAbspg+3xn3c/stq4RPeBCx8SYoqlA
	rofKx6m+HZhrPaLJ4MPLiL40WRmF7BZYrCc=
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763675e9.16.1758217228728;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOoCiSMZx3r6ahJEsPst7vmWcAL9LRHA1I1NtHk23nXFndZVGSronTsEuZNCUr5eL1KdExGQ==
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763425e9.16.1758217228248;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e93dd85sm103570545e9.22.2025.09.18.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:40:27 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:40:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918133938-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
 <20250918120658-mutt-send-email-mst@kernel.org>
 <aMw4wx5ENt-odhYS@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw4wx5ENt-odhYS@google.com>

On Thu, Sep 18, 2025 at 09:52:19AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> > On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> > > On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > > > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > > > So how about switching to this approach then?
> > > > > Instead of piling up fixes like we seem to do now ...
> > > 
> > > I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> > > I think there are three options for 6.17, in order of "least like to break
> > > something":
> > > 
> > >  1. Sebastian's get_task_struct() fix
> > 
> > 
> > I am just a bit apprehensive that we don't create a situation
> > where we leak the task struct somehow, given the limited
> > testing time. Can you help me get convinced that risk is 0?
> 
> I doubt it, I share same similar concerns about lack of testing.  So I guess
> thinking about this again, #2 is probably safer since it'd only impact KVM?

I can't say I understand completely how we get that state though?
Why did the warning trigger if it's not a UAF?

> > >  2. This series, without the KILLED sanity check in __vhost_task_wake()
> > >  3. This series, with my fixup (with which syzbot was happy)


