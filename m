Return-Path: <netdev+bounces-184293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B47A944BD
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5857B189BA3B
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC851DE8A8;
	Sat, 19 Apr 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRhLenMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F01465B4
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745081438; cv=none; b=sK1J9qe6LZWWwBeKV3F18RC7S3d6BCpDmLAM8D90ku9MSqoMFYAvdgw1GTc2y/nAAz58BqOQbQ3YLM6aIuJMFE4y1DDfSClmTJcKyOR6CNKfhylI5VfmCyrZ8Ez20mhNfOXtr5PoYVkS05XG6U5qZ5pAjESDwmyFA0nNSRpKEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745081438; c=relaxed/simple;
	bh=hgt5u4hJcnOlBKT3vj9LQnWtll2HmR1D47irc31CwZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uB0kg+Y0JrKJNm28c9PJe2sN0jYDwc7U2hYOvuLcEykwFNDC3VIUjIlRd3AAUMvqVjt+irU/GA45c0xK17XvSnKbGYkBgCp/fzVFU6TwW4odzEHXIoxXvf7yW5A9Rsg3NrgQQYrLiiN51VdxolQxjPbac6SK3l4g8NoIWarUQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRhLenMQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so4203111a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745081435; x=1745686235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFmG4Yjcuj/yEtol3FRL9FCcE/zLthByUxW5LXM7RRM=;
        b=dRhLenMQgxBiTUt7DdShPH7gjyceHP0l3RaUil9fM9Ch10uHQdOvbAreY85ZTz7ykJ
         iLItJuw8K4+FaGTihGVClhjOLh9JLbngvsx8d7FPrg0xctnp1iGwPMiJXzMyP9k7jrcy
         GMHMoaFpVG5DdlvQYYBc5MZmQpBz5CAFuySWWHi24EumHiuBUoDd6KaMnh1fT5ebTnvm
         FijaFgrt1+Ha1uVi5Zplbozi6LUxQfgE86MBgsrIrYuJNjb6EnSAbblO/5YjcN+lGykA
         U8uOIb+/WEK1V2JbbXOT8imaX903/gff03fesrSv7tlKgdpEyMMQKgbgqI5V9qrgmR9w
         yoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745081435; x=1745686235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFmG4Yjcuj/yEtol3FRL9FCcE/zLthByUxW5LXM7RRM=;
        b=G+KD3sV/vvjTUhz06+GHlx3lu5AspVpDwY4oODY5tU6hoQ1vT304VDKranpsD1IPRK
         jzKemzYrKCJ7OchLo1GP9vHWKwDtvU7a6/L8os60PvWIEXXgfROo6Da1hxQMqySb63+2
         SuZk7x6P49Navmi9j43nO+Y9sYYdMbcWuslnrN4NnAHrSk9injjxVlAImUUAW3g3TkXE
         xj1tjFb5NussH7WjH2xUsRQHroc6LmjtAvpEzp/tAW5kE6uPIXiP4rsK7gzYnpgYT5VG
         tLL4+CDsckPSklrwNkz65BRQPV1CN3P1adNQPI7PYXLbHh7oRNYg6c/+DVxmku6A7oY4
         tntQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWmYjOfKgqt2meZmVwBH5wuiZpmZdMIE2gPNaq9X0kWydvHjjO5p4alh4o1DYwOCsc7QNZWPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxae5Qq1QPcTBt4IeACke3JW7u9My4sxFxINF8obLo2ilqQbI7U
	RwzVlw3A+6fDINx8hNaz0bTZrjfqTwrwwRrP144aabq1eCEtEfFi
X-Gm-Gg: ASbGncsFmUv+IhYnQzSLioAsQpUCg7GT5grafM5NaT/+gBShjAkZJ0d9ZYKBSEEv7u/
	gvcziN7BedhU63VW+OoDDuI2QJP2KWZSl5q1mYNyn3Q7l0TvU2926g1cOwXvhCIQiM3MAnTW9pO
	LJjDVAA5+e4khHGGyAMzUjLdaJinQGz9LVucVFp7u3DQZEQd6VwdMudDowgTGGPB13TkB6U+98s
	vbR0Sk/Y6rgQTpFdSmObtXcGrkiIfMSsYfTqW5MQlxsFVCOr75j3dHabbdQeYtV8CtYYidhumwX
	uf+ymH3ycJmtuo/r+P3cbf/D/sDkLr2UogVsRcXd2SM4
