Return-Path: <netdev+bounces-178560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053CA778F4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD9C1669E7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590B1EDA35;
	Tue,  1 Apr 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwLpBN2K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC31F09A7
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503795; cv=none; b=QlQucIHxDp33bK5d/E8Cjf5IjiaKyyrSV/KD8vqegM8hxJlptaVXk9sg37h1i0kP7e5eX3tL9ZCmwTmM32Jpu0cFgP7x1MiKskJZs4ly0FYPi06NFBJ9k5i16bBdTE8QQNfh2i6VJaM3QGbyn3v20v3qBaLZJwJzsbweREGezBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503795; c=relaxed/simple;
	bh=9/EHYs6xpCZI3XSkaJGAtARzqbLbwZsMQFjbMWVvXVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5kuDbQQrtdO5E+L9JvoY8Xk277k8I6bIM7p+3wuqX0Hh0NxcOgYAGre/xXH2/Ic/i4/HYqoAApybxWTda4To9NMDesw/hQIFktHM17gcaVTfmQLLAs0/qOKIGiWhQcOWL2GeibeU9EuRrBLU7qIEpBQj7x0jO/q3GogKRvDR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwLpBN2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irbRg405LqpQNUULtX+WksVa1vDGOOwZVIRyr5VBbnA=;
	b=gwLpBN2K+DpWeACvLO37pagyiQjvM92zhrttb4+VKzhEYdSFMysgHB5ZivItfxbPt0ZZlP
	tbpRN0eqcOCYxUYzd6UXTJgxlcJk6gx6OaeoJCM03ZkX4VhOUbtz9vCwDr83LrpM5ZMVeH
	XVPt297QCgTig7jJzvAOClpcr/RVUBw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0snMkkqPN3-PuLQQBi81Eg-1; Tue, 01 Apr 2025 06:36:31 -0400
X-MC-Unique: 0snMkkqPN3-PuLQQBi81Eg-1
X-Mimecast-MFC-AGG-ID: 0snMkkqPN3-PuLQQBi81Eg_1743503790
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fe32b08so3081489f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503790; x=1744108590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irbRg405LqpQNUULtX+WksVa1vDGOOwZVIRyr5VBbnA=;
        b=CHq1iI8O9fR2lJxQd398kU2yVUKIftfGLhoipzom589UQ6QCP309lZ/WaVBqdSEe9U
         Hhw/bklfMrPmjJ6nfVddau/BJZ98awwuDS3pxlrSmV8HGOC8okcm8agu/BE7UyMNtL4D
         VurHt5c+nnx8CgFpKEDoo1uYbBv7wUBs5uNQYecs23Fq+lWZv2vAn4xSxufhDOygyBlt
         1uxXnUhI5DN3lhmIjTMNt3URryPP8BQhqpRENFvoehhEqem+p9YDVuzVgqKsEbrxX8CR
         bSjqdUrbrhXxxtIAgVc6taLv7Q5HkoNSbFBuBnR5R4BWyqzpDU+JcvhxXjczp7CiNeWv
         USeA==
X-Forwarded-Encrypted: i=1; AJvYcCWrighOIbbM/gm+1VCMZRPSYe/5nUYGS/qEggi4Ldh5LPzdIdyw3dVS230y2yynezPXVP4bNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzels0wKmrhWmWxg80Xej2f8hn7NA2Nmt+Ddd+xz25J6Yhp9+/A
	1nhlQMigk40T21iiZaNiVb5P7v/7/LA2DkCX5+MmezMoknrY56haR0MS48M16pj385dCI7rF/Bf
	jf9nTxl58H4KaJEzy55I97A/kK4ZzQD8kUskaVWC/WSr5i8GkTeX14A==
X-Gm-Gg: ASbGnctTIGJcs7YQEkAso0wYk+f4nyGeRCMBydYUrEV8XErJ4eMFoGz6allx8oKf1Uu
	SSVfi9aTDiImXXBqnOeMLz3NdnHgs4BaboOYlSz8pHpcHF3lBsOBKaOxeJpiCLX+qpwSSyotHKX
	y1NWqTSO7+jMXJ4eISUf7eMq+kgIFUvij99rK4fXNddQiFIxjuJLIUUAKBrZvZhV4ENFgQ3yZ6L
	XTkLsY7U4pNBhmzcUIQWH3+IWdWBWKv3tJl8gRa6IgGTnvCQTAEyiCLbYgUEjtzpcJs80kpHp5m
	TMiLld4OAmq1y/YKEQSv5qwioweGwWuvvNxyRgDI66Q9zg==
X-Received: by 2002:a05:6000:18a8:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-39c12118aedmr10813602f8f.38.1743503790192;
        Tue, 01 Apr 2025 03:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQmtPCHJlXKLKUpS3M2CZ3vPpJsGxYjZZ0dPv5EAK7n+IEZYEck46rKc/h0rEPKySQLP5l/A==
X-Received: by 2002:a05:6000:18a8:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-39c12118aedmr10813583f8f.38.1743503789829;
        Tue, 01 Apr 2025 03:36:29 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0ddeecc9sm12532244f8f.83.2025.04.01.03.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:36:29 -0700 (PDT)
Message-ID: <a9e10c46-c418-4bb0-b366-0a31f35caa6d@redhat.com>
Date: Tue, 1 Apr 2025 12:36:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: remove unnecessary judgment in
 ip_route_output_key_hash_rcu
To: shaozhengchao@163.com, netdev@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc: horms@kernel.org
References: <20250401020017.96438-1-shaozhengchao@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250401020017.96438-1-shaozhengchao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 4:00 AM, shaozhengchao@163.com wrote:
> From: Zhengchao Shao <shaozhengchao@163.com>
> 
> In the ip_route_output_key_cash_rcu function, the input fl4 member saddr is
> first checked to be non-zero before entering multicast, broadcast and
> arbitrary IP address checks. However, the fact that the IP address is not
> 0 has already ruled out the possibility of any address, so remove
> unnecessary judgment.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>

## Form letter - net-next-closed

Linus already pulled net-next material v6.15 and therefore net-next is
closed for new drivers, features, code refactoring and optimizations. We
are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


