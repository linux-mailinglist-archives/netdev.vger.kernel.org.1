Return-Path: <netdev+bounces-116763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7F94B9F6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0615FB21156
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A789189F43;
	Thu,  8 Aug 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGUXVLA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10491487C3
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110469; cv=none; b=c/cHq9m1340oaCZ36xBSdFO8IaTB8dsrE+CNGIcAr5PwDYl98+ZhwORc5mnKCsP0ZhM23uqKLdgS27iijybqRyK+i9hDPdTvE5L0zT+IDcqHNcKQHprY1QhzupajcquHX1dPNTHt7SMPeQjmm3INtM8WKAbdhLOry2/egZKutuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110469; c=relaxed/simple;
	bh=VTr4v4ohnKL0dIxLbIOWkq2Y/jbwRQFBR2eJYGjm4RE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=URD9N7d/055lA32m+/YgaR6zEaei5dOzl3E1MsTtz/Ftd55yg5Q6scIBlR1PqOwJvNXLUfPtlgFX0b24GqtbqEy9ylheAt4pFQb8vnCSvnZe3I36NppRer/pm5CvyUDjrp+STG8H0izET/TeZhPRUCSKyvDtieVBaTsilYc4caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGUXVLA6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso5653255e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723110466; x=1723715266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qof8rHd+kTgVA5h9r/4ckhK1KMdytC4TCrTIr3kCh2Q=;
        b=bGUXVLA6QGfilybtvPLBvXZH2zfivXEG7N1Ha6y0AusvD0zTP9Xgp1MSuGYjqQtlML
         DolyAZ4r0F6XTXIBbm/JI6fpJvBPHotYkEipwQPiBrip9sEXhUuld/Ltr1/RkPIXbFC/
         YuaYSV6HgCMt9sLLdvdMNQYp+tZqNnFn0BTaeSRLlW1d6LXdsUorg4sgd+V4bvjsxtUu
         KSepwSzqoS9O3poiZBuG62U8oOjsSEOpfOa8x9BHvWLOIMD7EvYRE3Hi5j19IQd4XGa4
         cdNbjoX81+TuGXBYTL7wAM1O9kPs+wF8oZPb9cKwcwY0sxkEPDYiI8FeRNtK9lkAf21S
         P+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110466; x=1723715266;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qof8rHd+kTgVA5h9r/4ckhK1KMdytC4TCrTIr3kCh2Q=;
        b=gErn2BRYN9Xi+enXbuvGdSvUNKttpFLC/E5xEr205UuJY2IvH3EjrYwlFD+x+2USJa
         VZC5mPeWvjTEes6t7bTvR4UYP45GDZuribn5v70T8f8EsmnrOKPdAgE3gXRxWB6BA0ti
         nX9r/qmdQMVEHxSf4QDzk3o7PbV16R9E7aWSA0Wv5uJBXsBZw0ZfrcuaunazZQdzz4ze
         nbbflMfJ2S/gyDk8FF+uqvUxOnluTigryV5H10meOOt0ngmSKKjHXyhv7P5IRk5HI/Va
         8Ipx6Y9mJGvm8YztSZaQ8aabIllke0BJBwxCVXazlySAOqPm6oPyPgXMQK7cHm68ZbRt
         Z2wA==
X-Gm-Message-State: AOJu0Yz71jG9ou4f45f23j+ejpZN0gesD6nM3i9FFu3vsOY6YJjlZ4+w
	4mTuDpbDDVa2ERCRsx5z7OWxqRKEZW21xn6/9B/QeadZ2ysNNXso
X-Google-Smtp-Source: AGHT+IHkXmmBGmRpOEHsHiQIBngEU7AGicLJTuez/i5ZArJk8lUicQqDEzwDui1ggW6WOD0s/xQF2g==
X-Received: by 2002:a05:600c:1914:b0:426:5b21:9801 with SMTP id 5b1f17b1804b1-4290af0b20bmr9369365e9.27.1723110465953;
        Thu, 08 Aug 2024 02:47:45 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738f18sm13611165e9.13.2024.08.08.02.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 02:47:45 -0700 (PDT)
Subject: Re: [PATCH net v2] ethtool: Fix context creation with no parameters
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>
References: <20240807173352.3501746-1-gal@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <9e5ad376-352f-2628-3d89-a24bf34d4942@gmail.com>
Date: Thu, 8 Aug 2024 10:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240807173352.3501746-1-gal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 07/08/2024 18:33, Gal Pressman wrote:
> The 'at least one change' requirement is not applicable for context
> creation, skip the check in such case.
> This allows a command such as 'ethtool -X eth0 context new' to work.
> 
> The command works by mistake when using older versions of userspace
> ethtool due to an incompatibility issue where rxfh.input_xfrm is passed
> as zero (unset) instead of RXH_XFRM_NO_CHANGE as done with recent
> userspace. This patch does not try to solve the incompatibility issue.
> 
> Link: https://lore.kernel.org/netdev/05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com/
> Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

