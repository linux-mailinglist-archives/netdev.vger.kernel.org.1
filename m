Return-Path: <netdev+bounces-114378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60B9424FE
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742071F24BC9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E318030;
	Wed, 31 Jul 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh/l95cv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901918044
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396043; cv=none; b=F4YDPqAj4LpCt8PgMTAIBmZnOflyaadnmVGR5ne/P56/4tPcQbHqRLOZo0hNrfRLbnxaWXHGhDhPONMgYetqsAroDD+SCQc3ntTwf8thule6KXrmCBG8LCSOZgtYDXkaUfjYkkai/uO5nrCk0gF0M708vIsGXOlqTVMXBEI1PKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396043; c=relaxed/simple;
	bh=j3F+BN7cjGvPwSF5Rrv+boPv9WVpsKkibLGw44BsfZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNaU+EZYMMHjQCK3a7jjzHq5+DI1WcgDCiHJb1SsMog/S/SPs9V1tuiqkPe2xAHEwRIr22UDe68t/K5Qn4sAqQqYc0A63aTY5HHB4HjZ0tH8HhXSfRlRgw7e1wcc9rjgU/+AzRVUUOWZjK6kgDvJegJ+aFp81ZiJm3UoNg2LS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh/l95cv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7163489149eso3777088a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722396042; x=1723000842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5bIrqAN3ON/3JLQuyXLvuWNW93UTx8afURKC2yU8hE=;
        b=fh/l95cvrzxDJSv0cGYbQETJSB1xIBNFSWVtksoOFumnJRrGmAeaTa1JBuG89I4Zn0
         4rlHTG/fGA2fdBYvSwt06ClVtuUpue5uDDUuts5Y8rEAgdERT9l2BOIcvoThsENeeKsq
         wGSqAJeD1WXBa6chsNRGcay0dxcQxNw05RHWanb75bDrNUUE+oppnDkXAhgHtDyp0RPd
         uqSlt2iPB7qFQfjHVfdzKqExf65fO73jmcxZklBpKL7YgxY4nRv8NdBGWvvyLVJX5Xy1
         u9iNspdmIOtJNB2SjpbDqCB0UvlajAdU8rBThVsWwgmY9/iNLexNc8xrG6LKQ/evMNI9
         nA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396042; x=1723000842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5bIrqAN3ON/3JLQuyXLvuWNW93UTx8afURKC2yU8hE=;
        b=JCzNaFPvVrgbTQYJ0TTnZRGyWym9f6BIzFOMhHl3t8XTIhPZ9TZGLjKlAq+RWEa3d4
         1fMQPwwflU5BTL1PPYXWAAsmuqcnBreV1wzocGLRJJGGbV8aCpRFPRYIg1eXhP4xph0T
         1RQ21dT+cZmGsokZ0Hdr4nK2yT1vuxi9tSPtCfVplJP2h6ZN10FWFJlpstQ8kxYMWxFF
         i2qgibV3VcmlgPZPilpT+6EsRdydv4vWtJqDYkUtdDzIvAoPJhMxa7a2sTrYQzO+11oA
         RA+Gi6aZs22IkGR2qdwFZkklJgJZjWaxKwH1xAxSuZXIluWenf3/zbp9jlOxfvImFPeR
         Ai6g==
X-Forwarded-Encrypted: i=1; AJvYcCW+Wn04GjsTr/VhzUsO8SEqfm++PU8JRkYEHp3iFRiT7qhClSZMXekHTdshSd6tnet0VesL5Mb6ayArBYzM+lAqA+r60f6S
X-Gm-Message-State: AOJu0YynOjWjR7ggrLz72L7LO6uaHP4IMCDa44+wdq1pAEKLMRim7LCU
	H7oy3mSwEkZBDRPynggO3SQW9d9fGBNnn1vRgKwmypyhPV+JcDhqLGR+oLtl7HE=
X-Google-Smtp-Source: AGHT+IGCfMkctG5HJYTIH62gLJb32C/0nBsWDlhG66SERiPBhu1q9fhabHJ0sNL1fJAGigIb28aXYw==
X-Received: by 2002:a05:6a20:cf8b:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1c4a151124dmr15864992637.53.1722396041772;
        Tue, 30 Jul 2024 20:20:41 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:bea0:2ba1:46ac:dba6:9de4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a2bddsm9115238b3a.206.2024.07.30.20.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:20:41 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:20:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net 0/4] Fixes for IPsec over bonding
Message-ID: <ZqmthLxup5mYi6f2@Laptop-X1>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729124406.1824592-1-tariqt@nvidia.com>

On Mon, Jul 29, 2024 at 03:44:01PM +0300, Tariq Toukan wrote:
> Hi,
> 
> This patchset by Jianbo provides bug fixes for IPsec over bonding
> driver.
> 
> It adds the missing xdo_dev_state_free API, and fixes "scheduling while
> atomic" by using mutex lock instead.

Good, I'm also working on the bonding IPsec offload issues recently. This save
some of my works :)

Hangbin

