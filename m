Return-Path: <netdev+bounces-152878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325FA9F62A3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3198170D86
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38249198A07;
	Wed, 18 Dec 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dtaeGOIY"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2218A922
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517209; cv=none; b=kX73sNhBN1YvHIN4sjPtvhh8Ub8zjx5A5u8C/quZ60KUriNmWMAgsXd8DB5a6VAuAVJgDOS9XtYE5eiWjzp7kx960xylz02JQ6yjyqzzKuS2cheuaDfyBuFvP35ouV+g/l8f3avzDQOjTDJ/spL0WEeynvWEuKdZgahWZOTzD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517209; c=relaxed/simple;
	bh=Xo7v/6ukVzLA/O/DYAtaTsb8ByeXIl5K3lCnSkDQ7LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afubXHjS3HZIVzG9Gl1tiSo3QVX2RE/W2LR+xQjFY6mXR+7cIbBfsgTF9dxjfCF7JjMUebl5opjEzVNfqagVSAqQ7Ucl2FRxF0hkn0/XgzV1JWUeBWMoZ+0PkUSFSlnlgROZHoqt6cj3nR+626Du7S94P2Oy57m50cNgDYMY8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dtaeGOIY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbed26a2-4b59-4c99-b5e7-2ca55a666450@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734517203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb3pDiXxkXlb5/YuXJKOc8PCZAGeAZHuQVVmCcglYz0=;
	b=dtaeGOIYNdXWuLjo0xHJoosWSWHylMWE5cQM3aiB9bBYtNJFXmfyEQECkfzCRTfWfcD++g
	JE/k4KKsnJZckF/KtPX5KT6OhRxUeQ7IYxw2YTeCC7d8RyjWZA+nXdsjr3UYuuX+eZ9TzX
	bzpju7U124ZZ/h5PJqR68xh38SVWY2A=
Date: Wed, 18 Dec 2024 10:19:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
To: Richard Cochran <richardcochran@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20241217195738.743391-1-vadfed@meta.com>
 <Z2JG8RGcsQXxP-mS@hoboy.vegasvil.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <Z2JG8RGcsQXxP-mS@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/12/2024 03:52, Richard Cochran wrote:
> On Tue, Dec 17, 2024 at 11:57:38AM -0800, Vadim Fedorenko wrote:
>> The overflow_work is using system wq to do overflow checks and updates
>> for PHC device timecounter, which might be overhelmed by other tasks.
>> But there is dedicated kthread in PTP subsystem designed for such
>> things. This patch changes the work queue to proper align with PTP
>> subsystem and to avoid overloading system work queue.
> 
> Yes, and you can configure that thread with chrt to ensure timely
> invocation of the callback.
> 
>> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>>   	}
>>   
>>   	cancel_work_sync(&clock->pps_info.out_work);
>> -	cancel_delayed_work_sync(&clock->timer.overflow_work);
> 
> Do you need ptp_cancel_worker_sync() ?

ptp_clock_unregister() calls kthread_cancel_delayed_work_sync() if
ptp->kworker exists, no need to call ptp_cancel_worker_sync() on cleanup.

> 
> Thanks,
> Richard


