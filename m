Return-Path: <netdev+bounces-138510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FFC9ADF4C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70791F214C8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908B1ABEC7;
	Thu, 24 Oct 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2+DmbQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3814B077
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759014; cv=none; b=A6gjbOX27ADeV4aN6kOdueqmwgHbgJ1BIEY/it90HzeRrzh/VnPz2y8RlBkX5qNMsdmLsfoObnvY/iyDpI3ieVJAM1EMY5cPJr7Lqh1N7QApk8aEeEtGhHzuBKXkLt8gobvrF/pRJzQIbJbzzXgMAw92IgJbFBPi7lSfsWSXypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759014; c=relaxed/simple;
	bh=k2MmQUlbmKg5pfXrWwba7RLrW+gbXDhqcwKxhuulIyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CApTo5bPmfj8gDp2jnTra+qbF5Kz3JRCS912S7ZXKql5uDelqAGr8sW5R1gO0h2E05tbsjXQ3/VvgG/h386CaqXIX8tTviDSJrpHdnztBebDTzGhtR+q0NduTcn2nJlIQLAx1TeXcNuLD+rZwr4xx6/7Pk6ugZn0rSHxlATMbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2+DmbQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729759011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bV9TQmFfSs8yLsU7QCmDt4U0aRRMcN9r5MoA2ahCdZ0=;
	b=B2+DmbQYRA6uLWzQEvAoD1JmuHljwhpyHQX0C9yB1VcrduFR6sZcNV0R2pFhaT9msxdpC/
	SQQ+fWRoLkoV2ZyAQBalYj0IVYl9VaE0FQ4h5s0bKAGQJmfWe777nN7rk0Q1JIf3VOSf0V
	y5YNBDJxHcmV3G+A/Z8ioajsSzcIu64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-50jcp0bGMxODrjiAu6xndw-1; Thu, 24 Oct 2024 04:36:49 -0400
X-MC-Unique: 50jcp0bGMxODrjiAu6xndw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so4564655e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729759008; x=1730363808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV9TQmFfSs8yLsU7QCmDt4U0aRRMcN9r5MoA2ahCdZ0=;
        b=gcDqsJkRTsscgJW2rN8K5txNGFaCKFzSP2MbNaHRUm53l6JnyhGtUIkX4+WdadBiwI
         Zoumao0eHgFt5+c/LNomrLtn9O4PuXYHMOn/bUCn0qsQdwXya62g621ZUIBIbVRjnEQy
         wSuhPyk7npabkEPjij46F7fbIovo4/MnKvt/2+khDWxgBo+Aiq56EehJ7FyUy+yy4YPQ
         27B8o6Ve5s4uq69AZYoXkUXkSVl1vRfOJIOw/JmApZmrIDJGQdy9QPYbj0L+tuXB1lCt
         TeifOk84t8CyvQT4pYhTgducEl9ZKru0C4GFcxmNjL3hGSqc7mLWoYKbGIYjUt93JKCt
         kvNg==
X-Forwarded-Encrypted: i=1; AJvYcCXCYJPQLeUbY4LDK7x6s7jS+Ptyau7BsCtNUmflPMpS0aY41Ezcz8ag1+v7Bj9PuV5QtgSJhqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOT7XHw/L8HN6HyxWJBoCoMpZ0SkeGgmaEQTiLiErPCmHiJM0
	CFX9oPpnqaYwkubxi6u+mxbKFEwIgqThjTQzJZ1MEzp9q1CULNSnMLXeGuA6q1y5PrL0wQzUlfY
	Ia6ys2PwkA7GFMcGgmeGXwo8cLj+QK742VHCCWhcLOA5JZXYNcdGsYQ==
X-Received: by 2002:a05:600c:4708:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-4318413f05amr48109475e9.13.1729759007816;
        Thu, 24 Oct 2024 01:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/jQmgjcxFF+0jPxIt8I7wIYJFqljK4xsgl4yRw+G3zf82LoQ8Um3/a9/gCesPsa8XUy9BUQ==
X-Received: by 2002:a05:600c:4708:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-4318413f05amr48109195e9.13.1729759007442;
        Thu, 24 Oct 2024 01:36:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd6894sm38675655e9.10.2024.10.24.01.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 01:36:47 -0700 (PDT)
Message-ID: <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
Date: Thu, 24 Oct 2024 10:36:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shenjian15@huawei.com,
 salil.mehta@huawei.com
Cc: liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-3-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018101059.1718375-3-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 12:10, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> To avoid errors in pgtable prefectch, add a sync command to sync
> io-pagtable.
> 
> In the case of large traffic, the TX bounce buffer may be used up.

It's unclear to me what do you mean for large traffic. Is that large
packets instead?

Skimming over the previous patch, it looks like the for the bugger H/W
driver will use the bounce buffer for all packets with len < 64K. As
this driver does not support big tcp, such condition means all packets.

So its not clear to me the 'may' part - it looks like the critical path
will always happen on the bugged H/W

> At this point, we go to mapping/unmapping on TX path again.
> So we added the sync command in driver to avoid hardware issue.

I thought the goal of the previous patch was to avoid such sync-up.

So I don't understand why it's there.

A more verbose explanation will help.

> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Also we need a fixes tag.

Thanks,

Paolo


