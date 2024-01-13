Return-Path: <netdev+bounces-63391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022482C950
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 05:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3D286F63
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 04:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97ACA7D;
	Sat, 13 Jan 2024 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2PXM5aI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF77DF4F
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd0db24e03so83705271fa.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 20:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705118783; x=1705723583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lna9h0O+UVXK8PCGcFet0ZSWy0Enl4DsKLCDtHLGJT0=;
        b=Z2PXM5aIOG2vE3iSUbCMGIzmLIWhmPu3msg5zRSTXs2T1R9j4UZtjCx/ooGyGXs9rY
         rf4CmhIAKKItL6nMxaV1hj9CJqqN0o8wTQ1AuPahCqsCCiOEyCskzMYh4dNU4ypCfBQ5
         htNjEJtOrAgU5CH23QCkIV6PwwK8/84y4MRB6X4ShRh4ahq3tLnzvBrypPbg2H0Ykpi7
         QLxMmi7OfVSGrBcpcdUqrh0niEm5oSqIEylDjbolnkfpkNztpgpGYU1y8DAFJUEXWAgL
         zoltiE6hV1/xXtfWjUr9qqkEneUoekbqXUczvJd35E/9fV5t8/B9/i5cxdwu1epP9cZs
         6Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705118783; x=1705723583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lna9h0O+UVXK8PCGcFet0ZSWy0Enl4DsKLCDtHLGJT0=;
        b=FpaMxdoWaLjlpgcaHQLMxKNWSVKJXFkR+LLUsvb9U5A93qopKFD02TfJVR85zuajpb
         BjJxczhJFTA6A5McLaUkOd+pYQ/RxylCedOMRc52ld3o3SpJqFi2JHckwIKKaepGHJxI
         TOJUHjYwL/f++/dFky6AWtfUuKl04zmg0Ts2cHpUkJ484mQoa8v05eQ414OlelR+gqqi
         GMxx2MSp0HXdGtuqE61vWH4C09wYVDH7atxopbN4iXspdgwWygejc9aYXp6jgzv+kL3f
         WpZeevvrtaA8tt7X3+3JsT9if4MqhpxjodjQ/9zD/JsbhrvmJ4NNp3v2GJg4gSndaJIn
         4e9Q==
X-Gm-Message-State: AOJu0Yz2p4oa4OH66kVt4gYDpqEGTh+O2rNDN+l5nZ8RTwWX+HwNE1ah
	JDbxYfCPXURoeCzv+1KDEiRfdO2QNeM9ujneWYCaSzFEiqw=
X-Google-Smtp-Source: AGHT+IGmxZp4qfoOV/nWqIkYELwu0iKsV+wlDu1kBwYPq5uA8XBClA/17IDn4OUFidVGKZ7nRSrG1DEGrE4+yMLcGwg=
X-Received: by 2002:a2e:a305:0:b0:2cc:3e6d:8dcb with SMTP id
 l5-20020a2ea305000000b002cc3e6d8dcbmr667653lje.104.1705118782622; Fri, 12 Jan
 2024 20:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com> <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
 <659b1106.050a0220.66c7.9f80@mx.google.com> <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>
 <659bf414.050a0220.32376.5383@mx.google.com>
