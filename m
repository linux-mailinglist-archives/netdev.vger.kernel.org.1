Return-Path: <netdev+bounces-193896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7ACAC6332
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA91170EAE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275E42451F3;
	Wed, 28 May 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwK0/W05"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAB24469C
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417948; cv=none; b=nGhwu0NbkLKR6WMOeAEwoJaaL6F0fCVCnLa4HP5HETjkkuTn8sAzjnXzD4Mc5IbYzvheW/n1t8AWX+T6C0T+lEhKmXlZMtkzFNzdsgl2HF10lg+8cfdKkjXvBo/dY/8P782ctl0G11cmMJh2ZfNKF1+iDoxAgcQM2KiSg96BFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417948; c=relaxed/simple;
	bh=Kwd4D3iO9t/KxBmG0gWf433ndLq3AijK/cv4VbwcCHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcTWR3TKNBmrGk7UsMwDmP1GNeCAXQex5Dnpc/v0v5+VAuRl1ZbLLw/p8doSDiXCSxkJObythDVLL2GNioKrLVtZSOoHSTDJxVmPFpHreo/fsAQzwk6djkw5cuJol869yo+dnHRzAaJjcZkzbF0AusxdBLiyKXqJhKWH+HVsPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwK0/W05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSKWq23IFPg5EC17AwxJ8l+Mvez7SXy8zK+EDFRJYSE=;
	b=JwK0/W05Oq0a6UUZq7ncTSaPutzi0U2Ef2oM4PUlB83GIPTFwoo1iqDYFJ5CSKCEnCw5Ye
	zwS3++e4b6EPezLlKdnsHWLcs2/qE8KXm0cZbNfqm2Vi8VvzbkaHA18izj7FiQkMrLfDAs
	ONnfM8YZdyIsuqbfXFZrT6R5MOgiNTQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-r23BO-S3M9aic5mL0VATbQ-1; Wed, 28 May 2025 03:39:00 -0400
X-MC-Unique: r23BO-S3M9aic5mL0VATbQ-1
X-Mimecast-MFC-AGG-ID: r23BO-S3M9aic5mL0VATbQ_1748417940
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so126909f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417940; x=1749022740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSKWq23IFPg5EC17AwxJ8l+Mvez7SXy8zK+EDFRJYSE=;
        b=TVAIczOMb1yexPCrUJKa2HUKC2bWRo15a61SNVLxZ2EQbpv1OdufTo86QMAZUtUedF
         7YYCLZkncpb2e/ETe7ecUxRnsKkq007Z9L2t2h9CXxVP3KgIX8qA58j5su5U/IAwfFJs
         x8P3gVBeaemUcirss48uRAzSMTwwNDmPYR51wzx+1mKOkdwqz+78epTphqaNvbeKVIfm
         wEE4sqwjQ9FAyTo+d+fyz6w1qxZOz6xMC2BFQa9EEIKVX1o7P2CHM9d4KjLEs2cxBfdQ
         nNLTZvEC7Z08x3uC2XehOyAha3ZBL+i5yoS1BjCIdskcOTQswiQlizrAXIOwu+MB+pgq
         YrdQ==
X-Gm-Message-State: AOJu0Yy/kG5Q9Ab9jnYe0cT81DAsfrD4t5M+p81qtygaLb3qbxphFV8/
	Ic2j6hKtktSI34hUi/RJ80Uq+HSYTjB5ytiFb+YNXegMBN5+vA6eOaOcTodKbGPK3yIG8Pajclg
	AeEUIYCmCzd93QrblyN+AHox+HbKs3QFNuTEPwb7SVpiaGCwBFFrI1AaNlg==
X-Gm-Gg: ASbGncsk/GUCBx8rSnjnlarr14UG9p2Ffnd41g6oHarn9KO4qONHuLsnz8hDlKNWhFe
	hg5zoya67doskKr9EtYYXyRtJ9zz3/pRne+IVRNS54zq9EC7P/rs6MtYC+3R69hwL/WhBYsYuwg
	mix7WGWYh9d/6QKThn+nnkJXaQszVhNn+KD/H24l1jQIBPKiTDO8xyt8AsrxgmP12PjzBOgy2HV
	HhBF7S4jdSK70NXjvi31UT5tK8bpIsWhbKz9bwZGJlxHluQsasxR3XGH9ECjoaBG7Gjbo1MR2Hh
	7BY0+XS3/bDOHXzfZEvT+e13rJPpQesCpKdhZrh7for0Y+yv18McuRfQGVw=
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4cfbf5352mr12216038f8f.4.1748417939715;
        Wed, 28 May 2025 00:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNYhjHAxReC/Ixya4lOF3PnV5KGf/9AcxrbJuA4KPA3QtleoMxjf4OVnE0RS7jlPOoVlPG7A==
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4cfbf5352mr12216017f8f.4.1748417939301;
        Wed, 28 May 2025 00:38:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450787d3aacsm8564785e9.33.2025.05.28.00.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:38:58 -0700 (PDT)
Message-ID: <249a78c2-97cc-4f30-a156-d420bf285fc1@redhat.com>
Date: Wed, 28 May 2025 09:38:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250527013723.242599-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250527013723.242599-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:37 AM, Chenguang Zhao wrote:
> When driver is reloading during recovery flow, it can't get new commands
> till command interface is up again. Otherwise we may get to null pointer
> trying to access non initialized command structures.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

This is a fix, it should target the 'net' tree in the subj prefix and
should include a suitable fixes tag.  See:
Documentation/process/maintainer-netdev.rst.

It would be good to also include the decoded stack trace for the
mentioned NULL ptr dereference, if available.

Thanks


