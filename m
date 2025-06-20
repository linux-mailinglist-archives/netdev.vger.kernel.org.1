Return-Path: <netdev+bounces-199910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8141AE2223
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3077A9584
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D82EA73D;
	Fri, 20 Jun 2025 18:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE72EA74A
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443892; cv=none; b=H6qsdxO1vl8PUgELsAYIvA4C/vGieqm582wNdjjAOCFk4zq03PaiVzjJrmVd57lYzt9a3iQVuXfzCjfE3FQ7yOGn/hhwZr017/kL/HKtG5XgpaH2G3x3Vn6ibZXI/mWOs/+ojF7Snpy+RWa1uGaf6N88ALAl6UnqEeiS87eUP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443892; c=relaxed/simple;
	bh=cs+YiKdNSmE/ENFtrFYr+/YjN2LDo/VgUAeYvGaLSgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu05YFUhzD/WSOsuznLiqoFD6IjmE/iKuVEA/jhlcPmDnhhVBJHhBQOLrxRZwkStNYI8qF+IFHvktsHzMHm3QwlImnxK2eUUiyTGdBk/qY7ikmrTrjqyOTHW/ieaJuMT5VN8SLwA59obv7guGEKifs5QlamLejWOh/J9a+hZUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0290f8686so313420466b.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 11:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750443889; x=1751048689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJRo7jmxnGgRkY1Efqw/f1f6XzyK3DSzEq2Sx38JWIE=;
        b=kqZPGkA2GROPpO7Cdm/wPxHpEBiEPFhA/Cz868pbH3QrI24vxMC/jHKyOOimSeagYY
         QERxIvKJVpoervKc+oop4EVBWf5aR58atOJ4nrd5G36HQLOUCiaR3vmnOKSjnnyOh+4C
         fJuYKOjt7F8AFYO0livLAbOj9xdO75gbIEfvWIpdXN9MQaVSIVT7f5buMbbvu9vKf7dc
         m2TQBfC3tRsf86FC2X1AtNJKvz+BNK+H5/rbAqhsGnP5kpIfviPnEURBN8P/ye662XWf
         B69CmCROwjwfwqNKjxvvQuRxKwMAM28BLG56EYSJYuyBX0TR0O8btNupIET92wwKtACT
         4kxw==
X-Forwarded-Encrypted: i=1; AJvYcCXIs++gr/IMJJmP5ct27OmCZifs5lRdZJYLc0uYCR7DD6lrQWYFOTSZHnE0WfRaab3qWpcP3YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/cmmacozsrF6CTVUjDELVcc2G5EENCXkunmgtTjfGagdeiqQ
	sqKOb+SvnjdF4TLMLWyb8p+Xi2DMHGtnPeBcCnWbPMdmh5Yk2U3lNLeA0ZNA7A==
X-Gm-Gg: ASbGncsqaDmIUthOVHMw2+UoL2/falu6isW8gHFqoqutfu0f7VA4wHZUE/ILZaIgkRC
	3dLPrjHxGTHqUIH7gh7GC35w87nbFI+bpKimLk77nxYRndpb5evsXX0m4ottrIE/OwsePJS18In
	X96DFkRHmGqLMpY29AVBJYBDa+oKNw9eoVMAvqLI+xZ1JkTmxoLFLaYYSgLZPR0/pRBFx+HttSn
	cEsnpqKDfzZAUwP7c/AXA2qULotr7KmPOnAeTaovGVQaPz7VgznOqO3xAZf46ohXtyYvuvSU0qL
	V1cma4HZfgeZvKUwe81LigU6mzXS7hz1UE3iRqafQW639FszjMhm
X-Google-Smtp-Source: AGHT+IGml/qSVwLt7g5fIriKzK5ZBHV0PUvXN35Lox21llWEOsh4Em/Kce1O2kPF3/6Kv9dsrq8efQ==
X-Received: by 2002:a17:907:e90:b0:ad8:9ab7:a270 with SMTP id a640c23a62f3a-ae057c10ed9mr350981366b.38.1750443889222;
        Fri, 20 Jun 2025 11:24:49 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6fa0sm195187066b.123.2025.06.20.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:24:48 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:24:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	joe@dama.to
Subject: Re: [PATCH net-next] netdevsim: fix UaF when counting Tx stats
Message-ID: <aFWnbtAtl1kA1zIo@gmail.com>
References: <20250620174007.2188470-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620174007.2188470-1-kuba@kernel.org>

On Fri, Jun 20, 2025 at 10:40:07AM -0700, Jakub Kicinski wrote:
> skb may be freed as soon as we put it on the rx queue.
> Use the len variable like the code did prior to the conversion.
> 
> Fixes: f9e2511d80c2 ("netdevsim: migrate to dstats stats collection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

