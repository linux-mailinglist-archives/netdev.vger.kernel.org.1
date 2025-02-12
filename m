Return-Path: <netdev+bounces-165678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F77A32FD8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEED3A9E5E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBD1FF1CB;
	Wed, 12 Feb 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XG2Gk+9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECC1FF1B7
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388942; cv=none; b=mNH4DfZhAqoyrs8ttMf2H5BAxr9hrzuPjlQySW210yGwt26Y78oQYfY/xC8C9MZaY0G7Bnzgm6N9ANPd7ObQk5B5NIYda8Xx8MLR6qsSj8VlVAzaWP2K0MqLtjC8XdZ4xLoHgIHHwGHx7V5Xbf8EPXin5Jbif3IbxLDTqOpx2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388942; c=relaxed/simple;
	bh=vmAvWbsGdYNKRmni5mBBWvqq4sSKlumOWOmZ0JYXLzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0zXE5MFoTkBQgR/CaQ0sdoDzuW67B3uJVNJj7/GcOiLt1jd6yIEuQfZ83vL4yZNfE8EMR/92qMfRbA1Si+ALhGE4l8dYm0OlYkz381OOTzf13l0kilCEcVHFZghA8wvZmUL7edjTrWVIzhJ4GJax3TLrSvYLNr/kdN+dOTQ5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XG2Gk+9G; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f4af4f9ddso513605ad.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739388940; x=1739993740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gM8cfuxuqg3cm9VTQK30nhz59V/mbnlWePA/01igcE=;
        b=XG2Gk+9GoSkTYjSUzDPl+TKQmAoOdcpgWRmB3LUILlgocLW3+QjsDjAs16PBgwAQAi
         ONP1OBnGPRwgEal+YDj1ZfzhgkPc7JKAy+EPnZQ/qE/yaTHWHbi0wcq/fHH3Lj16NR3w
         WHgfYPkXJgEA20ng0vbQRvwNaxEp3fhuoBpZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388940; x=1739993740;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gM8cfuxuqg3cm9VTQK30nhz59V/mbnlWePA/01igcE=;
        b=VzqGi2DQ8yZl7Z+PTzyg4qOKMiYWJAHFKyNh7A04FdB0SmbMT9HPACTMMm0CQlM6ne
         GGfXPCzVMcknIpRPMaDcl2Wv08cRghQtBFnAbedH0BOYGDfvGqA5mMUJShKmChOCBz8E
         0fiGki9bi3474Re83Ln6KhLAcumHwjEDAJKdthNdwAjm/j0LjNCMTFUwvhAiM4p6H5LE
         ubYEIULGU0pHFWLArGdd6z06eZoKK5bUyNiw3ppOgKdTHIwrjf5HvWs5nm6w389hSHoh
         0eacVTC51g2agJo/sFld+BlOD6ATCv0uBvNLb2kNlKfIid1ZGS8iMRWT3bgDLbiNBp7+
         0eHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4nQhn4TAafByYyHivTccBbQRjBNuC6LDnTapj1xdqPJm9xqeTqloEGZKwJakE56MooY/tAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fPLHgk+p0QjHabE4V27Dl7Ft9zaD0lc8hkYFdcC8BLzQbSuw
	/EKZCRiYgMiRJyWJHI5FQzMHIvsRTXi5tYB2G70bVAGGDlS3P2wZ48wRV4ddyuo=
X-Gm-Gg: ASbGncvsuMyklEgWyrRq94q9i984gWiV5PcJol568cpb8sPDvg8TgOkg0b88gWGMG/U
	BRE3fuqu4hqprUWCXUCq0vPTbOFr3DwiUysmpHMyRsj9vVfqybJwJ0EvxCH787fKEHbKakSvZFR
	TmsrdC/WUilGERKrxDPMQdGY1Xw80GnJK2PoNL/bijR/MkxxxOFs+Wc4hLdeFz/YY6UO6zCynIZ
	kfkyMwVDOZt9sOgFEEKNlxmt9XfF9fiiFwoZlkhJR4Al19u7+hF+TMpj/nTaQQ9dfmsKJ3G1gzZ
	22gqewPlMdS7JJ6HcZbl7yTVsJcl7RcZ6W71FiYrTTAqM5LDKU9igDjcRA==
X-Google-Smtp-Source: AGHT+IEg+ioBMU+Ca/G1OAdLCJnP2ms61SibWzHwbJn0apwKLa2R4j3/nJXUxKb9+FoRp0a41HzDeg==
X-Received: by 2002:a17:902:ecd1:b0:215:9470:7e82 with SMTP id d9443c01a7336-220d1ea097emr9340915ad.4.1739388939724;
        Wed, 12 Feb 2025 11:35:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220cd96ae5asm3486845ad.247.2025.02.12.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:35:39 -0800 (PST)
Date: Wed, 12 Feb 2025 11:35:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net] s390/qeth: move netif_napi_add_tx() and
 napi_enable() from under BH
Message-ID: <Z6z4CMhLo0aj5YEN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250212163659.2287292-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212163659.2287292-1-wintera@linux.ibm.com>

On Wed, Feb 12, 2025 at 05:36:59PM +0100, Alexandra Winter wrote:
> Like other drivers qeth is calling local_bh_enable() after napi_schedule()
> to kick-start softirqs [0].
> Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
> mutex [1], move them out from under the BH protection. Same solution as in
> commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")
> 
> Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")

Hm, I wonder if the fixes should be for commit 413f0271f396 ("net:
protect NAPI enablement with netdev_lock()") instead ?

> Link: https://lore.kernel.org/netdev/20240612181900.4d9d18d0@kernel.org/ [0]
> Link: https://lore.kernel.org/netdev/20250115035319.559603-1-kuba@kernel.org/ [1]
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Other than the above, I briefly scanned the driver source and the
change seems reasonable.

I am not sure whether a different Fixes is needed or not (I'll leave
that to the maintainers to decide), but whether this is fine as is
or is re-posted with a new Fixes tag:

Acked-by: Joe Damato <jdamato@fastly.com>

