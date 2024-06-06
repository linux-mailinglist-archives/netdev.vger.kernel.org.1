Return-Path: <netdev+bounces-101265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31388FDE7B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564A3286C3A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA44087C;
	Thu,  6 Jun 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue2S92EQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238F3EA71
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653936; cv=none; b=p2fIxZ9SPXND4sz5iM6uXM4VsMnwx0GMUQksaq4OPuPzN0nymt/WwIkzrpecJB4zgFeGLcdonmO37VjHHN0kOxvtGJjweKJ9twhmIYuONl2RlY+LfUDHUHa8B+ToyhogZQfSUL/J90T8BiMXmigyc1XFU929m6JuVP3bNGISK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653936; c=relaxed/simple;
	bh=xZKIrW8/SuE4qqD2uv3M3ACaJ92yjjULx+qrf+XjCxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+bf9IOWn9O4hc8gvPBEbtIVqqVupqwKMpQAbrlzF4RRbRyo9EmScVheDv8hkmH/2kSNnYqV/aDor8xYWZYJDpHZDRRqa5+o9gF+7pwd4fFFXO8IpD8wMku8kM/U87NEfso4XCjodDQ6m5ehzBfOD/Rno3uIW30xARADIyvQ+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue2S92EQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717653933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsrZUlxApod7nrUSmaJxIfXQuT4xkPv6XR1BlDjdQ14=;
	b=Ue2S92EQBRfIuETzqCWxWXtyPS0KE2ZwifRY1u+/8uJWANHCZMhrD1V2OnNXFT0NxAET28
	lzbR3mYDplDvujWSd/VsXUmeomK+JjC16JBuBZ/TbeHauGMmICbtI35iIFxDFvD28S3X7u
	lM4eNVUKck470IAfvuZa4qtJE3wN/Ew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JxwKxuTLP0qfMzMhTP3Gog-1; Thu, 06 Jun 2024 02:05:27 -0400
X-MC-Unique: JxwKxuTLP0qfMzMhTP3Gog-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6b7bd3e92eso128445866b.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 23:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717653926; x=1718258726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsrZUlxApod7nrUSmaJxIfXQuT4xkPv6XR1BlDjdQ14=;
        b=k4SAdCRMdsp7ZacARZGp2vbQXPbk4QQZElek+H+J3ZduMYeSnFEKOp/krclgKQi2W9
         cL5M26JATLFA25HQyHyL+ZBsJQOnkQZq9o110yh7EBGnJfnI41gFRrODH0qomLGuernA
         jEVePAKY1B+hFusfzLh44Nl+pe9zFu1g990O+VmXjBWQ5l/AHKHELwj0dNb+xyVv1Fo+
         bdmQejBspo3jO2Z7+ZMS9XGRRC1XatEa2nBr+V2I0Ft3VeCJa0WAS9xAqcX/8MszVPix
         RG4dUpjAeFLd6zzdS37wfcSmg9nd+EZwnYA9wDfJdWxRNV6XnWddOU1PnZhaIJLyLtpk
         RtcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqdPgY3Hwz41SJXer62RJYwSJyuzo6paHG6g475kSAgcYljuXJGZnNqveZ6klaQnLL4d/4UR1rkOhyyNxE6NTavAYFv1BH
X-Gm-Message-State: AOJu0YwYUZE0IoQopEKm9GRzA/81QQWgPr5yMLqg3ub1mFwee5Zws10B
	gVGUef6FyIjY7cCEwBURpENIt6NpPYue3bdvOw37EnSm8FM9uvKNFqCsB6yScq/tf3oU44GXIr7
	aL1aVg2gOQRe0y5ySzPxQuiaJVXShdT9pwPnjci4bi1J0lcTQl57Ytg==
X-Received: by 2002:a17:906:b198:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a6c762bcb66mr147656066b.19.1717653925938;
        Wed, 05 Jun 2024 23:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK8HAAcmA9u09zvEwVLZTGKDryhlokys9J5BLeWli7B/moSHAoVGjthnoy2bJ5A/eL6Fnn6Q==
X-Received: by 2002:a17:906:b198:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a6c762bcb66mr147653066b.19.1717653925439;
        Wed, 05 Jun 2024 23:05:25 -0700 (PDT)
Received: from redhat.com ([2.55.59.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ec823sm44887766b.101.2024.06.05.23.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:05:24 -0700 (PDT)
Date: Thu, 6 Jun 2024 02:05:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240606020248-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>

On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> > If the codes of orphan mode don't have an impact when you enable
> > napi_tx mode, please keep it if you can.
> 
> For example, it complicates BQL implementation.
> 
> Thanks

I very much doubt sending interrupts to a VM can
*on all benchmarks* compete with not sending interrupts.

So yea, it's great if napi and hardware are advanced enough
that the default can be changed, since this way virtio
is closer to a regular nic and more or standard
infrastructure can be used.

But dropping it will go against *no breaking userspace* rule.
Complicated? Tough.

-- 
MST


