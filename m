Return-Path: <netdev+bounces-63421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8982CD08
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24F31F2238A
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7021360;
	Sat, 13 Jan 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3/YmJJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12C21357
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cca5d81826so97554991fa.2
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705155879; x=1705760679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/58FV9+2nwCANfFg7jhFpl+NC2k37CfSvYe8KoXs/c=;
        b=H3/YmJJ+vTFUgq2CrA/DNbxdmaMvKZ95Q5daaj7X8RYEQw92xmcxwWR9CCJTxOhwxh
         GtO2C+j6QFAdU60XWUFfLq6oV+IJWZabRO6Qe/6/opeZwhEMf1bdIeLivf4IIVf2G8T/
         zKaSHVQVSgCy4d82sQ5GP3qkBaWNYxwsCJPVhKNwWrIqgV5PcNfjqN3eGJEJb36ELRye
         7rvUGF85cA1XCmyUGmVwVtACTIK/ej7bcZzJ+yKeJQENiyEmDTLoA/nT8r0FSlnBwWkk
         GXWpRPm4sEWEA2LQQcqLNG5r/FXGatlf218Yzt9fmMC7PZV89nf6ajKygzua2WDXnXyI
         ZNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705155879; x=1705760679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/58FV9+2nwCANfFg7jhFpl+NC2k37CfSvYe8KoXs/c=;
        b=c728/JM53sd00QaIDXwilHAF+ZhbwJq6T1QPw6RuXFYv/9ATpsjaHvhVLpZN/YEIxt
         /bmIkogWF8I14oub6A3ycCUaOGhlOQvMdQIN1FpUVn2GpE4R9Tc5Y5Jei4783GzPI9xa
         0wrnGulVajn5/7d6FrGhgLfGuCBceGQiLEAOV0u3mBkbAw06A8SInXrwe262qzZTNjS4
         kilJLDXWkyP2LuBSXyyEXKbjebqb0V8QnQeDBmLiOjO6EsGQRkA9SWHyKjmOvam4vv+/
         VHWL4KWWi7+pbM8IOGfRfOO5u2gh5dolFPxgn4qFs+dEML6wxf/oAmH6Op8HD8SHM4qW
         er4g==
X-Gm-Message-State: AOJu0YwC7K//qXeoceAhYA/A4OovNw8nr4bCDCxwVIVM+8kbTtAUk0uH
	fs9uqbngsQekqqDoyxkV/XIL8Ks8yYWTzQed9EA=
X-Google-Smtp-Source: AGHT+IE4yGvJbWDksaAQs96phQ+O3I49YGQtC/K1P4gdVb/Pm4JEPU495hsf9TEyEW0mUhWEB5KfvpMenCiBgk/GcJE=
X-Received: by 2002:a2e:a4d5:0:b0:2cd:a2e:fba6 with SMTP id
 p21-20020a2ea4d5000000b002cd0a2efba6mr1488136ljm.11.1705155879032; Sat, 13
 Jan 2024 06:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com> <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
 <659b1106.050a0220.66c7.9f80@mx.google.com> <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>
 <659bf414.050a0220.32376.5383@mx.google.com> <CAJq09z6=78wQOv8HDghtmR04_k+kwCQbf_W7Th7d3NfGDX9pwg@mail.gmail.com>
In-Reply-To: <CAJq09z6=78wQOv8HDghtmR04_k+kwCQbf_W7Th7d3NfGDX9pwg@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jan 2024 11:24:27 -0300
Message-ID: <CAJq09z5SEqCxC5jQ7mPS+rqr-U-eXgWH=mjcpHpWT7UF_7twxA@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I'll try to get who scheduled the work and the stack from there. It
> might already pinpoint the cause. Checking if the work is pending
> during netdev trigger activation might also help. I'll also try to
> flush (or cancel) the work before activating the new trigger. I just
> don't know if I can flush (and that way, blocking) inside
> led_set_brightness().
>

Hi Christian,

I got it. It was actually from the netdev trigger. During activation we have:

        /* Check if hw control is active by default on the LED.
         * Init already enabled mode in hw control.
         */
        if (supports_hw_control(led_cdev)) {
                dev = led_cdev->hw_control_get_device(led_cdev);
                if (dev) {
                        const char *name = dev_name(dev);

                        set_device_name(trigger_data, name, strlen(name));
                        trigger_data->hw_control = true;

                        rc = led_cdev->hw_control_get(led_cdev, &mode);
                        if (!rc)
                                trigger_data->mode = mode;
                }
        }

The set_device_name calls set_baseline_state() that, at this point,
will start to monitor the device using sw control
(trigger_data->hw_control is only set afterwards). In
set_baseline_state(), it will call led_set_brightness in most
codepaths (all of them if trigger_data->hw_control is false). With
link down (and other situations), it will call
led_set_brightness(led_cdev, LED_OFF). If that led_set_brightness
takes some time to be processed, it will happen after the hw control
was configured, undoing what it previously just did.

Is there any good reason to call set_device_name before the led mode
and hw_control are defined? Will this break anything?

diff --git a/drivers/leds/trigger/ledtrig-netdev.c
b/drivers/leds/trigger/ledtrig-netdev.c
index d76214fa9ad8..6f72d55c187a 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -572,12 +572,13 @@ static int netdev_trig_activate(struct
led_classdev *led_cdev)
               if (dev) {
                       const char *name = dev_name(dev);

-                       set_device_name(trigger_data, name, strlen(name));
                       trigger_data->hw_control = true;

                       rc = led_cdev->hw_control_get(led_cdev, &mode);
                       if (!rc)
                               trigger_data->mode = mode;
+
+                       set_device_name(trigger_data, name, strlen(name));
               }
       }

With this patch, it will not undo the trigger setting in hardware
anymore. However, it now calls the hw_control_set 3 times during
activation:

1) set_device_name
2) register_netdevice_notifier on NETDEV_REGISTER
3) register_netdevice_notifier on NETDEV_UP

Anyway, calling it multiple times doesn't break anything.

Regards,

Luiz

