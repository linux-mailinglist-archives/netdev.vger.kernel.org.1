Return-Path: <netdev+bounces-176227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6A4A696AE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102367AC2BF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47121E9B17;
	Wed, 19 Mar 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpmxryDy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250371361
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405936; cv=none; b=fGO/fXw9dhrMgU7Oz59hs+42R3CrZG5YAEHP9UWr0VFDaK7TEoRObO8ZaJ/a+UU1hYm4Wsg+GFVZA3btQZ1dFlw3k075C445fiK2PjpqPxxpWVtqZBsn/w4Z67SOVNBKxRQHLzCx0e4QCQkud4x18ud06cuz1/6OcpTjBjXFqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405936; c=relaxed/simple;
	bh=OS750zsOhsm0zRWuj41DPLa6HTkZm4qf9YADRneYMmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU4yPxpDKTwd+dc5uRIRa1gwWccqgPu+dW1DPkVkEqDTzXDMzt/DRp/pOgAOYHjG5hbI+7nFZZXb/QLFhZbMo8elbGbJHGazjv99IrPj0rSRgNUTqkBSLENId5v43Bp0O1E2/i7KVE3hKgX0sjhgxBxj+h+QEGy7Rfqx/W+Azh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpmxryDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742405934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOucbCH8053ol58iaNfOQldT2PnQaQ3dzjaib8K+1rk=;
	b=PpmxryDykFPh6Q/JSVXSXWH0L8DFwGBsEnTJkkuU46TXikTvbj7OS8PFLY3ax4/SXYpGC5
	q3NBdgEmuy4tqJvJVbRihyxpECxrNUcf8viYgIES7PJVon58ulBjH9VjVvjbSQIzzvXRdh
	lIWecXKIU0NC8hbZ07wm1c7PlXJIESQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-59iDURuJPEu5dGapRmaRkg-1; Wed, 19 Mar 2025 13:38:53 -0400
X-MC-Unique: 59iDURuJPEu5dGapRmaRkg-1
X-Mimecast-MFC-AGG-ID: 59iDURuJPEu5dGapRmaRkg_1742405932
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d5f6689so4386491f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405931; x=1743010731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOucbCH8053ol58iaNfOQldT2PnQaQ3dzjaib8K+1rk=;
        b=ppZ0lPZyE/CsMvre6j9dlaDkRqn+RpbEs8WbhqHmUV08QEyW1GKRB3fBQQ2UWkN6e+
         42BvhVKNSgJrstyezCcB6jRH7LTXQ8kC3958hapMUbA2OGvkm+9hIcx0effUhkRgRQ35
         srsUInA6mW5yNT53J6Xpnbj6vX2lTAVdM/IKkIcrH7wUc5mcUF9qrzKZVAA7S5joyTou
         jMI1z/mF4Yw6otZza8xtU9XV2NpOCbvoeCCUIHYmJqQ+I1NxBtaxsAxiliEmfA3jRHl2
         NG24FoKJxvwIAiglRI1iUzotEVYHLQeGK7zyNops18zPlCr3HdXSB42G/UKsTtTeUXJK
         qVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg3u3u79wx6CAnddPeTZ50zYNwNki5eI7MmZRFcn4laQEGIbjLr1D7R+rzW1Tq/E9fqJee7Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjevjJWFaWbAaOt+hqAPjIjgn5Upb6ZsjxdR9sFthhbBGue3qP
	/vfQIOIv7ZM0u07HPyRJTIl7Kh25f4ECFIoY97Rwe+90/hJgqeT2sN7fRZsOKQ7Lm9AAU4ODJnY
	xMekgcSxmYIIbkKbW9/D0ri+dscS58I/45BGxvyH1RY9/VGZYRJejOp5UgbVTOA==
X-Gm-Gg: ASbGncsLnu1Gzz7YtVEvWTxHpCbpzOhM3TfrR+/Sn4NjMXsOo1wtmi7wBvIfJWnL+wO
	tgdstLi2IJpmPrhQtxLKq60YiWVJs3OcsJQnG7GR65PkXlTMFgyd6iZpwDmF9LcoT+ym/ohEc/v
	pYU12SkNl7K8Ws2/UxMhgX4C2XigehBeDtb88v/RnTcX1kEVVbV5yWd2wJ5fra3zVjz94yXvff9
	AsYJtRYbKc1Bn9V0cxRfbWngjzPjXHGwQQkCwAJG/mEzQ7WbvdITsRfwqLEsF+CspvT5LCzvoCD
	a16F8Ftzo1gi4TOjVEHcPRD0q267kg3mJGiOLs0on2Ae0Q==
X-Received: by 2002:a5d:5f84:0:b0:391:46a6:f0db with SMTP id ffacd0b85a97d-399795df888mr243970f8f.37.1742405931389;
        Wed, 19 Mar 2025 10:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHG5Tm2aTbhmmrCTzYClNAc5qOmeImMeQaQKe4i+YdSRkAsvTNxuFmNMQxghPMgkdbjpxDPA==
X-Received: by 2002:a5d:5f84:0:b0:391:46a6:f0db with SMTP id ffacd0b85a97d-399795df888mr243952f8f.37.1742405930965;
        Wed, 19 Mar 2025 10:38:50 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm21081012f8f.85.2025.03.19.10.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:38:50 -0700 (PDT)
Message-ID: <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>
Date: Wed, 19 Mar 2025 18:38:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 6:21 PM, Dan Carpenter wrote:
> This NULL check is unnecessary and can be removed.  It confuses
> Smatch static analysis tool because it makes Smatch think that
> xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> it creates a lot of false positives.  Remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I have wanted to remove this NULL check for a long time.  Someone
> said it could be done safely.  But please, please, review this
> carefully.

I think it's better if this patch goes first into the ipsec/xfrm tree,
so that hopefully it gets some serious testing before landing into net-next.

@Steffen, @Herber: could you please take this in your tree?

Thanks,

Paolo


