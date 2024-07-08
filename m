Return-Path: <netdev+bounces-110020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8230992AB1C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3204E1F223BA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926114E2F4;
	Mon,  8 Jul 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="I6Q6IqpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A11CD3D
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473885; cv=none; b=ou4qTZZQqNQI0IE9d4DZ5pUkRbzH837n06CJNfkWUNdB1MKKiXpYdVE1vY0uCmWy9utiBewI9SwaH2Lqx9KWrfUOUjyKKA36jbhYpfLSV89V3NIeGplDHe2Yj1sw7pv5dK2hYJRtC1cYTGUTJrQA950Uy7I/hL9q1w7SXgOBvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473885; c=relaxed/simple;
	bh=r6JNJ3bHNYV5p8EJ3iBKvIKvkBSJiAWuzo9z+/hOTsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB8QjQmG9Uzt7avlLBFDewdDtN3apyFSXBuEeMFzrpteLBfdZwyt8/C8a8dBYN9LAV/qnzw+RJXgPciW5unIhILpQSW/sok6aNnEIWjEnbdjMiWVZnT0vLViJJSIIwFJfUzB/adF/4wGYtJMVx6moVtlYPmph5zt8ze2ur3g15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=I6Q6IqpJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4267300145eso686705e9.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720473882; x=1721078682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4LZimcEUz/7TEVRYb34E0KsshqIeGH6G9ogVK+utoeQ=;
        b=I6Q6IqpJaLh+PkSjNBz6YcyQwSeA3I9rkO2gAl1gYF0sP39pR4NSmUGU86kWh4NyaS
         0zWEp5VbOn3GLbRSESvSBo1nowvPjIoBtvCVauy3MY05nb6ilqUxMrKEvlGVQ4BzxEff
         9PMim67rR6DUxLS9b33U+BO9fmzcHMzqQlxteAi4eMXfSbOycVRul5GfbCguTwcb6H4d
         wQ95IWx5NRWO7gvdeLEc5eeyUk7k1pi4zNQCA3V8yT/CEjc0/Q1YHHvrHuOGVflpjUPb
         XKwzKheDcbITNJTVWGQ7fFDiJqpI/YHDZwaHnPzNz7w7FfgSX40i/DONUV4QZbUyTbWx
         WusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473882; x=1721078682;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LZimcEUz/7TEVRYb34E0KsshqIeGH6G9ogVK+utoeQ=;
        b=ZidBFMKVsBOl3CufZ5Vpykurbp42biyGReSWTzlpkkjBT309x5TtEkywgNQQbc5v16
         LeYXZj9MDzCzfVn2Z1Cm3yUN4QW1QAcQEtPdI6XV15CPBq4RVBY2r8F6GgpMKd7PdG4k
         Rib8dvcm2knfDfPwNf795hy94WdhFYsZwVOjYT/P++u24dPYO1v0cYcbIJvAFVz/Dz5T
         buJPOfwevxTm3ifTivkmuQOyvX5jlca6zY8lM1FHDbIEl7TmFmHK9zHTwSQ5V1xFuF5t
         2VhGkYQsD3D31EUU1QHZgdaXvh1SXHoS2v9ARn7gMAqfnq/QRd4+bfNWZCbTDV4OGLid
         YmIw==
X-Gm-Message-State: AOJu0YwP9FWq9XNT9cYRbee/mpSLZjudWOpyL6Bx7aEpebQ8vTt/Jpbn
	uX7nO2srcXwWqzORnDw3XUDCCp3LAtqFHPH5hhQBgbY4p1f/3mekDzPQ5b6iO9k=
X-Google-Smtp-Source: AGHT+IF83CQyw73QRLMXq7cbWGfMIPSB53neo33ZMao2tQxXHBllDIajkj1VqoLlIcrvI8xUM815tA==
X-Received: by 2002:a05:600c:2d48:b0:426:55a3:71b5 with SMTP id 5b1f17b1804b1-426707ce9c0mr5190355e9.9.1720473881865;
        Mon, 08 Jul 2024 14:24:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f03c:44cd:8f8d:23c? ([2a01:e0a:b41:c160:f03c:44cd:8f8d:23c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f1d51sm11754215e9.17.2024.07.08.14.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:24:41 -0700 (PDT)
Message-ID: <805cdd1e-3190-4074-8908-85e158db4855@6wind.com>
Date: Mon, 8 Jul 2024 23:24:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] ipv6: fix source address selection with route
 leak
To: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
 <35638894-254f-4e30-98ee-5a3d6886d87a@kernel.org>
 <10327c0a-acf8-4aa5-a994-3049a7cb5abd@6wind.com>
 <9b223661-0fa1-4f9f-8d35-b134f312a491@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <9b223661-0fa1-4f9f-8d35-b134f312a491@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/07/2024 à 20:44, David Ahern a écrit :
> On 7/8/24 12:15 PM, Nicolas Dichtel wrote:
>>> !l3mdev; checkpatch should complain
>> No. I was unaware of this preference, is there a rule written somewhere about this?
> 
> checkpatch
> 
After digging a bit more, I should run checkpatch with '--strict' to get it.

Thanks,
Nicolas

