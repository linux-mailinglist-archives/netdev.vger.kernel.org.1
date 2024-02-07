Return-Path: <netdev+bounces-69859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1C84CCFD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9F1C2136F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11247E773;
	Wed,  7 Feb 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gwquoAEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106D7E76A
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316812; cv=none; b=Cfg3OLyeoYFGYp4qMuKZPKKG4XcktI7NCrr8ukaI+6/MKrcrCzxrYZPQmu9sgTlsnNB9vv/HKfLB7l7eMrTStcfXf1LVOpy4cmy0a8cOBAANMWjLBAFwVjt6x6tvhsxWL1gvGDJ7p4S7qk0l5hH331L4IuvzsrxFdgwn8KmlE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316812; c=relaxed/simple;
	bh=Ntw5fiG6U4x7V0dQ7rNOcoT+esXPB/rpqIFiRH2YhbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1Oej6HnJMCOEq9uiZSczvydLjCHYMYDlqtkBx3yv9FnROXUBRRqRa+MbhAP5czeouxLYD/MA8ealjgqsxK7sCw4f+6JZ7GCB3h+E5JUrHoEokxs4Q5erigwIS6Zvc7OLDB+HzokfawuOwfBR/tKnFtgAdCn7+FHAIvuv+4Ot/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gwquoAEy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso516245a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707316810; x=1707921610; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTy0TD/WzR5RIh6lZhgnOebUhLZ8bbC+FvuZI+ulvFU=;
        b=gwquoAEy34dFvJSTqXRIanVMZCQaFlrE9wtu6C1dkC0nsCKWoxqJBaq/f9eFAZ7ipf
         XD/0Mr8JuvjIv8XnTlRWK1fH9f2GU0CMIM4dfipHd/9uCfNmKzAVI1MOCD7pyunagG7W
         vs9BsFtj+077CMaq/R9EFMHE2hCmrzIFeAPXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316810; x=1707921610;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTy0TD/WzR5RIh6lZhgnOebUhLZ8bbC+FvuZI+ulvFU=;
        b=c39SlfxDiOsTB54KEU3XzIgyxVnFWypS3f0Rck5404a3lS/FdZwKDmYSCEA21oAFlW
         jGvni7dMDytYtQofVfUe6SBddtrdPGah5dnFtJpILM0X/St0gIHklDtY7d0fmAjQIKKp
         JK3RrHaz7jDcTjJhTv4fbIkCy9srOX1NVYoUctM4VxsrTJ4iAUZ5M30Szy6XDy2Q2E5v
         qvwWqCXx7ZhJG9QaDzVnyhG4ppppLjgTlY2msqk9YnqJ8v7BKyFQP+5ETUPS3raiol83
         MJ2mw5/GDSDL1/8dXgTlLR6oCet86MeO52PWq0DkAk2DvypPxFeVgEu2ltt5EGL41aQ7
         fMqQ==
X-Gm-Message-State: AOJu0Yxiy5hPr+OWpY0QCzAmv5cP0m3AiqfHLm76EU+8oRrk+gHGmT4/
	PSBp0fAraNYGqxv5SsVwyD7xSUc9KvDBvSeiEcxDDx8SdP3mkq3kWSFB0mXOn54=
X-Google-Smtp-Source: AGHT+IFRoT58DRturmHXvkZDAyT8/9JHrm65jJYXEqbtGPJc/79fabXhyu2Y1L3ntiopc0MLhhppgw==
X-Received: by 2002:a17:902:dac4:b0:1d9:c876:b840 with SMTP id q4-20020a170902dac400b001d9c876b840mr6229185plx.2.1707316810481;
        Wed, 07 Feb 2024 06:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAMqWy/7rZfxs+UZ1xWTANMYi47f8HisJ/+M0EQCvUkJrdf+qRIBnCAus7+SLsBYmDGd9gxyc4d/f7V4Jz7bwggv4Y/jK8Z8HMHc+SeppnVqBGE8cb21dpHnR0x6DYXmItsgwtp+sZAwnmA5ZSA6olj79S+HybqyCjdwItJYy43U+N5w+Ae3jni2u+MXPHRH6P9mlzfgFml7Sa6gt++mkC/UeEJejGme4hOQNd0U1aSDF0aPZTbLzzQ6Jwodqrgb1axquKJ79d9WWA6TxnyikniR+JR51Owv+GcAHbcH4/6evizQVlnk8QJ7ZWrFd/aSx35Znj1YKWyTt2xW+7B04J0iFJ+NAnWI7lalNUzN3+YJPZs055JSjC/yo=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902f21100b001d9fadd2e22sm259608plc.252.2024.02.07.06.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:40:10 -0800 (PST)
Date: Wed, 7 Feb 2024 06:40:07 -0800
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	rrameshbabu@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240207144007.GA13147@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
 <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
 <20240206192314.GA11982@fastly.com>
 <b19c4280-df54-409e-b3fd-00de6d6958d4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19c4280-df54-409e-b3fd-00de6d6958d4@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 03:23:47PM +0200, Tariq Toukan wrote:
> 
> 
> On 06/02/2024 21:23, Joe Damato wrote:
> >On Tue, Feb 06, 2024 at 09:10:27PM +0200, Tariq Toukan wrote:
> >>
> >>
> >>On 06/02/2024 19:12, Joe Damato wrote:
> >>>On Tue, Feb 06, 2024 at 10:11:28AM +0200, Tariq Toukan wrote:
> >>>>
> >>>>
> >>>>On 06/02/2024 3:03, Joe Damato wrote:
> >>>>>Make mlx5 compatible with the newly added netlink queue GET APIs.
> >>>>>
> >>>>>Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> ...
> 
> >
> >OK, well I tweaked the v3 I had queued  based on your feedback. I am
> >definitiely not an mlx5 expert, so I have no idea if it's correct.
> >
> >The changes can be summed up as:
> >   - mlx5e_activate_channel and mlx5e_deactivate_channel to use
> >     netif_queue_set_napi for each mlx5e_txqsq as it is
> >     activated/deactivated. I assumed sq->txq_ix is the correct index, but I
> >     have no idea.
> >   - mlx5e_activate_qos_sq and mlx5e_deactivate_qos_sq to handle the QOS/HTB
> >     case, similar to the above.
> >   - IRQ storage removed
> >
> >If you think that sounds vaguely correct, I can send the v3 tomorrow when
> >it has been >24hrs as per Rahul's request.
> >
> 
> Sounds correct.
> Please go on and send when it's time so we can review.

OK, I'll send it a bit later today. After looking at it again just now, I
am wondering if the PTP txqsq case needs to be handled, as well.

