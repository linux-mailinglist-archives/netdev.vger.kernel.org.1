Return-Path: <netdev+bounces-128095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB3977FC1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D51F24CA0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BB1D7997;
	Fri, 13 Sep 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gM8tGHkE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829C1D58A5
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230100; cv=none; b=JbnAxc/eeqw94qLJYmR25RGVmftuF3homFnHnNLUKc2Ll93a20VQNb3OsEwsExEWiP6M615ghng0s5rvmHibS9vN7L1sTi4IUz6gl3ze3QDfExQ1hUrfs8fSnmKa9N09NPt+bFidm8IG8Vcf5hqwVAN0Wr8WM1Maq2sGgIXTe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230100; c=relaxed/simple;
	bh=Ilak9Dqhyf4Y6TXhl7jRxqWMNzsY4BTlF8Abu2MGG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apUrIqeWj8+dgZwmY8BmmGHhdUWur/YWbY21UsysGjNdVhUKmB5lx/FuDTNPqCnNNm1X6jYOTa2yAZG5s3vHt9k1z5AJ57+W29RDAQPZpP/Q4t4u4JF22YgJssKTpJ5NzoUCl4LqxzUMv1DhQjif0XnG1s2/vBxABroZyo2wDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gM8tGHkE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726230097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ilak9Dqhyf4Y6TXhl7jRxqWMNzsY4BTlF8Abu2MGG/A=;
	b=gM8tGHkEaC9D51e1YOw/Twa2lL1nT86eWUjphYkAq9pr1oRIAdSjnT0/NnttBtL6corAgC
	IRA05D4RB3tpzGgELxRLS/WFv/jxts4BJ3s8qyMsjTy8+hlCLs2QhzSJjUDZZWt60Q7iZ6
	vwaiAqh6GIx7VAv/5qADxyGSGFCZNaY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-FZ8zDnfHMGKjXklAftU1UQ-1; Fri, 13 Sep 2024 08:21:36 -0400
X-MC-Unique: FZ8zDnfHMGKjXklAftU1UQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c581ce35so1117687f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230095; x=1726834895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilak9Dqhyf4Y6TXhl7jRxqWMNzsY4BTlF8Abu2MGG/A=;
        b=EHmdJ2MffikIefab8czZpW6cv0xw3uH6w1OKXnL+F8aJ1Xs7O65jEkL4kygDy/mtVy
         eXDFXLM9S5ia67bmQo1B7xLm2YAs8Rpk9mcWJOl3hjuSw+ml0l7swm/ePU/gqeHUXcQc
         AcM4BUSa5mQBkqrSiu8H0zYKNKP3ojwde23wGuYr0VZA37Lm6T5hl3MW4HLAmj8tMjuC
         iFqMmdNZz7M8hDTqrZe5kxs8DnLWRfZnd4SwrAexPlLFss31jbxhcy/hPY09zTLiCJhS
         UxvngjWVbcvUE+P1Z3SAM3t7OAQ8F416B5chLvpKCEADFoDS04vU4ZY2vewPOk9kxei8
         Bz9g==
X-Gm-Message-State: AOJu0YxQV4GwsvqG8pWM9Oh7BZB84wmebVu/yILZMg1IKHVDEUHvEO9S
	aLUQn2LgaR7DDv8eQAncdluHgL0M/ET+GR/LKaufTfYAhlF5xIT0uYRfbl0HL2IXE5Efp011VfS
	z5F0i4mcdrKkQrBHpyPUCJPb0zUqRz8LSWpbfz4D+DiFeQrjozxCsTg==
X-Received: by 2002:a05:6000:1e49:b0:374:c847:852 with SMTP id ffacd0b85a97d-378c2d124c8mr3772062f8f.29.1726230095380;
        Fri, 13 Sep 2024 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkBdl/KNHzxXm0BsM4mOIfhFgaF63godtUE8eTF09700i3WqGsJv9BUsGBNggpfA6qHUISRg==
X-Received: by 2002:a05:6000:1e49:b0:374:c847:852 with SMTP id ffacd0b85a97d-378c2d124c8mr3772015f8f.29.1726230094283;
        Fri, 13 Sep 2024 05:21:34 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm17183807f8f.36.2024.09.13.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:21:33 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:21:32 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 3/6] ipv6: fib_rules: Add DSCP selector support
Message-ID: <ZuQuTFCo+h5hNtNB@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-4-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:45PM +0300, Ido Schimmel wrote:
> Implement support for the new DSCP selector that allows IPv6 FIB rules
> to match on the entire DSCP field. This is done despite the fact that
> the above can be achieved using the existing TOS selector, so that user
> space program will be able to work with IPv4 and IPv6 rules in the same
> way.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


