Return-Path: <netdev+bounces-139375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296529B1BF1
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 04:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE28A2821B0
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2217736;
	Sun, 27 Oct 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE2iGZ4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F281161;
	Sun, 27 Oct 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730000544; cv=none; b=R+FuRErJdl3p9p6NrqTNsgNp0dXjHGA0E0vZ2zL5y187o7RPDVN075pLVl1/VvK7GI1f5oINgDDcwPh/xnL9aNXsG4HZS/QdQqABzRZDWhyGYbB/lp5UTrF9sr9tSjpQEdRte6R0l5oWiq3d9vm2MJ6mSZz9Sv13X/WfruO/0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730000544; c=relaxed/simple;
	bh=PLSHHND2d40KhC9siurbcOPBZMvMXtbuAT4JDKPgKfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iINEAaXoQ4/Tb/TQ6MF4dNLWyd+nse5S9SaYAAtPGLFRdaPqF6t+lUWVHYO1L+zXfr3Sbmvo9SHbOSPwlqWyIT/M6Vcczv4R6+BQwQMELbynLSb5EIxq2NuaDK/MZ861Ft4VfqKIJINcOFhG7x9ghB+EeUbqsqOPIZLRxwgWW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE2iGZ4r; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2614126a12.0;
        Sat, 26 Oct 2024 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730000542; x=1730605342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VOnsH2rH5KtfMZxOhoCT0TD1o5zPwTQiLaCxfSmMgY=;
        b=RE2iGZ4rRQu74onNo0eLui4K4OzsPlpWHFHNQ8kH0EUsnnY7myJGUamuHrQJYAOWy1
         xqIoUZkEdvQ37TXLJgWrIzfbSadQFBWUIzfmAbTmWT74RYHV9kWyU8N/szHAOrNeOkCX
         GdOJRJZCKqmakllw8CdiESAjdIyuHPsaIJF2gTNGMm1tJ9dl+y4zrxQqYAe0v3DzWBTO
         iQkJMlzF7zUi1Et70C+YK7NL0RVLiZ+vyVHsNyt+jhwJtfY4TqmhD9FnENeSfNlQiVS0
         VHDEvAWVTbGJsPQVm52FtPds99AsV1EqSmqDMGvItjr6V0tkQ8BvVQ3bwtzWUD7Sp2pn
         mBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730000542; x=1730605342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VOnsH2rH5KtfMZxOhoCT0TD1o5zPwTQiLaCxfSmMgY=;
        b=lelyzbQirG3tydUBaLw1adPHNcitv8BDSkvKjxkQnlGRYXg6GYkWzdh/mlNyVzFEfu
         LmBglc2B2PeJFr/Es+M18QcL0Lsk/M83/oXtVbkAQg+vrqkHDjxPqydh2BmzFY9OhMDf
         bb9pGoTAbQMQ4jSBn2f5c4BcFjP+W2kr2gdect32X2487rdVK+X5J8lvbzK0PPscTeLw
         lodwY9KU5ebr8d/IoqeaOKaNV253DvYv+BHn/y3ioi1xxNV0jaWcVpZDkJfBWgPlljdJ
         xWgvwPoXuHgnc6kBlwtcVsc+BZ360GvBbJfL9P6qkKMT9S1XuVxDHLcbrw6A4dJn208F
         +3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWSe374iR2ZfnKKvjwYsDR91uaiEeAq1pTDliuSQaFqqenBmJ4MxinswCarAcghTDO+R6Ae4uMiD3JbAlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQ9UnX/AZgxNCRbgafK6kdjX6fpFsy+OSiO37WU2kyDFNw9oQ
	NYZd5lPCtwDdblBURmMjpXu7W1VuHH+hitB1En6mDMrciTtVdqlT
X-Google-Smtp-Source: AGHT+IGp/IRYQfDtNycrDto4jOncAVRMLfW/PWw3EZ3FspX7Ai2s54yeKWmAKI5lSt8PEVw6z8a2gg==
X-Received: by 2002:a05:6a21:458a:b0:1d5:388f:275c with SMTP id adf61e73a8af0-1d9a83d5faamr6172823637.20.1730000542173;
        Sat, 26 Oct 2024 20:42:22 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:f124:d73d:1b7f:fac6? ([2409:8a55:301b:e120:f124:d73d:1b7f:fac6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2c67sm3089550a12.69.2024.10.26.20.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 20:42:21 -0700 (PDT)
Message-ID: <e1b114c1-155b-4656-8705-4993edb06a2c@gmail.com>
Date: Sun, 27 Oct 2024 11:42:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, davem@davemloft.net,
 Yunsheng Lin <linyunsheng@huawei.com>, kuba@kernel.org, linux-mm@kvack.org,
 Paolo Abeni <pabeni@redhat.com>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
 <02d4971c-a906-44e8-b694-bd54a89cf671@gmail.com>
 <add10dd4-7f5d-4aa1-aa04-767590f944e0@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <add10dd4-7f5d-4aa1-aa04-767590f944e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Andrew

On 10/24/2024 5:05 PM, Paolo Abeni wrote:
> Hi,
> 
> I just noted MM maintainer and ML was not CC on the cover-letter (but
> they were on the relevant patches), adding them now.
> 
> On 10/19/24 10:27, Yunsheng Lin wrote:
>> On 10/19/2024 1:39 AM, Alexander Duyck wrote:
>>> So I still think this set should be split in half in order to make
>>> this easier to review. The ones I have provided a review-by for so far
>>> seem fine to me. I really think if you just submitted that batch first
>>> we can get that landed and let them stew in the kernel for a bit to
>>> make sure we didn't miss anything there.
>>
>> It makes sense to me too that it might be better to get those submitted
>> to get more testing if there is no more comment about it.
>>
>> I am guessing they should be targetting net-next tree to get more
>> testing as all the callers of page_frag API seem to be in the
>> networking, right?
>>
>> Hi, David, Jakub & Paolo
>> It would be good if those patches are just cherry-picked from this
>> patchset as those patches with 'Reviewed-by' tag seem to be applying
>> cleanly. Or any better suggestion here?
> 
> We can cherry pick the patches from the posted series, applying the
> review tags as needed, but we need an explicit ack from the mm
> maintainer, given the mentioned patches touch mostly such code.
> 
> I would like to avoid repeating a recent incident of unintentionally
> stepping on other subsystem toes.
> 
> @Andrew: are you ok with the above plan?

Are the above patches cherry-picked to net-next tree ok with you?
More specifically, they are patch 1, 2, 3, 4, 5, 6, 8 with at least
one 'Acked-by' or 'Reviewed-by' tag.

Or any better suggestion about the plan?

