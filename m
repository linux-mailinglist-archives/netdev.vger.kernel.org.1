Return-Path: <netdev+bounces-169926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15486A467DF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9E9162C4C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601C220680;
	Wed, 26 Feb 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg30MXA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31400224896
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590270; cv=none; b=sTULS+l+M2xD7WJHuQx3NLbVBm8ht2xka0Pj8xNptpuCKyd1SLKf9EOTsgsrHQoWTe+kF3nefC7+gHhbU9q0B9Ro9T1jvlXZTDeDK0h0yp1uws+F/ARRK2vfLCdFe9fwe/kSta11ye7Ab5bSevZb3KbQC8JeH7VrfKoDrXwsYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590270; c=relaxed/simple;
	bh=cjDgmUQXElb4jc6mfZm2lFAosRkhi0CEA6OT3TPRZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZKhwZnyWpqQCdHxTRcBgnRmAesiHL3T6AexCrud8QzB5LgHxVUZa0tp623dlC5OZMNKWii0tnYWlFFTyNpZWvGNF3lcXFnFS9dI2jaGeVYLTVzksYBTiIGU26IGjiR6R0J9AdJ/4dIMSOSNCR4EHLIomigfatF+c1q5SHrcH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg30MXA5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e83d65e5so135535645ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740590268; x=1741195068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioeMB3IqPB+LdEcje/Q+CtjkzFAVPREtKJxywExHj7Y=;
        b=Hg30MXA5u/uSJBogB5tQF0YaP8tRe5seIJrHiAPiS7CB1g7cHDddrS2wRwQbUUkx1F
         B3vOzRQup/VOhbT6FxRl164er1DRj70Nw6Tkebp3qTl9/omOEBuBAlxckpb2AJaH6XPc
         jD28GJcdySrW9UqlgrPeuozxHNTbY8C3BJXMO2blEyHNLGG3RsAmrIoPEYeZ5hidKMHt
         Reax4BgwBxoXQCtLg3aswwcusWF25UbnwkW6rQex6QA3pRmWFqaFXboZz3MCsiEm7608
         nFe2YwTMpMo1R1OWrvT8pYP1azapTju8Y3kHppxiUa048PEDYAfBRQEdaJOQw4gyaH1t
         epUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590268; x=1741195068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioeMB3IqPB+LdEcje/Q+CtjkzFAVPREtKJxywExHj7Y=;
        b=cKwyX9QOtR3ahX0zvPr4zwONhrndGeGE2zf7eSzjoMcisZ5LFRQ/vFcakVbdn2wIbx
         C17AEswhAFZLQaWm+EdmqU5gnloWtZAeOEHGGRG2vYoxUI1UauhpqujkZ3SyF4U8ga2o
         Xzo1AQ73d8XyDJ57I+Otp0SIfs8VRgjsgf64TGYgOj2JjZD+uvdGXmZhj1Jtx8zN65iX
         7WKs0mvg+qz0dOq0Z6jRx+yTw4xP9HKTCVM2ZiRX8XPhc6ULED7mp2nST1RcUgejhXwi
         gpGT1GSMBqfEtnTLeXith/dCyn9cDXaKTsCWay1bCUygMwABfyY4IjDTld8xobtHclFF
         d/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXVCi7AHFgmLFYtgJES5XB1XWNOCu8f+OmHZsb/DjEClP47Wqo4w63JfWAEHgMX/TJvdkTKj38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrisDLNfY7eiaqYg+eOdO+ppuYmUe14ZnV2X6JXHt2njjK6xG
	QLSXTPGHPs87TJ/xyZ/SounWBWjc5iXcVSr4L3jb9XjYQUphJ28=
X-Gm-Gg: ASbGnctPZXPJafz3OoSCtHrMCNj2HuzXCnFmvZQZDVo+YPr6p31fPtJ3JkErASV152K
	4FbG7rHQPG+2Q8jYTRHnNeO9zWSivAW7MLm3eI6DGOXSMCtvtrGJaV8G+ql24OtjuCu+aCoLWaE
	WeFabIul+AoAkAtS8OLFYZeeH/zbso/WliI1mfJnOao2RH5WWIWORPi+rIZaMORf6oPvUEh12uR
	wv1n05NyeO+3uG0wgrOPqR24SEUybrRjnc4IgaV5CZuOZvQujVSE96f90sanbj3DWzl4Nps5VEU
	LED61OkTEIFeokS4y8C9Z1nMpg==
X-Google-Smtp-Source: AGHT+IFTMzT28rZENGxi/IpfEuVOb+blZqQbun0cULRXeBjZLnpT6/2pdQZjCZJcjJ1BCuksan9otw==
X-Received: by 2002:a05:6a20:3d87:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1f10ae2ece6mr6500618637.33.1740590266891;
        Wed, 26 Feb 2025 09:17:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aeda7f7e9f7sm3516117a12.26.2025.02.26.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:17:46 -0800 (PST)
Date: Wed, 26 Feb 2025 09:17:45 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v7 04/12] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <Z79MuRd1ZBfbDj4p@mini-arch>
References: <20250224180809.3653802-1-sdf@fomichev.me>
 <20250224180809.3653802-5-sdf@fomichev.me>
 <20250225190005.2850c2da@kernel.org>
 <Z76S925bMuXh7VKn@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z76S925bMuXh7VKn@mini-arch>

On 02/25, Stanislav Fomichev wrote:
> On 02/25, Jakub Kicinski wrote:
> > On Mon, 24 Feb 2025 10:08:00 -0800 Stanislav Fomichev wrote:
> > > +static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
> > > +				     const struct lockdep_map *b)
> > > +{
> > > +	/* Only lower devices currently grab the instance lock, so no
> > > +	 * real ordering issues can occur. In the near future, only
> > > +	 * hardware devices will grab instance lock which also does not
> > > +	 * involve any ordering. Suppress lockdep ordering warnings
> > > +	 * until (if) we start grabbing instance lock on pure SW
> > > +	 * devices (bond/team/veth/etc).
> > > +	 */
> > > +	return -1;
> > 
> > Does this no kill all lockdep warnings?
> 
> Initially I was gonna say "no" because I've seen (and do see) deadlock
> warnings with netdevsim, but looking at the code I think you're right.

[..]

> And netdevsim doesn't call netdev_lockdep_set_classes :-/ I think we want
> to add that as well?

More context: commit 0bef512012b1 ("net: add netdev_lockdep_set_classes() to
virtual drivers") added netdev_lockdep_set_classes invocation to tunnel
devices (which makes sense), but also lo and dummy (which doesn't). It
might have been overly eager? As discussed, I was under the impression
that netdev_lockdep_set_classes is needed only for the stacked devices or
devices that have peers. 

Eric, if you have more context on why we need netdev_lockdep_set_classes
in dummy/lo please chime in. I'll post v8 without adding
netdev_lockdep_set_classes to netdevsim, can follow up separately.
 
> I will make cmp_fn be:
> if (a == b)
> 	return 0;
> return -1;
> 
> That should bring back deadlock detection for the rest for the sw
> drivers.

