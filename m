Return-Path: <netdev+bounces-163518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7670A2A8E2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CAB166594
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30C22D4C8;
	Thu,  6 Feb 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZUM2pbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499813D897
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846688; cv=none; b=lqP06zJsQ6E/tXSc19sTZEMyg1jOm0YOYFS4C/wH7aygLOx6JiL8E1t9+bA37GmSsPPjpqf5RpSk0Wk6uBp50c1TfWuKVEbAgmLhTjvpE/ny9X9Hp9msocs/H1AEkf1DAkDHVwqX+g/8GApQCEJjWOJT8E9nkpNtn6M6fbeqAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846688; c=relaxed/simple;
	bh=/+YE97l5gGGdMiaSTgR2MdCMaMZNNMImj90AujmvGRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBsiml5SvIND9Rj4fNpylu6wue0ZwcwOFRkjCvlDfq5fBwPMjdorTFu6CiG1XbWau3fLHupT+whM+cWRzcS2ieuRxNGaBc8xAQB6ogxN+20hwyjHMCZ1B94J/Lbtms50BNDwjdqoGbqbdD1HWRcEdILpAdIjLcDSwRdYXk4vZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZUM2pbL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so1880971a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738846685; x=1739451485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82VL9XvXONz1JmWwmNafYVNrGyFeti9Oa0ZI1OXfhcY=;
        b=HZUM2pbLzMEEV4vH0LPfd8iU1y1my0G5oOp1paerDWtdCn/5C6AOb4NrM2GhPEbGOx
         mfM88ewwr0kyS+CEGgPtSqk57MwjpMwV+YXpnjaQ7FxSFPF71/5u8hCsJ/AkuGNHhpea
         i50hlrtOP5D/7N8hdJBpeRAr0xRmZfbc0efALQuL2P7CNE9v/kcn7wcPpn1KvI/3EzFs
         k8iD7kfG+8I7Q0Jy+0DFCgfEpul2hIToW43ue2H8y11SN8AW4J78P4IGVks2p4hqxZVC
         5aIF9taJO+1k9spnMz44dcuUKt4NAtnc4qwIaxNM/Zt7eemEI1w7+FOlfI0msEuujQT5
         L37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738846685; x=1739451485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82VL9XvXONz1JmWwmNafYVNrGyFeti9Oa0ZI1OXfhcY=;
        b=ABKdDpJ0jSrXoh2I+IdeC8a5Qw9R9yxemJ0BsI0HDACRFQGo9REc4b+oS+iL1cO0+9
         opLz2WITVjBWUZgCB94iO14l6I3sM5wg/X5HqCEu2iFErxACCCAn2d+xzouJ9WOkBcfJ
         oeQYY6as8eqzKXwGwBianIn8GSUdh6kr5tENMmOOgxsFM6aG49blVKcD9C3o3H87hmMF
         wFS/95MGNsjMC6mzOneVifZBP+eL9Bb1ecOPOk7lTl0kgZeccp1z2oi2CLjwyEA4Wsct
         yB7xD0wSyx/LBADePtMa4EBOxOjh1rOJK7TWQcAB68Fu/o5uVwj+3gYSTMbgJriKLn8/
         bWwA==
X-Gm-Message-State: AOJu0YwZhC7TkCDnNBTy2WcjBztRej4/cMJkM1RknjXoeTT0w4g6+6TQ
	qT/Z5T1uh7WU2VvL4bemGQabgjBZA3u5cxd+SSFM/4Hed6bWV7Em4pQWYg==
X-Gm-Gg: ASbGncuDopjFio6iiSfcxwp9BzY7ebBzkYsZW5Bl+RNcWyf2SZyM/trH3dxRUx5UMFq
	VOTJTaFvG1gVQUZUz9+CY3lR84J10bBVE0PC41OxVrGULknD9YyWGiWtQNdhQJTdRVej5arcUnW
	BaNCpd7nknKPbw6VQ9TynUwlCkyjh9d9LawWNjqCgc43oCBr0IMVghjYnZO448jfCIp/DB+cDpx
	rzDkkYxwJrv+VPP+TS3yDN1lZ9dMv/4X+wCp2s443HGJtX5DVjNG/XKdUm00wsX8VdaxYGlu0oV
	oq5OAcap1GZgziDaZZKv9/G04f77ut0w0DQ=
X-Google-Smtp-Source: AGHT+IHrDxmFpahE2Xf73yd6XY7H9pIuigc7Nof9979nKjHSrUsBzLKuD0egSCQoGlQ/UBARmteifw==
X-Received: by 2002:a05:6402:4486:b0:5dc:7538:3c5 with SMTP id 4fb4d7f45d1cf-5dcdb717b28mr7207419a12.4.1738846683865;
        Thu, 06 Feb 2025 04:58:03 -0800 (PST)
Received: from [172.27.34.32] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f9b3sm837776a12.59.2025.02.06.04.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 04:58:03 -0800 (PST)
Message-ID: <c130df76-9b18-40a9-9b0c-7ad21fd6625b@gmail.com>
Date: Thu, 6 Feb 2025 14:57:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] eth: mlx4: use the page pool for Rx buffers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250205031213.358973-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/2025 5:12, Jakub Kicinski wrote:
> Convert mlx4 to page pool. I've been sitting on these patches for
> over a year, and Jonathan Lemon had a similar series years before.
> We never deployed it or sent upstream because it didn't really show
> much perf win under normal load (admittedly I think the real testing
> was done before Ilias's work on recycling).
> 
> During the v6.9 kernel rollout Meta's CDN team noticed that machines
> with CX3 Pro (mlx4) are prone to overloads (double digit % of CPU time
> spent mapping buffers in the IOMMU). The problem does not occur with
> modern NICs, so I dusted off this series and reportedly it still works.
> And it makes the problem go away, no overloads, perf back in line with
> older kernels. Something must have changed in IOMMU code, I guess.
> 
> This series is very simple, and can very likely be optimized further.
> Thing is, I don't have access to any CX3 Pro NICs. They only exist
> in CDN locations which haven't had a HW refresh for a while. So I can
> say this series survives a week under traffic w/ XDP enabled, but
> my ability to iterate and improve is a bit limited.

Hi Jakub,

Thanks for your patches.

As this series touches critical data-path area, and you had no real 
option of testing it, we are taking it through a regression cycle, in 
parallel to the code review.

We should have results early next week. We'll update.

Regards,
Tariq

> 
> Jakub Kicinski (4):
>    eth: mlx4: create a page pool for Rx
>    eth: mlx4: don't try to complete XDP frames in netpoll
>    eth: mlx4: remove the local XDP fast-recycling ring
>    eth: mlx4: use the page pool for Rx buffers
> 
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  15 +--
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 120 +++++++------------
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  17 ++-
>   3 files changed, 53 insertions(+), 99 deletions(-)
> 


