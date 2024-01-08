Return-Path: <netdev+bounces-62299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 232B08267CC
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 06:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3711A1C21600
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC346B5;
	Mon,  8 Jan 2024 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUcBVeut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47898BF3
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso11337981fa.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 21:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704692853; x=1705297653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TuR0nWmVMcw1IKyZjCLgd3Mv9W0VJim4YNYV2XLyaQ8=;
        b=jUcBVeutRtloa0g6cHP+wzTUsJnGP6BJNjo2lno5EwPByr/h3YvqJELUXRKxNpI7vS
         BFz/ZTWJ1sruC5kFR1JRUiOi4mCoX8msbJuBokNepksxQVRYmbrrTOq+bCTDGBHLFRyE
         CMXRZZZbNSTZwAFDTI0WPHhbBwTjIwQP44cRGEA/X+VhMzNNfUzbTwME/m1wodnVQFIU
         LPeuR31+HRj4xpCCpjePf8ZGfIo5yO7TBfmu/LgYKuFxWGA0J9uZtb9MreaGB+bv6RzL
         KTjbY1AR5pKGZ0MS3sdNIU7a+oTY+n1XEOgmWm3R6/0ISmOaKEsaBTboZJv6dTALh25E
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704692853; x=1705297653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuR0nWmVMcw1IKyZjCLgd3Mv9W0VJim4YNYV2XLyaQ8=;
        b=eTo2DinpJqadj/uqf/xu2zZ+5prPHQeX7Z/4a8dkQfjWn/Xn10dvnOCE7Y1rIXs8+f
         ApmiFK4lUWHsb3+uxo2/u/5Z+K/YKUfT4W+t/n2EEiOSNBKONFHead9BbCjVTg62rtr2
         pWTr30+qOycjMeue334hLjx2poTur7dDMIKYB614umQ6WwEwU8QXOhYcxaJzpMifJ4Jo
         uPs1wZiioFAOhYshqtXMhXz9o65G3V7tDgUCfiOSb/1BkL1GR0BET03Qzr9lN4LOVFi+
         QrtZ3u0ubTJ/A34E8Ckcc4akjtEPTFIzf78uXQxjMzyuTZk+k57Y2H0X4nPaF4/v5Ooi
         nxog==
X-Gm-Message-State: AOJu0YzobWJCkWwNG9Syz+ESwPaxdFhkNeecOpmtW4dJQ6XY5XM4waOp
	pe7oRZGE3AxFETZ8yUZcyBzf+k6aKS6pezqpMunKA5k45S5miQ==
X-Google-Smtp-Source: AGHT+IGKhTuePocuNmOABndg9nr4BmmCskR6Tylh4maAqLi5MI3jLdnzXIht2Fd9QnMBgo44nlho/CZ4XGDRCEpKAVM=
X-Received: by 2002:a2e:7019:0:b0:2cc:e742:a18d with SMTP id
 l25-20020a2e7019000000b002cce742a18dmr539694ljc.194.1704692853344; Sun, 07
 Jan 2024 21:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com> <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
 <659b1106.050a0220.66c7.9f80@mx.google.com>
In-Reply-To: <659b1106.050a0220.66c7.9f80@mx.google.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 8 Jan 2024 02:47:22 -0300
Message-ID: <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Hi Christian,
> >
> > I tried to implement something close to your work with qca8k and LED
> > hw control. However, I couldn't find a solution that would work with
> > the existing API. The HW led configuration in realtek switches is
> > shared with all LEDs in a group. Before activating the hw control, all
> > LEDs in the same group must share the same netdev trigger config, use
> > the correct device and also use a compatible netdev trigger settings.
> > In order to check that, I would need to expose some internal netdev
> > trigger info that is only available through sysfs (and I believe sysfs
> > is not suitable to be used from the kernel). Even if I got all LEDs
> > with the correct settings, I would need to atomicly switch all LEDs to
> > use the hw control or, at least, I would need to stop all update jobs
> > because if the OS changes a LED brightness, it might be interpreted as
> > the OS disabling the hw control:
> >
>
> Saddly we still don't have the concept of LED groups, but from what I
> notice 99% of the time switch have limitation of HW control but single
> LED can still be controlled separately.

