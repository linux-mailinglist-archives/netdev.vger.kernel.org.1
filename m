Return-Path: <netdev+bounces-178821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33ECA790B1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A69167996
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86AB38DE1;
	Wed,  2 Apr 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIeaNL94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053D23771C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602832; cv=none; b=VSlwTtgc9/25X6mwOz6citCFXB+uvJaxdsIHtwzIdYQyhpPzIWnn9Ny1RhGD3yEOxPoqNfU7Vh+OwFF9vbbsYszfQv/HTURWmZh24AFEEhsIoSTX8SQJE8YP0CUskYnoYV4CG6xOLJfxHRx9rdeLT5kFYOjdfQEq8DYD/qLiZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602832; c=relaxed/simple;
	bh=8ufoFNQhVc1C0wv3TUfu7dCvL+GOH3lN9YqoEWqcHrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGqh6zcbqauai6XNLVDEzQxTrkbApO4rUqEYifXNImRpsqeMOdsQcm0zOEUqPCMyny0AE7kNb5K4qI62Plf0dCTkQXjFltnwWS/utsVbe0G6Dfof01ZYcJXvFs5MKYShA0moUVszEJOjw6vsOtOZsmAq16lpS/9Wa+PlSnsc2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIeaNL94; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2264aefc45dso11355815ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743602831; x=1744207631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zPuXzmduhsYjyQCCGmQDwW7cdOsEAxRn7O7cK11BYE=;
        b=TIeaNL94ZNFEFykg42j0Hbq4eeExDfin3dt4uJ3gCQFRiyht3vRcW65OP/bA0kphwV
         I9VcJ5Z+gewwQDGcT4wM3ebtx0mXSFaz+S/fn0apIbJKlmbZdU5K28cSpfKiY83+rtC3
         Ryitp8PD1tDuV4I5dNkAFdsnqmkwHjEtD+Ut/u0/3hhMnoR83kiMqm1mCBsUxWUgN0w5
         9Na6vjaOH2ZX8yDi8j0xR62p2V/Bl2oeNxyrNPB2nuaU3cRp60fkKh8/ucIqoEIM+jL/
         sdkaoLPnTDDBXmfYl/4M1aQvO3Z8TcAB5cVqOzaplEoRZVWTNuIgyHQUEEhhCkBS6aEH
         u0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743602831; x=1744207631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zPuXzmduhsYjyQCCGmQDwW7cdOsEAxRn7O7cK11BYE=;
        b=cELjI/j48QH4u4H4cf9fKT691CA9oW39Wm3Y9PgRUkojXrtR3CtoqhJR1ZD2kX8iXL
         Gs51RME/jFWz9eaMarH0pXKZ5GoRBtRKh72oF2ARE/t6+rY+s/sqnzIedQS614ARMTZG
         5hLm4Eq3HmOIEDYaLe6MkYRz/bh8rtNaM2vWdevd02dWvAWpvPDwKvNsDtGqkf9yJ142
         Y7GzQgCYbs30cvp5JrfYjqnF3ER8mf+zT5RuWb0RhdksVHRwpgpTUwju1LpO5EwXGjo+
         3sZyHIB/1lDT8IVTKgiv1oqd/jWeXaluGj2J6fTycfPVd5LMFe9fdUlOKtktQvIkhm1C
         DQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUz3hgpyNcbUq/7IHWRxREgOQnuCCEJOvyZ8Sod1digyxe42clEewKuvgqbaXOwAWW0NYgV8Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+ZHDaveaFEdZv4p+SNUGKnFM+z7LG1WlkTYo2VHDJcegGlv5
	oMQGBAKEqWyrmALFBAZP8X5ipyXcRWzE1/9Qy073TSJ7p3UqWks=
X-Gm-Gg: ASbGnctYz2HPLuLfPPehDw8LDfrBZ7/pkEulxP3Us9Dcss92kQ2tfXY/pG4yCkHACm/
	jCwwRvMrmTNQ2T0qarCtbI6uBIZ9Wphz58/9ZZBfONZsChi1duTjWWfVlAQ4A+k7TtGYnMN/qpF
	zr5iRCYH3vw1miSrnlj8CLVFLGT67CTYkIkMYkW8kw+yHJjv4OTsR73sHbfvzVgNWdW++JeYak0
	LiLuV81+f8LAc5clkDWW5oEvRngfw6Cad8Wsy8FGK7kYMuMsqF080K6WeYb1ccWpgJlzwzeRQTX
	8M/uBKPoIJ9MuAZIgWNhYLHxuTQ+3RCagVrHFDdJaspz
X-Google-Smtp-Source: AGHT+IGUjJm6co7og7GhiPwZi5IOKjryfl5QnOarCaROdfOpovPVfG2KEMmui3vXL9x4w+CblkrVrw==
X-Received: by 2002:a17:902:c94e:b0:223:faf3:b9c2 with SMTP id d9443c01a7336-2292f97b184mr242623425ad.27.1743602830512;
        Wed, 02 Apr 2025 07:07:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee2667sm108219745ad.92.2025.04.02.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:07:09 -0700 (PDT)
Date: Wed, 2 Apr 2025 07:07:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org, romieu@fr.zoreil.com, kuniyu@amazon.com
Subject: Re: [PATCH net] eth: bnxt: fix deadlock in the mgmt_ops
Message-ID: <Z-1EjJSCDTWPHoEU@mini-arch>
References: <20250402133123.840173-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402133123.840173-1-ap420073@gmail.com>

On 04/02, Taehee Yoo wrote:
> When queue is being reset, callbacks of mgmt_ops are called by
> netdev_nl_bind_rx_doit().
> The netdev_nl_bind_rx_doit() first acquires netdev_lock() and then calls
> callbacks.
> So, mgmt_ops callbacks should not acquire netdev_lock() internaly.
> 
> The bnxt_queue_{start | stop}() calls napi_{enable | disable}() but they
> internally acquire netdev_lock().
> So, deadlock occurs.
> 
> To avoid deadlock, napi_{enable | disable}_locked() should be used
> instead.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Oh, wow, how did I miss that... Thanks for the fix!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

