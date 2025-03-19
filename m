Return-Path: <netdev+bounces-176096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D24A68C06
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A6D7A6B9E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B125487C;
	Wed, 19 Mar 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iRx/tlYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4820D4F6
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384564; cv=none; b=YK1gfXD6lpZzMEolfrG3Z8YTWTc93N8BOT3dFC07G1xlCWM7kMxVlv01LN5jOuphFzBrhWG68HzUNQH6Room2JOQrQjih3KXn+Z1XVsLs5OPBcfCbf2CoA8WM6FeeKwRKVYTuRnbMj9AwByCEQcZri19TjxSVKjsEzzvxjjooWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384564; c=relaxed/simple;
	bh=MPYg0r6YPJPo22X4LHmppBpwJG6aL7W49QbCUseJvbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUyCAxQuQl1LGfXhNcfppjPEL32cJ07qCpUIvOFCGwZ7esgHDm63J/F9zD1HdtV12gda9/J5bsJgSIIpNM7eCi2NIrT1udxkk6v8SiUKijCnfj9ZYJgSG2dnFMYs5sqcqdlofGjXzdnXzHElFDZaL6G1awwMpyxkG5t3tfpLtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iRx/tlYW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso21902445e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742384560; x=1742989360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vL33lg17QB7Kpc9GmfRoPhFNJaj6oQhniCMLnkqc81w=;
        b=iRx/tlYWpPNYgb5FV42IlfXWPTbq7yXcfZNGgD+bdRlR1ZwmwTF1nd+6hA9DIvc+nA
         HQ1C5lnIQqMPp5YHLtRqDnu480AvR5HtkslWramSJRYkX6CySGkrNf/YUk8JKfCEN96p
         wH27+zTuEj8wHD1azAjvh7QNVhymZtOvqKuO7jf3FA15Uijr+TZVHTL8XA0cuSEgsJBD
         l4UpEVF3hnTjappUVXpxwbW4Pq9UnBm3SwY8CGQFl+dOsKkkOV0TaCh1v/kLCpiSndgZ
         NN2qsEwjcGHYLt6QZSxF9XCRCZLroUOoIuDP84RdvH12IrkWV43mGyshdKoyxZ76QOFz
         HRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384560; x=1742989360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL33lg17QB7Kpc9GmfRoPhFNJaj6oQhniCMLnkqc81w=;
        b=t8MPOQgXDx2UZCTD1SiDYe4w13dKyWnkRxVRyXGWYDNm8SvdXs3h8KOlgwO90ggPYy
         7HO6po/ADIzH0KQeLew/fp1zGdDUSlcDgjyRI3Acilg6LTaKtGnWddGVn92KLGnSex8M
         /1H8NujNHcyOOoVI8VKcCUSuLg5mze1yPp6rzV+psoTrfEEtL0bA5ZwjJy/D6x7XVLDK
         85yzKRgLkMuX7yy9hW94ydlXaty6MLBRqeNkpYsjkJayQiWLkPDokZRvl3yPKDvqET6c
         eooNOR3wIP+Cc9iKXvi0PdbgKs8bRtjteeD9iO4Y+9NQYMBOUdv0XVboXQ6IJfyZAQEz
         p4Ng==
X-Gm-Message-State: AOJu0Yzt519J9z51WPfazBSAtoZWs145A1NZQL0cmbbIHWgxTUdEetIl
	96VOu7TdBA5Oql3NHorhGchLqOofu0bCcuJNgtOS92Dud/t3AOnmbPmQEJN7JBU=
