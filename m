Return-Path: <netdev+bounces-219937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53507B43C7C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290BC163E16
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458A2FE59C;
	Thu,  4 Sep 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx0ZHM40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A322EA15D;
	Thu,  4 Sep 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991108; cv=none; b=k7pJh66Fx7+id2t3yUUCiT9ELgNQx/yoINMIZYS9S2hNH5kphw3twnSNKopfh1uir5RTiE0NW02AOfvjhNvgJvdIG+KBGThgX+GUVKDrBaXorogKqLVyTOd9tGz2O77/SBi7YXTMXrIVCMezq6P896UaBJUY7epPWj2vJqE8lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991108; c=relaxed/simple;
	bh=4+TuaB3AQgdLwq2LWwltTJVy79a442h+ql8Ri/7OV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdPm5c9SRWYUWOGKH27GByHphzDYVxYDOlAB+RX6WJTUH737D/H75nlc0TANs0aI1vLRWTiGLyJUltpVDE1kjGK8ReCjsQ+2DmlBlb1Kf59nESSVkt+QJ9RloTs3tqYQluJmUCHoxuQxY8ihSxhDO6GP7WYqGCZ/zpaMzAKtql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx0ZHM40; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcab69so10072327b3.0;
        Thu, 04 Sep 2025 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756991106; x=1757595906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRAIqJuFoUxn0IlxAYdnfU5ZQhjUgE5v1C3tZfihKz8=;
        b=Zx0ZHM402QOtWHjEGB4wYnPgsIPBEAFJad0OwsB+QCt3abg90baI7G6Wc0NYqkrss1
         XmRMLEWjj91L02QNSlsDsnmbjypcwQlIpMnKXOH92jEGSLg3HHz17OyfjHLwTNNTHDhT
         tp2mEmpfTVvXzbL1rodHiTjVNHwKkr1NiyXGb5mK5ZxIy2fgkqEuV6btMdVAQLIOdIvd
         tKTfLRpp2GU72cBQoXwUKnZmlJ4t5AXod4BC7m1Jo4/wUVK1DxA4cszY3a/NSfg607QL
         gXDppznXGsiKVCwKRsqR21S+T48vfvjsYc03gIRapri6MvGI0aGonvpgHkS937zisOHZ
         6DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991106; x=1757595906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRAIqJuFoUxn0IlxAYdnfU5ZQhjUgE5v1C3tZfihKz8=;
        b=opIUYfMCBgtFHyxrJdHO+8qwqLFEZFH47olVPCtDYkShWa+NmLxpUEFkvIYFuxkTr5
         8VCJcRubV+5pYqUxDHoXM/snWxYT6/gx2rjHx1tkuu0rMkh49T6zOKQxr6vKvwNSGiSi
         eBY6ADlkCLH0kmnwnfs2YNafmbhrYoBhUyPAzdlZ5/aLJHHJvNfndQ5eGziBgpXmTmkd
         gPAmU/czLawB6x/9LwfyriTFBsomkFP6tEKZnBpGJ5O0K9rye7Rz3TTClZ+Ynv43DqBf
         E+qmuhBz++iahda1PlKqNfHpqx+Fwr/wYAhjeA8zsdvp0gUEiXZyqtL/oJ67IzojDvhr
         /ZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXhd7KQU41+bms6jrWAcVCXlGIWxmsekNT96zoUy8/dvMJbDOpnH9iithApvzxJ3CKdBPYxI7S8U5sBAqE=@vger.kernel.org, AJvYcCXqWofdirOcLkrmHSrEvzNU307wJsTJuZzdQVZA42PmUSgINV8GfIQB4SNgH3xnXux5t7e2i0Gl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp89yaDU9X1+uP+6ssjzNkc7emyiUWti+7ekjCHKO+9EZxAjs6
	w2ewHJwdxvCeysmamVACdK921JLSMTcfpP2dlEyHLRy53MVpvsSW/i2t
X-Gm-Gg: ASbGnctyRLX2TPE/2z87zcJyiLuqCMZsbGVC0DxNOyBZ1H0SMWtQf6hGM5NZ/Hfiqah
	ITbuDuuA7QpI+HtXSCXiksuvq4yr4nXT+x186Y4kfzgCCp/O/t29YIrLFCPbT0yXNk1mgoPJg7G
	9emg1DI0XdC1iH3o4JJsBQUHJHyde2E5/XT/f6dG9yhCrcc3brwIkc35+8XHR4CY5ya3HaWHEwd
	nqFLF1n3tDBi6uKQfe6+jpWrG4R4w65Roq2GM3Hv1BEXInWokhnLhyDBswpiSWey8yGqD4QgXmX
	hLA4OGAAt8RLtkXTyYcuhvuMi6ccaUIZVcSSJXdoS5Hpu5iDEUWY69aZBqM5w9syrOvT6RxGHmE
	gMyLkl3SQ2q4RnPgzHe2wIEQXzfiJyprZ0Re54ngPqSTzAbvDw/A/pMSu9Zg3DXg=
X-Google-Smtp-Source: AGHT+IHmWVZV9smFiDb5EAWgukKWH2yUMaPX0VME1uD4yW4vCM5Ef44xf0wr2EDvqQBA5WuTd7GVIQ==
X-Received: by 2002:a05:690e:164b:b0:600:b3e5:d4ff with SMTP id 956f58d0204a3-601782d338bmr2063081d50.31.1756991105967;
        Thu, 04 Sep 2025 06:05:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf6d877sm2261100276.15.2025.09.04.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:05:05 -0700 (PDT)
Date: Thu, 4 Sep 2025 06:05:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Message-ID: <aLmOfsgjumBX3ftE@hoboy.vegasvil.org>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
 <PAXPR04MB8510785442793740E5237AFA8800A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510785442793740E5237AFA8800A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, Sep 04, 2025 at 01:55:43AM +0000, Wei Fang wrote:
> Vladimir helped explain its purpose in the thread, do you still think
> it is pointless?

Vladimir gave practical examples for the use case, so no objection
from my side.  I just wanted to understand how this is useful.

Next time, it would be helpful to have that info in the cover letter.

Thanks,
Richard


