Return-Path: <netdev+bounces-166927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F80A37EDD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20357A27D3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8DE2153EE;
	Mon, 17 Feb 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0EVRI9L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCA155316
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785133; cv=none; b=IltUqtRDbcDBO3i0nNzLGr7Y9avu3zI6pTHfUzR1622U0VzjQp0Np3HbM446Uz7+LaTXKD6fxKrS0qLtTb+gwaiV0Ni/FgCAYqPDRtEdvhxrayvMm6otkwNAkHapkXv4vgcuHkBOAeeAXlf/DS7M0f1ahQqwlQcY5eemKK2JvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785133; c=relaxed/simple;
	bh=WbeSwK55VQ8ulQtgaXCAw7A5RCVqIIPzoGQfC7e5fgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6mio94+OyxJQVttZaa/cNe6/BGxggKfytwOgnrLnwR7B0kMfLo3kwFK5GKs60MRKDL6kWUcVbE9Ydhhdo0FlxxxoYd0dIMWuv/3BfnCkI3BD4rSWi3rD03L7iuv/5hmVf6M6Rt9t9g2PaNDJU39nEXJbhp8L+ukQO3nIUTFsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0EVRI9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13DDC4CED1;
	Mon, 17 Feb 2025 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739785133;
	bh=WbeSwK55VQ8ulQtgaXCAw7A5RCVqIIPzoGQfC7e5fgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O0EVRI9LHbyeXtkmUpxnx3gWjYQmNctGb5WVMG2+XMv0tgQkSmXodSGBXsAdTVauU
	 UEuzr/6oQ0wPos2jOyoZjGTyUAu4ILMQLd47F5jlMd4PQu/QR6DcY4ES8vdi90YjVc
	 /xhk3iZfWfqvvLRhgieozAaTb3UMHaJjngYlZtDYtntaS5PFtBiM+/vkun2M7SSFfJ
	 EKIMR6bqfsl5nUkWO5WZsOaN6AggmdYBX99x5IQ0ISUfHWc69XEIQ5u1oPXfCKMCS6
	 gNDi68IGHqqUEMo49PvKR95MPtwT6kcjXuPv4urWV6sY/tsCnVjXOMzN5V3GMxi0EP
	 FVFTP/vHayfNQ==
Message-ID: <165410d2-98b5-48d2-9e51-6590d014bfd6@kernel.org>
Date: Mon, 17 Feb 2025 10:38:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org
References: <20250214064250.85987-1-kerneljasonxing@gmail.com>
 <CAHS8izOcLnt3SXzfbSA_vqno0R1SaBbXq-U8_LtRv64Bj7tUSQ@mail.gmail.com>
 <CAL+tcoAn3Je1P-c5=tAB9DNPQyYPEknk98WOZpC0jaPMuDqgnA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAL+tcoAn3Je1P-c5=tAB9DNPQyYPEknk98WOZpC0jaPMuDqgnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/02/2025 00.14, Jason Xing wrote:
> On Sat, Feb 15, 2025 at 4:27 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Thu, Feb 13, 2025 at 10:43 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>
>>> We noticed the kworker in page_pool_release_retry() was waken
>>> up repeatedly and infinitely in production because of the
>>> buggy driver causing the inflight less than 0 and warning
>>> us in page_pool_inflight()[1].
>>>
>>> Since the inflight value goes negative, it means we should
>>> not expect the whole page_pool to get back to work normally.
>>>
>>> This patch mitigates the adverse effect by not rescheduling
>>> the kworker when detecting the inflight negative in
>>> page_pool_release_retry().
>>>
>>> [1]
>>> [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
>>> [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
>>> ...
>>> [Mon Feb 10 20:36:11 2025] Call Trace:
>>> [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
>>> [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
>>> [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
>>> [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
>>> [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
>>> [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
>>> [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
>>> [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
>>> Note: before this patch, the above calltrace would flood the
>>> dmesg due to repeated reschedule of release_dw kworker.
>>>
>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>
>> Thanks Jason,
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> Thanks for the review.
> 
>>
>> When you find the root cause of the driver bug, if you can think of
>> ways to catch it sooner in the page_pool or prevent drivers from
>> triggering it, please do consider sending improvements upstream.
>> Thanks!
> 
> Sure, it's exactly what I want to do :)

What driver is this happening in?

--Jesper

