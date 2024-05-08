Return-Path: <netdev+bounces-94428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CB8BF721
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555971C214BC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8002E852;
	Wed,  8 May 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkPZigCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EB22301
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153784; cv=none; b=RqnxdzXyR18KuvjLzEOZqLmM6GyPE+QaeQgjCNONp/1tKWDkvQXGj9kJbn27wm5TgOVuO3tLJN0AuCp4kXnLJkPChar+5TBbTpp27mCkitZ2reitNpaK1keWPd7BuuAsJX3WBs5iEH+3mh+VFpZJyfoimL/yCBgeDKlQI5N16Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153784; c=relaxed/simple;
	bh=WJ4Q8BwhhL4vMwpKVKBQ7jc3Ngo7564kNXezyyVleEA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lvt3orAYehsISTIU1wKd11aARebtdVFzthi4RlKOVBM1UxZxRZouNgHLGoxzWPVn+75U8dYOx9U0C19rwseAHklcQ/R3dx9ySoUVoXeFMN8C35POs6Ky64RN7sPHab4Vth923OlJJm/E5AcKjpPaWnvjiNCutnl1KcBf05kd+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkPZigCY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b360096cc4so1032302a91.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715153782; x=1715758582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHAsLDKa8I7vnG1ZblLztcjS54nnxxutP6FWWnYmidc=;
        b=OkPZigCYRCpCqZa6UsGW/p379MTruIv8aHLBaQGieIGjHcXnneitZ1NPeWYfX7Jxq9
         RbGj1Vxrp3hgajyN5dYD3uc/zmxvp00X57e50GmOmZOtOUXLq52cFg3OGgMfCIt3/LjG
         JhLidT/6JaJC3AxeKsaB32mq/YX7oP6/Pgl1Fx3hw70Ipi8/HBrwq6fHLkVJ/L5+o3bh
         bXmc40p6s2GZiNDWpNm46L+LcZhv6VXW9P3JRW1GUjKee1blzPk2tidjOf4KKll2gxe+
         +PMfJ98m2QKkwJMAlIcFdej527skGi8GuNpuE8LaQAubPH7IC2y9aNf3lg39wz8iSpxX
         uYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153782; x=1715758582;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OHAsLDKa8I7vnG1ZblLztcjS54nnxxutP6FWWnYmidc=;
        b=IC19l2L79iCW+FvO7dKQdz29vMFvDLNCtLOn1x+LUCGsn5m5eqZBRtvCbcABpvtJZQ
         BndTz3lA2EXFI5U5i4vjo1RG7bvg2baBpGhPnRq4uMhSNjaQiF+l7pDhkHCKhwrOWS85
         bp+PZAegaBqVWt4MY67DIli2Ot7+GnBiozYjp1bgpUr6QALu1ie2gS1K6VUjsmUsCXu4
         1gi1AaBKnkJt54eUy40lP+nK8KBQKLXI33l6PdpoF3MxTFbBYanRiG3kUaGz6E2EoAI+
         W2j7/Ta9Nfldr8Z4G9UPW/RblCMnkR/ATkA82zF//Yw9TcxHqS9DAvfyxJ331qk4sixN
         4Y/w==
X-Forwarded-Encrypted: i=1; AJvYcCUbn4s28qksxtHUve1Q+yVC/CwZaLvbDaq65rgmmDqQmJGf0VqOcYaIYwmpeRrpSnkX/qLCWrnvOvZ0F4Y1kqNAmflimQuO
X-Gm-Message-State: AOJu0YxS2DFjz44gBh10CmM78U4GEZds5XHnVpMROmqpcQe9z1dSSdNA
	rT3+7NHovinBc24PFTl1oNpbhNwbARhYM2IqQMnAzJEnIv5Ef8jD
X-Google-Smtp-Source: AGHT+IF0JIr8uSOln2HAL9dxtIKIO1lWZzHsir2mbDWlmvvZoyHQOdflTgMfm0YcLHY2IYUNbqUk7Q==
X-Received: by 2002:a17:902:ec8d:b0:1dd:da28:e5ca with SMTP id d9443c01a7336-1eeaf86ee4emr20804695ad.0.1715153782089;
        Wed, 08 May 2024 00:36:22 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001ecc6bd414dsm11114910plt.145.2024.05.08.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:36:21 -0700 (PDT)
Date: Wed, 08 May 2024 16:36:18 +0900 (JST)
Message-Id: <20240508.163618.289658716761599768.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240506183825.116df362@kernel.org>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-2-fujita.tomonori@gmail.com>
	<20240506183825.116df362@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 6 May 2024 18:38:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  2 May 2024 08:05:47 +0900 FUJITA Tomonori wrote:
>> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> 
> This fallback is unnecessary, please see commit f0ed939b6a or one of
> many similar removals..

I see, fixed.

It might not be necessary to check the returned value here? I keep the
checking alone like the majority of drivers though.

