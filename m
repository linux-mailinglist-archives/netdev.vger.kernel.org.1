Return-Path: <netdev+bounces-235124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9FC2C582
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F31D3445B7
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6427F749;
	Mon,  3 Nov 2025 14:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018822FAFD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179173; cv=none; b=PKHDXWGFfctDoQTfxbirWC3DOttIS6djPrfr7O15KENaYBqLSeGi6i0cpLbtS9hsJ4sOCqC4K/ufX68G/uPwuwgWWBjEpQ7BJqxArPONnx0wLoRVTuzBNQuriHbJXAh849GNQJx13UGuw/W2d4Uhw4VFTmdHyDus4uJSm6cdRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179173; c=relaxed/simple;
	bh=258lH97XXGC28+Dowc301BofiuoERGUxThhiNcWo3Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN0+Xn+7ENDwoH9si88RlDN3tEyV6HBf54zz0fbMdM62EKh0e+iGk3nvZRsFe+/TSZ7TWN1zZ/NFU8168DWHEd9uCdjx7Q0msuP0Gqj1GeTYmcnZ6AwkeuRHyIRXwa+FUOT5G6s0pZGNCdg/OW4L34sk8lQOQ/57lwDR2MR7hME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so5279873a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 06:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179170; x=1762783970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV+XrmcKqNPHxmqSNaEdiGohivcDhtAS62RzzygEyEI=;
        b=ghVe6uMV36I0TyY4/l2SnbfxisiRs+YOwrrD7D8O27XmwEvNYLClVy7T/vHToSgNNR
         JDtfryEIZPVYA37AeKgp/YQtL7ALacpfHVkR4Ps5c6Rc4lOVsqDaRzIYyc4L703nle92
         Y1jd7NgyP0/Rm+EZQj8EnK+6Ov1HmoVj98ZnugVUieXAw5U1cw+NB+0hCOJMAm/uCU1X
         H6zhEC7XVSRdQyjr3nm/rMqpvfGlyYJKkLkdz2V6i4v/u0gZ49Zu7UWkNbfYUTDpqxnZ
         V5hxBG1Kw3T6/t/OK6zUsQsSiHpUUxTwGLr/234xFTlEaUQP6nnuWOfRWAZhUcRz/wvU
         JpCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT8gFoitIn7rJEYbI8Pog1SAQrTY/sqCXO0fVuHayEYO9kPS1noNcXF6FYhwuvlyQLX9m+qJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuCKpMK9KET3ILhscVhtKXIyfSBuFg98LbzjTXIoLtYmGlAMq
	u4B+u9JHNtTrOOggyeNMidCLc6M2YG9zZUBYKsxG4wl0ccUttTx+NBRg
X-Gm-Gg: ASbGncuWzeNSk2Qnj0xm/OGf2payWAaJ/oxWAigbTYC7IZ3NAAPmXOVKUXrjiHfzHiE
	DwP071yEFEuHtYUoOt424ntX8FGEGJbspfybyNK52D7pim8zyYSpuklVF6fiuJniohlY323C/o4
	2NFcQzIuhTMEKlGFWckrKMseNV1UhKUwq7sOYBXIsXSmbWo/SYgEHkTFOc7cGGRPpouJWxdP8GP
	uQHYkiHwkdoWXux3GGQaNx1y2SzIRGpKLduwRfOg2Rfyj0xX1PRgkaGLepsPQU0FTLlyRnH1LC5
	MYz7PJkyQJIAughbazMasyk+5rlCJ9omljfdlfDLO+mcjg8lg6rskzbIdizqhwbo1JEd1uyyWBb
	SHijNtkxtRWU9JWReBh6iw8O25YGBbp2dYnlJE7Kdtkkw+WtlrphNtZlcXaJgwJDZOX0=
X-Google-Smtp-Source: AGHT+IFWQEa+DoidWBa5kIJMKwLnZxsoTwKivdYX0YUChjS3vOZrQe3uWz6GQ2+eSv3jDr2kvuo3fg==
X-Received: by 2002:a05:6402:1ec5:b0:640:93b2:fd1e with SMTP id 4fb4d7f45d1cf-64093b2fe28mr7493506a12.17.1762179170035;
        Mon, 03 Nov 2025 06:12:50 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:46::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b42821bsm9761512a12.22.2025.11.03.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:12:49 -0800 (PST)
Date: Mon, 3 Nov 2025 06:12:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net v3] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <vrb6p4usfynhdlyf2u5frg57ppoc6umvg5we25cshlvudpvl5c@slq27s6cohbx>
References: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
 <20251016162323.176561bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016162323.176561bd@kernel.org>

On Thu, Oct 16, 2025 at 04:23:23PM -0700, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 09:37:50 -0700 Breno Leitao wrote:
> > +	while (1) {
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			goto unlock;
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> 
> No need for the lock here:
> 
> 	if (READ_ONCE(..) >= MAX_SKBS)
> 
> >  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> >  		if (!skb)
> > -			break;
> > +			return;
> >  
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			/* Discard if len got increased (TOCTOU) */
> > +			goto discard;
> 
> Not sure this is strictly needed, the number 32 (MAX_SKBS) was not
> chosen super scientifically anyway, doesn't matter if we go over a
> little. 

Agree. I will take this approach them, since it is not going to hurt at
all.

Thanks for the review,
--breno

