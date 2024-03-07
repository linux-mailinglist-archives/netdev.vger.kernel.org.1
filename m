Return-Path: <netdev+bounces-78275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A808749E4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD531C20F31
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6B80632;
	Thu,  7 Mar 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Kdsc8+dF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459B657D5
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800858; cv=none; b=XKYlSFZ1JkepRoc5c7ylDjmCDfUkuKvUACIQsUj8XzlnomV2rtlfl4h7C/Rvp4U+UoxlZ7WSNBbsyMkVV9f12Jint9d4h2I2NldeiMBvWi/Xnq+tk7/Dz+6JAMKYbHhrEVgQkUA0qP5cgA63v8pc8L+jfxcIM6TH8nxPnYyxXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800858; c=relaxed/simple;
	bh=cPLxyqvAL7wfpbvIkyBxmVw/NxtkWQVZW4gLPM0tAlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwpeBXYBeawyOaeH4RDU4IfQ3jAPGMUmKQSWr6VEAaZ0bIk+GAAhAF8FmfHD9Al7cmpOi++WkuCKivX7qq25+fn74s3g82JayIZW/bpoHFvfi9bU/wMJpz4EoeXNfkV6eTdi0sKv13hSP6UiCGvZddsMQ7HaJiI+hyfucIYXd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Kdsc8+dF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so268134f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 00:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709800855; x=1710405655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiOzY7a8j9txhnJCOmgAdef/ZGnUNTok5QcVhJzqb2E=;
        b=Kdsc8+dFOwkJA8mNNizIRe4mWpisVnvYk5UDVG6V/b+/TBW7R2A69TdPkqPYK6YaNU
         SH1k5NISEcAo9WWJDll531KAGUy/EO4mq/Mhzrsh+coBMWH3biEgk/8yMihFsFQOhGQY
         Jw0zOAc0ewOIddzvx4SPp9Ro0YWqBrVwDmUbbMggpNcP3xh6XDXRONHRWlsgfKN7h6EC
         DYKBw68UqF0DGrw9ZKdURs3oMCozxiYzZLSEwLFvaODnyPSM8ImL1ZJcqpxVLVFW9yEb
         tTPCt2b6pCC9Zgf8MzWMB9xa/SSTgxdmShtJYSexfMCmxvuEGo54I09OekwL2gT8PGeC
         8MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800855; x=1710405655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiOzY7a8j9txhnJCOmgAdef/ZGnUNTok5QcVhJzqb2E=;
        b=si2tzOu/XCAHJj2aEc1a8L51Erm8qatly+R91/SQpFeKXaA4Y/KeCpAn2OGmH1bb4/
         NERMVsG38VgM4rUBlkVXoQArHsguCCm1YMRccxbkKS2OPQXpR1kkEPkl9s3RVJ1Oti1r
         7pacQYxwTna9gUAm0/x4MPoOAWBgKHkTK7+P8CA9ivg7RLBQzSGCRw2IURkEARY8NeUm
         ht/rKLGYCVbNdyhkcmIThv6HSzgmS4o0Za4H+8EBCO+NDykOfK2mUjofyFid2X5XFKbt
         Owv7alsTPhsDTFVeSUncqBv0exN6lbzgTfVQfy3ABYHYeofcvJWv0znDeIEX0lrl+JMW
         x0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgicv8Yz4Yp2tSHRndHpU3EZZokid4s0ApSD2Ash8WrSJpUl1tYK6fFxs+fOypKpvjV9Qe5qoD7cdH5Kh+kDwqEAUhOEkb
X-Gm-Message-State: AOJu0YxBIHDmn1jCyAbXi6agEMqxAotttujEGd3jKN9YV3dfDIHFlWvx
	IdHGKcM8Q5w2R2a1GX4zK2z5/wrZ84CkCnRAaPBtq1etmOJhw0zWdQP3OYyMt+k=
