Return-Path: <netdev+bounces-14714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB1E74348A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 07:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C5A280EC1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626920F1;
	Fri, 30 Jun 2023 05:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCD1FDD
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:45:56 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CB3AA7
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 22:45:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso1692265f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688103945; x=1690695945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9DamHqoQRTGEPHmJjYoXKs4p/juuPvPGTamt5VWg8Y=;
        b=a8Wcpk7EDnnZwIgwD2HX0WSZBy+1oa/bj7pOqmvTOZzbvUL/OiML4GAVM3UU9WJuJB
         WxDiHNh4mr+EQ6SVUllGP1thPRm2M/PLa/cmrHZklfYVaoD9MEK2It1U12hX0y2wZxtH
         NKG24iqSMHcbvcB2Yb278McTlYFmBlKtJLMlWrIdoTiJFMXNwzOGXZNBYReowDLio1MF
         77GmQ7EUb/90uMkL6Wdcu2te4qPDKn7sx8AKOkdulebFP/Q51zXUVU4s1fBnN+DlBFpW
         +BNyTYv4B5hvX38cIcYfdVLgJTVCzfpAdBmceCOeOiND1sOdgbfCZ7LJdEWSRrwj7xYb
         wG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103945; x=1690695945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9DamHqoQRTGEPHmJjYoXKs4p/juuPvPGTamt5VWg8Y=;
        b=kQx7HuVv7NoitovzFhLwaoshgh6/Xutvu+iRWNJbcIpYwWfeM7I2fKuBogybajKeNR
         nSfSSDNERnxzcDMeVPz4VOEFj2ute+ssGIRitNd1BnPS279uGKmxjjfAo6PHdJ/fMCsy
         WNLe2bglPun3YNB821zg0zKv5a1ZawgjQBSNG7g3Ghg7jctN3oqdpHUNw2oe2lE8HYOM
         GH1RiUaD7WXCHn0AbDdg2rbh91KjrEPjoG2NAT/GkzsvBN69ptsrIlAhtiyfTqswBPbt
         7KCegbQiB27FrJsuQLp4woCD682jaeFvelY4JzY4jVMVItaD2hsp24JCrUCYrVbaWFNE
         abcw==
X-Gm-Message-State: ABy/qLYrPCUkW9YwgcobUxl4jcEftAj3lXpIQLMjYWvVPsIf/U5MyMN7
	JGskMJJFbuM3+H8O6p5CRothUg==
X-Google-Smtp-Source: APBJJlH41vjtNXK96kxURDA38odJVMBPwEkTkxM5vYTyKgQj30uXZ5l3+v9GL1D6Vdu8EmbRSr2Deg==
X-Received: by 2002:a5d:6512:0:b0:314:a03:c7a0 with SMTP id x18-20020a5d6512000000b003140a03c7a0mr1442004wru.9.1688103944951;
        Thu, 29 Jun 2023 22:45:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030aefa3a957sm17413602wrs.28.2023.06.29.22.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 22:45:42 -0700 (PDT)
Date: Fri, 30 Jun 2023 08:45:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Message-ID: <5e222335-5baa-4ce8-a90b-69a865f29b1a@kadam.mountain>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
 <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
 <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain>
 <SA1PR18MB4709E390AC13A1EF5F652165A02AA@SA1PR18MB4709.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR18MB4709E390AC13A1EF5F652165A02AA@SA1PR18MB4709.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 05:19:27AM +0000, Sai Krishna Gajula wrote:
> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Friday, June 23, 2023 5:14 PM
> > To: Sai Krishna Gajula <saikrishnag@marvell.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> > maciej.fijalkowski@intel.com; Naveen Mamindlapalli
> > <naveenm@marvell.com>
> > Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp
> > pointer before its usage
> > 
> > On Fri, Jun 23, 2023 at 11:28:19AM +0000, Sai Krishna Gajula wrote:
> > > > This probe function is super weird how it returns success on the failure
> > path.
> > > > One concern, I had initially was that if anything returns
> > > > -EPROBE_DEFER then we cannot recover.  That's not possible in the
> > > > current code, but it makes me itch...  But here is a different crash.
> > > >
> > >
> > > In few circumstances, the PTP device is probed before the AF device in
> > > the driver. In such instance, -EPROBE_DEFER is used.
> > > -- EDEFER_PROBE is useful when probe order changes. Ex: AF driver probes
> > before PTP.
> > >
> > 
> > You're describing how -EPROBE_DEFER is *supposed* to work.  But that's not
> > what this driver does.
> > 
> > If the AF driver is probed before the PTP driver then ptp_probe() should
> > return -EPROBE_DEFER and that would allow the kernel to automatically retry
> > ptp_probe() later.  But instead of that, ptp_probe() returns success.  So I
> > guess the user would have to manually rmmod it and insmod it again?  So,
> > what I'm saying I don't understand why we can't do this in the normal way.
> > 
> > The other thing I'm saying is that the weird return success on error stuff
> > hasn't been tested or we would have discovered the crash through testing.
> > 
> > regards,
> > dan carpenter
> 
> As suggested, we will return error in ptp_probe in case of any
> failure conditions. In this case AF driver continues without PTP support.

I'm concerned about the "AF driver continues without PTP support".

> When the AF driver is probed before PTP driver , we will defer the AF
> probe. Hope these changes are inline with your view.
> I will send a v3 patch with these changes. 
> 

I don't really understand the situation.  You have two drivers.
Normally, the relationship is very simple where you have to load one
before you can load the other.  But here it sounds like the relationships
are very complicated and you are loading one in a degraded state for
some reason...

When drivers are loaded that happens in drivers/base/dd.c.  We start
with a list of drivers to probe.  Then if any of them return
-EPROBE_DEFER, we put them on deferred_probe_pending_list.  Then as soon
as we manage to probe another driver successfully we put the drivers on
deferred_probe_pending_list onto another list and start trying to probe
them again.

That process continues until we've gone through the list of drivers and
nothing succeeds.

regards,
dan carpenter

