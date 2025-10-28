Return-Path: <netdev+bounces-233675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92DC1738A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 656B74E1ABE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485583587DB;
	Tue, 28 Oct 2025 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="08tz4mKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F63587BB
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691450; cv=none; b=o07/VdUnCB8pOiuO6DRk5TUQIO9pwhId0enahRIqgCfI6GxFpRMr8jsEfyyMtl6Nhj+qq00rQG/0NP3u1P6WlZWMDT3Hton1KYDOZUeJNF76kWRFeTh0jLex2auJT07jJoRwD6Rm7wY6A0/+OC/Z/XnR9E/MboPm07lbKvGcUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691450; c=relaxed/simple;
	bh=ZC42s0sqG+XopEJ3W+neysxRUCF8HUTzQ5v7byzQWkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXiRM01itlQxgxYqmb9URFWbXUrwUpBW2k449SULiWUI6OmZmnSgtW538QCZNWgWrTQwasPetDw83sT5RFomylC8WYtEGHpuk2hFfsFBffqTYZc2yWgZciRPOrXTOc8ZDioKuLs89ePYGZojFrYl0MbccDXbZGt+Uc4hV+u6Naw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=08tz4mKz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so80647545ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761691447; x=1762296247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4c5PhFuFTCwFZ5oEpEONV9tryVUpvmzCxp/gijmJQ=;
        b=08tz4mKzbpqjalo1bXtzS7lsl+KelVcnF9vctNyxLrPyVI6QiCuHyRBhuzN5+38NdD
         3pxi+HlR2bJPY0kY0Ly+VrJU08WYWSdy4WUxp0R8/XT1+BRCv0DpoU9+C3xIg8jpvp8I
         dRgnmtfV4DjJ8NogRivHbdfq3R6LiTdDNHNu/TDiNMpCq2PHxAg+WrSWzkHJHiv8cDsv
         vHRpMyOL+cjJAufRkh8t1v7tQk+ffIRX5Yv/XPEBGRhiTP9E3Cu7e4xuAVWnDJF3rT+N
         nfYEby6F12R+D/nBENaLJUOYzh0XWzL2l8q7X9V6WNyovWQCT/8Vse0kGu9+98alkqNK
         fPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691447; x=1762296247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4c5PhFuFTCwFZ5oEpEONV9tryVUpvmzCxp/gijmJQ=;
        b=lfFLHY5RLc/VCWGRMXjWXQUySuwrICMW9TkXMDii93SdXnKmK7ECQv6Zt5fXwjvOG6
         CXPbVWLsDJX9d8IynO6c+AU3twvvuIY2GNJDVPEHd3SMTM3gUeXjG4phJlqSWb49ldQW
         uNhaJGC4mS59S5uUqzk2RRIyI9R5cy7nncWYO3/URdV+vHfTUJWeWDkK2T+uW3dUFV7d
         k+bIUfJSlyPr9PyUjjiDOkgar2v1IxGzzFjIQaOUTmKJ+7NxdQr9K2svksu0ic4kMgeB
         FcYU14xTAT01AFY+DSDfXtvYZQmrgRFla0ZnFGrFqoZ9cUnqtoPPHPMFlhQtrUjoxfti
         KnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLBdevfsciBJHZ3uvKrhjLEujKstZgNOwCkTxzpRX1wIlyMKeMLgOL0P1ttUCu4kGuKzdbqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5AlnbkGqs2GZh7yb5JoyFwqrZambtEnO/Rh779Wcn5hL00Ky
	gxJtwMF/5+wlC0GDkR5EzUN6Z+SRh3JHCvs5Nm6btFCpTl+lLKfU7pnDXEuEw3fB9xk=
X-Gm-Gg: ASbGncvZUGlNqknpAzsnHdO/oHDdGjh5xRAckMvKXtHK5K4zhBRvwx5TWvI9q3PkdQc
	XxKLh7iLXYmVqtMt9PXBkXTs714ws8Ryxvi1ufx8OjNFMI+FO0BaTHrE7Ad704KzfZg9ybR+xqI
	AmRaJKhmbhItBpfP/FDf6ltBrlrS49jVYDhHpKT81ElKgtLdwsF9qtsdj+q5FRQnB4/raIjoa2f
	XIFpjtdHNJpq8sop7Gw5hCpsoxbmj6bo7MBJwkVkTKDNlTZv2I9EhFn71znwG67SGFkcc4DoQu1
	YmYcO1K8LQxdOYcwbMLRmOpROqiMG4xhXh4MgISje24MK0XeWF69gWWgtKcrQJxYNsGwpPN0Y3o
	Fr+la8tMROIKyK2rl9MRi6T2myHfBGM7ozvFEkgfaQqIj+XzBoMQKmGSphqpssSc//KrC+wOMaU
	yJQcfMVkoCf7V/Q3VWRT7YwmeYFB+N8En9894qa0x6+LSywzayyE7wFkqno2QiTrPIVudO
X-Google-Smtp-Source: AGHT+IGZFixYwX+c/VJ6LPbwoPvmyYW36TMP0l8DFdCGjhUcafZt8t6LFZzrbwYAD65AXmpGb+EwjA==
X-Received: by 2002:a17:902:c40c:b0:294:e095:3d42 with SMTP id d9443c01a7336-294e0953f09mr4458105ad.18.1761691447300;
        Tue, 28 Oct 2025 15:44:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4253dsm130275425ad.83.2025.10.28.15.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:44:07 -0700 (PDT)
Message-ID: <842b9023-1b86-455b-9aaa-20cdf0234c35@davidwei.uk>
Date: Tue, 28 Oct 2025 15:44:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: io_uring/zcrx: call
 netdev_queue_get_dma_dev() under instance lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251028212639.2802158-1-dw@davidwei.uk>
 <20251028153820.414b3956@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251028153820.414b3956@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 15:38, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 14:26:39 -0700 David Wei wrote:
>> netdev ops must be called under instance lock or rtnl_lock, but
>> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
>>
>> Fix this by taking the instance lock.
>>
>> Opted to do this by hand instead of netdev_get_by_index_lock(), which is
>> an older helper that doesn't take netdev tracker.
> 
> Fixes tag missing.

Sorry, will add, keep forgetting this...

> 
> netdev_get_by_index_lock() + netdev_hold() would be a better choice indeed.
> Just a reference doesn't hold off device shutdown.

Got it, I'll switch to this.

> 
> Is there a chance to reorder the io_zcrx_create_area() call, keep
> holding the lock and call __net_mp_open_rxq() ?

Yeah, I also thought about it, wasn't sure if it was appropriate to
extend the critical section. I'll do this in v2.

