Return-Path: <netdev+bounces-202889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA8AEF904
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CBB481A0A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3DE2741B3;
	Tue,  1 Jul 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUzrplRQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BD273818
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373744; cv=none; b=f0e4j3EkYxBi9RAsETvcldnKpUYudYGHQm1g3vFgW6T2+xdzS8JVmQBj+QcW4FOncM2tepZ22wM0NwkjQMvDF02SAJex1w6zHc+FiYMbiLTb6Nx3iGwbnhymXwGmho225kv9ZFoeXnvBURuT6PBh6q7FaXErUgGsKIE6TwEejsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373744; c=relaxed/simple;
	bh=J91jMOtn5S/iU+jH4/neCXnUUr4qOjenQaNSHFyZoE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrZ67dSz0H72pqsOVtyA8MFHI1lEBuHOmTl6iIyjJC8Up0mhfecfFfSWZNR76aqcSbdANM6fzXLNQRMAEmf56Oq8dq8LaPXi3lod/9Tf/LdzCowDSAmfRc9JdV75EQ3rwoqXa8lwLxTo2PW9YDYUQRdMRdiHwKb0j/UhGpgPZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUzrplRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751373742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrdnzuePJ7Xg/Glg6SaL3CaNK9Xu+C89jdkEFr3FdsQ=;
	b=GUzrplRQs9R+KOsKZ5XbA1e3+CQriy2XOacB/IZJASe6UFUb2Rq0k8WPIL1C0PfT+E7M4L
	8LQkd6EvMrL0QjhKrhw4sSPlF7X2wVdwJaxImI5anH7EjQZdvcp1TB7gjfI15lQdKJg9VU
	KUpZc4buL5eXsNMVkKughoGA6ytCELs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-u-a7tN7vMemHxVvN0bqlrg-1; Tue, 01 Jul 2025 08:42:20 -0400
X-MC-Unique: u-a7tN7vMemHxVvN0bqlrg-1
X-Mimecast-MFC-AGG-ID: u-a7tN7vMemHxVvN0bqlrg_1751373739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso31432805e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 05:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373739; x=1751978539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrdnzuePJ7Xg/Glg6SaL3CaNK9Xu+C89jdkEFr3FdsQ=;
        b=T4fT+ElbTpz+WSYEAB45s4upvgvg2NV4F9WULI+z0xKjAEU+D/bv3oIq13VW6MEuRw
         yjFS2SVivuRwNmxXr+7Qq47Z3LrGMDmFfUh2iXrNVy9t7RgQ3Ixc9PfuXdN25Ss+CZxY
         yNr2AnaT1Xp7iRw8BL7SBtjY16YTIHG0MUi6ASIKtgOoUieEOeaYwYY9ijNAoEo9lzzr
         OBq6uSmQ51hU7dpdd8Js5tWdxY4+NBM6eZ/HqPF1hzZlzBXVNP/FwlDqOKfgkN2rbgEU
         AbPB18cVAKbt6ve2sS02D5MucNvwlEq2K6IbqOWLpQ2HJ6dC0MTrg5QPlw/ioAcLdPib
         Y5UQ==
X-Gm-Message-State: AOJu0YyfJY7F1sTUWLWsy5wvYPZbtvpRZOmHO3H88yKw0mH0jE47tEBy
	4Bm3keYVlw5EmcknScdOQ+v7TcBuzQgf5yQ4BO7/wGWEKrt89QnFxGdBUFirH3QiqCEuyw+8bFb
	SkE8Q1grxer8r85/DdG2igkDWguX/GOj1Ejwu+GCzeofq5qiUhWCzaUcEVQ==
X-Gm-Gg: ASbGncvYdjWlpkbJWAtZx0XiAhOZUoiHKMFYWhly0iZhqzaFlBcDOkvoBPGQ+O+S4Ji
	Np9ByFhf0fYvDwUNm+z0Vga0YPX0TUawbMqYCt9WZObJ/kS1uJAiZnKeDgb7UhFNz1AmLwtK4LG
	3x49BVHDkgUNdEiHyKquZjcZHuwjJ1UdUuq7YizmUKDeBNQnPsFOdpSiKA38uH2HlXWz0NiHBTP
	g+cRjHwCzXgZWd4k8Bhkx7uTpiZBB4wCZI2Ak1a74mG19ETeRg1+wM/sAhGZDrxsPdVMA/2VY6J
	tH2vmiSVr6dUYwEGX8Mf/l7ibcX7ArOri6jIyqUL6KfqIWNOYtatbfAuY7n0chC7ZYvBXw==
X-Received: by 2002:a05:600c:8882:b0:453:60c8:f0e6 with SMTP id 5b1f17b1804b1-453a78b958dmr25714805e9.2.1751373739264;
        Tue, 01 Jul 2025 05:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ3EnuyE6lLMsRMGUyZPzTD0QSEjG+NpmThvDPouoHgbNQqJi+Gp8Xu2okKPmPYcfeQSwkcw==
X-Received: by 2002:a05:600c:8882:b0:453:60c8:f0e6 with SMTP id 5b1f17b1804b1-453a78b958dmr25714385e9.2.1751373738797;
        Tue, 01 Jul 2025 05:42:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c3a96sm194865485e9.35.2025.07.01.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:42:18 -0700 (PDT)
Message-ID: <f16bb726-e8ba-4b9f-9657-5860b4f118bf@redhat.com>
Date: Tue, 1 Jul 2025 14:42:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v06 2/8] hinic3: Complete Event Queue interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1750937080.git.zhuyikai1@h-partners.com>
 <4695dc0171c0366ef2fb4eb46e7a9738061164cb.1750937080.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4695dc0171c0366ef2fb4eb46e7a9738061164cb.1750937080.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 8:12 AM, Fan Gong wrote:
>  static void reschedule_eq_handler(struct hinic3_eq *eq)
>  {
> -	struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
> +	if (eq->type == HINIC3_AEQ) {
> +		struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
>  
> -	queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
> +		queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
> +	} else {
> +		tasklet_schedule(&eq->ceq_tasklet);

I'm sorry for the late feedback, but tasklets API are deprecated, the
suggested alternative is threaded IRQ.

/P


