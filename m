Return-Path: <netdev+bounces-122394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583C960F19
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE14EB2646E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E351C68A7;
	Tue, 27 Aug 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdCJFUVd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F371C6F68
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770494; cv=none; b=uEe3oH0gtAsXRX8d97zm8agaaoK2EgdNnAIJKIAGIM66/xOjO18wyNaBK0AzWIQAxSyPlKlVUTNVuv5oRzlZtm7WzGPhboLPjgkeH4o5qLtO8i/if2KvsD+OMTrGA9Wo1USDjo/Ygg8qPe3cw4V0jsujx4UFYFhRQKJl6G+2Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770494; c=relaxed/simple;
	bh=E7OLqoz0tREOK7wQ3vh1lxy8eEnqLJ7OjeCXcBco4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHPTdjebg20TRvmK8ZH8/EqE697kALK0z8cH+Pzh+JINhW1fiIBtv6disoDdjoKeihFiJsoUhI7exCoIK3zGSaAu1P3vUYc5ZteHdRPgggvuxOnHJqjjUaeiOsw0iZ1z3lapPqXw3Kp/d6EF0kdtbb13xDjGRTbL4WPcQw36UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdCJFUVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724770492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s25MpL7Tq/TPGjv/St//pk5+Hzc8PYbV3QYbpZXoEM0=;
	b=WdCJFUVdQoc0Y7lwn5H8QSMX/Dxm7QJJaZnTfv9AUKuHhLSpSdANC/D8C6n3wNGLhQwaQJ
	q8HoK/qAHe3INflXZNt/+QiKDsjVXgFI0lmhCzckZBiDjDpB2a7gS5jVTek+Rxdpmk+oUf
	9X+0CQbc2rZMvwLCLu0N/vVgW5IfZPY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-8yXEDHkrO_GX0i2wdLsPdQ-1; Tue, 27 Aug 2024 10:54:50 -0400
X-MC-Unique: 8yXEDHkrO_GX0i2wdLsPdQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bed91ffb50so4625699a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770489; x=1725375289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s25MpL7Tq/TPGjv/St//pk5+Hzc8PYbV3QYbpZXoEM0=;
        b=XnOD2/y+zJUIq8bt03zVfG26A0nNmWWylZZDISyDtn0xOh0pGK64y0AHmmthuh4n6L
         svhtGvVqdjzeKIyB342J+fhUhSJaxIBrh6uxrQVg9XYeZoxqtOMFEs1Ocu2SLlStuY6H
         QVRf2QRID1SZTLQz31qMS9WWyRSfoPDQFqu5jl+k/6h1DNPAM2qsno03/Sk7wfgtWY7K
         P8m3mSKrFfxqwbzg/i1U+xQEE5KspelNl7WncJIXw/7thB4FDvoO3zvY4ge75DTFkPnz
         VfGCGBEOw6xaZ9CsAYRYpyGhzcpcT1fFMFCDounAO8e5JiOt3TjYOY8TGr+Tl9qsyl6x
         Q2lw==
X-Gm-Message-State: AOJu0YxDIa5LQTYEe1Kk2g8BUCRXzRFSnVy/4nthQGCPfkb5LgGr4fHF
	5qVXG1zoLq6FJVzK5LuTTAIfckUDw6FvVKkpxKFwBJB4S2aM2EI+tqHQmJ/9FUvec7xTROnrchu
	l2KRXelSinmgr2iv2LRbfLd8oIMtW9Ut632g1Q0p5qB4LVEfHhbX4zg==
X-Received: by 2002:a05:6402:26cc:b0:5be:fe37:41cb with SMTP id 4fb4d7f45d1cf-5c0891a92b1mr9267182a12.33.1724770489111;
        Tue, 27 Aug 2024 07:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIunvhNYLO3V6oMfMQBw21LFVlGYwz+wXbXvSTd7Qsz2VSiEu5iJyTRT2II+Wjdm4/C/wC9A==
X-Received: by 2002:a05:6402:26cc:b0:5be:fe37:41cb with SMTP id 4fb4d7f45d1cf-5c0891a92b1mr9267154a12.33.1724770488424;
        Tue, 27 Aug 2024 07:54:48 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb471d7bsm1102102a12.59.2024.08.27.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:54:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:54:45 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] xfrm: Unmask upper DSCP bits in
 xfrm_get_tos()
Message-ID: <Zs3otVHdeeyb3z1X@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-8-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:08PM +0300, Ido Schimmel wrote:
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

Reviewed-by: Guillaume Nault <gnault@redhat.com>


