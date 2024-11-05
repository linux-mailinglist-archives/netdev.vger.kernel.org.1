Return-Path: <netdev+bounces-141804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8219BC490
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C673C2828CF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A061AB505;
	Tue,  5 Nov 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCPJzLSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96843D9E;
	Tue,  5 Nov 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783456; cv=none; b=PeZ0/QFUoMwZO0qfcbFVx5KoGKXx22u49sSbZiMdfpop/ndmPpAm5CLjfTRDD5iN9AMcTUqfLF4vXA7r9qbWe/iw4Iw4gHe+zfdhD1qAVgkke2tLmMA+8hmKZGWbC8i4gi9Oj+FRAje8ooZc1bsq3ODB4j1kC9e6bFjIMhmxRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783456; c=relaxed/simple;
	bh=ZZ8M1K74AfBAeZw1KBbrNK2iUoUdzDaeh7JVH/wIDsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubtTo3rkqE4nFaxOvUqK7R8Rn/oNq1uyE05RVfWySLUNqBqIsxwelpy073nw2P2DEZgR6xeBZAsZu5B8pmXlUI4Y88NILIP3HqsCWB9xO2pFdgJtneYJcQ9YNlrqC0EnKfktMa3Hp5OvS77J1zfwnAJz+e9eKMXZGqWfM+QyR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCPJzLSX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso46972525ad.2;
        Mon, 04 Nov 2024 21:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730783454; x=1731388254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYRQYYR+JdhQ0qAqYIjxsBozFzPNS0M2HhdVgVTXBhI=;
        b=XCPJzLSXDGEas9a4vjkGHKjmvD0JfpFnBjKa8bvxgFKjjNXJrwcOr6Ddh6mRVPNwLM
         nU2PLHf6XS7ti8R6VshOIbiRq1NBvL9zVX2rsuwDsN0u7WscUyPrev3GFi8ppgfa4ew4
         FBzI2qbRtLELINePDZdJwA4DS03kxfrazPjZB8b5waWS3zymj9TM6+UP24X4ILQtx0ml
         +e8e11yZ7dX48ZPsr3UJl1TrGIXhT4LxF4tKqbCUnJyJ9ZB4Osu/BqMDL821l21mHalg
         SSCHCr9OpNa5g7XIouN1kuOPocDRDaPeQje/ZbJ/WgLs6HW5hx/plB1W51JHyKkDiIFo
         FAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730783454; x=1731388254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYRQYYR+JdhQ0qAqYIjxsBozFzPNS0M2HhdVgVTXBhI=;
        b=LcO1yN3ZLYD31/FZ8ivh28uJcG+U+SGncndAdW7YDqW6HyfxnUAJc1i7GmfDSxYBMC
         92Wrb0FqgnrUgmTjsxcDXrFrWjp1bYtOVO+ZeaUtiJeeWdYADoAUvjBo/6ECnj0qEO5l
         XaLAIU+DlNjTSJSnWYGeoxHfXXPWFwVh7gAkj/El0AcGOXljyqSo5zeybEKNrO1cMgp8
         cUVsAjETbBCB1REGEwvvRF09R6q5Pp20GDlt+DBMJSBRDzVwt6amQAmNgcKPSwarFqBu
         g2Hukhe/Cezme5t9fRwYx2d9HALTLgnd64iKukT3wy9YIi4SxG3joIxlNe1Poke5l5eW
         5dWg==
X-Forwarded-Encrypted: i=1; AJvYcCV0lGVvHpfF76rDw2A/xcrCHfYOHjIwK6MJ8VvFNftj35RELKYgJMpj5jOTH5Fctz8YAAZN54YZmDL5Z+g=@vger.kernel.org, AJvYcCVSeMEhTvSiWtoqQuSOvAmsAhm+iamUEFmDOsafYsLp6P/h1WMW60/0SAtSlnjmURpT3Dw/UWZr@vger.kernel.org
X-Gm-Message-State: AOJu0YystKfddADhuWTfv3sUd1tyzf+BMxDsudiIxPBg9dBQGL7mE3Ri
	5Q86LxQsFwwas8kEtW480q0O0e5BqHErj5cmzryxh2+yZZjLOtGx
X-Google-Smtp-Source: AGHT+IE9YYi8i70c55z4uY1QrudbCshWUkBwISsO/eIU0cxOwovu3C2tOO5yobsD+fNZsNuiWwPB6w==
X-Received: by 2002:a17:903:1108:b0:20c:e262:2580 with SMTP id d9443c01a7336-210c6c3ffb6mr415459855ad.44.1730783453867;
        Mon, 04 Nov 2024 21:10:53 -0800 (PST)
Received: from ?IPV6:2409:4040:d8e:59e0:9ed7:e897:20d8:410e? ([2409:4040:d8e:59e0:9ed7:e897:20d8:410e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105729894sm69538205ad.119.2024.11.04.21.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 21:10:53 -0800 (PST)
Message-ID: <4f4b747a-a7e9-45ea-ba3d-fa6144320119@gmail.com>
Date: Tue, 5 Nov 2024 10:40:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv6: fix inconsistent indentation in
 ipv6_gro_receive
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241031065124.4834-1-surajsonawane0215@gmail.com>
 <20241103152213.2911b601@kernel.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241103152213.2911b601@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/24 04:52, Jakub Kicinski wrote:
> On Thu, 31 Oct 2024 12:21:24 +0530 Suraj Sonawane wrote:
>> Fix the indentation to ensure consistent code style and improve
>> readability, and to fix this warning:
>>
>> net/ipv6/ip6_offload.c:280 ipv6_gro_receive() warn: inconsistent indenting
> 
> Warning from what tool?
> 
> Unless it's gcc or clang let's leave the code be, it's fine.
Thank you for the feedback and your time.

The warning was flagged by smatch, a static analysis tool.

Best regards,
Suraj Sonawane

