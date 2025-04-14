Return-Path: <netdev+bounces-182490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F138A88DCB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE1169FBF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDF1624CE;
	Mon, 14 Apr 2025 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L86q7Bi4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209551CACF3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666129; cv=none; b=nR/TFT4w/s5xr4K0ZWqnmpIXmplfa1mUY4fQiu5DBk7ndIBTTwcytlePIKbIHGV4IZYP2Y1EeI7cRFEKec/AvPJ+a/uEpGtpJlpCG7RULYW7SlT7QJ/rg08RE21132sVKZonMVeTRzylEp8ZCCogRm7XMHwMYoB7KosI8X7k5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666129; c=relaxed/simple;
	bh=j/5qHHIyG+EfjwuSn/z37Wg54z5mQMVAj0u9RxMOK3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG9yxQ+w6FFYrvkmdLZurbtl3pJcfob2jjaikTqkY+iu3vHszG2jfuxQH1RnwtF2e9GjsxC/chNK7+VWZwr3SeCnVSkh66V/kObhJR5WnKXmh+F/P33UFGV9m18WAjWBrl9A9Bg3kWiN/xRyH86XN3fWyjyl1FcJflWFjuao9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L86q7Bi4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so48660765e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744666125; x=1745270925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6rLonSS1IRYgwVzhVYfx8+TvS/Xpb0X8A+rRi6mFUY=;
        b=L86q7Bi4TYSoyst3Bfjz4XBo/roMnMsPTcp3DQ+P5qWPa+5JRbuy4EujABovEuz6Xf
         wABgoqHr/7Smx71t8a6Vvnpx4LmZEZ65b06JzvniipbvVP7eGIp/8Q84NbnyAD5rav4K
         GpusRoVuIsb7uzOX4F1be5b4D6IgEWYPMh6HdVBfn9TCXTZ52xhHeM1Cwi5MlpBoPFcx
         6GYuGZHXaTmlBr4FOZ7lYmiGWqarKE3M45r/s1/dYb/7+tLMmcyDeTDkJ3zAFIHO4Zb4
         RBC9I3Lw0aBOTW7ILvGediBmi96Up5JmzVu3iAwXOsHk4mWaNocEO3VJtoJowF4nNHq4
         8xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744666125; x=1745270925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6rLonSS1IRYgwVzhVYfx8+TvS/Xpb0X8A+rRi6mFUY=;
        b=PIbwT/ywhEIupjAKD/bc6YeAOe+CKErnIg2dOxkFpJW2afb9VJS0jKH7t5Kuk+yWXb
         45xp8yuPyZS0roTDbij/fORtjzSX2cX3mWCGY6dMM6/eSKsX1CoyW5R/hJGRIFKvSGkY
         vxSpQUtq/73p96LXUwol73EQN8uwAUc/VCn57mxwAR8Lm4ypnNWMw5Kr1lx7/dHnMxI3
         TOE9R4W4dhcpIEmo/Yl8hUTU23vEwVJfy6YJmaR5pYkAM+zNeZnGB6e/UkoDlDM0LvJ6
         mKMcAo7ABvKTC3lCrkSEjLL89oGwAAoM6VvNec4uoAYpWWLXNLFBicRJUjvnAv4xTROP
         gwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUv2trHHMTrh7grg+F4UB4Z57FV+/ID0yMV4Sdp4Rcvxw+co+pUM9jgorYwz6KOQla2W9s9VWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1VUpreSagRxdvcJjeRqvP1kF6O1jSuLWDN0LNw8zhLy6PAPG
	UAFKEmQMDl33Rst3VCffr8AY7DMF3zg6Q9Zx12gWOC33eFICqLcB
X-Gm-Gg: ASbGncuwPcB1N17TzD0OHqFaRRbd6PSTjn0gqs2nC+NerHtcD2FfcTe9DYzim58hAaZ
	A4NxladL6oOvDD1DXH6FmI54FCxfetIXqfJZZFtMICZACz9swsbq6bTzKvUOeWrvYvOTgYKD3dn
	9qxszMoc5eiovxxiSXK9BaFuB0+iTkcKv/rB6jJT9epUAKXSwbYMi9Z/BoBnMcH3CTcUsSA+rsT
	AQJcfP/HsHm2mICP+TQHA3zClugF1ysLVz1AzEhQKZ5VWq+6Eth6LpR8pmGa/p8csvxqHoAowad
	hZjKpVQrP6+hdT1i8r63mqoxjKWxM6o6GM7rcxLKVdD3
X-Google-Smtp-Source: AGHT+IH0OCErbfWzPxCUziEz0u4t1r8R/esQglYEth8JdgjmrYks0lJthixT0SRHixc5LE47eqDLtQ==
X-Received: by 2002:a05:600c:674a:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43f4da84f37mr64620895e9.14.1744666125010;
        Mon, 14 Apr 2025 14:28:45 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977fc8sm11892224f8f.48.2025.04.14.14.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 14:28:43 -0700 (PDT)
Message-ID: <a43d7bce-5f70-4d69-8bad-c65976245996@gmail.com>
Date: Tue, 15 Apr 2025 00:29:14 +0300
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
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-0kBH2HMVAWK_CAoo-Hd3FU8k-54L1tzvBnqs=eS39Gkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

thank you that you found a time to check it. See the explanation below, 
might be you can suggest a better solution.

On 14.04.2025 21:50, Loic Poulain wrote:
> Hi Sergey,
> 
> On Wed, Apr 9, 2025 at 1:31 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>
>> Upcoming GNSS (NMEA) port type support requires exporting it via the
>> GNSS subsystem. On another hand, we still need to do basic WWAN core
>> work: find or allocate the WWAN device, make it the port parent, etc. To
>> reuse as much code as possible, split the port creation function into
>> the registration of a regular WWAN port device, and basic port struct
>> initialization.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>   drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++--------------
>>   1 file changed, 53 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
>> index ade8bbffc93e..045246d7cd50 100644
>> --- a/drivers/net/wwan/wwan_core.c
>> +++ b/drivers/net/wwan/wwan_core.c
>> @@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] = {
>>   };
>>   ATTRIBUTE_GROUPS(wwan_port);
>>
>> -static void wwan_port_destroy(struct device *dev)
>> +static void __wwan_port_destroy(struct wwan_port *port)
>>   {
>> -       struct wwan_port *port = to_wwan_port(dev);
>> -
>> -       ida_free(&minors, MINOR(port->dev.devt));
>>          mutex_destroy(&port->data_lock);
>>          mutex_destroy(&port->ops_lock);
>>          kfree(port);
>>   }
>>
>> +static void wwan_port_destroy(struct device *dev)
>> +{
>> +       ida_free(&minors, MINOR(dev->devt));
>> +       __wwan_port_destroy(to_wwan_port(dev));
>> +}
>> +
>>   static const struct device_type wwan_port_dev_type = {
>>          .name = "wwan_port",
>>          .release = wwan_port_destroy,
>> @@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
>>          return dev_set_name(&port->dev, "%s", buf);
>>   }
>>
>> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
>> + *
>> + * NB: in case of error function frees the port memory.
>> + */
>> +static int wwan_port_register_wwan(struct wwan_port *port)
>> +{
>> +       struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>> +       char namefmt[0x20];
>> +       int minor, err;
>> +
>> +       /* A port is exposed as character device, get a minor */
>> +       minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
>> +       if (minor < 0) {
>> +               __wwan_port_destroy(port);
> 
> I see this is documented above, but it's a bit weird that the port is
> freed inside the register function, it should be up to the caller to
> do this. Is there a reason for this?

I agree that this looks weird and asymmetrical. I left the port 
allocation in wwan_create_port() because both WWAN-exported and 
GNSS-exported types of port share the same port allocation. And the port 
struct is used as a container to keep all the port registration arguments.

I did the port freeing inside this function because we free the port 
differently depending of the device registration state. If we fail to 
initialize the port at earlier stage then we use __wwan_port_destroy() 
which basically just releases the memory.

But if device_register() fails then we are required to use put_device() 
which does more job.

I do not think it is acceptable to skip put_device() call and just 
release the memory. Also I do not find maintainable to partially open 
code put_device() here in the WWAN-exportable handler and release the 
memory in caller function wwan_create_port().

We could somehow try to return this information from 
wwan_port_register_wwan() to wwan_create_port(), so the caller could 
decide, shall it use __wwan_port_destroy() or put_device() in case of 
failure.

But I can not see a way to clearly indicate, which releasing approach 
should be used by the caller. And even in this case it going to look 
weird since the called function controls the caller.

Another solution for the asymmetry problem is to move the allocation 
from the caller to the called function. So the memory will be allocated 
and released in the same function. But in this case we will need to pass 
all the parameters from wwan_create_port() to wwan_port_register_wwan(). 
Even if we consolidate the port basic allocation/initialization in a 
common routine, the final solution going to look a duplication. E.g.

struct wwan_port *wwan_port_allocate(struct wwan_device *wwandev,
                                      enum wwan_port_type type,
                                      const struct wwan_port_ops *ops,
                                      struct wwan_port_caps *caps,
                                      void *drvdata)
{
     /* Do the mem allocation and init here */
     return port;
}

struct wwan_port *wwan_port_register_wwan(struct wwan_device *wwandev,
                        enum wwan_port_type type,
                        const struct wwan_port_ops *ops,
                        struct wwan_port_caps *caps,
                        void *drvdata)
{
     port = wwan_port_allocate(wwandev, type, ops, caps, drvdata);
     /* Proceed with chardev registration or release on failure */
     /* return port; or return ERR_PTR(-err); */
}

struct wwan_port *wwan_port_register_gnss(struct wwan_device *wwandev,
                        enum wwan_port_type type,
                        const struct wwan_port_ops *ops,
                        struct wwan_port_caps *caps,
                        void *drvdata)
{
     port = wwan_port_allocate(wwandev, type, ops, caps, drvdata);
     /* Proceed with GNSS registration or release on failure */
     /* return port; or return ERR_PTR(-err); */
}

struct wwan_port *wwan_create_port(struct device *parent,
                                    enum wwan_port_type type,
                                    const struct wwan_port_ops *ops,
                                    struct wwan_port_caps *caps,
                                    void *drvdata)
{
     ...
     wwandev = wwan_create_dev(parent);
     if (type == WWAN_PORT_NMEA)
         port = wwan_port_register_gnss(wwandev, type, ops,
                                        caps, drvdata);
     else
         port = wwan_port_register_wwan(wwandev, type, ops,
                                        caps, drvdata);
     if (!IS_ERR(port))
         return port;
     wwan_remove_dev(wwandev);
     return ERR_CAST(port);
}

wwan_create_port() looks better in prices of passing a list of arguments 
and allocating the port in multiple places.

Maybe some other design approach, what was overseen?


For me, the ideal solution would be a routine that works like 
put_device() except calling the device type release handler. Then we can 
use it to cleanup leftovers of the failed device_register() call and 
then release the memory in the calling wwan_create_port() function.

>> +               return minor;
>> +       }
>> +
>> +       port->dev.class = &wwan_class;
>> +       port->dev.type = &wwan_port_dev_type;
>> +       port->dev.devt = MKDEV(wwan_major, minor);
>> +
>> +       /* allocate unique name based on wwan device id, port type and number */
>> +       snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
>> +                wwan_port_types[port->type].devsuf);
>> +
>> +       /* Serialize ports registration */
>> +       mutex_lock(&wwan_register_lock);
>> +
>> +       __wwan_port_dev_assign_name(port, namefmt);
>> +       err = device_register(&port->dev);
>> +
>> +       mutex_unlock(&wwan_register_lock);
>> +
>> +       if (err) {
>> +               put_device(&port->dev);
>> +               return err;
>> +       }
>> +
>> +       dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
>> +
>> +       return 0;
>> +}
>> +
>>   struct wwan_port *wwan_create_port(struct device *parent,
>>                                     enum wwan_port_type type,
>>                                     const struct wwan_port_ops *ops,
>> @@ -448,8 +494,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
>>   {
>>          struct wwan_device *wwandev;
>>          struct wwan_port *port;
>> -       char namefmt[0x20];
>> -       int minor, err;
>> +       int err;
>>
>>          if (type > WWAN_PORT_MAX || !ops)
>>                  return ERR_PTR(-EINVAL);
>> @@ -461,17 +506,9 @@ struct wwan_port *wwan_create_port(struct device *parent,
>>          if (IS_ERR(wwandev))
>>                  return ERR_CAST(wwandev);
>>
>> -       /* A port is exposed as character device, get a minor */
>> -       minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
>> -       if (minor < 0) {
>> -               err = minor;
>> -               goto error_wwandev_remove;
>> -       }
>> -
>>          port = kzalloc(sizeof(*port), GFP_KERNEL);
>>          if (!port) {
>>                  err = -ENOMEM;
>> -               ida_free(&minors, minor);
>>                  goto error_wwandev_remove;
>>          }
>>
>> @@ -485,31 +522,14 @@ struct wwan_port *wwan_create_port(struct device *parent,
>>          mutex_init(&port->data_lock);
>>
>>          port->dev.parent = &wwandev->dev;
>> -       port->dev.class = &wwan_class;
>> -       port->dev.type = &wwan_port_dev_type;
>> -       port->dev.devt = MKDEV(wwan_major, minor);
>>          dev_set_drvdata(&port->dev, drvdata);
>>
>> -       /* allocate unique name based on wwan device id, port type and number */
>> -       snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
>> -                wwan_port_types[port->type].devsuf);
>> -
>> -       /* Serialize ports registration */
>> -       mutex_lock(&wwan_register_lock);
>> -
>> -       __wwan_port_dev_assign_name(port, namefmt);
>> -       err = device_register(&port->dev);
>> -
>> -       mutex_unlock(&wwan_register_lock);
>> -
>> +       err = wwan_port_register_wwan(port);
>>          if (err)
>> -               goto error_put_device;
>> +               goto error_wwandev_remove;
>>
>> -       dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
>>          return port;
>>
>> -error_put_device:
>> -       put_device(&port->dev);
>>   error_wwandev_remove:
>>          wwan_remove_dev(wwandev);
>>

--
Sergey


