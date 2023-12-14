Return-Path: <netdev+bounces-57616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0E813A20
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25B2281105
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859D67E98;
	Thu, 14 Dec 2023 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH1sS501"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF812E;
	Thu, 14 Dec 2023 10:38:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28b1478d85bso139357a91.1;
        Thu, 14 Dec 2023 10:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702579135; x=1703183935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X7uWNqlxwqbQKM6FKhrS5+tfGwh+5J0gJer6lChqM0=;
        b=gH1sS501lwZr/45CaEoaqaztynEtE2aSHDdam1r16lmlTfWaUQ3fxnDRs31rchggbB
         hGqmtIDXGmcGyEnS733eSZVPRP726SnkoKFSISm7f9lV1was1ffwtJ8I4r4Dhp9dBIbu
         n+14gY1yiqFGReDhenIBU4o3d7B/wJ+HDoLLkaUgpUSIJhCMDWVD0AN2/pj9vUuL8hfz
         /KUlivCmNHZUw+lBQqWFyxIeQpQLpqmlQGmLywiJqyXMNj7XOca8uX2CHAcXpxrZyqoK
         tCk7caV5Zx1YfInbc/nxCfzoL83tOVtZ/5JMuFep/vDVfmxkExHH5Igx3G5+6FHTyLey
         NXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579135; x=1703183935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X7uWNqlxwqbQKM6FKhrS5+tfGwh+5J0gJer6lChqM0=;
        b=SzBCcEcAw5Qa1/OGxcsDZb2W2kEXn4RzoFS9nAei+uBdm1ItvZbj/JItzmBCiNIHUQ
         sDRNqdbvrzxEnRWetVKm+9bGbQ6lvzwj9DQ2rq5DVj8NNURwdM/on58gzHZWKTIMQtpe
         X2ZsxeYZLgrcaJ3+p4p6vt6tECmp5euhYDZf13jVUI/UXjtWhzLth8TxZ8AW1Rs1vjgJ
         HM42DBEx6QnotqM3WqRGxMse0wI6b9kRB4FwwHZz+PYQL0ZtMrKjJ8u2Z9FcbQp70Qw9
         q06WLrnJeKR3VymqbxtyUXiYbHAvZLTWcGqpx/xF6xonm05Keo6yX28OMlfSEG19oZcw
         EwfA==
X-Gm-Message-State: AOJu0Yy+kDH1Dv3WC5v4TU5fVyMoU7AXT6DEpayVUYLmCealJ+OFwaVr
	5+KoPXWuTs89AVv6yYSS6mQCEJKAo2M=
X-Google-Smtp-Source: AGHT+IFSsy4P4c8y6whboiS3F9iPMF0wrPhd0MQrSwG/2L1OU/H7d9W7APjOihc2oUWYwAyWuSPTRg==
X-Received: by 2002:a17:90a:88f:b0:28a:e25d:a9da with SMTP id v15-20020a17090a088f00b0028ae25da9damr5564204pjc.3.1702579134938;
        Thu, 14 Dec 2023 10:38:54 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gb21-20020a17090b061500b0028aeb7839a5sm3439330pjb.47.2023.12.14.10.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:38:54 -0800 (PST)
Date: Thu, 14 Dec 2023 10:38:52 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <lnimi@hotmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v3 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZXtLvOfS0uYxESQm@hoboy.vegasvil.org>
References: <PH7PR03MB706431C1C25954AD76134FD8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB706431C1C25954AD76134FD8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, Dec 14, 2023 at 11:36:24AM -0500, Min Li wrote:
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index da700999c..66f4dd73a 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -32,6 +32,7 @@
>  #define PTP_RISING_EDGE    (1<<1)
>  #define PTP_FALLING_EDGE   (1<<2)
>  #define PTP_STRICT_FLAGS   (1<<3)
> +#define PTP_EXT_OFFSET     (1<<4)

This isn't going to work.

If user space enables time stamps twice, once with PTP_EXT_OFFSET and
once without, it won't be able to differentiate the two when it reads
a ptp_extts_event.

Thanks,
Richard

