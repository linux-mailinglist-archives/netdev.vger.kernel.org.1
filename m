Return-Path: <netdev+bounces-145010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0B9C9137
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5631F2358B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C218C91D;
	Thu, 14 Nov 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VwmIQSpS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41C18C32C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607096; cv=none; b=OaDRRW7pmO+6IqhVevL3ZT6PNZ+NAXTRoX5/2FAgb6xw8yh8E65pxKL8bBxD0RH0OlD84cNn2AmThxorBFQ1Jm7jvh3Y1/EQcnOK/2ccj+NBahM7fwaE360VhM9R5Pl9EKiElAnlp18FtXi2DWcjAxJgXGhLEPRxQA1tCFZ0u6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607096; c=relaxed/simple;
	bh=v2ab1vkCw497EvY3tHNVA+TwYZsLqPYJxUhnnM4XdlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fftK50QU2NG/3QTMRACnKn5mCTdFKE/2OB4LyAXHKw5Stn8jsDaJ0e+zwhAuBrWkwnfqRWaTOjvmCo2eGy2cF8PiLgldlCQLgNLvPHOalzQm48V4GghHgDN8k0MpRDHhRQGd5ABPJvyNEK87Px28XpCnCXLw6qv0UcIVgqG+wZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VwmIQSpS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea9739647bso689061a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731607094; x=1732211894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3z6SDvhxZuYf4/dY6ItezDeFDMD8qQ1RfdEEMTGt4s=;
        b=VwmIQSpSkO3sDy9D1s0LWEUi6y1dXhBpMdxUnhEmHPgnF2qnaMDEuErNhkYocUYMxs
         mkYQkPA9CPnKEBAW3ZIajv1bqVfBuNy6hU0fu/tlluh2ZyFoaCDEmFWYlgP2m+loi4Wp
         klg3edrlwr2FU//axQovg7TW56kFRdCBQGN0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607094; x=1732211894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3z6SDvhxZuYf4/dY6ItezDeFDMD8qQ1RfdEEMTGt4s=;
        b=KOFgnvBmOn0/gqn5ME3gwGU6vqx8DTksA+vyzkYzw34kEFv+1Z8wtoKP1de93U+HkD
         PHG80ZCPFPJwJXPybksdGILaUWmYc3DjD6tk7XbZX+6GrUCGOQdZkDV0wHUL+QGlQK9b
         FzDzrAzLr3HZ77/Q3smisSiQe9N1CGqNhD/l+r7iTTKM999fjVWfZNj/LABUUFbYrUBf
         1VFPLq8nu9zGaTuuOYw+8Adi5fcwTfAnslEvahN+dfzKTH4qfrLw1Sb96IrZnpL4aefr
         zC+yjFSripWew9zS/momv/Jdgl9HZkf/FWb4a7RTV/rQCSNWiULuLk/MWlkNj0geq+2V
         CmNw==
X-Forwarded-Encrypted: i=1; AJvYcCV+D/ZSkSBgZslPePuKb4uFJZUfeV9lQ8qOFaOz0Cp56CW9ujSeBFNU8/a/omiTLsI4O4SGotM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wuxRyetBWXACRt9zrdkuOGQTLFB5IM9ILRcFMDh0dBRs7SX5
	KDsI5PEaTsysV/4dEmvCEsDk/LbClvnETwsjp94G+JPmOo5ugtlyw92RT8qbY30=
X-Google-Smtp-Source: AGHT+IHbkdz9oAl0idgX3gmNVs9if7miOlUjBydLskEXfpmxrDo4Cu4ddQDmr9hSu/C63KtkM/KGPw==
X-Received: by 2002:a17:90b:2dcc:b0:2e9:2bef:6552 with SMTP id 98e67ed59e1d1-2e9b1793d60mr31256465a91.32.1731607094540;
        Thu, 14 Nov 2024 09:58:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f4b2dcsm1476971a91.25.2024.11.14.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:58:14 -0800 (PST)
Date: Thu, 14 Nov 2024 09:58:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org>
 <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>

On Thu, Nov 14, 2024 at 10:06:02AM +0100, Paolo Abeni wrote:
> 
> 
> On 11/14/24 07:29, Joe Damato wrote:
> > On Wed, Nov 13, 2024 at 06:47:35PM -0800, Jakub Kicinski wrote:
> >> On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
> >>> base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
> >>
> >> which is a net-next commit.. please rebase on net
> > 
> > I thought I asked about this in the previous thread, but I probably
> > wasn't clear with my question.
> > 
> > Let me try again:
> > 
> > Patch 1 will apply to net and is a fixes and CC's stable, and fixes
> > a similar issue to the one Paolo reported, not the exact same path,
> > though.
> > 
> > Patch 2 will not apply to net, because the code it fixes is not in
> > net yet. This fixes the splat Paolo reported.
> > 
> > So... back to the question in the cover letter from the RFC :) I
> > suppose the right thing to do is split the series:
> > 
> > - Rebase patch 1 on net (it applies as is) and send it on its own
> > - Send patch 2 on its own against net-next
> > 
> > Or... something else ?
> 
> I'm sorry for the late reply.
> 
> Please send the two patch separately, patch 1 targeting (and rebased on)
> net and patch 2 targeting (and based on) net-next.
> 

OK, I've done that. I left the fixes tag on patch 2 despite it
targeting net-next, but didn't CC stable since the code doesn't need
to be backported.

