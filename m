Return-Path: <netdev+bounces-95282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3258C1CF8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD6F283D79
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97860148FE3;
	Fri, 10 May 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqfk2xgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF3148FE0
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311445; cv=none; b=HUD+QaQajGAaj+XhVOCNHOVhbwB+FRtWmXlZlsu9cGSjbjM4CSuwqUkUjcCsu6p/jrlRWoo6fFo1AyEAbC19cACiSVXXNvWxSNdNWa51tM1UvygKN5ObpIXHx/dgjdh3LOS7djZvnc3T7tgmRaIjc0r/N/uQdg4ldwdzlTpNebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311445; c=relaxed/simple;
	bh=+iYkO9WCyGSya3lDlUY5nKyYJbewKpevQ6ehDqlSHmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd9TY2uagXS3BxqbS3NZvwBS9Hb45hhBjCmzVcMWG2eoV3yOcEZi248zWaSXYo/73FgDQvAnuyDbTbYaJcqcB5zvYTGWci7ZnWhfcj1zUcO618rfRC7qlp6z+QmLODwNWGIfSofXCFDC6350O1/Hpzj+yOp0p/XScXDhXmZhFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqfk2xgt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1109779b3a.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715311443; x=1715916243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKbF5ez3aAnikRT+URsvdUjBBBRWYDCnRX2XPSkBmD4=;
        b=nqfk2xgtGqahvs2KCJUgeEPFKcjz1bpVICErYcQyzdVJNnDVFbKp7+6HoMjod6Qt2M
         PO/7JFdtSyyxlsg7UmoS8+FpfA3qjjKgL5WfCJgBciRZjIaXlM0Ym1gH5OjR3Aa3EP49
         jcE4yNAS5Yro/eFS+mMYpHTKGdF5tWP9bXe6Yzj7UqkERS+gVxxMF+pWFKXzd3xmXFrg
         qxWS8xUvV5bkZMKlqmZUHJtSdK9vucQ+pxcFfdEQhje/i7dTS3GaoscZ6v6N9DXBbPFc
         px7pW7PA96qDNFGkaOjV1Bk9yWqoRA0B/zbmWACRQCbBmrr2B3thrSsBwKSLlAnUd3HK
         22Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715311443; x=1715916243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKbF5ez3aAnikRT+URsvdUjBBBRWYDCnRX2XPSkBmD4=;
        b=SaiCC1Rjg70PpoRfMi5JwxmfRlK66qgk5PqcpiZ7FZvMia/YG5C5Iz1t8HnwTSQxWm
         bePjtcXKTvmQoEB7wjkm56y68bcnNAwTbIt6NBRBNRx+S+JtoNG+CjuG2Yf4+RT3T+3k
         hplqu29Ui2YAT0+8nvlSe+DWxYt4fO5+J/TT6PvXWchdzeVG4yOZsrP8BIWw3GNcZeJl
         S9w4YUOlW1eqzxHfT+o4SNqv4QWdt1PKinO3lBtt5gtkzPAM9OcWrjxnVuR5lSaKYXGR
         LBlSiDAUP61E/LiROH3bXFXdhaYOyXjym6QlgVUToppFYCwRyXKWyTEFg+FQPA0qZhQs
         E74g==
X-Gm-Message-State: AOJu0YzVlknXF39sTmB9BAXtF3U0S05W+dNHpVC9dec4VU05MwvG3eo8
	Ll1O9KxAN+atEbXucAxv+qZoJjgwBzImPfkrMjNKfF5SXEGjZASQo34DJnOx
X-Google-Smtp-Source: AGHT+IEpbzy6+dngdx8+xlcXf3bwZIcSvcfCpUMrlwCKDQXcVN85lxPZatgLenmAiGskHqR6bEaqEw==
X-Received: by 2002:a05:6a00:1149:b0:6ed:ca65:68b with SMTP id d2e1a72fcca58-6f4c908ae25mr6418526b3a.4.1715311443476;
        Thu, 09 May 2024 20:24:03 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bc1sm2019464b3a.164.2024.05.09.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 20:24:03 -0700 (PDT)
Date: Fri, 10 May 2024 11:24:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <Zj2TUGKZvyiLnPvw@Laptop-X1>
References: <20240509160958.2987ef50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509160958.2987ef50@kernel.org>

On Thu, May 09, 2024 at 04:09:58PM -0700, Jakub Kicinski wrote:
> Hi!
> 
> Feels like the efforts to get rid of flaky tests have slowed down a bit,
> so I thought I'd poke people..
> 
> Here's the full list:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0
> click on test name to get the list of runs and links to outputs.
> 
> As a reminder please see these instructions for repro:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> I'll try to tag folks who touched the tests most recently, but please
> don't hesitate to chime in.
> 
> 
> net
> ---
> 
> arp-ndisc-untracked-subnets-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Jaehee Park <jhpark1013@gmail.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> 
> Times out on debug kernels, passes on non-debug.
> This is a real timeout, eats full 7200 seconds.
> 
> xfrm-policy-sh
> ~~~~~~~~~~~~~~
> To: Hangbin Liu <liuhangbin@gmail.com>
> 
> Times out on debug kernels, passed on non-debug,
> This is a "inactivity" timeout, test doesn't print anything
> for 900 seconds so the runner kills it. We can bump the timeout
> but not printing for 15min is bad..

Got it, I will check these 2 cases.

Thanks
Hangbin

