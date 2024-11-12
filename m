Return-Path: <netdev+bounces-144110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70F9C59AA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83251F234CF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1461FC7F4;
	Tue, 12 Nov 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MCECX3FP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F71FC7C5
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419718; cv=none; b=YUzfVTy7okJhAhdDzRYSanKZy7Xy6X8ZPhLwH2iomamacYpuQYn3bA70WTRmANzYjkNJTcm9N5ISYLAMb19EBv4AyWPqvvDgk/ORDXNDIYhNLrd1teRinFX4Xe4GAbIY99ArHkhgcbQvKXn562IRbSKkmhnbVrdkBkk6wB09SQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419718; c=relaxed/simple;
	bh=G8xzwS8Jh77VItMhM2kqDI9VqlIXOP4adNbvhnBqD9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUQctq3GqGzqM0mX13jQeqh/j9LzSNDSi/rjjJgtfs0Qr53drdZpvkYC9h7pRA4/gu1QfWHPxpe3L2AkNHQPisREK1GBLkKnYjDPERJ/fRD0MJ1xCHVSw1qBd9pouSw7jRaDULvhSmlUV3EIK0yx1JPMJTJfwW+q1ziH0qcihdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MCECX3FP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso6408197e87.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419715; x=1732024515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voFHxermzTbW6SEYbNRfkjb3lYDKPPEthYfYOlt7fmU=;
        b=MCECX3FPpzQOJoIEj6ke/Ul6Cwz9ZFtVnoAi2Sbibf/MSVlb0RQOOII5dBlzcnvxbb
         ZiGQXfWURnSVp5+Tw9xAYUZ0PzUxNlOV91XtOzKhhX7STkZhF6VurVViXkwq2sGSpH5a
         yROZuFPhLJmPF4jALX3BBkH080Z7EtmgG+tQzEn4UOznggjtIJ2b2VK2+Q/v40z6OQ4Z
         CTXvnQmGsB0/TTat/z/xbrA4P2seiXAPcGEXQ8FZTs+QxgvxugSqRdqBUfXw2AcdMA6N
         ctZLG+cqn6ccx05zp9US0um/dHPTMI3cU5DYkufvs8eoShLNpfAl7ruJwps8JrxwID8h
         I8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419715; x=1732024515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voFHxermzTbW6SEYbNRfkjb3lYDKPPEthYfYOlt7fmU=;
        b=mvuKlh3xynMkiw+cICkfZRveZw/s7SE039MVRBWiIQ46N9X3ZM+Xh/pIke+5z7Lgeb
         XQuXJ6HxrycCNTPUiVGRJPSuOieOaoZ+QYEX0F69S7t9NSJZHBbBE8/9fHSZP8/PDs22
         tmUmHBfqWxEPliYnNoOlXcauZvlCo9Y/IZ9pPK5yjclALRwdSYnuqwf9w1zVZEfLAEVt
         zCId056q34b0VTSiNY8RXlIzRb8y8h7LQFcuXzBJN+QiN6KwvLVxu6j1bgzQHudL0tvA
         x38vaFGBimigE8IbnbH4fYNzKOlw0yxdT23aQbt7419SOGLGl7LHpBxedkZApDzBs4tW
         wN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMVYOrnHRKY+pniN6NO/jToGaruhOTf0pyg3s8O/Xlg5Li6EFczlNAYdle/efD6pvDUtJTRmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNwUmradt0o+06gcLBuIGQdXqt1TYzDytwDOAXD+CmXF96iVW
	xlDZo5gPpGkrymbBx+lY7h4DEHEn1IXTg1gEliS8X4C1LPtfkBWIPqaNu54Ss/A=
X-Google-Smtp-Source: AGHT+IFuyNwJYii2n24HeeyLH2Hlj9JunNn86/qlU67LzZK76iRv2CYvlbAAnVqvPGC3XP9mtciezQ==
X-Received: by 2002:a05:6512:b8f:b0:539:e88f:23a1 with SMTP id 2adb3069b0e04-53d862e4cfbmr7920565e87.44.1731419714884;
        Tue, 12 Nov 2024 05:55:14 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82685d2asm1924953e87.67.2024.11.12.05.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:55:13 -0800 (PST)
Message-ID: <3ced011d-0905-4bb6-9985-22957aebaf8d@blackwall.org>
Date: Tue, 12 Nov 2024 15:55:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net 2/2] selftests: bonding: add ns multicast group
 testing
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20241111101650.27685-1-liuhangbin@gmail.com>
 <20241111101650.27685-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241111101650.27685-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 12:16, Hangbin Liu wrote:
> Add a test to make sure the backup slaves join correct multicast group
> when arp_validate enabled and ns_ip6_target is set. Here is the result:
> 
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 0)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 1)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 2)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 3)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 4)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 5)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> TEST: arp_validate (active-backup ns_ip6_target arp_validate 6)     [ OK ]
> TEST: arp_validate (join mcast group)                               [ OK ]
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../drivers/net/bonding/bond_options.sh       | 54 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 

Always nice to see more tests, thanks!
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



