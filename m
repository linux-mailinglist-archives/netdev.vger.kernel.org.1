Return-Path: <netdev+bounces-126731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66157972561
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E1B285892
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B118CC05;
	Mon,  9 Sep 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axnfaYo7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60D18C923;
	Mon,  9 Sep 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921465; cv=none; b=d3DpqY0tI3GGoaZTJ8KtzOa9vJRTpuhOs1RtGZbAW0CTX9NFbylNguJG8JqwtJcJ2kvUFmsjP+lrhRdhLPVdo5Rhki89R34mLMYD5o77gFt252V3euzuYx4XC/hoUzcIsVqt2Xa+cHQd4SCqx6MY1ilEt4CnIbz9SVZbRbBceDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921465; c=relaxed/simple;
	bh=7Ew6PsNcPX2rKJ7dpgqoMSNWYZAhlAPSfAskQYuBNtg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOS3gkdDLthlUJqPtkrm3u9bl+tpA9l8XUxyqAYuPqzLGok76FpjkmXrKr3PKW8nUyrEAKJ7BnKlUjI/BR41hLP34g0PbNCp2l1DR3S6pGA5l/rUQyfScqn6hSEwRJMloimlwSQIw6BIWc3bTNZn4saA7a3zhjvgE5QmecgXSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axnfaYo7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so128253b3a.0;
        Mon, 09 Sep 2024 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725921463; x=1726526263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n0OEd0ELgQaJV/osEYMishL8wH6c+Zm2nDCQ+FejVE=;
        b=axnfaYo79BSl9FuSImXUFWJM0B3LuoJRoGx/QB1SYspxGDJ+h8AwVawpKr8LPPYd2S
         NYDUJr2eESqlx5P61cVqB7EjwsLF8vec1uanBnQoMEVml/1DGYz1ZT2Kjdh9s9UDdfgG
         1glfXGfsg3V7GEqcGAgvQ4pdQpFdj8eHdYrabgK/1cI7+KPPe6e3hwrIyBwSfwlYn7qd
         BIYYVjNqI8zPPwbzya9m+o7GpwOqf8N/kWZQZzYuUvUmg86AOdmupDHZeDOeqnkG2U0O
         EnaWjX//UCzx7MsgRehH7VtUkceeNZ9SVLPJiBIQ1IXe4duqnp4STbcRmDlyMe9NyEk8
         nBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725921463; x=1726526263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n0OEd0ELgQaJV/osEYMishL8wH6c+Zm2nDCQ+FejVE=;
        b=DHELAfY/xMj62/0/HVXoybaEiHr7UiAeW/qRzyaAcKQIbd4d202dYYqSYKET3w1q9m
         kAMJCbmt+2XiUbGF0P+cKL0X7X+Fu9CWsx8XCl58FAnQSxoEkDHlcXgpa4yugAk6wd7g
         STG4YbJR0k0sQujTgVgOdMisio8VvXdhyQ6/ELRKaa6q5oz+spY9nM3HWdyXtDlzqZxi
         ZTbLUd30FI2pPaS7I0Z2jZk2D9/KpEMGpFc+nXbOphCS2TIevbHKS4gCBgxeH5tk68rl
         k9qLv32lIRT/L+pYjpwFNjuTjlzX/E4iLc37ASdPr5rn3vX+q1zRm5crXnQ35SWDtxZd
         x1wg==
X-Forwarded-Encrypted: i=1; AJvYcCUmlxwYmZ3u5/rQ6Jm6gU1yo39gaTRC9+3MQx9acFuOtDoxtKoDBYo5z11XVEpoEM0Tsg/OTCv5@vger.kernel.org, AJvYcCUwSRXuAyXegQcRWldvkXXseOgtafnUozlXwkTpDYd+ClpgmzHK5RdjcnnpcTvagPTyNomzBxICQh4HUtj/@vger.kernel.org, AJvYcCWs5XHrLuFzTVAvbVZOn7XL0Yldk3bTqqFVxyM8SQXwlOT9usIn+SIteXu7LC9131kdpFrF1yy6I/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygGxTZZWRYuvYvJrbnOTBk57kPqvRfdIGOlJErSahb9ttzfl3
	W4ueBKVIzwJdQJXGaSNcMJgF8qQkELUhFMJJCMka+/3YVtZEpwM=
X-Google-Smtp-Source: AGHT+IFDOMcPqsjTNu1lcgtoE5mW8GcxVPLNMZhPwUqti68SAGG6AS3vM0sC85+dIy4MOIYxHZSyNg==
X-Received: by 2002:a05:6a21:4d8b:b0:1cf:1217:ce87 with SMTP id adf61e73a8af0-1cf2a065919mr10681268637.2.1725921463084;
        Mon, 09 Sep 2024 15:37:43 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8256d0750sm4518226a12.75.2024.09.09.15.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:37:42 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:37:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <Zt94tXG_lzGLWo1w@mini-arch>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-2-jdamato@fastly.com>
 <Zt4N1RoplScF2Dbw@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt4N1RoplScF2Dbw@LQ3V64L9R2.homenet.telecomitalia.it>

On 09/08, Joe Damato wrote:
> On Sun, Sep 08, 2024 at 04:06:35PM +0000, Joe Damato wrote:
> > Add a persistent NAPI storage area for NAPI configuration to the core.
> > Drivers opt-in to setting the storage for a NAPI by passing an index
> > when calling netif_napi_add_storage.
> > 
> > napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> > (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  .../networking/net_cachelines/net_device.rst  |  1 +
> >  include/linux/netdevice.h                     | 34 +++++++++++++++++++
> >  net/core/dev.c                                | 18 +++++++++-
> >  3 files changed, 52 insertions(+), 1 deletion(-)
> > 
> 
> [...]
> 
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
> >  		if (n->dev->threaded && n->thread)
> >  			new |= NAPIF_STATE_THREADED;
> >  	} while (!try_cmpxchg(&n->state, &val, new));
> > +
> > +	if (n->napi_storage)
> > +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));
> 
> This part is very obviously wrong ;)
> 
> I think when I was reading the other thread about resetting on
> channel change [1] I got a bit confused.
> 
> Maybe what was intended was on napi_enable, do nothing / remove the
> above code (which I suppose would give the persistence desired?).
> 
> But modify net/ethtool/channels.c to reset NAPIs to the global
> (sysfs) settings? Not sure how to balance both persistence with
> queue count changes in a way that makes sense for users of the API.
> 
> And, I didn't quite follow the bits about:
>   1. The proposed ring to NAPI mapping

[..]

>   2. The two step "takeover" which seemed to imply that we might
>      pull napi_id into napi_storage? Or maybe I just read that part
>      wrong?

Yes, the suggestion here is to drop patch #2 from your series and
keep napi_id as a user facing 'id' for the persistent storage. But,
obviously, this requires persistent napi_id(s) that survive device
resets.

The function that allocates new napi_id is napi_hash_add
from netif_napi_add_weight. So we can do either of the following:
1. Keep everything as is, but add the napi_rehash somewhere
   around napi_enable to 'takeover' previously allocated napi_id.
2. (preferred) Separate napi_hash_add out of netif_napi_add_weight.
   And have some new napi_hash_with_id(previous_napi_id) to expose it to the
   userspace. Then convert mlx5 to this new interface.

