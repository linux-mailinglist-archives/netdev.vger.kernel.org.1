Return-Path: <netdev+bounces-126908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27387972DB7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40E72873F5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306D188CC1;
	Tue, 10 Sep 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPhK6pBu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7192188CC9
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960811; cv=none; b=D2rYQyfIivDar5nH+wqJJGpQPkL6x8HWL48pTZhHnTIe+ywYWZGuaXJyp4TiygkbwHI1KCoQVwEb3fflZNCVa1nblrV0Hs02OJdcwtjaeVXje/kjuRIAzFHfatCVl9asdyrThD6R0BvuppCo8mSr245gBiA8nAgILtXejdlFML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960811; c=relaxed/simple;
	bh=kxzG+EJWs4MXOnw4u/Te8FXFUsnv/LSVEyR7zW9Nogs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioQ/OTxzKm8gml1T1SrSItJWDQj6h9homVVxqPAB19DHeswfxSXSDaYnULvz98QI3MoQvg1dMQPDOsng0lxUPMPWgdFKcNb/BA/jCmrKuflglOlKVWesGnGsiSkXdOWNWN9Cof0JEYPb1uzn/etJ5EQson2Qio5ni4sswttrPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPhK6pBu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725960808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA9yTxibZRmjIrnp/SwQaGkc+TSrqbFe8n4AEI94xB8=;
	b=SPhK6pBuompbknrOGNRuccR5KNLy4PGMmzfB4VKqJqNmjZleHRMMdRwDD93cyFlq2Znz47
	m7qNVmxPHQ7tFUO6YeMaM9+M1srevppmvYMf/bSHLLyqlB0tZJzjZ9Nasvgul31WszLykt
	e5Tgq3rIUEZh7xTUFGn91Lu1uYCvngI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-VdhY0bZ9NeKCKV0V3UPgbw-1; Tue, 10 Sep 2024 05:33:27 -0400
X-MC-Unique: VdhY0bZ9NeKCKV0V3UPgbw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so12986585e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960806; x=1726565606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JA9yTxibZRmjIrnp/SwQaGkc+TSrqbFe8n4AEI94xB8=;
        b=RqF1Eg4Nnh5ttkRNjASi8T2xY7ckvDzCRFG0HvitRyHGAnL/cFBtGKl/mhD/t3BURz
         aIs7vD2jeJZPhfTltCVBwWBD5+AhLT4gVzQBHu9r5sTvMbyUJrptKR6OvdZjdzJw6Mnb
         EDPruYAiYOlP0HfB3Qa7HOJ1QN7l0vTSOZDqSgtonA116P9V6zhc6g4Ey+mHx4Pq93wz
         yFwrS8rxm5Bi2t4JsZfrhQ5gE9cwyBEnbkidSo2c1ZhMkbJkxuYxtr8mgfsHIyewVzyr
         CfNMO9I3eJu7ja7V9/cAVtHCHpa3IVV2y+2GbCdCVtLVt4crsqwrfmVq4r94IHRo7PAb
         ttGg==
X-Forwarded-Encrypted: i=1; AJvYcCXCS+DjGKwKw7yM4L0vo5CaTThLcwayw+p8A1lgIwsRpptm1yjDuZZIPAtbw8+gWAGbkMtJgUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32RoF5PCUq2Ao1UIWS6mR3I9PvaiN3IInxW2pdvSLPMGCKkEl
	eH78ufVqUgEFeS77aK15vP6EXmO/fnxbUICGohS+0D8ghBB7ChLWVKaz2IIjOUEU4hWloDTjIMK
	zVJ81PRVBPzB/JgdhSyDJiXpVKx1vegXboCweHPJTFcVJMqoxCrCzZT6QfsIz4uVe
X-Received: by 2002:a05:6000:144e:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-378a8a7aabemr1756098f8f.22.1725960805979;
        Tue, 10 Sep 2024 02:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIx0MEbsARr5ozF290Z4+XwTDzVUGk8hr81Yxop2HvDZXrncF5iTlTUBjlIz7AjxiKEBqk9g==
X-Received: by 2002:a05:6000:144e:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-378a8a7aabemr1756076f8f.22.1725960805457;
        Tue, 10 Sep 2024 02:33:25 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb81611sm106225555e9.32.2024.09.10.02.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:33:25 -0700 (PDT)
Message-ID: <a914a5a0-5726-40dc-b5cc-4f5924059ced@redhat.com>
Date: Tue, 10 Sep 2024 11:33:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 1/4] octeontx2-pf: Define common API for HW
 resources configuration
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, jiri@resnulli.us,
 edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com
References: <20240905094935.26271-1-gakula@marvell.com>
 <20240905094935.26271-2-gakula@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905094935.26271-2-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 11:49, Geetha sowjanya wrote:
> Define new API "otx2_init_rsrc" and move the HW blocks
> NIX/NPA resources configuration code under this API. So, that
> it can be used by the RVU representor driver that has similar
> resources of RVU NIC.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

For future memory: Jiri gave his ack on v1, and I don't see any changes 
here WRT such version: you should have included his ack in the tag area.

You should have included also in case of minor modification.

You should include a changelog in each patch incrementally describing 
the modification from previous revision, to help the reviews.

Thanks,

Paolo


