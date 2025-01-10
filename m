Return-Path: <netdev+bounces-157272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC69A09D53
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58C3A8903
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94B2147E7;
	Fri, 10 Jan 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvFU2Tvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB022144CF;
	Fri, 10 Jan 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545278; cv=none; b=orCRoN8IONDCtHi7XYMHRxHeabk2OeydKtBExUHWFyw+/UAWW5Kn/tbuJ4SnbA2HCzt5un7DcxODPO7IASqz/65TXXtvSGvV/hqoxKHxXFyJMVo+MEGgetsZ+SQ/lDZ2DL06Vtj0k0b0Yg/4pgEG9uEQfPpHafldHSWkPng2vfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545278; c=relaxed/simple;
	bh=Op9MnXeObhSGWH2mINMz0HIZtS1/3S+R8/tNvF2nIG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2S3lSVK4bHAcfqaAKvbYb3s5gOvm+X3aFcFrAw3kqftc2cii4p86puAumyMCUZP5+S0m7aKhcVp43iMfcOn9S1w2EA04i4zuTXp2/Oc+bmaZhrd5S1xWwx+hPhmmNC0h3vvtYwBIbrAyRLW6dkrEgoS78o2mgCe4DkP/HuQD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvFU2Tvo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso16157245e9.1;
        Fri, 10 Jan 2025 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736545275; x=1737150075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJSwmMRtD+kJc8b0jhmm6OVNdsYEx4ZQUONBcIn5tmA=;
        b=kvFU2TvoLXk4+pFcA0UMfDHe3lU/tIw6J8Jebk+fHEIJoZJJyORIzld0KIxlqOQi7F
         O/ez4Ls0/cL3/ifDA59jSHT7FZbqHEwgY0ms0adNBUoz03hUq3VX0AfYtHtiVVpP3x6g
         krzj5OSNx+sebDi/HXyC8DCxn+K4GcSg7eSiE82N0XBLbdh0GU+1klXoALlvN0QSJe+B
         mctQ/K07+hkemTwV4OLWPg6Qs4fa6zIfVip4XpNYzVAV+YXlS/kP4uLdXOL05d9AZImN
         Wh/gtzr0YJaqeg4DncpMoOj97/AqD5i42IwGzPbtxMbRs4Wzbm+oHq4SraOv3lVdgYZG
         k1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545275; x=1737150075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJSwmMRtD+kJc8b0jhmm6OVNdsYEx4ZQUONBcIn5tmA=;
        b=V7UFc1fgBsh+ZarziYvDnt9TvCmmL2VOKu9hdppRlUq0SqUvGCO6RMiWB1e3xKpP0R
         fr+JaXAISzvY7XLAAcjACdl1e9Gf3lWqSj2Z6Z/fxdwOJnbX7sU0Y4IaHl64waYYH1yY
         WgSxm0w6wVQ2BZD6KG68LbODj5FzIDDXk5L9hC00qNM7HjrQYOTTJLXkELVbkN0xgSux
         8h7ZkcEwT+hLYBrvJMW6nshhf6sDrFu6ScH+DVapiO5mhHLsZu1eAxFzeceh5VKbL008
         JVPvwnSn8JEN4v9HzjmPWGEQMqnmQYI80HIjThI3Kn9EVUEYg+vVSSQPbzHSDlYgJDF+
         KEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYMrm+6f3p9UeqKjSH7AGIp/oRzkVUq8mTOX6W9yHve3HPD5ok7frWmMvuH4yqFuO/w2TgryiPnwFKeg==@vger.kernel.org, AJvYcCXKvv7u+gA8RlepZcoGoM3l/wSwQD2Vlnyx5q1aUV3pFhaSOcGG9FGQBunWypt45ZhRGoG2ojgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqaIGJC7IBr5YSUnBzmGHGo1TKS01+v1zIa7Wprr4BCNKrPBD
	mglgRsAueiNb54n3iq35RpHZK0wm/lrnxzan+ZFqhbuysASvlM+1
