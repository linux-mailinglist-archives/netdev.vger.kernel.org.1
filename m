Return-Path: <netdev+bounces-163573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66CA2ABB7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369C6188B73C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8B1A5BBB;
	Thu,  6 Feb 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JOBP/0KZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5781A5B9C
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852912; cv=none; b=cBGRwyvdnyqHiclPf5H31OVj+6fcSfYn7npOGdlyyTbgidc/W9Wr+UIxJRGh/yu+gKt1XUvKOTrsPaB+JXSX336i4PSVRwCVpDsbRKm1tMqdmiN1S8YAPnlB5S/3zcaWADfLChKueCAFs/H1HwqGELFy7tpHHHoHtuq9WvorpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852912; c=relaxed/simple;
	bh=S9K6uTA8VvFJVDz2rVYNypE/HkViC5gyXPCZe+4fWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHX50zoYCYnhv6eCgy2cIGVJockzUJwLYnIMNs0CGo7w0ZrXMJEFE6eCUBjgXm0/jshUBmjBJLa6ZTBRY0qttDvxQDqaTeNqnn0xQWpO9CPRLEmpaUl0t6bdmD8hQXUV/njQ4t5xuTWXdBe37pfG05/ddLi9aGS332Bdd8ACH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JOBP/0KZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa68b513abcso190807266b.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852909; x=1739457709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rlKArYVbbfkMOQLEil2R2SAvQ0afSCP1rUmme1+B8A=;
        b=JOBP/0KZwJTL4OAEzcMMzeYVdD9Fn7PboeocOe7uLQvvolYpUOsop6tmOXVHcYY7Kl
         O8Ti8vXT/WDgfevii2bBizGUNgwvrxHpck4HewmDIaTsofCK+tjL/PW+bAtDJQJNLkY8
         qlydJ8Qf0eMU5OIMwKhFogbQLAPaQ8124us+XO6kE1J1MnchsoEJa9Dy4rB+xCPxh/NP
         SIGrBp0ZvQ3PCQeZWuEzsOLpcBLN797PM4dfId/yxqSPKwdkuR8Yk7+AEQqurXWmM3Yc
         U8K0bJolFHaP9vWzcbJWOBaqjoiipFW8jZOavQHJl4xGAOTl30jEAw28hGbitcQ4Gzc+
         P6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852909; x=1739457709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rlKArYVbbfkMOQLEil2R2SAvQ0afSCP1rUmme1+B8A=;
        b=F1OhFMDt0X6vYW7GSQe57EmnlfkDo+831xAcHedzJsoTrYvkrS24abY/vl+ICtafSh
         kAWGkBS2sEUWb5NGDa00vlmMlkFkiuQtm9uo6pI8XWna7/qv6yqj8qHMWY/kwIjfmS5b
         WtvNfd9F3jQx9isUSQ45VOO2MRFlRUjOd4CSsCNG3gW92CBgekPDvdzT6rS2LPaMRMQp
         2lyydAFE0tsdSk+rEbRUbAaV0fBT5hwNkFtxn6fSPjy3q9Hd0AC/HcTF46sQSno0to4m
         jf1J1HjUXL2BSfW6OaR4nCJ+7gbd9RpXcRbulpq2pcSpF8Vv/GSOTTVnkpHz4qUL/T6G
         WZDw==
X-Gm-Message-State: AOJu0YzuDtEweGmLBoCHvulL8PQTrngBd5AYuu/nq7W8kMqJGD0MG6vQ
	Dot2tsvj4J/WUzAXnaCPb6nzwljUbxdRHWhPfc0VY3cc4oFigGPhTUSgww8pkrU=
X-Gm-Gg: ASbGncuwxltUZ1WTHe5HGHvsJ4cOWmQKDH3CyCwGCwPuJO9Z59+C/jLIIjYlz0tzjRf
	WpLSr7BOrXmphSfTbtz2bl5+Nt24fWVip8q440pPgaTKKXuOBA5TX63Ahmhxc3r1dqDVOGap41L
	3CxP/tvm6JTc0sAKI7wWh+dVI+LcqKbZgaZGBdk+Ki3PNs0JsutwUvgTe6nJuoZ9eqvThM3PUQI
	OaJf7GoHEBhoDH1ZXNBxXlFEGEWGOriU/oFSRb0k3Dxgny1GhFfBjemtSf3nYydQAh0ySglZoGW
	bGshFqsVvu+JxYRvwrvWeNDORkIj9lzJPigQYfO6M9ND3vY=
X-Google-Smtp-Source: AGHT+IGYS6d4HsD5MEqTfuQgUgTGOYMkujVYUnjTnyeKJRhPZPj1m191dnJjgGKyqlpsKlnGfxYIDA==
X-Received: by 2002:a17:907:c23:b0:aa6:a7ef:7f1f with SMTP id a640c23a62f3a-ab75e233e41mr751067866b.11.1738852909025;
        Thu, 06 Feb 2025 06:41:49 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f484acsm109660266b.11.2025.02.06.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:41:48 -0800 (PST)
Message-ID: <ffcafced-51a2-4a09-ba45-1aafc8f39081@blackwall.org>
Date: Thu, 6 Feb 2025 16:41:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/14] netfilter: nft_flow_offload: No
 ingress_vlan forward info for dsa user port
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> The bitfield info->ingress_vlans and correcponding vlan encap are used for
> a switchdev user port. However, they should not be set for a dsa user port.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



