Return-Path: <netdev+bounces-174224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED476A5DDFE
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D53169820
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F584245013;
	Wed, 12 Mar 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA+U59gd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8315539A
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786201; cv=none; b=FpLfJLqGx6qPt5RS8Ts+jIfLq7rv0ClUscUSZrcYVd2q1YhMUskvzZfpUwL0g8rcSOAk1e5YlvKEcaPRJebSw2Kb72oi+i4S1Bno4zMQFmt4TUqn00ZzzbzuS8HK0pPOILMoE915HDE7t7mE4LI5xzHc4jIjGGaWAdIbSXTfidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786201; c=relaxed/simple;
	bh=bppsgeCLPOVJeGMR97jVKd7rPBeAw9kXU5zpyCLPEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnEKfoEv+3VlZzJ+whbgiEZCw9U4w7NLM6yHatQhkW6M0ZNqsVvT3ndT5+6P0ohAyTcgkFc7/B9gkF8Di1ivaE63x0GWHbgVC462KyqozS0+ZvJluYxOfnXCC4Zfu67MD02lSdUNXN7Ud0CBOl5KZO9Gi70GeyRqNAoIN72XnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA+U59gd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
	b=UA+U59gd1pWDp5Y+KYJw4SegRd3QMd48C4Atl1qs2//K9O8brbFIQOssoTPczk3dXjwgK9
	ukY4GoBcmYW8PZDXoCdTkVTW0GTIN8hE+Ob66PTzU4Fgt5pbnTOE8PAxtQWfMLgaO+CkR5
	3JCV9+HCufxkT58CuR+TyoDts53OCPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-hHQroT8IOwuv6kfeHWkZXA-1; Wed, 12 Mar 2025 09:28:14 -0400
X-MC-Unique: hHQroT8IOwuv6kfeHWkZXA-1
X-Mimecast-MFC-AGG-ID: hHQroT8IOwuv6kfeHWkZXA_1741786093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso34933595e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786093; x=1742390893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
        b=SEno6mY6MZBDpOfE1VT+CcpSRzxbFTQLtDbovnZ3Wf7XgqM9o6eZDLT1OEed1dYoWw
         twtnxhxvbyJ3HFjN9vJH0YgdXTIrkSYqU9o5laWWYps4/AoI+8TadPKAXl8bNoeNADlM
         s6v+x2oNhLPXTmyIaUEL/TUvI1PXPepU5fxvL6HoAC7eoGR0hwwtmGjUny6N55NpJ61J
         JGXbKy2MDxvEGFUuLnD7Lc1GpKXFAhKWR55E8CSSPKyv5m7uaM4ieaBaYiWbtXmtfo4j
         WCIKpXmZ9MW47LbVX9uLY01Nw45J5DsB0Ln+KskDAIudVb+CmW503OwXoOdGO2zYIZ0a
         Lqag==
X-Forwarded-Encrypted: i=1; AJvYcCXlMbrxcrW+JKY89YzNax9TaeLNN9U2HSr09Io1rBGhdl9TJIMfyRLLOpviVaFCnCa+g3oFWJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXfawxn6T+ttZCpJEN0nXnZR7BCYObJrGOzPXY/UQKpUy9VPU
	Kz+IApbdmpzk6UXLZYHb2mmuUQgYJlu1GUArrSloS/JBmchbJNCOe4wi/T4zwSrrakOzJ5diMyv
	9Q+4oCTu/NpMlBwc7IiTEAj3mBGTY3BX0t4WeXT4BGdYpPwecFqTCQg==
X-Gm-Gg: ASbGncsKpN60dM5KQXiXesrBw75vj0MXMLYb8WbZs+Ap1UZl6kbF34JebV02yFI3pSy
	LVf2GiLBo87ZiML9N5BAiYX3OFVySzi0XtDKiU1bgtAaKOvovIUhhip1U9w2f6Dbr8GNbvpjXm6
	MPQiIycSFAP3BtxG9UFsqbPhM/uLWuuOdYypoZcLqUuKFbQJNhwIifv26CebklGJOfEUJzr5nHs
	AdndNf4FXvigbx/hVpE0M9h1/nGugnOFouaE05LpHUt6JavdO6JZIS4uA0ZvdvQEKSza3aqc7N1
	eQoXMHT8Yw==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116970195e9.4.1741786093075;
        Wed, 12 Mar 2025 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrFZYXg7iC/H/VXbl+Ds5zQUdtIQbQ9fB3jQl6MW8bK6C7iTZoHzvzY6YXwej9HbMobpTCbw==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116969905e9.4.1741786092685;
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm22019125e9.8.2025.03.12.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:28:10 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9GL6o01fuhTbHWO@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>

On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > Hello,
> > > 
> > > I thought there would be some more comments coming and I could address
> > > everything in one chunk. Not the case, besides your comments silence.
> > > 
> > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > 
> > > > Hi,
> > > > a few nits below, should there be a v6.
> > > > 
> > > 
> > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > virtio CAN specification or after change requests to the specification are
> > > received and the driver has to be adapted to an updated draft.
> > > 
> > What is the status of this series?
> 
> There has been no movement from the Linux side. The patch series is
> quite extensive. To get this mainline, we need not only a proper Linux
> CAN driver, but also a proper VirtIO specification. 

Thanks for your answer. AFAIK the spec has been merged (see
https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 

> This whole project is too big for me to do it as a collaborative
> effort.
> 

What do you mean?

Thanks, 

Matias


