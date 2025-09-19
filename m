Return-Path: <netdev+bounces-224748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01415B8929A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47FB1BC0BEE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3E309EF9;
	Fri, 19 Sep 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9rD8d5S"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF22309DA5
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279363; cv=none; b=ex74l650IjKEyAE1Q89SQGx2rZElBRE41PG3nUjT/ULYSkBYVae9dNeEhuS2ISmnXLAy8XCmEUWlZzgx+YfXsDVRC+P9PkQjK2Xeu1yLkqKh5FsLEm6JAzOgPJpaEgt9VRLG3kptbs1sabyp5oWGuxdTRLvI8IjFu02ShQ22DF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279363; c=relaxed/simple;
	bh=e23ONrNwd6j0B7ufboHq4DnDsT30NnxZb/YaBTwxzjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq0gUgOOGkW6eT6zD8VRYPiLwMf//5uenvI4baw6oUbXdnxg+Vxiyh7eSaRQkzGXjKBfgT9KDIvdYHuTmSfxdQKTqwGA0pk5FXWTVdDzHmmcyFLGf+lqTmjkPk8mAJN4BGExHeC4uheiwH40K5DLV1jBXJhabrZGhBa6vQ1Gi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9rD8d5S; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bf5066a-a006-4f93-93fd-38e4c063e59e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mmmnjsu9xXx/i0h/Qsh8uWABNz0Q9My1OhrKczY0Xc=;
	b=Y9rD8d5Sbz9S1OKeW/Jp5GeodEl2YYtUqvdsIE1Yb/Dkhie9iiUVtroew6SRci8G1AQzxU
	ccyz5npLbFup2oDOEjJZKJjvK7qEJaJnyMZpKfZW+BdC5yjWCe4cVbvHrEQw+l9w5cssY+
	asYNJxLiThEz/qK2fBy9glSQECLa5ws=
Date: Fri, 19 Sep 2025 11:55:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition in
 TX timestamp read for register 0
To: "Choong, Chwee Lin" <chwee.lin.choong@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Shalev, Avi" <avi.shalev@intel.com>,
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
References: <20250918183811.31270-1-chwee.lin.choong@intel.com>
 <0fc877a5-4b35-4802-9cda-e4eca561c5d1@linux.dev>
 <d30d7a43-ca17-445e-b7ae-641be2fcc165@intel.com>
 <SJ5PPF4422C53747941CD81779E97F26C34DA11A@SJ5PPF4422C5374.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <SJ5PPF4422C53747941CD81779E97F26C34DA11A@SJ5PPF4422C5374.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 08:17, Choong, Chwee Lin wrote:
> 
> On Friday, September 19, 2025 6:11 AM, Keller, Jacob E <jacob.e.keller@intel.com> wrote:
>> On 9/18/2025 1:47 PM, Vadim Fedorenko wrote:
>>> On 18/09/2025 19:38, Chwee-Lin Choong wrote:
>>>> The current HW bug workaround checks the TXTT_0 ready bit first, then
>>>> reads LOW -> HIGH -> LOW from register 0 to detect if a timestamp was
>>>> captured.
>>>>
>>>> This sequence has a race: if a new timestamp is latched after reading
>>>> the TXTT mask but before the first LOW read, both old and new
>>>> timestamp match, causing the driver to drop a valid timestamp.
>>>>
>>>> Fix by reading the LOW register first, then the TXTT mask, so a newly
>>>> latched timestamp will always be detected.
>>>>
>>>> This fix also prevents TX unit hangs observed under heavy
>>>> timestamping load.
>>>>
>>>> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing
>>>> timestamps")
>>>> Suggested-by: Avi Shalev <avi.shalev@intel.com>
>>>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>>>> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>>    		 * timestamp was captured, we can read the "high"
>>>>    		 * register again.
>>>>    		 */
>>>
>>> This comment begins with 'read the "high" register (to latch a new
>>> timestamp)' ...
>>>
>>>> -		u32 txstmpl_old, txstmpl_new;
>>>> +		u32 txstmpl_new;
>>>>
>>>> -		txstmpl_old = rd32(IGC_TXSTMPL);
>>>>    		rd32(IGC_TXSTMPH);
>>>>    		txstmpl_new = rd32(IGC_TXSTMPL);
>>>
>>> and a couple of lines later in this function you have
>>>
>>> 		regval = txstmpl_new;
>>> 		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
>>>
>>> According to the comment above, the value in the register will be
>>> latched after reading IGC_TXSTMPH. As there will be no read of "low"
>>> part of the register, it will stay latched with old value until the
>>> next call to the same function. Could it be the reason of unit hangs?
>>>
>>> It looks like the value of previous read of IGC_TXSTMPH should be
>>> stored and used to construct new timestamp, right?
>>>
>>
>> I wouldn't trust the comment, but instead double check the data sheets.
>> Unfortunately, I don't seem to have a copy of the igc hardware data sheet handy :(
>>
>> Thanks,
>> Jake
> 
> Flow before this patch:
> 	1. Read the TXTT bits into mask
> 	2. if TXTT_0 == 0, go to workaround ->If at this point register 0 captures TX timestamp, and TXTT_0 is set but we think it is 0.
> 	3. Read LOW to OLD
> 	4. Read HIGH – this clears the TXTT_0
> 	5. Read LOW again , now to NEW.
> 	6. NEW==OLD, so the timestamp is discarded -> causing timestamp timeout
>   
> Flow after this patch:
> 	1. Read LOW to OLD
> 	2. Read the TXTT bits into mask
> 	3. if TXTT_0 == 0, go to workaround -> If at this point register 0 captures TX timestamp, and TXTT_0 is set but we think it is 0.
> 	4. Read HIGH – this clears the TXTT_0
> 	5. Read LOW again , now to NEW.
> 	6. NEW!=OLD, so we detect this is a valid timestamp
>                7. Read HIGH again and use the timestamp
> 
> Let me know if this address your questions?

Unfortunately, it doesn't. The question is "what will happen to register
after step 7?" The comment above says it will stay latched until LOW is
read, will it affect performance/stability?

