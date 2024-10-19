Return-Path: <netdev+bounces-137193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A64729A4BFA
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F89B22443
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4A1DE4CE;
	Sat, 19 Oct 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz00AZMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8271CC8B8;
	Sat, 19 Oct 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326434; cv=none; b=qTCYbgaaHGSlUahwSqSU1FzpP5zTLCIdD/Eni0V86Kw9V38AJmyOqH1G8kjX/4cPycxrAlTu/XGl5R6fDSwEtJhpVGfdiBvzeeAJs3q9EpogTjZKrr8gcVMiReu8+GFrwxNNAF1qMKD/1SgVg90qRRLxX8bWlh5iyABI3S05dcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326434; c=relaxed/simple;
	bh=YU8l1yQVcCfVXThq5HBg6xC4Z8lafPdUM13HNBFU0qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ia2oHsGFldu+VzJPLbKgknrLiLZEkLAurFyEsb7U5ETc9UOtivXKKiHqmsKBcChIF6wtukl61MkcGakMTwDCUl8XKjPh8c3gVPhL6YSA8wJCCwvnCPG8C3EzYl3QPBfMgc1fp7NFh5edvPObsWCKfxdUbOVki1N5e/FEd8gR+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz00AZMr; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71e579abb99so2089918b3a.2;
        Sat, 19 Oct 2024 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729326431; x=1729931231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9dYJZYQUT2bepQOyTdnPLW1sKkKzv8ZjD7fvnokyTQ=;
        b=Kz00AZMrwj4QBsb5RYAgXqt0fLnvgx/D+hmFMQX0FDgIpJzl3cT7wD3Xk+6aWhQDry
         mhTAERhDsQtYmm39p1blfcDUbuCEsOj1mmY7OUh31E2Q72c4/DFQqfyRVviDjR+RYwTE
         Bwq0cp1cPbOHi7i9ig6kAIXisOTrtZwZ03aRkCYk85pQW8z5I/vjsfH15ZiypkzdCG6Q
         8GRrQ5e/zru8Cdd74Qf9HDtNwe9k5z4iR1gqmMwiqSUdBRvTda1fUE3nraEQ9VeDq0dH
         yWswEAnCl6Ty7e5IhndfTr/3D6FyrAQkFIUgsOVjkOHz+kbrLlzoA9iYvqgf/6LBLX0+
         fU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729326431; x=1729931231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9dYJZYQUT2bepQOyTdnPLW1sKkKzv8ZjD7fvnokyTQ=;
        b=bUFWiBSuzTsmoYmG4EiPLbo8OI6kuHfEQGo2z3RYopmy9E53NhSjG1A8L3FdOvA0e2
         GrZr1mScQM1JLTBrbHDgch74mszOgymmBcqjw0Nm3TPdH2lkURHXY6rDbGY3dQYYbrh9
         l+mmDTYIp/XXSAdFDU0hrf+IbYLotHxcuCEF5/BlQ5Pp42Z0nLP9NIu2Ub7sQ38IBGmZ
         xtm7fCaS73UiG+kkOxl3p/sgJAF9tB9QySRDUjh3BQGnuHg7chIqEUyHAi0CgQkrjCfH
         T+uYNSQ36EpChcqD48/hIeFGsvRHMUjw4/+a/1OLnfWbvy5BgqdQvWfTXR0PERoYdZLZ
         SuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaEByvNrdcHHpcGomlJ9k88eV4li20B7lD9Wk4IgkCKkglg5KK7EPb6c8u4NFIdPrgA9P1Ld5zqjAWPCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhjv//CLwvesv4Q17W7MF10QyTHd+SeUw+pgp2NRBQNu8aS1VH
	LtS0+nygTG5seD3BSYP7oUomegvtSFLOHcdRU3HVI2MLF9jmufQJSJ+iTO9qSn4=
X-Google-Smtp-Source: AGHT+IFbhzcJedBJ14xj6QkKRaV/j7vG3UQL6Q9aiNR6mgDqJvneNyFHfLrZFdw8hcgKMggALUWMjw==
X-Received: by 2002:a05:6a00:124d:b0:71e:4fe4:282e with SMTP id d2e1a72fcca58-71ea335a7c8mr7691399b3a.28.1729326431076;
        Sat, 19 Oct 2024 01:27:11 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:79c0:453d:47b6:bbf5? ([2409:8a55:301b:e120:79c0:453d:47b6:bbf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345ac93sm2734024b3a.170.2024.10.19.01.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 01:27:10 -0700 (PDT)
Message-ID: <02d4971c-a906-44e8-b694-bd54a89cf671@gmail.com>
Date: Sat, 19 Oct 2024 16:27:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2024 1:39 AM, Alexander Duyck wrote:
>>
> 
> So I still think this set should be split in half in order to make
> this easier to review. The ones I have provided a review-by for so far
> seem fine to me. I really think if you just submitted that batch first
> we can get that landed and let them stew in the kernel for a bit to
> make sure we didn't miss anything there.

It makes sense to me too that it might be better to get those submitted
to get more testing if there is no more comment about it.

I am guessing they should be targetting net-next tree to get more
testing as all the callers of page_frag API seem to be in the
networking, right?

Hi, David, Jakub & Paolo
It would be good if those patches are just cherry-picked from this
patchset as those patches with 'Reviewed-by' tag seem to be applying
cleanly. Or any better suggestion here?

> 
> As far as the others there is a bunch there for me to try and chew
> through. A bunch of that is stuff not related necessarily to my
> version of the page frag stuff that I did so merging the two is a bit
> less obvious to me. The one thing I am wondering about is the behavior
> for why we are pulling apart the logic with this "commit" approach
> that is deferring the offset update which seems to have to happen
> unless we need to abort.

Let's discuss that in patch 7.

> 
> My review time is going to be limited for the next several weeks. As
> such I will likely not be able to get to a review until Friday or
> Saturday each week so sending out updates faster than that will not
> get you any additional reviews from me.

Thanks for the time reviewing and reminding about the above.
It makes sense to have more time to have more reviewing as long as we
are making productive progress.

> 
> Thanks,
> 
> - Alex
> 


