Return-Path: <netdev+bounces-104885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FB90EF78
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD8CB255A7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFC14EC79;
	Wed, 19 Jun 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr3GV2WD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33F14EC60
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805280; cv=none; b=P2ExSyL0f5hx8Zoh0do1f7QbJDZ3ob5zLBl17zGQEUWSWVl2i9d+cLiNWUXQfGqR4JhdTuvTDDEomlTCZlg8WDNYvwdGFjnzTfWaUADB+TZoKsoQyrbK9sqnB2thYdDM0BtrvR+n6sDYjsd/3tTeZWORuB08715Vgyvco241xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805280; c=relaxed/simple;
	bh=uULrUp2XdmogMLrSqTrBAy9ErEQY1du4cURnaRxIxRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P79zNk8UVlQ20tR1945X/Gs2JJBpQxauBnjpMQH0yUqeCG5Py/Zqu83RVTvznLykjffnGZZOZYPYM1rOlUxlpZbHxz7Y1MGDhgj3jJGFLbtgx07ocHEJjv1LU/iDgPGmlp/2fpQGJk5zjD+3iCAkl+/w/+mrrA7K+vTgsW5wSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr3GV2WD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f04afcce1so863675966b.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718805277; x=1719410077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/X1uyeKMm+LCTojyS0F0YrzqYsr5hKB4jznu/4UFt8=;
        b=Dr3GV2WDhu+Oakvc9fi144SccNziLRxLThNP4Qx7A0aONjP0VtnxKsb1RFoI3mJlL3
         n6tXBbVyuLZhTL6txHvCe8tNa/C+d2URoonemRNS96TH4o5UoJL+Tm8c4IelsHffWhom
         Y9S2Sa1Bqgv9KvIvQPmNnIR2G/EKcHyWrqVSZ1dBst6ceZSAIsqHgVT3ZCptEnGw1s8a
         987TvSWFgK758PXiVcV8H4ignvAsCdR6MT4+kFmm/VWSoT7YjywXU8ZvlLSWwgcI3Nhj
         Im1dmT5spUnfO/VfGHAsA0BzmLPkFgC3+kzBxyhkXJ3SVd5K0cl4YVtj/mTqgoDayimN
         7k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805277; x=1719410077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/X1uyeKMm+LCTojyS0F0YrzqYsr5hKB4jznu/4UFt8=;
        b=qEiBJEVpQDz7HJHUQFROfahaUVi//lCKXNET7F+bQ6hXnVH//rlKhy8gEhK0IMeocZ
         Jcjn9LNgxfIWBtK5lNOtJPUnQ3LIZK6g1syLqBlNe3wgJgSHC+7rGhuWurmaFW63cNeV
         gTNmodrGpyj/U/1mc7+I70vDVRVVCtO1BuDYKOcJrse4tTBg3IYgOvw4wuKIyVGiMUq5
         ShAiGOemuY8ghBtwRWvb53xLVRKMMMcYZHvXSztXchbrI6icSlUN2eHof6YVllpb+PnN
         Pj+ngzrqZExuV3yt9RJ+sTi44UpHMd4vERNkfTqTCtnS7dmgMHpNf9VWK/Q74kQXW9UK
         iQIg==
X-Forwarded-Encrypted: i=1; AJvYcCWD0KEBAtxREDQ1q7bqsl9P1w9h0R+6D5CKdqTgU4NTpGcyOr4ua8KeehLLmoOuJFL5sdaBxaXAGAVEwKPZyBHd7qdRhO/e
X-Gm-Message-State: AOJu0YzA3t+1rvgz6QLeY92FbT0gMy255DhmHbo8ep8LrVCPh6P84nul
	m1GXAE4rSlx12YYNxagemjjwW0HkT/VXFIyn2GoX0gEML9ovk/DhB6pwBmvcPJU=
X-Google-Smtp-Source: AGHT+IEoW9z9RL64fJJ6JJy+WiDYy6vtGgzuIi7TtyXXpU/XYPbgwsdqNS38T+1EnBxDOF0tEBmOZQ==
X-Received: by 2002:a17:906:16ce:b0:a6f:cb3:55cc with SMTP id a640c23a62f3a-a6fab7d6d8emr139748966b.73.1718805277329;
        Wed, 19 Jun 2024 06:54:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa67ecsm657146566b.215.2024.06.19.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:54:37 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:54:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <a213ea45-53fa-454d-8989-49dbab806313@moroto.mountain>
References: <20240619134248.1228443-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619134248.1228443-1-lukma@denx.de>

You went above and beyond.  Thanks so much! :)

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