In-Reply-To: <659bf414.050a0220.32376.5383@mx.google.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jan 2024 01:06:11 -0300
Message-ID: <CAJq09z6=78wQOv8HDghtmR04_k+kwCQbf_W7Th7d3NfGDX9pwg@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Mon, Jan 08, 2024 at 02:47:22AM -0300, Luiz Angelo Daros de Luca wrote:
> > > > Hi Christian,
> > > >
> > > > I tried to implement something close to your work with qca8k and LED
> > > > hw control. However, I couldn't find a solution that would work with
> > > > the existing API. The HW led configuration in realtek switches is
> > > > shared with all LEDs in a group. Before activating the hw control, all
> > > > LEDs in the same group must share the same netdev trigger config, use
> > > > the correct device and also use a compatible netdev trigger settings.
> > > > In order to check that, I would need to expose some internal netdev
> > > > trigger info that is only available through sysfs (and I believe sysfs
> > > > is not suitable to be used from the kernel). Even if I got all LEDs
> > > > with the correct settings, I would need to atomicly switch all LEDs to
> > > > use the hw control or, at least, I would need to stop all update jobs
> > > > because if the OS changes a LED brightness, it might be interpreted as
> > > > the OS disabling the hw control:
> > > >
> > >
> > > Saddly we still don't have the concept of LED groups, but from what I
> > > notice 99% of the time switch have limitation of HW control but single
> > > LED can still be controlled separately.
> >
> > Individually, I can only turn them on/off. That is enough for software
> > control but not for hardware control. When you set a LED group to
> > blink on link activity, all LEDs will be affected.
> >
>
> Assuming we have the same 2005 datasheet, yes the LED situation is
> complex for this switch. (If you have something better please link)

I wouldn't say complex, but limited.

The manual for rtl8365mb
(https://cdn.jsdelivr.net/gh/libc0607/Realtek_switch_hacking@files/Realtek_Unmanaged_Switch_ProgrammingGuide.pdf,
page 64) shows the vendor API for controlling LEDs. It is similar for
both families.
You have only 3 functions:

int32 rtk_led_blinkRate_set(rtk_led_blink_rate_t blinkRate)
int32 rtk_led_groupConfig_set(rtk_led_group_t group, rtk_led_congig_t config)
int32 rtk_led_enable_set(rtk_led_group_t group, rtk_portmask_t portmask)

rtk_led_blinkRate_set sets the blink rate but it does not mention
group or port, so it is global.
rtk_led_groupConfig_set defines the HW trigger but only by group.
rtk_led_enable_set uses a mask to manually set a LED

It closely matches the register behavior.

> > > Also consider this situation, it's the first LED touched that enables HW
> > > control that drive everything. LED configuration are not enabled all at
> > > once. You can totally introduce a priv struct that cache the current
> > > modes and on the other LEDs make sure the requested mode match the cache
> > > one.
> >
> > Considering that I can externally check that all LEDs have a netdev
> > trigger settings compatible with the HW control, once the last LED is
> > configured, I could return true for the hw_control_is_supported. When
> > hw_control_set is called, I could configure the hardware accordingly,
> > which would affect all LEDs in that group. However, the OS will still
> > use the software control for the other LEDs in that same group. That
> > way, once a netdev event turns off one LED, that message is the same
> > clue the LED driver receives to disable the hardware control. It will
> > undo the hardware change I just made. I could use
> > led_brightness_set(OFF) on those other LEDs during hw_control_set to
> > disable their software controlled triggers (actually changing the
> > trigger to "none"), but it might be a race condition of who stops the
> > other. And even then, the other LEDs will keep an inconsistent
> > configuration state, with "none" as their trigger.
> >
> > I need:
> > 1) expose the required info or allow an external caller to test a LED
> > configuration for compatibility (avoiding recursion).
> > 2) something from hw_control_set() that stops the software triggers in
> > other LEDs without destroying their configuration.
> > 3) something that could enable hw_control on those other LEDs
> >
>
> I think it would be problematic for other LED to do changes. I need to
> check how LED multicolor work... In a sense they are LED group so maybe
> in LED core we have a way to group LED and share some info with the
> others.

That's the main issue. I can expose the needed info to check if all
LEDs agree in a compatible configuration. However, once that happens,
I must stop all sw control and enable the hw control. Something like:

lock a group of leds
for all leds
   if not devname is correct
     fallback to sw control
   if settings are not compatible
     fallback to sw control
   if settings is different from other LEDs
     fallback to sw control
for all leds
   stop sw control work
for all leds
   enable hw control
set the group hw trigger
unlock the group of leds

And I need something that would also work to disable hw control once
the first LED changes anything, breaking the compatibility.

