Return-Path: <netdev+bounces-147663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215429DAF51
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F85AB21AF5
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03656201037;
	Wed, 27 Nov 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGQV9ywC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3731537D4;
	Wed, 27 Nov 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747691; cv=none; b=MV9F1qb6mB9BbZKS1IAC39n7QwxCds4Ql7QpIKgGW4OFuWtwmNWGebIu40t28OSg/xl0fh4fGu1zDcgmhgZrHhWUtxjz5JnSwyXXmnJ8aAgh/VbaDHyCyWUQkGeDEtfzNsvj4EmUmI4SpzIwFID0WvtQJnN8xrz56G/3RBqLXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747691; c=relaxed/simple;
	bh=GexJXR/2dc2IBhv34q6bDcJcXTBjzVNHuP0avEFyg3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BAbaBMkkdeYO6eQhpeENFxFT3ZG0lqLhwDA9xPbWPxLaCeLiB+Tbpt0WqvvvQMgiJSV1x3pA3kVZTVdHeBh6JwsJ4rkDuwU6dwkJG7z8Pr59udZzw9Y1R+KfmjEHpgwzq8EyFUkfLIvJMclzcqFyPbaZGKWuP53zZhvVYPCi8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGQV9ywC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee153ec651so219273a91.0;
        Wed, 27 Nov 2024 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732747689; x=1733352489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PzsIRv0dmcoh1JVhn/KYfXIXK/gFawhUd+jupZesXIM=;
        b=RGQV9ywCV/S815EzHB3dkI4h6B1vmfD8bEoAFWtKDqEkjLsKqUW0uH7OMknMd84asn
         k9GI1e/ZrBxoZnb/lnOJeyx2lK5GwvokJICZyaibbOxnNuqknVh+d+tICMVGoFmLLyVE
         pKIvi8vaxCDgGhleMAh0WlhtHejf7PVVKX/cwo2NSyDqKIi33Tmh7p/bu/TQU52xVWt+
         bOvlzzUfEVLMIFET1DgriPOchHLRIiR4Zgq0XbPC27sRWdygakXuHdNL7UXrJ5HWdrXI
         G8w/FFoMDQR8YjxyaK/tY7BmkX9Orj69UPLWkJeU5YI8s5SuffhMEumx8mTOaVVLPxyG
         WV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747689; x=1733352489;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzsIRv0dmcoh1JVhn/KYfXIXK/gFawhUd+jupZesXIM=;
        b=YT3TmJ5U57e2ego32pPwFjWrmHL8cX8RbTniwuxJuc8Eef+BYjIFQFloMewjHmrBD1
         tKEIXSQnD0M85/eCMsbXzIudhcI3PAHnb+2vGTNEqJ72YYRM+Trsy3tvU5jwBbem4u6/
         ziLiFYqFLibVfWEgVUK9jkqxNzQPBlZGf10akXCt6NI+Eh8Vza9aAWaADgDzqujb8Izn
         RowWuVm+6yMsR1XlQq6+xOKyUK4pM/YazXnjHgJ+SZKMMirqilqe8V9wuRy/PYzgKW4U
         vsBnpL+Tre5X/taPa6WZYquS+VZKBJ+q55GNljE6xEgOjiRATAxifadEnjORfsW5Q37O
         b5og==
X-Forwarded-Encrypted: i=1; AJvYcCWg9g+uRCBV5hDg05bcVcezDtkPalViqeQsqMwCPwULgS6NZuoDyJelFAfqWfc1nnLXeLV/72WXM840Vu/5@vger.kernel.org, AJvYcCWxXyBy0NRMmw/nOki2j0BQnvjlxZsu37Ylk45YuKufYw3+txgRoWoLA5Ikm0Nm2hyml3lG7WqIz2A=@vger.kernel.org, AJvYcCXH4bltkoq1BIk3f+8/G9saY5ToKHdQ/uxo2CQRrXcpA3XB6AmJD5bESse4OkYFQUd/roAU/FJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaVfut8E36J+PE3Dbm4tE5rkln2hXZqovv3k3wAnSsJKV4MI8
	YTUCWYT8zzFPjPXvEwb231qUrO1AJ9CUPvbtg6MnzxWioF51P41u
X-Gm-Gg: ASbGncsQ77JmWxnoddyw79uWbYO3WMjo/bxa5AfzOGJ5y+HoUb0banuJJC0J1FxuxCX
	mbOYzG45D5TwitdsuQduq+ZpVC08/NgpA9aHYPJBSjyhkckCxQ11i2bjS4WXNJXX5sqmWJ7bAVD
	xzeHriwRqG8Aq9rnvgr9R9rDoUpKztCCGm+4POxmZcNA0HMI21LJ5mK0axlTHuwaYn4SutXNC+3
	QuT3+ZlFcci9PCCRSBlHT+0RX8VggG+lqq4zUV5JGCcV04/F3QhJTIXq5gHTldqdjlGfS6IKXic
	+rOCRXVm5CBOitskOdWq94A=
X-Google-Smtp-Source: AGHT+IHKrye4kW+lZBmR2EtaynTda3T7K6xVD46GM8CihjQl+xc26tZC3RgoDSFItG33JLMxhEeXPA==
X-Received: by 2002:a17:90b:3e86:b0:2ea:a9ac:eef2 with SMTP id 98e67ed59e1d1-2ee08eb1c46mr5790193a91.13.1732747689000;
        Wed, 27 Nov 2024 14:48:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad0797sm2141990a91.40.2024.11.27.14.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 14:48:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1bdc12d6-ac23-49ff-a235-5ea54ca2ddaa@roeck-us.net>
