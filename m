Return-Path: <netdev+bounces-272861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKjUFDuzyGm1pAUAu9opvQ
	(envelope-from <netdev+bounces-272861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E94350C9E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F76130154B9
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CD25A2B5;
	Sun, 29 Mar 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwMiyP25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C31FDE31
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774760758; cv=none; b=SWWMie86g8OO4xKgzS812Nv+oCewcbfnu+F4DsJ60MmDgzQaLczoDCeakH1WsB+ZZRnHYOqPmyDxfCAT6K7ML9btx0MMO8Li49tGaHGkDWDmmbaTgrBPCydAUq3k5L2WLOSsp4K+PRsoQhuPikBULNcNa2+hjBaH2wK3h7NP0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774760758; c=relaxed/simple;
	bh=Kk3dWar8Quu1OSZMiLbSq19BiVddLPomPfiOafDZE7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4ZxtVCfzapdBXdGPHOH6VxCBXW5b73llqVbgjBeU17BiHtoJ8P1efnXGMll5hgEI6vP/ABQk43AtfEWVx5hWgGVB/6bDtna4Taa05IM8FeD3BoLyuXMKxWm9RwoHM2E+AJ62zIfFB21hs7Q9PPUcyUUpfNcsQuFucE7KncgE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwMiyP25; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2494440f3so1578295ad.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774760757; x=1775365557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zntGvzqjvnyYriEFd2VuM836jbP6Fi+HoD3l/aq/GrI=;
        b=WwMiyP25qHhMPuXRl4nm5TXJ23n/5TW97V40Om4aD8/I7k96NViD2mX4lNxRsGCGA2
         GLxNWHJ8ZY0PD0kOWRO0iz8icxePAXx628iV7tChAyAUG+fc8Z6yeAu8GVTO/v8qRX8Y
         7RCB0+Eva5EIn/lQ0vMzmIkvZB64jNrfm69MA62Hm/Fzv1IaC4/TlH8M9u3to5aIfTfQ
         Ch2aGG1IXKGWYiT8CpZD+pdVk3hrTMLtL7u0aZaMQmW18tnUjy38szDVqlrDApZYqACu
         Keub0jzx/oRsTDrCEswvVy+ebp8/b6eb6VCYsMwtbrwkraBooyWL9Iu3vmOoXOKJPVbj
         tbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774760757; x=1775365557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zntGvzqjvnyYriEFd2VuM836jbP6Fi+HoD3l/aq/GrI=;
        b=AOlLM3PRwD/lSHQaoeLxfBpmC2j07uT5ccPQtvmK8DT4kdy4+mlgZi3TUxwSwjq4mt
         Uqp24Bhg8ipIq8OsN8W1Lqj0Z5ajYLEbrYH/ysO9oztS8nunN5gbSSekcIO/p2OBYAAq
         oap0bx1grIc97KfS2J3MsgE7kzAGDI2HuMSH7jVhOnrebyxjdoa0h8RR3CuoEPrzz1Zb
         8NftBDLmgD7aetmSOPgzwXEjrcy8xjZU4E844wdqpjAV4PorjbyJKam/xusK0iLcsLNs
         hNm37JPjRRvSiaWRIUQS/1ukjAmqjjmcIYm/23ZCCB4IFMwFJh1nYl+pPYSpwt8o4/41
         v54A==
X-Forwarded-Encrypted: i=1; AJvYcCWKYbFNClUKR3zMIWmFOwxpbqk7/nHMru+A17QU+IKg/9VNvBfcJezn1tNAg79UPCRkaA5FxBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVou5tcGSpq35U3i26m9dFYdXg6afG2oE5ApCRDlKESRE+a3c
	Ws3Wu9ou8cNJRrTHhjOlVfrMxiXrLoJQdHNKSSEh5EVb2g2hJajF551J
X-Gm-Gg: ATEYQzzodvoQbZ99SRg/L+4eY+hmBDvBtzL/h1y37rC84L2UnZxzniKB3le+QAHyZLB
	6XDhPI5HaE2lPNLm5bG8xy2sac3EhObtUun87eBkBlBC7Dp7rQfz2nHbWbFfPmFKhLy88AQT72r
	D4nA/VHXM2FRRXqBhGeKvKLu4rXraRfj+rCUueVzMGHYXXdpsSAhBxL8dyVi8f8JFcrTlLoYReI
	i2C/gbtfb07MSu7ZQC09HvBmRDEuT9HAeHxLMkdvyABtNGRsqk+OUVESTVqoPBw3HYBpxTIQRAf
	dB0jG4KK4lH65hbtzK029eUEhJ0bbpzQdkkk7OUDpq8ZBoXK0QWFz5WjVuYzfAw+Ylcaf6vzuuE
	Cb4EY+YRfglLmzV/Di0/slZOi/5FN4YNSkkFRoNP3iQPC0J9pUsQdgPgrf+sq5GgAbHjmu+41OV
	BNORR53qdO6Kz2wABc8ytMoceMIW/sQwTIGNvwzpSichsMqJyDmKfnnEbVN6Mte5CMDyzBQujgP
	KqB3BqUSn8R1s/QdGLEvQ==
X-Received: by 2002:a17:902:fc4b:b0:2b0:af2f:b26e with SMTP id d9443c01a7336-2b0cdcc87c7mr81635595ad.28.1774760756699;
        Sat, 28 Mar 2026 22:05:56 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642864sm44640015ad.12.2026.03.28.22.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 22:05:56 -0700 (PDT)
Message-ID: <bb19a71d-3279-4093-a876-c044607a77f8@gmail.com>
Date: Sun, 29 Mar 2026 13:05:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Eric Woudstra <ericwouds@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
 <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272861-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1E94350C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Eric Woudstra 於 2026/3/28 下午 06:21 寫道:
>
> On 3/27/26 5:41 AM, Eric Woudstra wrote:
>> static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
>> 				u32 pbus_data)
>> {
>> 	int ret;
>>
>> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
>> 			      (u16)(pbus_address >> 6));
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
>> 			      (u16)pbus_data);
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
>> 			      (u16)(pbus_data >> 16));
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	return 0;
>> }
>>
>> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
>> 			      u32 pbus_data)
>> {
>> 	int ret;
>>
>> 	mutex_lock(&mdio->bus->mdio_lock);
>>
>> 	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
>> 	if (ret < 0)
>> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
>> 			pbus_address, ret);
>>
>> 	mutex_unlock(&mdio->bus->mdio_lock);
>>
>> 	return ret;
>> }
>>
>> static int __air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
>> 			       u32 *pbus_data)
>> {
>> 	int ret, pbus_data_low;
>>
>> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
>> 			      (u16)(pbus_address >> 6));
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	ret = __mdiobus_read(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf);
>> 	if (ret < 0)
>> 		return ret;
>> 	pbus_data_low = ret;
>>
>> 	ret = __mdiobus_read(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH);
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	*pbus_data = (ret << 16) + pbus_data_low;
>>
>> 	return 0;
>> }
>>
>> static int air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
>> 			     u32 *pbus_data)
>> {
>> 	int ret;
>>
>> 	mutex_lock(&mdio->bus->mdio_lock);
>>
>> 	ret = __air_pbus_reg_read(mdio, pbus_address, pbus_data);
>> 	if (ret < 0)
>> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
>> 			pbus_address, ret);
>>
>> 	mutex_unlock(&mdio->bus->mdio_lock);
>>
>> 	return ret;
>> }
>>
>> With:
>>
>> #define AIR_PBUS_DATA_HIGH		0x10
> Small correction using upper_16_bits() and lower_16_bits():
>
> static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 				u32 pbus_data)
> {
> 	int ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
> 			      (u16)(pbus_address >> 6));
> 	if (ret < 0)
> 		return ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
> 			      lower_16_bits(pbus_data));
> 	if (ret < 0)
> 		return ret;
>
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
> 			      upper_16_bits(pbus_data));
> 	if (ret < 0)
> 		return ret;
>
> 	return 0;
> }
>
> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 			      u32 pbus_data)
> {
> 	int ret;
>
> 	mutex_lock(&mdio->bus->mdio_lock);
>
> 	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
> 	if (ret < 0)
> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
> 			pbus_address, ret);
>
> 	mutex_unlock(&mdio->bus->mdio_lock);
>
> 	return ret;
> }

Thank you for your feedback.

I will include this in the next version.


