Return-Path: <netdev+bounces-198133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9371AADB59A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91FB3A768E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B91257458;
	Mon, 16 Jun 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="EWlJMGfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C682206AF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088165; cv=none; b=RyLLCxNyFU6SZECQhjYMeOLeN9j6ONlzlXleGzcUzwuXPGvn4y8txxu3SMRaYRFJRKqgtYZfnME0og5u6Nc73xGpEujV4Gv4VuDrX6Ms2geFKmIA0EkhNp2lk47TYJM7e5Z1Yajo1CQ+1eTf2gS18FdcttLZLUp6pN6DNHT5nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088165; c=relaxed/simple;
	bh=JyeYpEgfXXJs9sXcrw/TrRcixYECA3zNxMk3cMt6iQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKYK5sDJO3/sRU7c/V+2hXfCC6DyF0blViE6rks3zIS0bdtE6sTTawzMEefKQPuTQIJIRJ+1f4qQpJF1FpYvyS/sPKjwt2qFf9SQpLnNUnZ4RNk+k7tTnVJAMxxjtujzfzATQVi/B+gIPoEB1Q4dKv+F+oSoxdX5U6jcMQcdIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=EWlJMGfe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453398e90e9so24115695e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750088162; x=1750692962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRhhjNzBpPywHz29LvHHa//rV6tmBgWp6eivc4x4ByQ=;
        b=EWlJMGfe754RmYjk23jSzZoheMndZ8tcrnqwggpVymKZEVV48m1YiZHvEHKnvM2t+5
         tH2S+SffdYjcbkovHe7glxo38R+JeV2Cv4k1RbTXbrQ7fzoE9lrlGzMf4BbdkKGMTB5O
         9hTAqY+F/mOYJR5N8K8323VHuup+lbcWots+Ew+j7mQKMVEzeMEoVlncaK4FqynTLUZy
         aZgYVeqTK3g4aaqLyVx7J5YiZw8uqqSnzyoFhqFql5EUZhI38w2rxw4eUZt2YQ1YfA6/
         9caO5G8OlQCqMxHnoES6vt71nnhUqrypLRs2ypoTlQFGtezen3/0tzkBNVXZJ0U3jMn2
         p4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088162; x=1750692962;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRhhjNzBpPywHz29LvHHa//rV6tmBgWp6eivc4x4ByQ=;
        b=IkZysGJWrkxEUYkbK44rHVKqRXVRnR7+nN2T3krIeAcoVMDaPUYbmSriJyIMblyI5K
         LnLeaLMvLFBn5jCxw1i+XFgpUT67jau2GySKakiqMOdFowqmg8T2EHYHAVvBOs1R1z07
         1Fs7PnSQ6hORD7lWiInrTQLkIehNzqwe2umLACOwgyV0JpVG5zWkNWFixsQ4dZ2BwuXH
         ceRu8REOULInWBXZFJpXfEmRk6szyW75FwVEGXgi/zhHRdZcG5a0O0axi7LXKR7ZXShB
         1S7/vubgvV/59xq/wy4zs7p5+WiGWWWDzei86yJ6s0OjL+fJP/+YS3gdTc8FAzIuptq5
         nuDw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1geZ8S2c38pdIFHynAXzuMMr4v8HLNiWVf5PzT1pKG7GaXcnUzc9q5Y7ZAHORdLWrGPY5tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZTnQ6a050FQostueg0uMx8ySAFp0DVoKFhdvVzLUL18TPQw7
	i2SEnhbepTzV8QnkG279chLKIm8bhWLHQ5Wj3yFyvnZyP9sqgZBDOXX/hO5+49HHP1/KTV1CWSE
	LrXlgO4M=
X-Gm-Gg: ASbGnct/ETHKcevpOa41xqUmLYgajourTYXJlws5STTbbRUJpFeiK1o1Fz7b9PkX/m8
	BJyQVDSrzU53Z+sWLSivT8A144wEKani+IavekXXU2Qx3yd5sOcdaNwILk6XCI53ffVNLsmUlWh
	hEDdRkIgzx0TMM20qeoSEAFBzNAhdgpyKUtkIXzcuyUCz4fJtJYdGokiVenV+ZPFgYGVel6Ookt
	x2pkHIMpmj6T5zhbqrkD5WUwmJm8EKUmXYzqIHBDzSc16GeX/4b4eziUmAcQmEMU988fS+RuWsB
	Ztvm4yZm0qW0bExAlQO+yGYFjufcd8/TTyNCNdR0eJmG3137c4t/bLCWBM0gZ+DFWkY=
X-Google-Smtp-Source: AGHT+IF/AJ0JSg6FcfBnP2RA68y0+f7I5WJcx4QXm83I71RwvNucpNeyvaBiE1GS+rUfNOA8YZy82A==
X-Received: by 2002:a05:600c:6388:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-4533d49b94amr93119405e9.14.1750088161814;
        Mon, 16 Jun 2025 08:36:01 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea17d7sm146441245e9.10.2025.06.16.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:36:01 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:35:58 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 7/7] eth: iavf: migrate to new RXFH callbacks
Message-ID: <aFA53oKyldNcugoA@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-8-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:07AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> I'm deleting all the boilerplate kdoc from the affected functions.
> It is somewhere between pointless and incorrect, just a burden for
> people refactoring the code.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 52 ++++---------------
>  1 file changed, 11 insertions(+), 41 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

