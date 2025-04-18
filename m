Return-Path: <netdev+bounces-184266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90663A94027
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78978A825A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEECC247298;
	Fri, 18 Apr 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAk0xF2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6122155E
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017471; cv=none; b=kyDNwC9nAXhiXuH5V3xVHuIvqimV5ZHg22fGa0TdKMVoXhGfbUHTc9yEpXFnmEa4hIzH1uVkuHkLsNjv5jJNPleAoY4191KA5HWoraSEBn3wvVld1aUgQaeNpHolA/1r13YJlut01YzqpOFuGpWJXftSL9KZkkPbbBERUTROsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017471; c=relaxed/simple;
	bh=YF+NiB37CJjwjeox5R+QcbB5P05xsUzQQ+viPf768OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgEh0394orv3CTOOKy8YsVmzqDSqVestN8Egf2pnH0Vo5EByhtUGGI0cXJiM+nVXjXzfnCYXE85w9Si8eCe3wO7Li2Q9KWjgoJQpfZ9hXG+g4ykIKAzL8Kiznc6bmfxLAlnttr73agACeuNFe1aagGGcPjM8XX/w3iw/jkEA/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAk0xF2s; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39149bccb69so2281088f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745017468; x=1745622268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jQmrlaeutUHPAq9KnExXt3EyybkP591650vdlvgFuM=;
        b=JAk0xF2sGTdoLxEXQ72GiKcExEjKq3LZlmooZsa4WMbE9pnkNVaJZ98JvSrTDYMyHf
         WQOs9XPYHI5xKo1iMrQp/L/LdfXHoWYD14J/6zmWY93/3x6Teej/6kUPzMZud6j2fz1T
         A/VrvEoNUKjDNi5iWvR9u0NazRK5VeVpOICoRRgZgO0JI/dTnphSJwSeIpnViUWewYFH
         t+KsE9cFPn9gVuj/wg0XSS5zBNWP/L0czUIGHmi3f41s5jAt3NDrpf2Y/g9erRaUwSFw
         4TK8PZtN4vWxS/64X8v21Pqx//YIuSSUFilNuIdr3ofVAe+vnneyvSt29yHmKu5FKxcI
         2EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017468; x=1745622268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jQmrlaeutUHPAq9KnExXt3EyybkP591650vdlvgFuM=;
        b=RKyBygai+kl3JtsOWx3U4sas8Ah5MYN9/pTJP4/TiKajyB4hiysZ4HQoYHFARIyFD0
         JfvwEscy3WkG01VQioP8pSNV4gL6/krCYNWpMEUMfiaOzw/H3plMza4eT5d3P3o+ZFsf
         Bb/QVBjrq3i5FAE1Luez5JBe16uEq3nhtvwLX02DtLo0mpv43QwQZiU1qOQYdouSZPJk
         pGjf2ZUXOgVAerCZe6dmEO+5ybWf1kRfJJIf0d30vft6gHk+OxeZD8rVOIfkylEqPlRI
         d9XS/miDR7RRIdduJthsQHA+eM2n1mrIblmr68pWYx3+3wN1zAmYBFkaDUxEKv8df0/k
         qntg==
X-Forwarded-Encrypted: i=1; AJvYcCVVchlp493en542DMuhAKr9bMmRlUwCbeYG+H1zEMkoyNNP5eTxKQX4ZrgFbUIFWbjQgJ0uXXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQC2ysNAClComhIiujELmdtE3yLqq2wzGJuUEManQyfZaSou25
	WR8vObBNEZ6CRZAvXcoAdPljsd/4ktTn8oyUbWmubN0D70ODzYvQ
X-Gm-Gg: ASbGncu/W7zj7tXcQ7DaauXjUqkVZ9/uwvh9+vkcYBFqiMWi3M1eLOnBQvwdEzscYbR
	tqVxzExNphUkXyt7VPScJ75cCgTbQxwZ3l2oC8HgPdUU3LAPtH2/xuiV9TAgPQs/PTxuJmmXivW
	EfJz2kTiCnTcruw2L+Toq27VNWZPXC79TtFzxZhl14D+9LtxSSL7hnKd2gZTK/Fd6/OV3cZos1p
	nv+Wf/lNDBV5m41da91EYRRMU8GmN5Q1fMgAXSTX7U1Sc6GpxkzyCwF1p1B467ffaX4GegBQWFi
	30NRhj4+s8hG4o1S+O2rgNkxn7kiu8R8uiKHZuyD6LSE
X-Google-Smtp-Source: AGHT+IFzXbkOUVxHSXCjaoBpaxtKTAH2HezQUjWqYwf26ZHjfZvvneJfZ4OxeqHl2eKGHozVvl2JhQ==
X-Received: by 2002:a05:6000:1acf:b0:39d:724f:a8f0 with SMTP id ffacd0b85a97d-39efbace61bmr2991842f8f.42.1745017467836;
        Fri, 18 Apr 2025 16:04:27 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207c5sm3940950f8f.6.2025.04.18.16.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 16:04:27 -0700 (PDT)
