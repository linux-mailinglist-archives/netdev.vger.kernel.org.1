Return-Path: <netdev+bounces-104882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03790EF31
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1891F227B2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC614E2DA;
	Wed, 19 Jun 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E7cuZqR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FB14C580
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804446; cv=none; b=kXC9we/nScjXSO/Z5RrqV6O1DDXmBFRrKf3fjycKkwfyA5plJcPKV7iQxkYOADHt89cL2SF5G2Y0kZNFgLPqRTnBjhDt+aXBx6FLb12rXftO+ruKsIatPp9To82Rj/TlVLoJz7n4Q6WShKT0tktKpXVCXf3/gli5OrkP/mZEUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804446; c=relaxed/simple;
	bh=sG2Lpy3VpXT3f6OxbZel147PXaMOuouxB+lV8yBKBV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsCvtZWLLI1tme3eNRTq3RpGpV7g/gclNVqjgrpH4mRfPGtc1uKNmVAlM5DZsFfCuChT74zXffYdK8j0wZK0BuFM00N7fIOnYXxQ5hjGhnCVJle9/SfGU1FCAl5NLvkZvFWI94LJqWVuZIh9nINmpS2eRMXztS1PsmIRb9/c34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E7cuZqR7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6e85807d306so498714a12.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718804442; x=1719409242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZI5BSix8LmWzY7VDgC5VyaiYfKDgyRvZmlaJ7+6sKGo=;
        b=E7cuZqR75rKoEE52RGCPTuq72Ql9RTNiLbEuTwqK+su7VAWro600pxIhPI5sHZlMeI
         Gvmlr6NJ0eQFzId+lJDXoa+aQ4shv3qNgpuG3kLCbDwDdJyWPawBLQcETvSauheCehRN
         mDLbYo4r6ZDtfZHlZNqHe5Rkm7N0ZYuabUAsmmbr39jG62esfYCSyB0uNcBR3QlIqTKv
         HUMhS0lOFHXLcBGYRQZMs/IjBCrp07mcqirHVL+/KIGEBRDi3QOpFR+M0Y5zCJiT8q2T
         tpLXRcn+22FS1EIpjOo4/j0wjDyfeZUhC/Vjj4yTvXqTvcgeHsfIJ2xI9bfukJ7qmPvn
         guBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804442; x=1719409242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI5BSix8LmWzY7VDgC5VyaiYfKDgyRvZmlaJ7+6sKGo=;
        b=ND1h+yOSMaB65rRJGqVOEfJSLF/K8AjlCOBcKh8SXJcjFZwIDGf+9fRWroqN0QX/+n
         1QmRdIRcviPy3izOLPSW62id7AKG+2lf1jlMJYfPcQiEgRASJqqxNtMJGzM8VEO1rEmo
         3PMYWcN6uIqlSW7Cw1ZNGtxoSKDNSZeG2u0kM3RLqFOOq5YLoYeQZQ7SdYqFlwPks4l1
         9y523vWDsp5Mf0g0KCQXEsN59HGi2hzvOa5Ur0vp1XpaKnksZ/lbp9bvPvWJnLPzEMTe
         RtOYIJgXrVfcN2jW6VNd/DHZYHMUOfteOIHiqdzbA2dubEXbYI5fVfE9+7EY7q8guqO2
         7ytQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGadEVgeUm5a54NNUxYGBtVZ6ACnzdEMf/WJpSUcbui3Qf1v6Sd0Z+FlGiq/unCh2wE2+XhopYW0/ICw7rKfbVNHvlwBON
X-Gm-Message-State: AOJu0YzbOBE2VkFQTykfm5YHD+pS1MgNdVmlrusqBIiJkeZp5RwJAuZ4
	mhqUBI9Yj3V+WRv3/4gCWpwW5Uwig6kX2COGKelxUOPR+7pcyzaYE7dmI6XxBS8=
X-Google-Smtp-Source: AGHT+IHicUj38k3OCiW5PJksXObOTIRP9R4I5CfXJOeyErwyGssRFHOWu7QNQ6LRgHLsmIKJ6wqTtQ==
X-Received: by 2002:a05:6a20:729b:b0:1bc:bade:ea3 with SMTP id adf61e73a8af0-1bcbb732001mr2841430637.5.1718804442532;
        Wed, 19 Jun 2024 06:40:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ab7fasm12909516a91.2.2024.06.19.06.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:40:42 -0700 (PDT)
Message-ID: <68b482cd-4516-4e00-b540-4f9ee492d6e3@kernel.dk>
Date: Wed, 19 Jun 2024 07:40:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: Split a __sys_bind helper for io_uring
To: Jakub Kicinski <kuba@kernel.org>,
 Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240614163047.31581-1-krisman@suse.de>
 <20240618174953.5efda404@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240618174953.5efda404@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:49 PM, Jakub Kicinski wrote:
> On Fri, 14 Jun 2024 12:30:44 -0400 Gabriel Krisman Bertazi wrote:
>> io_uring holds a reference to the file and maintains a
>> sockaddr_storage address.  Similarly to what was done to
>> __sys_connect_file, split an internal helper for __sys_bind in
>> preparation to supporting an io_uring bind command.
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Are you fine with me queueing up 1-2 via the io_uring branch?
I'm guessing the risk of conflict should be very low, so doesn't
warrant a shared branch.

-- 
Jens Axboe


