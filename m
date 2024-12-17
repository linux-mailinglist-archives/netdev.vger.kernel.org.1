Return-Path: <netdev+bounces-152551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679059F48F0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8E216E9AA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCC1DF965;
	Tue, 17 Dec 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikc2keFS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C11D5CFD
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431583; cv=none; b=CYYaLloz05KHkRg4ux68uP2A+Ia0TE673VOXTsybW2A9OqAVI6h6Nhx92knGg6fXozpMQZaiK+a+lfcn5mkNzqEMUf31oW1vR2c/khk6t8aUwnR3e+ex+VMDipWDmYK3VEpeLk7zyvohL9IQKgy1iU2oJgUAzxBx77G01uNfQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431583; c=relaxed/simple;
	bh=6rGKn3qT/mO5c+YlIZ8yHQqEtuiYDyo8QCNvc9Fyvyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8Zh+F66TbikFvi6zX4FOXJH8WPJsl6BX9ZGVbzzg5ooj/XwLWZNry5HHj0Agit2qMVznQKQy2TxnMHmu5aLFUeBE8aLPaZCACC3XltFh0JYO9aPfO2mYoXabc8ZfzhR/FSWhdEoQUsi2qJ7lUIFWTtJdMRj3NgxyXDLj4Hnck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ikc2keFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734431580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fDauBQW3M0WEiex98LAZAecElQ9kepp9fQATzPbGEU=;
	b=Ikc2keFS+QWI85LeerDz7lEun1QmNH+/nAJqclm/ZCGPNBJtpuQzHJ0dnHNCfzdKJfJTOp
	S7q9YB0s9qG58VJFbPFtJkez/fvRUGEFLv9ilAH/N+N5PUEHm/6emC9L4ArmQTcUn8rLJU
	Fux7iF0pWV6ozWxqgKqVCVzAotSUkqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-cVSCEGQeM2OZQX26nkKEXA-1; Tue, 17 Dec 2024 05:32:56 -0500
X-MC-Unique: cVSCEGQeM2OZQX26nkKEXA-1
X-Mimecast-MFC-AGG-ID: cVSCEGQeM2OZQX26nkKEXA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso21650835e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431575; x=1735036375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fDauBQW3M0WEiex98LAZAecElQ9kepp9fQATzPbGEU=;
        b=N4rfdVvh5fcjKqeq0unQzJEYwdSAZBbpc1Dmz8LEf5X9FHd3PlGz74ku9BWN55zSKw
         lv47n76OFLFo7DEzVojMOpmVZNwfnlHSYNu+a1wlaGYn7hZS2N+8cVOueNh5eImlCO4x
         XURjsCMwGfegyoC2/ae/BzgoVp+zek+1NOD1e8K/pIC0b8nQxKHc360mb0/uMOm4zc/A
         qDlE8taJQM5kY0ONRk7x+N2/lVZ5aj76n6Q9ex5QN+zWEIlsGdX0Y1M2h5n0tOb7s6/N
         YhUsk0CU3p7Rt31GpKHZpk9o3pmu1+TU4eBV5EI99hF7pNkp17UyphBtZpjJQsvgDaZ3
         U4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTPRu2dpEkzY7BpmM4BN8+O/uIKQnF+QWcnzoaZbp73/WJ1GIK5JCXig0LKPKMB6QndlgFaXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebQBxW8aoJu9j62QVS5lrk7L+ROtaWTnw0OS3EOHz9P9fOtfk
	5mAkx3FExLHYlTDuVuT9AT4IlK93bqEslBDhK/E94YZFolgHuifX5cfrjubwG0ywd+va+4mKmrd
	n/KxmHO6KOf4kA+KQz6x6rq43NJDHYI0LbqK/imf12DNG5xVvV4C1zw==
X-Gm-Gg: ASbGncuDZIpRYT2baFvNP2EeVFn3MsEz/pu8x3KFXn2O8CGZnR6N5IQGi4xdxRkVXcP
	DrIQbC+ZADBqsvBaAvE60vYbcMIOLoOo8oN8Zh1YilDAWjcaWU4OeOLpInWJny+h9w9G+l1t7wx
	ddqQHKrwJrhAC0RRHdTtXRPn88xhGxaEuocwxM0ZqQ5PuKSBh4qf5cmQwex1VddqmZs5Yml/zTh
	kC0t5SXuDXfwzNUpD+1bPuilj6BLXNT4AcKX5yyXDhZKhrzEUKlVAfAEwRCzTWrGGTcAoet/tTr
	9Qa8hdNwXw==
X-Received: by 2002:a05:600c:4e4d:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-4362aa65d40mr155620815e9.15.1734431575508;
        Tue, 17 Dec 2024 02:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl+c/KutVHcXjNahdJk8/5T5uByFCeqRRqrBGDbk2NOnkKNFTLKn4ZCw6p8VWNlDlRvAQX5A==
X-Received: by 2002:a05:600c:4e4d:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-4362aa65d40mr155620495e9.15.1734431575167;
        Tue, 17 Dec 2024 02:32:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm111674435e9.22.2024.12.17.02.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:32:54 -0800 (PST)
Message-ID: <74cc9cdc-e74b-454f-9091-e39a214f153b@redhat.com>
Date: Tue, 17 Dec 2024 11:32:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 15/15] socket: Rename sock_create_kern() to
 sock_create_net_noref().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241213092152.14057-1-kuniyu@amazon.com>
 <20241213092152.14057-16-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213092152.14057-16-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:21, Kuniyuki Iwashima wrote:
> sock_create_kern() is quite a bad name, and the non-netdev folks tend
> to use it without taking care of the netns lifetime.
> 
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
> the netns of kernel sockets."), TCP sockets created by sock_create_kern()
> have caused many use-after-free.
> 
> Let's rename sock_create_kern() to sock_create_net_noref() and add fat
> documentation so that we no longer introduce the same issue in the future.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

IMHO the net-benefit/LoC rate for this and the previous one is a bit too
low.

I would avoid the rename, just add the documentation and instead add
some suffix to the sock_create* kernel variant acquiring the netns
reference (sock_create_kern_netref()?)

Thanks,

Paolo


