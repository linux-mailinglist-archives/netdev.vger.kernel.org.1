Return-Path: <netdev+bounces-243534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1ACA3369
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EA49303AFF9
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB133321AB;
	Thu,  4 Dec 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+jd3fiO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1YwhcYH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B41322C97
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844023; cv=none; b=lhstr/5tkSthlPNRsshOzc84EN5c5BcRGoLXmfyIZprbFGxLGln9t5hs6tCt9mFZA2SQ1ymKXm59AscM37g6Zjs/KT9PtvFehOYsNWf6Y0oBmZVbJmmLoOhu1LSUvyA9og7dRiSYmBcU5lb4h42EprVLgawk+GsqPMDLTMS6ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844023; c=relaxed/simple;
	bh=GDj0XOYw2INWgHhiZR3umk9UDMv5NvYwCIBslnkmAUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHmRWt6q+sLDIsaAiWdkuaq+0b+yumUTtK5p7vpMdNfkYWGHTD1VfcabDYFR/oASKP5rf06Bv86DRemOidweBCS1inw1loEriR2uUNFB1bBh6u7FLbIqMr1PJ94TB572SoysQc/K/j8bejQ11CwUNg+WH413S8OZCNOK03MIFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+jd3fiO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1YwhcYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764844020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvAgSuUIrE6mvYqIUbctn9fgbUe7c3R89eVWBs+ABmI=;
	b=c+jd3fiOTmCGgWGB3sm+PbSWM5DQAoBma3AG7avBet1pvugg6U5aZvXHbCRm40hWR/xRQS
	cZq76ZSWqTKPXeWlXtJWN0iVz/aBBtYnsxviERtkoAilOpubOJ9tHyxZtGJoDEdSlTrOAn
	YTI1EUXmIrnuGJr9u8GxM9P5k4VkqWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-qKgsBWB0M1OBoqoOr69O5Q-1; Thu, 04 Dec 2025 05:26:57 -0500
X-MC-Unique: qKgsBWB0M1OBoqoOr69O5Q-1
X-Mimecast-MFC-AGG-ID: qKgsBWB0M1OBoqoOr69O5Q_1764844016
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so482370f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764844016; x=1765448816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvAgSuUIrE6mvYqIUbctn9fgbUe7c3R89eVWBs+ABmI=;
        b=Y1YwhcYH3R2t7cHwbILSQMB3GkYdgotM9jU+0WRwmsf3w9iPieJv43FWos1jTUaRtT
         cbD8i2/EG9SJZelbGNZ25CqF2SUwJVHZO8NIC3TNJN3LUarErsAjWAgLf5Ld/SfWjg5o
         rf7sv5yTtrhLtgZpk0gU73E7T+eLWEmXVCib0VZpRLsM2/mNwr9GnjL40s8yiZRkxZd7
         oW112HjZ2QHkDy5QWv5OE30MfHYvWnbg0yDn/1c8FMbkdC0E0Tc53az7tJaEMA6ISXru
         FgM6qhNygeg6nU5Fj+uD2b7Zq0nsYOlz/oi5+sHLx+bNEUAdEWSXMgmYkSMWoSQXAL6p
         dNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764844016; x=1765448816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvAgSuUIrE6mvYqIUbctn9fgbUe7c3R89eVWBs+ABmI=;
        b=RBXYn5vKZooh8OJ6JpdOVW2HmckTdmHRu07ArBl/PrjOiif1dfL/WuungajS5HLB5V
         oAbgyySaR2ymHt7RdX7jpka0iddKCTdoOIH7KdoIttU+bvNag4HR3cTLx4OJT1ZIkbsu
         KHewNHdgSrSyFDWVuSFVRdXzJB1qUPNaDAeE1dyYpsQeZhx7Ey1up+5YPxQmOnfP1Jss
         QFQYHbIo447zo0RotiZETrSBVL2cvImMd1wd3lsR+X2tglsRNYx6DgkfGU6oTJBTexgh
         Tq8mnrFQWF1Dzdmo50MOOaCBs9NnT/wGh+rOhtVpdsfDcwiGsH/iaOg4x9erbBlTbSNE
         EvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2B4tL3ky/2WiqanwfokJ7BxAhXrJxs+WIIBlMoSBiOVSxRHe5We4WWrzqtN6uGInC2KhZpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRrCHD348JycOSdB3nWzoMn3ftf+OKWifRjU0IF15RWBEcVl0
	4YRj/nPlXu7LhYMeYb0wGbLaH2u8HKHGrYNu2Ld1OcplbpOZB6T1vxWj6s9ejUgxd+fdhVb1H9g
	vx8LkptUNvLWiXuH3jYInr8EV2p0ydV9cr7yantydQK+Cb9c1uPOFp/oWVQ==