X-Google-Smtp-Source: AGHT+IEyOip3lme7AF40iXYARjT0Rs5oTV8AIOMgpQGDUpFMbAKThzLBhgLQHbhHADbjcP4Jx1WYUw==
X-Received: by 2002:adf:f74d:0:b0:33e:cc6:a998 with SMTP id z13-20020adff74d000000b0033e0cc6a998mr10934244wrp.6.1709800854848;
        Thu, 07 Mar 2024 00:40:54 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0033e18f5714esm17554457wre.59.2024.03.07.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:40:54 -0800 (PST)
Date: Thu, 7 Mar 2024 09:40:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <Zel9k5uliEyi9ZTp@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-2-louis.peens@corigine.com>
 <Zd8js1wsTCxSLYxy@nanopsycho>
 <20240228203235.22b5f122@kernel.org>
 <Zel4F74EqG2YMf+w@LouisNoVo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zel4F74EqG2YMf+w@LouisNoVo>

Thu, Mar 07, 2024 at 09:17:27AM CET, louis.peens@corigine.com wrote:
>On Wed, Feb 28, 2024 at 08:32:35PM -0800, Jakub Kicinski wrote:
>> On Wed, 28 Feb 2024 13:14:43 +0100 Jiri Pirko wrote:
>> > >+/* Part number for entire product */
>> > >+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"  
>> > 
>> > /* Part number, identifier of board design */
>> > #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"
>> > 
>> > Isn't this what you are looking for?
>> 
>> My memory is fading but AFAIR when I added the other IDs, back in my
>> Netronome days, the expectation was that they would be combined
>> together to form the part number.
>> 
>> Not sure why they need a separate one now, maybe they lost the docs,
>> maybe requirements changed. Would be good to know... :)
>Hi Jiri, Jakub, sorry for the delay in coming back to this. It did
>indeed trigger a bit of an internal discussion about which number is
>where and for what purpose. More detail at the end.
>> 
>> > "part_number" without domain (boards/asic/fw) does not look correct to
>> > me. "Product" sounds very odd.
>> 
>> I believe Part Number is what PCI VPD calls it.
>This is indeed where the decision to use "part_number" is coming from.
>> 
>> In addition to Jiri's questions:
>> 
>> > +/* Model of the board */
>> > +#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
>> 
>> What's the difference between this and:
>> 
>>  board.id
>>  --------
>>  
>>  Unique identifier of the board design.
>> 
>> ? One is AMDA the other one is code name?
>> You gotta provide more guidance how the two differ...
>Carefully looking at this again revealed that "board.model" is indeed
>the code name, and it probably shouldn't be a generic field. Or if it is
>it should named better, and be called something like
>'DEVLINK_INFO_VERSION_GENERIC_BOARD_CODENAME' instead. I do not know why
>this was added in the first place, maybe it was a requirement at some
>point, and I'm hesitant to just remove the user visible field now. But I
>am happy to keep it local to the driver - it was moved based on Jiri's
>suggestion - should have provided a better explanation then.
>
>"board.id" is not the same thing as "part_number", or at least not closely
>related anymore. Perhaps it was previously, but I can't find any
>information on this.
>
>"board.id" is the AMDA number, something like AMDA2001-1003, and it gets
>combined with a few other fields to generate the product_id, exposed as
>the devlink serial_number field. The AMDA number that is provided in the
>"board.id" field is still used to identify firmware names from the
>driver side.
>
>"part_number" looks like this: CGX11-A2PSNM. This is a number that is
>printed on the board, and also a field that can get exposed over BMC by
>products that supports this.
>
>While Fei was preparing the patch there was discussion about using
>"board.id" instead for the part_number as they do seem quite similar in
>purpose. The reason why we proposed a new field instead was that the
>information in "board.id" can still be helpful for identification. If
>there are some scripts out there that uses the "board.id" field, for
>example to build up a firmware pathname, replacing it with the
>"part_number" will break those.
>
>V1 of the series did also have the "part_number" in the driver only,
>Jiri requested moving it to devlink itself.
>
>Proposal for V3 - Move both fields back to driver-only, and greatly
>improve the commit message to explain the difference. Does this sound
>reasonable?

Why the "part_number" is specific to you? You say it is a board
attribute, why don't you have:

#define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER       "board.part_number"
?


