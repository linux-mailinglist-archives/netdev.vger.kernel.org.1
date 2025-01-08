Return-Path: <netdev+bounces-156375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1410A06344
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B860816134E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65E20010B;
	Wed,  8 Jan 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UfOOqQEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642741FFC7B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357057; cv=none; b=BbpGMWyfz1mrNrQiIhpHV1BoTC+Xjwv7aDBjoRdWC6bOazZGDWTXWnQ8RRL6TPbwIEAoOPi8b/CVqlp7Nq/d8uR5QQEiqBewcCJSRQSIZVrKNiEzALXQ4EvDaM/Zy4hDnxzL/kcA4elzgcYpUB3QLM7DW+F4XSdpz4i0sJqmtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357057; c=relaxed/simple;
	bh=Hky0O+HooNHTwNG55Ps4LhGb1RK5fKkOSgaeUS7w7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqbgTxbdPskbFlwLiAQ8RZBUkkklYyngixpGVn/MW+K0zZZvddotvpuccgVi9dUMAnSVxwFXRTDeVjNV96elIBfhfJjFwtrb/150mYMDmRERIRfx6N6ORy2t8TXfWPIJJDzpK+we4luv52qYnHyDbP5TDHpD8Xb5k68y2oaVekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UfOOqQEU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21680814d42so215585555ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736357054; x=1736961854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONCg2OSf3VH3eMW5fDuexZj0M7g/dt03y2eyy26nduI=;
        b=UfOOqQEUnngRCPGSL1QXiz3gAhBID9aYXUr2/5Ap/L+8HiYfPyg0/JjcNMb80kS2ED
         OsXFNs/BiJYqI1368IvakesfsuTCCkbzMaUQ+/SsPgkbnYKNsvfkU1t2HHoaS5tAqTo+
         WsOYORJR+O4FZa+4Xr7lSDRgQG1R4FQvVXhqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357054; x=1736961854;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONCg2OSf3VH3eMW5fDuexZj0M7g/dt03y2eyy26nduI=;
        b=ZkRbnzw5c8yxeWbHo2ouB6wTjlBhEvD4sBLOqiQPZmQKaCzB2IDKxX4gRs1tk0B6o/
         Xxzh+8MX1kX6jhRvi/XntbSQ7VdDn6qVlJ2SIzJm/doYM/u4LWVFeQDoxfq0fHid4RF0
         VOrI1D2rg3ggI6vYvE/7VfJ/3op+hLDWVzPBErb8AfXVXAaU/nGtFQvgcqPLOeEgpD3u
         nF7A/fHNiq0ueRhB3X0I7ko3MFgz31WBC5wUIlz5Bmh8g7mkRe9VLtlHZOX1ie82QgXo
         sEkKj45I0LGIB276JzWNQd5yZk0h5sh9KHt0bWeDDwO3PGsBuNJdJT9JNx+Ked+ZfDXn
         FyJg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7G2T2EoviKAwPMmiurFdi0CJlDk+agkQyjs4JzXfqAqcQrOMyRV8eSe15lZQfmaMc7xKRw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzESESDM8mPLaLDYP/fHJup16GkSi+xDYtAqf6SP3w6kjHVYVya
	74IG83BHDGpv3OWYspUUKoYNusqZugoY2kfoiDf8JWoMSMEYRlOk6Lf3/yt4fxU=
X-Gm-Gg: ASbGncuZdrGn/+ACn61RWJ8eVmKVt/9t9XfRc9RR7Qdj6bpscM18Lz5w5rVRo79exIj
	c+K3wTzFBDcDLLVWLqLS0R96sNkEm7CDU26Rx6X25rA6B7IJkzeuFPnoWRa9lByykXVJ6qWNM2n
	MfyPoT+f07rYiVk8TZqdW+NbxJbhTJjHsG/4ciFSqJSTP1ACT7nC6sCfLhF+z62wWpNMNRNobut
	eKBen1Xjpeli8hcHSendfFxoFcLa4S4GTpP/g05wTLc7Dekhw2eSAtuB7/ca8zi4spGuA+Rn0wg
	qqwCXdcG+lImCCGUeTmyZec=
X-Google-Smtp-Source: AGHT+IFCU8nJXsp5a/nfECEtTqResZUxZXH3i0XAaYZEqyChLxSRwnXdmtEOu0lPXK5raQdTHTv/SA==
X-Received: by 2002:a17:902:d511:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-21a83f69cd4mr56438315ad.32.1736357053731;
        Wed, 08 Jan 2025 09:24:13 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5195sm327911915ad.194.2025.01.08.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:24:13 -0800 (PST)
Date: Wed, 8 Jan 2025 09:24:10 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, stable@vger.kernel.org, almasrymina@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from
 another namespace
Message-ID: <Z360uoTfHrl5VwSB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	stable@vger.kernel.org, almasrymina@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com
References: <20250106180137.1861472-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106180137.1861472-1-kuba@kernel.org>

On Mon, Jan 06, 2025 at 10:01:36AM -0800, Jakub Kicinski wrote:
> The NAPI IDs were not fully exposed to user space prior to the netlink
> API, so they were never namespaced. The netlink API must ensure that
> at the very least NAPI instance belongs to the same netns as the owner
> of the genl sock.
> 
> napi_by_id() can become static now, but it needs to move because of
> dev_get_by_napi_id().
> 
> Cc: stable@vger.kernel.org
> Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Splitting this into fix per-version is a bit tricky, because we need
> to replace the napi_by_id() helper with a better one. I'll send the
> stable versions manually.
> 
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: amritha.nambiar@intel.com
> CC: sridhar.samudrala@intel.com
> ---
>  net/core/dev.c         | 43 +++++++++++++++++++++++++++++-------------
>  net/core/dev.h         |  3 ++-
>  net/core/netdev-genl.c |  6 ++----
>  3 files changed, 34 insertions(+), 18 deletions(-)

Thanks.

Reviewed-by: Joe Damato <jdamato@fastly.com>