Message-ID: <9b36d9b6-c2da-43ef-a958-167c663792e4@gmail.com>
Date: Sat, 19 Apr 2025 02:04:59 +0300
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
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-1veH3N+eVw2Bc+=2ZhrQAzTcU8Lw9fHTmY2334gaDBSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

please find one extra option below.

On 17.04.2025 23:35, Loic Poulain wrote:
> Hi Sergey,
> 
> On Mon, Apr 14, 2025 at 11:28 PM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>
>> Hi Loic,
>>
>> thank you that you found a time to check it. See the explanation below,
>> might be you can suggest a better solution.
>>
>> On 14.04.2025 21:50, Loic Poulain wrote:
>>> Hi Sergey,
>>>
>>> On Wed, Apr 9, 2025 at 1:31 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>>>
>>>> Upcoming GNSS (NMEA) port type support requires exporting it via the
>>>> GNSS subsystem. On another hand, we still need to do basic WWAN core
>>>> work: find or allocate the WWAN device, make it the port parent, etc. To
>>>> reuse as much code as possible, split the port creation function into
>>>> the registration of a regular WWAN port device, and basic port struct
>>>> initialization.
>>>>
>>>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>>> ---
>>>>    drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++--------------
>>>>    1 file changed, 53 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
>>>> index ade8bbffc93e..045246d7cd50 100644
>>>> --- a/drivers/net/wwan/wwan_core.c
>>>> +++ b/drivers/net/wwan/wwan_core.c
>>>> @@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] = {
>>>>    };
>>>>    ATTRIBUTE_GROUPS(wwan_port);
>>>>
>>>> -static void wwan_port_destroy(struct device *dev)
>>>> +static void __wwan_port_destroy(struct wwan_port *port)
>>>>    {
>>>> -       struct wwan_port *port = to_wwan_port(dev);
>>>> -
>>>> -       ida_free(&minors, MINOR(port->dev.devt));
>>>>           mutex_destroy(&port->data_lock);
>>>>           mutex_destroy(&port->ops_lock);
>>>>           kfree(port);
>>>>    }
>>>>
>>>> +static void wwan_port_destroy(struct device *dev)
>>>> +{
>>>> +       ida_free(&minors, MINOR(dev->devt));
>>>> +       __wwan_port_destroy(to_wwan_port(dev));
>>>> +}
>>>> +
>>>>    static const struct device_type wwan_port_dev_type = {
>>>>           .name = "wwan_port",
>>>>           .release = wwan_port_destroy,
>>>> @@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
>>>>           return dev_set_name(&port->dev, "%s", buf);
>>>>    }
>>>>
>>>> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
>>>> + *
>>>> + * NB: in case of error function frees the port memory.
>>>> + */
>>>> +static int wwan_port_register_wwan(struct wwan_port *port)
>>>> +{
>>>> +       struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>>>> +       char namefmt[0x20];
>>>> +       int minor, err;
>>>> +
>>>> +       /* A port is exposed as character device, get a minor */
>>>> +       minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
>>>> +       if (minor < 0) {
>>>> +               __wwan_port_destroy(port);
>>>
>>> I see this is documented above, but it's a bit weird that the port is
>>> freed inside the register function, it should be up to the caller to
>>> do this. Is there a reason for this?
>>
>> I agree that this looks weird and asymmetrical. I left the port
>> allocation in wwan_create_port() because both WWAN-exported and
>> GNSS-exported types of port share the same port allocation. And the port
>> struct is used as a container to keep all the port registration arguments.
>>
>> I did the port freeing inside this function because we free the port
>> differently depending of the device registration state. If we fail to
>> initialize the port at earlier stage then we use __wwan_port_destroy()
>> which basically just releases the memory.
>>
>> But if device_register() fails then we are required to use put_device()
>> which does more job.
>>
>> I do not think it is acceptable to skip put_device() call and just
>> release the memory. Also I do not find maintainable to partially open
>> code put_device() here in the WWAN-exportable handler and release the
>> memory in caller function wwan_create_port().
>>
>> We could somehow try to return this information from
>> wwan_port_register_wwan() to wwan_create_port(), so the caller could
>> decide, shall it use __wwan_port_destroy() or put_device() in case of
>> failure.
>>
>> But I can not see a way to clearly indicate, which releasing approach
>> should be used by the caller. And even in this case it going to look
>> weird since the called function controls the caller.
>>
>> Another solution for the asymmetry problem is to move the allocation
>> from the caller to the called function. So the memory will be allocated
>> and released in the same function. But in this case we will need to pass
>> all the parameters from wwan_create_port() to wwan_port_register_wwan().
>> Even if we consolidate the port basic allocation/initialization in a
>> common routine, the final solution going to look a duplication. E.g.
>>
>> struct wwan_port *wwan_port_allocate(struct wwan_device *wwandev,
>>                                        enum wwan_port_type type,
>>                                        const struct wwan_port_ops *ops,
>>                                        struct wwan_port_caps *caps,
>>                                        void *drvdata)
>> {
>>       /* Do the mem allocation and init here */
>>       return port;
>> }
>>
>> struct wwan_port *wwan_port_register_wwan(struct wwan_device *wwandev,
>>                          enum wwan_port_type type,
>>                          const struct wwan_port_ops *ops,
>>                          struct wwan_port_caps *caps,
>>                          void *drvdata)
>> {
>>       port = wwan_port_allocate(wwandev, type, ops, caps, drvdata);
>>       /* Proceed with chardev registration or release on failure */
>>       /* return port; or return ERR_PTR(-err); */
>> }
>>
>> struct wwan_port *wwan_port_register_gnss(struct wwan_device *wwandev,
>>                          enum wwan_port_type type,
>>                          const struct wwan_port_ops *ops,
>>                          struct wwan_port_caps *caps,
>>                          void *drvdata)
>> {
>>       port = wwan_port_allocate(wwandev, type, ops, caps, drvdata);
>>       /* Proceed with GNSS registration or release on failure */
>>       /* return port; or return ERR_PTR(-err); */
>> }
>>
>> struct wwan_port *wwan_create_port(struct device *parent,
>>                                      enum wwan_port_type type,
>>                                      const struct wwan_port_ops *ops,
>>                                      struct wwan_port_caps *caps,
>>                                      void *drvdata)
>> {
>>       ...
>>       wwandev = wwan_create_dev(parent);
>>       if (type == WWAN_PORT_NMEA)
>>           port = wwan_port_register_gnss(wwandev, type, ops,
>>                                          caps, drvdata);
>>       else
>>           port = wwan_port_register_wwan(wwandev, type, ops,
>>                                          caps, drvdata);
>>       if (!IS_ERR(port))
>>           return port;
>>       wwan_remove_dev(wwandev);
>>       return ERR_CAST(port);
>> }
>>
>> wwan_create_port() looks better in prices of passing a list of arguments
>> and allocating the port in multiple places.
>>
>> Maybe some other design approach, what was overseen?
>>
>>
>> For me, the ideal solution would be a routine that works like
>> put_device() except calling the device type release handler. Then we can
>> use it to cleanup leftovers of the failed device_register() call and
>> then release the memory in the calling wwan_create_port() function.
> 
> Ok I see, thanks for the clear explanation, I don't see a perfect
> solution here without over complication. So the current approach is
> acceptable, can you add a comment in the caller function as well,so
> that it's clear why we don't have to release the port on error.

Looks like I've found another one solution to move the port resources 
(memory) release back to the function allocating it. It is also a bit 
hackish and I would like to hear a feedback from you.

The port is released inside wwan_port_register_wwan() just because we 
release it differently depending on the initialization stage, right?

We cannot call put_device() before the device_register() call. And that 
is why I've created that __wwan_port_destroy() routine. What if we make 
port eligible to be released with put_device() ASAP? Internally, 
device_register() just sequentially calls device_initialize() and then 
device_add(). Indeed, device_initialize() makes a device struct eligible 
to be released with put_device().

We can avoid using device_register() and instead of it, do the 
registration step by step. Just after the port memory allocation and 
very basic initialization, we can call device_initialize(). And then 
call device_add() when it is time to register the port with the kernel. 
And if something going to go wrong, we can return just an error from 
wwan_port_register_wwan() and release the port with put_device() in 
wwan_create_port() where it was allocated. Something like this:

static int wwan_port_register_wwan(struct wwan_port *port)
{
     ...
     if (something_wrong)
         return -E<ERROR_TYPE>;
     ...
     return 0;
}

struct wwan_port *wwan_create_port(struct device *parent,
                                    enum wwan_port_type type,
                                    const struct wwan_port_ops *ops,
                                    struct wwan_port_caps *caps,
                                    void *drvdata)
{
     ...
     port = kzalloc(sizeof(*port), GFP_KERNEL);
     /* Do basic port init here */
     port->dev.type = &wwan_port_dev_type;
     device_initialize(&port->dev);  /* allows put_device() usage */

     if (port->type == WWAN_PORT_NMEA)
         err = wwan_port_register_gnss(port);
     else
         err = wwan_port_register_wwan(port);

     if (err) {
         put_device(&port->dev);
         goto error_wwandev_remove;
     }

     return port;
     ...
}

The only drawback I see here is that we have to use put_device() to 
release the port memory even in case of GNSS port. We don't actually 
register the port as device, but I believe, this can be explained with a 
proper comment.

What do you think, is it worth to try to rework the code in this way?

--
Sergey

