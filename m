Return-Path: <netdev+bounces-83721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28C89387E
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AF4281689
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E78C1E;
	Mon,  1 Apr 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbUTHQio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D18BF0
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954472; cv=none; b=RG8TN0s2+d9Ahxl3ZvzNXjsvJI/0BjO7nRNwBPHlktXAtya9i24cFXRRwzVsNpgfRYlUHMMubTbe79kg7+XTTKQQFd0JTU3U+S74de89mSYnj7Y0ot8ZmDumR46MlOcYrTY2J1BbVFaZ7gsrRYAkBn9thl1vFrMj9FYYNmE64qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954472; c=relaxed/simple;
	bh=hByuSLBCnuOVtmhAskM8G1u47JQv+PH0hneK0bNGe3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beC336wp5sD9pP7OOgu5li4objAEs+FjIydkQYetPn1FQ2uS+tG3qH6rJhilIl1kdSz7hGcl2t+aLnFqbxMDmEJCAwNfKZxpuMOWlDlX9/tP5kUi3lpLDRmQvrrCQHrf4cczL5e1qiFDRPEj3ry7NhiXoFcMcXzp2aXzcX2Jmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbUTHQio; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341730bfc46so2769476f8f.3
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711954469; x=1712559269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=867rfgFbwucklmHRuK22F9Opm/qe0O8SJm6+mshhg5c=;
        b=MbUTHQiojBwAzkd/ixZwxMoKI6TBTOyoCo1QoNqYME7CCo4txTjSSboZq3Zx9x/rT5
         ODCQ8dDEeNc4b75ioZRdRGJyaXm58BfJZ52rGBZqcp+nCirVEvwDmzfZx6tztDHZeND5
         Ba8jAJ10ZsVl6UWKIKxVpJQ1aUyvpHPTmRSRSyqLexxWpl5zwoZhuvordqFL8qnVikkB
         j1eAi2hL0/82bsAwBfNmt2/S3QSLM9DXA+gOhLFnBDasyhysqtjq8F0q8nl0skMmDSr3
         G+TG0AyYFa/TcLLt+gh4rXACuElwqLw13QOHm2IlMMInsrKozvGqrTGfor2rqZmfbcQi
         foWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711954469; x=1712559269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=867rfgFbwucklmHRuK22F9Opm/qe0O8SJm6+mshhg5c=;
        b=pl/QiqDEd9QgBZ5IWxBHbOdmuBjiAEKQGoSEd1wkfK6fRXLXp42MOEmijNj/QQWU5T
         Mps0oDrYGz+MF3QlXWhjOrIwcWaXab23iiMTpKWrZ1VSg6+ixThmGOZ042AuAqryH/+T
         FgOcdxxzM3O5iMCb4tb9Le0BpSFwZYwVPmtJLyT4FTKCy9kZdLYPrdQGwPHgqP17MPBZ
         C5iWTBIE3Xmklmtl5RvxuqaQvlEue8pW8iVP8aS/Xdj2yzRXAtl6zCLtKa5ZBRYgx13Y
         iK2nxewi7qqkx7vma2+Ge3PFGGu3DJeogZR5GvXbZM9NZaqPUdhEoHf1Nw3sxRyIblmE
         WB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmkcX0OrG+1sgqiomU2nvWvzJ00FZjo2LbEpFwkAnV5/+bEtT1ux7718alZMv0B45Y6gafMJIhKC3N0Tr58NmM8nx0CHXR
X-Gm-Message-State: AOJu0YxifpweqlTjAoGfPQ2zpvPlmHAeox8t1OzTh5bcKPyLU3bOW2XI
	ZaxXlceqai6Jms7uzuInUNoW37+a9oBdhGIZ1u2a2w43EbzN9yRb
X-Google-Smtp-Source: AGHT+IEDi1NXDLbLrWscjddjgnF/pNv4fcqA16BIIo3fiQ8QTSQYMtp/5BWrR8ovQUk/VoCYl3mAEg==
X-Received: by 2002:a5d:6391:0:b0:33e:7001:b80 with SMTP id p17-20020a5d6391000000b0033e70010b80mr5366470wru.68.1711954468829;
        Sun, 31 Mar 2024 23:54:28 -0700 (PDT)
Received: from [172.27.19.119] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i9-20020a0560001ac900b0033e41e1ad93sm10784207wry.57.2024.03.31.23.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 23:54:28 -0700 (PDT)
Message-ID: <87ca050f-5643-4b90-8768-1d624e367cac@gmail.com>
Date: Mon, 1 Apr 2024 09:54:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net 06/10] net/mlx5: RSS, Block changing channels number when
 RXFH is configured
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <20240326144646.2078893-1-saeed@kernel.org>
 <20240326144646.2078893-7-saeed@kernel.org>
 <20240328223149.0aeae1a3@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240328223149.0aeae1a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/03/2024 8:31, Jakub Kicinski wrote:
> On Tue, 26 Mar 2024 07:46:42 -0700 Saeed Mahameed wrote:
>> Changing the channels number after configuring the receive
>> flow hash indirection table may alter the RSS table size.
>> The previous configuration may no longer be compatible with
>> the new receive flow hash indirection table.
>>
>> Block changing the channels number when RXFH is configured.
> 
> Do I understand correctly that this will block all set_channels
> calls after indir table changes?

Right.

> This may be a little too risky
> for a fix. Perhaps okay for net-next, but not a fix.
> 

This fixes an issue introduced only in v6.7, not before that.

> I'd think that setting indir table and then increasing the number
> of channels is a pretty legit maneuver, or even best practice
> to allocate a queue outside of RSS.
> 
> Is it possible to make a narrower change, only rejecting the truly
> problematic transitions?
> 

The rationale of having a "single flow" or "single "logic" is to make it 
simple, and achieve a fine user experience.

Otherwise, users would, for example, question why increasing the number 
of channels (after setting the indir table) from 24 channels to 120 
works, but doesn't work when trying with 130 channels, although max num 
channels is much higher.

The required order looks pretty natural: first set the desired num of 
channels, and only then set your indirection table.

At the end, there are pros and cons for each solution.
If you still strongly prefer narrowing it down only to the truly 
problematic transitions, then we'll have no big issue in changing this.

