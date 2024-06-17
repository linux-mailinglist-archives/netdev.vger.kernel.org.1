Return-Path: <netdev+bounces-104275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D190BCEA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 23:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AD1C21B36
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2F18C321;
	Mon, 17 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V0nJpdrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233C16FF50
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659453; cv=none; b=U5F9xffadp+MxGB7ix/ae+Uu0L2HfBQNqF2cyNYGULajRVz/Qz3WjgqZFU02t8eJoCngwRt7KKtMSXhf5r6qXT1tFiUz9OGHZ8JNDzFtonAIEJ0wF5bbegkXAUr1/HMpFDctEeNao9XO8uclTJOIB3wzu8rfhAOxnRjLndTcgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659453; c=relaxed/simple;
	bh=pk2GkvQ0+iF0GntaVcn37GDF5GB1+6P9lcoFD//Muvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQ9FJUjAYIek4LOl3AiZ+gllojN0hWho1qUJfaFgFUVNFBmL8BFP0t0W2K0NvTNQtE3SSZZIOjuwCPMt3WQToYFn9VZXnFHnCiyVefA8ZdqYxPzhHvJbDsHqowRaD2vieNNikYVkBZdaP2tV1CEBoEHI9czeqXLU2EoUBjlNF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=V0nJpdrD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f1691b18fso3859607f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1718659449; x=1719264249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wlerDEB2wowwGZlFmg2no29koAv0hVPY8yCH9sQIci0=;
        b=V0nJpdrDaCPdDtZlrGMEnI/v0lA+rtnUhBQKNVQYypsinBnZKgQG7p0Z24wpVX2KTR
         LoeUZvAZSq0P7BmFvxjvA0ZxlzmWRTZqoKExDp5KRf+uhlRbbLr80wtppS2/XDnw0hpK
         h+66L4R+n6HtAkMZwWOGqVqvfDG4J9J5gKPFxM2bUN2VeA74c/vYcLpVuvQ0lzXxemzI
         Cot486w7P7lbGfUNaEBQetZscix+60k8vGSpnSUopDfgZ76n/eLBeVVLewRV9CHIMSDo
         +3J0Cq/a8Pob/KUO7EbVknqMybYbOHsOxMQ7dDNGdDFewcFNb1ojFrCevYb77VN55E+I
         TpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718659449; x=1719264249;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlerDEB2wowwGZlFmg2no29koAv0hVPY8yCH9sQIci0=;
        b=tiC9c/Gdkpl+PLopaUYlIfMNa1wGYfNV+HU/o/CqGKNqvlBKI9gOfj/SY7qF2D0jcT
         1sEl+oqKaOL3xdOr4qyYdffC/dAOtMioFlZDeypZpJ0XJ3oCK2qEt+5DkDxmGYaFiEpd
         rWtrzTT7FJwZinmZMuBtOy3g1cMEopbQJHsiDq3vcbYFp/LarySm/ZJDUuUetQk19sxm
         /ABEUAKKQOKFlsijbAaNMS4QzzsoL5uk5UsI2OYauCTyepbwDR1fPn8jyU0wjrdPdai1
         PWd7EYFmSs7Xxd/NwIY/RFma0+V5/hSNoypMbHJs8kjITQpzU+PmC0sLHRiOZ8TcAnm7
         cTCg==
X-Forwarded-Encrypted: i=1; AJvYcCWN8ZeFPx7RDvPbk1midSmtnD7FuoPI5Jn2VKQhLcJmStmG9KPmdbw/i1LSpk+uGUUceiYcZwLF2LjqO3poRoecyKHvMWLs
X-Gm-Message-State: AOJu0YxV/X1mCKCByP+epYvnjmghTGXXdMDAEnUfUTBm+/fGQBslEm4v
	69boiSeAtS18sigUEf1sEYKFJXOowJPcslftgNFca5oXhpYAomU2vllOqNG6oaELkaZtyx8Qsst
	d
X-Google-Smtp-Source: AGHT+IEerBsuaYtElWOmInmZ92IL7Ll0hWKrxFKRDfZOEgU1sOFElLkVpU6Yf84xEnawxyhLABjWJQ==
X-Received: by 2002:a5d:558c:0:b0:35f:283e:dae2 with SMTP id ffacd0b85a97d-3607a7d98ecmr8447600f8f.48.1718659449180;
        Mon, 17 Jun 2024 14:24:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:3164:3835:7a95:54e9? ([2a01:e0a:b41:c160:3164:3835:7a95:54e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609df3e7f1sm993807f8f.109.2024.06.17.14.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 14:24:08 -0700 (PDT)
Message-ID: <25c62577-5f94-4721-aacb-d50fb49fde18@6wind.com>
Date: Mon, 17 Jun 2024 23:24:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
To: Christian Hopps <chopps@chopps.org>
Cc: Antony Antony <antony@phenome.org>, devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
References: <20240520214255.2590923-1-chopps@chopps.org>
 <Zk-ZEzFmC7zciKCu@Antony2201.local> <m2cypc3x46.fsf@ja.int.chopps.org>
 <ZlB_eSJKUKwJ2ElP@Antony2201.local> <m28qzz4dk5.fsf@ja.int.chopps.org>
 <m24jam4egz.fsf@ja.int.chopps.org> <ZmftmT08cF6UTMZJ@Antony2201.local>
 <BC54C211-FD19-4105-833C-BB3B297B9BD5@chopps.org>
 <9f3c7667-f5ad-48b2-9f30-454c30d6a933@6wind.com>
 <993B1CDA-DC03-4FA3-BC65-BB82D0A0B328@chopps.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <993B1CDA-DC03-4FA3-BC65-BB82D0A0B328@chopps.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/06/2024 à 18:05, Christian Hopps a écrit :
> 
> 
>> On Jun 17, 2024, at 11:39 AM, Nicolas Dichtel via Devel <devel@linux-ipsec.org> wrote:
>>
>> Le 17/06/2024 à 17:17, Christian Hopps via Devel a écrit :
>>> Very sorry, it appears that when I did git history cleanup, the fix for the dont-frag toobig case was removed. I will get the fix restored and new patch posted.
>> Please, don't top-post.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n338
> 
> Yes, sorry about that, I normally don’t but was replying from a hospital bed — things are a bit jumbled currently. :)
I didn't know that ;-)
I wish you a quick recovery.

Good luck,
Nicolas