Individually, I can only turn them on/off. That is enough for software
control but not for hardware control. When you set a LED group to
blink on link activity, all LEDs will be affected.

> With this limitation you can use the is_supported function and some priv
> struct to enforce and reject unsupported configuration.
> netdev trigger will then fallback to software in this case. (I assume on
> real world scenario to have all the LED in the group to be set to the
> common rule set resulting in is_supported never rejecting it)

Maybe I wasn't clear enough about what the HW provides me. I have 4
16-bit registers:

REG1: a single blink rate used by all LEDs in all groups
REG2: configures the trigger for each group, 4-bit each, with one
special 4-bit value being "fixed", equivalent to "none" in Linux LED
trigger
REG3: bitmap to manually control LEDs in group 0 and 1 only when their
group trigger is configured as fixed.
REG3: bitmap to manually control LEDs in group 2 and 3 only when their
group trigger is configured as fixed.

And that's it.

I can keep track of the netdev trigger form calls to "is_supported
function". I can also check if all LEDs are still using the netdev
trigger. However, I cannot detect if the user changed the device to
something else not related to the corresponding port as the netdev
trigger will not check the compatibility if the device does not match.
I would still need to expose at least some of the netdev trigger
internal data.

> Also consider this situation, it's the first LED touched that enables HW
> control that drive everything. LED configuration are not enabled all at
> once. You can totally introduce a priv struct that cache the current
> modes and on the other LEDs make sure the requested mode match the cache
> one.

Considering that I can externally check that all LEDs have a netdev
trigger settings compatible with the HW control, once the last LED is
configured, I could return true for the hw_control_is_supported. When
hw_control_set is called, I could configure the hardware accordingly,
which would affect all LEDs in that group. However, the OS will still
use the software control for the other LEDs in that same group. That
way, once a netdev event turns off one LED, that message is the same
clue the LED driver receives to disable the hardware control. It will
undo the hardware change I just made. I could use
led_brightness_set(OFF) on those other LEDs during hw_control_set to
disable their software controlled triggers (actually changing the
trigger to "none"), but it might be a race condition of who stops the
other. And even then, the other LEDs will keep an inconsistent
configuration state, with "none" as their trigger.

I need:
1) expose the required info or allow an external caller to test a LED
configuration for compatibility (avoiding recursion).
2) something from hw_control_set() that stops the software triggers in
other LEDs without destroying their configuration.
3) something that could enable hw_control on those other LEDs

> And I guess this limitation should be printed and documented in DT.
>
> > /*
> > ...
> > * Deactivate hardware blink control by setting brightness to LED_OFF via
> > * the brightness_set() callback.
> > *
> > ...
> > */
> > int (*hw_control_set)(struct led_classdev *led_cdev,
> >  unsigned long flags);
> >
> > Do you have any idea how to implement it?
> >
> > BTW, during my tests with a single LED, ignoring the LED group
> > situation, I noticed that the OS was sending a brightness_set(LED_OFF)
> > after I changed the trigger to netdev, a moment after hw_control_set
> > was called. It doesn't make sense to enable hw control just to disable
> > it afterwards. The call came from set_brightness_delayed(). Maybe it
> > is because my test device is pretty slow and the previous trigger
> > event always gets queued. Touching any settings after that worked as
> > expected without the spurious brightness_set(LED_OFF). Did you see
> > something like this?
> >
>
> Consider that brightness_set is called whatever a trigger is changed,
> the logic is in the generic LED handling. Setting OFF and then enabling
> hw control should not change a thing. In other driver tho I notice an
> extra measure is needed to reset any HW control rule already applied by
> default.

It would be OK to call brightness_set(LED_OFF) if that is guaranteed
to happen before hw_control_set(). The problem is that the
brightness_set(LED_OFF) happens *after* hw_control_set() was called.
It looks like a race condition.

Regards,

Luiz

