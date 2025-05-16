Return-Path: <netdev+bounces-191157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC8FABA496
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6036818815C0
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA627D766;
	Fri, 16 May 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYHoXiqM"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907C27A935
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426613; cv=none; b=L1OrE0hr3s/u8Fdk1oF7+xd9VYqtiLpurtzDRuMratrbC4m1SPlGHysrxRlYcUMsPj9K7/YmpHc+9rPbHoAp6ZS2NFYXsMfjjhBUyh1ryV7dciftoI34nq+5pZj0jj4nBGEDvyfnzE0b4QZUdMcrvNPWjhmlyODZ+wHh9gYnYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426613; c=relaxed/simple;
	bh=p1mvHlBdKatl+hMMra0+ZlPP255dxOsU82UwTPZKqI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHgDPyOxUWrnpRnhZ9DU2e9S1x1OWvdcRwBU040t3lUsZfS7eGFr41xcbjjKkHM1hS0Rw9vUxq0etlIoAViEwNkcmXTkGFNf0l4TX94tPE1DSE3cNg1+TTBzizvQdyVO7WqqH0HileE5shvCDUgjs4ETre1qozdKsF2IPTtEfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYHoXiqM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b72e8b41-a5ec-4821-a315-8670d7e2e56f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747426607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2L0rYe7eo1oBRvssRRGMqi4mD0VDsTUXJiSleO2/s=;
	b=lYHoXiqMOdkSm+VkSphX+fMNRj6jPIoLAJdyJGM+76xrriLOEnBwFE66CK2yzosIL49Ft5
	/TlBWbE4OuGhVhYYt/b8li2xhMo6iQPl2g1bAj8XZTVWVPnf4Wa5wDX9niAqZNsf0SaYiI
	yPTbjWT0TnlZUEfMWYBt22A56506gCE=
Date: Fri, 16 May 2025 21:16:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] ptp: ocp: Limit signal/freq counts in summary output
 functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250514073541.35817-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250514073541.35817-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/05/2025 08:35, Sagi Maimon wrote:
> The debugfs summary output could access uninitialized elements in
> the freq_in[] and signal_out[] arrays, causing NULL pointer
> dereferences and triggering a kernel Oops (page_fault_oops).
> This patch adds u8 fields (nr_freq_in, nr_signal_out) to track the
> number of initialized elements, with a maximum of 4 per array.
> The summary output functions are updated to respect these limits,
> preventing out-of-bounds access and ensuring safe array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Vadim Fedorenko:
> - https://www.spinics.net/lists/kernel/msg5683022.html
> Addressed comments from Jakub Kicinski:
> - https://www.spinics.net/lists/netdev/msg1091131.html
> Changes since v4:
> - remove fix from signal/freq show/store routines.
> ---

LGTM, Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

