Return-Path: <netdev+bounces-120956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49195B485
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD38281E44
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649717D374;
	Thu, 22 Aug 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DoY11lvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275713A244
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328181; cv=none; b=tFxG+TmmiOXA82kJyqJEjOVojhgLGUt7HOMQom8zRnVrGKI3+j1ldk6hTc4uKYqUtyU95pj2T1r7g19l/CtRYiSFSyisPN/Myfq/1rFXWIfG8T9R0O5nf0FXQCmrTZdcWZtksUMpHeEGoKFWVWASQMa5yVEqZJIjaJgARLUtmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328181; c=relaxed/simple;
	bh=1dyCqCmD5O3KppCbAZ/U9xSrslY4izbZwRJHPbcdpJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMmB9xbtR9Lfhl9k9btSK1fs9G0YC4a4NVJf0Us05sUhx/vudbR12P6diYUQuuSEX6KaYJGUrVsZUkVaOyipxKhtf4hXXAmogc1LzEvqaKFoSo8W6DYrl62GseS99AyiEL5Zv1JzU/h9CeD5cXFaOownMPkwcbgtL/yYX0m8wCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DoY11lvl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so885953a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724328177; x=1724932977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpnLaDjfkpjXWDBY0nDnw+SJJO1zQODRX6cGDZfJXuA=;
        b=DoY11lvlYH6r7eNLcAk+U9+wMbHHOa+S71Kq74DP6leYmc77zeUojU0Pk6bOXIfkys
         i25DOsBMaPeIngiXWM3nLDy+bYZ2uMY+OLcZzk9VEDEtDhcNZD924cHNofYVCrK+jQLL
         xqg3nYtxcbvKvvP49+ilfalnXW5oRBUjRc/kIjS6B4QKOJacFgBcWdc2K5G8NQ/kiWIN
         CbFlG+v71Q2pEtQFjjI+J3pMjTvkj36a8tCJESrEQ6ky5w1Qg7R7oxDQeSlGft0ug0oD
         OmGmrBFqGhxeXKpqYURVb3LeYnmjZtIJQ44EZNDX38Cr5aRbQT297o3+sBxHZ0f8SRGs
         mRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328177; x=1724932977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpnLaDjfkpjXWDBY0nDnw+SJJO1zQODRX6cGDZfJXuA=;
        b=qV/ifPKH4Qf2p+m3z0aopo9jJnwA2V8pnPJj5y3HvpjdniHkVkgjbqn54nB4bfTXp1
         HZNDmIOmVQzd2MhTJaY12uqRgr0epbj+QDZBVCEEakiwqeFCxkSha7yLju4qYY2GEVit
         HF1fKKNX+0jOW8orJcxdrZBKt8GILhL/Vh/Nuaz9anJCtCGoIdUjoG0fo74yMc2Zf9Aa
         HHGtYCApbd5u+rUdXNwzS53G2ZJ5MZuwSJpO9YYEY1+D+OBgww6UPNOrIKpO4EQJ7BTu
         awjHwwZ9oVl62PbrFqAwg62Y7Jze7LiNqxyhYlynNWmt0KFwU67+jJP7Ipu+1NiTI/sQ
         RKAg==
X-Gm-Message-State: AOJu0YxHRGtGCElpxrskoQ4SAqc70iNBuJxZW+OxF8DhuEgd1LB/iK4j
	3USOQxg+l/XlJrzJmJtlOIhpyx3I6zRaVrBam+eBny5bBCDBQCDeHj90KhQbLdUyLxiHRLhPfK8
	H
X-Google-Smtp-Source: AGHT+IGzCuVMKecnzuhqA0DOmWyQvUmuFzXUgh3mF5YjPOEHEOhJwy47hQ04DUEtHmTSS04W4gm2aQ==
X-Received: by 2002:a17:907:60d4:b0:a86:83f9:bc2d with SMTP id a640c23a62f3a-a8683f9c133mr249598566b.32.1724328176722;
        Thu, 22 Aug 2024 05:02:56 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220324sm112063666b.44.2024.08.22.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:02:56 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:02:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <Zsco7hs_XWTb3htS@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>

Mon, Aug 19, 2024 at 06:52:22PM CEST, pabeni@redhat.com wrote:
>On 8/19/24 13:53, Jiri Pirko wrote:
>> Mon, Aug 19, 2024 at 11:33:28AM CEST, pabeni@redhat.com wrote:
>> > Isn't the whole point of devlink to configure objects that are directly
>> > related to any network device? Would be somewhat awkward accessing devlink
>> > port going through some net_device?
>> 
>> I'm not sure why you are asking that. I didn't suggest anything like
>> that. On contrary, as your API is netdev centric, I suggested to
>> disconnect from netdev to the shapers could be used not only with them.
>
>ndo_shaper_ops are basically net_device ndo. Any implementation of them will
>operate 'trough some net_device'.

I know, I see that in the code. But the question is, does it have to be
like that?

>
>I'm still not sure which one of the following you mean:
>
>1) the shaper NL interface must be able to manage devlink (rate) objects. The
>core will lookup the devlink obj and use devlink_ops to do the change.
>
>2) the shaper NL interface must be able to manage devlink (rate) objects, the
>core will use ndo_shaper_ops to do the actual change.
>
>3) something else?

I don't care about the shaper NL in case of devlink rate objects. I care
more about in-kernel api. I see shaper NL as one of the UAPIs to consume
the shaper infrastructure. The devlink rate is another one. If the
devlink rate shapers are visible over shaper NL, IDK. They may be RO
perhaps.


>
>In my previous reply, I assumed you wanted option 2). If so, which kind of
>object should implement the ndo_shaper_ops callbacks? net_device? devlink?
>other?

Whoever implements the shaper in driver. If that is net_device tight
shaper, driver should work with net_device. If that is devlink port
related shaper, driver should work on top of devlink port based api.


>
>> This is what I understood was a plan from very beginning.
>
>Originally the scope was much more limited than what defined here. Jakub
>asked to implement an interface capable to unify the network device
>shaping/rate related callbacks.

I'm not saying this is deal breaker for me. I just think that if the api
is designed to be independent of the object shaper is bound to
(netdev/devlink_port/etc), it would be much much easier to extend in the
future. If you do everything netdev-centric from start, I'm sure no
shaper consolidation will ever happen. And that I thought was one of the
goals.

Perhaps Jakub has opinion.


>
>In a previous revision, I stretched that to cover objects "above" the network
>device level (e.g. PF/VF/SFs groups), but then I left them out because:
>
>- it caused several inconsistencies (among other thing we can't use the
>'shaper cache' there and Jakub wants the cache in place).
>- we already have devlink for that.
>
>> > We could define additional scopes for each of such objects and use the id to
>> > discriminate the specific port or node within the relevant devlink.
>> 
>> But you still want to use some netdevice as a handle IIUC, is that
>> right?
>
>The revision of the series that I hope to share soon still used net_device
>ndos. Shapers are identified within the network device by an handle.
>
>Cheers,
>
>Paolo
>

