Return-Path: <netdev+bounces-160627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1CA1A950
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42923A6D72
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1316153835;
	Thu, 23 Jan 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ByJT6a8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FA149C57
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655390; cv=none; b=RnfwZlWUwuFK0yIukkm0XrScUxLVRobpdzHLgiPGhi/EoYOYYQKZYyv28JIxqPYODgnfhe+LP9iPKOhKkOb2KcV8Jpv8d6UBzgxIiSU+E3vXykFu6IoaCNhyP6WMMuJuKQO3WVKWRXqyjRs7SNawuVOqB+7p9KAs2VV683bPrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655390; c=relaxed/simple;
	bh=iFOUozw6TdUGrLezmFixbL8oAZQSo1A/LILcVLn4Jew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtWZfd5afIvq6b07McWUDCz8YDCfaVH0pP6T2CudysrbN4b1SfROUyRqad8B+IQnYXq5KF3YzfqycyuhdF96sOHmxULYers3Uk4j3p9URQZcw/VffAjtFxor0WmBIe8CDw4m2bpBfz+iqNew4rdaSjUzBMssNXeb200wMeX4JkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ByJT6a8T; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so2390820a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737655388; x=1738260188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+/u8gyQxmGZ4v2axSJ4b4ESAyCVohSFwYcMGNhXaSY=;
        b=ByJT6a8T7ul6r9nPNqmfU4nZU+DWrhhCVW/49JFG36OIg/q5/b6Ne5GjAbvGq7G4wT
         L2l/uHsADPMt+VhkpUeh/ABYLsWRU9b82w2GDrtzgUnV7UuVLH/FtfnkFFXoTLc90k8X
         g2soAf85Hhyx8We2iqtPY3uDEPXO+SU9KSI5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737655388; x=1738260188;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+/u8gyQxmGZ4v2axSJ4b4ESAyCVohSFwYcMGNhXaSY=;
        b=J1GIOuP4NkcrkrBrqfnLGjYh+/YIG1TaBF33YW2CTIxvzb5+/idRYPPX0Wyy8kZSHV
         stiP8kbUx5JkI2Lza3nDRLY8KQTPst3YZ3Lm0d/PMi77FLSUUlZIKAOxWn4CPv3WuCPw
         IaciD7uRX6YHkLBk4QznD2i9lLxVMH1Rn6QF2pinahbD/rz1uwKDbqORNsHCXJ1vQkIb
         y4FMfe/sGUvMzE+etXaxsBFJ4foaYUrsKGIfx7Xpun9s3UaAAXL9zIX+xlgHSRuVLovq
         ITOogage559gjCxJrDlDLX5RPkSPJBM0kgerHPVt3JHzoNoeG3J0bupDmSQ8RF+mAHib
         ulcA==
X-Forwarded-Encrypted: i=1; AJvYcCX8qg9hsPfPO4otZ5LjxN27B9G9dZMB8J6WSkPJztWGN4oI2fqrLHGkPjd2Igsxob/V2zwniik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz735Y9oc6EOL3wKUs7ST5NcUAu1tufnixi1dn7xm5RBaxqWnti
	m54b4fmqsn8EatDY8QNziKzRYIaN1cr/q4EP4MEjVQQzzQtW7aK5U/2qEp2KMkk=
X-Gm-Gg: ASbGnctuqiKk1ZVdI7IAoDvn+3pkXxeLMIYAvgAfIsFmI7oj1sa/evp8y7VSckp23L2
	SaQj/KFOoE2vhTunXXX1nSTwZT3Qd8rCOHJDWj+uPGtGroT7pbBvk+eJqJhGDCarL5154ANc5Ko
	vGIE/xvVun+iA1zquwbHgPFcz2zMwJXoGK0MUpsNQWuXx/mnj4V1vD6gPUAWir78oEB+BLCr2Vy
	Q4jYpyL+27hgEv0fKUBabf/voO7irLGXhm5XwswQreWjhJvFIolrPJhSi/Zy5J+kGI6k+eFItiv
	yzOkd+hSyKMhcGnC155Zv0LBQW+/+EeKrOT8i2Iz8QafQGyEc9Gxb1XHkg==
X-Google-Smtp-Source: AGHT+IF1o7EPGIL7IBZxOpYyWuZZruR2k/w730DDjvrwL1i6mjoHCLXS/EGiz06KEO3sdDUkOVg3Fw==
X-Received: by 2002:a17:90b:2548:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2f782d9a164mr37829652a91.31.1737655388367;
        Thu, 23 Jan 2025 10:03:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6b97e51sm4333358a91.43.2025.01.23.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:03:07 -0800 (PST)
Date: Thu, 23 Jan 2025 10:03:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: admiyo@os.amperecomputing.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v16 0/1] MCTP Over PCC Transport
Message-ID: <Z5KEWK-A00NraUt3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Adam Young <admiyo@amperemail.onmicrosoft.com>,
	admiyo@os.amperecomputing.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
 <Z5Ffi4PSf5LH0vOS@LQ3V64L9R2>
 <587d6384-fcde-4bfa-b342-66d87ee5f1ef@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587d6384-fcde-4bfa-b342-66d87ee5f1ef@amperemail.onmicrosoft.com>

On Thu, Jan 23, 2025 at 12:28:10PM -0500, Adam Young wrote:
> 
> On 1/22/25 16:13, Joe Damato wrote:
> > On Wed, Jan 22, 2025 at 10:35:47AM -0500, admiyo@os.amperecomputing.com wrote:
> > > From: Adam Young <admiyo@os.amperecomputing.com>
> > > 
> > > This series adds support for the Management Control Transport Protocol (MCTP)
> > > over the Platform Communication Channel (PCC) mechanism.
> > FYI net-next is currently closed [1], so this will have to be
> > re-posted when it re-opens.
> > 
> > This could be reposted as an RFC, though, until net-next reopens if
> > you want to go that route.
> > 
> > [1]: https://lore.kernel.org/netdev/20250117182059.7ce1196f@kernel.org/
> 
> Considering the time it has taken to get through code review, I think it is
> safe to leave here as is.
> There is very little touched outside of the new file, and a rebase should be
> automatic.
> 
> As far a I know, I have addressed all issues found and posted.
> 
> I would be thrilled if this could get ACKed and added when net-next gets
> reopened.

Unfortunately the list doesn't work that way; the series will need
to be reposted when net-next reopens. There's no way around that.

If you want to get it Acked-by or Reviewed-by you can repost it as
an RFC now and collect the tags if they come through.

Note that even if you repost it as an RFC now to try to get the
tags, it'll still need to be reposted when net-next reopens.

