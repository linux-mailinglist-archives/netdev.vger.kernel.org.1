Return-Path: <netdev+bounces-141964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EE9BCCB3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE7928474E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750D1D54E1;
	Tue,  5 Nov 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D52MwWQs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BA1D45FD
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809716; cv=none; b=CaggJr1FeAjlDR1WXaCFWdMi5o/ajZ6x629xDOrSHwjDvWrys046jkOAlVwnu6+FJDeBKyw42JYkzDnohPfzTbo5qdgquR5/vRVkoK8OnIO0wQm7oiHPV5Jgce6vZPdW1UeLYS5QQtZUl0uvg2fenT4pZxLFWbJ2aOLFMRfgagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809716; c=relaxed/simple;
	bh=d8+q2cC8swJj6TPAWD6IMiRhjDy9S4yLyIVKCGShcA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOFoxf8naN/H42bWckAxH8TtB2vKIhdr/H3nRVa5YkZZgcCMu4aYe2YwQFukzlF7xshwcwPo9fVehLmhVX3omcCmXEcC6jcsUDOsTra/agOFk2ia1IPpmqtJjmloBJf5fWTrTmJPCcE+b1G7lHyBtJ25rIUZl838e0JQ0d+ayBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D52MwWQs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUC1nj0vvwjasfZw0SlmO9m9UAIg6vugQYsOMxhb2xU=;
	b=D52MwWQs6LhJG8wsMZth3rFphJiQysa+Y2gMtYPw0a/gTr8QpuBp3/feHUmqTFSLvN9N6m
	Crh9Ol9XNneTnoVkLBWfZYKv6ukjy4shEtfF65MocOs/TT7811+MWVstwgzuYZY+KX6SIh
	rCCnRoVytI29ghcrUK4NS/Q/ePkmGIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-wNDOHk9fOhGl2zeMT590wA-1; Tue, 05 Nov 2024 07:28:32 -0500
X-MC-Unique: wNDOHk9fOhGl2zeMT590wA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315cefda02so39921375e9.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809711; x=1731414511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUC1nj0vvwjasfZw0SlmO9m9UAIg6vugQYsOMxhb2xU=;
        b=VGZyhGP8XrocFB8dvYXIvPQeyddkVXpkGh9IanyjO9qgr0u0Ocnlbfx5xzNkDyXm3j
         3cBix9w1ZN7xh67vwVzcoN5yT+pfTaTkjvmIbyK2hsxc8xmv6GvKsVdXvhcxzg647kLU
         kFMa3MNGyR0IjRyWbRWZKbfWSTBqBzMWIV4p2WUM3LcxhlIkcxzoWJ6dBOuG28PIzTvC
         J0mxWXINJecLVSzIm1gyScLiKhjtkDctgtT10gKBi9XT2q549W4hsh9TVTblHOaR1pNv
         PyHKgROWVlD7IfFrrbDJnFtSsN0TBQQllzLPTVN7AlwxayWxqC/0uE5RfHkG/4WrGAcd
         KRFw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqNkP6RPEkDfMTJQ3jIO3PXlDTp7pWJLl6dLRRwKKhqlsovG1bOp1lg3xM9fGSvHC4Yoxq3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2404+g52O2FoRMtmsmcjj703zN8t+M7OkWvwt1BZV5ayZr5c
	4vxd2S0xwQw0UMH8ak1VhEUx7C//HBKcvadAiZDiGEqsnb9Z2cK36rXrAht8yf5wO0E35+FF3Fk
	f2CPJRViHzG923Ci9X9qta/TV4OgW7PEGsgDd8wWjiayYnZKcMYtDzQ==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr178436405e9.0.1730809711043;
        Tue, 05 Nov 2024 04:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJblbpncVdFoO9qp4CKXUlwBXcuEdsxfBUGct4qinijfqhn5UtFb1mG40y+JWdLvUY4dnj6Q==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr178436175e9.0.1730809710696;
        Tue, 05 Nov 2024 04:28:30 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8466sm217372075e9.2.2024.11.05.04.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:28:30 -0800 (PST)
Message-ID: <68f209ba-2979-4a15-b344-4613c465b005@redhat.com>
Date: Tue, 5 Nov 2024 13:28:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: ip6_fib: fix possible null-pointer-dereference in
 ipv6_route_native_seq_show
To: Yi Zou <03zouyi09.25@gmail.com>, davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101044828.55960-1-03zouyi09.25@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241101044828.55960-1-03zouyi09.25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 05:48, Yi Zou wrote:
> In the ipv6_route_native_seq_show function, the fib6_nh variable
> is assigned the value from nexthop_fib6_nh(rt->nh), which could
> return NULL. This creates a risk of a null-pointer-dereference
> when accessing fib6_nh->fib_nh_gw_family. This can be resolved by
> checking if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
>  and assign dev using dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
> to prevent null-pointer dereference errors.
> 
> Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>

Please send a new revision, including a the target tree in the subj
prefix - in this case 'net' and a suitable Fixes tag.

/P


