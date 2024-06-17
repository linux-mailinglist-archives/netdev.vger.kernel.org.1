Return-Path: <netdev+bounces-103912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5890A33F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DD71F2186C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3915ACB;
	Mon, 17 Jun 2024 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPD9JvFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE689C136
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600806; cv=none; b=cwsuknO307WwS4qJIamgSn86NnR9c55fJi9aZUUwfETmKTiKLN4PZOHtLFRSJuOOH2fFI8wqDgvgA9ncsPJQItQYXkMSsnzZVfQtMuYKhU8H1FxJk2jFJ4BRyowTz8sLDjgDGjDz3c9wxVKGfRS0IUWHXCl7GwhXq/DaHFHmwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600806; c=relaxed/simple;
	bh=YA31ho1hvGp6ND5k+asJiD/2vvQ0C24RrsBhKGIubrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBkyPC4KnavHrbRiC5M9yRkBIPV/J51LerH6OYHg37KKouiVFemIpbeWqcIr/CcWfGwoUtfvBsQjp1Z+UnAdU4y5mMrjkBe8qRnxy6KHjg4DDPHqnxrX8l+pJUPCKMCeGqgRTkCMRPebPRz2aRd3kOrsbMJuq/HhFw8rzpH71ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPD9JvFM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso30522735e9.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 22:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718600803; x=1719205603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNsnFR8O9J3fwQYy3BvAO92S2Nm4P877yU1SbHJJ3OM=;
        b=VPD9JvFMFfrIMXqy2ETXzec+8I1zDTP1wmD6NipxJ3bDtABJEUyW8fuIplKLdGm1hQ
         2vSTyaMWhXvoe3lAxQDHhdZN8BtgojnI1jPZYSrQDExilb0+UaOv7G+hJw1NPihZTHXy
         oQ4FfoV4Zj/2sdwfqizrKSI7CvoICJYdoihQEVSRThpxgkYNvH8TVQiI2LGb6K4ClUwe
         xJOCzRBXwLiy4jjruttqEgEoKY0prm/Wd8ioXqigo9Y+d2O6qKTF3cIwAowwJI6ra57I
         oFGkgyB1ISocSOG5Onpvg+ZDqnqNtunlC7nqT0C48bP8GaJ2DCHOKDeHBGwUyJFQc+av
         PuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718600803; x=1719205603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNsnFR8O9J3fwQYy3BvAO92S2Nm4P877yU1SbHJJ3OM=;
        b=V56npWtOBXiPHpnhM/zU7xv/nFBPVGqeFlYRM40DJ1S3yjPzlRm9PRQiWBt9Aqix+T
         /dZG6VGh0bdglYrt1BWLXx0uU4VAV0cXInZK8CjLsFrKfCsqGmT0JgSL+vFma/9FsKj1
         RVioGA0H2oDANLKeobDe34Smiw3m7rHdYlX9V5wLvnzon7vNMTMY1vMtJS0VX8lEvOqo
         WiAO6fR4B+eobwzFPHsBz4XodXR0WCMFFdDW7EMM7/ZRB7xoljT3vh+zwBNHavQ4lf2i
         48uQGBM+XRxbO9SaWbX1bGh/z1RczPGkWuzF9uaTRiNv56uMDnrzw8sqn9Fp45F29SNR
         PPyw==
X-Gm-Message-State: AOJu0YxS6tSLiV2TB2+oIRQhRdKRVjv3O9zN2wzm94kEDkd/wLAiM480
	aXIz0x5NogbfIac+4A61+6a/O9Q8r56jr3FgdUKoqaEvkLcpHTN6WECfzA==
X-Google-Smtp-Source: AGHT+IGUhuQA2k4ZQ4OIpf0EqUahAxNOijh0FGWW361Xx9+2CnWICb9RH8uUr2PDl5fKK7DUWZQzeQ==
X-Received: by 2002:a05:600c:35cf:b0:422:1def:e1ac with SMTP id 5b1f17b1804b1-422b89b1573mr104545895e9.20.1718600803037;
        Sun, 16 Jun 2024 22:06:43 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e71dcsm183168625e9.44.2024.06.16.22.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 22:06:42 -0700 (PDT)
Message-ID: <0de75730-5591-42db-911a-abcc24473345@gmail.com>
Date: Mon, 17 Jun 2024 08:06:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx4_en: Use ethtool_puts/sprintf to
 fill stats strings
To: Jakub Kicinski <kuba@kernel.org>, Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
References: <20240613184333.1126275-1-kheib@redhat.com>
 <20240613184333.1126275-2-kheib@redhat.com>
 <20240613184333.1126275-3-kheib@redhat.com>
 <20240613184333.1126275-4-kheib@redhat.com>
 <20240614183752.707c4162@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240614183752.707c4162@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/06/2024 4:37, Jakub Kicinski wrote:
> On Thu, 13 Jun 2024 14:43:33 -0400 Kamal Heib wrote:
>> Use the ethtool_puts/ethtool_sprintf helper to print the stats strings
>> into the ethtool strings interface.
>>
>> Signed-off-by: Kamal Heib <kheib@redhat.com>
> 
> minor build issue with this one:
> 
> drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:453:6: warning: unused variable 'index' [-Wunused-variable]
>    453 |         int index = 0;
>        |             ^~~~~
> 
> otherwise LGTM!

Hi Kamal, thanks for your series.
Please fix and respin.


