Return-Path: <netdev+bounces-170179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06888A47A00
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0C33B0213
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA59226D12;
	Thu, 27 Feb 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHwnS8UP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16F20DD7A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651582; cv=none; b=kokTRBtIGsleGoiWm3PEs+wsfxa3NAJoulxreX8GmgCRo5OVzHBiJ3Qa3qltcpAKQ5OZFusjlSitZyu+vimBbTKteUy4e4gaCqy2/hlZ5mMiRKmJzT7W++uYdIjxPGZY0qNXkx3NFTvBhF2z3Dj+V2xULZ0eY8H7YBTLtqZlLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651582; c=relaxed/simple;
	bh=X4JPAH/sc62VN1bVz4QgZMmPV3NQvGqMYU+FfWMtWCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEb2gsiaJ1Bq1u+azI4KHBL/SLC1BBiCp/PS6iUg0H++cnB9/tKpdxoNpQ2RfsrqbKXuBL6SLo2CnByYZVuWB7be5EnAyvanIagIUSSKhnjUTPgNoudUmZJQ2xcwE42bKGpAKiMQMdOTAQeJHMT2MO1EaE6NKxEzsOvH6srmtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHwnS8UP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UFnZA1KqxUR4AS86ehSRALNopd+p33rY6Keht7Hkxc=;
	b=fHwnS8UP8fbj7Mjv4PCRt0babRgc+bH6QcEl5UrKHsMgUrouftcs4ZxHGQbop6mxk73hp3
	kgLogSXoU8+6+W0+8GuowL8yAeNBL+OQ7mT6EI0Z9zAdD6JcLwWyXCg4pkFZHCEMJm3S8p
	J4wRX0x/xMetl3nSzv/4hJEjVvqs24A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-79-NLlbXNdi05-hOQ7u2PA-1; Thu, 27 Feb 2025 05:19:37 -0500
X-MC-Unique: 79-NLlbXNdi05-hOQ7u2PA-1
X-Mimecast-MFC-AGG-ID: 79-NLlbXNdi05-hOQ7u2PA_1740651576
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so3976685e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651576; x=1741256376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UFnZA1KqxUR4AS86ehSRALNopd+p33rY6Keht7Hkxc=;
        b=O086z0uzIjfTDZvz/9/wLpBlmWMRa3ppxRtgfm8WuOghRZkodWd9hdl8em1IkS2jkD
         X0YNcfVLD6iBTZd08k+edbHw23P8oHjzO7gG/1NEcG1i3xfygd+tj39g8vGXkzFBJnQS
         wDEBYmt9ay74JtcugW6Q5SU47NsI3+FfIgw4njK4HGhfkZkf1YM95/Mv7JXow+mXORnn
         cLUEn8yNfKOEhvK1MAu74+f6lYuP45ymEDFBziOb2DrkmH/NH1ovP4AaWV+gR3SAwzPN
         u2W89eVbG/oMnLP59EGEJqo1io15H8YwYDvqK7UIT9OV9oIQLLaiUF4DO+O+HwLq+q8K
         klNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGOnV46a+DZMqN2+VDL7j4Tk56mPFalPJ8jAgM7Bd2Dl/TsWXZqkeitCTRnb/jpp/EcmFpVBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+cnal2CW9dG1aLvnwC8x3/xjDG4dlS8Bh7kRbibk4djZYK17
	ck5GcsxJsx8Th8KeSUpcSOTZZLd9o3vNvbeFUOhChlJM20UBYvKAEtwuDMzuSSV/nJyZpOZDIFP
	8GUzb1790+jVKgcgDo00HYN2F/Uixo6T/GBs0Zwo+fzGcrJmbhvhXML3YSGQ5Vg==
X-Gm-Gg: ASbGncuSmkDdTXvy0BD2vkqWIvkOsrGS+OUSKtnCwnk9MM8kisY7ObwtkGuGpjopPCS
	G+0rxeE4Rfy4hOvSUHfk8RTdKRt9a77JgffNLmI9Wb6lEZ60ysp7OhNFVcJgJFmf5i+MNw1FVZp
	Nz1ypkvySrExWGNTSqHRolPPX/I9f/iYmf8wl27CKGrSKp+wBdzi1AVhQzgpgfRAQZHmuPLTxeG
	gdislkVUF+89IzqUuunA707QdletQbyQtbqlXxDO5hzZ6xwXwBLBaGNsHQQnyq908S78Ynx0XjK
	LkcgG3ryrf886WOaCKMSnuwHSy1eaM/eVKZ/M+QE4xav3Q==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-439aeb2b5d6mr213595125e9.15.1740651576144;
        Thu, 27 Feb 2025 02:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Vft26tcnQWraFswBGjedEu4sbaWKbanioc5YQRLPIC1rcPLoyFw5Ul1m0g3Nh69fGEHqEw==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-439aeb2b5d6mr213594825e9.15.1740651575811;
        Thu, 27 Feb 2025 02:19:35 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm1557821f8f.73.2025.02.27.02.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:19:35 -0800 (PST)
Message-ID: <02e13783-1f87-46a7-9396-96bf17e36a9f@redhat.com>
Date: Thu, 27 Feb 2025 11:19:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/8] net: pktgen: fix mpls reset parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-7-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-7-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ae5e81e62733..bb13a4591709 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -915,8 +915,13 @@ static ssize_t get_labels(const char __user *buffer,
>  
>  		max = min(8, maxlen - i);
>  		len = hex32_arg(&buffer[i], max, &tmp);
> -		if (len <= 0)
> +		if (len < 0)
>  			return len;
> +
> +		// return empty list in case of invalid input and/or zero value

I'm sorry for nit picking, but C-99 comments should be avoided

Thanks,

Paolo


