Return-Path: <netdev+bounces-125475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378196D35B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7711F29CD6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDB419538A;
	Thu,  5 Sep 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tnwRddru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43919415D
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528731; cv=none; b=DSLKkXna2Se0nzeVIl8qPfDI5xCaHF+57j42SM+ilaVL5ilokCeMOFx4Sr5UxM5OLSpxW6vaBYDGoIi4NxR+ngMJK6K4kEjFWciBAZp7hU5yzIW02in/3Il3T5V6xFJXsZj877Vt0n3LXv5OYQSGzCo8qthrFwgtgRtHXuRSNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528731; c=relaxed/simple;
	bh=LQ5PvTcHlXGD/hkNFOkC5JReMWoYpmLiurPZY9rQkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtBtagd6SU+PRfZew66Cl6h9y/vksyzCr/TN+6gmmhcPAkd6I6icWWnbvg1+qkd6q8Bn94qRl9JBXnp49sNw4PnaKbIuYKlCUvJyWyJhmQ1LayUowK9avrSBSqCUC1OlRAoeftbkq2vEJO+giIGSCBCAbEb9q/ThYQNCpHnVMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tnwRddru; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3787f30d892so308828f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725528728; x=1726133528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYvR2W7jIGeeSA8kiFQ7IQfHxoQoKGRP/A4d6og6D5c=;
        b=tnwRddru5evt6kv6LiJrqsUHyrqRwL41fYkag8/lFruPP+3DgRx56RgZKUX0ddOVxJ
         hnWKDe6AuaFwBbj7BtzwyXUAx/yIkjeeucknxG5HtIOhl+Hj234BsdLp/O9om88q5q/W
         rBbEw3q0z99OHVhtnL6QTFYuJzGFxbrzXd4hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725528728; x=1726133528;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYvR2W7jIGeeSA8kiFQ7IQfHxoQoKGRP/A4d6og6D5c=;
        b=ViOYERjEhRxSJGtdNPTnbeBu5Kh9az7Ig6MjJQkLPyMwhWnIw/6Ue7IfTdi1finudR
         5AtMeG0/KWrjm9SIkL4awE3Ca97B4bfhyfNiJhteWsu8SO306cvALKAQIdHCZs5jZq6r
         e7jMalYf2IYIr/89kZXg2es+HSzETL1Fxwd4JOm37ahsBL+p++fuwGtNrV9+5zzZ0rOx
         5hApHQIMfvxTo9D73hvxx83SjPSBzLGlP/T2yYc12jk7DqPS9htjdEl7iJH/MYD0XtB0
         MK2RfenSzkckjyyD0q+rbaehzKMVyowhak/RgKyzRVOrmUAFrjGa84Uo6NN6IPhEEQ6z
         ei9g==
X-Forwarded-Encrypted: i=1; AJvYcCXa0B7DZrAJFA2OnDMnVQZsPNaJX/HPBaj5Ef67D/dhtmSCnwq7rmEF22SKYH+ULMoaJnixie8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytj70IeVOZVowwrqJBg7OLJ9DIjQhGbLA22n0O9r3PHebBm5o6
	IfGBSCMG9u1wrGPyquqPwKBW4R450zw2RWmZVuDk9nz79DDAi6ajP6EHjUvFiw8=
X-Google-Smtp-Source: AGHT+IFllECApaNAIcoK8oWhKRk18ZBq0kn6XAZqAdlvY0zydI7UVq0JZx8/ZTiSJkGJqBngRd8J0Q==
X-Received: by 2002:a5d:62d0:0:b0:374:be0f:45c1 with SMTP id ffacd0b85a97d-374bf1e46ffmr9823673f8f.53.1725528727546;
        Thu, 05 Sep 2024 02:32:07 -0700 (PDT)
Received: from LQ3V64L9R2 (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274b6sm228268835e9.33.2024.09.05.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:32:07 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:32:04 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <Ztl6lATqzndc2-hK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <Ztjv-dgNFwFBnXwd@mini-arch>
 <20240904165417.015c647f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904165417.015c647f@kernel.org>

On Wed, Sep 04, 2024 at 04:54:17PM -0700, Jakub Kicinski wrote:
> On Wed, 4 Sep 2024 16:40:41 -0700 Stanislav Fomichev wrote:
> > > I think what you are proposing seems fine; I'm just working out the
> > > implementation details and making sure I understand before sending
> > > another revision.  
> > 
> > What if instead of an extra storage index in UAPI, we make napi_id persistent?
> > Then we can keep using napi_id as a user-facing number for the configuration.
> > 
> > Having a stable napi_id would also be super useful for the epoll setup so you
> > don't have to match old/invalid ids to the new ones on device reset.
> 
> that'd be nice, initially I thought that we have some drivers that have
> multiple instances of NAPI enabled for a single "index", but I don't
> see such drivers now.
> 
> > In the code, we can keep the same idea with napi_storage in netdev and
> > ask drivers to provide storage id, but keep that id internal.
> > 
> > The only complication with that is napi_hash_add/napi_hash_del that
> > happen in netif_napi_add_weight. So for the devices that allocate
> > new napi before removing the old ones (most devices?), we'd have to add
> > some new netif_napi_takeover(old_napi, new_napi) to remove the
> > old napi_id from the hash and reuse it in the new one.
> > 
> > So for mlx5, the flow would look like the following:
> > 
> > - mlx5e_safe_switch_params
> >   - mlx5e_open_channels
> >     - netif_napi_add(new_napi)
> >       - adds napi with 'ephemeral' napi id
> >   - mlx5e_switch_priv_channels
> >     - mlx5e_deactivate_priv_channels
> >       - napi_disable(old_napi)
> >       - netif_napi_del(old_napi) - this frees the old napi_id
> >   - mlx5e_activate_priv_channels
> >     - mlx5e_activate_channels
> >       - mlx5e_activate_channel
> >         - netif_napi_takeover(old_napi is gone, so probably take id from napi_storage?)
> > 	  - if napi is not hashed - safe to reuse?
> > 	- napi_enable
> > 
> > This is a bit ugly because we still have random napi ids during reset, but
> > is not super complicated implementation-wise. We can eventually improve
> > the above by splitting netif_napi_add_weight into two steps: allocate and
> > activate (to do the napi_id allocation & hashing). Thoughts?
> 
> The "takeover" would be problematic for drivers which free old NAPI
> before allocating new one (bnxt?). But splitting the two steps sounds
> pretty clean. We can add a helper to mark NAPI as "driver will
> explicitly list/hash later", and have the driver call a new helper
> which takes storage ID and lists the NAPI in the hash.

Hm... I thought I had an idea of how to write this up, but I think
maybe I've been thinking about it wrong.

Whatever I land on, I'll send first as an RFC to make sure I'm
following all the feedback that has come in. I definitely want to
get this right.

Sorry for the slow responses; I am technically on PTO for a bit
before LPC :)

