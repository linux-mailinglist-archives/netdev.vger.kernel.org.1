Return-Path: <netdev+bounces-141637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F79BBD85
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D71F22A93
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50271CB9F4;
	Mon,  4 Nov 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pRrGCkFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E31CACE5
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746275; cv=none; b=I7UU4GnUPbq++vlgU0KL3RZmpfgQH/TaNb8mr/yqwSlycvCJW1qqSnkMP4BuOx0jGoQD2A4JnQLWooVbDSLNyjAdybeX8k6aMLBLtA2mMmPnP6k6xlHFVpm0m9q8C7eWNAZiPEM1yWdkANuZbrXSqpxIb/qMVbDblEgXg36DIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746275; c=relaxed/simple;
	bh=i+JUo1WbG9fBZEzMBxei4ZEoysCHsSLRrRJGVjEMQvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwqUIt3kBUTTG3nnuutt56u4xstuCB1s5BYExDyveWlAkPbK+7qla8tig0sZ0Ds6R7TVBRRkxqjr1x3r42dmxEA+bBHode3tqv98LtLW+q1Oc+FgxJ1VHlda8Rl4H2JSdSDsa5kKEV29dq4O+3earl6dvxl+NLBKYWJSphaZh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pRrGCkFq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so3807490a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730746273; x=1731351073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWJfwtCH7EJrpJfmQrqLh3OrqN5mIv7D0ga+Lf0aVEw=;
        b=pRrGCkFqAdHpzg8NHknffTNpV2qViVALW5mBF4+6xzYj6yapNvbo8XsJMkp8F5R8Zr
         3cnNpWu77qX+lElwFvfChOMITdq/tjtzWFqDk5jZGT8OhraXJ6ha2XeAfJLyX5TMMs0j
         jAOtjK30OCmBaLD1BGsQOLvmss/C60dPMvfeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746273; x=1731351073;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWJfwtCH7EJrpJfmQrqLh3OrqN5mIv7D0ga+Lf0aVEw=;
        b=GL9wz62ax6WlJvTj8zLdl7q8Kn8D+1TErfXQe/zCWOzA9H+VSkVeo2W2u6Slyw4axn
         N3fb8HCUrZrOEaFpIRO368a59+i7khqy+6LPj2syavXwHvfGkLr4t9TluKsd4NYnOma+
         28J/RzMQsMcRt6G5yY5W1ZENuoQo2a5d1aeUScFIib9s4itO27dn6IOVp9lLyHqiFqSw
         K4ynvqygytXTatwKUfnwjn4D3iU4aOYiUsA5T745qqOpiH/HYf+6xBfQf7GVjxVP2u8+
         SZpowoY+fkjqWbdhy7I2JzW6Q69ci6T7TZUOdwLVl8aeVCBLHs7om3TQQOLBo6ipazqB
         0dUw==
X-Forwarded-Encrypted: i=1; AJvYcCW9sYQYAAlkkcg5/PiBtuaY0OeHzu8u+uWa/yA2hS5ZqCwq+dNkLRYaL630met2XvJyrn9qjJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybR0uvxRZ7rg3kXHlIr54cQOiJ4CLzkKmXOutqz5L+r/ceikb
	rZtKFX38NTrwxXtM14GvQUEMuXXOAmBBGor16JmTuS6x9NrYc2Z1RuL13FBKR6k=
X-Google-Smtp-Source: AGHT+IHWOygf8u1N20udthJq/ON31qkCTfTapdoM6eneR+DaWGQ7PM5fmjk8Rm84lqYDYvD8FX9TbA==
X-Received: by 2002:a17:90b:3d87:b0:2e2:af6c:79b2 with SMTP id 98e67ed59e1d1-2e94c51c61bmr19532397a91.29.1730746273096;
        Mon, 04 Nov 2024 10:51:13 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa0eda6sm10277879a91.4.2024.11.04.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:51:11 -0800 (PST)
Date: Mon, 4 Nov 2024 10:51:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
	hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
Message-ID: <ZykXnG8M7qXsQcYq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
	hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com>
 <ZyinhIlMIrK58ABF@archie.me>
 <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
 <87v7x296wq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7x296wq.fsf@trenco.lwn.net>

On Mon, Nov 04, 2024 at 11:43:17AM -0700, Jonathan Corbet wrote:
> Joe Damato <jdamato@fastly.com> writes:
> 
> > On Mon, Nov 04, 2024 at 05:52:52PM +0700, Bagas Sanjaya wrote:
> >> On Sun, Nov 03, 2024 at 05:24:09AM +0000, Joe Damato wrote:
> >> > +It is important to note that choosing a large value for ``gro_flush_timeout``
> >> > +will defer IRQs to allow for better batch processing, but will induce latency
> >> > +when the system is not fully loaded. Choosing a small value for
> >> > +``gro_flush_timeout`` can cause interference of the user application which is
> >> > +attempting to busy poll by device IRQs and softirq processing. This value
> >> > +should be chosen carefully with these tradeoffs in mind. epoll-based busy
> >> > +polling applications may be able to mitigate how much user processing happens
> >> > +by choosing an appropriate value for ``maxevents``.
> >> > +
> >> > +Users may want to consider an alternate approach, IRQ suspension, to help deal
> >>                                                                      to help dealing
> >> > +with these tradeoffs.
> >> > +
> >
> > Thanks for the careful review. I read this sentence a few times and
> > perhaps my English grammar isn't great, but I think it should be
> > one of:
> >
> > Users may want to consider an alternate approach, IRQ suspension, to
> > help deal with these tradeoffs.  (the original)
> 
> The original is just fine here.  Bagas, *please* do not bother our
> contributors with this kind of stuff, it does not help.

Thanks for the feedback. I had been preparing a v6 based on Bagas'
comments below where you snipped about in the documentation, etc.

Should I continue to prepare a v6? It would only contain
documentation changes in this patch; I can't really tell if a v6 is
necessary or not.

