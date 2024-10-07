Return-Path: <netdev+bounces-132743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F7992F67
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E91F211DC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676A1D88C1;
	Mon,  7 Oct 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJZcZWx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591561D61B6;
	Mon,  7 Oct 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311365; cv=none; b=Y02A9P9AJseoOWzr0O2svicQyBFJLDSl5VyRJUdRUCjkBED/3KuM5U0inpOaH0HfShI+AbOoKfkToXjiz0d9OWRKoiZNmNYNlZdCUDqoZMdyXVcQ5cWPbUOlaPCDLSOYq/OlbVAIi943AtU9maSrKEvZdEpRUA00fgKcy37+VFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311365; c=relaxed/simple;
	bh=W/RzfjYVv6DChxrW9f6IHL/wmpR8NAqJMEkuwZp3wyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Id+MkEw8bZJCgNdUAK1x9tQleAo+5XbOdOPiTbZ+Ao9CM0KmMVDDURWD422OJuwdIsH35sYocE0BL7MQo76dvu+by0ONO9XpJt/t1BfOQ1/zW2zyX6D6L6ryPVHNZjTDvC6240Rk822qFqKE/S3aI7q5CxsAeoWr/94fyy1q51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJZcZWx/; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so3482433b3a.1;
        Mon, 07 Oct 2024 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728311364; x=1728916164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNQxMPdLPQGiG6CFdOj3sCHGNid6tI7wiHJS+3jAN/I=;
        b=AJZcZWx/pl09MPdlErGtQj1fkRDxdNIYUPkQndWkEGKCKmQNIauLLGvCpXZ1yIgu4C
         nIOBPzaARsm9Jz9jU7KHlKHU/VgIFjpSmTmC2M0Yi8R2zgFmRru5h9yMuDVxac1sqpIA
         D+W0usTg5pSmfzgS7XzM2vGHiL1enceYzlW62NOGKXKolOigoY81Q4EtuO3qoE/dCJsE
         Dit710WfEPqkkOjjKTNlzGRLGHGM4yZis8N6+kkf6Shyn5T4Mh0qemolK6hhVwjcbuQC
         raXIjnY1NrnZFocK3NaPtlYY52Az0QjuO+tczjcVKUtNGxdW3SzN29HL3zlkB5O73F/v
         2lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311364; x=1728916164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNQxMPdLPQGiG6CFdOj3sCHGNid6tI7wiHJS+3jAN/I=;
        b=vloYyQkLH2dSptsp3LO00QC6xU7JvD2TWoXGy3WUNDnd0KlN+M0TPIm7fs+K3Mut8F
         rNVmHzzD/YwlQmsX6QTbxmZ9qHw3LYumWIeSYLpJy7PAKs/f+qVRlKUXMwrsVbb737lf
         KwRRiAiWgDFjnIs1RBdKXraNN25hBpX9HXvbRN+Hup2nZMpMfOJljzg/R00Ck777QZp+
         o24bn6U8QSI8KhNNaGUz9ZdlVeywsvJVh+1ElKcPJiAWoqGpB5SivDgyDlVKr2ZvG5sI
         bfVwlzeUux8l0K6ABoOOlCmAkayECp+Xdnqna4IJ6RC/KhCHcgDBxKtx4J1l9M/UGOrs
         BttA==
X-Forwarded-Encrypted: i=1; AJvYcCXLT6IvV0yIV+VTLAIorVk2xyuspKSYMQt695pgqAVKpExfq+I56fV7W2RZyO06rLY2ISJUtmeH@vger.kernel.org, AJvYcCXr2V4ZU2SsScPWcEiCRKTRdq8aztRK3G4aI0m90UzkdzZh3zy4LC24tb3UMheGBL743/bcdLWdqQh160w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDMjAN9Bat/hySA7Y0cWfLQaa85m12z1MmikYvkDipssPiT48
	qrEdKnPNcr0yedCTog1hh+AYaYyIln6ZdAqZQ09xNNEm/ORlahhX
X-Google-Smtp-Source: AGHT+IGIiRtkKKCUduaI8GCNJogac1D3SBdylmV9cioQC+jHWoCQyQ0/lcyIVAjkFoSJs+bM7fZq3w==
X-Received: by 2002:a05:6a20:a12c:b0:1d4:f7b7:f20 with SMTP id adf61e73a8af0-1d6d3b011d7mr25611937637.21.1728311363591;
        Mon, 07 Oct 2024 07:29:23 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:9c11:1d1b:c444:fe85? ([2409:8a55:301b:e120:9c11:1d1b:c444:fe85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f68320ffsm5030385a12.46.2024.10.07.07.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:29:23 -0700 (PDT)
Message-ID: <218513be-857b-4457-8bd8-c12e170233b7@gmail.com>
Date: Mon, 7 Oct 2024 22:29:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache()
 helper
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-10-linyunsheng@huawei.com>
 <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
 <c9860411-fa9c-4e1b-bca2-a10e6737f9b0@gmail.com>
 <CAKgT0UfY5JtfqsFUG-Cj6ZkOOiWFWJ3w9=35c6c0QWbktKbvLg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UfY5JtfqsFUG-Cj6ZkOOiWFWJ3w9=35c6c0QWbktKbvLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/2024 12:18 AM, Alexander Duyck wrote:

...

> 
> I could probably live with sk_copy_to_skb_data_nocache since we also
> refer to the section after the page section with data_len. The basic
> idea is we are wanting to define what the function does with the
> function name rather than just report the arguments it is accepting.

Yes, looking more closely:
skb_add_data_nocache() does memcpy'ing to skb->data and update skb->len
only by calling skb_put(), and skb_copy_to_page_nocache() does
memcpy'ing to skb frag by updating both skb->len and skb->data_len
through the calling of skb_len_add().

Perhaps skb_add_frag_nocache() might seems a better name for now, and
the 'sk_' prefix might be done in the future if it does make sense.



