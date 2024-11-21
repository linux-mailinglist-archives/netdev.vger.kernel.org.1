Return-Path: <netdev+bounces-146613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7239D48F1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB77B20EA3
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED891CACEB;
	Thu, 21 Nov 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfusDmR2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14C1BC9E2
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178269; cv=none; b=pGcegJ/oPHdEQRWSn0DpQdLJZkVe5FA6JIoN01XN657YwI81vzOFP6Qrw9qZAOwtx5pm1X1DJbfY20u93EOEbfqqa5zplHKfTcTi8FoKmmgxU6UGJT2+BeLDaCeYH343/kiaa+qs8E0hL7D6pPm0U+sQ/g6PtMHNN2WhCPXHuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178269; c=relaxed/simple;
	bh=cD4Fu3KbyxCyUuGjzEa4IuToSXO0RyJkQJKRw80eINU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW6zH1WbB8EmZtrdeTltILWvnq6eVuzal4y8T6jyeEctr1TXzo0Hh/YRdjKsX0/w/+E8ZYJSft7XVkn5YfOzcul2c+b/SfpaWFYNc40LOZeZSyxeuI1PK0GMTHfCQgdKPrUtUbVJJa5AzvyNoNZK8b8k6Gll3Npw29Oeba2L9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfusDmR2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732178266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
	b=hfusDmR2Y8IXshBefe+WXiwgAcyVQQJsrfTX3MBaxlSVJ93//46RFhVsNqom1En+Ngnn3H
	DXwt87DQGFF0EPkUOmFT/jgWUMjScPYtHolS463CZJafOjfoyJQRAQFkokNngdiDgH3K23
	FtEiEnXA29LLGUJBRkO8WxTTq9xxBMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-9HTNJj71OjqefQ_BQAvSiQ-1; Thu, 21 Nov 2024 03:37:44 -0500
X-MC-Unique: 9HTNJj71OjqefQ_BQAvSiQ-1
X-Mimecast-MFC-AGG-ID: 9HTNJj71OjqefQ_BQAvSiQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822f550027so328905f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178263; x=1732783063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
        b=vHFCz2St3b6Ahzb8OCC4saFsEnoeCQ3FIKLwdMN23cP0KZQBZMmmXRPFtaWVjI4xCK
         AY+YmfYDXD0HSPvDFFEXirQ4kdKRx5Uwmcq1ndRW6vvkfFudpGaQKzJCQJCPSX7HD80W
         6ukC6EMboWUfnMTJJcxtYuEZaOCsBpXFoe0/sHJZ8wYokXXFpltE9i15DUE+3VieTVwy
         igQxvcdm2N/LPKP2THVRnZS23zuDliRgRPLgEr9R5b8Xy5M6dOiHQ6XZTOCZtyGDqxZs
         KCf267mBLL90CBaSJSxdEtVv5tw/8yAaxWdmo4bl2nm2Wk5pB0BM8JUBFPZdlPEPYUg5
         FM4A==
X-Forwarded-Encrypted: i=1; AJvYcCUH94R58gZKNZc5cYFHVP4d+uLOxfknZM2QUcjRSSXgckpgJXwGoOntd8PZzY1Ylz7/lvyt2M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2rgzhcN9CARdM+/pJHTCYYec9n24IiIvaeCqA9MKIc93GwY8
	i0LU7jnIuPtGVKhReMCbnuryN3AQ0fgIfOMsy/cSZ4KMpAAL8FBwk6/hD4WoKT3/MCduUHhAh2+
	ojR0JoZurJY4UObeABRToYtXqWw3qZAz8o2VndRFq3GkuHNe3vyHa7qElPxKmDw==
X-Gm-Gg: ASbGncsBVOJybVjSN08Q0kEEIgIAbXBZ4NQzwFp+87/daw/arD0NyWq4DuLMlYYOKrF
	gO883inTSHyM5eL5AygOzyKLWbPEu0E75zsaKZPY2Zwpmr9d/MbDkpeXE+xYfyCLq4FOEcfXNAS
	vGT6tYN5FKifU8wTE+OBpgF6fZ6hwc6Pus7cG+5qr9Z6Rxm7SUh5041QlCG4ATt6/zJZTghIAfo
	fU+um9C8XhCF0XAi7r2BntbWU5xIkIGa67DJkuFJLX4GNnN1koxVWfAWGxmzhQ6oew6TWXRVQ==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518902f8f.0.1732178262780;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhkitcAujwGpzsyn2UlIRtZ04mvp+DvbIZs8ciCgtCb6aWVOCkAcYbsRMTziLn3rq2vc0jg==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518886f8f.0.1732178262430;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f3ebsm4208546f8f.105.2024.11.21.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Message-ID: <3646cb4f-4eb5-406d-9ea1-a407c3e03d45@redhat.com>
Date: Thu, 21 Nov 2024 09:37:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: openvswitch: convert
 call_rcu(dp_meter_instance_free_rcu) to kvfree_rcu()
To: Ran Xiaokai <ranxiaokai627@163.com>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 pshelar@ovn.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
 linux-perf-users@vger.kernel.org, netdev@vger.kernel.org, dev@openvswitch.org
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
 <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 07:47, Ran Xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> The rcu callback dp_meter_instance_free_rcu() simply calls kvfree().
> It's better to directly call kvfree_rcu().
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since the patches in this series are independent one from each other,
please break the series on a per subsystem basis. The patch 3 & 4 should
target the net-next tree. It will simplify maintainers life (and yours).

Also please note:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle









