Return-Path: <netdev+bounces-199454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EDAE05F1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B8916FEF6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B14235055;
	Thu, 19 Jun 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS8At6+x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6472AEE1
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336444; cv=none; b=kYfh3s5vy/Gz+K0VLalLWoP/gDboYklyl89guhJk45lq36QOOY2nyL8hjT2Xb67qdTbLttULhtdzntAOFRek0O0cInRQi0iZb2AQk0jD61AU92xnWvhaqDg7WLN0vXbAU+Oaz81hr1sAwnXJbR99fL9LchHE6nSgpxDAVZ9O9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336444; c=relaxed/simple;
	bh=qCVzeMxs9EUMICrVztaKwX4iPfq+eDFM9NLstX8U5jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGxXT+iyipcO05mJYsmGZUYX+TKkrOMSf4uW9IoU5boXhrDxT0ixQ4cgKApaIo9D93vVw7bQSPKkA6q0pDm9xKHNRM9K4VAla2nmkvpHVCVX8W4uRCUyAkp43O1I2ArRX0Dxg5o7moKiAwOpy4beEgZ01uPSF0WioyTIN18rytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS8At6+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750336442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Cj1ldVACYBAymC7ThfIa2OeEXa/8p6EImVP/ZavmP8=;
	b=VS8At6+xMuElywOgqk0t4f/owR5KDa4rDGGHxt4pXk8D0M23AgNZLR5YgBf15aAXisxdf8
	V6Wgk5qrHVt56RAx0QhW57+MX+edFXA7t6DVqPk5yR+EFhi+xoyQvZTnHNKK8vTym5dzrM
	L0Xdi5GlfzVQ5r7ttJcElpc8n3K//H0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ooSnDYlEMBuaNvQQXg26yw-1; Thu, 19 Jun 2025 08:34:01 -0400
X-MC-Unique: ooSnDYlEMBuaNvQQXg26yw-1
X-Mimecast-MFC-AGG-ID: ooSnDYlEMBuaNvQQXg26yw_1750336440
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so372364f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750336440; x=1750941240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cj1ldVACYBAymC7ThfIa2OeEXa/8p6EImVP/ZavmP8=;
        b=mhqNT4x0q4kuimg5JP6FwmvDm66o24YLnNfmzYSylXk6pVlIcgvQGk2N+zHAPQdeP7
         zjuc8dSLlV+O4RskRrImrJdV3ukVSC571+n2U0+B1PBqmZK2UuokcvIN16+pC4238IVD
         UBtHcgUqK8NGzvuwCysAdVrg6n9sPqaJASyXJvf6WRsTYAWrU1vlELF5bdIKNWSQaOPs
         pxMjQgFWpseFr9eMwLvfpleTkQJFpysXA5m3p+QGfJEil3XMB9CBCLXJrX+B8NlMZ/x6
         b7E3vfnT7FWg1rpOKggqyjMadUyDZzhKUZUpGaa8TCxijGqM/spXYAeVgikfULfVdsXM
         qL7g==
X-Forwarded-Encrypted: i=1; AJvYcCVqmBudkGEU1HEyqHgO/sC4CkPoiasit6oAS8xYlR6Cg9Egunr1zZVT6yVzfTc40TuauFhWY+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr71qvWhjcPAdGfHHKwTemJmL1l4d6SaUl/18aVhg8WjraqI4X
	myyrewyh6Y4Hu0xApptXmbcIQw9VxPtBrYRayH7FLJpvOXay6dFs4X+Hbf6cpaI+JB08kmP8PP9
	N5OS7PMY5xnPjPv2nHH+wDfYAk47q3yWkkF9fJY26nha0W+rIIIiBN/5u3g==
X-Gm-Gg: ASbGncu0PrHKl3ml3uO4Ts6SsKHhXbgf8K1nyI0Shyi7GBaurTQNvgl5E+gJuW0/j41
	MMGo8CdA9a1sIbT/ctDWb6tN+kyAqYedsjBr+ao48Dmcuyw1MzJd2sbqHBBMbguEBOTixIOQCBA
	4DoP7b2w0gnErgNMnkTb6GWZRbvOfabr812mhSPMzT6j0kN9qFqxKNAqf/GyZbOiJqVQ4Phxhht
	9o1Nhdxq9xD4fBrgihhCGSL/+QiAD3pz7uEHjzJ8IN3iez9W3wdr+Y0w6LW74Ngrg0T78QWhUEh
	CcEUzTikUy8YWTgGXlYIa+5OtmLP0w==
X-Received: by 2002:a05:6000:2504:b0:3a5:34d9:63aa with SMTP id ffacd0b85a97d-3a572e9ece4mr18975332f8f.59.1750336439635;
        Thu, 19 Jun 2025 05:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFT2e1H5dbj8q87tG7qDSztfLfWKUGSbWUwhvCeJEju3yrb7L+oeNDMap2oYmhsnuYHKStbQ==
X-Received: by 2002:a05:6000:2504:b0:3a5:34d9:63aa with SMTP id ffacd0b85a97d-3a572e9ece4mr18975312f8f.59.1750336439224;
        Thu, 19 Jun 2025 05:33:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54af6sm19218163f8f.6.2025.06.19.05.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 05:33:57 -0700 (PDT)
Message-ID: <c84e2303-2240-4bd7-a0d9-2e1d4d0c0677@redhat.com>
Date: Thu, 19 Jun 2025 14:33:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 06/15] ipv6: mcast: Don't hold RTNL for
 IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
References: <20250616233417.1153427-1-kuni1840@gmail.com>
 <20250616233417.1153427-7-kuni1840@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616233417.1153427-7-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 1:28 AM, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock(),
> and only __dev_get_by_index() requires RTNL.
> 
> Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
> MCAST_JOIN_GROUP.
> 
> Note that when we fetch dev from rt6_lookup(), we can call dev_hold()
> safely for rt->dst.dev as it already holds refcnt for the dev if exists.

I'm not 110% sure it's safe. AFAICS a racing dst_dev_put() could
potentially release the rt->dst reference concurrently???
The race looks quite orthogonal to the patchset, but double-checking I'm
not missing anything.

/P


