Return-Path: <netdev+bounces-164378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD7A2D9A5
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C6B3A6469
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC624338F;
	Sat,  8 Feb 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArRoMZ6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FE24338E
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739056908; cv=none; b=uQQXxpdpfDgcOWcdtWVv6LGHabg3zTsF5sjuIFGTj4bvaVsFZOiRK/FtvaRlkYq7ZOOxQCvUWvxhsd/SX98DI/p8N82iJit/BMVZr31OrkXd6gpdESO6TK88CXJP6N7FWhBfXRJRSyS6lM1/uIbPFsljdhxeL5qoZp5iu30glco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739056908; c=relaxed/simple;
	bh=RI0N0W2Vj0Rl+I/N8D1RVQRRVPHXT4APrXcpJ9EZ5Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZnyO+PoY7GeLxgUK6Ed7RG/bpG7ulfVi1VKRB57vsQFKvE8EVYgyM2q4Ztk+obQHHzZDkl7E5fNzjyngocg8me177gD1CS/wWg4Cv1iyEIAjhLuhyscB/uM5oCtofJT1a/x5uR7CtYxD0yOjtC5CRU/l+uLJFO2a8rQn+HPyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArRoMZ6S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so721286066b.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739056905; x=1739661705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFu+sehOCC7lltohHvFEwnZviF3CE078AwiAF2d4jtU=;
        b=ArRoMZ6SFLJWh/xewcZdhf9GT+5NIB1rdJsQwQfWvLQcYz9mewnWqXw9Mi0lV28CYU
         kSG2hSY5ylWLzC65nVSe4oQwTAnwZ4hsflwtUGvPieWuffZEjfxP80hU979gGjyTR8rB
         WtTMdfUjiupKmf/0fwLjt0VteWi93lgH5T4pASBp+qqzb5r8K1GhG46PObZ93dx1uEHv
         4xxbb6RBZvcwkLQWMEdcnXBQKLPf4jI3bJ5lOubgXB7r88wcmy3p02FFnBPJ8HYk9QWt
         A1doEl7Hs9NFRc1VGm0/lpo8s7iHZoqUOTZ0yEfEb2Ob8bTSXIKZG2zMD5Vt49GjLIfn
         KOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739056905; x=1739661705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFu+sehOCC7lltohHvFEwnZviF3CE078AwiAF2d4jtU=;
        b=YL/xufOXohuVHezj4V28FXUDTUnq8h33pG4Fm9sWK3CLmd9cWGDVb+QzfzyFj6fQ+I
         APxSoZt8k9OIVV1FkpKKhy/kb5SRTOMHPG+5DHgZ4YCNkNsMGNZsk4Ht/G9xB3SQ99bH
         5/xFQPQJAqaClEFHHB6/KBlY8DO9IWSKRaraTBu9fB4nVj1HvfFFHMBM779Kf6Bgc/0T
         UqLqNZQ9LtFYMkS7dpHJ0W93HacYASMpfxG3zl/V0iaWgFTXxmALhRTur8hP85ZjvFSK
         LLAPTtCM4Fz0o9XVwZjg8i0Vjlq/fr0NZz1pU5u+q+UvS7gwHdQPgnm58D0uCgbwuqsM
         o9wA==
X-Forwarded-Encrypted: i=1; AJvYcCX/KujSVNbm+8f6wJhIKxyOoqZ3n0mex3SLaihaQFLsaHe7+hKw+dRRxdtbQnEQ57jJWwKwxhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLATkEyGHAJI+X7GKH1H0MiGB9m4QPtDgv6b97dLKFaPn8fo3L
	A0fij+WgJ0eN2RF5YKtPaMYgzzorvuIGYj7HNK3GJXziILcTzrLY
X-Gm-Gg: ASbGnctH9KJGJAgAk59hiEf0dHD3yVRHOINlfHytC9/DXA/iZQFZMjEY88KzKf0kZCy
	ukMQxDsEjetsVTvUq3+xTfz157I3tK0J1oiyXoHAZgM60DCjX1bcqZNSf9cgOUBGfMfTnoAkij5
	JvEj53GL7bIHTOCKQpzZ8yhbjvV2Nb7q9zm6fYnkuLX6Gstaj5wJ8Earmd9TQgLDvhKu53XGItJ
	J9qdypgNd686GePdVCr4qxNJtT7Y0XSXbIK7XXy2WNH1s45ELmXYGsAPl9v0Vz2nMYJGN/GR1+V
	iOoiXFP6+1FD79aPfwwDk4MqWt8EXoa1Sn/DMpvwahjkzrHLCKNVW9KiX7B0GnfPLh1kNYCJsJS
	BRa02lw7ZNXPRi8ONufsRZTw2uw4t9u+dYreCDlrf7j/nx9OYiP5VPUBcRTk+2G0hetwYktycUf
	AML/MSKrA=
X-Google-Smtp-Source: AGHT+IGSAnwGOdO8mTXYMdC+0K39VbAFylugepThSeG0nJCreoUncRxlCxlBLGSSJDh9eBua7k83nA==
X-Received: by 2002:a17:906:3918:b0:ab7:a752:6181 with SMTP id a640c23a62f3a-ab7a7526492mr261071766b.55.1739056904943;
        Sat, 08 Feb 2025 15:21:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:b375:7f00:211e:90a3:e1ba:6cbb? (dynamic-2a02-3100-b375-7f00-211e-90a3-e1ba-6cbb.310.pool.telefonica.de. [2a02:3100:b375:7f00:211e:90a3:e1ba:6cbb])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab78ee9e208sm379554766b.50.2025.02.08.15.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 15:21:43 -0800 (PST)
Message-ID: <47a451a8-e253-460f-8e58-dfd2265a4941@gmail.com>
Date: Sun, 9 Feb 2025 00:22:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
 <e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
 <20250114150043.222e1eb5@kernel.org>
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
In-Reply-To: <20250114150043.222e1eb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.01.2025 00:00, Jakub Kicinski wrote:
> On Sun, 12 Jan 2025 14:28:22 +0100 Heiner Kallweit wrote:
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index f711bfd75..8ee047747 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -270,6 +270,7 @@ struct ethtool_keee {
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
>> +	struct netlink_ext_ack *extack;
>>  	u32	tx_lpi_timer;
>>  	bool	tx_lpi_enabled;
>>  	bool	eee_active;
> 
> :S I don't think we have a precedent for passing extack inside 
> the paramter struct. I see 25 .set_eee callbacks, not crazy many.
> Could you plumb this thru as a separate argument, please?

Thought about alternatives:
struct ethtool_netdev_state may be a good candidate for passing
extack to ethtool ops. Code below does this for all "set" ops,
as a starting point. This approach may even allow us to remove
the extack argument from a number of existing ethtool ops,
incl. static functions used within these ops.
Would this approach be acceptable?

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 870994cc3..28acb9224 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1171,12 +1171,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:           XArray of custom RSS contexts
  * @rss_lock:          Protects entries in @rss_ctx.  May be taken from
  *                     within RTNL.
+ * @extack:            For passing netlink error messages
  * @wol_enabled:       Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
        struct xarray           rss_ctx;
        struct mutex            rss_lock;
+       struct netlink_ext_ack  *extack;
        unsigned                wol_enabled:1;
        unsigned                module_fw_flash_in_progress:1;
 };
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b4c45207f..0cc22c482 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -704,7 +704,10 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
        if (ret < 0)
                goto out_free_cfg;

+       dev->ethtool->extack = info->extack;
        ret = ops->set(&req_info, info);
+       dev->ethtool->extack = NULL;
+
        if (ret < 0)
                goto out_ops;


