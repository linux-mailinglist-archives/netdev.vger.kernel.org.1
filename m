Return-Path: <netdev+bounces-176532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6DA6AAF6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0980A1886162
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386031EB1A8;
	Thu, 20 Mar 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DxttiE0n"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137D17B402
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487728; cv=none; b=XMuaU3bjetBCh6vXV0vWexuXogPu3cgjUFVqXFCCsRIvwHWcKykrTtqTOM6MFtc9bPZdve8fy5KfdsNqomBLkMMhJyqT1t4ktSCVF55JlppHtor/qs2D5XVRldEL892aXGzUMYML9Zb2S0GiGmm/PIdoY3Mc5ZW5a/qJdYrrcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487728; c=relaxed/simple;
	bh=YHoluULXLlSIOykdmwFNcoUGCpYVFD+xAYX9YUtVcqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=eVYuzi78MN1n4G06lM5S2qhY+1WSEPIggnwNhYJYW7tuyvNchCOPqNPoE7Cu80xQjZpP4+RbkIPw61Xf/1M5AlEyqQHIG8uCYlW5fwx7JpbFoqg8Hk4k/AGIqdnHC0VorXTPTy9tb42zLGn+EWh6fGOigG2QlG2BErH8otG4CB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DxttiE0n; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37629e9c-0a9f-4e08-921c-efbf7824c371@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742487720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QKE0BR0a27VxAFyt+lhSNd81xArUuMq1jMqPT8AXNM=;
	b=DxttiE0nA6ICRiLqR9u467IPtzB+v1GzjWruXoiB/BR9dmRYhr6AjK8W8+ArjAqvrart8z
	wxhQCrAfOmzDrCVq6V9DFlU51kBcpw4zCMYynUVIA6g4lvn4A8sioFm4/1QV42hpH3SaaM
	jBRnU31t1dEkKa04mVnZ1LzTeaMDMyM=
Date: Thu, 20 Mar 2025 16:21:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Andrew Lunn <andrew@lunn.ch>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Kamil Zaripov <zaripov-kamil@avride.ai>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <6c63cb1a-ba98-47d8-a06a-e8bacf32f45a@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>
In-Reply-To: <6c63cb1a-ba98-47d8-a06a-e8bacf32f45a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/03/2025 14:48, Andrew Lunn wrote:
>> 2. Is there a method available to read the complete 64-bit PHC
>> counter to mitigate the observed problem of 2^48-nanosecond time
>> jumps?
> 
> The usual workaround is to read the upper part, the lower part, and
> the upper part again. If you get two different values for the upper
> part, do it all again, until you get consistent values.
> 
> Look around other PTP drivers, there is probably code you can
> copy/paste.

This part of the driver is tricky. ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE
reports only 16 bits of 64 bits timestamp, 48-63 range, which doesn't
overlap with anything else. The assumption is that when the driver
processes this event, the register which reports bits of range 0-47 has
already overflowed and holds new value. Unfortunately, there is a time
gap between register overflow and update of MSB of the cached timestamp.

There is no easy way to solve this problem, but we may add additional
check on every read, probably... Not sure, though


