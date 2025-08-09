Return-Path: <netdev+bounces-212330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69FB1F4C5
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EA5723B20
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953C276050;
	Sat,  9 Aug 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC1t++yc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D42609D4;
	Sat,  9 Aug 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747120; cv=none; b=LwKZPdQqVRbz5WYei5Ct8+Kypk3zsMaVUai/H/5ZWb2dcjMbtW8rraX8AjfvsAtnzC925Xk5isTf5xkzrmzBWmFDKMtj2n4jKDOsiEa6duIdpst4h8k2N3wKu3uyuvJiksatJuKn1VF571TwSH1dY6lj2Vx9mwoCdUkJ/A29Q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747120; c=relaxed/simple;
	bh=OUb89YNcB+O1QqowKQck97SXaBpSIoevZfkXAChOW2s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lsaVujez/kB8YawF1wNCbNP8MDQgdAazzuA2Xmwuu0Tp7h0CC6qOQbhf81JUC3KeobXYicJKb+XadMJ78T+TMxvC4ZPgmUSb27ogrJEbCOsAhTIntZjQGx6qvp4KQANpXhhxK/WpiKe5jxtdr/ei9ZWz30OL1AJWbBu4ey+KpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC1t++yc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fa980d05a8so30838286d6.2;
        Sat, 09 Aug 2025 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754747118; x=1755351918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6tarr7SGERQGP4F8QUjzkuALlpG89WF5FI3+w2kYgg=;
        b=lC1t++yclb2lcu/22TEdlySgL7WhfA1H2ORbAtuDfJbvu+Ez7RacqTfTo/5VVZLAS0
         kC8geTsMnDfxQjYGl474t00RQGTIIdKkZGWhhGbW/47nlMXY5ScnSH+118xRfwlTxhF+
         H5lk5GqiY1/0idESX2CORNkOObjGWxE68GXoAnDByBfTyXrt2chG4bQpUkh69CrpN/7i
         IWPb+Sa+O942rcf4E3LKoOXCe7Q0HXa4pn7uATTn+YlBrzKhh8ApRJJWnWDVYOFMkwfe
         XHZOQtX9MG9TfwmSbBkL/qJaxurMNrNRvLcRjA9QysOH60XhAlZvyCmuXx9wnMxFhnYd
         GSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754747118; x=1755351918;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z6tarr7SGERQGP4F8QUjzkuALlpG89WF5FI3+w2kYgg=;
        b=ocwAVklu5EtI1vP49qV2rv1dTJlZ18B3QLrDU8TdTavnjHEwiSEkpOxIO/p9DNjfMH
         jGtLkJ33DwvBnWmTcYbNGubTVx9bEo4WAxs4kBNbgcPSeWYSVFT/BlUehmGtWoejYV81
         32JM99h1+KYuT8u6usw3ke8TYeppXBeeNUGqeBcSDLaM+n6OSFb3Z1KMLGYvQcj6mLBS
         bIyGrdtJUdUOLa8HLz0WXbV2FF1obIE1DjWBfQvBv9oEdMRHQ6zm5zEDkD2fWq2wDY3x
         M3Ba0L2z1hVy94IItCertceUKUkxHOSsW1G+Ivn93lL9kqnu7MDxzeyPI4rwxUgeU6bA
         /HzA==
X-Forwarded-Encrypted: i=1; AJvYcCV8BkZhqThOQ6gO/aXgGl80BF2ZbENe8FJMTfDWM2jLAzQJY1d+nk8WyyS7sJgbkRko+DnAt53o5gyqmhE=@vger.kernel.org, AJvYcCWswpdXXbi3L/nI0C8wONdoy+LJNENz0JG6i24IlxofguTH/vnx3zTKCauheWzJTQKA3gEOhgYc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LLmJc6b3GxA+bFiyjPnTM5A2CYazp4GKlfJ9cRwa5+/I66RL
	MCKJRQyliuExfiSzqQk7FwFiNrZ8yGob+AJxIk+9NSQC0t590PH4KlyH
X-Gm-Gg: ASbGncstMvGHP+7hNbfolqVur+ZZeb6JMiO5NwSA4iV5cnXlFJrExGYhxsiem+aPV6A
	ONxo1Sxav/YxTczrkI1Z9tnCEg+cC3RB3x4wSIUzl4mT9pGo30UPkHkljjPfG9Q339Ie/PchXrS
	R24XBMeLC/+2lHHeZYKvoLsD+u7oKY/V1GNwKBiAa3ELvNRSqC2VHhFrKf1G0rLhcB2hP+Bp2HY
	3qHqHBhAYZaoEyx9uj8jUh6Zaj2VC2o9TWWckMWkYzqraX76Fp64wZ7IPF4ZAkYi9DNuLsc9uFb
	DVFH+S7j+b8eXm/aewGdfMXgbjLYuD3QXAvibL/HFwjY84Cztv9RvDtvuazBD1raQJ2bMx2SPMc
	6eZ1PMcTbWcgVr0ftLmsipBwoX+5ghNsHrSSHy3Svh0m/MY7FsFZHaKokhya84q9DUZLLoA==
X-Google-Smtp-Source: AGHT+IG/n7ywdlro1lwrlyMwE93AsDo9/VNyCkACNxcREpkxAWB8Gg5krVfaA79gvryYNnCsHWOVLg==
X-Received: by 2002:ad4:4ee7:0:b0:707:4668:3314 with SMTP id 6a1803df08f44-7099a28496emr96806106d6.1.1754747117960;
        Sat, 09 Aug 2025 06:45:17 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70937821c2esm102984576d6.68.2025.08.09.06.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:45:17 -0700 (PDT)
Date: Sat, 09 Aug 2025 09:45:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <689750ec91ef7_2ad372294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250809124313.1677945-1-jackzxcui1989@163.com>
References: <20250809124313.1677945-1-jackzxcui1989@163.com>
Subject: Re: [PATCH] net: af_packet: Use hrtimer to do the retire operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

This is a resubmit of the patch you yesterday [1]? While the
discussion on the original patch was ongoing too.

Net-next is also closed. See also see also
Documentation/process/maintainer-netdev.rst for the process.

I'll take a closer look later. Agreed in principle that it's
preferable to replace timer with hrtimer than to add a CONFIG to
select between them.

[1] https://lore.kernel.org/netdev/20250808032623.11485-1-jackzxcui1989@163.com/

