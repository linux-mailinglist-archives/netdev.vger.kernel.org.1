Return-Path: <netdev+bounces-68322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DC8469C0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449871C20398
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424381775E;
	Fri,  2 Feb 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BkG/wLDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEE17BAC
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860024; cv=none; b=ZoM1LC9uYttZfkRix2l/87r7bwtesl8gO3RaZL3oS/ljFE98PrPmjR1jGL4bQyK5mez0qYFJIL8ORitG87+MPQH8BLi2cquON8oinwlhq+MyaMHhjceFtH0LC/w4qzNNoJwzZgQoI1pBYlxOKVqPdxlnjTjYGRBfUnyyCRi6wRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860024; c=relaxed/simple;
	bh=zTpmsjzrinvpuVifqqyj9McJ5sPZ4iquKbn34GykddI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaLUfQx14R16PZ5DBgjjjrDosXqBV9umBrqQdnMBKzLGG/hNLGNjxnbFvKpC72DKoENkBsTiftiuqePlajNsKQcRhoxmDkbBHkbDtqUglEa0TbPdy+SIARppJ+xEBfgcvSd5/LSIRTh2/9yufyFiZ5G+HmEGO2hfZvkMkAiVTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BkG/wLDN; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2d043160cd1so20891611fa.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706860020; x=1707464820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umVLAUVuC8fGiqJOrcxqcnirOPPoxmUT+3/smehpeQY=;
        b=BkG/wLDNKm1Pg6tTUt8pL2735lMh/vpDLO93ZIVDDfIxLtBvlqjT/TykjTEZAWetO9
         UYTLtOaR7wJKgWOBLEKdIvzt5byfgZ995Xdz9tBNOpaIBU1J+S4CsDp7RRuvRpdQ/GAE
         XEPFEDiWQuhBkVJW4u+WwlkurRFpf0xgvvBJBcqvBFuOyP1SuOhuzE8yxmdAeFAwARxF
         iCGyFV937cjwT31NkecSqbUvf6qLpUAdaLGX6njAdGPDJ/eG5fkKuZJUM80KhnQoJXkR
         NAknSA1cevAzSGrGYeXz3b9N8VSI3Tr8RJhbkWFGi4klvJGRAaVE/SLUR5H9o+QdVkF5
         cQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860020; x=1707464820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umVLAUVuC8fGiqJOrcxqcnirOPPoxmUT+3/smehpeQY=;
        b=TH4/jtIKK0BOb3K4LC7WELyuTBEwan95VWVZA2slAKCx+tggB0HlJbP9+VsfKcKnxa
         HbHuLZjBp0cDvObp0U2K69pGMFU87NR+Q6cr+D3H+1okr+BNI6evInkII7I3XKsex/Mc
         sZ84YynGDLuXtoTDos2k5wXAUIKpmMjfzert6uVhDSFQsCWflKQkiCVyYsB97ElogRby
         FM8UolDG9bMY+zsyYHKZ7dOGYsDLHByBH7EjPqXm3dsX4BMi1SUHjkeTwpBaP7VfS3L5
         auLDE9om7OXduKe6EB5CLkc2O2nBXgRBEyy2ZAAsgYlb8wMG9mp3jM7UX2+XS9NKSog2
         0NHQ==
X-Gm-Message-State: AOJu0YwJ5lk8+hOFhsRWiIDd43/b1fhG0Iu/rUQlR2xccc6rxV0JUp8m
	SZ2j2lwSN9fjyvXVwDS1h0e4sJjTKJvCs+g9drHLIMRWQXIvBAwMa2xbDLS8Kl4=
