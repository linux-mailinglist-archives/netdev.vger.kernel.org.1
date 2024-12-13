Return-Path: <netdev+bounces-151910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5E9F19C1
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61758188D10B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57191A8F9B;
	Fri, 13 Dec 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPSlgqbr"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B2193073
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131763; cv=none; b=eeces/A2Y3aBdwSx7ULwvohhv9UMLGt+4nF03fazOzLqSIv4DAmZc/KptBD51Q8aANlQrKF1MDCiMW0hocSPrfBoek489LCASDGA55mI9ojvBIku3tAuy5WR8UtU6P2mw17XiMuANf3TQRhU8fwo7s3xLhX3S3ZjIHjzm3M2yYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131763; c=relaxed/simple;
	bh=KKtL/PsftXCwKV92mSnukQ5R/DtW4ysnRr1ukbBlzkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmQWWhjO2dh7OxPZ6CjWcUdLRka5B1/yxdtJElS8NcztZEiX5frkN4HO8HeEweCw61lyGD9A4rboWSVEBAPcP9X3+zRUYBTW18NBejcWiUdUX7zoc70EDqthWm4fktYuaKbIvucaW83DaD0PP6ZPvVqRWsXJ30fcQ58n2BZ8ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPSlgqbr; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53c3be2f-1d5d-44cb-8c27-18c84bc30c9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734131759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LX6/0+0xRBVNtjMps0VhjdxMoYFyXabZfc6NB2DXmV8=;
	b=qPSlgqbrYKnL2SEVNmYTn+ss6A9f/+27X16fS7eqxZkJ9jdH4p5UUD+I7AL7CW+ZPC391e
	gRjDHWCUNRiFilA8FPQaWbto8/QRpoQb1LtsIrOW3yyjHUhc6KyV9+KbzqSrqRFhXOJvuV
	6cq4dnwb5p6ieehk7EmiexRZAHb6ueo=
Date: Fri, 13 Dec 2024 15:15:48 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCyu6w=O5y2fRSfrzDVm04SB2ycXB06uYn2+r2jSRhehA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 7:13 AM, Jason Xing wrote:
>>> -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype)
>>> +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
>>> +                             struct skb_shared_hwtstamps *hwtstamps,
>>> +                             int tstype)
>>>    {
>>> +     struct timespec64 tstamp;
>>> +     u32 args[2] = {0, 0};
>>>        int op;
>>>
>>>        if (!sk)
>>> @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
>>>                break;
>>>        case SCM_TSTAMP_SND:
>>>                op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>> +             if (hwtstamps) {
>>> +                     tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
>> Avoid this conversion which is likely not useful to the bpf prog. Directly pass
>> hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in args[0] and
>> higher 32bits in args[1].
> It makes sense.

When replying the patch 2 thread, I noticed it may not even have to pass the 
hwtstamps in args here.

Can "*skb_hwtstamps(skb) = *hwtstamps;" be done before calling the bpf prog? 
Then the bpf prog can directly get it from skb_shinfo(skb)->hwtstamps.
It is like reading other fields in skb_shinfo(skb), e.g. the 
skb_shinfo(skb)->tskey discussed in patch 10. The bpf prog will have a more 
consistent experience in reading different fields of the skb_shinfo(skb). 
skb_shinfo(skb)->hwtstamps is a more intuitive place to obtain the hwtstamp than 
the broken up args[0] and args[1]. On top of that, there is also an older 
"skb_hwtstamp" field in "struct bpf_sock_ops".

