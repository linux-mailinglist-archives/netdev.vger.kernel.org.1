Return-Path: <netdev+bounces-126058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C596FD35
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD42840AC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0014B956;
	Fri,  6 Sep 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3vt6RbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8A149C7A;
	Fri,  6 Sep 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657424; cv=none; b=M8aumk9i4uvhr2ctfAfJ0LrKCD/RfIzKRR51yEM3FrztWkYOrl5T/deKf11l0ax2/hZCu7M15sU5OgTbEUOCFXfY8DVDYR7M0R4t9aaUVXePerYvklnqBNQlNchYQwgXbn+hsHNXXx3WL5oc5PE8dV/Jmrcj1m8TYe2YcA50enA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657424; c=relaxed/simple;
	bh=exEcAQcbp/H1LZtwWplSPgGpl/hNHojIdj3gTPTG9HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK8sfP5alc7O8T7RWAvZk0GBWCaw3gxHf4xF97AFksWwWGf9LaBHxxMZTO7ANYjGiDenlra/FgmH9k5v6tnTRnuEYRvenX4Lc3/lXon6/xtP0BiXgAMzGkRI78XtwU797flPD76gnVMex04IwtIOTZMBwFT7FsoaNAqC0ho7UXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3vt6RbQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868d7f92feso353063266b.2;
        Fri, 06 Sep 2024 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725657421; x=1726262221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYx/MlMnx325TFNB6gFQhpihCuWdY0bhTqUHki4lGI=;
        b=Z3vt6RbQxu25VUML3ddrqa551yw5ehNh3UMupRjRnXkhEh463joSqxL359Hdu9lfLi
         8CzM2Jo1vUvleVZfLNYAqIw9u9KhUVYivCFZQKFCsLiOiL37GMkjvClNO3X8bRSioAv+
         zIM8y+fHQnnrntGI+LWqAUEdOIZ6AI+iOUc+ho/1IxtnOUOuXNP+rMd/I4NyE5C4+bXV
         Fyfv4qOHEDCnhq1Zo9EyV/0Es3xJoK1db0yEo9MrJvCNC2lA0eZhZ0Vd8Quy9APJnvLv
         YfOWklPFQyDJGBIQvok9wvVRASMxRZJ7Bo0bheXRWk+sE6cUWASdvQH2+i4WF34q/v+u
         WLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657421; x=1726262221;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOYx/MlMnx325TFNB6gFQhpihCuWdY0bhTqUHki4lGI=;
        b=Bu+mzaQ1rcxWSe4ynF95Qgh3fG2YMbyTJd87T95UNoU3Z9QxLdQoeom6ceYPQWdLVU
         PLiOWSzGsIVCS9s0CfWwk63+MPSmgfFaN52RjXWlQmo7Mb0RohQxdBB0zvRkp2cp/E4J
         rsfdTofi2uW8+9DC0qzLg3QoCv0W3ezlEWMye+zv5S9QluvDIveFJK2q7qN+dsaMK7nm
         AXJicEr4q887e0CxgH+8u3QfGgccs9I7Vgfts3cXP6U2W+Qt2kc2KIJgSoCSt8968OSq
         7Ir7gx5D1HRQH2GGPw7PWb8ECjOPSptfrSOcFQCPJMru/RLKHbdnxnyCFroFNK1GFQtm
         SGnw==
X-Forwarded-Encrypted: i=1; AJvYcCU4YMdfVSrEMmhY70AChDWvsdBrHL45EQ4ZUVtUuFIDz8a5IGPSnV3J9dtqj1Item1NHzrYAtFG@vger.kernel.org, AJvYcCXuD4ytUnOcz7tIE8CHdLwxqmogMbkswU6tBX5oNm6rr1T5TRm2LaPxorDkxkRseaB7Wqg7y695PIDD66A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SfRC8kewBmouRvXVeU18tV8zoy/evprrYNwfLawwwb0Sr6Dg
	nwXejSOf62uUq2AjezDQ43Mkpz9OIx/6wzlt4fPdwKqorL6IAN59
X-Google-Smtp-Source: AGHT+IEOyasT7IUwBXZXv5ZJjWcCPbGm1W8EH4nLJQ4DxJ0wy0xaUxLJOxcAKwoN/jTkUj0H7qlAbA==
X-Received: by 2002:a17:907:1c16:b0:a7d:a680:23b5 with SMTP id a640c23a62f3a-a897f8d5179mr2295046766b.33.1725657420606;
        Fri, 06 Sep 2024 14:17:00 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c43:4a00:fd31:6f97:dce5:bb00? (dynamic-2a02-3100-9c43-4a00-fd31-6f97-dce5-bb00.310.pool.telefonica.de. [2a02:3100:9c43:4a00:fd31:6f97:dce5:bb00])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8d11d531f5sm46611266b.108.2024.09.06.14.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 14:17:00 -0700 (PDT)
Message-ID: <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
Date: Fri, 6 Sep 2024 23:16:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: En-Wei Wu <en-wei.wu@canonical.com>, nic_swsd@realtek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kuan-ying.lee@canonical.com, kai.heng.feng@canonical.com
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20240906083539.154019-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.09.2024 10:35, En-Wei Wu wrote:
> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
> link-down on RTL8125") set a reset work for RTL8125 in
> r8169_phylink_handler() to avoid the MAC from locking up, this
> makes the connection broken after unplugging then re-plugging the
> Ethernet cable.
> 
> This is because the commit mistakenly put the reset work in the
> link-down path rather than the link-up path (The commit message says
> it should be put in the link-up path).
> 
That's not what the commit message is saying. It says vendor driver
r8125 does it in the link-up path.
I moved it intentionally to the link-down path, because traffic may
be flowing already after link-up.

> Moving the reset work from the link-down path to the link-up path fixes
> the issue. Also, remove the unnecessary enum member.
> 
The user who reported the issue at that time confirmed that the original
change fixed the issue for him.
Can you explain, from the NICs perspective, what exactly the difference
is when doing the reset after link-up?
Including an explanation how the original change suppresses the link-up
interrupt. And why that's not the case when doing the reset after link-up.

I simply want to be convinced enough that your change doesn't break
behavior for other users.

> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3507c2e28110..632e661fc74b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
>  enum rtl_flag {
>  	RTL_FLAG_TASK_ENABLED = 0,
>  	RTL_FLAG_TASK_RESET_PENDING,
> -	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>  	RTL_FLAG_TASK_TX_TIMEOUT,
>  	RTL_FLAG_MAX
>  };
> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
>  reset:
>  		rtl_reset_work(tp);
>  		netif_wake_queue(tp->dev);
> -	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
> -		rtl_reset_work(tp);
>  	}
>  out_unlock:
>  	rtnl_unlock();
> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
>  	if (netif_carrier_ok(ndev)) {
>  		rtl_link_chg_patch(tp);
>  		pm_request_resume(d);
> -		netif_wake_queue(tp->dev);
> -	} else {
> +
>  		/* In few cases rx is broken after link-down otherwise */
>  		if (rtl_is_8125(tp))
> -			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
> +			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
> +		else
> +			netif_wake_queue(tp->dev);

This call to netif_wake_queue() isn't needed any longer, it was introduced with
the original change only.

> +	} else {
>  		pm_runtime_idle(d);
>  	}
>  


