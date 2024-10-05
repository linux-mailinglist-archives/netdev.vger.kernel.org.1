Return-Path: <netdev+bounces-132379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DD991739
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34D283615
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228B13A24E;
	Sat,  5 Oct 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CbCFDyIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D215AF6
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137388; cv=none; b=NQzmjDjMEiKpbtV2Aq7yardiCpPP+g/3L3VjZtM8fLZRQvBoYwbEJDQqd442FvhZMUCAuE3kXB63vKv8EDInOTRBV5gpACha8SgTukAiMHOwq9tkvtwNcBxiXzIH3GwZZ2rSGs2S4CZwM4fmR7EYrxhB3PjVbzdsCQTZe/5rzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137388; c=relaxed/simple;
	bh=8eXWQlT83dsqeW3c91nOFuMCEQtDBy380SIR/E9QVGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em1Sj92lEmDI3H1ceYuCjf69cwu15OcviCZyutwVAa6JwdW1GTDHNMyR2MgDf/UFaXGuj4x5P4L36XSPFW04jY+IoDvWIRlkbHRQSRkmLHgf08jpEGbIkR+9MNJq9mlegrUVFnpCqRQMB8uCDyswNDdCuXfCsv23KQMYScW3QQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CbCFDyIn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8ce5db8668so484166866b.1
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137385; x=1728742185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/10Eu7CAPxM5HNhb3N/ypFZbvoH5LacC2lLE4aauqjs=;
        b=CbCFDyIn6VZJc/76tasJ/Wpz0TwSadxYlKq53Vv2CxzhcVL8VO3JeyizXpKRBRt4Jb
         rTjm3vsX3igXZUkQKCgmEqZOmvdhMjcdsVmzPRV+05CigeUbGIyJow/gi51U5R4pdMt4
         kuQPbJojOVYvz8vEg+AEziAtUyULga8yL+B0HbrB8VjymUXrSRG1iagTXPToQIgf8taU
         y03x+pExNXuNAMw5df2btVsKtmuJHab7J36rj7x2bPNt4V1jkiZi7SIUIc823eXhRcLn
         emydu8U+0bscNquWzLu/z80td0Hx1Mjc9+aHjQFa4pBwYJaSu1fkShgA4oPg0oLPrRpa
         RS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137385; x=1728742185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/10Eu7CAPxM5HNhb3N/ypFZbvoH5LacC2lLE4aauqjs=;
        b=dtjMH9EKOZWPBdGTAUfBcuQdD3vMjpq2jZRjKR4WOxJzRn9C92qU0xsXv7IQM2ZBeH
         iweZS6RjC7hJP2qqWje3HW3Jle4oEYJZXE8Ea/x0TXE4XIVvVgFlKjau42idPaR8PdJx
         Ahe02UW2NQRRwywDk0Uj57FQyjLfriUbr2ixcaon+ue8Mzc2eipTbQopYPCX6QhyZX4y
         ZLDsap7AwCUEyK12K0ePJgHiRDJfVNwbZh5P0IV+Ji9a+bCcGxe+Z6Uy+XCaPctH2ImT
         8FnD1AEI5ascfM0YllcKkJr0C64dG5tI873np5eqnDeVirrSXi0yYZV3R38rAsH0txpp
         jrWA==
X-Forwarded-Encrypted: i=1; AJvYcCUEt8ZefYSVtosI1U+spbUySmJqno50viVkV4I8vk373dDbZ5df9PN1RcpyX/OG7aPCA601wIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L7HzLApDEMRYjWfO3GvE3FozjK5NNBSO7ko5fWofgBOpAsEs
	mn2yU3LznnE5OG5fhSFSLy6F8B4yezBVN88aj3osC7sHz2rMwFI0310BK0EEA5A=
X-Google-Smtp-Source: AGHT+IF9/uqy/dx2aokeiiydCDigyNk0oyxqMeT+dWXVOz2H1z5msuTPSfDdx5LrrexjPuNM12y/uQ==
X-Received: by 2002:a17:907:9726:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a991bd05711mr565611766b.8.1728137385107;
        Sat, 05 Oct 2024 07:09:45 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7840b6sm135988566b.101.2024.10.05.07.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:09:44 -0700 (PDT)
Message-ID: <33165f11-113f-4155-a551-7490be717686@blackwall.org>
Date: Sat, 5 Oct 2024 17:09:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 3/6] bridge: Handle error of
 rtnl_register_module().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
 <20241004222358.79129-4-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004222358.79129-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 01:23, Kuniyuki Iwashima wrote:
> Since introduced, br_vlan_rtnl_init() has been ignoring the returned
> value of rtnl_register_module(), which could fail.
> 
> Let's handle the errors by rtnl_register_module_many().
> 
> Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
> Fixes: f26b296585dc ("net: bridge: vlan: add new rtm message support")
> Fixes: adb3ce9bcb0f ("net: bridge: vlan: add del rtm message support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  net/bridge/br_netlink.c |  6 +++++-
>  net/bridge/br_private.h |  5 +++--
>  net/bridge/br_vlan.c    | 19 +++++++++----------
>  3 files changed, 17 insertions(+), 13 deletions(-)
> 

Oops, I guess copy/paste mistakes.
Thank you for fixing them!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



