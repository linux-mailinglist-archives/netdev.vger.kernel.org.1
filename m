Return-Path: <netdev+bounces-151844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C59F1450
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D37188D32D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E13917DFF2;
	Fri, 13 Dec 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hrAYcSUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B0632
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112197; cv=none; b=H9q6jx9irGVo7Vtatl4Ldu6DH8i+b8zDOXJVLaz23B/at/qbN48B2XLfIOxhd+CHHQWf/WbAFhmFDBH+oT6tqSZwrK7dzsQAH5d7kyiZ8PGTTVAPYLxKdHzaN+Npl53DGLPP5Y3jf3avCAgRWV4CDJO7M7+FHnuvNcvHBOflnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112197; c=relaxed/simple;
	bh=8vMElNfX0MRlPEMSkUEf697NX5ZGg5D+bLz5d0grn7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5AU4Ja9cIm826nnG4bJYfkqu7KqKAr+bRRgkFti7QxZbDFIL/QKNAwRXSw2u4CHYl/OV968Ny7OQnMT1X6w3jmpbAfUyK0c95i05m+mCc5GP9wd6HJ1A0GZLtXeuKyp7YTHa6sB9GTbmEGnrh2bLFNVsEZ6/32VAC6Mb+yRDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hrAYcSUa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728f1525565so2465105b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734112195; x=1734716995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoeRSpsDS81GwvSyWkqFDuog6WCw8LHM58POPtSjicY=;
        b=hrAYcSUaBJV6qx8FNvlho2LrSf4aqMifj5HeBgd5Qiop6BAh5mhefywQI8nZcaBkUX
         dzRyUNXFZLcxxzI+0jLpIuRa61d6fo/oPDAEd+CEmsAVc/0Zf7RQRh7N3SscmnLuDsiV
         Xie/m74UW1Fej7xmg3wIfeegmH1S89QlJm5Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112195; x=1734716995;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoeRSpsDS81GwvSyWkqFDuog6WCw8LHM58POPtSjicY=;
        b=LELhsTMOL19f1Uuf93BCopIdNug2fAUp5V4vqGfwzFoAFF0x8NOjPgi00Psua0NIZD
         mOG/8TKw796ryWJhCLlQOAJc/RkI7IFWTrYEjCF99E4W77dDA1Bx4efphCIC7qKWFxVV
         +p5rbWNFbgdpLmZCpCiocHaFPoeGuJpuFitHWymJaA5gOEKqlZD1DPR3pqXK1Pa2wG4w
         tq7ktOmAFbZzL1AztRFXZxoXRvY3AwmTe5gdtG1/YGHoZG7HXysOLB28dzJQs1jRHdef
         9xx6pjUrHDry55/fexHxLnEQLb1jvG8wmTRCG0iu/Tn62NPkT6BjuxZIvwFyn/78Ho7R
         7rCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUxPAH1E5rl9YP9VRDvUGcwcLeuUBWv8cg/OiT8ccHkWrVxipUp5fzr9rtRumhRAMJDjGPqmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYexX2KeAwGfjf3LGSmH+dy2JNmG2o2XKc9pmTGeHHww5ssCA
	M/0OLnlk//9Fx6WSItsJUITZajwDGQvMCHvw5djkB7Wtl7WiKIXgjaGPagrEJOA=
X-Gm-Gg: ASbGncumC8YAplYCiNK+e8HRw9987+eKuMfqS7/F6E+8jyTWO1PVhZXSYpJzkFA//mz
	+ccBipkdIjhYGNf/diVKNrNvAkMCyfckH6JaERMYnFKUGwWOuEbqbHm7qXtwAIls4My9przKHyX
	xx2ARUih63E11yTpOKA4n6A1ZHovmNE8tiejlxPapzyNLIMeCLgUE4KxmEm3fbg3wLi+FVw/A2/
	tZJHHa1qKdoPCnNVRi/3Q6ZgNSI69BCJxwlYpT3ZTobWYj5z+9O2atCbiySoTuxjuqAi5XWe49o
	GJA+dukyKk0ywWae+OyMeZk=
X-Google-Smtp-Source: AGHT+IEorBTg1SfiLGh769iPLGW/DF2t0zWhVDbfYD9DXoumKSlNHV190M1gZNAfQ80VoG9rlSQpQA==
X-Received: by 2002:aa7:888a:0:b0:727:3c37:d5fb with SMTP id d2e1a72fcca58-7290c248b32mr5420514b3a.16.1734112194886;
        Fri, 13 Dec 2024 09:49:54 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78edfsm46216b3a.125.2024.12.13.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:49:54 -0800 (PST)
Date: Fri, 13 Dec 2024 09:49:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: prevent bad user input in
 nsim_dev_health_break_write()
Message-ID: <Z1xzwAG4xqkcSVzB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>
References: <20241213172518.2415666-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213172518.2415666-1-edumazet@google.com>

On Fri, Dec 13, 2024 at 05:25:18PM +0000, Eric Dumazet wrote:
> If either a zero count or a large one is provided, kernel can crash.
> 
> Fixes: 82c93a87bf8b ("netdevsim: implement couple of testing devlink health reporters")
> Reported-by: syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/675c6862.050a0220.37aaf.00b1.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/netdevsim/health.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
> index 70e8bdf34be900f744e821fb237641a27bb71a7b..688f05316b5e109fc84222476023f3f1f078cf28 100644
> --- a/drivers/net/netdevsim/health.c
> +++ b/drivers/net/netdevsim/health.c
> @@ -149,6 +149,8 @@ static ssize_t nsim_dev_health_break_write(struct file *file,
>  	char *break_msg;
>  	int err;
>  
> +	if (count == 0 || count > PAGE_SIZE)
> +		return -EINVAL;
>  	break_msg = memdup_user_nul(data, count);
>  	if (IS_ERR(break_msg))
>  		return PTR_ERR(break_msg);
> -- 

Reviewed-by: Joe Damato <jdamato@fastly.com>

