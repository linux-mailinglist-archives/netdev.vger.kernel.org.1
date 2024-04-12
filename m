Return-Path: <netdev+bounces-87405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D398A2FE8
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDE81C20B14
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327484DFF;
	Fri, 12 Apr 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="amD/3pDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CC85639
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929992; cv=none; b=DkFhr+gqxiLvTCINdX8PuICEFGRjsr3hsGpKBXzWA7MCkd0Hb9tGOWFM0z/1Ao83RPXbFd8NKvYrGAJv1zaghio42w4QW9PmxBtWoNjkMlMzpBE5nYtV+4XU48y9k3WzZXliLtOaVj3vHCa69J/W+MGYx4xrUW6MAhYWI5jThhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929992; c=relaxed/simple;
	bh=6pvfq68lSJ5q+BtAZp1YFuC/Objnawn+Czcn3SJXKKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwWja0Y4lg6RIkYvBPzgv4l13s+qpUEI228hyOWIHPmA6zdGjg5FQ0OT7ZfvNlOqpRplGhoV8z9YFYmcVkW3DR34o+nyZppxw/XVu3K9yQfHmquzpKMIrCmTDe/qXT/ymGO7hD+vjX045bC34wlLAI3wue+hXJSknA6aCcDrBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=amD/3pDx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so8857771fa.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712929989; x=1713534789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbSm2EaYbd+BFnKn0WI3G1WWW9+znVkR1IcnM1cM99Q=;
        b=amD/3pDxpcMgv4I6mr036zXkTfa819epmmg6lkupI2utaFCr+mCHs5F4C5XbLq+SjS
         vRT1SNtitmGw1xryks6OqoacslWKeWTVE3VNhHtYECszz9K/DJwwKTnSX/4pdfD2dt70
         le8xC+0zXTMnTuamGBHNt45Oombcvwm5dezW2tDJMSdXnfV3I8kef1HmTYaaWf8uyQzY
         PyQuEKcJLwZsbV8H/0tRNQUuYzAvrprrSXriMPYeYRbOgsjva/zD235m+nQzuA0VCPuK
         mQto4I9ZZ2LXLbqYZiXY9fMqgWLtrPBNvbJqjBt21nkJkArGg5mm33H4+TpaGfpMcCXm
         p44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929989; x=1713534789;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbSm2EaYbd+BFnKn0WI3G1WWW9+znVkR1IcnM1cM99Q=;
        b=ki0+K5Pji+gwzN60MZTQN+1NR6owRpoJNNpvddckiT67tGEl4SyxsUL1teHztsYoA2
         DuwTH2DVYtLcVow/yws29JYFKMDSlfBYQnfp9BD5xBZSYERgT0mFNUEps3/EDQSTu0x3
         K5uM55Bsk+SyOlTYRjN457RoDQeT/e16jvacXz+XOCqO2suJTiA8Cu1yoaZzLU440gin
         eFykZbTVc09zXtPNqVyq5lRY95ReYXH+uYuHrDqI1C/2fy9t+grvuqnIw9/MOwQOYfCb
         2+MmwJXve9hv+X2y0x4IeWwyHXdIaqFn9F+XB1RnoyDKpQI1znhVfMWrx46h19klYcyR
         9Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfDa7r+UXUKIuTtoitW23oS7Bi5AeKbtGVN+8X5U97AryRUyk5etnmExuvX2J+2+SxKVENI7HaXW+4xt2P3yCjr+jjZlS
X-Gm-Message-State: AOJu0Yy96UWe2mIdOkRG/Gh0wznV8jg+W4ermdYQSXrN5w4g/n5RmSuk
	KwglIGrbTqoxhMNeuiQJLWLq028U4Ms1jtlMWXesvCQTVk92A4/obWZj6tcY2uo=
X-Google-Smtp-Source: AGHT+IGy3dE1gZc+pqhz/Y8kup1Qk8vj7/b3vSqVAwLT5IyvkoYsGrYTg4i/ka2MxFz4YWeNhIHRAw==
X-Received: by 2002:a2e:9153:0:b0:2d6:f69d:c74c with SMTP id q19-20020a2e9153000000b002d6f69dc74cmr1814989ljg.38.1712929988913;
        Fri, 12 Apr 2024 06:53:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:309f:895d:c00e:dad3? ([2a01:e0a:b41:c160:309f:895d:c00e:dad3])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b0033e7de97214sm4311568wro.40.2024.04.12.06.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:53:08 -0700 (PDT)
Message-ID: <2d527f86-da34-4025-8f9d-4865a20a55ff@6wind.com>
Date: Fri, 12 Apr 2024 15:53:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v10 2/3] xfrm: Add dir validation to "out" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 11/04/2024 à 11:42, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM output
> data lookup path. If the configured direction does not match the expected
> direction, out, increment the XfrmOutDirError counter and drop the packet
> to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmOutPolError         	2
> XfrmOutDirError         	2
After thinking a bit more to the naming, what about
LINUX_MIB_XFRMOUTSTATEDIRERROR / XfrmOutStateDirError ?

