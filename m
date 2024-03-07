Return-Path: <netdev+bounces-78376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B6A874D71
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8FD280E7B
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFBF12839C;
	Thu,  7 Mar 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cUB3fwNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC69DDC9
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811177; cv=none; b=FcIB2vkm3HYqPABjuwiqaoFqxO98dWFCc5vVOyPn4S/cXH8EWwCws95yBOyBzgy8Y3akJwtp+Phg4pcK6c/rcDBKPlS2xbePSTwcaXm3L+SmK2zOasM35mJN8DNN1BkuPKW4pOo715QYK1oojMG6fRETLxEQIt7lKKuLcweMW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811177; c=relaxed/simple;
	bh=0j3GnZoEN26Xx0QrH4PKNNB3sNmyhZt3L5dUaaTlhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYPThh7N667dQHkgnDBKEDJShFCRncGC7kOzNG1/vAWzYu1b5sZPP9IltulMK7Amnp2GVZ1t67RrWSpqplgYRcrKsBuwKJr2LtHiA88l7GBeRXg0Kg4MsOfR7OLPEDdjUbWluCBKy70q2+8J2zujndGncULq50xcx8YVkSEo4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cUB3fwNz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28051376eso10844501fa.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 03:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709811172; x=1710415972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xS5AdlRLE2jj2VsR+edDGoh9oMkK/DcyyJfcGFpQe7Y=;
        b=cUB3fwNzccamlHKroFM93g8XtNm0FaUXdQ5mSNhRON7Mu/yhcKmqt6+xZwRkALSqfH
         HjXHksrPwbe/NH5Q8k42JaDEXI6JfgJOpX7v8T6CpAx+ZsAgjEGy3VH39Fn5u8zweG2F
         AowB0Ggi6H2KRhp7tStEZlLRYpfSl4SM8CYQOZQRQkYhrcP8XUX9pyFikTIJaX28pXzb
         qUHlUMlzv5o0BRtdWYveBj0Ej29FIswgEabmyDEwmqZP0dXtfjcqIww6+DHzjDRqUUPQ
         3ZjggjW6ZoievLTJMCg//fIa2fGd6ielAfJzDF+VWi0F+EV85lP1opNs8leekpNdIIMx
         13Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811172; x=1710415972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS5AdlRLE2jj2VsR+edDGoh9oMkK/DcyyJfcGFpQe7Y=;
        b=T5nKTYD40Oq7NAeBUrvIQaRqA/sOy//2Dri+4xJ6WBC9JjcZfqEg1UyM+7aqitTo4/
         P9hJ8W/k5y/1gRwNyyRo633VjGTQczIfJ5cNfWkkuSufoGCYeuzm1BcJIyaFtF5ghqpv
         Zd63Aa5P8z4mU+bhCaYM/lOrcvkPNIMd+8kUVBK3xVeTnP398VWJWiP9Ze3CCbfQ2dtz
         oug00SFRP4FhxBkjNy7d9uYHk3lG52aOGvqQGChlAxLbJSh9n2FrzeQkA3APzjbEVkWg
         PBGvDmTnCcX9HfeH3aNhMmOnto1IF9cJXxgZOTZiqB7Vqu+ghMOB2GGj/uyfougw2K6w
         mpAw==
X-Forwarded-Encrypted: i=1; AJvYcCWS/BP0h8ovJakVJDECRS5c5Je3RngJwa6C08cP52lREE+3AGy8q/hG86Edl6Wg8bCwZi3KVxAKx8+FuvS4dcUp6KWeq8pO
X-Gm-Message-State: AOJu0YzfqzOpmGJprW84Z45AjgpcF2C/3klopyqQyYYMDznas8d411y4
	EJT4U5WyegHuq/YEWL5NwMswYInXrOXW5xQSzMi531EDW2Pw4FG9RdrtVkYO85s=
X-Google-Smtp-Source: AGHT+IEqt+OrHvsqrEaemR/ulL95BlBVIBMcki/mI3VtzwMgKB9+A+TfGMJh3GjfoMeiu/nsWwwbYQ==
X-Received: by 2002:a2e:9646:0:b0:2d3:bc4c:e0aa with SMTP id z6-20020a2e9646000000b002d3bc4ce0aamr1241919ljh.3.1709811172086;
        Thu, 07 Mar 2024 03:32:52 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ch10-20020a5d5d0a000000b0033e26c81b11sm15312534wrb.92.2024.03.07.03.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:32:51 -0800 (PST)
Date: Thu, 7 Mar 2024 12:32:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <Zeml4L6EUmlCHU37@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-2-louis.peens@corigine.com>
 <Zd8js1wsTCxSLYxy@nanopsycho>
 <20240228203235.22b5f122@kernel.org>
 <Zel4F74EqG2YMf+w@LouisNoVo>
 <Zel9k5uliEyi9ZTp@nanopsycho>
 <Zemfzkv4/FevHHfS@LouisNoVo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zemfzkv4/FevHHfS@LouisNoVo>

