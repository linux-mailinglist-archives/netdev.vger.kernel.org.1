Return-Path: <netdev+bounces-217807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7EB39DFC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6816816F8AE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12EB30F55F;
	Thu, 28 Aug 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ra8FPJf0"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEF262FFC
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386101; cv=none; b=EsnKftAg4yDq/uOZlYsivJB1jClDWNtZCMQWwWt1/LWNJt8mEuVCh65K0ddpe7MvGrjNVLiaMie3LfMLQMi3WFQnQBumWe4GIcrDun3Cs7rXdZbikEx/47tKvSWFQ7HghmZFrUU3hayltVaDxl997AZyBYSTbG1S6tTHFTkaGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386101; c=relaxed/simple;
	bh=YR/qZ84vLiQKuz+/Sxg5SyMSGAAAoTDdsnFm77awHyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUsz16MqZS+dd6TLtrUf0ud6MBKHVwynvmyD27yAKW2kdr4Fi0N8MfH8/LE+XTY3Y0FCfBg6bqcTYaDYeU8Cmgk9zt7QIDcBezZlJCuq1Lz3Gi93PjX0/d+bCkBppuZHgl35CTRNdA2PaLj+eigMnHa2z41tLManV/Ig7uV2N8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ra8FPJf0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e177027d-9286-4a30-9656-e0395094b2c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756386087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7v68eUbMhdBb1FN26U9K+vJv5tGLAeNVJMhgqgmwlM=;
	b=ra8FPJf02ezT/Z6Od+0hGN4l4CJBp5cRRQwc7kivX348XlYc76qHJiTCY2Zbr6BzuhziWV
	vtp6ovLknz+EW3nWC8g/Y5koIGMS61GWL+j18xx61d5DIBaIiGVrOdIF2zednYc5wZw2gS
	Hu5qlNzC2MneYgUfwtN/+OFL0BuZwcQ=
Date: Thu, 28 Aug 2025 14:01:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethernet: ti: Prevent divide-by-zero in
 cpts_calc_mult_shift()
To: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250828092224.46761-1-linmq006@gmail.com>
 <11d46e56-b8d9-4776-9969-d3767d8cda41@linux.dev>
 <CAH-r-ZH+0rsji1f9eEaVDtG3XcMCD_EnAHAMwr8DuqO4D4Ps=w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAH-r-ZH+0rsji1f9eEaVDtG3XcMCD_EnAHAMwr8DuqO4D4Ps=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:38, æå¦å© wrote:
> Hi, Vadim
> 
> Vadim Fedorenko <vadim.fedorenko@linux.dev> 于2025年8月28日周四 20:06写道：
>>
>> On 28/08/2025 10:22, Miaoqian Lin wrote:
>>> cpts_calc_mult_shift() has a potential divide-by-zero in this line:
>>>
>>>           do_div(maxsec, freq);
>>>
>>> due to the fact that clk_get_rate() can return zero in certain error
>>> conditions.
>>
>> Have you seen this happening in the real environment, or is it just
>> analysis of the code? I don't see a reason for these "certain error
>> conditions" to happen...
> 
> This is from code analysis, not from real environment.
> The !CONFIG_HAVE_CLK version of clk_get_rate() returns zero.
> With CONFIG_COMPILE_TEST && !CONFIG_HAVE_CLK could have the problem.
> This may be theoretical.

!CONFIG_HAVE_CLK will have cpts_create() doing nothing as defined in
cpts.h and it means the patch fixes impossible scenario.

NAck


