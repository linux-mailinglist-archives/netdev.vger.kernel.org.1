Return-Path: <netdev+bounces-176180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE1A6943D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1961895EF9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123902FC23;
	Wed, 19 Mar 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lG8/MyUj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64811F9DA
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399822; cv=none; b=GhE0R4PRzbEz9jTSeCTENNzclLk+4jxCvT4W1vVqzgckjwDZMloi5jL84xxtdqVJMlzNRCWgDK9/jL8E1U/EvRDGdHPAk3SQBxfSYV6yeOedEml7DX7J+olJzzZ7wTyTD+YiQuEYjsOXvSssJRfig1VxQWAXJzBBkd98UmcC8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399822; c=relaxed/simple;
	bh=f+9eQvUdIVyplo97+8h5Gnyx9GiJPqVnK2N7PiScMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljfzAo/sy+9bxyFjlnm53mzdA+JscasDw4Yxks2z7bust5SkY/ihJPlmSOnwekEJhHdf2DH/oHvHZmiJ3fY7e1e9vg1Ogcs6m4ZWca1fMKV5vKRF8byDEThj6E7i28WCkKUBGyLz3P6NILvUZAzS1CbCMTFUaD8kt32P36XSVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lG8/MyUj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224171d6826so48657325ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742399819; x=1743004619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH+Ne/GeJpiV7zojk6DlYEVxyrcSW023NyPjhVX8Uqo=;
        b=lG8/MyUjvbjICR42S3jPEfvVSjnCBfg844F9Qea9piJ2N19iDkF2XJrW4sdnEXgScP
         6MboNEjMiolWJ1dVNDen6DOy/CRRnh0HE5A9h/7YXapxGfK5Y++XmHBzkB24vy2XxaXu
         mu0Ku+BqhB5HNfZZ9Mn6CG3m253JN+3t7zZNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399819; x=1743004619;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+Ne/GeJpiV7zojk6DlYEVxyrcSW023NyPjhVX8Uqo=;
        b=iI8K/3QijL5zZGh5Sxy731hIrTTZpUIMtOHSdADPVBASFU86OusaxUp+0SpG+mRrsF
         6YL0a852t5RJkJz4CZZB/A3vyfNHm6LWA9L0d9w5XoymJxNeP0doBT5lFvPW8NsHYxNm
         5C/K3cLok8zdG52jPO+ixuVH2IRAuu1edEJ+03Wl4NUPWzZMNnmhN/qEvm2J+UDSTZvy
         Mqjw2rl97fe+gWaeCdssiSwCHy/nsM8T1sYnaD1j33xJllYBGEndOxSMuLMAg2XzlEix
         2ibZHC+sw0gu04MA3I7iWOrNmietDfVDyg8Aidx5+YoIf9z0rMFt4Awd48j+FAhfIwHK
         jjKg==
X-Forwarded-Encrypted: i=1; AJvYcCVyaQht/VA4hulwXlmHBZHbJKA1WZ9gcN612zHdGLn9g2wYspps+Oq1AjXtQMXVJLIYbQ6arWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhAQucjCLB8OnoX6GjvsuCPMWdOVKJKFdQiflzetN32n4tDkd
	nJT05IGy443rEBvunw+Q3W83rrQaDIA6i9azm0IOiXvp2SNvKZ2VkA8yyE0GojigQ0Yafa8R8Zf
	G
X-Gm-Gg: ASbGncuxxPYlVe7gxVx8xDSljS9BKdqFYYmBS5FL441zCYOuSvEgIdAOichz6viIALo
	wgagK7RHzJMHdK+NdUEH4bK7Q44QEQBbw7gKRPkwHogBpYuG/2WWsYYRQ1MQBuf3jwdkXg9Zoz1
	7+AviIbmrDEw1eMcyy/W1WXbx4itM0Ejos4x8/SlicJ/iKapzaFQZjsIqzG0PvYHyiTAHPHdskg
	sdta03ADfBFGpoOA0AVwI8V+f6/JjeEEenuTkrjVjFf/Meh1d7Rxi+s70MkCL8fwB0B7B9J/YtT
	5i7nJd1/d6UZ+EYGqZZ6/Z4S5dJpAfGYATrDO2WIUhWiC9shN/u89CxjEOEIqHjHs0DWcwK+afz
	UXomcgKJ3ZgC5w5ti
X-Google-Smtp-Source: AGHT+IGZKa6DjH1sSbKETfBrAx2FPuAUauFFga5rakOTfFmzrNpyGQ0tTt9LHuAP/z4HS1NhFvfzbg==
X-Received: by 2002:a17:902:c950:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-2264981dc7bmr46750195ad.11.1742399819573;
        Wed, 19 Mar 2025 08:56:59 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfb4fsm116134265ad.208.2025.03.19.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:56:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:56:56 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 1/4] af_unix: Sort headers.
Message-ID: <Z9rpSFrBxOfIVRNb@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <Z9n8w-6nXiBUI20T@LQ3V64L9R2>
 <20250318235208.57089-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235208.57089-1-kuniyu@amazon.com>

On Tue, Mar 18, 2025 at 04:50:00PM -0700, Kuniyuki Iwashima wrote:
> From: Joe Damato <jdamato@fastly.com>
> Date: Tue, 18 Mar 2025 16:07:47 -0700
> > > +#include <linux/in.h>
> > >  #include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mount.h>
> > > +#include <linux/namei.h>
> > > +#include <linux/net.h>
> > > +#include <linux/netdevice.h>
> > >  #include <linux/poll.h>
> > > +#include <linux/proc_fs.h>
> > >  #include <linux/rtnetlink.h>
> > > -#include <linux/mount.h>
> > > -#include <net/checksum.h>
> > > +#include <linux/sched/signal.h>
> > 
> > Not sure what the sorting rules are, but I was wondering if maybe
> > "linux/sched/*.h" should come after linux/*.h and not sorted within
> > linux/s*.h ?
> 
> It's simply sorted in the alphabetial order.

Yea, I understand that - just wasn't sure if subdirectories should
be sorted separately.
 
> Actually I haven't cared about the / level, so I grepped the
> linux/sched/signal.h users and it looks like most didn't care.
> 
>   grep -rnI --include=*.c --include=*.h "linux/sched/signal.h" -C 3

OK, fair enough.

Reviewed-by: Joe Damato <jdamato@fastly.com>

