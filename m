Return-Path: <netdev+bounces-172263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BCA54012
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCFB162B76
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2B18A93C;
	Thu,  6 Mar 2025 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UiBIAF1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA229CE1
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225361; cv=none; b=UtvVS/tRlpXrCCadpGX3guej+9rwTfdLlPB01X7ipRbw5PQCTskUnOUU+/aqFJwCoUfnA/6xmsLNs9HgzOLBC+GMuRWpIaA5JCqHcZvAzmIThYEAPnexujPCsZdF+pT+nPgoXDtq96HLBZhAnPRr22sV0HUbaFheQ+eHch8bBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225361; c=relaxed/simple;
	bh=XHvW3ycQBFWggaOSJ8vyOSVd00mPwcXwlVmZWzFWPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUbv93ZdfPBfD7VS3tOCy8tfs82aMy4faYb+YFvWYJiZGhlmYIb57yDLI3kqSEGukzCWz+YAPp71HS7G9L0L8hvUgh+/+I2npIH4/uhDtqUa4LhdyjJ37hQe2GFay4wDQiJcgj5px+Qreo58cwIO+NBvmPO1Nu9hOgwUBhQhmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UiBIAF1V; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234daaf269so2108365ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741225359; x=1741830159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=UiBIAF1VOycAdowQ15wxoKNfts54yukj/Rco7rWMVhUcdfkFao8Paxw0U6ZTWimYVZ
         b7O3F15unqgrwhkIGVwkchIsOKxxaItfMs3FE7srnPEUOFAfna9cH20IDFsWiojhNqwe
         dqqEjsG2fMzyZ44a0YfBHDwvU8tASLGU8ZOrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225359; x=1741830159;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=v1jDBPuiBIV73fhDp3zxubLCMk33dzY1khCyCr/BLbVYSQoSK17qGFcdTE+BmnN9/N
         UrV4LRaGFw4gStWLrCqP2S3j7EOCXr8o/s+8PkKji05JWi5UY7HpW1QruvWxT6wDh9Ry
         rICZAQ9ldgDT3GsW17mxZ51qLAFojaoz3imhatGpWWFgUwFA+HkEH2jZ3KbbvSyDjeaM
         tt+iWYO6SjzVMBwNHGX3crj6WutJ/LSpB6t28rPhXzi/YB/u8cjvZdK7OFw82dq3Hbdq
         Xkij7Ki0gJu4l865hV9NOSxFcdaw4iYmqu2DnqQSBaG+3fYRkG02F+Xk4mP5yrIHDyEo
         0vfg==
X-Gm-Message-State: AOJu0YzpnlaqlU4l3N23wtJ/Hn5i33enZYUUTQqmUUVMWwF1bLfw//J2
	bxOa9xS+02qpReTqZBTNdEY/S+F1+5eJgiCSh/H1l9ibfPdr4EjzW0yI6zu+KaW6GpWxYd5nHJn
	Y
X-Gm-Gg: ASbGncvM3YcfH/KWKmKOjO1AEf7o0ktIaK3Ma8bCdE5teW2Soly6yMBUs3cLUBu2v10
	tGWohCn1fKjG/RxZ49XjRrWto5vhZRxma9r0wk92odiorbLmR2kwEqmSDZbU5JVfTavRQH0IU0W
	5GV44+8sdlYh+n2HagIKmGnw3UJKcMwWQqM7eEy9KgeK4cJ4n5x+0zUGK/A6nJXJqkWXAgisLDa
	7Csb7iGQW/oe8yVj8Vp9Yk8LoUlLoTQ8ZynE9a8fg+t6U8shxOBn64pNDeoql7lmkv2v4jjM16l
	tnM0ZTBCyT5Ki1pMiUro4Yin+y0dsYiiSIEAx0sE7Gu/2nhRIE34BZJKs8wFN+oT40Y9eVVhj3C
	TuQIK5G7K12k=
X-Google-Smtp-Source: AGHT+IHimzEWYok/7eEF2qEOfWup3jke8xbE2s20bz5FMsbXG9wqEzxeTrKe9ompiWcW/VmgcjtyoQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:3ed1:e83a with SMTP id d2e1a72fcca58-73682be572bmr8332195b3a.12.1741225359121;
        Wed, 05 Mar 2025 17:42:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514eb7sm110830b3a.122.2025.03.05.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:42:38 -0800 (PST)
Date: Wed, 5 Mar 2025 17:42:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160355.5f8d82d8@kernel.org>

On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > 
> > How about we don't use the API at all from refill_work?
> > 
> > Patch 4 adds consistent NAPI config state and refill_work isn't a
> > queue resize maybe we don't need to call the netif_queue_set_napi at
> > all since the NAPI IDs are persisted in the NAPI config state and
> > refill_work shouldn't change that?
> > 
> > In which case, we could go back to what refill_work was doing
> > before and avoid the problem entirely.
> > 
> > What do you think ?
> 
> Should work, I think. Tho, I suspect someone will want to add queue API
> support to virtio sooner or later, and they will run into the same
> problem with the netdev instance lock, as all of ndo_close() will then
> be covered with netdev->lock.
> 
> More thorough and idiomatic way to solve the problem would be to cancel
> the work non-sync in ndo_close, add cancel with _sync after netdev is
> unregistered (in virtnet_remove()) when the lock is no longer held, then
> wrap the entire work with a relevant lock and check if netif_running()
> to return early in case of a race.
> 
> Middle ground would be to do what you suggested above and just leave 
> a well worded comment somewhere that will show up in diffs adding queue
> API support?

Seems like Jason agrees that leaving refill_work unmodified will
work [1].

I think leaving a comment is a good idea and am happy to do so. Not
sure where would be a good spot for it.

Two spots that come to mind are:
 - in virtnet_probe where all the other netdev ops are plumbed
   through, or
 - above virtnet_disable_queue_pair which I assume a future queue
   API implementor would need to call for ndo_queue_stop

I get the feeling you have a much better suggestion in mind though
:)

[1]: https://lore.kernel.org/netdev/CACGkMEvWuRjBbc3PvOUpDFkjcby5QNLw5hA_FpNSPyWjkEXD_Q@mail.gmail.com/

