Return-Path: <netdev+bounces-162847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEACA28237
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E4D3A06FC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAC213245;
	Wed,  5 Feb 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aB8JAkNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F37212FBA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724130; cv=none; b=NOfwptY1kMBp31eSaj6Nq9xd7ZBW70gQJYcna2WcF5hZ7ojf4uNkHKBQPmt8t7uShpFkrqt+AS/ndvnouwI6YNM9T1XzAgDyqupjcZ4zwwPWpkUuFfW7uDC3iBv/VybsxNCVfGatgF0fujPOVNEqigHy1gJhUO8pFgHl+cpaVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724130; c=relaxed/simple;
	bh=QT+GjxZnomFprCsYTmqbMFNv96jOwrOslredsnVeDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJKl0dvbFGue8GKbJknP/wRnYm7ery6xAIfRvQ/gnaq45TPA4u632DxNlmtvd6EUCYgEpAfPnh6hL52VPLxbumbpX04p/HdK8kBeIXcxXq2KVXT7ggwmS9ElgUtOMUSia6kXyOIPDc8xTwmThteF+dBrCI+C+SvGiMFmcsAK3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aB8JAkNB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso105805785ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738724127; x=1739328927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTWmoqb4s56IJqGFUw7WpNhUFo/c/5qM82zk1Xjakns=;
        b=aB8JAkNBsLFtcS7h8kQi6vTplExFq5aqcuc2wTjRpQBQiexog+Ge/cqcwAIAcGbeYZ
         OaNX07253Aobdlj7z3O6s3IwQgicJwzQw9yFRmDOOWDWSc8sSuS4IaK/nnUVA91rKH/p
         8QBbuM7GZuzKM7UaRnXxbJfnzzi+9nVcnDM28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738724127; x=1739328927;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTWmoqb4s56IJqGFUw7WpNhUFo/c/5qM82zk1Xjakns=;
        b=XVFy5DxyFA6WCOboRk6yFzD/JsQ9gQEMrLHR/CS3yZDBw5SotO2hSqgSN2Ml2vCSna
         89wUTLX7HkmZVV9rmxtBiSMu3QiCzABy3niPI4sxd/AtPRK6yOullonqJmCNXn46k3Od
         zxrMFLo0+rRxAsjOkO40lrTUdHG8pirmHawC2hKyY7MWI6SqV4+nxJ+xvFsHY40VU2+Q
         uDLV9HE9fZtHYY8yMuQQ3Yi4GLKgOH5pUt8w0htqewWfU9GgU/KHfuf+898gJWIh/W7t
         GfHEkuhbYhGEUANZx3XxALGE/XiC69d0NObEX4uEH1B8lPUt0W5CMqAsEYWrFID5JHUv
         HW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCULi9V6sCTBNByKPriNTfuBHX38IDGktM9OZFbtjuVujHBuDxp3cYAAEiHoZ1NoEGU4nXV+5K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSAEMryPfoomw87yPL6PUTz/SgbXc1gwb0WbtV+6T1s8nfW7r
	zXJH75fDoo3Jkm4T2Jj3uy6lUo4aabq3xToE3qUc8+KOnqWIl1QcHddaxfcBcwg=
X-Gm-Gg: ASbGncv0hFL0Hqr6IVD4F9HYSwNW7Hba72V1fOWkLar3bg+WW8AQelgGe0pyY7eUuZy
	AfpGhwzbhSG2Iymj8ve6LuALdIYv7FzeBHAFaVYCytz6/4xVvogA2nbNmPvpLHMX4lf3idtdFhQ
	SZ/qxQw2HiqDkDpDwpP3EH58hgpaLAk+XZ7v9gWHC53SX/iQURye1wCfc4atQsb40GqGQdF46qt
	HGrSi3ubbksabzozAlCQdQRvreGv3mtzlIMlHcetENqApdbupp//OjnH3L77dENg/k4deVgYSSL
	y1vVwTLvdbGry84FMRAHY4++8jhEr3fPYEqTN2UwJW0onIoRX7H5HTEd2aJb+54=
X-Google-Smtp-Source: AGHT+IGQ9bFZb261hq+GhXbxdyAWwHKcm2GSqeaQsdXZt+8nvjORSVOH1HUl+HU7NrM0By3kM+IcRg==
X-Received: by 2002:a17:903:2346:b0:215:8809:b3b7 with SMTP id d9443c01a7336-21f17df5bcamr14883075ad.7.1738724127688;
        Tue, 04 Feb 2025 18:55:27 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1da7a1dsm307220a91.36.2025.02.04.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:55:27 -0800 (PST)
Date: Tue, 4 Feb 2025 18:55:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] net: Create separate gro_flush helper
 function
Message-ID: <Z6LTHDR2OIHGM2y7@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205001052.2590140-3-skhawaja@google.com>

On Wed, Feb 05, 2025 at 12:10:50AM +0000, Samiullah Khawaja wrote:
> Move multiple copies of same code snippet doing `gro_flush` and
> `gro_normal_list` into a separate helper function.

Like the other patch, this one could probably be sent on its own. I
think if you want to include it in your series, that's fine, but I
think factoring this out into helpers is good clean up.

> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  net/core/dev.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 50fb234dd7a0..d5dcf9dd6225 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6484,6 +6484,17 @@ static void skb_defer_free_flush(struct softnet_data *sd)
>  	}
>  }
>  
> +static void __napi_gro_flush_helper(struct napi_struct *napi)

I wonder if this could be changed to take a boolean as a second arg
then you could also use this helper in napi_complete_done in
addition to the locations you've already cleaned up?

