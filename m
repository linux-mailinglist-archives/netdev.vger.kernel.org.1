Return-Path: <netdev+bounces-136079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF549A0417
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A3E1C2AA4D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAFD1D278B;
	Wed, 16 Oct 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vw9LJJZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D21D1F76
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066878; cv=none; b=qdzl4D3/kjy2Y9sPZD0v2Fv+yySFZz+6FBiQPIgAbe6svsx7hICmi8Pb/N4hg27mKWO/VO/sD8YcnYeSUjxBZnfBZc1MifM0JBfqQVMeWVRzeSRMSWvPZwyKi5YN0hHplGI9ZGwvkuajH/DBSgrAIkhkNX95n1tmbNNbLAypgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066878; c=relaxed/simple;
	bh=aJueLz+IN4WlI4tmlwGHSA+XgBXSW5DM+SgqfEl3YDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsQ7uab/W7uouJxVR9wZol4ysGIl2M9YZ08Cdru2EssDoYm9JrCRf4Ol9RMfU2PIjbY7mh+vnLfBdSFz9TlZdPQyA+E3MK5lWfR91R88pgFe3wyKsLo3vh2Y8o02V97OgNqz9MmaT/4Qn6ZD5giiBwNcboF7B1O1kZ8/afjRrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vw9LJJZQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so4877241f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729066875; x=1729671675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP50kWPiw0MifDHtIyl2wdMhk6Jfke3YsVD3vsO0JF8=;
        b=vw9LJJZQyaPUkPSdeVBuXLaFMee3xvntMo50obSjx8jhhDVmvCG07S2RFP9QNVmqCZ
         5QOAcyXKxtmv8q/DYcfvEM2yYh031EYzJnaY+Wj3o9oPyHLJKA1Q6c2WVuJxtc/4mKob
         CAPU1URBKBFEh2fdHHIpLnkjzYBlPriWXjnyvcSxrBEI5+cSHr/J3phBOSkMv3jrDn9W
         Xl2ufjDJojO/97oolj3GNAlIlObb9G+IDHxHQi4Z4u1Vsy03bsoD+EIKB1BsQHWCKoqb
         4GcCOF3u+MR8koGsgUmjaLkzYG2nWK58Ap4H/JNxSPFDvH6qKwuY5exOKXYrX2dts5Pv
         aSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066875; x=1729671675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP50kWPiw0MifDHtIyl2wdMhk6Jfke3YsVD3vsO0JF8=;
        b=iUu2WPx7thNXgkjfoOkBAKoeJc/b2UO3/6vkPmx2HmCO46AhGKYr/ZPqB6MB6XC/lb
         dL2hmL/2QStCLUvCBpkmFOVcjKnlm8z7rafZ3Cc4efddcQYitiwkSlgZhwcOu7tLklqr
         Tr3uFPCf9m24Wzzk2+4+Uqgmfy6IrsDckJP9a6BdXPg+rm3QyQinq1jvkCDFaMmWTvXT
         kTFXuUk3MKxLs2bm10Tk1W4pla1XrTvGes98orZjaw1iYDIOyaVR3VkHYNUMi/ZVXs8Z
         iLb0vi0idL2kScpXc7ADSiu/s+KHdnOShVdctADf7t/W6EEF/oV5UxClAGXo15PgI7J3
         Mhmg==
X-Gm-Message-State: AOJu0YxniEkfIrwX/S0rWjV3qLjYX4C8nztUC+uqh2kM1oQmM3qlsitY
	9ejyl7olLpA501d7k0cND0o3Nl703VXhyBIPk5rJGGeSip3cZWquGvvh0VKUfSc=
X-Google-Smtp-Source: AGHT+IG4cjXE6vaHzEExA5NCTXa1i23amKdREgZQifEbDS9I5YXhdEmEZ9VOiFHQFdYbciM+U/Bq3w==
X-Received: by 2002:adf:fa46:0:b0:37c:cc4b:d1d6 with SMTP id ffacd0b85a97d-37d5ff8e817mr12950900f8f.27.1729066874557;
        Wed, 16 Oct 2024 01:21:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a173sm3651876f8f.15.2024.10.16.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:21:14 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:21:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <Zw93d2xz3TpOVp73@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
 <20241015080108.7ea119a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015080108.7ea119a6@kernel.org>

Tue, Oct 15, 2024 at 05:01:08PM CEST, kuba@kernel.org wrote:
>On Tue, 15 Oct 2024 16:38:52 +0200 Jiri Pirko wrote:
>> Tue, Oct 15, 2024 at 04:26:38PM CEST, kuba@kernel.org wrote:
>> >On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:  
>> >> +    type: enum
>> >> +    name: clock-quality-level
>> >> +    doc: |
>> >> +      level of quality of a clock device. This mainly applies when
>> >> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> >> +      The current list is defined according to the table 11-7 contained
>> >> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> >> +      by other ITU-T defined clock qualities, or different ones defined
>> >> +      by another standardization body (for those, please use
>> >> +      different prefix).  
>> >
>> >uAPI extensibility aside - doesn't this belong to clock info?
>> >I'm slightly worried we're stuffing this attr into DPLL because
>> >we have netlink for DPLL but no good way to extend clock info.  
>> 
>> Not sure what do you mean by "clock info". Dpll device and clock is kind
>> of the same thing. The dpll device is identified by clock-id. I see no
>> other attributes on the way this direction to more extend dpll attr
>> namespace.
>
>I'm not an expert but I think the standard definition of a DPLL
>does not include a built-in oscillator, if that's what you mean.
>
>> >> +    entries:
>> >> +      -
>> >> +        name: itu-opt1-prc
>> >> +        value: 1
>> >> +      -
>> >> +        name: itu-opt1-ssu-a
>> >> +      -
>> >> +        name: itu-opt1-ssu-b
>> >> +      -
>> >> +        name: itu-opt1-eec1
>> >> +      -
>> >> +        name: itu-opt1-prtc
>> >> +      -
>> >> +        name: itu-opt1-eprtc
>> >> +      -
>> >> +        name: itu-opt1-eeec
>> >> +      -
>> >> +        name: itu-opt1-eprc
>> >> +    render-max: true  
>> >
>> >Why render max? Just to align with other unnecessary max defines in
>> >the file?  
>> 
>> Yeah, why not?
>
>If it wasn't pointless it would be the default for our code gen.
>Please remove it unless you can point at some code that will likely
>need it. We can always add it later, we can't remove it.

Well, I use it internally to define the length of bitmap. Does that
justify? I mean, it would be very odd to define the bitmap length
differently.

Thanks!