X-Gm-Gg: ASbGncuoml+U+H0kxXfD67GqkQk4AhP24KbVgqpaUvYQOXdXyHsH1EnkvC8diCKiVYT
	jti6afCgU4qPOsPWiNVh+e9EtyLXCKtuDxAf+tP5EVtNHWWkktF9uwix9lqPQGxWM+1PMJVCpUc
	a7yGt09mN7xAwZoXJ7WUmkoddOmpmkkcwMNaAdfdFco4PuZ1GRMV2x94i2RCsqO2XlrQ9n+lntV
	fLgxJV16KixuB7YwuFM4dB+1T+zJmD39zjLHeb4/2jy/PuJHnGXtQIWewACnT41ryzr0ZYxYbHp
	i0h7OuTVB2TpidiPBRdDrrivNwpAckLRK95kedK1qW92ja5OOAnSpNaGGUzalN1/5vZDmZOLpTr
	R0LutvceC+sAf
X-Received: by 2002:a05:600c:1393:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-4792af43957mr54762275e9.30.1764844016139;
        Thu, 04 Dec 2025 02:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe2VYdkOW4g2chRFIty06a+I10kiBp0/8HHsTFNbQNcY2Gfnm64HqRkjy1wllbisNEXQJWeg==
X-Received: by 2002:a05:600c:1393:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-4792af43957mr54761915e9.30.1764844015694;
        Thu, 04 Dec 2025 02:26:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm23316675e9.0.2025.12.04.02.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:26:55 -0800 (PST)
Message-ID: <e3c1117c-144e-4f4e-ad43-d0a11bc2ecaa@redhat.com>
Date: Thu, 4 Dec 2025 11:26:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: atm: targetless need more input msg
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69298e9d.a70a0220.d98e3.013a.GAE@google.com>
 <tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 4:56 PM, Edward Adam Davis wrote:
> syzbot found an uninitialized targetless variable. The user-provided
> data was only 28 bytes long, but initializing targetless requires at
> least 44 bytes. This discrepancy ultimately led to the uninitialized
> variable access issue reported by syzbot [1].
> 
> Adding a message length check to the arp update process eliminates
> the uninitialized issue in [1].
> 
> [1]
> BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
>  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> 
> Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

This needs a suitable fixes tag, and you should specify the target tree
into the subj prefix, see:

https://elixir.bootlin.com/linux/v6.18/source/Documentation/process/maintainer-netdev.rst#L61

> ---
>  net/atm/lec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index afb8d3eb2185..178132b2771a 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -382,6 +382,15 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
>  			break;
>  		fallthrough;
>  	case l_arp_update:
> +	{
> +		int need_size = offsetofend(struct atmlec_msg,
> +				content.normal.targetless_le_arp);
> +		if (skb->len < need_size) {
> +			pr_info("Input msg size too small, need %d got %u\n",
> +				 need_size, skb->len);
> +			dev_kfree_skb(skb);
> +			return -EINVAL;
> +		}

Can this be reached by pppoatm_send?
Are you sure that the data will always be available in the linear part?

/P


