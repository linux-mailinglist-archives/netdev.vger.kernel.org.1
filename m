Return-Path: <netdev+bounces-131531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845698EC54
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C310D1F2260B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEF146A71;
	Thu,  3 Oct 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akXV1s/O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD4145A1E
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948097; cv=none; b=sLHTOy3i0NiMaUNkacJj1tbWtPAhn711i324hWvHFoeooYmQ7WGetiqw6ooyO6lVVKQEpQLaUt2JZ+aUIH8j/GGjVqO4CDqpq1HFq3lL/iYNt/3RlJOCR216mgrRAjEZoTbByU8s90nqZ35apFKGSt315xQyRHu+5b2rhnhXaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948097; c=relaxed/simple;
	bh=8PNWb8f5FF5xUid5MxaKNsCFti1xv+NLEa0wWHyNbBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTZpWXa2cyYzQhuam4qGvRuZXCwLftuUvWQpoLJJHeHlOJCAuwzNmEBHavhKZsbedMJ5kU1W8KlqBiNwgBUSPfKV5exXFznm7a9sAV9dVkDS7e3mhx6U4sKhY4pHR3dYDefYswJmK7GPgo8LPdeLGR/63wr01ImoOD3wEY4p9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akXV1s/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727948095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
	b=akXV1s/OXdxs0FMV/AkF+P5IKBUN7jLraCfcyPYDGZVNMLiZq6MKcxz94as/DnE9uxwSx7
	qvA7Aw1o+h4bgHlt84+3CXfJBSm9xreaQisvNLkljqPLEx3VjTP8kLeBhyHkFxLTB+alCw
	ZahHVtysX9U+jvSvDbhs/lCBOa69ZJs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-dZPGXcxBO1WkTP6lpTUIqw-1; Thu, 03 Oct 2024 05:34:53 -0400
X-MC-Unique: dZPGXcxBO1WkTP6lpTUIqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso3879875e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727948092; x=1728552892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
        b=WItBD2QhUrdNSBxVSKLXSwiWQizKZju6qGu4YVI7n3NowZuCJkAEGWq+i4mrx993Ne
         07flCAxPbd6M3X5qFaoAjhgKjxv05qtsXzrRlIlSQyoburjFMfM2hLz0rFjvWkEkESld
         zUK8gV5u5Ck9lDpWOQvMwHJdxSfzhqMtPGr8xl/yPpX9Vg9xTRh/QWttES2IyyY7kvb8
         D8zIefyDYik3Znj7W/TjDmMZ8nIa/1mB4U4ukfxY/zYwiThDWqoELNLB+O0N7eiD4B+m
         FHiCmjQuYJsHj1bCYy6VbL16xOM83xJL5RS6/SjSsnxRsmQBkZdCS5ezKZdLX6x2+gH7
         amFg==
X-Forwarded-Encrypted: i=1; AJvYcCXELoo+dNhB5R7rASpLxgsIY5d4Z+i4F2tzM4dn825kXM2yiAMGhYYQMzB9Q1xeegmB1QTl9ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiuAMREXRhqXz2K2D3xp47j/4hELKLKKFJc17NkK7OaSeqkVz
	CkVvnXtJTZopIZ7FAgfgOIT1Nfr5+ac1hOfot8L4CQrphLLPTKuGJp9l5QOghxqaLeP/0+vrP3m
	UcUycCF5159Dofprxj1PSwLX7BtCHk0kknbDTi7OHkjeXqXQCGr56Wg==
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752525e9.12.1727948092112;
        Thu, 03 Oct 2024 02:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBowI5zhEycK9k+WgMuHJJtTO0OTPJ5Pur5BI9oIv9qrWES3L7uxAbpAFQkDhtkECemtMfmQ==
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752385e9.12.1727948091654;
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3edsm39844885e9.7.2024.10.03.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Message-ID: <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
Date: Thu, 3 Oct 2024 11:34:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 edumazet@google.com, kuba@kernel.org, stephen@networkplumber.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 22:54, Haiyang Zhang wrote:
> The existing code moves VF to the same namespace as the synthetic device
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check to netvsc_open(),
> and move the VF if it is not in the same namespace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

This looks strange to me. Skimming over the code it looks like that with 
VF you really don't mean a Virtual Function...

Looking at the blamed commit, it looks like that having both the 
synthetic and the "VF" device in different namespaces is an intended 
use-case. This change would make such scenario more difficult and could 
possibly break existing use-cases.

Why do you think it will be more consistent? If the user moved the 
synthetic device in another netns, possibly/likely the user intended to 
keep both devices separated.

Thanks,

Paolo


