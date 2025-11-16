Return-Path: <netdev+bounces-238959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85381C61A08
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238883B1BC4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBC1E1DE9;
	Sun, 16 Nov 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf5EFD8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85445273D75
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763316018; cv=none; b=ghGGLNb4mwO/cjd0konfYRa9lg0otcfFrDsF93kIA7FMsdMLI3Xxa6ccyclcJOwPTrcP+dc8o/h9lmc72tCm7g7O2lIBZq9hVwEJltDrMv2RwFyM7Oa9Jj70LXCEXU8o456pKCj6LTt0a3bRR+WYZCPVIMleIumjtUAq9CwuvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763316018; c=relaxed/simple;
	bh=4bNQSFj5hf/jGkPpYOhkJolC7Cjx+446q/N2hDsuwx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJGfiQEYsfstE19iotXOxGaK3ffYoawQALhfFfde6eyNd+7cdEMu2TdB53Ye+eWJRLoHKpckCI2z83UWLLETQbhH1GUUntgUHgDNGdmItIeS78Tjs0enewZBkqQGIF2eo045yN6IDQUovq/2waNQeDN3ZXTBohS9XVJJlJbKuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf5EFD8M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298456bb53aso39838265ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763316016; x=1763920816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeuJmAB9iGCoM9KFNRE0tBxG/2yQDs+Ahoor7rwDQqY=;
        b=Xf5EFD8MJ7Oi0ZN1EDagaqUoCte7qGiAaOsge5sQDH+jNUoOEdK2lq8uBO7Zub8DEP
         faAPTm20yVYgbZLctxFExtG58bh0fsv2oHnDnZbhhUjinCa8HdC/2YHgjOl6ubhqKJAH
         UsHaXbqz6xKu6PB/YuzXuPPXlva+s70EP6jFD6RKT5If8x3VVz8UcBvJfCnUEO6WqN/F
         bS8fngbxHCXAc/F8WBSSW/OKl7smeK/2nWvOHqHU8ccQt8EHnMtaJV/sfjdosyCOwWMS
         l7xHQDm5oRPYUt+/2n6H4fDlEC+uG8zBO809btnUrKshdADscY3jmJiinvFLOsnc4MGM
         14DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763316016; x=1763920816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeuJmAB9iGCoM9KFNRE0tBxG/2yQDs+Ahoor7rwDQqY=;
        b=cb0O1+auskgZ9gYiUotK1v1eZtKuILBQHQMRauPgAz6NtetI2s6WI9py+t2p/GU8lj
         mVWvyB+Vb5hdMNtyYD9DeSpNeF5PWg4KLF7DowoWLMQWfDoygokpWqF1lrfFyjyiyqmz
         H7qZLpqD9aJi0kFSXFsbx5u0ayAAXoJspAif55+MiAuFah2mviUAqhPoSykjHeQZvyLp
         xoY/TFcG/fQc1LN7mFqKj08qbNGHbF/x1ep2yNIroi72LAsjO9QZfi74q8ITn0uUlGPP
         lQueIQTO37/YfXkDiEMc5HG+iR0voGd7i+PrR1ROxAZ22Z6ewmgPIcYmZ28BF5wzPVZt
         OvCA==
X-Forwarded-Encrypted: i=1; AJvYcCU+i4j86lLABy2FQ1A1FdOW/OYQPWVd1zNbRklAdI7cEWqEJgIgXQmXCNSQirBsnDCjqs2CfsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziHyiCIwTOtxrN6VDaVTSvvkjvVdY4ts/ini13VtWcHvRFa9Hr
	nm4oWTSZpScMAOhRwlXfcivT9GspVq52Rsf6uOpRwhYcILoYQnymAOvh
X-Gm-Gg: ASbGncsTgl/pZQ5EpwqiwMgQ2waei0LOygZHk1U0tZYWzJtRV9KxfuiZpxV7Er3GgWK
	TdDX9IoKGGBJi+KXUOMUi74dumu9DKeheEg2khbxhXaWTNWAY0aB6U0EGtIqy8Fk+aAay5tXW/L
	TcRza2C/4sq0LrRZH2ac/l6gQun7Qmh4ht1JNKfkUyrOfinWiFUHmLwaub1on9O9j9rKEyf75W5
	4KkQZxFFabThQGsoylcTvXjBmgeOM1Ug5JbrBEam/nfXwH1Qwsg4eASov2wjfHKN458fwGAQoXM
	RHt7MEzZl8LMBgZBtpVe94qk1+VmcL+XiNNhy3xWHk5hcWI9d4sMbUTsD7A0ux79ApPZeLpTFBo
	ID0z2agvLeZ56bYea+nSm2DecL3nQxURsiMNxox9SK0S4WGvm7lDoqaxLGoeVG6yM0U/ViVNb1x
	cR3JuWh6VFYbOTRCP7tNSLtikxxWnF3j5/EZ4=
X-Google-Smtp-Source: AGHT+IH8JlO8h75rEDYJ9Ee4B0RDae6Ov5UJRiX2QDIhpbgy7/yAB5+6i5vuGlFYH4yP8lhUXTQNug==
X-Received: by 2002:a17:902:f64b:b0:295:5668:2f2e with SMTP id d9443c01a7336-2986a74186bmr118803845ad.37.1763316015605;
        Sun, 16 Nov 2025 10:00:15 -0800 (PST)
Received: from google.com ([2402:7500:499:ceaa:49c7:4719:2441:afea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eac7fc34sm6838527a91.1.2025.11.16.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 10:00:15 -0800 (PST)
Date: Mon, 17 Nov 2025 02:00:10 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 0/2] rbree: inline rb_first() and rb_last()
Message-ID: <aRoRKp4yDGOsZ4o0@google.com>
References: <20251114140646.3817319-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114140646.3817319-1-edumazet@google.com>

Hi Eric,

On Fri, Nov 14, 2025 at 02:06:44PM +0000, Eric Dumazet wrote:
> Inline these two small helpers, heavily used in TCP and FQ packet scheduler,
> and in many other places.
> 
> This reduces kernel text size, and brings an 1.5 % improvement on network
> TCP stress test.

Thanks for the patch!

Just out of curiosity, do you think rb_first() and rb_last() would be
worth marking with __always_inline?

Regardless, for the series:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
> 
> Eric Dumazet (2):
>   rbtree: inline rb_first()
>   rbtree: inline rb_last()
> 
>  include/linux/rbtree.h | 32 ++++++++++++++++++++++++++++++--
>  lib/rbtree.c           | 29 -----------------------------
>  2 files changed, 30 insertions(+), 31 deletions(-)
> 
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 
> 

