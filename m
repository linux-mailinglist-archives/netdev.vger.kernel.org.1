Return-Path: <netdev+bounces-233603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE9C1643C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C1B3BC28D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2939345CB1;
	Tue, 28 Oct 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUBOwzsM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3B276024
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673284; cv=none; b=cIet7eB5OaSq1W1SgkGes3jbpNL+k2Cs+Fons3VSKw10NP5SyPmYsmhURgGagUlrrpChcaMuW3JLVdKxHEZaORtOGJVS/L1ziBP60X3uJsC1ZOshAljWoY+El/G9ps6lNdnGwlCkTbM8VTjka0jGle0z/i15IAfV3VCmDNbCzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673284; c=relaxed/simple;
	bh=xxS2G6WQPR8xLQfqYucZVgoySn6VrwB7yqfdcY6tPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOCKltEkq6x77cTm6GIC9eg+7an3MmwsOZzfft/C+GuS8LLsfh0AG0EHjwLqta3RKUIHL7+k8XQy+zUGxkzpUQJm6jx3KmdBRYinQoZurC3o7B6rZbJfw7+ndRfisVY4aW7ZBNFt71gdOOU7H5+Zbl2AbcHe20OjWu4+0s5E/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUBOwzsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761673282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mCtIp3NhcuQTnj7vYhpcJFbrhWeSPVCifF35mih/iY=;
	b=QUBOwzsMOkKiZhGj5CE5ykgGrxBjZgDDumdw8zKGpqfgWEfDmXRkEXBRkvfQfNnBsvxGA6
	nykLzIk/gEPXGPSsyqzS05/rIoMHcJtyngQ0Q+gRURXNWoQCCBD3YA6U2s02SA9DHuwZ5J
	jx1A9bKaDJ5iGjMrve/OyZahHTNSnS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HRCuMOmyOi-vkTHZrOEBag-1; Tue, 28 Oct 2025 13:41:20 -0400
X-MC-Unique: HRCuMOmyOi-vkTHZrOEBag-1
X-Mimecast-MFC-AGG-ID: HRCuMOmyOi-vkTHZrOEBag_1761673279
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471168953bdso1330695e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673279; x=1762278079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mCtIp3NhcuQTnj7vYhpcJFbrhWeSPVCifF35mih/iY=;
        b=JLZz+82wa5deMWttF/UJaBi4Ooz+el6Q6GfqJkWPBX0aUPhZLEFN5qTMgu8kmpDW9m
         SCKsaK1bqTcCT9QkMwqwyMPCikscuG01iqIcLtVzkvc5Aaoxuft79Bd76UmZj2heOnQQ
         HXqyxVE6KstTj9y+ZcwgXKPe59yllZiLCp9EBMIy7vBWbvkbaGqunRBZeOMDGQpzAgyZ
         we4WEj+dce1y1rQB+7UEohGvykp1UJ3/CfVDycizi0s7+qRguwsHDegN87myMTpI0Huc
         RV8aO0d2fqqz+PZIRDYbGDHRLRzQXAzf5ThmCid1xTG7N5OUlW4xCJIGfpx+cHSb5ExA
         tw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWf19k1qSXE2YdokVwf41eqHj9lZHPCpgc3o8UvGzuiOLw6LTCvMIYNshtZZF1WYbNeP2GX86Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnAWZBW5ox6Yu5AqrXo5vTpQYkMKGWJAsICyB770ges2JQUoM4
	SdmGypJO0PPiQx0tAnNnx2IPYjLyij4ungS3N0IL8AsEkmW481cj6qW2Kszx9Q/a+4nYlKCmCXJ
	4lM3eGpeANphnQHnVasqiLGjqMMnqs4t2OIwswzSxjPJr8wOy00O58xKKrQ==
X-Gm-Gg: ASbGnctYHX6iZBBGS6dsOdoCZDfNGBpqqMUkgu9jl+vgsCEkdjvZf+W+E+1+93KjTxM
	QqbBItbNp+X6fLgGat32/Fp5WhjJEkZYhF5uLdo1BHx8uPkqlWFB1McVxL9EQpcJ8jm6rhMelOj
	owCt81Dd6Z/N9OgEV4WPqljCwVVGfnmv9xY8Cs0EKmR91YvMbU+p1O8BTyjLuGH0KPA84JNIGVY
	gXptKjOifU4XqLUus6ImHPX0rQU0VZK4C2bAmrZD0Ggaov8wpuNujehg3T8jTi1o8kh/rO0Ci7g
	xecydF2DP+tt+jKLzUEMxpOlKZaQbRd600smjwu1zdOGuCf+cOkKqp2XbBu0/XN4W8W/cPOHBdS
	/wCh/ZPlEw37MlxQuBSPBE16Ca9t2z159yHoUu6LM0tuA2biEXLuVgQ==
X-Received: by 2002:a05:600d:6104:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-477180f3b0bmr26156835e9.1.1761673279445;
        Tue, 28 Oct 2025 10:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWtnY3mqgMJ0swa1V5PzzStI64L4bSLRcAclZWa7j1/RYzNAh+IUcCdtR8gXCnJa26xesmNw==
X-Received: by 2002:a05:600d:6104:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-477180f3b0bmr26156585e9.1.1761673279061;
        Tue, 28 Oct 2025 10:41:19 -0700 (PDT)
Received: from debian (2a01cb058918ce00fc0f8e023b359d02.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:fc0f:8e02:3b35:9d02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e39379dsm2613815e9.6.2025.10.28.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:41:18 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:41:16 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 10/13] mpls: Convert mpls_dump_routes() to
 RCU.
Message-ID: <aQEAPIZOxe4aHt2z@debian>
References: <20251028033812.2043964-1-kuniyu@google.com>
 <20251028033812.2043964-11-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028033812.2043964-11-kuniyu@google.com>

On Tue, Oct 28, 2025 at 03:37:05AM +0000, Kuniyuki Iwashima wrote:
> @@ -2768,6 +2773,8 @@ static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_modu
>  	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
>  	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
>  	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
> +	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes,
> +	 RTNL_FLAG_DUMP_UNLOCKED},

I can't see any reason to keep the old RTM_GETROUTE declaration here.
It's going to be overridden by the one with RTNL_FLAG_DUMP_UNLOCKED.

>  	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
>  	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
>  	 RTNL_FLAG_DUMP_UNLOCKED},
> -- 
> 2.51.1.838.g19442a804e-goog
> 
> 