X-Gm-Gg: ASbGncsA48fHJlnZ29fGHF60GY2dQgWSlotWyQ287SZVmOkFxhpFMMhaHF/Yvo+g5Y/
	fbFeoTwdknVSVF1AOlhSQfUur+ROS1LkK/sM84HQaanUbcmASjx6j+dFGdoKneqi3OOkJrqRQP0
	c+wfdDfmKLOpnd9yM8onWAaz1sUQwwKeGJlhnFsw2uUUaZDgYnXD3kp4dux3m2RtDYbt+TQ5pgI
	IiXhCrza6yWI9nnITW2hzjDAzEGiJs5Nr4mZzS/d5gbG5lLoaQTAmNX5olejhrTl2pcu+DhEgT5
	LK77UtjrwefoUcoOZtU8wDOJJ2oOnVJXzPEc6s3X+G6V4PKlxt2TaLgeCWkouYryd1NtUs2CeKR
	+Un4zy7c1qp0daNIhbq+inO24SNXW79OVwBhJF+BMdJmt6A==
X-Google-Smtp-Source: AGHT+IHJ20F82b0823PoFNf7PIanzGSKTDvHFeUpetpcYHB5TwnR39DZsfQ+Wj3ptaR369kXx86EqQ==
X-Received: by 2002:a05:600c:3143:b0:436:1b0b:2633 with SMTP id 5b1f17b1804b1-436e9d74908mr72263955e9.9.1736545274829;
        Fri, 10 Jan 2025 13:41:14 -0800 (PST)
Received: from ?IPV6:2a02:3100:a08a:a100:1e8:1877:1b89:d707? (dynamic-2a02-3100-a08a-a100-01e8-1877-1b89-d707.310.pool.telefonica.de. [2a02:3100:a08a:a100:1e8:1877:1b89:d707])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1957sm63337085e9.16.2025.01.10.13.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 13:41:13 -0800 (PST)
Message-ID: <dca1302a-82d2-482c-acf7-d6af76241a6b@gmail.com>
Date: Fri, 10 Jan 2025 22:41:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
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
In-Reply-To: <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.01.2025 22:10, Andrew Lunn wrote:
>> - over-temp alarm remains set, even if temperature drops below threshold
> 
>> +int rtl822x_hwmon_init(struct phy_device *phydev)
>> +{
>> +	struct device *hwdev, *dev = &phydev->mdio.dev;
>> +	const char *name;
>> +
>> +	/* Ensure over-temp alarm is reset. */
>> +	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
> 
> So it is possible to clear the alarm.
> 
> I know you wanted to experiment with this some more....
> 
> If the alarm is still set, does that prevent the PHY renegotiating the
> higher link speed? If you clear the alarm, does that allow it to
> renegotiate the higher link speed? Or is a down/up still required?
> Does an down/up clear the alarm if the temperature is below the
> threshold?
> 
I tested wrt one of your previous questions, when exceeding the
temperature threshold the chip actually removes 2.5Gbps from the
advertisement register.

If the alarm is set, the chip won't switch back automatically to
2.5Gbps even if the temperature drops below the alarm threshold.

When clearing the alarm the chip adds 2.5Gbps back to the advertisement
register. Worth to be mentioned:
The temperature is checked only if the link speed is 2.5Gbps.
Therefore the chip thinks it's safe to add back the 2.5Gbps mode
when the alarm is cleared.

What I didn't test is whether it's possible to manually add 2.5Gbps
to the advertisement register whilst the alarm is set.
But I assume that's the case.

> Also, does HWMON support clearing alarms? Writing a 0 to the file? Or
> are they supported to self clear on read?
> 
Documentation/hwmon/sysfs-interface.rst states that the alarm
is a read-only attribute:

+-------------------------------+-----------------------+
| **`in[0-*]_alarm`,		| Channel alarm		|
| `curr[1-*]_alarm`,		|			|
| `power[1-*]_alarm`,		|   - 0: no alarm	|
| `fan[1-*]_alarm`,		|   - 1: alarm		|
| `temp[1-*]_alarm`**		|			|
|				|   RO			|
+-------------------------------+-----------------------+

Self-clearing is neither mentioned in the documentation nor
implemented in hwmon core.

@Guenter:
If alarm would just mean "current value > alarm threshold", then we
wouldn't need an extra alarm attribute, as this is something which
can be checked in user space.
Has it ever been considered that a user may have to explicitly ack
an alarm to clear it? Would you consider it an ABI violation if
alarm is configured as R/W for being able to clear the alarm?

> I'm wondering if we are heading towards ABI issues? You have defined:
> 
> - over-temp alarm remains set, even if temperature drops below threshold
> 
> so that kind of eliminates the possibility of implementing self
> clearing any time in the future. Explicit clearing via a write is
> probably O.K, because the user needs to take an explicit action.  Are
> there other ABI issues i have not thought about.
> 
> 	Andrew

Heiner

