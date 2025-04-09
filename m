Return-Path: <netdev+bounces-180684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF0A821BC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D219E4C8F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3625D208;
	Wed,  9 Apr 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvo+hPan"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792D33EA
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193369; cv=none; b=bepK1HbnXwFtnPhiJkSrsRwh1W/xWHs6dG0h2OtYRDDp8NtPi7FukooZkxdAZu6C9I0n4K1ZoWtsN4hyOPjArubgTdc6z7IHciayJlKI9v60yBUX6gA5cAHJvNSazi4dr0bLxF2URESMejWyu09PKVbBqzxHcL/ErSsOmPHQmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193369; c=relaxed/simple;
	bh=c9DuTSaPjiO8StDDsOMg3WMYUwFIi3AqQOH/c0eCiCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I779wrypxsSdVWFXtoNmf1DS7Am6YBFsPRXdeQDn1GwtKwUJOOo4WGShqYH/1SJlrvly3aTxn2fnpFxA5jvR1oPldQ1OGYe/o7jgROH+wZARIo5NbneMMOcv+G8KHLmEOHtky9JvywS7ZvSV/rG1CsEU+o6haQZ745Vy9nczPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wvo+hPan; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b772404d-ef1f-4ca2-a7a8-e3fe7762dd8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744193355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3Osk/xwKtmBgpfhItgZqw/w4soU25CKVKTCKayJfqo=;
	b=wvo+hPanftHBPyAT/EJPxMtZa+uMbwcJauyG+wy5u7oNwXMj62DEhCO0B6k84VJyPr1hq2
	pfeygywI1oBum0SKToM8q7RC9d8cIGN6Ko1Enc7YEgoOJ3qsBu+uiUCGKPdoLQbBOGolRs
	8dVCC+T+WlkNWxpr2/RhMOwnUn5gdw4=
Date: Wed, 9 Apr 2025 11:09:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: add irig and dcf NULL-check in
 __handle_signal functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250409092446.64202-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250409092446.64202-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/04/2025 10:24, Sagi Maimon wrote:
> In __handle_signal_outputs and __handle_signal_inputs add
> irig and dcf NULL-check
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


