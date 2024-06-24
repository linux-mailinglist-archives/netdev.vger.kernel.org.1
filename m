Return-Path: <netdev+bounces-106257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E220915921
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032AA1F24171
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068911A0AE8;
	Mon, 24 Jun 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hilBePT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513171A0AE6
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265061; cv=none; b=uNLMaeMqS7xQIMj6aoXq5jPG1YKyLZf87l12/gyiOE4C9XcSgipmwzfwozeO62iER5QGMATQJaZ0HnJv9q+ZrrurBuJXsZEg3UCQAYXUGzFQMzV6OV+7EfEdT8YCEQPi5Y+jGM4nYSLZGGPHsmsPBxEzV50cRzHH098sj4Fweyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265061; c=relaxed/simple;
	bh=FW7T6PMFn4ywvR/rtVoyuYFWTcaMPvvtOmX4HG3VKrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlw+LNvE4Y7xnCrFGy7TF2VW8pT141H75YBY9zspcXiDPI3L4dbGXyUfNarmu8bFnyfoO2cbCKUpN5xBOWunUhyiaqHQl/7qnwfD+c0cOp+H7mA2Ty0IK7j8LaKxCBimAxDmHx1sW0yPgzg4cLENyGKHXdv9wwb5uhZpIzUf/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hilBePT8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42108856c33so34505465e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719265059; x=1719869859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fcCb9JJmvsk4sWgE3oZNXFPa6PXHyluDbi5m6og7FZA=;
        b=hilBePT8kmi5ypetZ20zzx7C0m2DfFqyMkWa9n8jcQN1huy5HWq6Z1QJACNm5T5yGA
         fp/r0TQR2aG7E60n4SfA0T2YQBgHtGND+CTJgcjecMjw5dyo399e40Z1971cEvQZwnxt
         fuFfiutPXbAsihuX0uMcrqYqzpws2Hjd0ovx/1PwqCTiqb0UYKjDy7f22S5w/mw5dRvy
         D7ijOR34+P6W36n/hIFZ4sJbS5oIeNTAEMwVLF8WSVlgoJgj9y9bv2lPHVUJCmNrK6r2
         V8Ih/js04rAqK3yOUkfHQZ/He9NUHCgR0q/SMyhe665ZGJWen9tAjmAbFv3kuoW3ylF6
         XW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265059; x=1719869859;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcCb9JJmvsk4sWgE3oZNXFPa6PXHyluDbi5m6og7FZA=;
        b=cCtG/I8XUopEoOnUm7R2KDaAIeYWhTk1jMBBtss7tZOdrmmjG3eUIjrYFk3iyZpFCH
         6mMQuJLC+aGKpTs2ACRnN2cio9KvBOZwVhLtyYE9Zz7HW1XMdwiBXPAj7/mdnykO2uW8
         0YRsyGG1PlSpMkA5xcY6biX9bA9Hu11LvEo9tEnyJdqpyms+M6DCHUUK3MWYfUUM0AM5
         PhODzGj+EMHNGyEtUZwc7qbYmXoJNOlKLueVB08zZ8gJPKXzzCBRb8QouNn/tSGbDdkP
         02yDgJFXY0dY0TzJVVJ8V+TIifjeDFBv6u3Mon6ONtm/5+oCi5aXwR8+d0QTlZkXI4Wt
         aHLw==
X-Forwarded-Encrypted: i=1; AJvYcCXGf7LPV3N+HHwmZk/LpgPiHxUMMuTkkvBzeRGJVYi+g8EhM9DLJWjgNqctlBBih+TJJOcakFT5EI3OeBbTPSZsxQQQd7E7
X-Gm-Message-State: AOJu0YzQETQzCaUMgKL3GERWvz0yJrDe/+ScLZ4p3w7Ai2nIE9CBPU0Z
	IR92sX5XRXrHNVLrdtuRYf554OElwg5uypPn803P6FXz3iYhI2TNMzQ0D9m3C9o=
X-Google-Smtp-Source: AGHT+IGaZxbWTiVdlucmCc1Rm016TjkXIPZYNAujjXwc3ll8ZzaGl49Az5sMXirS8+gmDAlV+raPkg==
X-Received: by 2002:a05:600c:35c6:b0:421:b65d:2235 with SMTP id 5b1f17b1804b1-424895707c9mr68401565e9.0.1719265058649;
        Mon, 24 Jun 2024 14:37:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7b60:57c1:c75e:3561? ([2a01:e0a:b41:c160:7b60:57c1:c75e:3561])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4249b557c42sm1785215e9.1.2024.06.24.14.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:37:38 -0700 (PDT)
Message-ID: <d4a3ac6c-3a4e-47e3-95ee-ce01be88f13b@6wind.com>
Date: Mon, 24 Jun 2024 23:37:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 0/4] vrf: fix source address selection with route leak
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
 <20240624133039.5b0eb17c@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240624133039.5b0eb17c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/06/2024 à 22:30, Jakub Kicinski a écrit :
> On Mon, 24 Jun 2024 15:07:52 +0200 Nicolas Dichtel wrote:
>> For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
>> I suspect it has been here since the first version. I arbitrarily choose one.
> 
> I think this breaks fcnal:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/654201/1-fcnal-test-sh/stdout
Thanks, I will have a look.

