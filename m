Return-Path: <netdev+bounces-187415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915BAA7084
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD2116D808
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6B1C9DE5;
	Fri,  2 May 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QfayfuBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DF4C6C
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184573; cv=none; b=X52+urnXMhtHSA1ro9ptj2wZ99mtBuRIvcDm5e/nTHEtA9pgJU840kQld3aroW2+9teacXChprHT3Z2uwrqhEM2VILme3UXptWws+jMW8NSDtlWIZrBAgHquDr/hozQNGwrFeZfvvyNL+Vu3yrQxjKb9FLWmj8qqOE8fSeQXcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184573; c=relaxed/simple;
	bh=Tv+/s6m/CaO+1O8ASwNFBZlOBl1/jHpZiumYU+GTt5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKq6aBBREIpAeIz0MQD5vT/YRA1KNyQedGScudqwSE7tLG3SLZiGZS7DcuirTwLJlwNSM6Fi6i3z4i5Q90ITDFFlivq96bv1TKo52ARIM/K+JkoEaV2SROLEjJ38cEPgmsY0DHDaY7oI91A7ZStnBxUwK70CW/+ITuKoToxAtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QfayfuBP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913b539aabso811145f8f.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746184569; x=1746789369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PP3h/Q/pJLMgZyzN8eLoTIRCBSRQBrx3iolLkmI89A=;
        b=QfayfuBP9ecL2/BO3X5GwZiFbMc7Asbcrh4QsxbLccaq6yCiKuWytK/tM2tVGqzA/r
         tyr0V7IcsygPmw4Y0y4sLxIOZQnGnQ8PeYm5lMTtOhjOuydYOGmINQvgEjWmkMooZuCG
         tsc7rWEIhUkNACllbHnI1vp7W/jMryZS8LZu0fDSExnOpEfW3AQZg5YTeuiPomBpwthK
         FuaO+Aqo6MKFPI8aCy3Mchv8EXBX977xp/UcPqZ5pbK4/awA19S8utCwTjN3F/fVAVCD
         +XzWn5DVvBFlFzum9+juX8BABcSZEegpYK1HNodPBMse66jqS2+3IKYj6YpfIlafC+9h
         ZsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746184569; x=1746789369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PP3h/Q/pJLMgZyzN8eLoTIRCBSRQBrx3iolLkmI89A=;
        b=FbeMQP5+jW6xn92hKhLBhKGYGH1NiQQRvdTpcSyUDg5yjRzIOF+oZ5W5847qhzTY5w
         TmR7Dbu4EThWUC6cAy/teN8Pe+FvcHipIUpL33HtMIk/fZyAA3ZDnWvU+mkE3esRKxS0
         ZhUVdHc11kq0vH7uDPtXKzkBCK2h/sxpyq/tCcVLoYKgO9wCPxZhE4Zb9P+OYIW2Bfxm
         0VXtWjd2AohPcwAifL6KKXod5tBaSltITy1WsGr6AqIx7+i0Nfa7sL5l0ZbGkpYnFu2a
         8sG5dlYXPjINuDDmsscyjNNPi/sX1JirGxO/h3hVnq3X9n7noJd6DBGSjg2Y7GVwyTiv
         NDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGtM31QbloNSEt4CNtxZTpPvp9vdOSRMOIEe4R9w8BC3Xg5mDb16JQy0T/86DdpInplfDAJBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GRSZCne6k+7rtaE/nPjz242rrRHAMyAOTW96cb8nLjuan/J7
	jOXr/so59cvvKZW8KFNqhj6Wy4vIrL49x55f5W5ErhKbWN2FKsFQ6sHFhrCHlLs=
X-Gm-Gg: ASbGncsl7hn84SOYAORvEe1CGTeVlT1VxhLrJvtY0Jxcv9l6u6z+vDBkoHsy6wHcvyh
	axoTV95TQyI9zNoZbL9+MbXINyJdz+rJ4nzjAItm5oZEoUEGUyDYMjHXdsFE2aieYlCzjQ/Uvau
	Ro+h7Tcg3FhwM9/FonwfEMWcmWRfFAkolMlEhhCxXD/78hU7e+hc6jNWItMyirFpOWGhd2pGpat
	I/+0wk0xjO2RMRSonJwkeZRQYh/BdrZfNInLtbj3ME3fowUAHwobAabAdQRSbtPALkHx05Zy7pL
	MXZBy0zki+Eb+g3F/4TG2UodxHWKL5KXKP8t0AyE2ul0Bczn1SXBONk=
X-Google-Smtp-Source: AGHT+IG8xBQmDZUAQIN+kNxrgworN8B8mcxJMDECnyxLxsQHFd8Es+lYhptKl+vgOGpIy1XTWcWB/w==
X-Received: by 2002:a05:6000:2288:b0:3a0:8ac0:e496 with SMTP id ffacd0b85a97d-3a099ad263bmr1759982f8f.7.1746184569420;
        Fri, 02 May 2025 04:16:09 -0700 (PDT)
Received: from jiri-mlt ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7cc6sm1911006f8f.55.2025.05.02.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:16:08 -0700 (PDT)
Date: Fri, 2 May 2025 13:16:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <x6dxuv4fakclafbubk22akzlrsu43ds24jgj6t4uqtx7tpmim3@zxnggsxzh6sc>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-15-saeed@kernel.org>
 <20250428161732.43472b2a@kernel.org>
 <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
 <20250429095809.1cbabba4@kernel.org>
 <ggvcsmrox4iyozy664zz4gmp54s4s67gbgfldgkx4i4vdebfsn@tnn3ozx5yiol>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ggvcsmrox4iyozy664zz4gmp54s4s67gbgfldgkx4i4vdebfsn@tnn3ozx5yiol>

Wed, Apr 30, 2025 at 08:24:59AM +0200, jiri@resnulli.us wrote:
>Tue, Apr 29, 2025 at 06:58:09PM +0200, kuba@kernel.org wrote:
>>On Tue, 29 Apr 2025 13:34:57 +0200 Jiri Pirko wrote:
>>> >I'd really rather not build any more complexity into this funny
>>> >indirect attribute construct. Do you have many more arrays to expose?  
>>> 
>>> How else do you imagine to expose arrays in params?
>>> Btw, why is it "funny"? I mean, if you would be designing it from
>>> scratch, how would you do that (params with multiple types) differently?
>>> From netlink perspective there's nothing wrong with it, is it?
>>
>>The attribute type (nla_type) should define the nested type. Having 
>>the nested type carried as a value in another attribute makes writing
>>generic parsers so much harder. I made a similar mistake in one the the
>>ethtool commands.
>>
>>We should have basically have separate attr types for each of the value
>>sizes:
>>	DEVLINK_ATTR_PARAM_VALUE_DATA_U32
>>	DEVLINK_ATTR_PARAM_VALUE_DATA_BOOL
>>etc. They should be in a separate attr space, not the main devlink_attr
>>one, but every type should have its own value_data attr type.
>
>You say *should*, but where's the rule? I mean, the reader/parse is in
>charge of determining the type of attr. How he does it is up to him, if
>it is fixed policy or some dynamic means. Why not?
>
>Looks like a matter of personal preference to me.

Anyway, we can't do this for params as it would break the UAPI :/
So we are stuck with the current approach.

