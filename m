Return-Path: <netdev+bounces-134185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD3998528
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A61B219BD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD31C3F03;
	Thu, 10 Oct 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="chf40HKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933801C330A
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560186; cv=none; b=d6CrRV0+5gREotT8nVtx4H7BYO9I9X+VRp3XP2OozDm4DbBSRMQg7Mkq+ULVgraHihU8ALNt55BMn82NqBBQ9xRRJUuS52XmZVrr5GfCiY9teR/hi+W9D4+1XwvMSaR1YTf6FwDY5q/mN/opQDg1MPmuvwT1n2IvosPK/cwNcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560186; c=relaxed/simple;
	bh=m1l13wsW8fvYJL7Nm2JarArZ1HtMK4U/agIi51dYEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz/iRyVh7ZVKdJH4WmfF3GFIZwjCBR0svEEOQjkhmNTRLT5lD4isbGyfYuWbVNkL91QoCU+20vIMMLLtDGKJhP6Sr2kj4bsz/QeOUj61xd5GS69QFTyQ+e70MkpT87STZSYjo1LWR9nxGD1aMI+tIChudVHyPycgtYBSWhmikV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=chf40HKT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398b589032so1351839e87.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728560181; x=1729164981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+baJBjnZllgzFZy/QTDBBIcJKCuFuZ5vooTK7iP2Ds=;
        b=chf40HKTCd2PE3kWhSGAOejB5nHipvp2d4h5jWQKeR4dl6Tqxj5NrWoVVpbzypJAI3
         57SLBD9gUEEi67Uu9t0ihpT8pkYclReMdctIuwTC2gailnoHogM7GaRPSCZOyVkqjE4r
         cW6KTUwkS225mxCWfqjvHohLBqAMppS0izMlS2Vu+WRtm/2LT0wN4iUDgUmTVsTayeSC
         /JxhLccW6h44eghY29OfdS/+26GVvDC9M+TCOKHG0QolygTjiEAcdPAQUzXE9Xs0u7Z1
         Uto6DZjdyglhU17M5zxpCkjjp4GGQRLWhgtzQRRbzqs5fD+aT+TFivvdkJ1nDzihycOl
         tjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560181; x=1729164981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+baJBjnZllgzFZy/QTDBBIcJKCuFuZ5vooTK7iP2Ds=;
        b=EfF2pVuSxiTohY3Tvv2CZ/XpRRvVAbdOsXPCUb9FZnI4XPnYf9/EIpBAV+R/PFkXXE
         0lTEJkOj3nf/fgcSvGT14OqUB85dfrJUKuWVNS/l+LRAnLn1MAc+6PDeL2Jz2hWEzdsv
         8hAE1ZspQBXHYuWGIc28DuhbuCRgumgHUiW7Lm7ZwtODtfXlats3ef4hJnQTNFg1Bpn3
         oXkSBTERI4VYF3ROC990z9bDa0/gKGoISxNA3bJgA5FXnYewrObe59WSOiNflN3UWZDJ
         Wco6qPUyZDImFavXdwXOWUvNYYBZ1m+O45srGmXFv3H/EmNS6noq0QMoyzm5kziRjQ+n
         wE+A==
X-Gm-Message-State: AOJu0YzPA+t+CAO3t2/eTGeRAtid5zK7EJRz5CQXX70fqwNRUzU5XHOy
	6cwXFO97ll3KBf+sYBAt9ckf//03lldojZil4whzvI/czbedEWCgo/d5iLBDVfY=
X-Google-Smtp-Source: AGHT+IEofel8xOKxVGNRbvRNbFMtgkA7KcSxyqm2/lqZUXwIpymtduEzs0h1vS6MLwcngWfvOpky/Q==
X-Received: by 2002:a05:6512:1091:b0:539:8d9b:b61c with SMTP id 2adb3069b0e04-539c4968056mr5395585e87.51.1728560181363;
        Thu, 10 Oct 2024 04:36:21 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f2457fsm77417166b.51.2024.10.10.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:36:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:36:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Message-ID: <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>

Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, October 9, 2024 4:07 PM
>>
>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>
>>>>In order to allow driver expose quality level of the clock it is
>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>userspace. Also, introduce an op the dpll netlink code calls into the
>>>>driver to obtain the value.
>>>>
>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>---
>>>> Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>> include/linux/dpll.h                  |  4 ++++
>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>> 4 files changed, 75 insertions(+)
>>>>
>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>@@ -85,6 +85,30 @@ definitions:
>>>>           This may happen for example if dpll device was previously
>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>     render-max: true
>>>>+  -
>>>>+    type: enum
>>>>+    name: clock-quality-level
>>>>+    doc: |
>>>>+      level of quality of a clock device.
>>>
>>>Hi Jiri,
>>>
>>>Thanks for your work on this!
>>>
>>>I do like the idea, but this part is a bit tricky.
>>>
>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>spec "Table 11-7" of REC-G.8264?
>>
>>For now, yes. That is the usecase I have currently. But, if anyone will have a
>>need to introduce any sort of different quality, I don't see why not.
>>
>>>
>>>Then what about table 11-8?
>>
>>The names do not overlap. So if anyone need to add those, he is free to do it.
>>
>
>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>As you already pointed below :)

Yep, sure.

>
>>
>>>
>>>And in general about option 2(3?) networks?
>>>
>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined In
>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>Quality Levels).
>>>
>>>Assuming 2(3?) network options shall be available, either user can
>>>select the one which is shown, or driver just provides all (if can,
>>>one/none otherwise)?
>>>
>>>If we don't want to give the user control and just let the driver to
>>>either provide this or not, my suggestion would be to name the
>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>provided attribute belongs to option 1 network.
>>
>>I was thinking about that but there are 2 groups of names in both
>>tables:
>>1) different quality levels and names. Then "o1/2" in the name is not
>>   really needed, as the name itself is the differentiator.
>>2) same quality leves in both options. Those are:
>>   PRTC
>>   ePRTC
>>   eEEC
>>   ePRC
>>   And for thesee, using "o1/2" prefix would lead to have 2 enum values
>>   for exactly the same quality level.
>>
>
>Those names overlap but corresponding SSM is different depending on
>the network option, providing one of those without network option will
>confuse users.

The ssm code is different, but that is irrelevant in context of this
UAPI. Clock quality levels are the same, that's what matters, isn't it?


>
>For me one enum list for clock types/quality sounds good.
>
>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to indicate
>>this is ITU standartized clock quality leaving option for some other clock
>>quality namespace to appear?
>>
>>[..]
>
>Sure, also makes sense.
>
>But I still believe the attribute name shall also contain the info that
>it conveys an option1 clock type. As the device can meet both specifications
>at once, we need to make sure user knows that.

As I described, I don't see any reason why. Just adds unnecessary
redundancy to uapi.


>
>Thank you!
>Arkadiusz

