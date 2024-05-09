Return-Path: <netdev+bounces-94948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206078C1134
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0642284042
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D515E7F9;
	Thu,  9 May 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG1wibNS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729615E1E3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264906; cv=none; b=oTyestkkLNz9aC4vDjCxgbGyY5eyD2/91zgscjz8+x80wr0iFCJq71aWqclPg0nVcC61GUTMqOkmR5LWwe6KDbzWOFuLweQ/SoAROEQa13iBUhoCJrQegJ8lPcQtWqqeEbK7Ihoe+znGY3Y0rurmbjt1TNlfsfUikKstkC3rARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264906; c=relaxed/simple;
	bh=At/PR9xiPBZXIeHupjRi2vL41OmNPl7+MlUPDhRsU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icSvK2NCkRmPcbtte4nXhVmXMyEEdtSbk/sFmgN51OOeRGS4OXlxvM1KLdHrPTkZTDmhdiLlUJ3e8lb4F+2WA62GlNvQHWf99zkYi2Rkd39DM8Iq2tdnycn75y936J/p/y/bHNetGtphpy/oXZtwIIeqwfHpbRG2mv/DWNO5YAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG1wibNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715264903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yB4R6RD8JSzHt1WCn3E7Onr1qX3r8v4WsayQOTvs8Q=;
	b=AG1wibNSYHw18nJk09deujOtDjUvtl/fFGNUn/zBPdpTVmJQEu8ZwVB8vlbXb+XlA9IGPE
	E00tWecgHpGy7H9YrNG/ivhS66oVvw+NHAG2cnXQMwcPK9XBl17SBWpArUxSEerkucO2pb
	LZDmIyr9NbIDuvL8gTqeEswHHEgwZVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-qNCQbFnoOzi6FMd9Wext4w-1; Thu, 09 May 2024 10:28:21 -0400
X-MC-Unique: qNCQbFnoOzi6FMd9Wext4w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41d979ae1b8so4225545e9.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264901; x=1715869701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yB4R6RD8JSzHt1WCn3E7Onr1qX3r8v4WsayQOTvs8Q=;
        b=YOsguWzXvwZnKyQ1tWgc3KJ5fNboMNrOILzJYx7zcvvnubM5HHBEB75Svnh1x47L8H
         m2vPoBeM2Wvlvr0YHZMYIsLyrj/+0K4h804j6NHQYo4VfLYyolty0voApCdJ6dE6Sf2u
         up9JjO5RdL+6S+zcXrNMKd4NteC5YL5HM4d1ZNP+3RN47MvOkQhasnsPWc9fJpqzvha4
         Qj4yRAZCXSU3SbcGJTXjx2jmmqqiupKS14t2xYuz1yoyxD1wEAlndTRqVstWpYh06YlZ
         Oe+FKxjqYbg9e1wy19ft/ssIBIAlg4LPV5Rz7LiTI1q8wrBOZ40PtElhkcxubng74dHz
         Ev1w==
X-Gm-Message-State: AOJu0YwiLBUOBkfLBixQOAgrFITunFVdw3VWkR1uL2+rk0xlYq99R0np
	cOaUcAw2d8UihPKaH6Vmr6yB7vDidvxmuTAVDJN5a8ZZUnl4/r3rm91z4RCQko7vXC6ExAjb60Y
	jPdSa3x/bT/Uwmdjdwj1iZcVuLRwe0JzHQf+CfPM1G/BZxjH4F/YtoQ==
X-Received: by 2002:a05:600c:154c:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-41f71302dedmr39294155e9.8.1715264900717;
        Thu, 09 May 2024 07:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAt6VE4MW6hKIeo6jWBbU4XjmGfYi89/ka3k4INSe646/Yi+7fF7mU9MnA1C6/BbjQ2e22qg==
X-Received: by 2002:a05:600c:154c:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-41f71302dedmr39293945e9.8.1715264900227;
        Thu, 09 May 2024 07:28:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3cda:4bef:a79:3f22:9a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe126csm27126095e9.41.2024.05.09.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:28:19 -0700 (PDT)
Date: Thu, 9 May 2024 10:28:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240509102643-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzQTFq5lJIoeSqM@nanopsycho.orion>

On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Add support for Byte Queue Limits (BQL).
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >
> >Can we get more detail on the benefits you observe etc?
> >Thanks!
> 
> More info about the BQL in general is here:
> https://lwn.net/Articles/469652/

I know about BQL in general. We discussed BQL for virtio in the past
mostly I got the feedback from net core maintainers that it likely won't
benefit virtio.

So I'm asking, what kind of benefit do you observe?

-- 
MST


