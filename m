Return-Path: <netdev+bounces-141713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD759BC182
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D2B282C6D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6041FDF9D;
	Mon,  4 Nov 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oa0wm5Jx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E851ABEBA
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763322; cv=none; b=jAjhenWATwVyXilWv++7Qa8aLeXJnLotK/0OGqq9D3/hn2KgeVzjRpK1U0REhowYV58xweBiCnW2zIqXxezj7HVrp8zbRwG/VFwJFC0tGI/6QVzs/ZN4W89SOxbLtPwZJxGo+ODcPsC0VTkwB4ZB40GCLJyM0Cylrrgct5F7tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763322; c=relaxed/simple;
	bh=g12YJMdjzc4EaRnpMnl81wcVbqzgZX9A6uefhMb5jAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAPp/8dVo8FGsOSwZT+ZIcnpHrUg9PdP6Fk6gQnjTOEuFPdUXFLTgiGpimAZmdxPX13iLDDaI0WEkGvhinGiv3AMnksilPlgS6RtIHNgPsl2kbz5yPnOwK8fSxdjDXN08klj09lPzGoKdaR0oPYTLKmhzTBAYUdS1ZOfKFcDPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oa0wm5Jx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c803787abso37569175ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763321; x=1731368121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=oa0wm5JxwZwci18yD/EmRq5Fag/WtQ3B3zpIBVmgCBF+dQOMyfiZOJ75FoL31UTuSq
         67QR5A+icRih96pHufUChzTw6GJEjKWtpFPSjLH3zOTA8OaoU6nFhWpKXfmCdcR/f5Xy
         H1zYpBGzd5pudrrJ4qiF+bu7NbHIuT1vz17gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763321; x=1731368121;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=NRLqmqziRRHnSGBl/+DV3jKqLLRtgWZUc4sbCapEE7+PSwnLIJ5NHpGa91poOJZA3w
         7St+m9+5mXEfN802RdZywkgzxHniU9txI2wIFA2K+zRitPgXt8euMB9Db+ypXdm5xJET
         g10sxi8Ee/DRJbWC3qlr4BPh+Nz5xJuEAbnX3qmXPjPaYYeAEgjp8eI7nVtWNukhwcmM
         lWe6gu19KYv3QzP8pO/FlSh2XXF9qg2xnDYqdOa2PGwAh8YewojRf/CF4P7yhJ6Hcfl+
         Itd2NfoPxpUakn/DH7q38AfHwewRWGQTjzepHIqlEQ9Aj5QwnDHncky2wSu1BfjxkBko
         4T1Q==
X-Gm-Message-State: AOJu0YwE8FXiDYocMwU365gNnFFqEVXrnX5e1uA5gjWVjlGv3Ds33wPm
	DuFBYIxS6UUa1q+v3yyIYzdPB2/J7aGdJsWC3Rf2/8K35bOpmth7iZxm4cHJzCs=
X-Google-Smtp-Source: AGHT+IF75w+Ptq7bsaSssIf5M48gQfiKPC9x4jCAu+t9iSu+zcEnnB0a2FVmbeW4YMy00MxPy3Pi5A==
X-Received: by 2002:a17:902:e5c4:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-21105716ef4mr243171585ad.17.1730763320701;
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2bf7sm66763055ad.173.2024.11.04.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Date: Mon, 4 Nov 2024 15:35:17 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 01/12] selftests: ncdevmem: Redirect all
 non-payload output to stderr
Message-ID: <ZylaNahW4yhA0uC4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-2-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:19AM -0800, Stanislav Fomichev wrote:
> That should make it possible to do expected payload validation on
> the caller side.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

