Return-Path: <netdev+bounces-158269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2499FA1146D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C076A3A1AA5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7A20AF65;
	Tue, 14 Jan 2025 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CVQHV8Ap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAA26AC3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895202; cv=none; b=kZYrRaXVJzF4m1oO+KMrN6eCppzhqz4It+hsCBvZNlujsaAO90+nHIdNMv1cBhyMpTxrM8BJ5AhexjEFolGq0FgU1pXabnPPuLauHrUnYzwJzvm5OnH3SswWvJRod5vp0FaJkNOAQT46K/k7FbTIHoVJZeEarmOTMUmpPqRbbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895202; c=relaxed/simple;
	bh=nC2lzTkaiS8jnhjRqAUtFTx+eA1hN+5/feL9URv6/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbM1ay4R4rYbr0YA4S0tFc8C6ddR12LLo8w5jQ7kl8PrqlBoXYf8WDyj0p5DPgIxoQ4ZJ8cmuKoEceFS/E4yHS/VwjYGf/SOLj9cu4L4ct5yQQ5PzBIH1CqrZG6yIT4zJF0Kl5nrv41OpY1OYOHNoTciuux9tmDNsE+xk8BYmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CVQHV8Ap; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166f1e589cso129834925ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736895200; x=1737500000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkmnhqpRVgeEZekTduS6Pd7OMvTbaMIXDs2y377MAVk=;
        b=CVQHV8ApQGrOuHxU8XMRFblf0RtDxXWV1m2zB6iOJU8MR2GhuHsK8tsW80m2cHXtdP
         CnG1d8QHUaz94SooxzcamABUsMYXPXsi3EmccirLZojRa1jbi9j5a7o/88G9wxRweYtL
         PHpEc9GL/MgmMZkP2N8RIYfwcPvkMeME8HS98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895200; x=1737500000;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkmnhqpRVgeEZekTduS6Pd7OMvTbaMIXDs2y377MAVk=;
        b=lEjaCHFqZskuTcfewoKCoy8ONiNgi0YLTF+eO9oDHLVeGBUp1grwwSHONkoAtYKwIq
         XrLvcE0/fn7UJ0sWgHESEWzSGrNzAEJzLT+2Ubg6/i6gfWRDy+HceIZUkS26zvOfA9q7
         0yxy+MunfvhOHQEwQmvG1pAxDD+Ry7yEag5G4rSLkJ/0JHRC/ZkdAaVg2E7F4s2CDxR7
         azLkRbwsvDK1hx4aOrcWGpsuPxIitDsdx400gCjdApdrLCihvKObu8ikWPlX4vAhDeGW
         GINshrsgYxpxSdrDVEkWsCAseTy98fzww3X3E0mNgiblAg3oqM7ABEUUHN5yovoqLLrk
         pR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbs1WhCpoJbZ0+AmCvmGjgLAIsqC6zhQqk4EjjFlXZCOdYyu5NXUrN3yZxMjTAED/+SpBOeIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvubiDtdWfKMvT3y3/+ZfxLryMIIc6DDWd7b9YqxlwCgXZBWII
	IVFdpG2Q/qOJHM5cYQLjugl7qqrlZoJpEsOeK7IswRaCRP8OcffAlIggQFh7nys=
X-Gm-Gg: ASbGncvbw6qKqkJvLK003E6iP19YuPQSx7GklNwGG838z2HCbCwG8xU6FyFpyclqtgh
	2AS5aLzaxKUSYaWPwcMFY8iSeqemFa+Mh2ZQU30deeKh+qcQ14nd0qSvGrENDKNnA+YlVbKccsw
	YAj+RGqnEIGfQ3s/CtiCyjdcfVvvsgaFiihEHpByC5DEPqWxcVFTMiX1Iu8KWyT15XyUN9nKtGq
	aBDvtYGydbAiVj0SkAoZi3QBhu9X5tBUrpThIwYiObmJyQ31wFSEPgoqUeg4iqCCkmk7SzNYH6g
	2iXaMVp/5M+mMuwnjiYapg8=
X-Google-Smtp-Source: AGHT+IHE7jbPZfDgaFFrfQ2dckP29hKgNEaihg7OTf1CKnYo2iZyVlAkYzds57iqtSYVEnk4v+fg5g==
X-Received: by 2002:a17:902:d50e:b0:212:996:353a with SMTP id d9443c01a7336-21a83f3f576mr454745705ad.12.1736895199838;
        Tue, 14 Jan 2025 14:53:19 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d0fcsm71689605ad.161.2025.01.14.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:53:19 -0800 (PST)
Date: Tue, 14 Jan 2025 14:53:15 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 02/11] net: add helpers for lookup and walking
 netdevs under netdev_lock()
Message-ID: <Z4bq2y0fHtAlfBpf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-3-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:08PM -0800, Jakub Kicinski wrote:
> Add helpers for accessing netdevs under netdev_lock().
> There's some careful handling needed to find the device and lock it
> safely, without it getting unregistered, and without taking rtnl_lock
> (the latter being the whole point of the new locking, after all).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.h |  16 +++++++
>  net/core/dev.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index fda4e1039bf0..5c1e71afbe1c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -783,6 +783,49 @@ struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id)
>  	return napi;
>  }

[...]

> +
> +struct net_device *
> +netdev_xa_find_lock(struct net *net, struct net_device *dev,
> +		    unsigned long *index)

Minor nit, the other added helper functions have docs, but (unless I
missed it somewhere) this one doesn't. Maybe worthwhile to add
docs if sending a v2, but probably not worth a re-roll just for
this.

