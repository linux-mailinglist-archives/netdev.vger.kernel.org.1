Return-Path: <netdev+bounces-169695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D25A45444
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C707518988FC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB71624E6;
	Wed, 26 Feb 2025 04:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnX5j1/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52933DF
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542715; cv=none; b=ZDH6RObLsmxQ34LpjhaoqrcSVa64T4wU5hBxfAFAV82fuC+U8MrOKaNoaocm1pLJGCNreuJaxaCYsn+q9kcrxLRHfG1W04tYfLuTvDGiab7fy626rNpUZT1yytxvNji98Xp6RJsAXxAYXtjFOThOOU8Bvtvc4f/6ZsBdzSHC2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542715; c=relaxed/simple;
	bh=DAgDDHd21Dim2T46Q23i5Wf7BAGEjweytHx/mAN96Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSP4pdj8+8hu3cB+RWRSxwYdI5wJ7kHZkLrjinJ9efwmddG2a2zngSjXwOlL3jZDamINHFbO2VQ21CqD3ERx6JRYr0CX+ut/hhP3AtHSVVDkvUUXH4Zw4e7raPclDQt/WmegZ/DZLeIojyxAkhzXG/YIm+Wbb4zrhDeR5WjI8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnX5j1/g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232aead377so3655165ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740542713; x=1741147513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utz/Rc57TWxfZFtenYs2pZytEk14fi0jyzGeayJqy3s=;
        b=KnX5j1/gIx+ntehGJs2r8lirjR5yM3SGngFw7FqidiTxCvCNXPi000sdwA2p7QV3Po
         DWBITtnY3WWMN8mzRAyyLTOnge5vn20hjvP6j9TdkYy8YZAU0CQgVgvwGy4MC23AhGPN
         DY7tflxzqp7jFLA5KI4ys7qC003Jls/pZyc5v/FULMBT72/mv7n2CtTROG+0gYQJ2PfQ
         lA0AU3e+aEgpQgK+0LFZzDBvnGABpBFhn3KTpTGBTbdN1T1suqvfOKpgHrSeB0w/MUb3
         sx+zEjV9xFuP4FkBZyAoE2oV+QUhRMM8UH6AHNQPubAeeR4Cgn8wlT6od2NWSPIkKH1B
         Ph3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542713; x=1741147513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utz/Rc57TWxfZFtenYs2pZytEk14fi0jyzGeayJqy3s=;
        b=d+8BUMPYTLVaHzjrVM9M4VRuW3IyoccBrxs8lUq/kyk4tF2ZhiOq4ZxDqnxkc6qgqw
         PzZH9Ithh8EMJHlme54bG+EHIWfWHe2HGCMhamj6OMx+JLfyT9Xj8djyGPbG7Y+ekdqj
         64t8s6pSTMNOr9mseJiT1+Y7kpvMA4B+iH/jmRlmaaV0kqmWGP7e1SDEGuEB8cJGuSNm
         KphHo7WxU5yUkseugLYZSR5aTo3Vuku4EgaGGsWZ/KXf+LHjkv/rGtDa5XYmRIEg3Llc
         XujA3FiK7Mbvy8IlwjbVJtcRxFvwQjMqJKx7dxqldVP0XXEKE8hTCXQqUF6S9gwrjKU3
         J8xg==
X-Forwarded-Encrypted: i=1; AJvYcCVoeQ0PbKNlC4mtbUSEfFeNCfEh1quInFYAWLzw6SivPRkxh1lsdi40AxnrjzXG5sXYB0AsrWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAO8OBVtnRXwnj5O71RH4PRY+YGwXdO217B1UilwBp7vo5S8o
	JEdf6HCq1aX+1ERpThK+5bkgZrfvXjsTqa0R633Ov+ren5hezr7ku3qF
X-Gm-Gg: ASbGncuH6LX//2Y6/p9ITCqavQUbPY3ROwUIvGH9yAbvrTTDNKwoVoNKleVo8DKH1c/
	WgZBaiFyjCWUFULJbNxeYBm47gKKUH/84A9p5pvo9NIvF09RiGR1Efvh2vHSLYzUZ9HHgArO+Rc
	PtF5YTLw/TSDe7Fpw/EjffkDPQWuwvw10SgsYYGC/R3s2dLa4e0tAwF+Rq+xEHZRxym2cEdogMI
	IgY+3ecUfqjAo8ypo4EBzAfWXS5NbiLrsGsDQHhhTo74XQIR6MtZb0UYwNhFVtLPp7/XvIThhNl
	+nnlb127N+d1diUIHS9+/OOKPA==
X-Google-Smtp-Source: AGHT+IHS6SvgDQiWrz3Q4HDp8ZSphc0lT8GS63TW/3+rJI6KzCkuDLBgkm+13fnZk6BS6JHKLQjYsw==
X-Received: by 2002:a17:902:f549:b0:220:cd23:3cd with SMTP id d9443c01a7336-223202135edmr31033085ad.44.1740542713049;
        Tue, 25 Feb 2025 20:05:13 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0a631bsm22417275ad.208.2025.02.25.20.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 20:05:12 -0800 (PST)
Date: Tue, 25 Feb 2025 20:05:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v7 04/12] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <Z76S925bMuXh7VKn@mini-arch>
References: <20250224180809.3653802-1-sdf@fomichev.me>
 <20250224180809.3653802-5-sdf@fomichev.me>
 <20250225190005.2850c2da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225190005.2850c2da@kernel.org>

On 02/25, Jakub Kicinski wrote:
> On Mon, 24 Feb 2025 10:08:00 -0800 Stanislav Fomichev wrote:
> > +static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
> > +				     const struct lockdep_map *b)
> > +{
> > +	/* Only lower devices currently grab the instance lock, so no
> > +	 * real ordering issues can occur. In the near future, only
> > +	 * hardware devices will grab instance lock which also does not
> > +	 * involve any ordering. Suppress lockdep ordering warnings
> > +	 * until (if) we start grabbing instance lock on pure SW
> > +	 * devices (bond/team/veth/etc).
> > +	 */
> > +	return -1;
> 
> Does this no kill all lockdep warnings?

Initially I was gonna say "no" because I've seen (and do see) deadlock
warnings with netdevsim, but looking at the code I think you're right.

And netdevsim doesn't call netdev_lockdep_set_classes :-/ I think we want
to add that as well?

I will make cmp_fn be:
if (a == b)
	return 0;
return -1;

That should bring back deadlock detection for the rest for the sw
drivers.

