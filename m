Return-Path: <netdev+bounces-71193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE785299A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C83E282197
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD3168AC;
	Tue, 13 Feb 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAwyWNYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080B1754F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808780; cv=none; b=QeE5e/MIfed00c+I7HCP5dSFnd8cOZ+P3CpwRzxd+KsiHlpo6i9jW4dtn74xu+oGnruXzu5UJ6u1FOJmmiBWq4gap5/KTp5bezaAp7Dopogg1HxlYLAKZv8/+ASgHg4syhd7bBjheoJjKu8GrORDhjxvLkUhHfRfXbUrrE7odH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808780; c=relaxed/simple;
	bh=Mshiao1xfdY8IRC3Fg4WvwPUoeojH6JslwfmrzxbjbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM1FRLIpudXqc8GFBItMhjSfQdfmzeIEFJuhRV2Qf0+RMgvCeUZYfZAUtdvZeZUmmZeFS4Vj6KQPetf/szim/A95mx1OOtcQOePzS8O8dF2Q/PZCwSjug7pjH0V4/UM3UcxILmkHIn8udI+jSTt/fqwHCblm1E6ZYC/oluvwtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAwyWNYO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso47931111fa.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707808776; x=1708413576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FrYUGQ2aYYAti1JNRWqHAl4rgmR/xHTdSMKcXtjZ4PU=;
        b=WAwyWNYOV0aXS4ibat+fTBnp3bYM6nWNj8FtJ3/OYID4gw7FLLoX5G0pOjsGQO1u30
         tppT9HOImeVJfoPC/PCsBV4O+L83k+fhZVBGp2vBHhHiyIT72q/lkHE6p/HwbuJ14REn
         iFC7UKsztUg3yDdILuvF/F3E5o71KVjvYWcihkNB3YQJ86/0fzz0ZCVRbePGHAnIoKmR
         sWXJoVJCMW+JdmolAWHYxioFM7sELJQ9dNT2AAr1DoK9oYfAGPU5VjboCuiJE9PJhsSQ
         uUfk/klJYyiEOqvC9ryWWlEUzftFD2hZ8hXBF7BLtzGeeSUIGH7eXm6SuN3kEO6D/rTI
         SYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808776; x=1708413576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrYUGQ2aYYAti1JNRWqHAl4rgmR/xHTdSMKcXtjZ4PU=;
        b=nUNF5dITJSSQj8SMFSAn2O7RZknEcVJhy/Q2CXDNcOCyAEB6doH88tKlG8xa28wWtC
         F4vjuLWybgeF5wxz5L9jQSwrqPCsiGBCh7ogvUpFkbh2doNOgDDYx42G6XFXHc7qmZjj
         7fsxmTZv/BvNrm+jqqrAwpQQVEMlLg6Hu6XFLNpbRXC8NoZC06JLSL7jnxpQsvtFvCuI
         h7bdoowDaUAkKFeZz8xbrQaIQ8m7FcKCu4mSfGTEpQ3aqGlP0IUdg7C/F2sv5XiTXSl2
         bdD/jGCib762RdzyOehgcMAzHhECF0qz/ZpNzUhekm0id8ar1CRTR8+gvVWOaR8yrzyZ
         TFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4sPthAhLNvMr7ODhvvkb94/Wc6jqojXm5JOaKbI9sLzDbki7QCPC+/mMTK5RX6nWYI7Ly0gOEyG/CkehA8Kjc+JS11LCu
X-Gm-Message-State: AOJu0YyL8chzBIi/+5XQtCtiBIHKboQkzhAOjJGdecHK4Euoh0taG69A
	STS41kYZlJgPGk8/wGaAa5zoGH5IUp5WemZC3e+pl44gvjsh75N6
X-Google-Smtp-Source: AGHT+IGCX21auHg1uPjpwSfe6TXaE4BpbLQqIKp0qmBIzX1VQRRT+1+ktrOctFgfrfkP7ylNJLgRgg==
X-Received: by 2002:a2e:8509:0:b0:2d0:b663:f052 with SMTP id j9-20020a2e8509000000b002d0b663f052mr5759797lji.6.1707808776080;
        Mon, 12 Feb 2024 23:19:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPKj7ySk6dN3/vwDfccPj8SUda8nu6VBGc4Udg3kBrCDBGDSMhq6TRYoF6nT9LQXToeFGpI21W2FZA3CkJTO+vXLUw4HTusc+k9TCo3mGD8DZE9kjSHK1Qqh6ufeuTIM4g9AtSE5JptD+JAStMyHeJSDtqLTVmSxZZc0oJF/SSzuAAnNsD+++yLMf4Ltq6nENGG2xi
Received: from ?IPV6:2a01:c23:bdaf:b200:457b:b235:98c6:f76b? (dynamic-2a01-0c23-bdaf-b200-457b-b235-98c6-f76b.c23.pool.telefonica.de. [2a01:c23:bdaf:b200:457b:b235:98c6:f76b])
        by smtp.googlemail.com with ESMTPSA id m7-20020a50ef07000000b00561419b4aa0sm3435780eds.94.2024.02.12.23.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:19:35 -0800 (PST)
Message-ID: <042741a7-9fce-404c-ae33-3a5abf22a186@gmail.com>
Date: Tue, 13 Feb 2024 08:19:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add LED support for RTL8125/RTL8126
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
 <26417c01-7da1-4c44-be31-9565b457f7ae@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <26417c01-7da1-4c44-be31-9565b457f7ae@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2024 04:11, Andrew Lunn wrote:
>> +static int rtl8125_get_led_reg(int index)
>> +{
>> +	static const int led_regs[] = { LEDSEL0, LEDSEL1, LEDSEL2, LEDSEL3 };
>> +
>> +	return led_regs[index];
>> +}
>> +
>> +int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode)
>> +{
>> +	int reg = rtl8125_get_led_reg(index);
>> +	struct device *dev = tp_to_dev(tp);
>> +	int ret;
>> +	u16 val;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mutex_lock(&tp->led_lock);
>> +	val = RTL_R16(tp, reg) & ~LEDSEL_MASK_8125;
>> +	RTL_W16(tp, reg, val | mode);
>> +	mutex_unlock(&tp->led_lock);
> 
> I'm wondering if this mutex is actually needed. Each LED has its own
> register. So you don't need to worry about setting two different LEDs
> in parallel. Its just a question of, can the LED core act on one LED
> in parallel? I don't know the answer to this, but it does use delayed
> work for some things, and that should not run in parallel.
> 
This is applicable for non-atomic set_brightness ops.
For sysfs changes of the hw-controlled mode, the call chain is:
netdev_led_attr_store()
  set_baseline_state()
    rtl8125_led_hw_control_set()
      rtl8125_set_led_mode()
        mutex_lock()

So I think we need an own serialization.

> Maybe you can look into this and see if its really needed. Otherwise,
> lets keep it, it does no real harm.
> 
>      Andrew

Heiner

