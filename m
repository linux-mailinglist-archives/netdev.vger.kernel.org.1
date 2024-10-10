Return-Path: <netdev+bounces-134300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3C998A5B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C45F1F2A5E2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874B1E909A;
	Thu, 10 Oct 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PGhBTl8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13C1E9079
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571000; cv=none; b=jGu3G1fV3tL8PB+DiB5VdCOql/CIAFBok+mlf+LOnpNkRzK8NbI4NLoCR5EPpDrXyC7A2MHYOnMh3a06GWX6aQJ1TAUAMsoUqKNSk6qhBxewkkiV2JcymLGMfrAEng06Wr7Jki/fet1j3PaL7BsmwfiiVIs5Fa69NKrsl9Nd9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571000; c=relaxed/simple;
	bh=QZ66l9Y9zd0N2tSa0Zl2B31RD0zDLJ4PT5qBzUEtJWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVdduaSSQ9DPpLRKkCBlslJioTpnRc/i049XB/FAAlEZMRZsCzlbq+FJjthJYiMgxZpIRYlzlLA/OEbddnbJaXYn53j5lvbS2NVAiWoD7N9NqhWbMJNW2exxytpLaeaSw09DcMiVFPNknFXRugXyepJB9plnMg2w0AXD5O8fG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PGhBTl8r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a993f6916daso172682366b.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728570996; x=1729175796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NEFJX316XKH+M4MNbovOi7n/Svbsi5+Opnmu87CJr0=;
        b=PGhBTl8rdixe/y8F25gmEHQ9P0gqYfM/ro4RAA+b7rUITpZJ3IQML8gn6viIlQr7iu
         /j9REM3wKteoevL994hwLdGdOKBoZwqXuepoO2Ncs8D2JAkOQGF4XdKPbeRgsTOgAXmr
         ZmjthA7RQSTR1ZbrdDktuvWRoloYNr+/SXk+lw1BVAqPKpIyZ3qadu8NS+5HtP0tI9LA
         x6ODNFDqFentkz8Fw5Yme7S6k+aqfHVGNRxKrVMJjq5x1/xjEcZbz5m0znFtg9m3OroR
         Ii1OBF3J3+iteWQU80YNOZZJWmSo9qC3Lh3EsX0zQ7cBJRY523hQxIpd6EO7ll48YdVe
         leLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570996; x=1729175796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NEFJX316XKH+M4MNbovOi7n/Svbsi5+Opnmu87CJr0=;
        b=Cu0j6CZ3f+7Iia7a0FROXXRrHXRWV6SXTA0HfxHrxPK65stNBrkH+iJwEuWTYYcbRn
         fzdS2/7eUUtgfehkcCWbd6ertWktNA2MLS4N0hBNFaDbnok6VpsxgrTtps+4k1+M/nrD
         0g2jngVUDl4HoeYjmwgYwTtj17UkriWlvXAa6RL2PfTKgqc9kv5uQxwg6EoxhR/wums4
         /O6KHX6fqkWLVra1+sCltc6ORxs7udKFGAnvjtQ1k/0xTc5M3nmms5rdBIOeSvbigEv7
         4NXNh8a293CUaZkb6twPhIRxS4u2D0w5E+7VnAv52hbt3PZp1aKfVNNj/ekappvdibtk
         AOmQ==
X-Gm-Message-State: AOJu0YwbhKYzi6Xyu/DaG2Hmba5Q0HsLARTpAePI86ZNEv2DGDJ6WI6N
	WFuj+can1ocw7aMergxnOWpuxr3afwnMkjeVfIYM+rrSAiV667OwpMoTXsQ/eCo=
X-Google-Smtp-Source: AGHT+IFji8Wk2EwUKS1NkbBTc9T+wjaEv5A9f54bRFYFMw9HgWsnnBdW070UEWZXHSP1roXwZQFx0A==
X-Received: by 2002:a17:907:7295:b0:a99:a48d:4470 with SMTP id a640c23a62f3a-a99a48d4737mr216829566b.54.1728570995471;
        Thu, 10 Oct 2024 07:36:35 -0700 (PDT)
