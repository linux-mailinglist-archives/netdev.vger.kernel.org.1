Return-Path: <netdev+bounces-165257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC5AA314A9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927B21652CD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA5262170;
	Tue, 11 Feb 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt4rG59g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D511DDC14
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301069; cv=none; b=D0sMkRKXE27sp3w443T5ajMt4Ee4AOHcPODT3wMQKYobIJJUPYJ9GjZgLM8gahQon6AUTf8iEJ25ZCxrJHMJUgP/vSuv63w9dfYJ0d4cEV3eMHVDzALXd2X0dUNiu+S+UprAXCWAgF5fxvBJzWMl0hoCdqUdd7IJhN1hmp0xJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301069; c=relaxed/simple;
	bh=kLFmUmMBq09RDuFG/tVL2zZdQSUFXf4BHtM7Dh3E938=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+Hm5cz3LHNPQu5PuDOQt18WPCwaNxZCwl7TyPJ0QgzEVgGkjJ7P96MUQBSMbjJzwJWmfUNTCjhgzFM8ag2Zvc2GvLFk81c1Onw28lwyCIQ4zJTeTCkxesICD5HaLi7gfjaTE7H9UzjgM5LV6/hOhEhevVDGyf0P2MTBRFRGqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt4rG59g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393f6a2c1bso379855e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301066; x=1739905866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVQfSzwJUqgEnGginpm7iJCf1WNb6avhzQey9SjRZ5w=;
        b=Pt4rG59ginMAysA/1U9GjCWs3T+zveWuoiLdFSwzhb8yQ96pQ0DDzkvpZR/5yr+QkH
         fkviEMIeWpsiYPeq3U6gG6s7653bBOToyWZc1xC/8b9Cn1FQY28BQL1YulpPtV8V4EnQ
         J9l6hlCYDo9NHhV+GJuL31Kg80apMTOK9V01cmbnO2sMq5/DiiB+YUoWg1ViuyO6d+sM
         2ebDyipF/DamUNvutgqbBA1NMu98KTkVzoCn+WTaxEAkITKkpNPC8q5eeYZOsOzhL7Nb
         KQw5gvkySzMdujY9bKa1LpUW4QoJl6E8KLO5WOkUbTKYV6fwVE4jfa9oLzQ5/U/o3jAj
         EY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301066; x=1739905866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVQfSzwJUqgEnGginpm7iJCf1WNb6avhzQey9SjRZ5w=;
        b=L/b+fwY3RvdQfKwTQj7ZxHpMS/WcsqmueNtOOYSI0VmoaXGTcfM1sqQETsvADpNRzf
         S1KRAisehncv49icq2UF+chO5emFEeW5ngmqKk2W5WM7ZUX80ziGhlFfbzM6XerAnZNb
         9zs1Fa+RI/6qADCqHX7edgszuZfyATd4YUImW5OPFb+fF9CdA6vNHDsMCC/56CGaFdw3
         rY1OdtDwzt1Pa4ljPPsknqesEGbzf3TCEXMhbnQmeO8nsN7aaEZtm0OiMLxhyzg4DmdD
         lECyIkCZzvQGN06lFRTpiEnP8F9x5PD4l4Blu86x9Xt3TjjmvdrrVwqUH1lRxfRWdpmV
         a/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVTMZZEWK4jsjz4SWh5s7SMv/BGKR4u/bAJllYQQI0UjicY3dCfGvieUZKTxNFR3Z5L8WJHiXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoijElrZcwa1gePKi6p/xQBYZ8G7gePqeRV+x71YnQ+Hpxm+LF
	gB4+ZUovVSM36rE4y1o8Mm+o3DN/2xniIRdtOhP4BCvsv5p3hqpp
X-Gm-Gg: ASbGncttRChyLpVwAP253FG6+nscmaMPi8FliK20+Ns+FBCKQSr5p2pRTNwx5yAxznw
	z5d7jFzFiFLmHmq7zEKqusr5n1vJ7FVk641Fn+ioq2GwiScTHj/6ObXUizW2VW1iJwKYTk5yzlP
	NrUDBogltnwkc4QVGdHIM7wInj9RVirAQTql+cnrRqYJzikPVVSePWYVOHp4TxjPM2BrJK+OUL5
	GlSwTSe1Cf2RYq7AlhZah6sLtdaDeV5ZfSs0fZK8lzdtGgkgS5HeHmPMo0CFPtByW5C7Wxys64H
	B1FigqyCz2b1o0S7ruCl0MksnuXzb26ulBfH
X-Google-Smtp-Source: AGHT+IF2g0cfhZBFjLr5mE+UZaxAawjJCGwW0fUlpEVyr83+KSfNVDr23gHmwT419MEf4SutYQe6vw==
X-Received: by 2002:a05:600c:5897:b0:439:44eb:2d7f with SMTP id 5b1f17b1804b1-4394cf01072mr37598495e9.12.1739301065571;
        Tue, 11 Feb 2025 11:11:05 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394f2c2c41sm20548135e9.1.2025.02.11.11.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:11:05 -0800 (PST)
Message-ID: <ed868c30-d5e5-4496-8ea2-b40f6111f8ad@gmail.com>
Date: Tue, 11 Feb 2025 21:11:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-2-kuba@kernel.org>
 <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
 <20250206150434.4aff906b@kernel.org>
 <18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
 <20250211110635.16a43562@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250211110635.16a43562@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/02/2025 21:06, Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 20:01:08 +0200 Tariq Toukan wrote:
>>> The pool_size is just the size of the cache, how many unallocated
>>> DMA mapped pages we can keep around before freeing them to system
>>> memory. It has no implications for correctness.
>>
>> Right, it doesn't hurt correctness.
>> But, we better have the cache size derived from the overall ring buffer
>> size, so that the memory consumption/footprint reflects the user
>> configuration.
>>
>> Something like:
>>
>> ring->size * (priv->frag_info[i].frag_stride for i < num_frags).
>>
>> or roughly ring->size * MLX4_EN_EFF_MTU(dev->mtu).
> 
> These calculations appear to produce byte count?

Yes.
Of course, need to align and translate to page size.

> The ring size is in *pages*. Frag is also somewhat irrelevant, given
> that we're talking about full pages here, not 2k frags. So I think
> I'll go with:
> 
> 	pp.pool_size =
> 		size * DIV_ROUND_UP(MLX4_EN_EFF_MTU(dev->mtu), PAGE_SIZE);


LGTM.

