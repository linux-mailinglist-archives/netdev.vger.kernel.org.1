Return-Path: <netdev+bounces-125774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D409896E89E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777EF1F223E5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654763CF73;
	Fri,  6 Sep 2024 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRxINl6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A2487A5
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596858; cv=none; b=YvtIS+gS5SEApvMs/6RV43qOusPXb4hK+gise1h6Ub0HbeQJwZhQOsEQZcGCHifh7IwKEuYyjB6+N9NsTY+L3VDQuuGCloNSrGxWq0BlfYjR9CnGQC9V0zpbwiplM+xcWJ8j7iHPiotlA6FXxXyNApr05T8U2tkiOSl0f+Elm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596858; c=relaxed/simple;
	bh=SHpa3TaVX/PZNGXIZxW0jlQGT5N38KTUnvk2z/VZvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVz0B5j06Mg/EP4CNu0CT/KMy0YNSR7HOnEbPtJbun6jV62xPsEeDIdgK2Rohp0XzGU3YSab0oD69W9GVdM6nLaeIELvwsyJmTuXjG272FitWkYhcvKWUYQPryQbPW/X6KtIyezYNxIMdu7I/DcPt22+xJiMvHOyy8CClmt0M6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRxINl6z; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70943713472so863590a34.2
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725596856; x=1726201656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/5h485WplHgrAfrcpkaODV/RCb8oIGDtSJ1ysKMxYA=;
        b=FRxINl6zX7Bhbl+j7Z/NaLdfepAqwj+5XB8Bq7sHZsMUwHbw9546/NNnfZNPG4Kbr9
         Cfbj/eiVm1LgOw/gDlhA6NzFnCJAHFz+ZxzYwvkTR3IPxAz68nFQ3w3Ld9KzQdpOITYC
         ebQ2PqJi52eOOLGn7IccFQDDMThDMaHKN+Cv3nrwdHBkP9qK4IijffAxFy040D6yGadp
         cESVzHAZ/EWqLrakVyB+Tq6WCEh3HZ7u9aGsxvH5uk8M2CykKGBqkrpLQgvX945bCMb0
         YHgbXWhJlrQperlQTW7lajMoG1O86ToTSgIy2NR2XscL69VX07sHQmO0sjIUEKjrCyy1
         oHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596856; x=1726201656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/5h485WplHgrAfrcpkaODV/RCb8oIGDtSJ1ysKMxYA=;
        b=YMerce9mDB0Yu6DTvQ6iM3Il/YpwV0rhhoA1OiUNIiv1orzwXX9KmBF/L5WFarvl6f
         hBzPy256z1MXfzrUUkbpIb9A9uooS4Tav4dVWTZozd6/LEmVjYthcQgxb9uAKsAeH5Mr
         W9fdPQgLqP5sEwVIdgiFLwrEOSYAnWFKkBH6+bdWx0E2Z+ASHAJeo2nmi1bHfWs31LMG
         RCc7chJYLuN4jDRunwJelGhXC4EK0sb+foK2IZOM9Zd/RUvz47ZP1jcoNvTVlF01vrpT
         J8QrzO5z0XAXTpzFztky3T9lXE5ef9Mt0+ZQRhDMWPWFQPufVjC3qfIJibJBb6lvuJEY
         UQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCULDFg8/iMrRq77HoPZBRezjsJ65R80RzCnV/JZNDCRmNCK+7nSiKQ3/2cSSGYOfARZe/8Q1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2M7vyx5DWQ1vbdSNC2DTJFFiwNAhlFb2Lcfj0TvvuxAH+5x8
	ibCtSIA7Koftqb9sPKt77JviAUfh0lOcNu6IBFYI5ie2rq7q3MYO
X-Google-Smtp-Source: AGHT+IGNOY7nVppXfXNDF7IvFCuoSZ1gJeTvPQUv/FUPFi8fud0wPFrGHCTj6HkiCKluiyp44qZ7Jg==
X-Received: by 2002:a05:6358:591f:b0:1b8:341d:36a1 with SMTP id e5c5f4694b2df-1b8385b2017mr151495255d.2.1725596855959;
        Thu, 05 Sep 2024 21:27:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718d8dc341dsm276962b3a.56.2024.09.05.21.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:27:35 -0700 (PDT)
Date: Thu, 5 Sep 2024 21:27:33 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] ptp: Check timespec64 before call
 settime64()
Message-ID: <ZtqEtVBEQQEp5gPV@hoboy.vegasvil.org>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
 <20240906034806.1161083-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906034806.1161083-2-ruanjinjie@huawei.com>

On Fri, Sep 06, 2024 at 11:48:05AM +0800, Jinjie Ruan wrote:

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..cf75899a6681 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -100,6 +100,16 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
>  		return -EBUSY;
>  	}
>  
> +	if (!tp) {
> +		pr_warn("ptp: tp == NULL\n");
> +		return -EINVAL;
> +	}

This check is pointless because `tp` cannot be null.

See SYSCALL_DEFINE2(clock_settime, ...)

> +	if (!timespec64_valid(tp)) {
> +		pr_warn("ptp: tv_sec or tv_usec out of range\n");
> +		return -ERANGE;
> +	}

Shouldn't this be done at the higher layer, in clock_settime() ?

Thanks,
Richard

