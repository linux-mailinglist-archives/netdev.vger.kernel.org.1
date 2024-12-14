Return-Path: <netdev+bounces-151933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA09F1B48
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4DE16B19F
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA60539A;
	Sat, 14 Dec 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FsktCloa"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D331FB4
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135482; cv=none; b=ChUIh+IbyLkV7FwD2Fhg+hHl1FWLHw4K+mG892z9I7uX1ecdyjGzUGUfDOewwc9Btd+cOGzq8/JTPlz2M6r4ZvC+oE5QEs28gTq9bT9MWY/I19UVqEcOXvPoICL3gWShtsANC33OVGYKarfjLEjLDA4kdniiURkZ9E3MYPGkFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135482; c=relaxed/simple;
	bh=KeCcRhow+86qc5vs4XdC+hiRQ5ec0oSKM6bzbjQ76qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxFy9m3+RGHCKcWQyqMxQq7SEGNylDI3MD5+eeA9XkmnnsaE51IujlHQXIIfpBD36/M7xebwzXev5HdOGqLBAMLgJM+tmHTM2hNRWt2uNvxEdxW7GC7ybg6FFasnowsvssc/ITNIyjzA+M3QGwHauMlY26GM6NkPFmgqR8ugjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FsktCloa; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd65a3e4-bc84-426d-b60b-eb4064dd7731@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734135477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCAbGUvluC0Y0sru1dCT3kRoMPN5ZbjT6v9S8jGO+Jc=;
	b=FsktCloaWuCoVCsZvSLcVGeGXkGPWP9RHooHZTtJXDamF8vmPP2W7tDBM0LWqkrwRFdoPZ
	Xs/pcBc2AIAtf0p6ciSfmI9hJdoHexE+zstRwvm+l6t8c/l2b8YX7hj9vlIZfMAM9mNWuG
	O6T4juadg/gzgqmqyLGkxn+YhMlBp+4=
Date: Fri, 13 Dec 2024 16:17:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-8-kerneljasonxing@gmail.com>
 <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
 <CAL+tcoCyu6w=O5y2fRSfrzDVm04SB2ycXB06uYn2+r2jSRhehA@mail.gmail.com>
 <53c3be2f-1d5d-44cb-8c27-18c84bc30c9e@linux.dev>
 <CAL+tcoBzapbhMuu6=jsDbf6N5eT84JmZ-siZFgHNogcRANj9bA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoBzapbhMuu6=jsDbf6N5eT84JmZ-siZFgHNogcRANj9bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 4:02 PM, Jason Xing wrote:
> On Sat, Dec 14, 2024 at 7:15 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 12/13/24 7:13 AM, Jason Xing wrote:
>>>>> -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype)
>>>>> +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
>>>>> +                             struct skb_shared_hwtstamps *hwtstamps,
>>>>> +                             int tstype)
>>>>>     {
>>>>> +     struct timespec64 tstamp;
>>>>> +     u32 args[2] = {0, 0};
>>>>>         int op;
>>>>>
>>>>>         if (!sk)
>>>>> @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
>>>>>                 break;
>>>>>         case SCM_TSTAMP_SND:
>>>>>                 op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>>>> +             if (hwtstamps) {
>>>>> +                     tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
>>>> Avoid this conversion which is likely not useful to the bpf prog. Directly pass
>>>> hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in args[0] and
>>>> higher 32bits in args[1].
>>> It makes sense.
>>
>> When replying the patch 2 thread, I noticed it may not even have to pass the
>> hwtstamps in args here.
>>
>> Can "*skb_hwtstamps(skb) = *hwtstamps;" be done before calling the bpf prog?
>> Then the bpf prog can directly get it from skb_shinfo(skb)->hwtstamps.
>> It is like reading other fields in skb_shinfo(skb), e.g. the
>> skb_shinfo(skb)->tskey discussed in patch 10. The bpf prog will have a more
>> consistent experience in reading different fields of the skb_shinfo(skb).
>> skb_shinfo(skb)->hwtstamps is a more intuitive place to obtain the hwtstamp than
>> the broken up args[0] and args[1]. On top of that, there is also an older
>> "skb_hwtstamp" field in "struct bpf_sock_ops".
> 
> Right, right, last night, fortunately, I also spotted it. Let the bpf
> prog parse the shared info from skb then. A new callback for hwtstamp
> is needed, I suppose.

Why a new callback is needed? "*skb_hwtstamps(skb) = *hwtstamps;" cannot be done 
in __skb_tstamp_tx_bpf?

