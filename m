Return-Path: <netdev+bounces-67987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0688458BF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7EB1C27908
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6965B696;
	Thu,  1 Feb 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LMFvC17w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152C5B68D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793633; cv=none; b=s+6415MSXga6qoawRelsg07S8FYOhKk+KQc8DQGaGF+i6OzKP8bJiexm/iiVLOYOBM002tpuoyXZ58B0WoSTjUhZQjqKJnNWDsAcphwdU3+rRBdIwPdReLFLfQj4t/eJ/UWlL3uRBrnzROAUQ365CW4cDRGazP2VP8N60t4kEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793633; c=relaxed/simple;
	bh=GcXd6zzIctDICMWvOQarMzR5bNNDBeDptM+4zbpLab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpFj07IchOZH9Y22dZHl6x6EiwHN2FMh9uu7/cnzi1K0tE3QjYbO+O9O+QA30Zz4vU8PinSTFe9GOU6F8+nTy1e3vewOOU7ybvOLSDWWQMnu3AdT/V9kk/ok9XarAMU4avI5DFxw/pjpwE7nJ0vjTNuJLs5CL05Vd9Zga7iobRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LMFvC17w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40faf6788d1so12059755e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706793628; x=1707398428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckd38E7X//CQPeoPjfsDgV9+RBwHO5Pr66/35DL0opM=;
        b=LMFvC17wnqUYX2+JAqN+qzBY6A7qv8ygkQnpoWYS7HZ/Z+ZS3Ip9jI04kbGz8hpsWo
         UEzLBtLY7drFbo8slH51dJRuUXZJa7uIPrB6sLA621Qo91YzM2/4ftcPMxO6QMuVbvF3
         aNiQMl3dzwkzR/YOd6j8dYrzIrzNABka/IcL1gbvGXlCzaGZfRQpX2ZbKjylnFWUviC6
         OiV8GyiPyw9uVRSEJyMA7OXYYuoUnmRafgV8L6WiGwyDFWwohxlSQcEZRcLTErXqXYP2
         yxT3vrB4MXniwJ8b2KMkjIffaSlRPbIO7A2S8+1eOaRkNWC2RwO83dJLqWfJa5VSD0pC
         WfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793628; x=1707398428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckd38E7X//CQPeoPjfsDgV9+RBwHO5Pr66/35DL0opM=;
        b=umHv4qbQPF3Zc1+wbJh+F3iZDMZPyguxclzwM6Xhu0+ueXlgf2ERGvjuqUPzGAe517
         Fi1V7Fgmca+iXqpov2cThnBKy2StXUPsHaRqAtPo+Qvmysh4XipqMgADH9VIgEZ0DwYm
         elBQRgSvS0zmwMYsJGP0wuboxDgem/fHXv0ntn20aELYLLQ9Ytbh0AEObhXIreCN0FYq
         TKERv/vEszmhjaTyjzMyYtum+W2fWOlZ6ZoIz5jwjeYVPxpH/CV1pOpSppR3PIhpzewz
         RXIdVtFT7afcX3r8YztdfQ5QmtymX4DF7tRBlbJBsaTF1jpX2qjrYKvYhwCWjI6vvbhG
         MSnA==
X-Gm-Message-State: AOJu0YxOOh73bxiiH5bQhE+lqdvaGdHrO5YeY9GX+c7ucFuhvmZPK1cn
	e3HOuZSGtLZ42q0caXWjl4LJtw4vdoPhBNUsCobv6Px+xlyNs0mCI7BUeFwsHis=
