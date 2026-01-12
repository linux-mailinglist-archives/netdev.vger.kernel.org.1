Return-Path: <netdev+bounces-248878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D944FD107C7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0828F300E154
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCBA306D36;
	Mon, 12 Jan 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqUgpN5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EA30B53E
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188580; cv=none; b=K/GSY7qJ3NAlWKDwnzdK6eMtxCk9Jw0WVFoO5AfbjvH25TSZcS0+Z16A8pqy/AEnJkMSrsLKD1LGB6oOkskFhP5wxYj0AfV0pwe6GYHVf0BzKyKfN9Qmlek9TxdPmiWUbbx8Txs0CtitxmFGBN653PyNh3YDtpTnOMJUQiol1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188580; c=relaxed/simple;
	bh=UUdVs8j7VA9m6zvW0rt4/EZwKeh88/gjMVptAIG6e2E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t8lKS0rXiviKXkKNOaZfN/gGOp3K8CFs8tV20nO2x3IMpKX2IhFTV8vyvHXn1LuKglLZTQsv3e7/9nFl+CbLYkZXgNTQYFYMJ8UuNx43f3iui66VAmpEM3WnKTzeZzRTsYbCsTjHcvl22d4pw4CQvBXRKfEbUPcyq+HkmTl6f3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqUgpN5D; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79028cb7f92so53019887b3.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768188578; x=1768793378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hoNUOG2P22leawShonh5OVWkCNHeP5L5yPB4VezeJw=;
        b=IqUgpN5DmM0i5sdmM3C2qRhMOMdlFGlCNaOIowJjdbU4IB954vEAPrcQ4SEwCeZY1W
         pq6glZGJbEvObx9kOCU3Cygnq1qLGvMoaMqRpi/jP2wztqXO+zOgrEMP3bSx7UuGTkDn
         buSZ2tM3iVavMWzMEF6VwVfJih6vKWCfIBH8RGxAqzY9YQLjeO4MQ8CpshMVzBw+Fmar
         /6/0rGa+N2YuMa3Kats1S3zi1/GwGWDep1q2/Elr4t/XfMWgCm66uQ6frcxbn1owtUg7
         Q0h26gbSaGvQNq5CNw84AcJqqAmdYCLnAqCbTYKB2/R83NR4E0u0zSQsxpA5P6iAUNlw
         PR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768188578; x=1768793378;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hoNUOG2P22leawShonh5OVWkCNHeP5L5yPB4VezeJw=;
        b=kCkRkefvYynR1xN7VhvtUF981orb8i759SVH8h92MZTAVmttRZoyBfvfL8AETiUYyl
         d4c/6tFEFFNNDQCVEo/WEYE7Mm3yrrI0PUvbZ7WwDIk1nhCcNmmTdyoWn5SKYYDefEwK
         qSemvyrTLzNRc0t9749e2YVYXHM7DOM3jWlntntvOs5Uptnt1FUP8EOWvv48Iv6c75ow
         zgOZaS4I6ZU6P1PMFuH0SdwmC34hLJX3MpNaQnC6GhfpD7uxRmyO/DqokV96aE2kEkRi
         RkBNRG01L37ROFs910YgJ3zsSJmZ3lqJuNVqiJ5fZpKClWrSGH14A/3Zvu93NaelDCyS
         vhaw==
X-Forwarded-Encrypted: i=1; AJvYcCWIsFjKnw+EDvzQjxjK8gQJ9P0NdjurhG/i9vHaxyfMbyrHIeZZFgZFl4ltyeAzYeEvhHhEMAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZEV5AdBhzPbSx6tmo7Dzl8EP0ZSP7FPJe2JY1sLNfY0GFy3a
	kxoORKePytlZ9qzcdhAElRtNNHd/9EbO7nuI1vxX8C+OY7RyGo3+Ij3N
X-Gm-Gg: AY/fxX5fYrRkh+IwqZiI3jv+Ha2BO56QqFBAw+7Y6+lA6M5DjO891SLJ0O1sszIS5+X
	+L5oUZwKFqDlHRgwz35N+nGJHJFKXMH2bfbOXw0pZqT/Kio8Kmkjp9WzLdCB9Zj7yl+zQUWjvj7
	+canyapvMkel4KCUrSrot9LKkCyaMSIu78kb5nPPA9Hiy00E4bJGxO4pmRKXhxWeJAD+K/ro+lK
	0dpvyYjUQ9OX7/iiRjXjDSqKPF1sJClotkWBVYOQnIfZvCMxLcqL2dmRQr9H5S5dznmUVNL043/
	yGIeUALzIheU729DuwtN3cb4qoLI5FPEp7S6Q8V5UspeTjGZkTR46dEqo8ShW7msc9Oyjzl4U5r
	hCxZ0/LhbOvFCS3KtthhcHk5QVA+SbM+mLkPqpheMtXWCaH0GiOJoCKXvbPnk0eh7NIzqnE+Nod
	HGOUYj8deMdVqXEn6D5i8dUSXp3JatBg1vUBs3eAaOaz91OPycRu1gBPqq36I=
X-Google-Smtp-Source: AGHT+IEmPrppbEVxfjylMWJptXyBZbSTaF2447Z9XdxfTQFcxgt5gPHDheeSQ2GIZkCMgGzZ/IrBOQ==
X-Received: by 2002:a05:690c:698e:b0:786:6179:1a47 with SMTP id 00721157ae682-790b57fdfccmr129020517b3.44.1768188578084;
        Sun, 11 Jan 2026 19:29:38 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6a4d00sm65224337b3.41.2026.01.11.19.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:29:37 -0800 (PST)
Date: Sun, 11 Jan 2026 22:29:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
In-Reply-To: <20260111171658.179286-3-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-3-gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling
 for high CPU numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
> 0xfff0, only allowing CPUs 0-3.
> 
> Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
> 0-15.
> 
> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Should go to net instead of net-next?

Reviewed-by: Willem de Bruijn <willemb@google.com> 