X-Google-Smtp-Source: AGHT+IFmELEuuh29u+I2Sur6DELySCuHEU2N8DSY6YSTnbDaJkF5+2g+YD04/MnLLEINUHqsm1pajQ==
X-Received: by 2002:a17:907:9414:b0:ac2:cdcb:6a85 with SMTP id a640c23a62f3a-acb74b2d3f5mr515717566b.22.1745081434584;
        Sat, 19 Apr 2025 09:50:34 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcfb8sm286333066b.111.2025.04.19.09.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 09:50:34 -0700 (PDT)
Message-ID: <01c17d6f-dfb4-4464-b33e-6e3ed64ecaae@gmail.com>
Date: Sat, 19 Apr 2025 19:51:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] net: wwan: core: split port creation and
 registration
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-3-ryazanov.s.a@gmail.com>
 <CAFEp6-0kBH2HMVAWK_CAoo-Hd3FU8k-54L1tzvBnqs=eS39Gkg@mail.gmail.com>
 <a43d7bce-5f70-4d69-8bad-c65976245996@gmail.com>
 <CAFEp6-1veH3N+eVw2Bc+=2ZhrQAzTcU8Lw9fHTmY2334gaDBSg@mail.gmail.com>
 <9b36d9b6-c2da-43ef-a958-167c663792e4@gmail.com>
 <CAFEp6-2n13+Q5sjatgjjgG0vFP28PSiH8PoOJBNB-u9HX04ObQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-2n13+Q5sjatgjjgG0vFP28PSiH8PoOJBNB-u9HX04ObQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.04.2025 14:44, Loic Poulain wrote:
> On Sat, Apr 19, 2025 at 1:04 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> ...
>> Looks like I've found another one solution to move the port resources
>> (memory) release back to the function allocating it. It is also a bit
>> hackish and I would like to hear a feedback from you.
>>
>> The port is released inside wwan_port_register_wwan() just because we
>> release it differently depending on the initialization stage, right?
>>
>> We cannot call put_device() before the device_register() call. And that
>> is why I've created that __wwan_port_destroy() routine. What if we make
>> port eligible to be released with put_device() ASAP? Internally,
>> device_register() just sequentially calls device_initialize() and then
>> device_add(). Indeed, device_initialize() makes a device struct eligible
>> to be released with put_device().
>>
>> We can avoid using device_register() and instead of it, do the
>> registration step by step. Just after the port memory allocation and
>> very basic initialization, we can call device_initialize(). And then
>> call device_add() when it is time to register the port with the kernel.
>> And if something going to go wrong, we can return just an error from
>> wwan_port_register_wwan() and release the port with put_device() in
>> wwan_create_port() where it was allocated. Something like this:
>>
>> static int wwan_port_register_wwan(struct wwan_port *port)
>> {
>>       ...
>>       if (something_wrong)
>>           return -E<ERROR_TYPE>;
>>       ...
>>       return 0;
>> }
>>
>> struct wwan_port *wwan_create_port(struct device *parent,
>>                                      enum wwan_port_type type,
>>                                      const struct wwan_port_ops *ops,
>>                                      struct wwan_port_caps *caps,
>>                                      void *drvdata)
>> {
>>       ...
>>       port = kzalloc(sizeof(*port), GFP_KERNEL);
>>       /* Do basic port init here */
>>       port->dev.type = &wwan_port_dev_type;
>>       device_initialize(&port->dev);  /* allows put_device() usage */
>>
>>       if (port->type == WWAN_PORT_NMEA)
>>           err = wwan_port_register_gnss(port);
>>       else
>>           err = wwan_port_register_wwan(port);
>>
>>       if (err) {
>>           put_device(&port->dev);
>>           goto error_wwandev_remove;
>>       }
>>
>>       return port;
>>       ...
>> }
>>
>> The only drawback I see here is that we have to use put_device() to
>> release the port memory even in case of GNSS port. We don't actually
>> register the port as device, but I believe, this can be explained with a
>> proper comment.
> 
> Yes, that's a good alternative, so you would also have to use
> put_device in gnss_unregister, or do something like:
> 
> void wwan_remove_port(struct wwan_port *port)
> {
> [...]
>      if (port->type == WWAN_PORT_NMEA)
>                  wwan_port_unregister_gnss(port);
>      /* common unregistering (put_device), not necessarily in a
> separate function */
>     wwan_port_unregister(port);
> [...]
> }
> 
> And probably have a common wwan_port_destroy function:
> static void wwan_port_destroy(struct device *dev)
> {
>      if (port->type != WWAN_PORT_NMEA)
>          ida_free(&minors, MINOR(dev->devt));
>      [...]
>      kfree(port);
> }

Yep. This change also makes sense if we manage to release the port in a 
unified way. Will try to implement it next week to see how it's going to 
look like in as a code.

--
Sergey

