Return-Path: <netdev+bounces-118410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACB951812
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3DE283AEF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C119FA66;
	Wed, 14 Aug 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKiPVOn9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40413CFAB
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629311; cv=none; b=VStGAiD9eVfooyOPAADIRFw59HpWWwyhHXK1uIY/Y9AMgGmT1CTE8kshT9k82GTMWfLRcdP+XY3QJRPc+ayRrNQ+gHkNZLDJGvBQoFEfwOe7Jaf/xaEIFK/K73izGjPrEleBD4KQWr/RxaObqLOnPmz/Owm4A1TZ8yK2u4zM9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629311; c=relaxed/simple;
	bh=hzCTGEMMJ7kf4NqqEdzR97wZ6ZicVjeTlJk6P9+znlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un8z5xt9Mw3uLqWqztp4ex3di3pSQRdUuWTelqR90L0P/3Yn6maTO9QK7MMst4CdlMHUnGEhoCGlTqaN8tdIwrkEk6a3KqIQfxhddf1oLSr4JapBp5qEmDYwKqvs5GqxdWW+JxL+JMlWwXfhcCuvO98lBIixdm6qs1iw4YSzZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKiPVOn9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723629308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TD3eIlc9AjVv5XHFM7Qv3v9oTzPd68l7T0XpauE4HO0=;
	b=HKiPVOn9EA0zXqOp5h41fhVpol91DnozsuIj5gd1mgYMha+VDjh+dmTip4Njksc/M4vAjb
	dHtB7/yZqVRrSQ9CWoeDo1yYAjt2mbbxpFbO1J60ASVWZpUH5kMYEszzx47M6eHDzzlMi7
	pgSL0IuaWhfvIBMZefXm7rRII7+UyuM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-CsBtBR5DOb2h9ztWB_OGLw-1; Wed, 14 Aug 2024 05:55:07 -0400
X-MC-Unique: CsBtBR5DOb2h9ztWB_OGLw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7a8d5ad9bcso461879466b.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629305; x=1724234105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD3eIlc9AjVv5XHFM7Qv3v9oTzPd68l7T0XpauE4HO0=;
        b=w+v+QfIRL4G8xfzJtS/qHNzOJjLo3dK4g+MB1jWPT5RbgxYjzOhV8OVdK/zx6yOlkM
         PsAtbopSOjhHJsF+/49TmHZLtMi8eDcz7eocBWgRokAYunULAc1xs8DC81V1TFYUT4Ie
         ID8S8VVMlX/xlugqX1pjis8nG86j6zQWR9qzyqW8CVvAz3W8sAUhpjR3ExyUP690Z9bE
         g2OByu3lfU5XWURnLegJSJPYJInWUOqjMQcQW2raIsxBYXgNwgSdeLhDEm1rSSIdvSIj
         UwGy0OLeCWkRqDxUDBlNjjEJJdS3W0XVcWgVAQqbkQ1oKtwtp7nM+je1wBcWbJP8gMVC
         5BkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj/NtHqUF4bs0L7fKwj2GvR3rLp8OU/Q3RAdi/d7dEe6vrAEEjZCIPkgatAbprDodUAttnc0op6TiU2Bi09QYXoc6ypEig
X-Gm-Message-State: AOJu0YzGFKsnU11vWOkJXyD66J9OXG52DNxZs9rRPQ4aWp4gl39Lixy+
	1F10dgoEzW/ayfGl6fm0DRagJ6UAUyV4p1qBmlyjH21CdWdexLi+aoD6chXHiF++lsOdSf/Io4J
	2vkjoYYN6l8tYuNuEF6w+rrySCAMmrEDuu38pNckBNWbY/b/cE6tkbQ==
X-Received: by 2002:a17:907:e2ca:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a8366c2f66emr148802966b.9.1723629304775;
        Wed, 14 Aug 2024 02:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVdSA4xeG6FKGN4RSrjK5lihBvWgcah1U0Kk9andCHfMqprUTfLMzNpY/SS6Z7AT8pu64aVA==
X-Received: by 2002:a17:907:e2ca:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a8366c2f66emr148799366b.9.1723629303945;
        Wed, 14 Aug 2024 02:55:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e127sm152304066b.150.2024.08.14.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:55:03 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:54:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Heusel <christian@heusel.eu>
Cc: Greg KH <gregkh@linuxfoundation.org>, avladu@cloudbasesolutions.com,
	willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com,
	arefev@swemel.ru, davem@davemloft.net, edumazet@google.com,
	jasowang@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org, willemb@google.com,
	regressions@lists.linux.dev
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <20240814055408-mutt-send-email-mst@kernel.org>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>

On Wed, Aug 14, 2024 at 11:46:30AM +0200, Christian Heusel wrote:
> On 24/08/08 11:52AM, Christian Heusel wrote:
> > On 24/08/08 08:38AM, Greg KH wrote:
> > > On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:
> > > > On 24/08/07 04:12PM, Greg KH wrote:
> > > > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.com wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > This patch needs to be backported to the stable 6.1.x and 6.64.x branches, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.1.103&id=3D5b1997487a3f3373b0f580c8a20b56c1b64b0775
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.6.44&id=3D90d41ebe0cd4635f6410471efc1dd71b33e894cf
> > > > > 
> > > > > Please provide a working backport, the change does not properly
> > > > > cherry-pick.
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Hey Greg, hey Sasha,
> > > > 
> > > > this patch also needs backporting to the 6.6.y and 6.10.y series as the
> > > > buggy commit was backported to to all three series.
> > > 
> > > What buggy commit?
> > 
> > The issue is that commit e269d79c7d35 ("net: missing check virtio")
> > introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso
> > csum_start and offset in virtio_net_hdr") which it also carries a
> > "Fixes:" tag for.
> > 
> > Therefore it would be good to also get 89add40066f9 backported.
> > 
> > > And how was this tested, it does not apply cleanly to the trees for me
> > > at all.
> > 
> > I have tested this with the procedure as described in [0]:
> > 
> >     $ git switch linux-6.10.y
> >     $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e
> >     Auto-merging net/ipv4/udp_offload.c
> >     [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start and offset in virtio_net_hdr
> >      Author: Willem de Bruijn <willemb@google.com>
> >      Date: Mon Jul 29 16:10:12 2024 -0400
> >      3 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > This also works for linux-6.6.y, but not for linux-6.1.y, as it fails
> > with a merge error there.
> > 
> > The relevant commit is confirmed to fix the issue in the relevant Githu
> > issue here[1]:
> > 
> >     @marek22k commented
> >     > They both fix the problem for me.
> > 
> > > confused,
> > 
> > Sorry for the confusion! I hope the above clears things up a little :)
> > 
> > > greg k-h
> > 
> > Cheers,
> > Christian
> > 
> > [0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@gregkh/
> > [1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment-2272326491
> 
> Since I didn't hear from anybody so far about the above issue it's a bit
> unclear on how to proceed here. I still think that I would make sense to
> go with my above suggestion about patching at least 2 out of the 3
> stable series where the patch applies cleanly.
> 
> 	~ Chris



Do what Greg said:

	Please provide a working backport, the change does not properly
	cherry-pick.

that means, post backported patches to stable, copy list.

-- 
MST


