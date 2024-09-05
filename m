Return-Path: <netdev+bounces-125471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C596D2FE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EA4281C68
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBC197A66;
	Thu,  5 Sep 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ha65vysf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655A19884A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528056; cv=none; b=JLbwITrATrO6E/msIADlGu+RzyhPAXLBv5X8Tk4tkeMwUnp7zYHvqOEKdzNIcM/VwrmdH8iqyJC1SKGtbiYHsETIZAmbmgIEWVUAieD1KSSV047UfeBNmVabxKLfK/7yNwCwTkEEmpGwxRwpsufIX/FdjFtrXwJvN0Y41w2NHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528056; c=relaxed/simple;
	bh=p2lDSthd0UAUDSNfN3vnJgKP6Jqx7i1XmEotG9/mWqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT8Pw1XioZNkKYAcYmXo/FxEqLFq89aI71TsCWvVMcODejPqtQ+NRfQ8+veccu2BCUCwnkIh12DG/cAKjj/H8MTvtZ/fyDAj6V6umBAubeeX0S7lHYxxN3TCfauDnkR6EmHvEoLXZVwsgGGyo/iKZu9UAB7UOt6C51fZGGomst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ha65vysf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso3883285e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725528053; x=1726132853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VngNsZVj4tHXgmy1m4a8BA8KlrpyKaaIV2tVk6G4OxE=;
        b=ha65vysf/XZmDUqUygAtFNGJFFnF5LTu9G1I36VW/0nP2w+ADDwuzHvPDkFNpBL5pl
         pdeaihYJPgrXnnN7KaKSNJXibZPpKOLyywVg/mS0FknVRGf0t9mQX+/2lM2LGiUSlR0D
         OL9ZA5a1QLrt01q3yGiD+zSrmyHwnuqfOyygI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725528053; x=1726132853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VngNsZVj4tHXgmy1m4a8BA8KlrpyKaaIV2tVk6G4OxE=;
        b=sRMmFJA89GOlwe/VSC2FUpfuuUegzS+R45aPI50EkC9i0WclXFSK2HyCh9wtL8U/2J
         vXnjwtngx5nB5bNTkp5yF7ZHzs1RPufMSperrSCuTAmAqn0Alc1/xeSHr0B9X4b50C2D
         PHJ2FWLyTH+1Dd2xMfPV4ALcEfjtucAQ8PamlBBScfwU5n9I03m82sNbGDQkDPPTz/mt
         gvOmjWc8ZlSLp/ayglPwTBr3yiXjXcY2rqSmLF16qevKdJoWFIp1nDyEq2CN5JbQWM+x
         ThsMVwGNeFv7xk6qNgNS2DF7y2dNDOVxOEjwuYHbgNmX3d26XRGuQAGvh/nMomnpQAQx
         a/qA==
X-Forwarded-Encrypted: i=1; AJvYcCU27JlC/98aXC1x08IqDg1W/xAr+DGRQzjYIUtP2TFE54Upoqqx3KbEAFR9HbQCszF1mWJoAnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCX0qmNm/2PJVBmUPraGze1wwrsWgEUQstFqSWLOhM/W6G5++
	C9h7//xGu2nTybPZulUHj/PCjYLmb6S51gWYo8qfKbLATioeL4OBlMZgVyJwngk=
X-Google-Smtp-Source: AGHT+IEvug0p6LTD4E+fEx2g7jibM+OQXqcH6xTH7HVfg+4RXyN1ckcaEvzIosMAyI+B+/HVZ75jxA==
X-Received: by 2002:a05:600c:3b9f:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42c8de7b0a9mr49322045e9.13.1725528052636;
        Thu, 05 Sep 2024 02:20:52 -0700 (PDT)
Received: from LQ3V64L9R2 (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c819e356asm141174265e9.42.2024.09.05.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:20:52 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:20:50 +0200
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <Ztl38u_2le7VhxDl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <20240902180220.312518bc@kernel.org>
 <CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
 <20240903124008.4793c087@kernel.org>
 <CAAywjhSSOfO4ivgj+oZVPn0HuWoqdZ0sr6dK10GRq_zuG16q0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhSSOfO4ivgj+oZVPn0HuWoqdZ0sr6dK10GRq_zuG16q0Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 02:58:14PM -0700, Samiullah Khawaja wrote:
> On Tue, Sep 3, 2024 at 12:40 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 3 Sep 2024 12:04:52 -0700 Samiullah Khawaja wrote:
> > > Do we need a queue to napi association to set/persist napi
> > > configurations?
> >
> > I'm afraid zero-copy schemes will make multiple queues per NAPI more
> > and more common, so pretending the NAPI params (related to polling)
> > are pre queue will soon become highly problematic.
> Agreed.
> >
> > > Can a new index param be added to the netif_napi_add
> > > and persist the configurations in napi_storage.
> >
> > That'd be my (weak) preference.
> >
> > > I guess the problem would be the size of napi_storage.
> >
> > I don't think so, we're talking about 16B per NAPI,
> > struct netdev_queue is 320B, struct netdev_rx_queue is 192B.
> > NAPI storage is rounding error next to those :S
> Oh, I am sorry I was actually referring to the problem of figuring out
> the count of the napi_storage array.
> >
> > > Also wondering if for some use case persistence would be problematic
> > > when the napis are recreated, since the new napi instances might not
> > > represent the same context? For example If I resize the dev from 16
> > > rx/tx to 8 rx/tx queues and the napi index that was used by TX queue,
> > > now polls RX queue.
> >
> > We can clear the config when NAPI is activated (ethtool -L /
> > set-channels). That seems like a good idea.
> That sounds good.
> >
> > The distinction between Rx and Tx NAPIs is a bit more tricky, tho.
> > When^w If we can dynamically create Rx queues one day, a NAPI may
> > start out as a Tx NAPI and become a combined one when Rx queue is
> > added to it.
> >
> > Maybe it's enough to document how rings are distributed to NAPIs?
> >
> > First set of NAPIs should get allocated to the combined channels,
> > then for remaining rx- and tx-only NAPIs they should be interleaved
> > starting with rx?
> >
> > Example, asymmetric config: combined + some extra tx:
> >
> >     combined        tx
> >  [0..#combined-1] [#combined..#combined+#tx-1]
> >
> > Split rx / tx - interleave:
> >
> >  [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...
> >
> > This would limit the churn when changing channel counts.
> I think this is good. The queue-get dump netlink does provide details
> of all the queues in a dev. It also provides a napi-id if the driver
> has set it (only few drivers set this).

This is true, but there are several and IMHO extending existing
drivers to support this can be done. I have been adding "nits" to
driver reviewers for new drivers asking the author(s) to consider
adding support for the API.

Not sure which driver you are using, but I can help you add support
for the API if it is needed.

> So basically a busy poll application would look at the queue type
> and apply configurations on the relevant napi based on the
> documentation above (if napi-id is not set on the queue)?

That was my plan for my user app based on the conversation so far.
At start, the app gets some config with a list of ifindexes it will
bind to for incoming connections and then gets the NAPI IDs via
netlink and sets the per-NAPI params via netlink as well.

Haven't implemented this yet in the user app, but that's the
direction I am planning to go with this all.

