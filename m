Return-Path: <netdev+bounces-226464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C456CBA0BCE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7C325791
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DC2FB975;
	Thu, 25 Sep 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZOS1dRs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9119F40B
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819867; cv=none; b=rMU/dhPOYgORBSesfvv70kaN4ck57WUsT+Zaxgg+jHgfqxmnDFTiWFMAM7Fm9XXhl9OJwqxUaZDRZO/YMi8qMXM2u1g8tR9rY6ZMubeJb6Q5LtBKbD+ONl40az+h0VVZjowgPcQwPsICA6IDGNFXVlV3hAhyTvOnxbIq0337yRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819867; c=relaxed/simple;
	bh=44gyp6vKdy1xn+uQ05Jc1VwLiYdISbIi5vZyvpU5pko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAPTD/GaJ1zGSVY5ITyb2TdutyVmkMQED36CZdF3P/u1rQZMQXwK9kZeJnJXkO516dajXdXD0+2yUQWxXeokrqXadsHljR40YJ6VH6pL92Q75hoZ2bXUUc70EUCnZgqvbL7MjeVGnt8PRxBk+BSJ2CaShR4w5iuTEAcWsD/a3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZOS1dRs; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b61161dd37so8182041cf.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758819865; x=1759424665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FedGuuQ9EoLGZHyVuUa4kxaEEe0W3EgjNiYDYZcgNxY=;
        b=LZOS1dRsOjl4u9mFMtt729T+jKuVkUPK4tLy7imvuwkV1byI8gXYsnvJx5C6A8ChFu
         TtY2t/1+B87RzZiBOHylsVEeicmXeb+ryzkLukYSf51bQM0WkHMRn7l4WFpxsU5KOvyM
         jr4FkGBFS6vCcPYdnaAgMiaoNSuQL2S/BaNwu7bwfZeKJFE93/BAZ3VmhTVvBMuGmR50
         QbxeITVwYUhbboBISoz5JXwZg8q5Gr63DkHXQ0e4UcLRxOIkbVGePx7oenQ121zvl+hL
         lJBmCnPs1LNonSyXvZ/PA/O/vg6T2fM8iEfu7HInl1jV8ncD26sMc0llQ20cN2wzGRJA
         icEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819865; x=1759424665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FedGuuQ9EoLGZHyVuUa4kxaEEe0W3EgjNiYDYZcgNxY=;
        b=qyOLLQEnd48Y1QgiDEGrcNAUwKYTo1FtUkJKVsI4e4LXOXCxqfJON+otj1k+Cvcl2/
         UUIv/b1oDBecsbN4tCDhr2eUQLkKcu6QoBqZMrhPGfk4KYFkb1+tnouPL65HLpjgcxNS
         8fyZKKUbpJ9ee/2QzczKxDFJSj3ZwC/Mx7CMK6WiqKAj16dKW2/hpMI5TcuGZY2ntRG4
         MfqE0T9reHCMjA4iQdQOgmgweoGh39mUdJ9XaruV67cyFL7p4ht1ySOIVEGpwh6WC4I4
         vx73u38RnEhzhE/wlvJykyU7MyxIj41yUZuBlj1oCfEeHHFOSOFQfYLwlrgWDZ5SJsOF
         b1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDnM4z0AnmZFGgaK4ZrsoK2+CctdL5AzcoQCKNT/MKBAJVf300ATv6GkwnUMfpsayWhsymxdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/1VPephx+CM3oC3OOLtJVWUjeriPs0wxqYVgg8xltIj9tisu
	NeEUfPgF9Kyd/k5bfgex6BoNI4dBqFaLxNpOOppUR+MpBbxYwTbVNtKqbDDw5A==
X-Gm-Gg: ASbGncv9SIHaqEeHW3aaoAKd+Pi+OsvWyctqK2OXaWb0YCLXOeUZYfVI+lOR8lyntLr
	lcIjlC7ElX13kFJsodNBOwPtEA7QnnnwmXH+0U0/6NKQMNQ02AduqiQ4eyhO9YJHAC9hgh10qjD
	YUxbJNmixVg91Pq+b9mEmy6WDmiW0qLDmSfdyWhqdF9XUJT5e8zCMM71TB5Xvki8m1zHcOcBxOj
	f7Jk9IuUo8F0lz0Z+QKuTXeJ1zPxp0J0xSZrX2QFdKiN35KZku8iItPcECbWbja8XTRXl/zPUYY
	JK7ejSJ3C8++ZeiR/VJk5Dy8P0VArvEkUfNBQ+DgNN4AhKfOWslTTxq4BVSjv7xCrDQSRCdCiDN
	XwvoYkiHlIHcZfG7v6VDxELLIGjMVV6UmFEucHg==
X-Google-Smtp-Source: AGHT+IHB4nL1f17zZ3DDXlsvZ0gPqjUEC63iZEjaLTYX9Xc6Org1u16Qu1czS6Ft94AAeAs01OiPxA==
X-Received: by 2002:a05:622a:4111:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4da47dfd4b9mr54903681cf.24.1758819865241;
        Thu, 25 Sep 2025 10:04:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c9::113c? ([2620:10d:c091:400::5:846b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c286b424dsm143564385a.15.2025.09.25.10.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 10:04:24 -0700 (PDT)
Message-ID: <7e099b09-75d3-437b-a1d3-ed964032f9b6@gmail.com>
Date: Thu, 25 Sep 2025 13:04:23 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] selftests: net: add skip all feature to
 ksft_run()
To: Petr Machata <petrm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Breno Leitao <leitao@debian.org>, Yuyang Huang <yuyanghuang@google.com>,
 Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
 <20250924194959.2845473-3-daniel.zahka@gmail.com> <87jz1mwksz.fsf@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <87jz1mwksz.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/25 12:09 PM, Petr Machata wrote:
> Personally I'm not very fond of this. Calling a run helper just to have
> it skip all tests... eh, wouldn't it make more sense to just not call
> the function at all then? If all tests have PSP as prereq, just have the
> test say so and bail out early?
>
> Topic-specific tests are pretty common, so it's not nonsense to have a
> facility that supports that. But this API just seems wrong to me. Run
> these tests, except don't run them, just show they are all skipped.

That's fair. I will change that for the next posting. Thanks for taking 
a look.

