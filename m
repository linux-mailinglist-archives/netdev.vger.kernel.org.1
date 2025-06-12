Return-Path: <netdev+bounces-196899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CEAD6DBE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F923A4D51
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328A2356CB;
	Thu, 12 Jun 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zjmm02vW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9E22DF95
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724264; cv=none; b=c+9tP0hYfrCzktMfwPHTuOIoEkyVYqmk8CeMoktrPlgM8aSjeMQVpS9OLkkb0pzHMCEgReHQoJaGWF4SiAepVeQay7IQa7dp6+yTCDinthOFzD7dgT+uKrgUE2ZOq+Yvb2ZdqYtHcow2ljtZV8+3UFXKOHxS9RcoxS4o258AJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724264; c=relaxed/simple;
	bh=MwcDvqiPKQ5m+MOCVaULmUHgjO3KXST3aoDS36kB++4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAUNwdivfd+ygcDiCBwB7lFZNonj8Iu8tN5NlUlTQRwYe/RNVGGa5DxMM+2f/NqrOoSXo0uDfg78WhMFCfXXGmaI4IwTTBo6pEbGcSeB9TY6MU+Tf63DwP7zUPZx7vguDRQc8SrzNGSnhyPtC5gDyvKbFbP6tM7f5jkvsZrSPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zjmm02vW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55394ee39dfso788191e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724261; x=1750329061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6Q6GFaK0ZhwcIoV8v/ohamMRwT5mAkPHT6RA1HWH40=;
        b=zjmm02vWeqL7mAYk0Uz1++MwsRuD+dmVKzy5zeb5llohq2fzZt12sQynOSzIKczNKI
         GGaVT4Nmd1DUapJxoHlhWjAee/G6YOzlNFHhFrwU09WewQmb3e8Jlr0wlI8Q+n/3K4+p
         qyH1+g2OW6zoLo98llfcSofgDSKldcPDrNiF3pfJM2Bp/0+4APRjKNDk42aW16X5q9dA
         7z3acotZZZYGenvFvwDK5US98IdfGtSBVZ6MJove2hSbybPf4/r7tNOJB6vK4ac6RZiF
         hnh3cPST40gUBXENjKNdHQyIXdNc9dhq3PobnRAQ6h+FM5oNrz8XpeEfyG6cSISd9QB5
         hImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724261; x=1750329061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Q6GFaK0ZhwcIoV8v/ohamMRwT5mAkPHT6RA1HWH40=;
        b=jTKKsJrlHkbeVspgRri/BTBWUARxnltWGg7kHuZP0xXRKPKl+menjYRSnFMxwzOr4e
         EuUgVvGCZY5vrVo9GbFMO1zjJGynFHKQ26NcK5Jmlw8TqIgRgsx1hVdmyvuiI79sYE41
         sCm+q5cgMOrtVniu7XQ1WWD64JmYZFyhdBz0xl5voODG2AlWaC6VTVWpxAof6kP7iNec
         dQxKeqN/Zpn7K2oOB/Drb0IptSNb9llCongJPs4F0scjuHwmMXDGipVgNiH5hlw41a3e
         xtmKFroY6igEPXZXRvloTQjdUgTsSoBKmUYOAdZuItlRngcw2W1aIwNWo9YO8QuU7sTo
         WSzw==
X-Forwarded-Encrypted: i=1; AJvYcCWLZ53M/3WNhD6BUy1w7jOA3fam6llMAHLCeNgGKtexLrqEJczVb6wLnEr7yZWu4Ccv/dZJKPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ijFpuEnXDL9PtXyWIWkqCnnvSJHstWdVg3ZL0uEEPBp1ca1b
	iR2v1GctKuSp+byZE8i9DjJGnbfeCo2eXClBZ1/xSmUZWkO+X2LEXZaL9v2oQ/otI0U=
X-Gm-Gg: ASbGncuQsVg8+4KyVBUC1GAjS+l7kDzuBDHjygJHVXC5BXDPnFv9JNyJ1CXoWMAEAWN
	oRrj5U8YNO6MDhCcCh1dsVT3kkKJW5FjP9K7DG7RMSCiu3iKXqefuuFexsOauqpZGbkEmxChNWF
	yRd6OVWl9/4V1LnJLKzWFIuJuy5xg7063kOoHxfhkYFw5Rh5WANolQR2v7BIDtE8kzZRcfWAlfm
	h3uKHulvfh8Vz6d7db2EL5shRj8xNL6I1fgWKV9fYav6LS2qtSmVnU+rVLyDrRlSd5DVuGdwIEv
	3sk0wkIQpGc2KfT+xAi6JUmmWS5g1RSt2lTfHdagLRocivPA/a030Q9YPdHGcBGkV+fFcLuxdat
	pDdIy6ucpe78C2Gcd3qxDIiletcDjrxI=
X-Google-Smtp-Source: AGHT+IFwIk08JYtVEXyJ6fzJ7nbyU+2CzKKhyso3gt4TAkW80IB5zmivUm7nxIiSaJLIZIPeiJ4qxQ==
X-Received: by 2002:a05:6512:3e1c:b0:553:2969:1d6d with SMTP id 2adb3069b0e04-553a54521acmr693440e87.13.1749724260732;
        Thu, 12 Jun 2025 03:31:00 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac134e8esm67203e87.56.2025.06.12.03.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:31:00 -0700 (PDT)
Message-ID: <a535cbab-ecdd-4179-9f00-1960228f8175@blackwall.org>
Date: Thu, 12 Jun 2025 13:30:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] net: ipv6: ip6mr: Fix in/out netdev to
 pass to the FORWARD chain
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
References: <cover.1749499963.git.petrm@nvidia.com>
 <4d836908c8667a64f66652f5690fc60e0aa2d93e.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <4d836908c8667a64f66652f5690fc60e0aa2d93e.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> The netfilter hook is invoked with skb->dev for input netdevice, and
> vif_dev for output netdevice. However at the point of invocation, skb->dev
> is already set to vif_dev, and MR-forwarded packets are reported with
> in=out:
> 
>   # ip6tables -A FORWARD -j LOG --log-prefix '[forw]'
>   # cd tools/testing/selftests/net/forwarding
>   # ./router_multicast.sh
>   # dmesg | fgrep '[forw]'
>   [ 1670.248245] [forw]IN=v5 OUT=v5 [...]
> 
> For reference, IPv4 MR code shows in and out as appropriate.
> Fix by caching skb->dev and using the updated value for output netdev.
> 
> Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      This never worked correctly, hence going through net-next.
> ---
> CC: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> 
>   net/ipv6/ip6mr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


