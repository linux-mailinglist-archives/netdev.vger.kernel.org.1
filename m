Return-Path: <netdev+bounces-182497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC73A88DD3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2073B3B9E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615C1CCEC8;
	Mon, 14 Apr 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hikp9ZJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5419995D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666415; cv=none; b=SWafCjHP19JIsvdEks1207Dn2g9nNqYamxGkD0+m5gvuJFlOA4aoeHc+vRuK2nVFDLHgUIiQYl5uRMSc4aFaKwTvmZPt1LBd0Kdt5TZAiXsR5Rr3cfJEwpdjlNBqf+rLHwuLAqDNO87o3chyi+0sqt70AcaluCp5Dbfj/OSPwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666415; c=relaxed/simple;
	bh=sPrJpBEyZXVTEk+LVLFLXo0MtquKsXP3NkMAg0bkd9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGRNWyKA9HdeiVyImTe6FXGwgLi6dccNVt1OEghvparseRMiGpusQ2I7ojyCfCRkv6fieQVDJrwoZgLWxxHtP5SR5TwXCzX3mVtan9KYPvT1kZNwuyQlAp2ZseYtwOq/GfgncvTgMmNRkKJgSwA4DOsj9GljcG1Ajk8bcDwCxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hikp9ZJL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913b539aabso2894102f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744666412; x=1745271212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gsv7Vj6x1hszdqAaptXmFjZ3eGC452SY1cG8kKbwzqA=;
        b=Hikp9ZJLmfF9xfO7Q4zn7CwEUhFAMHteUrCdpxrZ/uB2dR639x/950tWmo4oPc4OHi
         VmOd4kIu1fwsL/u6F6p+hbWDfkkhVErh9AeW3BZModwE3+lCw3GoDDnqH5rwpt8dLsBC
         Fr9j/2dbXuUGP4qkZkt4qfnzFuc2+NTJqKKm79amzfO/d4+CHTNnL9I7eXsj6WSsxwTh
         PXxhs5sEb5WktKyOPCDB7JdRikCy269O8xk+cvNqYy4DZ7lwGPYwKrSnoTG3VK5k7lCE
         Pw9Ihzis9mQqshGftYw2fvVe4sNgQJpRVybdh1Nf1lsBi0BpvlxLZC4j6bTzFFXVnwal
         FNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744666412; x=1745271212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsv7Vj6x1hszdqAaptXmFjZ3eGC452SY1cG8kKbwzqA=;
        b=cJoMtk2tmt+490ZYzNJ6lBTpXfXzfVpfjtLVtPyGNuVaRTIEJwMZ57xQrLFnUFw3Zp
         6ztlgAQbSQNI4FsIH32V7TytFOFVQg01E6Lzf2XTySGvkGmj8jhBesFugoT7LI/LkJxp
         Drkdjqx2rx+QfMY4lDbOH+MEzutSRrQiPyptV/NRFb+giNnVZmiTjIcTnVlQ1mO5ctfG
         +UZ+0sMwIRfy0KrMtovgRHspHbrKdGFDICMUPUh4egO0ngC12k9SXubQohFBDikaBNdj
         23FnJ9pk1w56G1RNG+wC321Qny1kpzOpOi30keulBaIWTubC9Ryy0fZbImhDO9SjwX07
         ceBA==
X-Forwarded-Encrypted: i=1; AJvYcCXTRIkiQVXflKIBGnYCQOIAy+inn4ZjT3QlenG5dr0Y2cweU0u9xr5CZ4sBBRCWTCb5ju9KH6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE3ORfwsWK9vyOHHTz2I4YO1QyiBer3lXJkGpd9t5U3bRMwzC
	7VZijScFAwh5B8Voz4EUxBLgYPHODDH57Cgk7H3qgHtO+SF+PHxU
