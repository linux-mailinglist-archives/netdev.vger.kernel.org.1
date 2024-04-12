Return-Path: <netdev+bounces-87498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D28A34A0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C511F22378
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3A14C5A3;
	Fri, 12 Apr 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGVrk77s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205B1E53A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942564; cv=none; b=bl6HvZwJ2dceJYfRaof56QqtUvj3mVtP3VgJYnaN1HrHsxaq2qGc4TpghDwizS4uAROCQ8oGNYs+QVxuj8ugaS6qRHz87I9vADuAGLDeKYdqXjXOxHxiRPixBblc16p/7wRPOSM5ODdJTmnC+QTiTcFSP3J7oWAW4LRtRVHyy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942564; c=relaxed/simple;
	bh=GdilPNMVhsZHO3SlcgDBY1v3cIw0AMW8Zg5j5+x5pQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUDnIgqtWL22ukzqDdhc5MF/o4JxYGEYMzjn+p6MRhKEsW88SOmydTtt4Zhm++ko3/RfRf86HkzG3dNPzPkFTbQQO/JPw9IEPtOWaxGv7Zc3GMf+XC0KS7aJJ5Hk4yNj+X7D+G0rfJ8q7g4kR7XA3cid+yQ1EbQBefIOyu1Poss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGVrk77s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712942561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+zjaRAYiGpNYYe9Km7QaSRYAKe3Xfe71nwm8XVbGNU=;
	b=AGVrk77srwWy7+3ii/zwwJlAAu6k8SCgJh3EXyAmC1KGvPGrEf+5QolpfuCBpH0Zv1ERWZ
	Rp8qxaha40Fb+xC4vpZe2O87BlQqXg0cD3vDo8It9d1eJZXtgKeJHQSJoRrOhGuj46yw5Y
	kZC4ulubckY6A/cXKfOIi8R8CKiqg7w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138--RXReZAROyqCl2QrNCoUWA-1; Fri, 12 Apr 2024 13:22:40 -0400
X-MC-Unique: -RXReZAROyqCl2QrNCoUWA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4455ae71fcso80629566b.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942559; x=1713547359;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+zjaRAYiGpNYYe9Km7QaSRYAKe3Xfe71nwm8XVbGNU=;
        b=qtANQqO2/Wc+ikdXV1ey+xg31S6B+fMKyUr/T1jG+q7tWayXjhHk6oGiVRSmiIBERR
         jABGEtHS6zPZqFjcoNrsBNqBdpXZ0qqzs5ihqEDJM7tgOqy35bjxSxnf9DCYF3FZcmwF
         4/i5n/2oZK59rT02InwGNqKxNFW15+EcR4ixx7XKm8tMpbl8lwLJeXLwuDnDgRTmK3xK
         IwxzHyVQZycTjtO1Ja/j4kqDoMBCAS95QD6XyxdAZXRkfmMkH1D11ka0j1AfZWO8XnZU
         Eu61QqA7wQu5vKqMmS3KMz5uORkQdQ63XuwvMy7r2sM3SP0PEZtIabia3bBQSWzUJQlV
         CVuA==
X-Forwarded-Encrypted: i=1; AJvYcCW4F5kVNfo1SYdYHMH6z09BKv5B7djVW4p2ygn6t6Q1Uns/ZjzRd5AR+Gdh/BEQmWDEZkok6rCgsv9mu37Bs4bEqovjSCPE
X-Gm-Message-State: AOJu0YwWeo5JBO4cnYyvokTukQX6gHfKMNiK64hDNix2xZ/Lrs4KJMWT
	ro1boqToC9ARPOOWbhrwfM4pjucJoev6VJYV8puzy3rXScjfZKZIOMdLUSTFGb6R2NwjTHOfIAs
	6iheGNiKObjzNjWwsGz68Is58xs7UUbHVyqte19jR5DIgR0XeOfgT1Q==
X-Received: by 2002:a17:907:2da8:b0:a51:895c:6820 with SMTP id gt40-20020a1709072da800b00a51895c6820mr2380818ejc.44.1712942558594;
        Fri, 12 Apr 2024 10:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmh0GY+0sYjr0gYTOreL+wPA0TP51RKVSJBVBtrpsYkrLZ11+Qu9/VTdV1MpcmCvUcBVqlJQ==
X-Received: by 2002:a17:907:2da8:b0:a51:895c:6820 with SMTP id gt40-20020a1709072da800b00a51895c6820mr2380796ejc.44.1712942558058;
        Fri, 12 Apr 2024 10:22:38 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id og50-20020a1709071df200b00a51ba0be887sm2047386ejc.192.2024.04.12.10.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:22:37 -0700 (PDT)
Date: Fri, 12 Apr 2024 19:22:00 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Ilya
 Maximets <i.maximets@ovn.org>, donald.hunter@gmail.com
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Message-ID: <20240412192200.662d92ae@elisabeth>
In-Reply-To: <20240411140154.2acd3d0a@kernel.org>
References: <20240411180202.399246-1-kuba@kernel.org>
	<b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
	<20240411140154.2acd3d0a@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 14:01:54 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 11 Apr 2024 13:45:42 -0600 David Ahern wrote:
> > > +	/* Don't let NLM_DONE coalesce into a message, even if it could.
> > > +	 * Some user space expects NLM_DONE in a separate recv().    
> > 
> > that's unfortunate  
> 
> Do you have an opinion on the sysfs/opt-in question?
> Feels to me like there shouldn't be that much user space doing raw
> netlink, without a library. Old crufty code usually does ioctls, right?

I think so too -- if there were more (maintained) applications with
this issue, we would have noticed by now.

> So maybe we can periodically reintroduce this bug to shake out all 
> the bad apps? :D

Actually, I had half a mind of proposing something on these lines: add
a TODO comment here and revisit in, say, two years.

I guess it's definitely more painful for libreswan, but for passt, I
think it's quite unlikely that distribution users could get the
"breaking" kernel change without a fixed version of the application: we
made a new release relatively close to the NLM_DONE change.

There might be substantial value in keeping this type of short netlink
exchanges fast, for example for container engines that need to be able
to spawn a bazillion containers per second.

-- 
Stefano


