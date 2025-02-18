Return-Path: <netdev+bounces-167319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED92A39C00
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CD3A6B3C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE212405E2;
	Tue, 18 Feb 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDwoG/kR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AB23FC77
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880989; cv=none; b=PXLPD4zckI1LUC8YBXUg1t9KCaEWaWmA3l4Ao6GKWlGgVBvH3wbPETSsYqjPO6X48ZR8KZFiAKW0lAqA7hb7kgYHzb1gQiyNd+wXqdxqwH+/epjv1gM8mxtzfqOfUIkGBMKBeJ7RVoINpJrKwp4ViM5zvR2b/ZvQey9C+sDOu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880989; c=relaxed/simple;
	bh=PMvdr+ZfNDVAmEj0pphp6bpy76vM5UNBn+OgYvm5Eqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9fXMD2mH83dpSdNIy60PJcPjNlWZ2kgCpV1qgeOG+TnQRbBBzfQpK75X94nto+T0kl14IinT02CaiJU2YFW9x4y6Mszbdkk6iowKkNHznsgYyYG5z98TV5aliLyQQDD4iqkVzyXlwjAFKFVqQ4U9TfRZFMq+7+YT6UDeKWU7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDwoG/kR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739880986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ8Z/ts1X1WoAYHbEmugKRiLd46SJGRn9B00Nh0gRJo=;
	b=WDwoG/kR/1QGal1K5UT7tm/nkUe6SoAxWLB/q+hEL/HF9iAE4y8yGTWn7N4DjVP+Hzsiei
	nclLTJlk3iYbUIH4zoJof6vLMFRX+3+KukFiXExxxNISa/jo5Lep5WFv9gEddrw7cQcEiG
	V5gcsAhAfGOqHWb1ypWC3mXXAIDcncU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-AJ1Afcb-Nf2Uby8Gai8THg-1; Tue, 18 Feb 2025 07:16:25 -0500
X-MC-Unique: AJ1Afcb-Nf2Uby8Gai8THg-1
X-Mimecast-MFC-AGG-ID: AJ1Afcb-Nf2Uby8Gai8THg_1739880984
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c747c72so28475975e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880984; x=1740485784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ8Z/ts1X1WoAYHbEmugKRiLd46SJGRn9B00Nh0gRJo=;
        b=KD/3BISj0cXXjvOD5s52Y16dlKPxmsXZdvMtkoNH48jXORptqmH2P0FkOJoJI6n2pq
         IcYEg4LcmHcBwVOI7m6HpXgh+TK2Vvjua6e7Zxx+/b3xbO6bDxtKHxIfKiSACnBt3vQe
         26o7Rdrvl/2HjDnLxT7EKQNiyZ5bE3Zm+InfAeuJuJ3cJGakXq0+Z9gJZADvXrrZJbEb
         qU/s47z3tM+/hdckSl2xQESbrwJurBWJqwfFIiUPW1xDKtBjfx7baZofei/F5Z+hKnNg
         eCtVFN4Y9oqG2H1+q4NzWCstBVIV2mgh7p1vkXw4APu/4LloG6FFOs28CB/lkseDMZjr
         1nXg==
X-Gm-Message-State: AOJu0Yzfp9Ymy9m0XQHz2nmo4HoUMN66pHX4s1mJBRo4B7SzZmkq6CP5
	5VPKMCkVFEUkUGwYVrcmipTyo4FH9sqK/pfN16IoO+luh4X4SPL3stl630VkqGEZU7hiLJRV+L5
	cVAY4coaJVGRKdotK/7sU6Qgx92sS/sZ1KtHzMTmkiAMQ+2+Z6pfiDQ==
X-Gm-Gg: ASbGnctdTJYlsfA6H6yWRuIOwtaE0AjpFftjdz3/xo60jAGRIZHtSGpsAYVgiawiGFX
	HS4LV+2Nm0eikvqoRLJooGHM+S1XXHzEaW6ypCitQRYuoj7QNGAYxofuQpuwPtivKPlE6nWqGS5
	u4wxpVtqb1+t48Gvbh7KFh1EqSxHtUFbwaHNgBcxVZC9b2ur4O6tsdoRbMgnzcv03O2um0yJPRK
	JFibHbi8OqfJV1gtIpoLeylkuOdkzoGC8Eqqlo4KTdX91iYw/7cX/cN7JT51ZHzOXXw
X-Received: by 2002:a05:600c:1550:b0:439:9377:fa17 with SMTP id 5b1f17b1804b1-4399377fb82mr23541045e9.18.1739880984155;
        Tue, 18 Feb 2025 04:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFilLdpduDNHnvMwVANmVn9Y1oesjLxWglQt1gIkKaYpGGtImk80h95+MrESaOFKwflpYNmgw==
X-Received: by 2002:a05:600c:1550:b0:439:9377:fa17 with SMTP id 5b1f17b1804b1-4399377fb82mr23540755e9.18.1739880983769;
        Tue, 18 Feb 2025 04:16:23 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm49553785e9.3.2025.02.18.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:16:23 -0800 (PST)
Date: Tue, 18 Feb 2025 13:16:20 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 0/8] net: fib_rules: Add port mask support
Message-ID: <Z7R6FBKMM1i1nZk5@debian>
References: <20250217134109.311176-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>

On Mon, Feb 17, 2025 at 03:41:01PM +0200, Ido Schimmel wrote:
> This patchset extends FIB rules to match on layer 4 ports with an
> optional mask. The mask is not supported when matching on a range. A
> future patchset will add support for matching on the DSCP field with an
> optional mask.
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


