Return-Path: <netdev+bounces-105358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62843910ABD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD661F21214
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED41AF6BE;
	Thu, 20 Jun 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAX9cxaY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532E3BB50
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898774; cv=none; b=uAZBDc1t3Ojt3gZfOO1SMznzmlu/Ode0VlCxg/LDTXtuEhNCwMJ1hYTSEbFN9jbzsSTyWrlR7jUNUPHedamM3+T0cOoHMTxiti2No2TQ+myeft7UM73CX4pk3xdvP9pE5N/+ojTUgId34Ojvwe/69p1FZXA5nfnVGXMzzpwe6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898774; c=relaxed/simple;
	bh=moBi9N/RFbRzoVOUAM3DlRJZlP/2IpYEuEZFZftDCro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyeF1Gx0Qk6HNzxUT6t3n+mYuxZqqcUNj5+NcNrawH1W8j76uqQ87HYh0Nbmj1doCQjsTjrQARbnHYeuVqn6AejZz7oByv7UV1lUwS4EOvQMksJVeo1QN85dEu0sI4O2uXhwG8msMNLyiao+Vlg5If7+lNFDnKr0kLIVvm4kj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAX9cxaY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718898771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwNNvwObBSUkOJNUIBrZAqmahLR99Pl276GZyuIXCWQ=;
	b=cAX9cxaYZDHZEGlWSgJx9TrAVd8DRxxFpUTKZppyMCJeKsAd+Km8ZX4WBbB0SiJjMCBAcL
	4k4m+YMQNJrxPezQnU1kJZD/sEyfzZaQZ6o2rQemRVOcYrTNXNbVlAuAqOiEI1xrpK2z3J
	Y34VSOq1gGUY5aBc4fNvHGs8cvqvqqw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312--75-i9pLPY66m0xXUktDIg-1; Thu, 20 Jun 2024 11:52:50 -0400
X-MC-Unique: -75-i9pLPY66m0xXUktDIg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c983f4285so856090e87.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898767; x=1719503567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwNNvwObBSUkOJNUIBrZAqmahLR99Pl276GZyuIXCWQ=;
        b=LrUCji5eUgxTst3rj3oLQSCDHxVm5G7ge2tlPffp5+aTeWnMBZcLeKLkxBo44vnnrr
         rGjtRtFv2zGNFEttbcrPRahFSzg/9n3B39Y8nVc9OyuL+6WyPzzpDTk3WKWEkHVpaF+3
         AGuTnB6txLK73zZwVRvxUDk9xPhdCUqZIjHBDPsPuESWTQzA2pRzU4yVAXcScPa6rVMi
         KbKOiB4zjhVs/Yqsot/C1VHJMh/eRO/44oSIsgVXHJFzLuw5jN+sK17eP1xW4IlNwq5w
         BkV3n7q8UP2EnfgGf3XA/bKOQG7vef8QTKK+/09h2EGc/MprvmqZ4Rd1Op5SMqpPIJsA
         hDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4svF3Z87js2SxnbYmCpC6KbSobrjbVonZDxZUDbt22yUCNqb6REDyJ97Ch3cq7X4oNMjyne4G4obGH7LpM5oIK1IIRq4
X-Gm-Message-State: AOJu0YyM/qWI5DdF1H0LPt+nKueTgsKapVFx2OVyX92ufmXJ11kTJvoo
	Rg7TzYR+kndvbAHiIgzEiRD9zgFb6DTClODyVug+qOC9VNiVf0y1Uf89XY11fjekc/YGxDH9aEK
	6KtagGqLX+KHvBNADwq2JuYUVjsPnaz0dwDU8smqHmUnpjuzqK5A1Pg==
X-Received: by 2002:a05:6512:e94:b0:52c:8339:d09c with SMTP id 2adb3069b0e04-52ccaa56a39mr4237028e87.3.1718898767278;
        Thu, 20 Jun 2024 08:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Je/ga6tFIcspju8x5xeYXLt0pQVBD8V9mXVemMeiqup+QDAJObfNNyyUsMB9rXPQA0/+kQ==
X-Received: by 2002:a05:6512:e94:b0:52c:8339:d09c with SMTP id 2adb3069b0e04-52ccaa56a39mr4236984e87.3.1718898766077;
        Thu, 20 Jun 2024 08:52:46 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9943sm9887783a12.51.2024.06.20.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:52:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:52:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Li RongQing <lirongqing@baidu.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240620115133-mutt-send-email-mst@kernel.org>
References: <20240619025529.5264-1-lirongqing@baidu.com>
 <20240620070908.2efe2048@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620070908.2efe2048@kernel.org>

On Thu, Jun 20, 2024 at 07:09:08AM -0700, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 10:55:29 +0800 Li RongQing wrote:
> > This place is fetching the stats, so u64_stats_fetch_begin
> > and u64_stats_fetch_retry should be used
> > 
> > Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  drivers/net/virtio_net.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 61a57d1..b669e73 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> >  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
> >  {
> >  	struct dim_sample cur_sample = {};
> > +	unsigned int start;
> >  
> >  	if (!rq->packets_in_napi)
> >  		return;
> >  
> > -	u64_stats_update_begin(&rq->stats.syncp);
> > -	dim_update_sample(rq->calls,
> > -			  u64_stats_read(&rq->stats.packets),
> > -			  u64_stats_read(&rq->stats.bytes),
> > -			  &cur_sample);
> > -	u64_stats_update_end(&rq->stats.syncp);
> > +	do {
> > +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> > +		dim_update_sample(rq->calls,
> > +				u64_stats_read(&rq->stats.packets),
> > +				u64_stats_read(&rq->stats.bytes),
> > +				&cur_sample);
> > +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
> 
> Did you by any chance use an automated tool of any sort to find this
> issue or generate the fix?
> 
> I don't think this is actually necessary here, you're in the same
> context as the updater of the stats, you don't need any protection.
> You can remove u64_stats_update_begin() / end() (in net-next, there's
> no bug).
> 
> I won't comment on implications of calling dim_update_sample() in 
> a loop.

I didn't realize there are any - it seems to be idempotent, no?


> Please make sure you answer my "did you use a tool" question, I'm
> really curious.
> -- 
> pw-bot: cr