X-Google-Smtp-Source: AGHT+IEgi7x+cmDlc7XAhdfSEcLla3jqLoFo2CdTI40RjEi1//diYQhE2M/bj/rDnidZp9NVEn3/Wg==
X-Received: by 2002:a2e:8e8a:0:b0:2d0:7c54:1c13 with SMTP id z10-20020a2e8e8a000000b002d07c541c13mr649023ljk.47.1706860019984;
        Thu, 01 Feb 2024 23:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW162CGAoKHb5hyvcPiFYV8SQj997zBlDMlSFmGNEAAoqs2XKZEKYO80t31GcvqRDjlSFLVplizsE1BLCdSf9t9kZA5VG69+l+WgQQ5oXG5BsdM4bblDjgv4L96E7U4eSvO6zryjIOXbfZ33JW3KE3E9qs6OSVbSBG/IOa7x17rPtz2H72GbjAY9DR5TzDlKZji0IHGWYK5Ozu2nsqdrNgx+oWWBRoy1GbS++qFy4wpy8qKVE1txmtC4zTGY0Jwo+bM9H+EkNHj
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e21-20020adfa455000000b003392b1ebf5csm1319038wra.59.2024.02.01.23.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:46:59 -0800 (PST)
Date: Fri, 2 Feb 2024 08:46:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zbyd8Fbj8_WHP4WI@nanopsycho>
References: <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201200041.241fd4c1@kernel.org>

Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
>On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:
>> Thu, Feb 01, 2024 at 12:17:26AM CET, kuba@kernel.org wrote:
>> >> I guess bnxt, ice, nfp are doing tx buffer sharing?  
>> >
>> >I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
>> >I'm 99.9% sure nfp does.  
>> 
>> Wait a sec.
>
>No, you wait a sec ;) Why do you think this belongs to devlink?
>Two months ago you were complaining bitterly when people were
>considering using devlink rate to control per-queue shapers.
>And now it's fine to add queues as a concept to devlink?

Do you have a better suggestion how to model common pool object for
multiple netdevices? This is the reason why devlink was introduced to
provide a platform for common/shared things for a device that contains
multiple netdevs/ports/whatever. But I may be missing something here,
for sure.


>
>> You refer to using the lower device (like PF) to actually
>> send and receive trafic of representors. That means, you share the
>> entire queues. Or maybe better term is not "share" but "use PF queues".
>> 
>> The infra William is proposing is about something else. In that
>> scenario, each representor has a separate independent set of queues,
>> as well as the PF has. Currently in mlx5, all representor queues have
>> descriptors only used for the individual representor. So there is
>> a huge waste of memory for that, as often there is only very low traffic
>> there and probability of hitting trafic burst on many representors at
>> the same time is very low.
>> 
>> Say you have 1 queue for a rep. 1 queue has 1k descriptors. For 1k
>> representors you end up with:
>> 1k x 1k = 1m descriptors
>
>I understand the memory waste problem:
>https://people.kernel.org/kuba/nic-memory-reserve
>
>> With this API, user can configure sharing of the descriptors.
>> So there would be a pool (or multiple pools) of descriptors and the
>> descriptors could be used by many queues/representors.
>> 
>> So in the example above, for 1k representors you have only 1k
>> descriptors.
>> 
>> The infra allows great flexibility in terms of configuring multiple
>> pools of different sizes and assigning queues from representors to
>> different pools. So you can have multiple "classes" of representors.
>> For example the ones you expect heavy trafic could have a separate pool,
>> the rest can share another pool together, etc.
>
>Well, it does not extend naturally to the design described in that blog
>post. There I only care about a netdev level pool, but every queue can
>bind multiple pools.
>
>It also does not cater naturally to a very interesting application
>of such tech to lightweight container interfaces, macvlan-offload style.
>As I said at the beginning, why is the pool a devlink thing if the only
>objects that connect to it are netdevs?

Okay. Let's model it differently, no problem. I find devlink device
as a good fit for object to contain shared things like pools.
But perhaps there could be something else. Something new?


>
>Another netdev thing where this will be awkward is page pool
>integration. It lives in netdev genl, are we going to add devlink pool
>reference to indicate which pool a pp is feeding?

Page pool is per-netdev, isn't it? It could be extended to be bound per
devlink-pool as you suggest. It is a bit awkward, I agree.

So instead of devlink, should be add the descriptor-pool object into
netdev genl and make possible for multiple netdevs to use it there?
I would still miss the namespace of the pool, as it naturally aligns
with devlink device. IDK :/


>
>When memory providers finally materialize that will be another
>netdev thing that needs to somehow connect here.

