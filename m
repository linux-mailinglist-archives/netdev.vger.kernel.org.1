Return-Path: <netdev+bounces-131025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D395498C67F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D0C1F251F9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0631CDFA9;
	Tue,  1 Oct 2024 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMQY4lFS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570F1CBE98
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813301; cv=none; b=oe2A3jDdz7L6P3PLSaDBU9Uhi448QLDVim2u1pkuNLQNVhqPTbbhaCew2c/vywZ1BT3DwR/yxsS7r46dHoMurCTgPkohRmKLuodJx8HYfRbA+bCqZs2jCySPMXp7pO2ZodpVXpRANbIfrtdZFOJyUIAwIilw+pqceK+ypQQe/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813301; c=relaxed/simple;
	bh=3GYCSxujynSYCowFZOQX+JdInLmXxU5vEEvZc/hFaVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJtNkNwgRFuEeyzkbqdvsATXq57loT9G3Bs5jB3NH+y1dJPawor09FmD6SAK3Z/Trq/Ei5rZdirCwX+HBjwaao3vV7st+/YUZ36/68u5ljYCpN6mgURErO+Y2Qt2OYCW0iuND0YEQZVp+B2aRIX7EX6UqKWrsqmNm3lALDZ/9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMQY4lFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727813298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apius4g1CeHdIrpl7QkimkmGSsSx7Zv/3CES3u3Bny4=;
	b=gMQY4lFS5Wkd5AocU8bxzDHEYeApIVWVI0uk7NNq3bctS+RhdLzqmGpvNQwUYG/hvwnIe6
	VvR+vFhmhyxIA2Qk4/cccBBcMzRiIxzjT3JyryYMNOJ6J2zbSFE9Cz2r3IKe3WL97sC5kG
	YZB3D3Jf2uMBfjTsWagpw8l0iVTV8Qg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-hyfjMmVMMGOiBkLBCB2Opw-1; Tue, 01 Oct 2024 16:08:16 -0400
X-MC-Unique: hyfjMmVMMGOiBkLBCB2Opw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd32f9c59so2043281f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813295; x=1728418095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apius4g1CeHdIrpl7QkimkmGSsSx7Zv/3CES3u3Bny4=;
        b=A4UAyJ4cX+W67d59kAU5ONTa/2F9Y6Rto9xzSPIFCmKn+/S5YQI7EvMpe//BngJPsc
         6dsMOJiFPAmwgF40aytETSXsNE3FdK/u2abFw2YnjElwA/eMSDO3xZWtVl+aMV8eHToc
         Fjdy/CaLgJU/6m4yQDYXYW8RoXNZ2f7DYZD+9y4kAauPcu0k95lGJO98EhoU2VJcacVj
         1L16K93IFYwOgpQXS6OUh/r/GiSYT+aGRYEEJg8gQ9C8DPEgtFXwR4SsL3tJzfTRGcFb
         s8NdFV9U2JPM+0pA9hGEccbS0T7sVXuzdFM1oIeZexgum5sVnVsYVgMoQIG6AVcBkszo
         ku3g==
X-Forwarded-Encrypted: i=1; AJvYcCXXR0NbGc8M5HGN41OkKAdin4GRnaiQfWsPhXXfC9FZg2iCNCWRjuQ18qaw/NvZOWDvLci224c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrU15FcYC6C0KdtB5AaHQkYSGZrEfmGju+ji0eeYHYYmltwM2
	dxmp/bPGeASgFqCWrEJblTXLH/wIzF5m2FoXHA37OHm6pv/GayzmHKXUkj5ajv8Nb+L+02zafPb
	KtF+a7f8nCh85BtpZWf2F5T7CEvTWzy52isT1fWlxlO0Wtf4sKfj0Eg==
X-Received: by 2002:adf:cd84:0:b0:37c:cdb6:6a8e with SMTP id ffacd0b85a97d-37cfb8b63c2mr605959f8f.1.1727813295057;
        Tue, 01 Oct 2024 13:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjmBk+oacLgMaOQSzyXcC6kpxQ9y9EoovlJ0qQOX/LfrUwb3fxuYWcFS//Cpd7Ndwkdhh/0A==
X-Received: by 2002:adf:cd84:0:b0:37c:cdb6:6a8e with SMTP id ffacd0b85a97d-37cfb8b63c2mr605943f8f.1.1727813294565;
        Tue, 01 Oct 2024 13:08:14 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cfc262852sm364235f8f.41.2024.10.01.13.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:08:14 -0700 (PDT)
Date: Tue, 1 Oct 2024 22:08:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Message-ID: <ZvxWrJHbXzxpKCFK@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <ZuQ5VNo/VUBWbqNl@debian>
 <Zvqrb3HYM3XogzOn@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvqrb3HYM3XogzOn@shredder.mtl.com>

On Mon, Sep 30, 2024 at 04:45:19PM +0300, Ido Schimmel wrote:
> Hi Guillaume,
> 
> Sorry for the delay. Was OOO / sick. Thanks for reviewing the patches.
> 
> On Fri, Sep 13, 2024 at 03:08:36PM +0200, Guillaume Nault wrote:
> > On Wed, Sep 11, 2024 at 12:37:42PM +0300, Ido Schimmel wrote:
> [...]
> > > iproute2 changes can be found here [1].
> > > 
> > > [1] https://github.com/idosch/iproute2/tree/submit/dscp_rfc_v1
> > 
> > Any reason for always printing numbers in the json output of this
> > iproute2 RFC? Why can't json users just use the -N parameter?
> 
> Because then the JSON output is always printed as a string. Example with
> the old "tos" keyword:
> 
> # ip -6 rule add tos CS1 table 100
> # ip -6 -j -p rule show tos CS1          
> [ {
>         "priority": 32765,
>         "src": "all",
>         "tos": "CS1",
>         "table": "100"
>     } ]
> # ip -6 -j -p -N rule show tos CS1
> [ {
>         "priority": 32765,
>         "src": "all",
>         "tos": "0x20",
>         "table": "100"
>     } ]
> 
> Plus, JSON output should be consumed by scripts and it doesn't make
> sense to me to use symbolic names there.

I guess that's a matter of taste then. I personally wouldn't try to
imagine what the scripts expectations are, and I'd rather let them
explicitely tell what kind of output they want. I mean, I agree that
scripts would generally want to get numbers instead of symbolic names,
but I can't see why they would _always_ want that. By forcing a numeric
value, scripts have no possibility to report symbolic names, although
that could make sense if the output isn't processed further and just
displayed to the user.

But anyway, if you really prefer the numeric-only approach, I can live
with it :).

> > I haven't checked all the /etc/iproute2/rt_* aliases, but the general
> > behaviour seems to print the human readable name for both json and
> > normal outputs, unles -N is given on the command line.
> 
> dcb is also always using numeric output for JSON:
> 
> # dcb app add dev swp1 dscp-prio CS1:0 CS2:1
> # dcb -j -p app show dev swp1 dscp-prio
> {
>     "dscp_prio": [ [ 8,0," " ],[ 16,1," " ] ]
> }
> # dcb -j -p -N app show dev swp1 dscp-prio
> {
>     "dscp_prio": [ [ 8,0," " ],[ 16,1," " ] ]
> }
> 
> So there is already inconsistency in iproute2. I chose the approach that
> seemed correct to me. I don't think much thought went into always
> printing strings in JSON output other than that it was easy to
> implement.
> 
> David, what is your preference?
> 


