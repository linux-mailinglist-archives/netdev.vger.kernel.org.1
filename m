Return-Path: <netdev+bounces-135771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700F99F2BC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE8F1F240C2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9FE1F669C;
	Tue, 15 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak4o3Cmp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297081F6668;
	Tue, 15 Oct 2024 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009915; cv=none; b=jx8BGY2vkCuSgm9ob6HU3QvfCCJ9rX2HxW1aMak6rq50gGKw2UuUOq1AFIZp4ZFs60P0emcbWancUEkHIgWz6LVcNn348sYmmBJR8ICYVvcyWWFBZa7qYm/ux2jKgKpA/UzwXp5lYvl6KNo+KOrET/R6QGThf+aeOEBp/8R3SKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009915; c=relaxed/simple;
	bh=/sDqHOs2CraTyNXk7KQexVK8gi7AvoziwNQ+gBLJHjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijCVIxwFzl2YYQXM9yCY5MBWEmqbWJdzcaKnXk0bJ44AzPhmxHGGtAVFu+pmSEHwpplnQZoYgPVj8ssdNatlDEP8rvr4RWgcn40QIKCnw1vmvbDY5tuyeSZnVpF8fi8wWfElvI0R2byTBZSfDD5RKeqwhcIEiO3/FtVlg6ECmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak4o3Cmp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b13b3fa372so44153785a.0;
        Tue, 15 Oct 2024 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729009913; x=1729614713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XchPzXKco182AVL6YvZhYqZjtDpLA7br0rvyko/9TYo=;
        b=Ak4o3CmppeFur72UFxhUq146Vy17B/LWoiF2VvNplKnfOIT2ShnW/iTgb6eSmEuv2m
         BVnPzshNXzFNtllSNAOG/jy7348FCQft+UgqsjVwwTnFdxnOg9rn5aBwEYWazjOSpMps
         SmFJLXIXBYPcnhIQHkt1GyyBRin6on85sT1Jx+L8gUb9p4C+WUW9+4m8qp1OvEAJHyLy
         SulAz4IO3y8pTM79TabHdR3iMnMCup7adTaTQSSeYvbihGHYLsN/yMW+T4+LDwB/lmR1
         0W3a26BXaK4cglrDAcy8pVMmOtgKQOYXBpCBHojRWN9BenbWcFugDSZ9pcwq3/GjK0Ke
         1pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009913; x=1729614713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XchPzXKco182AVL6YvZhYqZjtDpLA7br0rvyko/9TYo=;
        b=M44WRkfdlvVGKxaK9DNRMxIGBBTRCrTZCa5vIdcSXH/W0OZjqsGAUbOjPfcc6f5Nnq
         6jy0/3TNEPh7Z5cAxzFd+qFebp03LqvRFLO2VKeH0b3lg7iL6WudqxC3ssGWtf6Ir4U4
         Uus5BofYx/45Yzg7+oz2qvcS7tjNwmWVjlMNx8qmzswnKV4kmcMs3hocxNofmI0iJyYZ
         pzYocTWjP9XIE90OUqZnPEQykXlXL4/1b5HhSeBzH/cm+3zbPLJysZJq2On0PKECbKSr
         9nVyCvKFgtcIXDj/PxFJdXWrSTKHqTwLa2QccHqedgyxWSn33PfAO4kVNnrZjRR4EWWn
         d8fA==
X-Forwarded-Encrypted: i=1; AJvYcCU3HFBTZO57NANRolSE6Z2jDhGlqr3TdU8IavRepzZ4RxxUNNhSF+hZGyy/wufV2Pf5aBDSwpkOtOlRJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OFGAT7eeFRtrSQKIDwP+Jblu9CgkPUYQDmPXtrbCYslf3uEW
	WEIn4hnGQXd4GVC2JJSDBUem6qz8SUelXX6juU8bYWG+otuLs4ic
X-Google-Smtp-Source: AGHT+IGwmklZ8hcxUZ+LnFL5K1eJCxbfEhmqAS28KuwM2Xf5XnjyXiRnVDC0PmxdMen0TBaJZi6eCw==
X-Received: by 2002:a05:620a:485:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7b143278197mr63514885a.32.1729009913015;
        Tue, 15 Oct 2024 09:31:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:8629:aa69:8faa:971? ([2620:10d:c091:500::6:ed8e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395215sm87616685a.75.2024.10.15.09.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:31:52 -0700 (PDT)
Message-ID: <43a98a99-4c79-4954-82f1-b634e4d1be82@gmail.com>
Date: Tue, 15 Oct 2024 12:31:51 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when
 in use
To: Edward Cree <ecree.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
 <20241011183549.1581021-2-daniel.zahka@gmail.com>
 <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/14/24 6:10 AM, Edward Cree wrote:
> Imho it would make more sense to add core tracking of ntuple
>   filters, along with a refcount on the rss context.  That way
>   context deletion just has to check the count is zero.
>
> -ed

That sounds good to me. Is that something you are planning on sending 
patches for?


