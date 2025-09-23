Return-Path: <netdev+bounces-225594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCBB95D5B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A59444D8F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBCB322DD1;
	Tue, 23 Sep 2025 12:22:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C747322743
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630158; cv=none; b=M8B9NN8xaxbNDmxM+PF8xh1DtQ0j4jBBqkNGcQKzq7JjLRc4iVNCsgExAQc6jTVdvMSVVYNsD5wEw9Or+AwxB7/aYuHTrhKmnP9SlE6fdrR0Kz8JQkpWerW7EgZ15XMc5Ogd3hoC7bvz0t0OGeVlGRxbOGCFeKFacGmGqERnVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630158; c=relaxed/simple;
	bh=U+5D0sR6XJEjZELYryi29uICrwMlCpQuoP+FBppgRNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7zHFi4P2CCFG9O3JISbHgo9W90qzkrFRfMmljzzv5RaUVSIFN3+riZowVz2l6hXXpkG3H0O1PduhLBuhT6LHrPLmfUXixFCfA7F9xT+xcL6PCRwAR++8Gb/mW1hA7iK9ObRvMtJC11ifD4TaB9WDubWa/dW0usWB1D1rgjtWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b30f8d14b9cso65720966b.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630155; x=1759234955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUwzngG7jyImtp5vHhFKudSZI9s6xHT4nLuU1ntMiUE=;
        b=rJICaIoipli3Y/+sU9v5ImdVpw6p8hj5XkgI88bezlRV1aQEaeG+N2M+7SmmH6el7Z
         Om6iabZypoSCjAmb06ba/2vR72fDKH8QqIeyia3GoAvOYIlXJIC5Kmyfha6+4/KBGtOx
         xLCCdvx05IbhFOedAMQQ3Dsd+aQgTkCdS2gCzKeDhrVbQ0Z/kHweeIca/6vQ4MeekH2K
         kW3XVhBILh89YbOyhWye5dJpKgi4+9b44QvkZb9tFCEWJfOMtPJfELb+lFqnKGZGvz1F
         Dc+ToXSjhowdM8YmZt8BGCG6S6dElZRBz9dEHFtmbMhczJMphLj9POWy6vGb2Kr76tdC
         7mUg==
X-Forwarded-Encrypted: i=1; AJvYcCUAOqOdGOekdVSsaiD+C1M04m4WMN5egvIbTQbVHXbOpZH4zhu2d9ZOijSEPWks1t3VYd6iXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwCRPYemPkYuSB7LOeLvYiDYaiu0iKGnzs7ZVB/1QpJB7ZQ06
	JOqONqrVz0vKMH8MnPFd5XkHjWSyqyGy5cFSdf/g3bBMAs8rlSq9GTHS
X-Gm-Gg: ASbGncuYVd/Z4+3Jt8kwWAldK1tvUAG01ZfPKco2fr47/Q8b8JMK6PBwgZNcn5iy+jo
	3J29kV1BForEOhaXgssWXCDdkEUlc4qfqR8O/89vyrXhT8IZniXcqMrIMOEUccH0OtXFQdfFGAM
	N9ZBpn9OXNz2cwIGIAEcQKZNisQo2lnUdD81kBSwmfAT5BmyK546Yj2cuJWQj28msei5XJiPzvK
	c9m04RMfDCkWjHd62PmVcgOpCW4hQ/VljTTJxdwUezwttbQyQfh3bPYHrvA8xq/sLt8/zhgg3E2
	AbcdLoTNoT8PXDL/BWy8x53WG5kIJEKGdKsb/hXfT2K4ggEOQ7bvmzygyitLXGh9ia5oWkLLiT9
	VZogR3bvk19++9yV+I8xRjaKUxoi2NQ4=
X-Google-Smtp-Source: AGHT+IFJJQV/rZ81JFvvZxamav9LBv/rKh85aN3SZcE6XIweQ1NYh5YOnCqwoF0bRMyahnqcLfy5LA==
X-Received: by 2002:a17:907:9403:b0:b2b:63a9:2229 with SMTP id a640c23a62f3a-b302ab33a50mr245730266b.30.1758630154444;
        Tue, 23 Sep 2025 05:22:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ad6d374fbsm589066266b.107.2025.09.23.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:22:33 -0700 (PDT)
Date: Tue, 23 Sep 2025 05:22:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>

Hello Andre,

On Sun, Sep 21, 2025 at 10:55:45PM +0100, Andre Carvalho wrote:
> Attempt to resume a previously deactivated target when the associated
> interface comes back (NETDEV_UP event is received) by calling
> __netpoll_setup_hold on the device.
> 
> For targets that were initally setup by mac address, their address is
> also compared with the interface address (while still verifying that the
> interface name matches).

For targets that are set by the mac address, they don't necessarily get
np.dev_name populated, do they?

I am double checking netpoll_setup(), and if
is_valid_ether_addr(np->dev_mac), I don't see np.dev_name being
populated.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 59d770bb4baa5f9616b10c0dfb39ed45a4eb7710..96485e979e61e0ed6c850ae3b29f46d529923f2d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> +/* Attempts to resume logging to a deactivated target. */
> +static void maybe_resume_target(struct netconsole_target *nt,
> +				struct net_device *ndev)
> +{
> +	int ret;
> +
> +	if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ))
> +		return;

But here, you expect that np.dev_name is populate, which I suppose it
will fail if the target is binding by np->dev_mac.

Should we also compare that the mac doesn't match before returning?

--breno

