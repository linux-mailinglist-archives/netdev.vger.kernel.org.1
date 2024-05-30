Return-Path: <netdev+bounces-99509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4158D517B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1241F24A13
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA44653C;
	Thu, 30 May 2024 17:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C65219FD;
	Thu, 30 May 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091464; cv=none; b=ia7qqTQnfAz6r3xaHB1pStYsiq0A+oEjYo+dT5/OOoqm4JGx8pokd4mnvAtXEphL1ZGZ/5NUW6AxGdoBDyBWhkSxk7rxU6Aor445RSvZNiDZHUvA1cl0lZBX3q39+wd/SYukJdfMy6vBJgjZAxIu0gINDhO8jF5S1QsKgkJoSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091464; c=relaxed/simple;
	bh=EWIEk0SfL1qoQ87T87n2tHcu+axuW0rhQYyxUX24uEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsmi7XdxQrsGHPa2xbgCNNQzqun9L68/ls8d/UMeshgw9KRwpglh97pGNvIQBSLY5QwSrTx96zcSlLSDKUY5Qf75wnRJOKo8N7FeLlKcS8RIlgETQYrcQC/y8NF96HBbe/E5DhMnEy/FiMczw99p1eW8z/+nBfc8smwBRYIbMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546CB1424;
	Thu, 30 May 2024 10:51:26 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93ED3F641;
	Thu, 30 May 2024 10:51:00 -0700 (PDT)
Message-ID: <b6632140-f2b0-40db-9d1e-2486ddc5810b@arm.com>
Date: Thu, 30 May 2024 18:50:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 13/21] bitmap: make bitmap_{get,set}_value8()
 use bitmap_{read,write}()
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Potapenko <glider@google.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-14-aleksander.lobakin@intel.com>
 <5a18f5ac-4e9a-4baf-b720-98eac7b6792f@arm.com>
 <ZlizL6d1_ePq-eKs@yury-ThinkPad>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZlizL6d1_ePq-eKs@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/05/2024 6:11 pm, Yury Norov wrote:
> On Wed, May 29, 2024 at 04:12:25PM +0100, Robin Murphy wrote:
>> Hi Alexander,
>>
>> On 27/03/2024 3:23 pm, Alexander Lobakin wrote:
>>> Now that we have generic bitmap_read() and bitmap_write(), which are
>>> inline and try to take care of non-bound-crossing and aligned cases
>>> to keep them optimized, collapse bitmap_{get,set}_value8() into
>>> simple wrappers around the former ones.
>>> bloat-o-meter shows no difference in vmlinux and -2 bytes for
>>> gpio-pca953x.ko, which says the optimization didn't suffer due to
>>> that change. The converted helpers have the value width embedded
>>> and always compile-time constant and that helps a lot.
>>
>> This change appears to have introduced a build failure for me on arm64
>> (with GCC 9.4.0 from Ubuntu 20.04.02) - reverting b44759705f7d makes
>> these errors go away again:
>>
>> In file included from drivers/gpio/gpio-pca953x.c:12:
>> drivers/gpio/gpio-pca953x.c: In function ‘pca953x_probe’:
>> ./include/linux/bitmap.h:799:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
>>    799 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>>        |                 ^~
>> In file included from ./include/linux/atomic.h:5,
>>                   from drivers/gpio/gpio-pca953x.c:11:
>> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
>>   1015 |  DECLARE_BITMAP(val, MAX_LINE);
>>        |                 ^~~
>> ./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
>>     11 |  unsigned long name[BITS_TO_LONGS(bits)]
>>        |                ^~~~
>> In file included from drivers/gpio/gpio-pca953x.c:12:
>> ./include/linux/bitmap.h:800:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
>>    800 |  map[index + 1] |= (value >> space);
>>        |  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>> In file included from ./include/linux/atomic.h:5,
>>                   from drivers/gpio/gpio-pca953x.c:11:
>> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
>>   1015 |  DECLARE_BITMAP(val, MAX_LINE);
>>        |                 ^~~
>> ./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
>>     11 |  unsigned long name[BITS_TO_LONGS(bits)]
>>        |                ^~~~
>>
>> I've not dug further since I don't have any interest in the pca953x
>> driver - it just happened to be enabled in my config, so for now I've
>> turned it off. However I couldn't obviously see any other reports of
>> this, so here it is.
> 
> It's a compiler false-positive. The straightforward fix is to disable the warning
> For gcc9+, and it's in Andrew Morton's tree alrady. but there's some discussion
> ongoing on how it should be mitigated properlu:
> 
> https://lore.kernel.org/all/0ab2702f-8245-4f02-beb7-dcc7d79d5416@app.fastmail.com/T/

Ah, great! Guess I really should have scrolled further down my lore 
search results - I assumed I was looking for any other reports of a 
recent regression in mainline, not ones from 6 months ago :)

Cheers,
Robin.

