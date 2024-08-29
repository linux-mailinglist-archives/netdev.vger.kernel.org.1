Return-Path: <netdev+bounces-123214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497F96424E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F88B1F22D67
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818FD190499;
	Thu, 29 Aug 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2D/JBv4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24218CBF8
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928789; cv=none; b=ax9A9MveWSRlf9PTaTeI+syaiTXl66RMTZEqSi84G4bzaewwlrWTl9pm60vKsMPcosQ51pJMPWOnonLRpdgESdtB4mFPKFvyvVGCpK4pM0KctHWR1JAD2CXbjfE4OJQUxCG5Kz5Tr9r/K14QxJMHPdum26/WsBiQEvRzkqBtoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928789; c=relaxed/simple;
	bh=vYsSRcffFINc/Z5uf1RRpgskM6ELOon13wb4ULaXsb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tij7NFlIwceNLbGWfyrlfQrHvzSyHbtOaiQSsMjMEnNMUnG/IgKQCLrvgmSfoHdJdWJO//QapHR5q80GqDku+I3/wDLrsxSG6hIp7UwqNPtVmUEtD9C6RywvaHFYwqL4W6owEi5+utNtAfqjybT2gsvKhba0O6jj+jRxmrfK49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2D/JBv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/8wOthdbHWlH+BLKtl0TRATt6SB1NZ6dUt6Jn4HyYQ=;
	b=S2D/JBv4n7QfCr484SzN+Vt3tWSBOln4Di0CN/nZEfSOs2sgUjHYDGgHU3UHYfiRKc/mvo
	Bits58bSQ/gCzOP3vWCO3UAA+SqdrNDffXEppJpwAFSsIBJXuFIYzKixzEKHZwhGbYrxdZ
	zLH1HauBcxtfvKT3VjCTwyExz7fP5Io=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-e1uyYpYDMry0fFUizYjM4g-1; Thu, 29 Aug 2024 06:53:03 -0400
X-MC-Unique: e1uyYpYDMry0fFUizYjM4g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3717ddcae71so403936f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928782; x=1725533582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/8wOthdbHWlH+BLKtl0TRATt6SB1NZ6dUt6Jn4HyYQ=;
        b=a5MgrAXzkXngfUAuJ+tYISSd2DTvyg4IlnRUUW8e5FPsWioGvOww9LmXmZ4fMpWsKZ
         4OpJ4nwElS93DZ0R9PVP2dWZjmMu6QRoJlr6nEyTV8wffRS6L8UoWfLewEW7Hjzq/d1h
         PD+5pidTpuUp8iFu0flS6KwCnpH/KWyye2FAyKUsel/BIprJGoP8h+JzILtS2s/SGhnA
         2A+6vFABYjq1JlzNTq1bzPZ/PCeAHYiQHeWfbamtgnFGEfPl+mhfxqNJ4ANKM0qzrKrO
         PgRSGELZOxlSeeYg2P+tJkt0aHz/IjImtALRM7Q4CAmUYIfcjRmtOBs8FYPj/8lsplUj
         eflA==
X-Gm-Message-State: AOJu0YyL5ughEN7BZRLH0AZkh9RFImmm2mBHErXeBfidKZfhkP1A4pxd
	6d/4PCgjZMJe0nwHoQyK+AJ6KW4NM8XYeFUdEK3nqC6+ykIvw4JDNc53fuxdNYUh7nbbtMKl1LG
	4TEomSsLpM81kZTypzp42eZ5Y9Vo6ZaZGt8t/X39S03EQJYtLV9KVqw==
X-Received: by 2002:adf:a416:0:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3749b5477cbmr1721315f8f.15.1724928782049;
        Thu, 29 Aug 2024 03:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCvmcLU9oPm9tTU/f+g5J+P2MF1yPV0hunP9kHsqhBqcIuXvYhwnSfDFdmDI67biubGwmkXQ==
X-Received: by 2002:adf:a416:0:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3749b5477cbmr1721280f8f.15.1724928781168;
        Thu, 29 Aug 2024 03:53:01 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273e3sm13202495e9.30.2024.08.29.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:53:00 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:52:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/12] xfrm: Unmask upper DSCP bits in
 xfrm_get_tos()
Message-ID: <ZtBTCjRP9M5qo7iz@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-8-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:54AM +0300, Ido Schimmel wrote:
> The function returns a value that is used to initialize 'flowi4_tos'
> before being passed to the FIB lookup API in the following call chain:
> 
> xfrm_bundle_create()
> 	tos = xfrm_get_tos(fl, family)
> 	xfrm_dst_lookup(..., tos, ...)
> 		__xfrm_dst_lookup(..., tos, ...)
> 			xfrm4_dst_lookup(..., tos, ...)
> 				__xfrm4_dst_lookup(..., tos, ...)
> 					fl4->flowi4_tos = tos
> 					__ip_route_output_key(net, fl4)
> 
> Unmask the upper DSCP bits so that in the future the output route lookup
> could be performed according to the full DSCP value.
> 
> Remove IPTOS_RT_MASK since it is no longer used.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


