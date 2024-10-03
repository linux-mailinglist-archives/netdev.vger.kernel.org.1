Return-Path: <netdev+bounces-131520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1C98EBEB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AF8B24142
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179B13F43B;
	Thu,  3 Oct 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIRWbWF7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1413B2AF
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945755; cv=none; b=hFVx8Z6hfLB8coF79UNzVyw9ucbRvI85m0n0Z38sNJM8ChBH2uAO3cZogmgPXMiqAJ+sAXYjoGUJw+6nMR5BU9UqJt22Kwgy1yNQPeIPX2zuSbKT3mGagJQ5+GlI0Wh3Ge6tohjaBGdZ94ADnNZ9Pv/6L6prTJfLJ5Dp10SAAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945755; c=relaxed/simple;
	bh=/ls+Usjj0lpRKVwE40z6h46uE7yUpqkPPHw9jtcK6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCnw/nFQM4a40skipiUFW6RjWo5F7Xqh6d7jN312iyDcU81EpW1kz7gnCs9AXH2Dw7KlqfnQ0K12ZbniQYct83TV6YYU3z+5n3i8hsVRIdeqGzWyTodX199dv0X2yX9NWIX9+xlok9zCIHquJPdGfbjjwSxiRYjqDmGPop5XxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIRWbWF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727945752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNyleeSBIrkoz+o+G4sN8Sg53/W0Jp8BT6862q5Zags=;
	b=CIRWbWF79J2p9X8rq4t1BEuMTEE1H2imxqNLhKV4GF9p2RGydj5hrW4cJA8pNabwfTXgeK
	UjLyW1DetIkNbSLpTSyj3qYgvx1bHoIgacRaz27qltQ25UwLJxiMys2VpVcS2XDHuDqNHA
	yYBWmeDOmeEIEoHxA6E5RUPSBj14HKM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-l8cuuFEYMiqvfD9DUrU1LA-1; Thu, 03 Oct 2024 04:55:50 -0400
X-MC-Unique: l8cuuFEYMiqvfD9DUrU1LA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53994f50133so564083e87.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945749; x=1728550549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNyleeSBIrkoz+o+G4sN8Sg53/W0Jp8BT6862q5Zags=;
        b=AjRZPbzYjfxPHddlMF+oGojJlVc/x5SCfjz1dSJXuOTPkCk/EhZ38IQiYVN6bOBvRy
         V+iuTd07VlubRV8qvZJxX8/S8inIJhROM+31yPJQLly8YgIBG4AmTLqFHcfQMVZ2lKxr
         jPzvN76Y/i90wLbqddyuPwUu/Ci9QOYKNcpEt+3Yg4248fqCoy5ZwY43OuKxTq/3EEPn
         rPKAGZGh+yiFYptgs47RYJWXaMMYBp6cs2yMiHminhn3UHES2igKOLAUC0enKRlwQYwB
         ayb6UtMjrDLQK8OXbKWb+bs5jkdeKc4FFAYHzbZC71io4oOpToMJcMLSOF7uvRuGq7xJ
         zI+A==
X-Gm-Message-State: AOJu0YyFlqGDzTU1YbhNE1iF1fbpIryzFFHtZ6htW+xBbLauzrCoXCTM
	dJc2REBUc230N1TFcalLobMikjcq4Ju/uwPUzCQBv4N95c7QcJ0uRhfjdYnTwkRBdlS5Z7hAwU0
	hmopgbid9Wc7cSKHgz3/n3ABcIujdQRpQM2GNvJ48F8icKz9qbjCOeQ==
X-Received: by 2002:a05:6512:1054:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-539a079f5e5mr3663106e87.42.1727945749289;
        Thu, 03 Oct 2024 01:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7QwxJ8KaZj1SiIC8+qvQzggg+ESKlt1wUj9pnPdfIIZHMWzpqbpbEcdhtk92ID+wFhtG63Q==
X-Received: by 2002:a05:6512:1054:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-539a079f5e5mr3663091e87.42.1727945748883;
        Thu, 03 Oct 2024 01:55:48 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0476sm10011435e9.35.2024.10.03.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:55:48 -0700 (PDT)
Message-ID: <a9d896a4-b279-41f6-a492-980340e125ac@redhat.com>
Date: Thu, 3 Oct 2024 10:55:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: retain NOCARRIER on protodown interfaces
To: Volodymyr Boyko <boyko.cxx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927073331.80425-1-boyko.cxx@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240927073331.80425-1-boyko.cxx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 09:33, Volodymyr Boyko wrote:
> Make interface with enabled protodown to retain NOCARRIER state during
> transfer of operstate from its lower device.
> 
> Signed-off-by: Volodymyr Boyko <boyko.cxx@gmail.com>
> ---
> Currently bringing up lower device enables carrier on upper devices
> ignoring the protodown flag.
> 
> Steps to reproduce:
> ```
> ip l a test0 up type dummy
> ip l a test0.mv0 up link test0 type macvlan mode bridge
> ip l s test0.mv0 protodown on
> sleep 1
> printf 'before flap:\n'
> ip -o l show | grep test0
> ip l set down test0 && ip l set up test0
> printf 'after flap:\n'
> ip -o l show | grep test0
> ip l del test0
> ```
> 
> output without this change:
> ```
> before flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	 state LOWERLAYERDOWN protodown on
> after flap:
> 28: test0.mv0@test0: <BROADCAST,MULTICAST,UP,LOWER_UP>
> 	 state UP protodown on
> ```
> 
> output with this change:
> ```
> before flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	state DOWN protodown on
> after flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	state DOWN protodown on
> ```

I'm unsure we can accept this change of behavior: existing user-space 
application may rely on the existing one. I tend to stay on the safe side.

Paolo


