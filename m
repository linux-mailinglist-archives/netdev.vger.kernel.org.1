Return-Path: <netdev+bounces-112609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E293A29E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C86B2306E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7915442F;
	Tue, 23 Jul 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dccVrJEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A214A4E7
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744560; cv=none; b=d60jXAWytPEJxFNtTHPgQsAJdLZMUl+JgNwv2PCq9tEszpHi4CewuzoXWqNPnDfwQGO2fIRCqaHWuRF0wkYcqZIIDPA/9W3r0mwe5qmUrISautLuRCH8sbvyyPXAomTUUIOWudi05KmmTkrIZMZu9tyjyw6hXB61+8QH3yfKo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744560; c=relaxed/simple;
	bh=a4hAJEUFvTX7V9Ox6nbnE3H35VtxyxCP87bGBZRQWmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di9bRGX3bCbqQ+YovyrOz/FqXhDePhf7Ie67RaOG1BOdo5Dup9jN36jMemOkZKZPpQGHyXxwfuqJkK+huZKg1B2SStD59lBlVkrkQYkAUM+EGp3r8kUjf/sVE2m9AFF2EmzDKQR+I+kA/g97ccctGbbjQcM9rPmYrIKyfzc3m/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dccVrJEN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so6932465a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721744555; x=1722349355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lB+I72oA3HTuOu589/Vj2pzfaW3IoL/d8EUbjB1wvTQ=;
        b=dccVrJENJfFfTC/6kHeJLFRL0WRaW5D31KUXkGAw3lq1Q1vY4h5vySJKamF+EPvXPI
         zR2UlDcd+9vt8e8ozuYWfyjymN46jIqY3YK21pJPiDJybHzF78zciUp8uLLTnGt13QJs
         gBrfFNYYCPEWEfoEDPXnTC62kXxkEqK6Jeb+Nztukg++Do2a0iSlnkyqi1KVXnnWd5TM
         dyYZ/vMoUeMzFe5BylqO489XndpeSFkcu8vI9ewuejxGRzkfGwv+99Kk0Y1/m9g728Cp
         IPdpy+VTsShcKj6Asn297len4hHfsNLIJa82sVqWPXJNC5t9aIbKf3IEAJod0dT7372j
         5k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721744555; x=1722349355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB+I72oA3HTuOu589/Vj2pzfaW3IoL/d8EUbjB1wvTQ=;
        b=g7bzFus4sKkNNxTKn5hi8EvtZXlmxPI/wHiKxeNkJvSqOVn3+wsfOQOwEf41bpl47l
         w3TMRyjykdeNXfInIs/aAsgHzYoXtWVWS2qoxn21ZfRMuP0rDf3a0nIMVuY01tL+8DS1
         7mw8JTzOGPwJT7JZ382VIVaOBYuxkD8bq1+iMMJ4/SwAcQab11oxHNGDj5sgm2ftj1ke
         xrZ5pwpY/sEaX8nM+zgH/9R7GCN1YvvdN9vL1laxG89q22q4we6XM9egi4EUy1GeVzmv
         uyddkDp2EVf26yfcelv8rpIUez1I7RQrrYykPut8ndUk7MzuwzCCIj/er+F+xk3Aim47
         ee7Q==
X-Gm-Message-State: AOJu0YxLYGcZY658/lwb/OV26hN2VyJVawvjBUBFLhq6WsPQF5eeCoVz
	oZG8tqwbY2avt8tJP8lkCe6NyBW7fH3iDW0Ks1I0IPR2wiEXhEusHDh7wfyZysU=
X-Google-Smtp-Source: AGHT+IHnu/cpiWjyYSTSZz+OxGvrjSTprSv7oBW9A1IsAzw0SLWXBRy2s3l9wTK9wBlBLWryRkThyg==
X-Received: by 2002:a17:907:7244:b0:a77:ca9d:1d46 with SMTP id a640c23a62f3a-a7a943c1d0bmr251141366b.33.1721744554556;
        Tue, 23 Jul 2024 07:22:34 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9177fd3bsm93732166b.182.2024.07.23.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:22:33 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:22:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC PATCH 1/2] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
Message-ID: <Zp-8qM7178LYGJ_q@nanopsycho.orion>
References: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
 <Zpo0_CoGmJVoj8E7@nanopsycho.orion>
 <59de0f9b3c4f59f7921cafb2115478fed82b1c4c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59de0f9b3c4f59f7921cafb2115478fed82b1c4c.camel@sipsolutions.net>

Fri, Jul 19, 2024 at 06:31:18PM CEST, johannes@sipsolutions.net wrote:
>On Fri, 2024-07-19 at 11:42 +0200, Jiri Pirko wrote:
>> Thu, Jul 18, 2024 at 09:20:16PM CEST, johannes@sipsolutions.net wrote:
>> > From: Johannes Berg <johannes.berg@intel.com>
>> > 
>> > RCU use in bond_should_notify_peers() looks wrong, since it does
>> > rcu_dereference(), leaves the critical section, and uses the
>> > pointer after that.
>> > 
>> > Luckily, it's called either inside a nested RCU critical section
>> > or with the RTNL held.
>> > 
>> > Annotate it with rcu_dereference_rtnl() instead, and remove the
>> > inner RCU critical section.
>> > 
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> 
>> Fixes 4cb4f97b7e361745281e843499ba58691112d2f8 perhaps?
>> 
>
>I don't really want to get into that discussion again :)

Which one? I have to be missing something...


>
>Thanks for looking!
>
>johannes

