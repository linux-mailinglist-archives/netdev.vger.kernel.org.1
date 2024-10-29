Return-Path: <netdev+bounces-139994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B149B4F91
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD53BB2244A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B851D79BB;
	Tue, 29 Oct 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk189abe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EA1D6194;
	Tue, 29 Oct 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219890; cv=none; b=flGT/jYxEA+K+oFSw8xDWgfNnp3gHT2QhPNFa8JkN7rasgg+kK1ZVJVWiF4/TfOHky8L2bGgUm/s3/PlLV+/KrlIZzN00yL4F1DgphtUQr6l7B7Nbl5a5Pkh1WsqFEwoGnQsdWl+LLNrNwz707Jlubp3bQNrGXLNM5jmXSUv6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219890; c=relaxed/simple;
	bh=xhGgxrxdhI77oYmrM98/2S8lIX5d84zrf1QI7RDmWec=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ecrX9g4o9mLfmFn9/EWDgODIr1ZPvhM4IEAJQeP7AbZwX0ai9vItY3jzvOKgC8495BaEs2tGJdrI5Zi3BuL9xCWwx/GQaCim4S5FwsprrPBhrAXTeokYQYCCFvP+vPASTWpjEOE+D46ww7k3JMZINJhTkf7GTceL4u6Svu2SwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk189abe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea6f99e6eeso371707a12.1;
        Tue, 29 Oct 2024 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730219887; x=1730824687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GyRJo8osUh0bS/jXb3vmYZGR0kFLUh88z7vDZ8WsGmw=;
        b=Lk189abeH1BrcbtMwcKve1LbElDx1sm9tvSWzVr0SB780upcoFVz4NHFSZdwxhKZkQ
         R9hS90UmsrQdPNB629fDAqNCBGl98u/THPQXnXrd+nYroM9xXeYx8Xy73uzTwUmpD9as
         DUdXxcryw8w2j2y7aEpeNNTsArzsKfcXdJ35ltZT1Xdb86StqDv8jOfRa6Ot/m8Vql3L
         CQBDjqZrgKrMNyBgrb56uQs42ofTvjYiJVHZqnTG3HQ42mEsYBEq36TR4kw/Ekoz8OTk
         M+Cv4e0lsKyJ4eGVzi4OFcluHHX3yc6uZSsyR32q2vrKzILREW3SY8QQiLtvCuKJg+Zt
         mPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730219887; x=1730824687;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyRJo8osUh0bS/jXb3vmYZGR0kFLUh88z7vDZ8WsGmw=;
        b=o3IIJiAB5pH2qZdKtr8Co5qAEOEun2qgDf2vdURbBG3T7Z0EljYlAY8zQJ82eQP3By
         K360lVNO1f0jo4i1YYnzxEm8Q5XHU36jmz0vw7TxZtkPk6wfsk/7wkH+yGASQAPTW3rM
         vYH0kbQ+IsEF5HBhmI4k86AUwEeJLw2F6Qz/hK89b/Tsxg6qMC27N1A16kgXOBJjMeWe
         8Z/ZqrUOG9kAUVQ1/sq/o3hMVp4y/PTu7OgLUveW7R2ACl41Vf6dDTdWlWFVq0JpkQqN
         kO+CcpGj3gDkFakMXwRjCQg5RsOpkM/+Xf+w7CnV1tuZWhEBZp+wLEVTCYJiSJUdDUkC
         rcsw==
X-Forwarded-Encrypted: i=1; AJvYcCWKwkmYJmiG2+eef36THWjHzbEfdL7PREKxe8gAKoG7QmfFNFSVFzjkoEXGcbWaNcnLKRHXX3es@vger.kernel.org, AJvYcCXQNnwExyCXZC2lMgftyJbr60+S+w6VDWY/3bma+u+x6sOy7zTgZvbFADTAVeU12XIHXWv+F4utLdyTZuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCY7MEL0U1BRDx8LabdHxqVKtU1IO2upBgZf7XRHXkm9jghlB
	xdob2OJySm9N5CpoIPuZf/nZ4h3lM90mJosRQyNyB8i01zR5Pg5/PPosXQ==
X-Google-Smtp-Source: AGHT+IEOidahH12yUik1E97OBTgPFsm3C1isybXyzLOwzLpxSlRhRJUlz4OcFNmOicpiDHU0UWQYOg==
X-Received: by 2002:a05:6a20:3946:b0:1cf:52ac:4ec9 with SMTP id adf61e73a8af0-1d9a84dd505mr8277846637.8.1730219887067;
        Tue, 29 Oct 2024 09:38:07 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:e12b:a9a3:6d06:6d0a? ([2402:e280:214c:86:e12b:a9a3:6d06:6d0a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793325dsm7732980b3a.76.2024.10.29.09.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:38:06 -0700 (PDT)
Message-ID: <e9a89d87-d1a7-44cb-aab5-07a61d578c3c@gmail.com>
Date: Tue, 29 Oct 2024 22:07:58 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: R Sundar <prosunofficial@gmail.com>
Subject: Re: [PATCH linux-next] ice: use string choice helpers
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, karol.kolacinski@intel.com,
 arkadiusz.kubalewski@intel.com, jacob.e.keller@intel.com,
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <20241027141907.503946-1-prosunofficial@gmail.com>
 <ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com>
Content-Language: en-US
In-Reply-To: <ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/24 15:24, Przemek Kitszel wrote:
> On 10/27/24 15:19, R Sundar wrote:
>> Use string choice helpers for better readability.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>> Closes: https://lore.kernel.org/r/202410121553.SRNFzc2M-lkp@intel.com/
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
>> ---
> 
> thanks, this indeed covers all "enabled/disabled" cases, so:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
Hi,

Thanks for comments.

> for future submissions for Intel Ethernet drivers please use the
> iwl-next (or iwl-net) target trees.
> 

Sure. Noted.

> There are also other cases that we could cover ON/OFF etc
> 
>>
>> Reported in linux repository.
>>
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> cocci warnings: (new ones prefixed by >>)
>>>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:396:4-22: opportunity 
>>>> for str_enabled_disabled(dw24 . ts_pll_enable)
>>     drivers/net/ethernet/intel/ice/ice_ptp_hw.c:474:4-22: opportunity 
>> for str_enabled_disabled(dw24 . ts_pll_enable)
>>
>> vim +396 drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>
>>
>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c 
>> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index da88c6ccfaeb..d8d3395e49c3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -393,7 +393,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
>>       /* Log the current clock configuration */
>>       ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, 
>> clk_src %s, clk_freq %s, PLL %s\n",
>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>             ice_clk_src_str(dw24.time_ref_sel),
>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>             bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
> 
> perhaps locked/unlocked could be added into string_choices.h
> 

Sure, Can I add locked/unlocked changes in linux-next repository and use 
suggested-by Tag?


>> @@ -471,7 +471,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
>>       /* Log the current clock configuration */
>>       ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src 
>> %s, clk_freq %s, PLL %s\n",
>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>             ice_clk_src_str(dw24.time_ref_sel),
>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>             bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
>> @@ -548,7 +548,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>>       /* Log the current clock configuration */
>>       ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, 
>> clk_src %s, clk_freq %s, PLL %s\n",
>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>             ice_clk_src_str(dw23.time_ref_sel),
>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>             ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
>> @@ -653,7 +653,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>>       /* Log the current clock configuration */
>>       ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src 
>> %s, clk_freq %s, PLL %s\n",
>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>             ice_clk_src_str(dw23.time_ref_sel),
>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>             ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
> 