> > > > BTW, during my tests with a single LED, ignoring the LED group
> > > > situation, I noticed that the OS was sending a brightness_set(LED_OFF)
> > > > after I changed the trigger to netdev, a moment after hw_control_set
> > > > was called. It doesn't make sense to enable hw control just to disable
> > > > it afterwards. The call came from set_brightness_delayed(). Maybe it
> > > > is because my test device is pretty slow and the previous trigger
> > > > event always gets queued. Touching any settings after that worked as
> > > > expected without the spurious brightness_set(LED_OFF). Did you see
> > > > something like this?
> > > >
> > >
> > > Consider that brightness_set is called whatever a trigger is changed,
> > > the logic is in the generic LED handling. Setting OFF and then enabling
> > > hw control should not change a thing. In other driver tho I notice an
> > > extra measure is needed to reset any HW control rule already applied by
> > > default.
> >
> > It would be OK to call brightness_set(LED_OFF) if that is guaranteed
> > to happen before hw_control_set(). The problem is that the
> > brightness_set(LED_OFF) happens *after* hw_control_set() was called.
> > It looks like a race condition.
> >
>
> Totally require some further investigation, it seems strange tho that
> the your system is that slow.

I got some stacks. When I change the trigger to netdev, I get 2 calls
to set the hw control:

[  625.601449] CPU: 0 PID: 2607 Comm: ash Not tainted 6.1.59 #0
[  625.607153] Stack : 809b0000 77e70000 00000000 800c1e80 00000431
00000004 00000000 00000000
[  625.615627]         80c45c74 80980000 80850000 806ffc2c 80e23b88
00000001 80c45c18 f51e58b8
[  625.624094]         00000000 00000000 806ffc2c 80c45b48 ffffefff
00000000 00000000 ffffffea
[  625.632561]         00000112 80c45b54 00000112 807c99c0 00000001
806ffc2c 809ec080 00000005
[  625.641029]         ffff7fff 80840000 809b0000 77e70000 00000018
8039785c 00000000 80980000
[  625.649495]         ...
[  625.651965] Call Trace:
[  625.654422] [<80066e4c>] show_stack+0x28/0xf0
[  625.658848] [<8061b800>] dump_stack_lvl+0x38/0x60
[  625.663599] [<8189b890>] rtl8366rb_cled_hw_control_set+0xdc/0xf8 [rtl8366]
[  625.670578] [<8041dfb0>] netdev_trig_notify+0x114/0x280
[  625.675867] [<80450d14>] call_netdevice_register_net_notifiers+0x54/0x104
[  625.682729] [<804542dc>] register_netdevice_notifier+0x98/0x130
[  625.688702] [<8041dbf8>] netdev_trig_activate+0x160/0x1b0
[  625.694152] [<8041b948>] led_trigger_set+0xf8/0x254
[  625.699070] [<8041c2a4>] led_trigger_write+0xd4/0x148
[  625.704163] [<8026966c>] sysfs_kf_bin_write+0x80/0xbc
[  625.709263] [<80268438>] kernfs_fop_write_iter+0x118/0x244
[  625.714801] [<801e787c>] vfs_write+0x1fc/0x3c0
[  625.719301] [<801e7bdc>] ksys_write+0x70/0x124
[  625.723791] [<8006e1e4>] syscall_common+0x34/0x58

