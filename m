Return-Path: <netdev+bounces-187842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17664AA9D95
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D998189183F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919131AF0C7;
	Mon,  5 May 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LWTwBM7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D915680
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478371; cv=none; b=MZWXif1SOzwSNzNEzP3DyUfkHTWKRneeEZW0rjsambHYvCRi1ghwF0EqZDQnqtLEt8QbK3+XhIJELnrekVJiCiMatZEIwPBAWnTiOcTK4PgIzrreERpVsmtuBvpG8vDqdwB/OmqXx30Y3ITFv7mqUXzC9mcr9GT2oFr6cdi3OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478371; c=relaxed/simple;
	bh=yd3QfzXaj7z1fjzz6t45YLeVqPyKz+tr7X+Omat72WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjXWbaWkObxS+HQKEQSi71QNJnzlu7NMMzYON17ixbADMWB8TAIDiv0JeO7ulcV0ydLaPIQYjKrjnUlGWm91SChTwEUtGvukU+x6OEQ5Qt9CEE6/QEKWXuFHaVeswd09oJzCXNNYU748bGHPmtgPxOqgoM1v+dqjV+mqaQLtkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LWTwBM7X; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736a7e126c7so4402719b3a.3
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746478369; x=1747083169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cBi+dbkPn4cktEQILDqL/yCI2dmXoqGnAnBOjbUNHo=;
        b=LWTwBM7X9kGd2L8/zWasCJfttwDOI6kXP4ZTZQ9JJirdNQa+9bgJBgX9azkenL5kEg
         F6Ri89I21qHpTgFd5FXS/U+PezU8P+M/DBd5x0g0MjRVztzyCAouy8yJqoN/rHbzXHj3
         epOFgHvd81WvFxwdk/7KYiAdCeeI3PJup/ejb/cgCamYlEJFcqoXIwa5KzWg3L/cXLYJ
         CNIhymRoPLoAA//AiBMuWE5AamHUXhZL+/yNIdMMxSuzJCGcb64CCNQVfDVvUfZFOvjm
         Nlj9gN1xeBWfqTvlwNtA8qREB79OSbZl5zwW6hEMlRk1x5IFmdPcZibG5h59C3fBJDUc
         mmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478369; x=1747083169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cBi+dbkPn4cktEQILDqL/yCI2dmXoqGnAnBOjbUNHo=;
        b=OgNPsQ+8jvuoL4eVyahUuc3A8Zb/BHIURd6fJwlYc0Z3JxX/BGSJIc3UaRaBPQB9x6
         IvGU9hgBPtQDJfOOWR3U+f8XP9PyXv7CL+3bZLUIunK23ihZh9tILjO+SzXgVc3KPIEO
         3sCVC2pcybt/EMftldmO/BKo6Oxy6VAy+geA+r/npOtEOTFMPk8AwkfiXRbjyEzSmNg5
         i+w7Hv/1Vc8raAo4RnJzns1LNxntKtgB8OZSB2KKKYIiP1hEYG/UDKI7UZwWL020uldw
         wqvi3jK5xBGRnJaIAWDoFUyisucdKhbHSzL8m6I2NTQ2JPgpasZYeaNnE533rtNHWno8
         RO1A==
X-Gm-Message-State: AOJu0Yxbi4eDkQR9AjhDPNV/chelQFWYzfogRcukSRKqNVWiNArS0c9X
	wpu4JcozyUSAoz7/MVC4k63j7Y+fhH0cZzS4pPQ7hIgo2foStGqjWizEuCjcUet15P6n8yJVdJu
	ybZ8=
X-Gm-Gg: ASbGncvtkY4iD2SGtwXvYqDYulIyqSf6p6ABTi89/iCtDkilBGDjrl5pid3B37zokdo
	aCDh5Umw0XxqoZqEYXlg25Cav7pjMXMAiERNykL5wtfExzvEEidXdDh4nG0HV4hb5Ha+exvB/Th
	/n5X2zRCp7yIrqRdNbitpuSKNTsTv/ilQ3Mw3HfkFLcfJ6okGtbClxqC8zFHElY59Xb07luJr/U
	+Qb4xbOGKpXozWdbC8jOSE0wIXA0yA3nGGfgjjov/FBnHIBG6SnlA/f+B23Bq/0JJduMyZb6AR8
	yE1mfYadd2oJtUb9IHeCZvBnmCG/gdWwXD5x+kjWOyP2l/dVtZ4kvwCWnVTa2IKZSKwgc2cGPaQ
	qyyc=
X-Google-Smtp-Source: AGHT+IGeyC7S77vjXSdZZ+UpEmEDuqzYuu4FHFJBlQGYqnwUSQDTRYvqTWVjeiNRXzkr3T1ctghJiQ==
X-Received: by 2002:a05:6a00:4489:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-740919e879amr738156b3a.11.1746478369415;
        Mon, 05 May 2025 13:52:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059065768sm7308711b3a.154.2025.05.05.13.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 13:52:49 -0700 (PDT)
Message-ID: <bf373951-64d4-4455-adef-eef93ed9a57a@davidwei.uk>
Date: Mon, 5 May 2025 13:52:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: rename basic presence from
 'bit' to 'present'
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 jacob.e.keller@intel.com, sdf@fomichev.me
References: <20250505165208.248049-1-kuba@kernel.org>
 <20250505165208.248049-2-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250505165208.248049-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 09:52, Jakub Kicinski wrote:
> Internal change to the code gen. Rename how we indicate a type
> has a single bit presence from using a 'bit' string to 'present'.
> This is a noop in terms of generated code but will make next
> breaking change easier.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Confirmed mechanical change.

Reviewed-by: David Wei <dw@davidwei.uk>

