Return-Path: <netdev+bounces-159648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B3A163B1
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 20:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EFC1884B2C
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0105187872;
	Sun, 19 Jan 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDsKrJPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387117FAC2
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737314161; cv=none; b=JB1Ioxrh7GKhVsH8PBhpJDF/0P57abJWsiizL08DaCVcmbe/Lel1ADNRjDUNQN8F1+VTg4FKgcIm5JVu/gGoRXO9sU/lXIX1wk/S/qRH+3vwoiPGfJ2Ss5NrKTbM6MvYrrhNN1SUjqbtlntabSoMR51uh5DVfQL7OohPDERvADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737314161; c=relaxed/simple;
	bh=E3ry4DmHRcitmerXMu46zMQ8d9gctMovbiA3qqo4E4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkYXABkYc4wbbBelZXnGIHsxM5ZDsLr8ZKfy5uf7qXlnar3L2qL8XJ0nb2pcLAI3eeuVwRL7NDlzzZpCBy1d+Dnsuo7CoLzM/U1ByVUPGMiCx68tRW518SQC7zlTUe2aXRIasH/lJXrsZX1cJmtqiK724JTyKZdpl1xnTLqeRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDsKrJPo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso57721095ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737314159; x=1737918959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf7s/VP+D7jQwlZLxsOUaYdtv411NwxiUFhPm4fKZ4k=;
        b=lDsKrJPoQf3PiZkEN9EPXBa7K8G5ZSLE2LvZg38mn/n6TEZXVtHBQkJpkBaoB1CtAY
         IIL/uAkX/hGZ8XocRHqb7aIH0QglEjkyFlsFjtko6kbmidhjxjes8nTMtlNflFj5SaXE
         LLcaADpvrgkHFGIxg9emtNNHMAJdYX6mY04omJwe8KD8cjevDZHVPxL0DskQs+VfsW8Y
         iWQuFohJGyUn6446Vn4g/hxWzmSbnKxXNUvtCZ1L9qkUnTUVLX7C3IFnl+QF0Z/922as
         hAcockDMxsv5MrV+SVy5wIS7TTmBOievBX/Xa1i4AmOQp151gPuZj9rMf3GTNWNjgSaq
         rFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737314159; x=1737918959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf7s/VP+D7jQwlZLxsOUaYdtv411NwxiUFhPm4fKZ4k=;
        b=CjBrHMaVAJvilMxSdw4TpHeE3GNYdwCnnZXozFr6Ma9wbx6JCyqv22TTjLi0C9aGCU
         Cu+8XQHGgwy9HqdmAmn2Pqqmk01pA8mF98N34j3JmxiI6suGP0gf41T/5AQwVkSGuRGr
         bVxUVlVZwjecUHuMxwnAKnnVYz81uP1cLUrMiOCaMpMm4Eyf7HqTQ8vYCpvxjSv6fqpI
         XJmAwBEKePcCYsKFYlRZdK6bnYKQikzVrsZGQGmJLRvUHT0kPQllM9bM8Udj3Hp84NYG
         Tzg+/BMc2VvA6uPwGmeRvmr+zRVxtvsJx1VZt1I3QLQQ7FjtymIGIqbmtQf7HxOmbCiT
         Pj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCr0xT87MnXe1zWiINJetlK+3Ue61HBuyqTCmdZMNzr6b5zqyQynkw1IHd0iSf2YYtrfcKRB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvDOTh8DRGxHnOOvp5pg4HB/I32ydY5X4V7tu/MdXDDmHbuNJ
	W0LCSs3gukS0L1YwvUiM5aCkzVLP/5FRlQcaq2g3MKXwoGLsBRdL
X-Gm-Gg: ASbGncuoE5WJ/Tf9cV3Aeez4dhFmqE5zapHZnVMxq8RS1IYF0fq+wy/KhurZwC/w1Fk
	3nCCCLtKFYvMSn2HHMh9ZgcgjMpcEvGkj1866ksfCmztBWFBjos8Sh+uD38mkx82+aGPbtagWBb
	PtBo1DEa88o83XlqmaBonAE+HKi+LnawMlmpWRslIzfEbepJLdsUzsoL383refgcitd6n7tuzcs
	RW22jKriHHZzWsNWMmSImNonrlrc7g0dF+LTDiezX5EimXNiSPdx/697zrhWfbeHtPupXV7Qerw
	3mObB+bJ4b7wmg==
X-Google-Smtp-Source: AGHT+IEjNa3qWujCxoJtrrKKtoZQ+NhR3sWjdFtBYW0/Zbzy/u+NEZAPJ/PsouHzEyRdoJHSzvqruA==
X-Received: by 2002:a17:902:d2cb:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-21c355c4384mr159580935ad.32.1737314159405;
        Sun, 19 Jan 2025 11:15:59 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a908asm47186375ad.150.2025.01.19.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 11:15:58 -0800 (PST)
Date: Sun, 19 Jan 2025 11:15:56 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z41PbIkIrfE4xn9K@hoboy.vegasvil.org>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117062051.2257073-5-jiawenwu@trustnetic.com>

On Fri, Jan 17, 2025 at 02:20:51PM +0800, Jiawen Wu wrote:
> +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> +				 struct ptp_clock_request *rq, int on)
> +{

...

> +	if (rq->perout.period.sec != 1 || rq->perout.period.nsec) {
> +		wx_err(wx, "Only 1pps is supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rq->perout.flags & PTP_PEROUT_DUTY_CYCLE) {
> +		struct timespec64 ts_on;
> +
> +		ts_on.tv_sec = rq->perout.on.sec;
> +		ts_on.tv_nsec = rq->perout.on.nsec;
> +		wx->pps_width = timespec64_to_ns(&ts_on);
> +	} else {
> +		wx->pps_width = 120000000;
> +	}

This looks fine to me now.

Thanks,
Richard