X-Gm-Gg: ASbGncuNhjBwlj0mx0RRf0+AB9sQjTT5Qr2fYaNI6cpqk8Zjqj9hB9YoYH35nbGHvcS
	rvf6zJlqkebUEYprpQhuM8DyfcqitZ2mdSSPka0L1K2A94uTZdWt66jNWcCoF/I35JWCMnmLaCh
	8t/Svr+CIzAYeyAR0tZco2p8v7+h0JWfXVYqvdzu0e5tbdPxCScKNqrFd05Fi37hcc7WvXI/O9Q
	j0guCkj8BMATpBgy1VSPbkAlMepakIMPiE+rQsL3SLWiwYzjUK+GEDZfBM5TnAHAF0jHSibpVjM
	uNYix6vt8csB/w0fH8SMyVCklCA1pu3bx/oVuagmhi8F
X-Google-Smtp-Source: AGHT+IF9PZ1+AciwteorV5KNKkphW30Nb75VSmGtj4uPBtknJQ9VWyba3hDGvXABHogN+jUzRQS5fg==
X-Received: by 2002:a05:6000:2282:b0:391:1806:e23f with SMTP id ffacd0b85a97d-39ea51f5c52mr11235058f8f.17.1744666411977;
        Mon, 14 Apr 2025 14:33:31 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb29sm12080988f8f.76.2025.04.14.14.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 14:33:31 -0700 (PDT)
Message-ID: <0e061258-b7d1-47ca-b0d2-5e8a815136af@gmail.com>
Date: Tue, 15 Apr 2025 00:34:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] net: wwan: core: split port unregister and stop
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-4-ryazanov.s.a@gmail.com>
 <CAFEp6-2MxMohojOeSPzcuP_Fs0fps1EBGHKGcoHSUt+9fMLqJQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-2MxMohojOeSPzcuP_Fs0fps1EBGHKGcoHSUt+9fMLqJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.04.2025 21:54, Loic Poulain wrote:
> On Wed, Apr 9, 2025 at 1:31 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>
>> Upcoming GNSS (NMEA) port type support requires exporting it via the
>> GNSS subsystem. On another hand, we still need to do basic WWAN core
>> work: call the port stop operation, purge queues, release the parent
>> WWAN device, etc. To reuse as much code as possible, split the port
>> unregistering function into the deregistration of a regular WWAN port
>> device, and the common port tearing down code.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>   drivers/net/wwan/wwan_core.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
>> index 045246d7cd50..439a57bc2b9c 100644
>> --- a/drivers/net/wwan/wwan_core.c
>> +++ b/drivers/net/wwan/wwan_core.c
>> @@ -486,6 +486,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
>>          return 0;
>>   }
>>
>> +/* Unregister regular WWAN port (e.g. AT, MBIM, etc) */
>> +static void wwan_port_unregister_wwan(struct wwan_port *port)
> 
> Wouldn't it be simpler to name it  `wwan_port_unregister` ?

I came with this complex name for a symmetry purpose. The next patch 
going to introduce wwan_port_unregister_gnss() handler.

The prefix indicates the module and the suffix indicates the type of the 
unregistering port.

>> +{
>> +       struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>> +
>> +       dev_set_drvdata(&port->dev, NULL);
>> +
>> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
>> +
>> +       device_unregister(&port->dev);
>> +}
>> +
>>   struct wwan_port *wwan_create_port(struct device *parent,
>>                                     enum wwan_port_type type,
>>                                     const struct wwan_port_ops *ops,
>> @@ -542,18 +554,17 @@ void wwan_remove_port(struct wwan_port *port)
>>          struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>>
>>          mutex_lock(&port->ops_lock);
>> -       if (port->start_count)
>> +       if (port->start_count) {
>>                  port->ops->stop(port);
>> +               port->start_count = 0;
>> +       }
>>          port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
>>          mutex_unlock(&port->ops_lock);
>>
>>          wake_up_interruptible(&port->waitqueue);
>> -
>>          skb_queue_purge(&port->rxq);
>> -       dev_set_drvdata(&port->dev, NULL);
>>
>> -       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
>> -       device_unregister(&port->dev);
>> +       wwan_port_unregister_wwan(port);
>>
>>          /* Release related wwan device */
>>          wwan_remove_dev(wwandev);
>> --
>> 2.45.3
>>


