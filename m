Return-Path: <netdev+bounces-144274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 397519C66E3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B4B1F256C7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52754277;
	Wed, 13 Nov 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="i8iI8IQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF162E634
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462528; cv=none; b=r/VzMuntjKs5dNQFaNlG/oSc8h9PK02D7ZyQXkJ06lBKCvjmqqCGijaQ2A7Vm79AhZPSXqPXhLLJNmvG45v3r+czeNxUIkp4GBmjArqOtnfRia6Uw/T4BT4Fef6FFTig9nYocZDaz7ufNNT8uogQDKch1EJ+3wsGWkVi7mme2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462528; c=relaxed/simple;
	bh=HkNYWWQ2EMSQNlU3U3KCFLYPWU2T/B1jd9MUVLxBBv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht3jGlT46b9jI+s5lYKvm1mBd1GLAwstH0HmSVK+my/R2JRX9avq1G+x34V4jFVUEmD0jFi+G1glL9fAeIq0QsNgugOKjUB/5jwas9mIeSd05SefVInG88OadserPpFWJmkFn35UCECJ6mUUU1k08MhWeV9RYLIB71/SQGb0WVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=i8iI8IQX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e60f6ea262so2921543b6e.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731462526; x=1732067326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKHQD9Tex7lX3O/nm/7VP3jjrqlV4Q1M0lOw2A+fBK0=;
        b=i8iI8IQXnhcsukuKiptZMJlsiuIIx5L5TP4w7IFdzu2KcrmkAvj3mR5pXmwvDCBWDS
         x15/pXY/vyw88EJ0dX1Mo3xwnorS87Gb1PjuqMdZmPas/dmioHalwqp7UGiZfry2P7uw
         R+2OTFffUVm3mz44cqQPr/alvLqsSOGkzM3iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731462526; x=1732067326;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKHQD9Tex7lX3O/nm/7VP3jjrqlV4Q1M0lOw2A+fBK0=;
        b=uy1KScrbvm8tQZ2G8aRs7hYsLdXB/umPQ+tksrUvVk3nrIRs4iEFvWnadIZ0HxNt5d
         2CC6FloFHsFAUBTQqpTHIfNv0FQ11ERgyAT7roUzmlk+hFxLhwq6k9yi8dPcV90z1/Be
         OvKgb7kmOgvI70EKaSsOMzZjX1PnqZgRoNyJdRUKniLMgw5rZLciPd9Ne+o9pY7+wvF7
         FWg1yjBjt3Ht+FETJxXSJrzcqkjRCCajcSj0X+BbjmPDQAAKDsyk/7itpcHMWLPq/D9k
         g7x2DEQTfmm2bzPf0FbHfxGtLxkk31Ia6pIQ1u2hfPIFM0h0d75XbCr4YNUlBLEr5OnB
         gs5Q==
X-Gm-Message-State: AOJu0Ywcj7VdYctiSyOqxQAu8UIJHzEj6klU7T1wq/8Iz0z+bvuDXoWR
	8fiipIvr7tXlI6KTAm/TsDXKQ+PIjSpqXJh80r5lN5a4zDW7MZFtKvkFK8ZER2A=
X-Google-Smtp-Source: AGHT+IFx3HQEDOShaN+gNt6GlobneUfX5HOUPcO7wOqefESrPL+NusMs2GeOSZF3v3B4W2UL5Y0sQQ==
X-Received: by 2002:a05:6808:19a9:b0:3e6:19a9:4718 with SMTP id 5614622812f47-3e794775b91mr14231832b6e.40.1731462525999;
        Tue, 12 Nov 2024 17:48:45 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5da75csm9604558a12.36.2024.11.12.17.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 17:48:45 -0800 (PST)
Date: Tue, 12 Nov 2024 17:48:42 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Message-ID: <ZzQFeivicJPnxzzx@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241112181401.9689-1-jdamato@fastly.com>
 <20241112181401.9689-2-jdamato@fastly.com>
 <20241112172840.0cf9731f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112172840.0cf9731f@kernel.org>

On Tue, Nov 12, 2024 at 05:28:40PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 18:13:58 +0000 Joe Damato wrote:
> > +/* must be called under rcu_read_lock(), because napi_by_id requires it */
> > +static struct napi_struct *__do_napi_by_id(unsigned int napi_id,
> > +					   struct genl_info *info, int *err)
> > +{
> > +	struct napi_struct *napi;
> > +
> > +	napi = napi_by_id(napi_id);
> > +	if (napi) {
> > +		*err = 0;
> > +	} else {
> > +		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
> > +		*err = -ENOENT;
> > +	}
> > +
> > +	return napi;
> > +}
> 
> Thanks for the quick follow up! I vote we don't factor this out.
> I don't see what it buys us, TBH, normally we factor out code
> to avoid having to unlock before return, but this code doesn't
> have extra returns...
> 
> Just slap an rcu_read_lock / unlock around and that's it?

Sure sounds good.

Sorry for the noob question: should I break it up into two patches
with one CCing stable and the other not like I did for this RFC?

Patch 1 definitely "feels" like a fixes + CC stable
Patch 2 could be either net-next or a net + "fixes" without stable?

> Feel free to repost soon.

Will do, just lmk on the above so I can submit it the correct way.

Thanks for the quick feedback.

