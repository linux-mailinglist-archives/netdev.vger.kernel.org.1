Return-Path: <netdev+bounces-166043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A43CA340AB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AAF3A8CA6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503632222D2;
	Thu, 13 Feb 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O1UWIXHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E536227EAE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454344; cv=none; b=Yve16IeR21ugzmPzCWn4slTIQ6mGFJQjAY0u787hY50gTFAj+YAUqUW8AATvX4+0E4T/+Z9w3joLWuHp4GpCFB8H8SgU5wW73H2mmcHLIB80PG+BwAvXthD+bSBs4lbCJiZ5+Y/sIX2drEHPWv+vyQSlP834DirEHfBCIqCzDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454344; c=relaxed/simple;
	bh=JqQGz/Rf5LV/UyFhhwLvg8wPoS0Ss8A3I+uVWgQQo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovUvLYU+IQqvNx/6wFnCo5U9Rs7yU96gJTN+/3XD70TvMKeaMCFIJI4ODV1nTQFDrjur2uY6tdqDdZnMt2urW9ks4CvJ3D/PlsLl1Il3zg85Rn0BIvvNDwzxAYpkWkm/ga9THcrgStstCggg171O4L8mgnKDG0mg4qwiEGAZW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O1UWIXHE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e6028214so3868855ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 05:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739454342; x=1740059142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZfMY5Ky6JWO9rAJooFwnfwAFBDZ9Iv+5bt9evH/dRU=;
        b=O1UWIXHEKbeC/PxRpLLmgkzBm1k6JwJ2hHxPImqG6Z9mkd7UMEdhPn/GPw3oOp9Xpl
         ANo2Lv0GkybX96+PfFPxJe7vTooPmgNZsZIZuMbidqT0Q6SX7ldu5XVUgi91o6atNusN
         WIs68Wuvx1itUb4f4+tBPwyp+mZcO+VO5iqjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454342; x=1740059142;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZfMY5Ky6JWO9rAJooFwnfwAFBDZ9Iv+5bt9evH/dRU=;
        b=Y5BUOXoC3aJQcwJJoOJ5DjLXDCGrOIDaijAbRY3oPatMWDok293i0xZueeoPCLOGri
         /fM82e1MFyqg3Kr0C0TMggq+YnO9YgZfLT3uGnV3FYog+/czQKpk8GCU1/KwkY4KuG7n
         3DMpMrLUhKdk8jqIliiQqvxTjmimHoMIBo3FtwBItC/czoG0cx8ztvA6dUyFZ842D3D1
         iG5bR9MSulpufgQMywGBHPut6DwiXNcBJjOfH/MUuxyE1Z0AwtvVeSzlVBhkqg9evnIr
         FppB+GRt+5L08bufjkJAhVbKLJYtQT46X68NLzq0xi4Ap57wxRTuvM2zYD1ic+eiQ0c4
         Jp9A==
X-Gm-Message-State: AOJu0YzOl7Ii20h0NSr9m9zSeHY1hlm8kz1GbJYph7JmSTEvPbLbl80T
	FiyBzhI2hp/9QJ/CQa96dtaCs7ecK8itnA8CVev1FvmP/PfUoQPvsLQiANgNAyo=
X-Gm-Gg: ASbGncsbu0i6VXZPWotKYsR+pRGC+nz+sDkmnXRdOKIl24KSsHsIhTAxLClWxoiiwmG
	VyGFsDuCf0+WacYznCmjDMi5YRdZBmjHWvqOcwItpmu7WUYrDuPHyJca1pU54I6XiFBQYpweunt
	czJ00EdIUBzWP4NCJwWGkeYhj1AMiznbCDq1cvjbnltrSXWKJxZUcMpNex1tgiO6NgUGh2kprHd
	o4vuX15Bnsnck8uztTdGf3F0B+uXDGBuXOl9byXMYxPi5dWF1zNEl+IvydVjg9inpVha5BvykHr
	bJC7JbCCvnvxWtEg7KX292ZPJha4By2JTeSmINMMbuY1SWg9qyC+LAzb5Q==
X-Google-Smtp-Source: AGHT+IGVQHRnaEC8fyg/uKj0MoWqj7Qq9SDAczdTFT9cAow0d4in9EcMOYDk7qf/rAYnjSF0QhPwSA==
X-Received: by 2002:a17:903:238b:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-220bdf4ec11mr105120495ad.27.1739454341404;
        Thu, 13 Feb 2025 05:45:41 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5590770sm12359555ad.231.2025.02.13.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:45:40 -0800 (PST)
Date: Thu, 13 Feb 2025 05:45:38 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, rdunlap@infradead.org,
	bagasdotme@gmail.com, ahmed.zaki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <Z633ggyM-F2pfAkG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kuba@kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
	ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
 <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>

On Thu, Feb 13, 2025 at 12:45:01PM +0100, Paolo Abeni wrote:
> On 2/11/25 9:06 PM, Joe Damato wrote:
> > Document the existence of persistent per-NAPI configuration space and
> > the API that drivers can opt into.
> > 
> > Update stale documentation which suggested that NAPI IDs cannot be
> > queried from userspace.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Reword the Persistent Napi config section using some suggestions
> >      from Jakub.
> > 
> >  Documentation/networking/napi.rst | 33 ++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/networking/napi.rst
> > b/Documentation/networking/napi.rst
> > index f970a2be271a..d0e3953cae6a 100644
> > --- a/Documentation/networking/napi.rst
> > +++ b/Documentation/networking/napi.rst
> > @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> > of a given type. For example,
> 
> It looks like your client mangled the patch; the above lines are
> corrupted (there should be no line split)
> 
> Please respin

I must be missing something: I don't see the line split when looking
at the original email and I just tried applying the patch directly
from my email and it applied just fine.

Are you sure its not something with your client?

See the message on lore:

https://lore.kernel.org/netdev/20250211151543.645d1c57@kernel.org/T/