Thu, Mar 07, 2024 at 12:06:54PM CET, louis.peens@corigine.com wrote:
>On Thu, Mar 07, 2024 at 09:40:51AM +0100, Jiri Pirko wrote:
>> Thu, Mar 07, 2024 at 09:17:27AM CET, louis.peens@corigine.com wrote:
>> >On Wed, Feb 28, 2024 at 08:32:35PM -0800, Jakub Kicinski wrote:
>> >> On Wed, 28 Feb 2024 13:14:43 +0100 Jiri Pirko wrote:
>> >> > >+/* Part number for entire product */
>> >> > >+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"  
>> >> > 
>> >> > /* Part number, identifier of board design */
>> >> > #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"
>> >> > 
>> >> > Isn't this what you are looking for?
>> >> 
>> >> My memory is fading but AFAIR when I added the other IDs, back in my
>> >> Netronome days, the expectation was that they would be combined
>> >> together to form the part number.
>> >> 
>> >> Not sure why they need a separate one now, maybe they lost the docs,
>> >> maybe requirements changed. Would be good to know... :)
>> >Hi Jiri, Jakub, sorry for the delay in coming back to this. It did
>> >indeed trigger a bit of an internal discussion about which number is
>> >where and for what purpose. More detail at the end.
>> >> 
>> >> > "part_number" without domain (boards/asic/fw) does not look correct to
>> >> > me. "Product" sounds very odd.
>> >> 
>> >> I believe Part Number is what PCI VPD calls it.
>> >This is indeed where the decision to use "part_number" is coming from.
>> >> 
>> >> In addition to Jiri's questions:
>> >> 
>> >> > +/* Model of the board */
>> >> > +#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
>> >> 
>> >> What's the difference between this and:
>> >> 
>> >>  board.id
>> >>  --------
>> >>  
>> >>  Unique identifier of the board design.
>> >> 
>> >> ? One is AMDA the other one is code name?
>> >> You gotta provide more guidance how the two differ...
>> >Carefully looking at this again revealed that "board.model" is indeed
>> >the code name, and it probably shouldn't be a generic field. Or if it is
>> >it should named better, and be called something like
>> >'DEVLINK_INFO_VERSION_GENERIC_BOARD_CODENAME' instead. I do not know why
>> >this was added in the first place, maybe it was a requirement at some
>> >point, and I'm hesitant to just remove the user visible field now. But I
>> >am happy to keep it local to the driver - it was moved based on Jiri's
>> >suggestion - should have provided a better explanation then.
>> >
>> >"board.id" is not the same thing as "part_number", or at least not closely
>> >related anymore. Perhaps it was previously, but I can't find any
>> >information on this.
>> >
>> >"board.id" is the AMDA number, something like AMDA2001-1003, and it gets
>> >combined with a few other fields to generate the product_id, exposed as
>> >the devlink serial_number field. The AMDA number that is provided in the
>> >"board.id" field is still used to identify firmware names from the
>> >driver side.
>> >
>> >"part_number" looks like this: CGX11-A2PSNM. This is a number that is
>> >printed on the board, and also a field that can get exposed over BMC by
>> >products that supports this.
>> >
>> >While Fei was preparing the patch there was discussion about using
>> >"board.id" instead for the part_number as they do seem quite similar in
>> >purpose. The reason why we proposed a new field instead was that the
>> >information in "board.id" can still be helpful for identification. If
>> >there are some scripts out there that uses the "board.id" field, for
>> >example to build up a firmware pathname, replacing it with the
>> >"part_number" will break those.
>> >
>> >V1 of the series did also have the "part_number" in the driver only,
>> >Jiri requested moving it to devlink itself.
>> >
>> >Proposal for V3 - Move both fields back to driver-only, and greatly
>> >improve the commit message to explain the difference. Does this sound
>> >reasonable?
>> 
>> Why the "part_number" is specific to you? You say it is a board
>> attribute, why don't you have:
>> 
>> #define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER       "board.part_number"
>> ?
>I don't know if it is specific to us, that's the thing, maybe it is,
>maybe it isn't. What I do know in our case is that "part_number" and
>"board.id" is not the same thing, so we would prefer to have both visible.
>I cannot comment if that is the case for others, if the concensus is
>that others will find this helpful we don't mind adding it to devlink,
>as we've done from v1 to v2 - exact naming disussion aside.
>
>Updated proposal after this comment, V3 would then be:
>1) Keep "board.model" (the codename) local like it currently exist
>in-tree.
>2) Do still add "part_number" to devlink, but call it "board.part_number".
>Looking at the existing options it probably does fit the closest with
>board, it's not "fw", and I don't think it's "asic" either.
>
>Does this sound like the right track?

Okay.

