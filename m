Return-Path: <netdev+bounces-133741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55305996D3C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42181F23DFE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DA199EAF;
	Wed,  9 Oct 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="odL61Lb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88757197558
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482807; cv=none; b=HKagl4oay6JlPnVocXgHicA5X9THGL2T9iphTrXlzGWbAkwJQ9J1YOTFaPCb596dqfCL705GqCH10PB6H9OyzPZFxsWbEgMX54p3ZxXOaDSdj4CClDWuAOsxkgiVzHZmkKCaofckc/pPpTklH/ECNfPpoo7O2/EobJ77WFX4N9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482807; c=relaxed/simple;
	bh=fbelSDC0TB6izRZq9DLuQbFmS9ol+PAbMC5C06angGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opjukxqRmnxAA9otPN8tUpQ4wKG2KTTQVb9Qjwobbu7W3Hqf1ewqWHFE0mUCr1/9+jrrFr7oITaLy9k0JQdpzJM/esn/xZQWs/LGE9/fYH+Y3TFmZLHwG1t8HDl/DuNWOxKLYQGEOtEN8Tc5bRMkO8McUCPKb2rDFJQYd0X0DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=odL61Lb2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fadb636abaso70049601fa.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728482803; x=1729087603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KATN5zZPm4tupD7tbMrbA0CISSzN6Nb0rI+gmuCDJ8E=;
        b=odL61Lb2amzzJxseIKkbBYlKuUldbNBG1kjtm9vws+HaemzKhXkRAdciOa24da1L6+
         6chZ5mLiWgmGZBEuelUXfaOJ3mQLV2FUKBdxXK203w3JL6dd3F4Ubnq30PBGTyLGz7dh
         bQyjlDrFe61oCgJ2X38a6pewMnr+CUIjHSxZ676miFNBwevWFRUvaXNVpoZU8StxuxkN
         5VoUHjznWatx1/TwAy+iIrh74e8oEUBrxR+x7dJadbN7K03QUsKYQTlKm+lA87wQD5CK
         ggqqGc4CfmBNN+AjKwra4Ud9ZavzdSYZjw8GFpWW/DB145rLHBErtgAo6HiS4GwvY8b+
         CbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482803; x=1729087603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KATN5zZPm4tupD7tbMrbA0CISSzN6Nb0rI+gmuCDJ8E=;
        b=OVYHiclkPmSTDvWLAbvslZ3ziYjD+GoZjC7B2bxhG393e+ctMjL3CbFhO3/QWxWpIF
         82rcoGlOj6uDLWZq6sYrYEkETgn4TaA9LLMbptWM+kQV1PZo8mbU3hBMVUfku5jg5bqF
         nF7Y80W4Wc0vNd0bNWRjgt9bmDEbbmI5O7tup+rmypKU/XuHZxcX2DTqASP9+XJVW3By
         lC3bNFigs4R2ypYm+Gp0JPCsAe41fklPVqVs3DUGy5L+JJiPWzVq0hXSXxzkf+NLfybd
         ZgBTvxIp3US48mqOfdI9vm8MgGdhlRsNF0/1yAV5sYV7z7j+SgsxagYwqhPrM0o5qOjw
         OnpQ==
X-Gm-Message-State: AOJu0YwRrjIPpTT0NnH52bJORjLXk1EJ12UVwW9z/xL082QUe6BK5beK
	unXqQDcNIZEQUKeTGq749sRdxJ74FHOejS/GjXxg49Arp/Pzht3z/e4EbNziph0=
X-Google-Smtp-Source: AGHT+IEt3Z7/y43v0PaUmKaIEjUloG8vJHu5CkDvuuJibR5hTZJ3+OweRJ+wCZvp1RObr7t3CewKYw==
X-Received: by 2002:a05:651c:b2a:b0:2fa:edb8:3d5e with SMTP id 38308e7fff4ca-2fb187d1d92mr17666731fa.40.1728482803324;
        Wed, 09 Oct 2024 07:06:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd3a5sm5477115a12.41.2024.10.09.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:06:42 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:06:37 +0200
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
Message-ID: <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>

Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, October 9, 2024 2:26 PM
>>
>>In order to allow driver expose quality level of the clock it is
>>running, introduce a new netlink attr with enum to carry it to the
>>userspace. Also, introduce an op the dpll netlink code calls into the
>>driver to obtain the value.
>>
>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>---
>> Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>> include/linux/dpll.h                  |  4 ++++
>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>> 4 files changed, 75 insertions(+)
>>
>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>b/Documentation/netlink/specs/dpll.yaml
>>index f2894ca35de8..77a8e9ddb254 100644
>>--- a/Documentation/netlink/specs/dpll.yaml
>>+++ b/Documentation/netlink/specs/dpll.yaml
>>@@ -85,6 +85,30 @@ definitions:
>>           This may happen for example if dpll device was previously
>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>     render-max: true
>>+  -
>>+    type: enum
>>+    name: clock-quality-level
>>+    doc: |
>>+      level of quality of a clock device.
>
>Hi Jiri,
>
>Thanks for your work on this!
>
>I do like the idea, but this part is a bit tricky.
>
>I assume it is all about clock/quality levels as mentioned in
>ITU-T spec "Table 11-7" of REC-G.8264?

For now, yes. That is the usecase I have currently. But, if anyone
will have a need to introduce any sort of different quality, I don't
see why not.

>
>Then what about table 11-8?

The names do not overlap. So if anyone need to add those, he is free to
do it.


>
>And in general about option 2(3?) networks?
>
>AFAIR there are 3 (I don't think 3rd is relevant? But still defined
>In REC-G.781, also REC-G.781 doesn't provide clock types at all,
>just Quality Levels).
>
>Assuming 2(3?) network options shall be available, either user can
>select the one which is shown, or driver just provides all (if can,
>one/none otherwise)?
>
>If we don't want to give the user control and just let the
>driver to either provide this or not, my suggestion would be to name
>the attribute appropriately: "clock-quality-level-o1" to make clear
>provided attribute belongs to option 1 network.

I was thinking about that but there are 2 groups of names in both
tables:
1) different quality levels and names. Then "o1/2" in the name is not
   really needed, as the name itself is the differentiator.
2) same quality leves in both options. Those are:
   PRTC
   ePRTC
   eEEC
   ePRC
   And for thesee, using "o1/2" prefix would lead to have 2 enum values
   for exactly the same quality level.

But, talking about prefixes, perhaps I can put "ITU" as a prefix
to indicate this is ITU standartized clock quality leaving option
for some other clock quality namespace to appear?

[..]


