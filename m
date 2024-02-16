Return-Path: <netdev+bounces-72335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0C8579AD
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423A7B25674
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77481BDE0;
	Fri, 16 Feb 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icx77SsA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAE1BDCB
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077468; cv=none; b=tR+PYiZa+wUqZjHBnXkcO0g8ff56j+nH3N9dtT1HKXQCE9w/PX0XdqR/SpJJRoqCYoxMY/yQWBt0PzUA8NBuqFl6Y8MSHkPC1jWan71x505cAD9CEaOt8wtQ4/mGk4VZc2hx/95828lLka9cQgXgbr43Crjk5PYU9hrqiu97IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077468; c=relaxed/simple;
	bh=9anl/sf9UbKDozc8k/PCaKZ1Swc+K6ruGL8v6O+Q/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2Tz5KVLyCvqtdv++QdFQXbl74XK7GcQqbSahkEW72mYVBXV3ivsJZ23LSWbImZ2TtjvNxvZdlBkgHjdpCNYQ4Q+ioV6dWSSEtIaHwsnkPyfO4JuDwwmlfgFKW10N7f/+j58CvuNznAwcrd6HA1x/9WxD/Em0GldcpSNNqkJgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icx77SsA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708077465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gn4OwW9hd1Px9XbCG6HyTbhodQhSFxo9LRFxA+tplUg=;
	b=icx77SsAs/VK7CxLyzWqgY5ULV4S2AaEPHc6ctTw4tVupBcNJFrcZ0OqNtpMLeCDpISt80
	DQ8SaSOO/ULZRrCxa7oN7Gr7XKGX9M3L0y0RUqZHOFuI9r4vrPhD/l9CWoSvHQf+5jBTux
	XHLcCFTtu2p7Es61RDtO3YydJEnnLX8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-fVKn3WFcNIGYjN3N60wkOA-1; Fri, 16 Feb 2024 04:57:43 -0500
X-MC-Unique: fVKn3WFcNIGYjN3N60wkOA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78315f41c6cso245308585a.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077463; x=1708682263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn4OwW9hd1Px9XbCG6HyTbhodQhSFxo9LRFxA+tplUg=;
        b=l593AWLaC/WF7hZ6jCzJ9a2HumE1inaA7zMTR9fPNZci+2nv1Y4qCSSGxLbM9emNci
         F5UBf67hWa2GgGmZzx91i3l8GZPMqPVTPY8ivmWcCVH0JuchwUduk0BJ3jWWSEGzZOL0
         Qppfx4F2GJ8CE6jLjed+DyzbpTlQgDb5KzJ12U1uvewUD0ev/iTR/4Sle7CKXyoFToiu
         4v6YIR47ml2n7ne0pPN4wpJ3f8mFfQ1Pp0VHzfemZswrGk0kuwC7lcBOOumoIh17vv+z
         r80pOaZM4YyrZJF48IsvbK2HXtVX0up7xVO4tRKtFxW6+2ERBjcB7J7Cs04B0gZ9PE1J
         c/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWKg+xuDCD2UQFo8+ITMmVC0E9++Vt5PdxzIJq2/QqWSVULhSripM7kaN6zW5IttAj4Nx5gw2ONxa02KOKZDPRMhhDE9DW
X-Gm-Message-State: AOJu0YxIQOP1EwTqIv+qSWORbRy0q7Cn57L6msir8BwFaF9uGTA2KQph
	S3YEiWqJTL+EedL0wJ8Lz3dZeRW5TEphtU7JFf8L7HdiICtjdY5aNGYOvM1/mRtEm3JYRXc26yF
	JBvGQbdCvRE0YtNkXINJowTZPKZyoFvHTwhfMdC/h0jnJjQ57LUSxyw==
X-Received: by 2002:a37:e10a:0:b0:785:d64e:7165 with SMTP id c10-20020a37e10a000000b00785d64e7165mr4035443qkm.27.1708077463144;
        Fri, 16 Feb 2024 01:57:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVjbXUOYl1FeeOI9y+82+egCVVx1qdcdZKmMFstAJB4GkruA3pRXvA7QTGN6QO6iBLnUX5Tw==
X-Received: by 2002:a37:e10a:0:b0:785:d64e:7165 with SMTP id c10-20020a37e10a000000b00785d64e7165mr4035432qkm.27.1708077462829;
        Fri, 16 Feb 2024 01:57:42 -0800 (PST)
Received: from localhost ([37.163.182.241])
        by smtp.gmail.com with ESMTPSA id pj23-20020a05620a1d9700b007871a4b423fsm1365776qkn.110.2024.02.16.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:57:42 -0800 (PST)
Date: Fri, 16 Feb 2024 10:57:36 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: David Ahern <dsahern@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	sgallagh@redhat.com
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <Zc8xkHURrzmZT3iZ@renaissance-vector>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
 <20240209083533.1246ddcc@hermes.local>
 <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
 <20240209164542.716b4d7a@hermes.local>
 <ZczcqOHwlGC1Pmzx@renaissance-vector>
 <d2707550-36c2-45d3-ae76-f83b4c19f88c@gmail.com>
 <20240214190519.1233eef6@hermes.local>
 <f04a4b8e-9db0-458b-926a-fdd448becbb7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f04a4b8e-9db0-458b-926a-fdd448becbb7@gmail.com>

On Wed, Feb 14, 2024 at 08:10:54PM -0700, David Ahern wrote:
> On 2/14/24 8:05 PM, Stephen Hemminger wrote:
> > 
> > I just did this:
> > 
> > diff --git a/misc/ss.c b/misc/ss.c
> > index 5296cabe9982..679d50b8fef6 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -8,6 +8,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > +#include <inttypes.h>
> >  #include <fcntl.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/socket.h>
> > @@ -3241,7 +3242,7 @@ static void mptcp_stats_print(struct mptcp_info *s)
> >         if (s->mptcpi_snd_una)
> >                 out(" snd_una:%llu", s->mptcpi_snd_una);
> >         if (s->mptcpi_rcv_nxt)
> > -               out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
> > +               out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
> >         if (s->mptcpi_local_addr_used)
> >                 out(" local_addr_used:%u", s->mptcpi_local_addr_used);
> >         if (s->mptcpi_local_addr_max)
> > 
> > 
> > And got this:
> >     CC       ss.o
> > ss.c: In function ‘mptcp_stats_print’:
> > ss.c:3245:21: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long long unsigned int’} [-Wformat=]
> >  3245 |                 out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
> >       |                     ^~~~~~~~~~~~         ~~~~~~~~~~~~~~~~~
> >       |                                           |
> >       |                                           __u64 {aka long long unsigned int}
> > In file included from ss.c:11:
> > /usr/include/inttypes.h:105:41: note: format string is defined here
> >   105 | # define PRIu64         __PRI64_PREFIX "u"
> > 
> 
> Andrea: can you check on how perf (kernel utils) compiles on ppc64le? I
> thought Arnaldo had build "farms" for all of the architectures; maybe
> not for this one. __u64 is used a lot in the perf_events UAPI and PRIu64
> is used extensively in the userspace code.

Sure, I'll look into perf and let you know.

Thanks,
Andrea