X-Google-Smtp-Source: AGHT+IHk/wPWjk6/XkiNfSrZ3SmxvnCWMEsoyBPSbhsSgYxxmtwma3Xfp3CCmWFxVHfDz6gn6Ox21w==
X-Received: by 2002:adf:fc8b:0:b0:33a:ead3:6438 with SMTP id g11-20020adffc8b000000b0033aead36438mr7131258wrr.33.1706793627930;
        Thu, 01 Feb 2024 05:20:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPqx+9MNhBCRHDXiJgYNXxir1yprGTfyboxwXaZZU+nhZm/YOBWCW/+a8V+GvwrGTg2DiHuwJY/ksYnmINi2Av9bdaqyWuZ+golhzH+fIHz64cUPStUIb7ppQgTnNyeDkqwRUe+uAf1A/v5jEHJY+pWMpol9caC8aNzxyxS86DqH1rsgiE7JyFDIBXECLB+GNQImXC1S3Rnc/DbI17dVGrYNi1XsaCHJcYOuNgAz3hi5gkIQotWr1ldgB/EHTQsjKnWFFnbofy7/Z0/gUzuaUlvjPpAcI/nT49+xTqniyCu9Q4ci4FvIzROk8uNjRLMePRCyly8mU7UTjtqMJzznb9zuFiw+res4AdWylJcOYqInJdv+Fkcqm7+RBM7eHMI+i71m0U5/XWFnSdaYV36oRF8CPq42nI4/UK4q2vdq1vhgKf9XWDbXQJufeB/A5u7BykDjs3ARKds9PBc6vzv2+aFBjDy+ciY6ySK55xgMad+xOygE4Dsfe0p9ipJp7TbIOFG5pcnnSoXqZtoTSHf6r1HqZVMawTvolegwwKys/ggdMGymqCVeb1TCBYnLo/4GTVmrSzH+BDvv1gD1lD+w0Cxe/AjjSMY3TbTyshJDQWsnf47Rxl3fc6UAsHtmFrezEuU9z4gPtucYPUyg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000100f00b0033aee3bfac5sm10318553wrx.16.2024.02.01.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:20:27 -0800 (PST)
Date: Thu, 1 Feb 2024 14:20:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: John Garry <john.g.garry@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, mcgrof@kernel.org,
	russ.weight@linux.dev, gregkh@linuxfoundation.org,
	rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, keescook@chromium.org,
	masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
Message-ID: <Zbual3uIsjXENw0c@nanopsycho>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <20240131104851.2311358-4-john.g.garry@oracle.com>
 <20240131112432.5133bcaa@kernel.org>
 <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>

Thu, Feb 01, 2024 at 01:57:16PM CET, john.g.garry@oracle.com wrote:
>On 31/01/2024 19:24, Jakub Kicinski wrote:
>> On Wed, 31 Jan 2024 10:48:50 +0000 John Garry wrote:
>> > Instead of using UTS_RELEASE, use uts_release, which means that we don't
>> > need to rebuild the code just for the git head commit changing.
>> > 
>> > Signed-off-by: John Garry<john.g.garry@oracle.com>
>> Yes, please!
>> 
>> Acked-by: Jakub Kicinski<kuba@kernel.org>
>
>Cheers
>
>BTW, I assume that changes like this are also ok:
>
>--------8<---------
>
>   net: team: Don't bother filling in ethtool driver version
>
>   The version is same as the default, as don't bother.
>
>   Signed-off-by: John Garry <john.g.garry@oracle.com>
>
>diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>index f575f225d417..0a44bbdcfb7b 100644
>--- a/drivers/net/team/team.c
>+++ b/drivers/net/team/team.c
>@@ -25,7 +25,6 @@
>#include <net/genetlink.h>
>#include <net/netlink.h>
>#include <net/sch_generic.h>
>-#include <generated/utsrelease.h>
>#include <linux/if_team.h>
>
>#define DRV_NAME "team"
>@@ -2074,7 +2073,6 @@ static void team_ethtool_get_drvinfo(struct
>net_device *dev,
>                                    struct ethtool_drvinfo *drvinfo)
>{
>       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
>-       strscpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));

Yeah. I don't see why should anyone care about this "version"...
Let's remove it.

>}
>
>-------->8---------
>
>right?
>
>John
>
>
>
>
>

