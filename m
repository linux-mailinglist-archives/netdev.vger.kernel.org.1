Return-Path: <netdev+bounces-101778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B329000B9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A1E1F25507
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234015CD72;
	Fri,  7 Jun 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBE+pvru"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65C1E51D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755827; cv=none; b=ozVsX9rT2QSFqBuCWJq+rSoMxGZVJ/dLE+fWjo3k+XAYQQBr+TEPyYcof7L14QW1F9NZJqC4OlH/hc0iZa7s/XUIdpZzv9pfXvOtS82IpJ9SvpViXm/jvJL021D2BiwCaCRECimFBGQklNHjBq31oa+WxjrSa3wmap5anYjljM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755827; c=relaxed/simple;
	bh=RFXgRMs6kjSAsxH4kS1kJxemVJFnLMpc0AeHIN3UL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1K3hKucYxf/4tjoOifBUjdcJIo6SXKUtQqMObzkXNNysCfmnBdOuHOS/D17RE1jseHk5f99afehQVTl3XAWxm4+akxC0y3gn8FUxT3OEQ8tfuVIp16pUPd0RoSZSs6RScOcnGvsyT95dBD3zTf44GDDHcun7MV0Y8rR++0/dxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBE+pvru; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzxDjjhBVYQ4MozMAdX0bvSJ+E1P8nTRPna61lMIjY0=;
	b=BBE+pvruqTTk2MLbdwWgJgbmAvNytRUdJUgWjucw6dx6j2DNgVpV1quU7Mt59Oczt/83ee
	ONUgpxik9ii4WwIqyb8P8iyN70p+M13bXZIvtEe7zQHsjh6e67/jV0IGWgBd7nvt/1ezLO
	vdpUwP2TVCm4m5MgUU1OpjWsdexI30k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Bz8WMJaZMTmRTyht-eFPzg-1; Fri, 07 Jun 2024 06:23:43 -0400
X-MC-Unique: Bz8WMJaZMTmRTyht-eFPzg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6ec06ed579so13862066b.2
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755822; x=1718360622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzxDjjhBVYQ4MozMAdX0bvSJ+E1P8nTRPna61lMIjY0=;
        b=orNTdHuCKQ2jrKwQGuMi6NoscxKV5JOS+WlQTfG8ZKY0ebPDLXRf+tCXcDVGPdnh/p
         gsJVp0ToYDScIBxER3vDhHR/UqX5oKfAhFuzjgJlknn1eEojCtSZ/hFHZ/Y+Owh0kan5
         KGEL+LesiXrC1WmUBBufA7RXBvsbCkVyW6Nnn+mHv7uElNchQ1aG2CisluBfHOodmK/V
         p2eccOhsD2Pl5vb8mLlbpo6AYPc4pmCZRQKX0NZuGUgrkmz7RuxppEQZkULpDZdEg8cR
         FUpadvNObp0e3yCeLD6QffzASOtj+WQ5u3QXH4qvXi/NZ5M8tDWBj3h/Jo6UmeJjrVyR
         Qi0w==
X-Forwarded-Encrypted: i=1; AJvYcCUu0pswVjDAftA8IalhBuwCySCE1Rrwe1B/CviDI2+xA4+WIHxCKlX0RWl9G2u28w3JZgKsX755uPmOZnXwBFNK1i5XUcMQ
X-Gm-Message-State: AOJu0YzNmIQ2i/fByp6lcNzTVoQunTaTUTd5ewKeQoPh9rhPbJFjKB6d
	MFNOqyQb5+dbWGGqo+OaZG0thNnHznUzRnzLeohuh5xk4DTDrZt6liHFSeNSQK73Casp2yU86Tn
	nyfUfRxFHo3+cLYNBShPmpiAVzSQ6NN/q8howmdj0mfuO/OLY2HTU6w==
X-Received: by 2002:a17:906:26c9:b0:a6e:f645:f595 with SMTP id a640c23a62f3a-a6ef645f710mr2692766b.32.1717755822393;
        Fri, 07 Jun 2024 03:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADNV9wQQ+4jRf7MncAYwuQX/VA9lntFBPZPcUQ9lGezI97j/mnqv/QeJxOh0+G43mXA4LkA==
X-Received: by 2002:a17:906:26c9:b0:a6e:f645:f595 with SMTP id a640c23a62f3a-a6ef645f710mr2691066b.32.1717755821842;
        Fri, 07 Jun 2024 03:23:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070f9b4sm225979266b.187.2024.06.07.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:23:41 -0700 (PDT)
Date: Fri, 7 Jun 2024 06:23:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607062231-mutt-send-email-mst@kernel.org>
References: <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>

On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >True. Personally, I would like to just drop orphan mode. But I'm not
> >sure others are happy with this.
> 
> How about to do it other way around. I will take a stab at sending patch
> removing it. If anyone is against and has solid data to prove orphan
> mode is needed, let them provide those.

Break it with no warning and see if anyone complains?
No, this is not how we handle userspace compatibility, normally.

-- 
MST