Date: Wed, 27 Nov 2024 14:48:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2> <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 12:00, Joe Damato wrote:
> On Wed, Nov 27, 2024 at 10:51:16AM -0800, Joe Damato wrote:
>> On Wed, Nov 27, 2024 at 09:43:54AM -0800, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Fri, Oct 11, 2024 at 06:45:00PM +0000, Joe Damato wrote:
>>>> Add a persistent NAPI config area for NAPI configuration to the core.
>>>> Drivers opt-in to setting the persistent config for a NAPI by passing an
>>>> index when calling netif_napi_add_config.
>>>>
>>>> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
>>>> (after the NAPIs are deleted).
>>>>
>>>> Drivers which call netif_napi_add_config will have persistent per-NAPI
>>>> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
>>>>
>>>> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
>>>>
>>>> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>>> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>>
>>> This patch triggers a lock inversion message on pcnet Ethernet adapters.
>>
>> Thanks for the report. I am not familiar with the pcnet driver, but
>> took some time now to read the report below and the driver code.
>>
>> I could definitely be reading the output incorrectly (if so please
>> let me know), but it seems like the issue can be triggered in this
>> case:
> 
> Sorry, my apologies, I both:
>    - read the report incorrectly, and
>    - proposed a bad patch that would result in a deadlock :)
> 
> After re-reading it and running this by Martin (who is CC'd), the
> inversion is actually:
> 
> CPU 0:
> pcnet32_open
>     lock(lp->lock)
>       napi_enable
>         napi_hash_add <- before this executes, CPU 1 proceeds
>           lock(napi_hash_lock)
> CPU 1:
>    pcnet32_close
>      napi_disable
>        napi_hash_del
>          lock(napi_hash_lock)
>           < INTERRUPT >
>              pcnet32_interrupt
>                lock(lp->lock)
> 
> This is now an inversion because:
> 
> CPU 0: holds lp->lock and is about to take napi_hash_lock
> CPU 1: holds napi_hashlock and an IRQ firing on CPU 1 tries to take
>         lp->lock (which CPU 0 already holds)
> 
> Neither side can proceed:
>    - CPU 0 is stuck waiting for napi_hash_lock
>    - CPU 1 is stuck waiting for lp->lock
> 
> I think the below explanation is still correct as to why the
> identified commit causes the issue:
> 
>> It seems this was triggered because before the identified commit,
>> napi_enable did not call napi_hash_add (and thus did not take the
>> napi_hash_lock).
> 
> However, the previous patch I proposed for pcnet32 would also cause
> a deadlock as the watchdog timer's function also needs lp->lock.
> 
> A corrected patch for pcnet32 can be found below.
> 
> Guenter: Sorry, would you mind testing the below instead of the
> previous patch?
> 
> Don: Let me know what you think about the below?
> 
> Netdev maintainers, there is an alternate locking solution I can
> propose as an RFC that might avoid this class of problem if this
> sort of issue is more widespread than just pcnet32:
>    - add the NAPI to the hash in netif_napi_add_weight (instead of napi_enable)
>    - remove the NAPI from the hash in __netif_napi_del (instead of
>      napi_disable)
> 
> If changing the locking order in core is the desired route, than the
> patch below should be unnecessary, but:
> 
> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> index 72db9f9e7bee..2e0077e68883 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -2625,11 +2625,10 @@ static int pcnet32_close(struct net_device *dev)
> 
>          del_timer_sync(&lp->watchdog_timer);
> 
> +       spin_lock_irqsave(&lp->lock, flags);
>          netif_stop_queue(dev);
>          napi_disable(&lp->napi);
> 

That is what I did, actually. Problem with that is that napi_disable()
wants to be able to sleep, thus the above triggers:

BUG: sleeping function called from invalid context at net/core/dev.c:6775
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1817, name: ip
preempt_count: 1, expected: 0
2 locks held by ip/1817:
#0: ffffffff81ded990 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x22a/0x74c
#1: ff6000000498ccb0 (&lp->lock){-.-.}-{3:3}, at: pcnet32_close+0x40/0x126
irq event stamp: 3720
hardirqs last  enabled at (3719): [<ffffffff80decaf4>] _raw_spin_unlock_irqrestore+0x54/0x62
hardirqs last disabled at (3720): [<ffffffff80dec8a2>] _raw_spin_lock_irqsave+0x5e/0x64
softirqs last  enabled at (3712): [<ffffffff8001efca>] handle_softirqs+0x3e6/0x4a2
softirqs last disabled at (3631): [<ffffffff80ded6cc>] __do_softirq+0x12/0x1a
CPU: 0 UID: 0 PID: 1817 Comm: ip Tainted: G                 N 6.12.0-10313-g7d4050728c83-dirty #1
Tainted: [N]=TEST
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80006d42>] dump_backtrace+0x1c/0x24
[<ffffffff80dc8d94>] show_stack+0x2c/0x38
[<ffffffff80de00b0>] dump_stack_lvl+0x74/0xac
[<ffffffff80de00fc>] dump_stack+0x14/0x1c
[<ffffffff8004da18>] __might_resched+0x23e/0x248
[<ffffffff8004da60>] __might_sleep+0x3e/0x62
[<ffffffff80b8d370>] napi_disable+0x24/0x10c
[<ffffffff809a06fe>] pcnet32_close+0x6c/0x126

Guenter


