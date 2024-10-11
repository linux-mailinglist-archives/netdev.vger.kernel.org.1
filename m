Return-Path: <netdev+bounces-134624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70D99A87D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DE71C2117D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D419750B;
	Fri, 11 Oct 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ycWFp/gv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA918EFC1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662256; cv=none; b=YkrSkBZACEyAvvwztyIQzm/1GHD8J2rdRsxkLSPoCcPGAxaK/++C5DIDGEaPIVvoTsVXjLhrENXeY1L6UEb4rv/fxnlY2Piu+QBkCkxvILf3XoyKJTqYijBQKR9g/XaLXxQ98JpnvaoX7XlMPL8SfxDrAsG04/ghiYq3CdzC/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662256; c=relaxed/simple;
	bh=rLTGiWaZLBCKzw6sFgtEKcXrtbKZGHVuLaulVCSLEvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz1TtxsX8LxTQxCYpFG8J/gkkU1X/h6gGfgj35y1ehwoerbk1CjHOJ/afKlxUc23oVUe33UjXiYGqe404lciGGU/Iy5psL8sNB2+ijpuCDPsIGmIGOAYPwvUsR4QF5beEsc0jeAEcoK4Mr+zIndaHPWpBiCmUClxlWPkCx7Hd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ycWFp/gv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so108364566b.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728662252; x=1729267052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NwSc41xH6AgVFNlt0eGGdP34xZ/xI6bJI56YutjInA=;
        b=ycWFp/gvLr5y7sJYo61RKw1kkhTXdU/aN/igQi2KIz2OGCSCocaWy9WYqhy+MYwyo9
         F8eeqH88SZTIoPhkIto+O9nfUuYwDXfO91wXuPUdDJK4nxigEV/2KZvhdQbp0K4joONw
         XaYUG6mVb2xIbWVFrShB9uV2QXtT/4oJUiw+6Vm5zV4aXvhWmuhmh5QMqw6hU5PkCNsY
         LMKbT3H5EutXYRRsDzGDVVsf9GoRcNYmtTqcJq+fLTF7L6G4wmQeLVApHfu0xh/OoBrM
         rOJ0ujl4ZpFLs/XM9FycwxrSxUhxu57d2r0yfUPO7Uk0fkudYkGnKahLYrrg/zWQf3DX
         9Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662252; x=1729267052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NwSc41xH6AgVFNlt0eGGdP34xZ/xI6bJI56YutjInA=;
        b=p43mihv+wCKE1ynyawnxRGqgvykIMCxvpzsne6bQO57WmX5VuDo6ER2FhO07k6cN11
         FmzVkhSHCSYuPS4bNdIqHFSqyn4JuhOVPnCyJG1YJeMd+IqF1xDMbNHv7jVsd6/szkz1
         XPS80LsG2lqaXpqoj+ZDeyg4kEAKpyUJxAQTFhy9r1SY6EccQk9fAbJ71Qk8o9VCtWQ1
         MlJSR8sgIdCVu0+ekB4Rvgj85QOYxYzlzw45eJ5OYZb9ABysTyZY020my+5iMj9XXaXl
         G3GdkM6pV60XX/DLAN4ct9l8IO6zREvRxzwNs6IoCzMQ7jnS3baDQjssRD589rPGrEbl
         +69w==
X-Gm-Message-State: AOJu0YyGcBXVXIkNpD/5+MZK+/lNwIVDRtn3NxyygssLq2J2GfOOL55J
	qFXkq0bA80yWWZH5EU5JIAE52fG5LJ7PcQrGjhYBEc5Jdl3WS2zopcDIF0lD000=
X-Google-Smtp-Source: AGHT+IFK25UT04sB60pZJZSJBMv7kxXO6virmCRATX+UVLm+Ll0+D4yIMdiC0pZVJr8yLurSVjk87w==
X-Received: by 2002:a17:907:e265:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a99b9582c12mr291475266b.29.1728662251381;
        Fri, 11 Oct 2024 08:57:31 -0700 (PDT)
