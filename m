Return-Path: <netdev+bounces-156560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A612A06F3D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE353A32B0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD39214A6D;
	Thu,  9 Jan 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAZmsawM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C7214809
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408540; cv=none; b=OBUY3I7BI/Qe8Hzi9BeF0v5Htm08eNlydYwQpV2WactpZPFN1Q+7a4k85i8GcQxMM5BvGue3d5nQBrX9PhjBqQ5YzuF6OuFC9xIOPYoyCaCKVMKS8+FWX49By238zUs23dVyJAUif8VifIB0sG3FpJbZVE35YrN3vnfHjxNdqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408540; c=relaxed/simple;
	bh=KH8ZKM1it3Yxv/77thTE6axCBv3gF2iIm/JJRIvqYLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC9exnfuEb3WNyl8BdNcIJ2ZuxtLPRN2tgCfs52DuC2Stqrgge+yUkh47T7qyhAzNu6bb8FU6Dm+iqfVpWfZThaX1SmVHNftumGUl50Fpc5BLLdR62u9xf2o1KivDWwgEjSvBG/6RSIQEr/jrKSwflGkpjdNwwYvwTulwpsk85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAZmsawM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736408538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ0jS+8S8ofkxwCu6uaTJBXu7c3fil4zQKkE3+oBAKQ=;
	b=BAZmsawM1DKGLc6rPemIWtmvvVCS6g45EWEWf1EiVvpSr6A56Qs/WNS5SOuPuushO15tH8
	ntiReHJV8Yf11jD+VhjI9oe7lQFQs0/rvilyW9oWTy1pAn17pso4r2eRR++c5ybeCokbCQ
	SYg6+pEez3LYxtUM/uBubZ0ANQ3fBiM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-a67UUzX-MoiCpvsBDaTllA-1; Thu, 09 Jan 2025 02:42:14 -0500
X-MC-Unique: a67UUzX-MoiCpvsBDaTllA-1
X-Mimecast-MFC-AGG-ID: a67UUzX-MoiCpvsBDaTllA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3ec94ccbdso611267a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408533; x=1737013333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ0jS+8S8ofkxwCu6uaTJBXu7c3fil4zQKkE3+oBAKQ=;
        b=K/wzmSdFoFnjsC9B1Z/kbC7qs1nIVAtNz3QACRuC+akbjeabK/brJUb/BYcxn4zAAk
         02OqbkpItHtgao7zQGX8RyzsaqxdS+aLtME6gx4MQ/bikvZxoXZhnrCuY93V8lsYv5Fj
         grp45ybCGGBq0GKWEfY3s6AQR92czKQVN1Dj8YfiYLiaNHJh+ib1T0AL/UuEACVjGlV7
         LzlspzM+dGbKZbY7lfni8X05G7nIU49wrewfi/Ej9hkV6y/cPRnNZ6OvX6oArryFhGLO
         7fcfdjvJhCfpg4XnVEnVgxdV731XKjPGABne2k1dY7PeGZa/btiHOdCWsLWyTdIzTIvM
         sweQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVA9L4LcInd5BvTNsA9Rg4BWs6nUIQhDoAHyeQDX62iRq8mksI4wODSiVpP8pFtxIyYpjvaHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtnJUdujLPRrr9pJXAxbSt7buZnGJW4L/hCSuLFKQiQOhq8al
	VYSL7N2jFoPKLXIuDJK4P5mhErYDtttv1mNa0CsZGMhDFDZ4Nq4ILhW1z5MYwEvAGUpNLLWMyHW
	Iyl5txkpfAWnvUcz2yeO2GMJGDbuTWEoBntbDkqAQqqh6wVQlOak5Bg==
X-Gm-Gg: ASbGncs1hUezfGo42KJR67YdmK2fGk1vOO6ZzRA1du8UB8VYZ11cKzXkg/LPSx3Brxh
	EEImPphcsw+oMpKTRuXXQdPKW1lM2qfwZWK5voeBQs3hCQBWk3y5EoYTEVV60aBkpiQGDEIUuL2
	oaKMsUQLLyjXZyK/wvMa/uk9pXERr9uKD8ZqLnrQZgst0XznTQae7OJ5ciX8m/tmaLxjCY4zMpy
	STRBaQgfowVE1W7EzR6wae0GTooWRNHus37ytvFfV+jPNhjwX8=
X-Received: by 2002:a05:6402:35c3:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5d972e645dfmr5337193a12.24.1736408533410;
        Wed, 08 Jan 2025 23:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN7MJKvcDkD/Px6nKcdgXtLTm3nqt5X4JuwtNE4wiW6ylzro51CFyZ0ACP+YhNMw81jHMbWQ==
X-Received: by 2002:a05:6402:35c3:b0:5d0:bdc1:75df with SMTP id 4fb4d7f45d1cf-5d972e645dfmr5337166a12.24.1736408532973;
        Wed, 08 Jan 2025 23:42:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c496sm326964a12.16.2025.01.08.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:42:11 -0800 (PST)
Date: Thu, 9 Jan 2025 02:42:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250109024107-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109023056-mutt-send-email-mst@kernel.org>

On Thu, Jan 09, 2025 at 02:31:37AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > tun used to simply advance iov_iter when it needs to pad virtio header,
> > which leaves the garbage in the buffer as is. This is especially
> > problematic when tun starts to allow enabling the hash reporting
> > feature; even if the feature is enabled, the packet may lack a hash
> > value and may contain a hole in the virtio header because the packet
> > arrived before the feature gets enabled or does not contain the
> > header fields to be hashed. If the hole is not filled with zero, it is
> > impossible to tell if the packet lacks a hash value.
> > 
> > In theory, a user of tun can fill the buffer with zero before calling
> > read() to avoid such a problem, but leaving the garbage in the buffer is
> > awkward anyway so fill the buffer in tun.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> But if the user did it, you have just overwritten his value,
> did you not?


To clearify, I mean if user pre-filled buffer with 1, you have now
regressed it. Patch 3 fixes it back, but - not pretty.

> > ---
> >  drivers/net/tun_vnet.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > index fe842df9e9ef..ffb2186facd3 100644
> > --- a/drivers/net/tun_vnet.c
> > +++ b/drivers/net/tun_vnet.c
> > @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> >  	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> >  		return -EFAULT;
> >  
> > -	iov_iter_advance(iter, sz - sizeof(*hdr));
> > +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > +		return -EFAULT;
> >  
> >  	return 0;
> >  }
> > 
> > -- 
> > 2.47.1


