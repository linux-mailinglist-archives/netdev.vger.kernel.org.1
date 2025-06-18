Return-Path: <netdev+bounces-199049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F29ADEBEF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E0E1894558
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45B2556E;
	Wed, 18 Jun 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AISR77Ei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C564EB38;
	Wed, 18 Jun 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249260; cv=none; b=oO0tgpx0/hgUXkTikGannridfVg72frQ5axBigbYvtDMCUwxLEFMT0KDvr54EjXz9oMDL9vCSz3cy2uVdUPtPhzRHDLFC2p+Vs5a5X0CzzUh50ciE8XzkL5vqmpBmNgV8BrV3GgJcWeduL3PjO7FUp7LrKqNztOKCi5eaH/NJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249260; c=relaxed/simple;
	bh=De2hGz3gvtQnW5EJe07LzzlHoUlHB5o1oUjN4eO7FcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URGV71PSTP/dEHQlDGetgFKzvUAsLkr2i4vmo954nC9DI7jhB1M8ZUAy6lrvP+1D8OamSuNQyPM56Bdi89Z2rvdiXv/Cc8VeKA7lAauowivUIOlwcw0F6dFggGuRvjhsg0pPgZYY9hDc3Am9JKrxFtPz5vTOAhkmHi93Q88AwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AISR77Ei; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b3316160so4333906e87.2;
        Wed, 18 Jun 2025 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750249257; x=1750854057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJCOxXHVo1xvCRwBVR7i8ri/Hq2UMjfD/lprAcsfHqE=;
        b=AISR77EiyumfJk6hsV3LUONyi3g0wSkcs3KThT4Jc4397oVC9Z9YZ7HZuJ5G4vyJr7
         HVmktIuSAmUTBXlZLOrJSbFyfA1WHcyDfTCQT1idCYlgQi+qqxyEmnKszirgiQrJpfPQ
         yZGPC2yhzV5YhOzNNh4GYJZ64Z847W2QC5lYFRXZ380cxicdxIXY23vnISSnp3rC/2Xv
         Xs7uNutPhuDaTBe4IKsCakYWg1n1586Hp4LiqYgbR4NCBitCXRYNt8ydV6BmpL6ZglEk
         zohDqqr7yJpsCCv4DTKv3T0ayAnrQ9PoccgU4RZ7Xrytx36jJLfqkRTGAUEVOx8roIHJ
         pXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249257; x=1750854057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJCOxXHVo1xvCRwBVR7i8ri/Hq2UMjfD/lprAcsfHqE=;
        b=h2u2ogUll11pA3MGXBWK21a09NJ1KhFpdZxLKbW9VjW/zxMnLpBM/akzpBn1OEBMOY
         7wyKcwU4teRBKu1W+A+De9ROeHCTH5t6Dc6qubUeFtpokJtiKY721NUpbtU8MZytO+Ni
         mJ5RFeRl1GWttvlqVIF1pSjifNS76q0ZH6XyjdyNLo+SfUl60GeFeS3Z/7bRwTom/f4J
         AsW9amAN/nfLBFw+ayl5RA23JswOgGA5Ugr9cosCGqNJawbwndHaIfZv2hWkxF+p885U
         1CyKhO6TAUoKxd4DSOqmiVO2OGUd1kU8ORTQGJoEbMfvpHLJk62pbxSmB5PUfmEo3tYx
         t3qw==
X-Forwarded-Encrypted: i=1; AJvYcCV18hnhQcqOWgqXu8o0vAT9fha0dIM99yYNw0isuzrCGzzXvcJtRfUfMfkQW3ZtfXf2yz12CkZE@vger.kernel.org, AJvYcCXko6V7if0QU+OYbWJ66+uf5ZQMfyq2/clns/8JACP8G/HIggfv7xK+XFQvh3/z0o3XeCSvLtgjFI4nGiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TfRai/57GgO8HDza1xFWSWg4aO4FBForMB1SdwGG5hqaeFHP
	YszPv4+DwcuIonze7vk9Y4ax2I4hAT4ygJaaFIbs7Yk+rVrVMGh56HYe
X-Gm-Gg: ASbGncvoX5mH+27Np6p4arqR3Cbx8iYRVfq81dSD7L2rYwr7ju6ON8q1ZjmuYqwRttk
	MbQwWG+dh5psuRGGaKVGAwnQ3+FiJ2ZAu7H25ObacFzXEfW7N/7gX9c8yx8ba5PErMeUBNjEgUT
	SEhL6uIo2U6FFAKyQr3SyrJpseTPtCyaGwvstcM6MtqLEyfwpjKIalDF1mLb3Lqwwa2Sjwz4ItM
	OOakTLUqgHzb90fqYq6Yp7watGVgec08dEZr51nf6s11tW3FiDFwxAjb+K2ojBKhxN8yW3EuweK
	D4/toePK5nldv3RJtTKDBQyTF69R5UpLAPMlRE3m8itJQ1VASlgFwK852od7Cz6vzhEltU2wECM
	t4h3cpj3K12dMIaV9NuP3miMo6yPivkF7Jf57mFzWGag=
X-Google-Smtp-Source: AGHT+IGrMKRd6JzreiglJoe7+dUDlEgWBSSJMKLHN6wu5zjoGH+5+ND/JVY7fkFZC9OLskp5z+ZNCQ==
X-Received: by 2002:a05:6512:3989:b0:553:543d:d996 with SMTP id 2adb3069b0e04-553b6f0f91bmr4855311e87.33.1750249256446;
        Wed, 18 Jun 2025 05:20:56 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1e0c73sm2254440e87.198.2025.06.18.05.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 05:20:55 -0700 (PDT)
Message-ID: <449c1edd-fb57-4ee6-849c-84e68c2aa5c5@gmail.com>
Date: Wed, 18 Jun 2025 15:20:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net-next: gianfar: Use
 device_get_named_child_node_count()
To: Simon Horman <horms@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <22ded703f447ecda728ec6d03e6ec5e7ae68019f.1750157720.git.mazziesaccount@gmail.com>
 <aFFVvjM4Dho863x2@black.fi.intel.com>
 <20250618104251.GD1699@horms.kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250618104251.GD1699@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/06/2025 13:42, Simon Horman wrote:
> On Tue, Jun 17, 2025 at 02:47:10PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 17, 2025 at 01:58:26PM +0300, Matti Vaittinen wrote:
>>> We can avoid open-coding the loop construct which counts firmware child
>>> nodes with a specific name by using the newly added
>>> device_get_named_child_node_count().
>>>
>>> The gianfar driver has such open-coded loop. Replace it with the
>>> device_get_child_node_count_named().
>>
>> Just a side note: The net-next is assumed to be in the square brackets, so when
>> you format patch, use something like
>>
>> 	git format-patch --subject-prefix="PATCH, net-next" ...
> 
> Hi Matti,
> 
> It looks like this patch has been marked as Changes Requested in patchwork.

Thanks for the heads-up. I don't really follow the patchwork.

> I assume because of Andy's comment above.
> 
> Could you address that and submit a v2?

Right. I'll re-spin with different subject.

Yours,
	-- Matti