Received: from localhost ([37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ddf4csm226298766b.181.2024.10.11.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:57:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:57:29 +0200
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
Message-ID: <ZwlK6Xm5mNzpvlsS@nanopsycho.orion>
References: <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
 <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
 <DM6PR11MB4657140103B9C33B3899041E9B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwjJiqFbDWwUNh9_@nanopsycho.orion>
 <DM6PR11MB4657805DBAA2CCA70D233D2B9B792@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657805DBAA2CCA70D233D2B9B792@DM6PR11MB4657.namprd11.prod.outlook.com>

Fri, Oct 11, 2024 at 04:25:09PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Friday, October 11, 2024 8:46 AM
>>
>>Thu, Oct 10, 2024 at 06:02:56PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, October 10, 2024 4:37 PM
>>>>
>>>>Thu, Oct 10, 2024 at 03:48:02PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Thursday, October 10, 2024 1:36 PM
>>>>>>
>>>>>>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com
>>>>>>wrote:
>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>>>>>>
>>>>>>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>>wrote:
>>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>>>>>>
>>>>>>>>>>In order to allow driver expose quality level of the clock it is
>>>>>>>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>>>>>>>userspace. Also, introduce an op the dpll netlink code calls into the
>>>>>>>>>>driver to obtain the value.
>>>>>>>>>>
>>>>>>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>>>>---
>>>>>>>>>> Documentation/netlink/specs/dpll.yaml | 28
>>>>>>>>>>+++++++++++++++++++++++++++
>>>>>>>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>>>>>>>> include/linux/dpll.h                  |  4 ++++
>>>>>>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>>>>>>> 4 files changed, 75 insertions(+)
>>>>>>>>>>
>>>>>>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>>>>>>           This may happen for example if dpll device was previously
>>>>>>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>>>>>>>     render-max: true
>>>>>>>>>>+  -
>>>>>>>>>>+    type: enum
>>>>>>>>>>+    name: clock-quality-level
>>>>>>>>>>+    doc: |
>>>>>>>>>>+      level of quality of a clock device.
>>>>>>>>>
>>>>>>>>>Hi Jiri,
>>>>>>>>>
>>>>>>>>>Thanks for your work on this!
>>>>>>>>>
>>>>>>>>>I do like the idea, but this part is a bit tricky.
>>>>>>>>>
>>>>>>>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>>>>>>>spec "Table 11-7" of REC-G.8264?
>>>>>>>>
>>>>>>>>For now, yes. That is the usecase I have currently. But, if anyone will
>>>>>>>>have
>>>>>>>>a
>>>>>>>>need to introduce any sort of different quality, I don't see why not.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>Then what about table 11-8?
>>>>>>>>
>>>>>>>>The names do not overlap. So if anyone need to add those, he is free to
>>>>>>>>do
>>>>>>>>it.
>>>>>>>>
>>>>>>>
>>>>>>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>>>>>>As you already pointed below :)
>>>>>>
>>>>>>Yep, sure.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>And in general about option 2(3?) networks?
>>>>>>>>>
>>>>>>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined In
>>>>>>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>>>>>>>Quality Levels).
>>>>>>>>>
>>>>>>>>>Assuming 2(3?) network options shall be available, either user can
>>>>>>>>>select the one which is shown, or driver just provides all (if can,
>>>>>>>>>one/none otherwise)?
>>>>>>>>>
>>>>>>>>>If we don't want to give the user control and just let the driver to
>>>>>>>>>either provide this or not, my suggestion would be to name the
>>>>>>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>>>>>>provided attribute belongs to option 1 network.
>>>>>>>>
>>>>>>>>I was thinking about that but there are 2 groups of names in both
>>>>>>>>tables:
>>>>>>>>1) different quality levels and names. Then "o1/2" in the name is not
>>>>>>>>   really needed, as the name itself is the differentiator.
>>>>>>>>2) same quality leves in both options. Those are:
>>>>>>>>   PRTC
>>>>>>>>   ePRTC
>>>>>>>>   eEEC
>>>>>>>>   ePRC
>>>>>>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum values
>>>>>>>>   for exactly the same quality level.
>>>>>>>>
>>>>>>>
>>>>>>>Those names overlap but corresponding SSM is different depending on
>>>>>>>the network option, providing one of those without network option will
>>>>>>>confuse users.
>>>>>>
>>>>>>The ssm code is different, but that is irrelevant in context of this
>>>>>>UAPI. Clock quality levels are the same, that's what matters, isn't it?
>>>>>>
>>>>>
>>>>>This is relevant to user if the clock provides both.
>>>>>I.e., given clock meets requirements for both Option1:PRC and
>>>>>Option2:PRS.
>>>>>How would you provide both of those to the user?
>>>>
>>>>Currently, the attr is single value. So you imply that there is usecase
>>>>to report multiple clock quality at a single time?
>>>>
>>>
>>>Yes, correct. The userspace would decide which one to use.
>>
>>Wait what? What do you mean by "which one to "use""?
>>
>
>Generally if you provide some information to user, he shall use it
>somehow, right?
>
>Maybe you could explain the use case as you are the one developing it?
>Is this to tell user a quality level of your device itself - without
>anything connected?
>Does it change during runtime? (i.e. locking to a neighbor?)

Nope. It is the quality of clock the device is running. Locking does not
change that. We propagate this info over SyncE ESMC message.


