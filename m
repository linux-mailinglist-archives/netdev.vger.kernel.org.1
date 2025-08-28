Return-Path: <netdev+bounces-217760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C8B39C30
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A8246064A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83CE30EF9F;
	Thu, 28 Aug 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xClLXYSf"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07430DEB2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382768; cv=none; b=msfq6j2YGCJ0263BiKY9M8zqDIgJVA/OafEjM3ICU7gB5K81GvJvIlILkE6v7PA+W3KPcHwJNBzhPp4ETDQuZu8Hf84eubiFPC7bkzsL3MD8uF3ePrcoz46MdBqyyv1x0PAAXZEP6YYjuz8JbJbhvTQgAw7MfT2o7pXZk+IKj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382768; c=relaxed/simple;
	bh=u8rEJf5zKJXsNuVAQ+4r/lMzldLPRV7Bc6LFRRi/Fi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hcRoF3Y1FfNEvY7UBLCeDQ2IWTzb9x+ln3IW6F0wX7Jzt1Vr4H3ULhofz8VdwtTULNm3QWZ7JjDw4vSXMADPv45472/fueRyI3a0gI51ChGWfDjLTVTuzASfFw9oDTYuuGQRSiZgzFRP/0eDSloYRlu252s3EKm0ZZi9D5oa9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xClLXYSf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11d46e56-b8d9-4776-9969-d3767d8cda41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756382764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lf9KRuU3XqjH9s/P98ePLTJLe34Mktbt6oDMXgNk/4=;
	b=xClLXYSf4+Y47SMAxpPCJbn6XmGzs3dIcquE8NJLfEPLm3/qz+X/1yTkBgXhVxika8ThH3
	lsRaGUbO+SUI5mHC1mu87EeBMwd5zKFveKVZbK3cxJCrFE1pNVIWRmTlRO9W1F9fgfjpk9
	qoOf/I6JzQnTzROTIOnNmnMuWXhMosw=
Date: Thu, 28 Aug 2025 13:05:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethernet: ti: Prevent divide-by-zero in
 cpts_calc_mult_shift()
To: Miaoqian Lin <linmq006@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250828092224.46761-1-linmq006@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828092224.46761-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 10:22, Miaoqian Lin wrote:
> cpts_calc_mult_shift() has a potential divide-by-zero in this line:
> 
>          do_div(maxsec, freq);
> 
> due to the fact that clk_get_rate() can return zero in certain error
> conditions.

Have you seen this happening in the real environment, or is it just
analysis of the code? I don't see a reason for these "certain error
conditions" to happen...