[  625.761665] CPU: 0 PID: 2607 Comm: ash Not tainted 6.1.59 #0
[  625.767374] Stack : 809b0000 77e70000 00000000 800c1e80 00000431
00000004 00000000 00000000
[  625.775848]         80c45c74 80980000 80850000 806ffc2c 80e23b88
00000001 80c45c18 f51e58b8
[  625.784315]         00000000 00000000 806ffc2c 80c45b48 ffffefff
00000000 00000000 ffffffea
[  625.792782]         00000130 80c45b54 00000130 807c99c0 00000001
806ffc2c 809ec080 00000001
[  625.801249]         ffff7fff 80840000 809b0000 77e70000 00000018
8039785c 00000000 80980000
[  625.809716]         ...
[  625.812186] Call Trace:
[  625.814643] [<80066e4c>] show_stack+0x28/0xf0
[  625.819068] [<8061b800>] dump_stack_lvl+0x38/0x60
[  625.823820] [<8189b890>] rtl8366rb_cled_hw_control_set+0xdc/0xf8 [rtl8366]
[  625.830800] [<8041dfb0>] netdev_trig_notify+0x114/0x280
[  625.836088] [<80450d94>] call_netdevice_register_net_notifiers+0xd4/0x104
[  625.842950] [<804542dc>] register_netdevice_notifier+0x98/0x130
[  625.848923] [<8041dbf8>] netdev_trig_activate+0x160/0x1b0
[  625.854374] [<8041b948>] led_trigger_set+0xf8/0x254
[  625.859300] [<8041c2a4>] led_trigger_write+0xd4/0x148
[  625.864401] [<8026966c>] sysfs_kf_bin_write+0x80/0xbc
[  625.869502] [<80268438>] kernfs_fop_write_iter+0x118/0x244
[  625.875040] [<801e787c>] vfs_write+0x1fc/0x3c0
[  625.879539] [<801e7bdc>] ksys_write+0x70/0x124
[  625.884030] [<8006e1e4>] syscall_common+0x34/0x58

That is not really a problem but I my guess is that it is calling for
both NETDEV_REGISTER and NETDEV_UP as both eventually call
set_baseline_state(). Shouldn't we avoid one of them?

But after that, I get:

[  625.900712] CPU: 0 PID: 2626 Comm: kworker/0:2 Not tainted 6.1.59 #0
[  625.907154] Workqueue: events set_brightness_delayed
[  625.912178] Stack : 81000205 81a4ab40 817f9da4 800c1e80 8199e4e0
806ffc2c 807c0000 81a4ab00
[  625.920652]         81000200 00000000 80c08c5c 800c1f7c 80e21cc8
00000001 817f9d60 f37f8d2c
[  625.929119]         00000000 00000000 806ffc2c 817f9c78 ffffefff
00000000 00000000 ffffffea
[  625.937587]         00000148 817f9c84 00000148 807c99c0 00000001
806ffc2c 00000000 81000200
[  625.946054]         00000000 80c08c5c 81000205 81a4ab40 00000018
8039785c 00000000 80980000
[  625.954521]         ...
[  625.956990] Call Trace:
[  625.959448] [<80066e4c>] show_stack+0x28/0xf0
[  625.963873] [<8061b800>] dump_stack_lvl+0x38/0x60
[  625.968624] [<81899ec8>]
rtl8366rb_cled_brightness_set_blocking+0x68/0x88 [rtl8366]
[  625.976389] [<8041a018>] set_brightness_delayed+0x84/0xec
[  625.981833] [<8009f724>] process_one_work+0x254/0x484
[  625.986934] [<8009fed0>] worker_thread+0x178/0x5a4
[  625.991766] [<800a61a0>] kthread+0xec/0x114
[  625.996004] [<800620b8>] ret_from_kernel_thread+0x14/0x1c

This one is the issue. It turns off the LED, forcing me to disable the
hw control I just configured (twice). Unfortunately, a scheduled work
breaks the stack, not showing who actually requested it.

I only saw set_brightness_delayed being used by a work created in
led_init_core(), called by led_classdev_register_ext. That work might
be scheduled by led_set_brightness(). So, a call to
led_set_brightness() moments before setting netdev trigger might
reproduce the issue I see.

I'll try to get who scheduled the work and the stack from there. It
might already pinpoint the cause. Checking if the work is pending
during netdev trigger activation might also help. I'll also try to
flush (or cancel) the work before activating the new trigger. I just
don't know if I can flush (and that way, blocking) inside
led_set_brightness().

I just bricked my device and I couldn't continue the tests. I might
need to reserve an extra hour to fix that in the next days.

Regards,

Luiz