Received: from localhost (37-48-49-80.nat.epc.tmcz.cz. [37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2588sm96362366b.205.2024.10.10.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:36:34 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:36:33 +0200
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
Message-ID: <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
 <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>

Thu, Oct 10, 2024 at 03:48:02PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, October 10, 2024 1:36 PM
>>
>>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>>
>>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>>
>>>>>>In order to allow driver expose quality level of the clock it is
>>>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>>>userspace. Also, introduce an op the dpll netlink code calls into the
>>>>>>driver to obtain the value.
>>>>>>
>>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>---
>>>>>> Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>>>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>>>> include/linux/dpll.h                  |  4 ++++
>>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>>> 4 files changed, 75 insertions(+)
>>>>>>
>>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>>           This may happen for example if dpll device was previously
>>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>>>     render-max: true
>>>>>>+  -
>>>>>>+    type: enum
>>>>>>+    name: clock-quality-level
>>>>>>+    doc: |
>>>>>>+      level of quality of a clock device.
>>>>>
>>>>>Hi Jiri,
>>>>>
>>>>>Thanks for your work on this!
>>>>>
>>>>>I do like the idea, but this part is a bit tricky.
>>>>>
>>>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>>>spec "Table 11-7" of REC-G.8264?
>>>>
>>>>For now, yes. That is the usecase I have currently. But, if anyone will have
>>>>a
>>>>need to introduce any sort of different quality, I don't see why not.
>>>>
>>>>>
>>>>>Then what about table 11-8?
>>>>
>>>>The names do not overlap. So if anyone need to add those, he is free to do
>>>>it.
>>>>
>>>
>>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>>As you already pointed below :)
>>
>>Yep, sure.
>>
>>>
>>>>
>>>>>
>>>>>And in general about option 2(3?) networks?
>>>>>
>>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined In
>>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>>>Quality Levels).
>>>>>
>>>>>Assuming 2(3?) network options shall be available, either user can
>>>>>select the one which is shown, or driver just provides all (if can,
>>>>>one/none otherwise)?
>>>>>
>>>>>If we don't want to give the user control and just let the driver to
>>>>>either provide this or not, my suggestion would be to name the
>>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>>provided attribute belongs to option 1 network.
>>>>
>>>>I was thinking about that but there are 2 groups of names in both
>>>>tables:
>>>>1) different quality levels and names. Then "o1/2" in the name is not
>>>>   really needed, as the name itself is the differentiator.
>>>>2) same quality leves in both options. Those are:
>>>>   PRTC
>>>>   ePRTC
>>>>   eEEC
>>>>   ePRC
>>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum values
>>>>   for exactly the same quality level.
>>>>
>>>
>>>Those names overlap but corresponding SSM is different depending on
>>>the network option, providing one of those without network option will
>>>confuse users.
>>
>>The ssm code is different, but that is irrelevant in context of this
>>UAPI. Clock quality levels are the same, that's what matters, isn't it?
>>
>
>This is relevant to user if the clock provides both.
>I.e., given clock meets requirements for both Option1:PRC and
>Option2:PRS.
>How would you provide both of those to the user?

Currently, the attr is single value. So you imply that there is usecase
to report multiple clock quality at a single time?

Even with that. "PRC" and "PRS" names are enough to differenciate.
option prefix is redundant.


>
>The patch implements only option1 but the attribute shall
>be named adequately. So the user doesn't have to look for it
>or guessing around.
>After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
>It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=X or a tuple:
>DPLL_A_CLOCK_QUALITY_LEVEL=X + DPLL_A_CLOCK_QUALITY_OPTION=1.

Why exactly do you need to expose "option"? What's the usecase?


>mlx code in 2/2 indicates this is option 1.
>Why uapi shall be silent about it?

Why is that needed? Also, uapi should provide some sort of abstraction.
"option1/2" is very ITU/SyncE specific. The idea is to be able to reuse
"quality-level" attr for non-synce usecases.


>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>For me one enum list for clock types/quality sounds good.
>>>
>>>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to indicate
>>>>this is ITU standartized clock quality leaving option for some other clock
>>>>quality namespace to appear?
>>>>
>>>>[..]
>>>
>>>Sure, also makes sense.
>>>
>>>But I still believe the attribute name shall also contain the info that
>>>it conveys an option1 clock type. As the device can meet both specifications
>>>at once, we need to make sure user knows that.
>>
>>As I described, I don't see any reason why. Just adds unnecessary
>>redundancy to uapi.
>>
>>
>>>
>>>Thank you!
>>>Arkadiusz

