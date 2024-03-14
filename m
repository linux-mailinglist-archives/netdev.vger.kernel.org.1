Return-Path: <netdev+bounces-79903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A250987BF9C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE998B213EE
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2C7173C;
	Thu, 14 Mar 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9E05WGb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885CDDD9
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429004; cv=none; b=V+0Bu4a+Pcz/8eQhofP4q3J804dMeJxqZuQfNYiIWghNUYtULRshgNbTXZMz7gUIyPISigZQW5D7Mm9cquNC9j3eeM3lcPTS3x90Z7wBiZ6KXl7Ka16XNTyssMnnxfhrZWrca1u8uYX1fqr5CMzp8JG6WS9ILSIO5unWcYGCNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429004; c=relaxed/simple;
	bh=AQfUW3gFNrbjXXL3IloGvW+E2jBS9PDIeGTSBRAl+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIcfhJ8oy3SWdST85sMQsbBhAzwBvW+dUebIvLaSxQtzCvZSkaFwO/9SQkFv9oW32tvREoaCGdCdr9gwPvKZWgjXtaAZ4NE84DpEx68tsZx1Zg/w56rGdaHjmrcauJy964AuEndtHFqesDyhIOVt3ESnPeKumI2hOkSZ6D6Eeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9E05WGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710429001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
	b=B9E05WGby9uH+fTZprwDjJzN79QGOHnSkbu35hmg3yNMtuui/ELzR++9T409/XDInznsV9
	GXepxFG6P3QVqCz7ZuIYFUZn5k05khSJIsp73+iyO6lvzQfHjsLWMgu+tMF/p5euNcn711
	qt61aUD/WY+GEL86KfvQBiZTQbxu1ms=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-K_c2NpmBNO-9jwcyQ-RcAA-1; Thu, 14 Mar 2024 11:09:33 -0400
X-MC-Unique: K_c2NpmBNO-9jwcyQ-RcAA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513cbff0134so1328472e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428970; x=1711033770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
        b=t0Y8yuONiv8ObarpyYxYG/hwjE542Oyo/8lWpMJxSjx6Gvptoe7kELbjRNtVOURKMB
         8jZmS4rz54w+zfDVOG0T4SV8NkxCpCwM0GQ/+G9PZ5hwDGsyj1SdYFeW8nJtRsqAXrq6
         FcQ9WDMsmAXyDHO6QpE23A8ylHkGoD40gKRX5dbj5OLFcCnXaXNG/sMh4J/3ZSuNxHuT
         MItOMRvAlNlrwC3B0AWvTEokmFqxFSDenUDl4JYDiILXBd+3EAbDWErRgGhFdqzGAoPP
         N9RoSLYyqUTRv4X4QoGUeY9JN6PwzwmJ6YJQGjb1Wxn1WWMcLPxcascDozCgeKQW5q+D
         Dwpg==
X-Forwarded-Encrypted: i=1; AJvYcCXXLU2tCkl7AylGqqdzWfayLa9xyhF8A4QcjXCem+MxUseN8+GCU4/Hf6xugDaJEiYMGT58NZ/awzMqZwipo5Ohyr2frwj8
X-Gm-Message-State: AOJu0YyoLXzAJwmJfbyT6YWatIGvHsDC8ppac/WMGXTNBGsESPAnfQz5
	Bo6wAgStgocQnH0odBXGE+MB6XX3EI+QkduiQNKxpRJaT3LdqZsZb8njEjyJ/SpMxLfjllHgTDf
	OhZMhp36YVQ+2Pj9dujWeCDcXVaGo3rc0Nz9lKHXO56rFRIZmxOn29g==
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492777lfj.19.1710428970160;
        Thu, 14 Mar 2024 08:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWuoe/3iFru0sIgh80GCQKJ1jGXO44jJmLMs2cyMkKY2erF0fOYFgEPRPLaBXlctWIZnyYg==
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492752lfj.19.1710428969612;
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Received: from redhat.com ([2.52.141.198])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600c4e0900b004132f8c2ac1sm2732690wmq.14.2024.03.14.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240314110649-mutt-send-email-mst@kernel.org>
References: <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73123.124031407552500165@us-mta-156.us.mimecast.lan>

On Thu, Mar 14, 2024 at 12:46:54PM +0100, Tobias Huschle wrote:
> On Tue, Mar 12, 2024 at 09:45:57AM +0000, Luis Machado wrote:
> > On 3/11/24 17:05, Michael S. Tsirkin wrote:
> > > 
> > > Are we going anywhere with this btw?
> > > 
> > >
> > 
> > I think Tobias had a couple other threads related to this, with other potential fixes:
> > 
> > https://lore.kernel.org/lkml/20240228161018.14253-1-huschle@linux.ibm.com/
> > 
> > https://lore.kernel.org/lkml/20240228161023.14310-1-huschle@linux.ibm.com/
> > 
> 
> Sorry, Michael, should have provided those threads here as well.
> 
> The more I look into this issue, the more things to ponder upon I find.
> It seems like this issue can (maybe) be fixed on the scheduler side after all.
> 
> The root cause of this regression remains that the mentioned kworker gets
> a negative lag value and is therefore not elligible to run on wake up.
> This negative lag is potentially assigned incorrectly. But I'm not sure yet.
> 
> Anytime I find something that can address the symptom, there is a potential
> root cause on another level, and I would like to avoid to just address a
> symptom to fix the issue, wheras it would be better to find the actual
> root cause.
> 
> I would nevertheless still argue, that vhost relies rather heavily on the fact
> that the kworker gets scheduled on wake up everytime. But I don't have a 
> proposal at hand that accounts for potential side effects if opting for
> explicitly initiating a schedule.
> Maybe the assumption, that said kworker should always be selected on wake 
> up is valid. In that case the explicit schedule would merely be a safety 
> net.
> 
> I will let you know if something comes up on the scheduler side. There are
> some more ideas on my side how this could be approached.

Thanks a lot! To clarify it is not that I am opposed to changing vhost.
I would like however for some documentation to exist saying that if you
do abc then call API xyz. Then I hope we can feel a bit safer that
future scheduler changes will not break vhost (though as usual, nothing
is for sure).  Right now we are going by the documentation and that says
cond_resched so we do that.

-- 
MST


