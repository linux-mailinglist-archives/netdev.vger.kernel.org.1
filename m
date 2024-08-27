Return-Path: <netdev+bounces-122177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D931B9603E5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F9D2829E5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029371917E6;
	Tue, 27 Aug 2024 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f/sZPKBd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E133189522
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745823; cv=none; b=gXrfaIf3g/zMCRuYCj/sC+Ut518gGDfRVmc9v/sqUGVG+tqs3uYFdAVeBZ4foUIyIwBWlLs3KieKSDWmkQjB9rUWX9sr5Z9tVjV12zNba6OVuYspKsOr/30FzqXDLt465wTCtgiZFWaZx2k2sNZ4fPoyysD5PIvQfj/0jGb5K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745823; c=relaxed/simple;
	bh=JPbLOrfitdr79yK878Qc2046eEBvIFhjLJdQeO6MPNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBH0nUGRNzwMy2S/CgS9GAZ20J0Tb0La75tAQg3GJ03vaySflRhSPb1+ABKC5cuXJjZDHAHSmNP9SoQEPLzTjrCWzlH/8tVjeXe6w+6tCWuMZDshXL8mY4CCfrDPxwviqqMlmpbyJy1GvWRgbGnvTfHi/1vDKFMsCFf7FlQ7Hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f/sZPKBd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20227ba378eso46762945ad.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724745821; x=1725350621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0alnhJeXJ8CNHH+iupeZGBYbM9/noOx7k0vEP0Fbe0I=;
        b=f/sZPKBdTBax3V66MC0r4+eAFca2bt7rVHD4qkzovMdIMbXf/068hF40GchjUhrPmt
         aka81b8QizouBUYWUxUYQpKif5a7VsHEeb+QjOwJGnDDd/D7hScxhhs9UXwl4LY6Ze+4
         /Ek894VEA6ZMRiRmndYHcnhWVVrpEsBYdnBMSrw93yQejD59+u/slQ/7E29JuXRZLuis
         FFT75pWhDvLcVNWgYHqoHFHg77s9FfV81oBE/WRziTL04V21iVs6NsCr6jXhg5ltIq4J
         ox39qJaExgNKqvEIn3DO/9JCdTjcVC+3nz1+qRqCMcilPioFe7kx4lznEqXFDKjrPsy6
         FF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745821; x=1725350621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0alnhJeXJ8CNHH+iupeZGBYbM9/noOx7k0vEP0Fbe0I=;
        b=vqbefXy/szRBJCkzgpx1YWooeVHsiYWoDsvkJK64RLHnCsfSQr95kSz4NHcI7+akKU
         SZ5w/E6J/5W+0cAZ43773U0nQYJtuuk9X+p0sjmhJ/8fXh26KNUVdU0iPx0gEdnVQgNc
         E2vQm9LaBxwub5/M8D5ARa6aI+WNNflSsDFw83j/ZBy/fdxrEj/QZppuwfhRVyY4abSe
         T6ZWjhoJvr0VbBmQqlt1q9EtrntxJQA7HN37IZZO8X4MGeoNPfKRJSrVjELKhy3PsEmB
         VxXt487nlUPcyvjEdWMTsbG0wRb4m5mQtzfXrt1cSUxkuE+SW5A64qb5/kJmCMlNnBxZ
         EUFA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZqiI1AfLqfpLnVxTD9FO7IMNLqB3/hHDq+QdXSYzVMzPOLKXXLADBi7eHlM+1Xx3a6pJLcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFT8hfJ6ym/eTqsPhTPrEepyT0uz7r2l/NLrXkCsmVF1vWusL
	OO+7EkTZ9ViMAG7MbpEE8oFmD0SuG7ohKT2AVX2yCXR4GpMA+cGPcbTodBBd7hg=
X-Google-Smtp-Source: AGHT+IEfFJcUX481vjGBLHA6+KBbX4S3KVNLdQ6kxZyqIqN2wlO5r29hxw6Z2W8raEZHF65OaG9PYg==
X-Received: by 2002:a17:902:dacc:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-2039e4428ccmr6716235ad.9.1724745821356;
        Tue, 27 Aug 2024 01:03:41 -0700 (PDT)
Received: from [10.68.121.74] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566551sm78673775ad.13.2024.08.27.01.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:03:41 -0700 (PDT)
Message-ID: <8ca80081-5935-44cb-804d-86bd6bad02d7@bytedance.com>
Date: Tue, 27 Aug 2024 16:03:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2] net: Don't allow to attach xdp
 if bond slave device's upper already has a program
To: Daniel Borkmann <daniel@iogearbox.net>, Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
 <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/23 20:07, Daniel Borkmann 写道:
> On 8/23/24 1:55 PM, Jiri Pirko wrote:
>> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Cannot attach when an upper device already has a program, This
>>> restriction is only for bond's slave devices or team port, and
>>> should not be accidentally injured for devices like eth0 and vxlan0.
>>
>> What if I attach xdp program to solo netdev and then I enslave it
>> to bond/team netdev that already has xdp program attached?
>> What prevents me from doing that?
> 
> In that case the enslaving of the device to bond(/team) must fail as
> otherwise the latter won't be able to propagate the XDP prog downwards.
> 
> Feng, did you double check if we have net or BPF selftest coverage for
> that? If not might be good to add.
> 

Will do, thanks.

>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>> Changelog:
>>> v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>>> - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>>> Details in here:
>>> https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>>>
>>> net/core/dev.c | 10 ++++++----
>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index f66e61407883..49144e62172e 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device 
>>> *dev, struct netlink_ext_ack *extack
>>>     }
>>>
>>>     /* don't allow if an upper device already has a program */
>>> -    netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>> -        if (dev_xdp_prog_count(upper) > 0) {
>>> -            NL_SET_ERR_MSG(extack, "Cannot attach when an upper 
>>> device already has a program");
>>> -            return -EEXIST;
>>> +    if (netif_is_lag_port(dev)) {
>>> +        netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>> +            if (dev_xdp_prog_count(upper) > 0) {
>>> +                NL_SET_ERR_MSG(extack, "Cannot attach when an upper 
>>> device already has a program");
>>> +                return -EEXIST;
>>> +            }
>>>         }
>>>     }
>>>
>>> -- 
>>> 2.30.2
>>>
>>
> 


