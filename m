Return-Path: <netdev+bounces-134559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C599A1FB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3813EB263D0
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774220B1E9;
	Fri, 11 Oct 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvwLUaFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F919EEC7
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643894; cv=none; b=P/LT7Gziux/3/6X7pDt77RQei80h+OA2jqzmozcJ77s5bPRM+lnJSBQra/mifV8+jdeCCSFjZ8L8PY4lBKsGe7qnzDuGSrNoSBHnBsNc8boSI1g+CxzihhJ/2GcsruXxO6tF2RZC0gJVZ7DgBQqhNJDN5S8TpcVW8WJVE1usZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643894; c=relaxed/simple;
	bh=QCSGMXDPd7atkSFYrkbwAUYkVJrHSz4hspvRl6ksyDY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WwIwQRVVFY5UYo0YFfk7rJMYtW6F8bbSvalxvVzMXcSdnWFuS6mIyXtTAqQg+meUez0oARUC+jxunemNtHwhlrtD03iUeJP5MywdPBZnOFs4HXEn3ufhnSjAfnO1A8diOY3BMzzI2HfbXV/LzGQJ+P61EM3Nsqn+jHB5rzDkhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvwLUaFX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4612da0fso1516210f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643891; x=1729248691; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCSGMXDPd7atkSFYrkbwAUYkVJrHSz4hspvRl6ksyDY=;
        b=FvwLUaFX6r1OkQefKDEX5nFh3mQ2yGzu8zI/wrVhKu5K1XeWuP+hMa6WTnUF1V4AnQ
         4zd+cA8PjOAQq+17TSFuTlYJOG7op1uolpKC7o6BALvcDorbL1IZ3VBzk/Mvxx4hhuKC
         /0Yjenic91az7ETbFWCrHI/dd1L58j5x+I/CyIeSdh+9y+hRbWorzyemf9cxbSKFyp1i
         sjU4FObMiR1O3llXrasDKNpwugXQH70qkfilY19fXWUgx8uGwmMzBgDB8cwV+RiY41Nv
         D+NFdcCE9DPzn/uZEh4VpCqlCQbeGZHjdHQ1FtydnhSk6jrr56wo30pMm52InbUh8kD1
         /MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643891; x=1729248691;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCSGMXDPd7atkSFYrkbwAUYkVJrHSz4hspvRl6ksyDY=;
        b=BRNCH1H3qK9OLyRkLsMsp9R2V9CTcu4245bjSj1aW43AV4fiv99hjsOmFPys84a1Dv
         yLjW7onypGspg8VurGfpmOu1AWGCMRjWEjoIoIjrZYLd/B8Hs4NrdttCEz7VHG6UmQve
         OHVSvfaRAorwOtrB9/0/8C9nHnsqIfvy11kEYFE75dPMmbwR8k3Aub2jjH7sOrQkMX6R
         E+e/qNBBmbPtfpQpQKgHf5PZ0guhpqK/zQ1HMdDmtK5Vv1EPl0Ps7pq9CEx6d/ormHJP
         bZR5bL5gYbr6TzfoQ5D/XQZxazklPMBG3lt6DrHopa3MTOYXfAAUTrZPjFCMEF5qHK1l
         DfNA==
X-Forwarded-Encrypted: i=1; AJvYcCVCaM0yr6VFaxoEbwDUzA4mqrYf62yDzrq2TZDf1eUh1N69Xv0GwO6+bjic7oqEg5WfGs1rFc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJ6x+/8aADBxuVr4j3LANqKBYqF6qQGJJrRsB9nzlsLEcbUoh
	GOqCW3q2ARGOkI8GIrzHlDCRFgD3g6nUQBTjUFNU7MDr9nUVj2detYrPHw==
X-Google-Smtp-Source: AGHT+IF+innIRCMkFCzmqkjIUTiCP8zVEJyxg46luilSu7tNrJ8SFSdZkLW3CKeN1wgmaJ9vcjPYBw==
X-Received: by 2002:a05:6000:128f:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-37d55304616mr1728406f8f.33.1728643890551;
        Fri, 11 Oct 2024 03:51:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c9b8:df99:9ba5:b7d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8a8esm3628244f8f.19.2024.10.11.03.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:51:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next] tools: ynl-gen: refactor check validation for
 TypeBinary
In-Reply-To: <20241007155311.1193382-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 7 Oct 2024 08:53:11 -0700")
Date: Tue, 08 Oct 2024 09:51:16 +0100
Message-ID: <m2jzejq8or.fsf@gmail.com>
References: <20241007155311.1193382-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We only support a single check at a time for TypeBinary.
> Refactor the code to cover 'exact-len' and make adding
> new checks easier.
>
> Link: https://lore.kernel.org/20241004063855.1a693dd1@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