>
>I already explained my concerns: if device would be providing multiple
>clock qualities for different specification options (i.e. ITU-T Option
>1/2(/3)) and they would differ for single device with regards to the
>meeting certain class spec requirements, the list of those would be
>required. Since the names for both do overlap it would be not possible
>to let the user know accurately without changes to the uapi.
>
>>
>>>
>>>>Even with that. "PRC" and "PRS" names are enough to differenciate.
>>>>option prefix is redundant.
>>>>
>>>
>>>I do not ask for option prefix in the enum names, but specify somehow
>>>the option you do provide, and ability easily expand the uapi to provide
>>>both at the same time.. Backend can wait for someone to actually
>>>implement the option2, but we don't want to change uapi later, right?
>>
>>So far, I fail to see what is the need for exposing the "option" info. I
>>may be missing something.
>>
>
>See above and below :)
>
>>
>>>
>>>>
>>>>>
>>>>>The patch implements only option1 but the attribute shall
>>>>>be named adequately. So the user doesn't have to look for it
>>>>>or guessing around.
>>>>>After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
>>>>>It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=X or a tuple:
>>>>>DPLL_A_CLOCK_QUALITY_LEVEL=X + DPLL_A_CLOCK_QUALITY_OPTION=1.
>>>>
>>>>Why exactly do you need to expose "option"? What's the usecase?
>>>>
>>>
>>>The use case is to simply provide accurate information.
>>>With proposed changes the user will not know if provided class of
>>>ePRC is option 1 or 2.
>>
>>How exactly does those 2 differ in terms of clock quality? If they
>>don't, why to differenciate them?
>
>All I could find is that the same name of clock class the quality
>shall not differ. But again I am not saying we shall differentiate
>the clock class.. Rather an ability to provide each one, keeping in
>mind that device can meet different O1 vs O2 (vs 03.
>
>How would we extend the interface to provide Option 2 clock class?
>I still see some entropy, I mean higher then expected..
>Let's say device meets PRC for Option1 and PRS for Option2, how would
>we provide this?
>The same attribute twice? This seems also possibly confusing for
>certain cases.

DPLL_A_CLOCK_QUALITY_LEVEL with value DPLL_CLOCK_QUALITY_LEVEL_ITU_PRC
DPLL_A_CLOCK_QUALITY_LEVEL with value DPLL_CLOCK_QUALITY_LEVEL_ITU_PRS

same attribute 2 times with different value.


But, in the meantime, I learned that for example ePRTC certification
may differ for option 1 and option 2. So we need to provide it. I will
just put it into the enum name. Looks as the best solution, UAPI and
internal op api-wise.


>
>>
>>
>>>
>>>>
>>>>>mlx code in 2/2 indicates this is option 1.
>>>>>Why uapi shall be silent about it?
>>>>
>>>>Why is that needed? Also, uapi should provide some sort of abstraction.
>>>>"option1/2" is very ITU/SyncE specific. The idea is to be able to reuse
>>>>"quality-level" attr for non-synce usecases.
>>>>
>>>
>>>Well, actually great point, makes most sense to me.
>>>Then the design shall be some kind of list of tuples?
>>>
>>>Like:
>>>--dump get-device
>>>{
>>>  'clock-id': 4658613174691233804,
>>>  'id':1,
>>>  'type':eec,
>>>  ...
>>>
>>>  'clock_spec':
>>>  [
>>>    {
>>>      "type": itu-option1,
>>>      "quality-level": eprc
>>>    },
>>>    {
>>>      "type": itu-option2,
>>>      "quality-level": eprc
>>>    },
>>>    ...
>>>  ]
>>>  ...
>>>}
>>>
>>>With assumption that for now only one "type" of itu-option1, but with
>>>ability to easily expand the uapi.
>>>
>>>The "quality-level" is already defined, and seems fine to me.
>>>
>>>Does it make sense?
>>
>>Sort of. I would still very much like to avoid exposing multiple values
>>at a time as it complicates the implementation, namely driver op.
>>
>>
>
>Well, true.
>
>Thank you!
>Arkadiusz
>
>>
>>
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>
>>>>>Thank you!
>>>>>Arkadiusz
>>>>>
>>>>>>
>>>>>>>
>>>>>>>For me one enum list for clock types/quality sounds good.
>>>>>>>
>>>>>>>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to
>>>>>>>>indicate
>>>>>>>>this is ITU standartized clock quality leaving option for some other
>>>>>>>>clock
>>>>>>>>quality namespace to appear?
>>>>>>>>
>>>>>>>>[..]
>>>>>>>
>>>>>>>Sure, also makes sense.
>>>>>>>
>>>>>>>But I still believe the attribute name shall also contain the info that
>>>>>>>it conveys an option1 clock type. As the device can meet both
>>>>>>>specifications
>>>>>>>at once, we need to make sure user knows that.
>>>>>>
>>>>>>As I described, I don't see any reason why. Just adds unnecessary
>>>>>>redundancy to uapi.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>Thank you!
>>>>>>>Arkadiusz
>

