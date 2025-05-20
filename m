Return-Path: <netdev+bounces-191923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8CABDE96
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C2A17E7BD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB924677D;
	Tue, 20 May 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DhN+4PCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4124C66C
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753177; cv=none; b=KYCaBFOGgC0yOWqMYzY6ombYBJ1P3sn6jNrcIrI7loETRJB4QSXbYV9p8R6omqWIyhEAxMlK4B6sBFHAk8FXPJN6o9pJpY+sZM7L61vsD3jdgzrCEnDvkZi/Jxq6IcTWVDP2PSbmBKwyiGEsYHWkNg6fXYNMPtFw8tdrUcBS6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753177; c=relaxed/simple;
	bh=tBpZ0/kobeFb/wXbvGgeE+EZeUv85g3hi2ioKvPgsHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7LuGs6y92McqIqbOAgYbBhPU/3PFaJ0Bgdgx6AGq5XXJx8g3xqQs9pkNnz5uniMqgi39Y2VQIjCwZG/y2KUEz9kWuCWTxYnSGj1osmiDzAHpZUNqXiLo+pk6+6iGm8RkNoJWiIZCi4OpWEAN0z79BBtKG4l0keoRkQ1cVTjcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DhN+4PCo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so1112858266b.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1747753174; x=1748357974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg5DdC4iMqSSER4zCMZwVTBTVih8D7aFm22aVmaEjZI=;
        b=DhN+4PCoYAqDfAl07irfw6g51NUhTSyZUa24RkW6t9+sNGiYUn8gZfENnZyTRVTe6W
         NSnaqvML/999hfuqZwQ/bUI3tQIUUw1YniEw4pK62F+SKHMnCTMOdfYpFvC9r/LupqlU
         Q8MbvUZOu5cs4D4whrlEuSgPojHp2Rmj2GCH7anQOGol1taV0N5pt9B0fgcX6P0RWQPY
         IU8zZcb0vnM4YHPxK/LSLhH2C2EiHNrUG1vo1/bgnAS7NxdRaBkyBC9lZtg4wtUxWdCV
         66AE5v+3xC1IvZ+Q9orlKrN1I95b5T35L59krRfMeeLj0GpAUTRFiyTIfsSBfxaPbhBn
         OWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753174; x=1748357974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg5DdC4iMqSSER4zCMZwVTBTVih8D7aFm22aVmaEjZI=;
        b=B11UMdqcuN/tFor92fiYBIkwSTpliYemCN/Z4MvOFVkQ9ilGZmudlAcI3mWdgM9BK6
         zx/tZVmz6dOn1uytedYYHnRD/96Pll3i/TbMWv8bEXVtsoYN8WsA6r8q2ab+yAY/5tSM
         Q6Ha/Je2O7qkv1KWU4MzKbcJ6UomA9idNd6nRq2qzyml8pbEbTnYqU5XTQgwPWXTp5Ja
         h0Ix/cDun3WRjpK5wd6EUL0yxYkF97umN+HJAqKaj+Yw8XGepD4DQTxYI++pOQzkFcHi
         pTADZA/p7eVRxXT1zSsR3b6Z++EJoxRgrhdOIuNtdKTtWyHN6nyfJUmn0NucA6a+qb8Q
         FYhA==
X-Gm-Message-State: AOJu0YyR5uNbgez/Rziewuscg0Zk89cqdQ6CYd2RmAhgQaFETsmIdkKp
	YtN8RPfiNwqHqcnrSeSMN+qhhmL7+UbxvNUux4e0dd+a0m1DB0qgRWaSDgMcPi7cXJk=
X-Gm-Gg: ASbGnct5sZIXvc8a8qisHoA//NMyCNR6aJKAHe4jNf00bb8+8rHohrw/e/t0X4J3Bza
	3N6BwJJdYcQJvbGpu8y5JsmQNzEFY3tDQ0Dt+QXH4+6W0QYWOaf9jaS3bnE62pdkl2/PTRA2LEE
	ciCauV2AykAzcg5EiHRvW8V4mvGw+DEChOipYj6yr4iUteh38XdlO2IV7gZtxWb1WLVXnL49Jvd
	Fm4AFPB2CXfF/C47i7Bp+fZvNOOMItxCa22J3wVeLzuLLDcmgQ1kIhRi/+ZqP6zWSFkxWDG1u9t
	2TSN4sd/2cSvVcb0tdE75vyeOHxF+04yxfwnF6MRmRocanIMqS8EgDdVs90hNlfyCzcEjOl4juR
	qEq+850DRRzvw7KEhAw==
X-Google-Smtp-Source: AGHT+IFUxnAmkx274h1RA9dFiQ0hmb3bCOunpIK9vknHa9Me54kXAozjGnAIanHbcOKiOjm4vP2I3A==
X-Received: by 2002:a17:907:960a:b0:ad3:e742:69ea with SMTP id a640c23a62f3a-ad52f86c635mr1358196566b.14.1747753174309;
        Tue, 20 May 2025 07:59:34 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cc1:c3d6:1a7c:1c1b? ([2620:10d:c092:500::4:4bc7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d43830esm749977366b.98.2025.05.20.07.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 07:59:34 -0700 (PDT)
Message-ID: <d6529b8d-dbca-408d-b28b-803b90a4d23b@davidwei.uk>
Date: Tue, 20 May 2025 15:59:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250519204130.3097027-4-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 13:41, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The commit under the Fixes tag below which updates the VNICs' RSS
> and MRU during .ndo_queue_start(), needs to be extended to cover any
> non-default RSS contexts which have their own VNICs.  Without this
> step, packets that are destined to a non-default RSS context may be
> dropped after .ndo_queue_start().
> 
> Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
> Reported-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: David Wei <dw@davidwei.uk>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 +++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 

Thanks for the fix.

Reviewed-by: David Wei <dw@davidwei.uk>

