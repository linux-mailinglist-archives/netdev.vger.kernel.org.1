Return-Path: <netdev+bounces-186953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E7AA4310
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960989A53C1
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655741E832E;
	Wed, 30 Apr 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KNnSl4CH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937C1E8326
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994307; cv=none; b=aUsmEDz1aLrC361McRnvK/NL1GN46yQgJ1qgMTx0kk8oGvaKi4I5gc2jEILwGUAKIlKzZxSmI9IxuHB/rEmMjDQm0JAxzNHohEHC+TOpp6FFMNpoIeN3VPBvsqxiaWhkgUq6dmZ1KjoYVYNAyzcpONHlQbjSv1OSt2L6Hqtw4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994307; c=relaxed/simple;
	bh=CrYNOYrVWgHcAXr32/MkZ9CMthTKsvRzP1kvgqLX690=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbGvQ1qc16i+3lXGOiD/6BdrvsHEwcM7hyK2o05odz2qnzGiH095tDc3FVC6EJw8ET5RI0EOkc/Ee/mC/32XRcTM9nYNKwix3gilm/RaFajyoONK2A29wcU+5ccnyMMHkH1DzrR0f0TUupYxpuQ4QE0LoQGOiIvzW7+0suYWTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KNnSl4CH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so1009653966b.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745994303; x=1746599103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7AU6d+Y3jO0ylDXnXm/CXY1qM0nY+0N18voPCsqckM=;
        b=KNnSl4CHPfIU2BicabQOSSPkmGUCJmVU2xH54DOTrf/RU0xcCIDHIYzqhPOmf1hESa
         zv+XqO+D+Wz7HdxpfYForTMbpTjQMA5T6Iy/v9eKLYQ5vPPL3H9QZ6yOc82UB3SPvlZ1
         fGmFJ0Qzg5jQLWZ1+kGAKPOL39MoZWfOLHefVkyU1S+ImWoDdN9KE8P4UFe2TBLrjtxp
         YOnGSpPJNPIxS6K26S1/JSbfFGHWlaU+2giNuwIseTlCGiuqMJrTPThS0fnQdFeuRu93
         hDirL9vhnAvh/yMGCI3R5qMg9SX05UuTSzuq3WpxksVNMSmbBpCpITC4S1H+kX9LfKyj
         3foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745994303; x=1746599103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7AU6d+Y3jO0ylDXnXm/CXY1qM0nY+0N18voPCsqckM=;
        b=FhtYG93xLUwjuN7DPzwq2OkOQo+cJ/GftcxfnBlLAc+KezV+NB06u6+h5fUhEsR4x7
         m1tbahweYG+srT5rn0MZ5U7AqrGxlws0qRTG9OWB7NqKZBP2au3h+cwuwuhZho+lPfrB
         Jt8M873BFT44jRZ38drG8SWjJi4vLuzuVLz2fe456h7csNM/lrYwprm5SL6aD4voM0Jf
         /2MORZU5hx3JgGwiKvVUd8SAKtAE7nWrDHVIB6cv6fXgzuP+g96LyJ+5GFWRRh6r5Yao
         xTzdBQ0aZ4x+dIuuiSieY7c7ddpf4GqWieH05GDBE0hudNEM83in7ke0eME6uj/mDti+
         /0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXzzlnELyOPprl8IuORFgqaEwvuBn2P4k0tWU9QVJugMN7FoWGY09QVvnKLpPdAG+OJd0C0G9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhIaeeSnqaKDkwLUNF2Ba4hGhAWI1/CJPV63rUDlaNq7G8mhb
	YqkPnqVcxgjsq/Np87IDJqg0AhshEl0muWs2NQAlNilJntXcX5X1AVkmJQp03ts=
X-Gm-Gg: ASbGncsFtxdd3fNY0iJO8Xc8mzcZHC6pIdLt24OR2PCRJqdgju2LNxYXINdD0XomCmX
	buOfZfNtXc6Fro2UvVRXawLpUKTzyWTavDwIsF4vKKdcBdZhN78xiooiwKjdR8tVxRSbSKFrTUJ
	czk1K/IkswCO0FtCCcwwVdxgHbo8f7Jw9+O6R6OvHkigGzgEevT1GlVAlnFlgi1aV4HpAxazeHw
	E/PaCKUrSpfAehcTo6mrdU4Sppuv77nri17rEhbbkXMTTiKSYjQlrTJzwmxnBI8lXc1wg0dKt7L
	lfTSPVE4z54qK9uDRdqOdXcl2esaO1Ds5dFpiHy9MbrDGDQR855dLd7mULDtg/xF66zE
X-Google-Smtp-Source: AGHT+IETnsSDEDjvjP1kfizOl3Re+byY5cPctnT9Vjf/cIeWs9tTPoPPmGvE8UtuHM6mGqZv1/ZhRg==
X-Received: by 2002:a17:907:86a2:b0:ace:d986:d7d2 with SMTP id a640c23a62f3a-acedc762e2dmr232162966b.49.1745994302895;
        Tue, 29 Apr 2025 23:25:02 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4f8835sm892849466b.67.2025.04.29.23.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:25:02 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:24:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <ggvcsmrox4iyozy664zz4gmp54s4s67gbgfldgkx4i4vdebfsn@tnn3ozx5yiol>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-15-saeed@kernel.org>
 <20250428161732.43472b2a@kernel.org>
 <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
 <20250429095809.1cbabba4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429095809.1cbabba4@kernel.org>

Tue, Apr 29, 2025 at 06:58:09PM +0200, kuba@kernel.org wrote:
>On Tue, 29 Apr 2025 13:34:57 +0200 Jiri Pirko wrote:
>> >I'd really rather not build any more complexity into this funny
>> >indirect attribute construct. Do you have many more arrays to expose?  
>> 
>> How else do you imagine to expose arrays in params?
>> Btw, why is it "funny"? I mean, if you would be designing it from
>> scratch, how would you do that (params with multiple types) differently?
>> From netlink perspective there's nothing wrong with it, is it?
>
>The attribute type (nla_type) should define the nested type. Having 
>the nested type carried as a value in another attribute makes writing
>generic parsers so much harder. I made a similar mistake in one the the
>ethtool commands.
>
>We should have basically have separate attr types for each of the value
>sizes:
>	DEVLINK_ATTR_PARAM_VALUE_DATA_U32
>	DEVLINK_ATTR_PARAM_VALUE_DATA_BOOL
>etc. They should be in a separate attr space, not the main devlink_attr
>one, but every type should have its own value_data attr type.

You say *should*, but where's the rule? I mean, the reader/parse is in
charge of determining the type of attr. How he does it is up to him, if
it is fixed policy or some dynamic means. Why not?

Looks like a matter of personal preference to me.

