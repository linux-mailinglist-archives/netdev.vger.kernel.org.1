Return-Path: <netdev+bounces-184838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673ACA976AE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EAD17A8E2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B0298994;
	Tue, 22 Apr 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B8vR8mGX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD81DEFE0
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353143; cv=none; b=IlzV0meDyorMEAX/+tab3/7n0nr9x0iCWLl8F/2JuTMwL3Hs7IEhIPjkx5nHdBzCJsQrEzeYDVibBFYzZt3bSwg06FjFAiyg5fq44Cm/R3NMwdblHq4UKfXUoy3WFjrYhtmMQCWNLsMeH4fDQ8CAqBQqjJNR0p9WfZ7jSy2lEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353143; c=relaxed/simple;
	bh=idXdvxc548cmcGUY+7fxHntywwpdMns5AGSR76rGB/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag5jLbQoF0paaPOixKhY+FkOTX94gibIdnf1PlrWrbrprXC/Jpaq6jcwgVLdCeJe7mk2jh5kVTYQ9QVH07dfIh17dEo2YeAR03QWmOOv8m33vSZke1xCCD/+KGPiFMwj71JgNnIPLt1SL+ioNdEs8qTKzVzJE97BtGvaZZAwGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B8vR8mGX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227cf12df27so2818455ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745353141; x=1745957941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlVdV1YlZfrtkMqtQXHNBZSHY/DkoheWkjaRUvA1EvY=;
        b=B8vR8mGXk/LCHnkLnwS/UEYwOVnKQssvMfvhIG6LyIlcDNnnQVIWAJEyzGAelLW3wS
         3P+cOa3cy0I/aXNV+vDDXQJGdJsF6Dfk+rW618g+oeByZ6SJMjY/zUF8OYPfPtj2GXi7
         M0pX6NtuRLLRZ7YtBAoqlJoE2W4JVvUgdex0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745353141; x=1745957941;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlVdV1YlZfrtkMqtQXHNBZSHY/DkoheWkjaRUvA1EvY=;
        b=T8zLWizaoNBBuSYjE0ObZbGWGhYcQtDmZREzKz8aG/g+r1usHezcywOsJciUIkNSOC
         B9421moeqVZjP6jMvRKilLeNOsALOutDtQjIuVZxTG2HK57N7HCfohKADVBDediCl6Rr
         q+WIKlGkw0//OHgGv6mwDpLTBZkm9elWPhd7/ikJEisWEiuUml8rXALpRE2TrVAmb47U
         auWTBLAeBI8DEImohgxUJVaimBpBCBXDg/4xbaABZvv/W11jFOCyblQMKIYX/hL5Aoqf
         2SVERkxtYhDx06ZJSJQHlsZepLu0Z1pyhVcaJrGR6uE2GEds24zcwt+Wz3pGhRNSPY17
         qwDA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSeOotR9MrXVF7F5wY4wsfb1icPGC/YUoD/tjYubY9OASlf80XkAMLNRPfLiFju05I00qGv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRy8EevcjkJEF6F2r4qfoAxJ+vWDzmMZMnZM57yaL3XfuB3UDR
	szyIkx8XGWTqZ/w1/f6HIoe1Q5YviOUmVvgejGMNKYOggWcnWyr24DXVpqx9mIuWc5D/oWtFgZW
	V
X-Gm-Gg: ASbGncsVXg2xdu+5NZ+1EMF7dVLQBUtOTjwEQHJd9QHnw6XKjRrxyb0Z2aEXMSns1Z3
	6G/eT1Sn3WLCnq4xZF38kY7VDqObQPmQpxoZWsWXNHf+b4zlLTwZM8szCKmBLGJ/YNPkqrTkivd
	Wfy+pWoA8vpYF07dzz9tbUG3wiLrFy+EAnYdsbJTh9hLQbdbqZU9jecwRm1OhrsyKuT0nsIU8FJ
	+cFko/Ld+AhyFJdlX25mp/d7Ve4RP3hN+9AEfrDtiHi3d/y/taCB60Nq8SILllEXJEz+CoW6hmc
	2xfVxEpnyjhoV1bRLMV1yjl16gWZo3oskJk8hM5BxDt7Mv2yyKQIFYoSl/2+I3Kd2Tglb8oDrKs
	ngGiW67yzcM5Rlnwg9r2IZi0=
X-Google-Smtp-Source: AGHT+IGkk8GEXTiyk2osYDKOaiFWILDzYKHoATRwnmCj/s6J7bv5rHUipNSPZ27QqXwQFd3xi+z2Lw==
X-Received: by 2002:a17:902:fc4b:b0:21f:7078:4074 with SMTP id d9443c01a7336-22da31974c3mr4347715ad.7.1745353140737;
        Tue, 22 Apr 2025 13:19:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4483sm89802715ad.118.2025.04.22.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:19:00 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:18:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 14/22] eth: bnxt: always set the queue mgmt ops
Message-ID: <aAf5scux38EGRaHr@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
	asml.silence@gmail.com, ap420073@gmail.com, dtatulea@nvidia.com,
	michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-15-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-15-kuba@kernel.org>

On Mon, Apr 21, 2025 at 03:28:19PM -0700, Jakub Kicinski wrote:
> Core provides a centralized callback for validating per-queue settings
> but the callback is part of the queue management ops. Having the ops
> conditionally set complicates the parts of the driver which could
> otherwise lean on the core to feel it the correct settings.
                       feed ?   ^^^^

Otherwise, I think I like Stanislav's suggestion on code
structure/flow.