X-Gm-Gg: ASbGncun7QQS7ic7e/c4hBW8HmWnku1gpKT1Iu5tcAPc6zssXSj9gevnuzn2XgQuGrZ
	XKbd8sIcgbh16dK5gFpMVhdslLIn++IUSMxksk7AXW/B94J5C/YACmgDOeQbfNXmH8E6UwfGBd2
	macErtukNmc/OJ5MePO3ej62+JQDfM/8k46foltedlmlnNTKmp3oDiE/0nNPkcYFyyWDs7VKqK2
	++DJd4v35ARaFPL3cX93v9eppfSQxexm4TDrhkIYTR4o4ZgIJmElGnxtJedU/PoHTzyrUnUCfG5
	1pA+acQ6HTv/nxo+30qpCY/dspl18MD9vNRQqgWWgySIvXhwUguLgq2uf7np6DhQ8S8Sdd4=
X-Google-Smtp-Source: AGHT+IGujRnrp2FLRBt9mzWvz2w0aFKjp60UmAYF/GioZ5/YeD4GfjnO7lHCw6sye6/1FIywlNhwgQ==
X-Received: by 2002:a05:600c:4f0b:b0:43c:fa3f:8e5d with SMTP id 5b1f17b1804b1-43d43782c00mr17328575e9.2.1742384560247;
        Wed, 19 Mar 2025 04:42:40 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f476a7sm16446115e9.9.2025.03.19.04.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:42:39 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:42:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, dakr@kernel.org, rafael@kernel.org, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, cratiu@nvidia.com, 
	jacob.e.keller@intel.com, konrad.knitter@intel.com, cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <gv6fmiz6orhrwpvbnlrlkikgwwzhq2u5icdwacfpivlmx6c3mc@dxg56wedutse>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031848-atrocious-defy-d7f8@gregkh>
 <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>
 <2025031817-charter-respect-1483@gregkh>
 <paftiyrmjuiirv7j26eenezpqlszva55w2lmsutflmt2tfwufp@za2pg2q7t43n>
 <2025031817-stench-astound-7181@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031817-stench-astound-7181@gregkh>

Tue, Mar 18, 2025 at 06:27:17PM +0100, gregkh@linuxfoundation.org wrote:
>On Tue, Mar 18, 2025 at 05:51:34PM +0100, Jiri Pirko wrote:
>> Tue, Mar 18, 2025 at 05:04:37PM +0100, gregkh@linuxfoundation.org wrote:
>> >On Tue, Mar 18, 2025 at 04:26:05PM +0100, Jiri Pirko wrote:
>> >> Tue, Mar 18, 2025 at 03:36:34PM +0100, gregkh@linuxfoundation.org wrote:
>> >> >On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> It is hard for the faux user to avoid potential name conflicts, as it is
>> >> >> only in control of faux devices it creates. Therefore extend the faux
>> >> >> device creation function by module parameter, embed the module name into
>> >> >> the device name in format "modulename_permodulename" and allow module to
>> >> >> control it's namespace.
>> >> >
>> >> >Do you have an example of how this will change the current names we have
>> >> >in the system to this new way?  What is going to break if those names
>> >> >change?
>> >> 
>> >> I was under impression, that since there are no in-tree users of faux
>> >> yet (at least I don't see them in net-next tree), there is no breakage.
>> >
>> >Look at linux-next please.
>> 
>> Sure, but it's still next. Next might break (uapi) as long it's next,
>> right?
>
>The point is that these conversions are thinking that their name is
>stable.  This change is going to mean that those patches that have been
>accepted into different trees are going to change.

Correct. I was under impression this could be handled in within "next".
If not, my bad.


>
>> >> Perhaps "const char *name" could be formatted as well for
>> >> faux_device_create()/faux_device_create_with_groups(). My laziness
>> >> wanted to avoid that :) Would that make sense to you?
>> >
>> >I wouldn't object to that, making it a vararg?  How would the rust
>> >binding handle that?
>> 
>> Why should I care about rust? I got the impression the deal is that
>> rust bindings are taken care of by rust people. Did that change and
>> we need to keep rust in mind for all internal API? That sounds scarry
>> to me :(
>
>I was just asking if you knew, that's all.

Okay, I misunderstood. I have near 0 knowledge of Rust :)


>
>thanks,
>
>greg k-h

