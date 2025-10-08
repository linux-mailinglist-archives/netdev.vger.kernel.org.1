Return-Path: <netdev+bounces-228247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49771BC58DA
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160724E110F
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5822ECE96;
	Wed,  8 Oct 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9gyAgYG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9A2EB851
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936900; cv=none; b=rESYwvi96nDgMUECV8puXCcZhsmbeIyjvvthdLV5ToUIHfG/9cc38jC8q6YQC/Wgte+y+SilOTjeTV8VgHdjctLMZhHp8U8TjKIZjP1jHijXCvuY9CoW0bBga6KFEr0iwC4MhPdexZygoqcW35vcM6Bz5CKFwRBuRAYWO5f96Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936900; c=relaxed/simple;
	bh=D4ufD86zZzCdEADHoUELQUb+cca6dWk58M9bIke/nOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwIdgGHSDzU77eawwCnZZYYuXlrXVRVw57NJAEYWYygQOdSfxKp58v41DqxAcQ9Z45031rdze9YnjFlVYrynTgYfMu0Tdc5uXoQQv1mojc3frBFkr2MG0+vpu/I2oxmNpjnM4nQLxVK509X/OHlHw7vIxGI06toDZsKqY/cBA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9gyAgYG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759936897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw9XafzPyU5RLEwAQUrMvC4yBVbnsaatLBibFhD32+8=;
	b=U9gyAgYGr7lypQ+aNMOfn66swgYpY+35kn26FlFzcvD0L4UFD/X/TD63lIOHN4WkCv36cK
	YOyTNzU7fG23NrKrnyfBiTg7aROWpmjnVsxzXaWKFJEvygyAFuPN6LKRoHTWiN3CQtW7AH
	DDnxxWz+xxErSGOw0IMFFaCEXRYrPBM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-h9ykBFE9Ph6EnWXjUTOduQ-1; Wed, 08 Oct 2025 11:21:36 -0400
X-MC-Unique: h9ykBFE9Ph6EnWXjUTOduQ-1
X-Mimecast-MFC-AGG-ID: h9ykBFE9Ph6EnWXjUTOduQ_1759936895
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso40528465e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 08:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936895; x=1760541695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fw9XafzPyU5RLEwAQUrMvC4yBVbnsaatLBibFhD32+8=;
        b=nqr/18MJg5SEX13QEA8ie7LQzBo52KOvU0insw3ScOCP51JnzRfswNse98CZhVhEsb
         YO8OzxpXFq27oAh56mfW1kuy+ei9rHHnSlMieyFRTM/XeguFTu6GX9bQLP+daJ/VH7IN
         PDNr4va5RLD2l3dNVVPTXfHxtjyP1iRtrS/84HSt/4aFs2Mwrg1WPmt+aK8O1lUPjTJ6
         bGWF72t6FX7Q935GJ85I/s1visL07ZLKvLR/aff37+P9zK56AmXCPU68Z4JnMJUmSZGi
         f/PSeS3Q8PRlp4wtqvCvl1QAuUN3/3FGyA15r9744CT6IjUH5Aj5WkCQ34ZH6fRBH4Zb
         M7tg==
X-Forwarded-Encrypted: i=1; AJvYcCUrBGyoe/HXMLOyh7uoLkw5LnHT4J+0827u+iOeUx8GfW6KeE3LZ9SXCtvQIMJej4YrOqmmppA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwM3MGN6OkofSVBc0sGsYfudJZ5QnKbz+MtgREUpJW1LxSf1Ej
	LXrSFWDvs2HgxJzyQyPllIJI4gIxJmjWqqAknoHacIKwZXnAhwZSdYRQdhddsnRz4Mi4KkZaVxR
	+PzsDv7YQfxB3AiXIlc3BHIqsUwHN4MeSId554HjPKsVEDzwtagXc6i/DMA==
X-Gm-Gg: ASbGnctTIp5DRCRZba/VgstSMJpg0m+GlmpI2Jwe019PzyCNgjvM7QWDw9+r7MfJ/QF
	KA6aW8Djue9ylU2b15GuafrgH5KwXG6dWUVPA3lGVt7qKXpL4zh5NLpEYYxD6nHdP1ocj12ikjv
	jbBmTSLSFuX4CcSMKC7LUVSPWDIDHcDqlDFNzezinXyejCw68eKHixHHcyD5q0JcC/u1ltV/0q7
	bHCplvKWytjJGTF8a2wJnR452Cu8ml44Dk00kVNykf+281fnkO3dlSgRYuq22i4xJC/Yrhzr9KU
	sX8OIjgRhinLcuGOfzTPBeELZbZrsAA4QVuvRq6MUmVa86CUcJHanzLabua/yMJtRvXRpdJRz74
	diaxkTPVSljKLbUGJsQ==
X-Received: by 2002:a05:600c:1986:b0:45f:27fb:8016 with SMTP id 5b1f17b1804b1-46fa9a89388mr30430145e9.1.1759936895493;
        Wed, 08 Oct 2025 08:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2zKGz4XTejwnsyTDYN4UYuPOus2C4PWqBXH0vbZ89rAu38WjrIRfI+c9WBfT932Tu7lgBLw==
X-Received: by 2002:a05:600c:1986:b0:45f:27fb:8016 with SMTP id 5b1f17b1804b1-46fa9a89388mr30429875e9.1.1759936895024;
        Wed, 08 Oct 2025 08:21:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf1118aasm4494545e9.5.2025.10.08.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:21:34 -0700 (PDT)
Message-ID: <3272d2ee-dd62-4f0d-82cc-f50eb1106fcb@redhat.com>
Date: Wed, 8 Oct 2025 17:21:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 3/4] net: add
 /proc/sys/net/core/txq_reselection_ms control
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251008104612.1824200-1-edumazet@google.com>
 <20251008104612.1824200-4-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251008104612.1824200-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 12:46 PM, Eric Dumazet wrote:
> @@ -667,6 +667,13 @@ static struct ctl_table netns_core_table[] = {
>  		.extra2		= SYSCTL_ONE,
>  		.proc_handler	= proc_dou8vec_minmax,
>  	},
> +	{
> +		.procname	= "txq_reselection_ms",
> +		.data		= &init_net.core.sysctl_txq_reselection,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_ms_jiffies,

Do we need a min value to avoid syzbot or some users tripping on bad values?

/P


