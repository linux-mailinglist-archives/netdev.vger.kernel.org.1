Return-Path: <netdev+bounces-184837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9BA976AA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E947AAC93
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC1298992;
	Tue, 22 Apr 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Srl1DmVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE917BED0
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353001; cv=none; b=O/cqwmQOZHu2oS0TYVv2qR5Kbmt5y5k9Yg9lFn3wlnWZOS5BuFdpynJmSPaQSQWL9qg7N0gJU+sAsVmX75R+mG3tVuX3mYlaXZazgLyJZvVxp2GTTFs7txLB4HkMsYyailjppPYhFX7a7r6AL3z/jIFpytLgksxaQ2RVIyb55to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353001; c=relaxed/simple;
	bh=V738fx9sHxbPJQLFqueueap3epQ0m87kcqgyyj8D30k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM8t2docO/DVInAe0FzG7j5S5nStYGefkJF7vPM3Pr4XJoP7N88fC+rV95oAtdnJrOe4obvEMfQzZLtP4WwxnXei1OONP3CerQSPTsoPEwJGlWvuq3J1iHr3+TeqKrvsSj5Z8k08z1gEUsyv+kpWxDRX+Pa+CjBsOiQA/MaWndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Srl1DmVS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so60570935ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745352999; x=1745957799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTJQZJPXr8Cguq9A3DxbN48+CCPVDmv7CfP9nMMaJAk=;
        b=Srl1DmVSGXQLYBcfSjWC8wMDMVEVBdFP0vzGbLbLcwxEyPNcZi709z65WKE8EmU1iy
         IzRVBADXw6uPGoI7JaMdk6kCciaAfF9nGrtxNNmEd880Loqw7X3EqTStlmaEcaVzkW3M
         IDKoCJNqAkzsBS366CXddvecNuBLFcdjtNWuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352999; x=1745957799;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTJQZJPXr8Cguq9A3DxbN48+CCPVDmv7CfP9nMMaJAk=;
        b=L5OLzWOecy5TEWv4DmeiVarlz67Jo8+UlTtYW9trPYeKFxWwAUmjuJ5Wre+l+FO9vC
         LghiUbdyDaA9cHD8KuFtfIqFkxh6+dLLl/vBPnkjOh4JOPyip83VyZWLtuqPnXjXTjSJ
         5fHsFfBT+wGG4zU9A2MoUXYWiqo1FIwQl6mv/qmOhpF6McAprfIoZzG8LvBAXWfxwGGB
         MeVLm9elFk23ZIr+6bTrwlqdP2osUwNTBrqsbYJFdMiM1FFkI0Hk7dEJVRZtQZtIVXOf
         x0hlZA6SoSyRR0AwXQ0iKAp89mRmNzirgFWy3Ht2F2D6R32uui/lGh8josNhJIbVwsLi
         1flg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYq9gK+GpYJby1RSaawNXhgixGREhwqVhIL+yOjFir+D6uixcvCF4NBgKUoM0s1Q/S4DbPWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E44CANPQ+BzdJ31WpAghbbfI5SrW9j6JUHsKQtMy7Y443MfB
	wde6zJiTYAubo6NSqtU/IDWQsUAgf1gRFgKI7WBkAesYJLX5nrYVozX5KRihAns=
X-Gm-Gg: ASbGncvJ0S+apJr6DOdV6tdhHCHnQ/jTEKdom+RGr8wB5KGnbzwlJp39ngFeTD4DCyK
	sm1z4/QEvFXmjiJcawW0AuBAvlMsPkTRWe9mdWpcF+PrAPKrYpkpaVFBA1667QaxQUYd00WaED6
	ytCBb3a20LRuj44EGToDSBreXS5N6cNtlPZ5VgOP9DgH6IPDNw2i/Z4L/PuFqHYZ5BnryinHt6B
	ulZ236kyPcMn62mdBiq76S7S79XZrjfAAjDsae/ybtAB/100ebR5JT5MT5c0Tjp4tfGdSGKA2nL
	aaUvqAql6s9szmGkaGvq2dzvPxKZPjw2Od07x4EHIKZkldleiv2xiYfwgkwZlYFYZI7/BBtIopy
	v0ti6j2xNSL3X
X-Google-Smtp-Source: AGHT+IG5yrzAQBYAFkmoitMysLfBX/Z6QCRLxBHqf2aQqFIPKHSHy4KWs/XOtfpwNDAOp538QbChVQ==
X-Received: by 2002:a17:903:1a6b:b0:224:1ec0:8a16 with SMTP id d9443c01a7336-22c53580d28mr244534545ad.21.1745352999144;
        Tue, 22 Apr 2025 13:16:39 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb530dsm89240395ad.151.2025.04.22.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:16:38 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:16:35 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 13/22] net: add queue config validation callback
Message-ID: <aAf5I3kKrf7l5oym@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
	asml.silence@gmail.com, ap420073@gmail.com, dtatulea@nvidia.com,
	michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-14-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-14-kuba@kernel.org>

On Mon, Apr 21, 2025 at 03:28:18PM -0700, Jakub Kicinski wrote:

> The "trick" of passing a negative index is a bit ugly, we may
> want to revisit if it causes confusion and bugs. Existing drivers
> don't care about the index so it "just works".

FWIW: I thought some drivers use the "-1 means all queues" trick for
things internally (I thought I saw at least one driver use it for
per-queue vs NIC-wide coalesce settings?) so maybe it isn't *that*
strange

> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int rxq,
>  	__netdev_queue_config(dev, rxq, qcfg, true);
>  }
>  EXPORT_SYMBOL(netdev_queue_config);
> +
> +int netdev_queue_config_revalidate(struct net_device *dev,
> +				   struct netlink_ext_ack *extack)
> +{
> +	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
> +	struct netdev_queue_config qcfg;
> +	int i, err;
> +
> +	if (!qops || !qops->ndo_queue_cfg_validate)
> +		return 0;
> +
> +	for (i = -1; i < (int)dev->real_num_rx_queues; i++) {

Not gonna lie: this looks weird. But maybe all that matters is that
people following this changeset are OK with it?

