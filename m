Return-Path: <netdev+bounces-127514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02641975A0D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA61F21A1A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3701C1917E5;
	Wed, 11 Sep 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVIl2iRv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54C1A7AD2
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078231; cv=none; b=jI1l/xIJ39PRTfkeobXbIxlI7lRrkeSJvDzH7Rnf5p3Qqvpf/g5KpC6X7GehDFUVDSCfqmreYdm+u+dpsbTBUaJYPcM8qm24oSkvYtPQ7GqNU8ct2VmnWuwWiHnf0PAEMRbMGYrA2gnvobDke+GI8Yv8YbO3hrWXbC9QJkFeYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078231; c=relaxed/simple;
	bh=n06C4KbKH5L8Hd1NFW8h4ZWpC6UDxZQwCu5kTxp73Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUUBAwk9FUGCGKITOeGY94r0RNb02dkPH9BDC0IWDIAYiXBhQCBi03fiaOapk/6iTk/C44MUCdBG8PL2SKycTDUZOe2X8ksyLAokVh6dMRIosT0HN5PWnsquXW6SMh7mojk7nnNtrUBB1bDm4+orrwkkrde+acKm7zS6s7JuNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVIl2iRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726078228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9ulHhVQt0qTv76m8xS0G7aEW8B2dUBdBiBS/EUaaiI=;
	b=JVIl2iRvYQhz0zYhrgpwOErjvEOmjqljOLanFbMPP73KVeRDGfaQuwv9KxF3kPLE/admuZ
	d5zqDuqXw1jDm15tG6iqeJgI9/zQ5QdTr9suvr0bxXn4jGDGdnHbJJr8cCugpcXYjlZmiq
	Sjl0iaWtFN2Y0rH4G0AjbpSUykUxG8E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-YvuYueo_OU66Fks6ZgU63g-1; Wed, 11 Sep 2024 14:10:27 -0400
X-MC-Unique: YvuYueo_OU66Fks6ZgU63g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374b981dd62so65130f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726078226; x=1726683026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9ulHhVQt0qTv76m8xS0G7aEW8B2dUBdBiBS/EUaaiI=;
        b=BXfzX8vLcfHq+aXMvr9aYClY28DDNSY8gn9uVYpKJzO/Ehz6pAXuXemMU5HL16KtHy
         ymqFE48Ky2ZEn5TT5bgXVl9uCi7EhOniAjJNT88OGs1AbebIbiTmTexjnoMAclDNH1EG
         HNgfyOLZf8wmfD4JuHq66GEnncbwo1ZIAEMoSWWo4gFuO2MQkLh7SPjROIrIdZyA7jWL
         5ziReYCXBQu8HzAXQVCIiJ6IHJwq9s7ldTJEKcZ0UnfmLdV/Z7QKM6wZrTaMcjfOmmuo
         JlB4FOt4nWdkWJS02IwZlW1uMedsFksp5OV0YTDHeSpdGrv0a5Cc3FsCkLw2hxTw41c9
         MBdw==
X-Forwarded-Encrypted: i=1; AJvYcCVC9AgdHOgZY0cGIQVAG+r30KLQ3VJEfS/BonpthM5kcY/VB9kZqMblPMuIdiYx8WUtEtFegVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBZxunuze+eK/xaCzSNUNe3xWA2jm4zIfMUYQVLrqOcpGpcFC
	E5602Ow/Jebxd+Y2yb7b07MW003/Zn2ZdT0K9s5YOLr2Cx7iceQoxjg+CeapezW6XteCXvLpEyD
	4jMYvuZhrU3OBbZOIjrCTTXjWwFYsXt6pzuk7D9xwaQh2UKWaay2jcQ==
X-Received: by 2002:a5d:4841:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-378c2cf3e20mr64287f8f.19.1726078225947;
        Wed, 11 Sep 2024 11:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjk6+e1goGbPimoiKYwqNPqhCCNklehgfmgycaeZ5xJWqfTi5p+BHD4IZr7oN8sledeDO6A==
X-Received: by 2002:a5d:4841:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-378c2cf3e20mr64250f8f.19.1726078224815;
        Wed, 11 Sep 2024 11:10:24 -0700 (PDT)
Received: from debian (2a01cb058d23d600901e7567fb9bd901.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:901e:7567:fb9b:d901])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c11sm12126128f8f.55.2024.09.11.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:10:24 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:10:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/2] bareudp: Pull inner IP header on xmit/recv.
Message-ID: <ZuHdDh4tmFgYutWJ@debian>
References: <cover.1725992513.git.gnault@redhat.com>
 <ZuFdn61NlY80sCyO@debian>
 <20240911075816.171c626f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911075816.171c626f@kernel.org>

On Wed, Sep 11, 2024 at 07:58:16AM -0700, Jakub Kicinski wrote:
> On Wed, 11 Sep 2024 11:06:39 +0200 Guillaume Nault wrote:
> > Forgot the Fixes: tag... :/
> > Will send v2 soon.
> 
> Too soon, in fact:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

Forgot that rule, sorry. Thanks for reminding me.


