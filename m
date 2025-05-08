Return-Path: <netdev+bounces-188950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61491AAF8B9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D951BC64DE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F551DF725;
	Thu,  8 May 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzxtI8BI"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7F22128F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703762; cv=none; b=NL0NnAvzbAOKM7nL+dwxS7gy7oERm8VB+mMHmYxtpKzG4wdYNX9TDEmS9LTLFno/Ajwmkx/Zv6d15118a70KuFS1wfoyq5ejhfBMYokUJAy8cCDZh737lOiqPmoVOXQjJSsbyzSesgS5jzzrc66UQugfU68th4iVOfffnXhYn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703762; c=relaxed/simple;
	bh=xpYchZCplIfg8HKrEsPwShb9bi/+ZGA67nS38hZDn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4KPW53qkowMPssL3EAeLgYpnq/I4cEcPKrlsQOD1wGsB+qznrhMQmetkPx+Gn+kpICsAVgXJZD3kOnyalAPNiZMrOo5fCMBUSoKmg8o5p6T4c5jlfH4kINoRxg1TS83v5qbrAA7sXqCHOOSKptpbLyW/q0LNo4TtlSgAg2QY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzxtI8BI; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60686dc1-5b8b-47c8-b7b6-2348f2ce58c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746703747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/v6JeouaMEXInKNfep2mCJjgolN1hc+ZaO0xsg6Qxc=;
	b=fzxtI8BIBjMo7V0ZmhsLACfkwzJHyViZBBfjOtJJ5Z+Dq1HV+Zlo+y/i+/jCTtkOSG6tMt
	aPP4JyIyjVw1gQMRWoa49KFE+08w1rrOfhxGXQUxzaAERbAjcVbuCn8wSqSm3vCGfV27ia
	MCgXQ+Kvn7QPOKxxRB6kpfGAQc3RRos=
Date: Thu, 8 May 2025 12:28:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508071901.135057-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 08:19, Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements in
> the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
> nr_sma) to track the actual number of initialized elements, capping the
> maximum at 4 for each array. The affected show/store functions are updated to
> respect these limits, preventing out-of-bounds access and ensuring safe
> array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Simon Horman:
>   - https://www.spinics.net/lists/netdev/msg1089986.html
> Changes since v1:
>   - Increase label buffer size from 8 to 16 bytes to prevent potential buffer
>     overflow warnings from GCC 14.2.0 during string formatting.
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

