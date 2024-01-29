Return-Path: <netdev+bounces-66803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7699840B43
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9071F21C23
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461A155A5D;
	Mon, 29 Jan 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6d3P+Tv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77805156993
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545371; cv=none; b=LsKvJI5Mpdr85WCCxEFDvtgEcEUR8rCQH221HI+JVy6Tmz8NX0Nax438U1rTGQdJD3CV+79DlbCq6JRHFVP66QupkBqE2x718UwmqadC1guCCSijtV5fWrfGt3Ctl9U67lR6uoMsNoo4DMi2oiDqIJN6lxvFi9I1SF9FXm0dKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545371; c=relaxed/simple;
	bh=RIlOUkts17J+fWTOtkDHmEnaDMSRXm0V/c0C+CnCvBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPYf6A5GZcaWBWVE3XPEMZBLwHPtcqMpV0KVV5z9GCgKg8diUxHRu+cL7H/HJbheT1+mj9y2SS07CMlxuNnNDnsOUrru9xZA6XwCz6uxvDzT6L/PyUbzvqTNkAIzp+VVgarMNL5ws69O+8ENwsE/5mXLc5sATxjKqj9X8xxMphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6d3P+Tv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de029f88d8so2134713b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545370; x=1707150170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95GxRx45cwp40w2z1VCI0FtBfdt/08ItuB2pGgizNhU=;
        b=g6d3P+TvVUEFrac9BTPkjPQJKTlu8yqYc3Ic2Ub8MO6Diwkio8E4H87S/ZYW9GjG77
         lali2SZjELJu+sh1RSry0Mw74TDVPx2vaocA8FGq7hR01wdrCaRCsWpoFYgGbaBJ4lmK
         ProCsmm/tbeT/bCW6GpaP9tgsmKMoRPBt2uxukrQEa9JLuYcFLduIP8b1/vLa0R0V+/N
         kJCM9HpsRdIH67jbiHslg4BzRZvaAtkQ3VbO/4wPD+cGoAl2/1I2+KFzUJu61yA0mqz0
         xMaJkLMPt2rnqLV2Fw0V+kFHuHtv23Ec0GKokoARNbCVHxmzbm2jfzn7YxVhGf4dg9NE
         /dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545370; x=1707150170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95GxRx45cwp40w2z1VCI0FtBfdt/08ItuB2pGgizNhU=;
        b=iUV90HWXczqZ8rQ2psC3/0uC/QpvfS1IWZs38cbEX6Yp3FUmgNvob6POeXdYTKh6Pu
         2vXtsaxB1+uKx90j1yHMWANrmLRhHS24N4gTKl9rrN2BuqcfPsjNKv9Ef70ySNnFDztZ
         EPanr1v1AUcgLfW5UMICRlrSHKCLeaVbUA4auQSfQnLEGVVMNfyGZ+Ryb4DZNRFHgzLu
         GgfjyeJyVjKu1C1oOTID8ZJ4wk+JhIVSrEhJzl3NTQe7t6bjfZpFkJGYF2+gm/xRhwRa
         +SbcKiV4yexK3g1rnCTIDhHIQBHFm8n20nTjiIUghmSuMQbAgipwxgW32IjuXLARrOkF
         tXnw==
X-Gm-Message-State: AOJu0YxbJQy+dLSgXwd7PgTLFmuLXHK1RzHA0kZf0Pg8MBO5fH82iBCN
	XTCvtceimLleOD4FT9/aojL5MK1SnJvRnFh6/MKwFGdDYq8/3/Q8
X-Google-Smtp-Source: AGHT+IEAHmFXh5jaFTj76omMEsJS1RmYNR+8xbm4s7ouaAdPfw855E8TJr/dz7GMsLJvOQJycpkJcw==
X-Received: by 2002:a05:6a21:3386:b0:19c:64a5:2162 with SMTP id yy6-20020a056a21338600b0019c64a52162mr6498542pzb.20.1706545369593;
        Mon, 29 Jan 2024 08:22:49 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id kb3-20020a170903338300b001d8d582e742sm2600801plb.270.2024.01.29.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:22:48 -0800 (PST)
Message-ID: <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
Date: Mon, 29 Jan 2024 08:22:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arinc.unal@arinc9.com, ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240129161532.sub4yfbjkpfgqfwh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/2024 8:15 AM, Vladimir Oltean wrote:
> On Sun, Jan 28, 2024 at 11:12:25PM -0300, Luiz Angelo Daros de Luca wrote:
>> It looks like it is now, although "remove" mostly leaves the job for devm.
>>
>> I'm still not sure if we have the correct shutdown/remove code. From
>> what I could understand, driver shutdown is called during system
>> shutdown while remove is called when the driver is removed.
> 
> Yeah, poweroff or reboot or kexec.
> 
>> However, it looks like that both might be called in sequence. Would it
>> be shutdown,remove? (it's probably that because there is the
>> dev_set_drvdata(priv->dev, NULL) in shutdown).
> 
> Yeah, while shutting down, the (SPI, I2C, MDIO, ...) bus driver might
> call spi_unregister_controller() on shutdown(), and this will also call
> remove() on its child devices. Even the Raspberry Pi SPI controller does
> this, AFAIR. The idea of implementing .shutdown() as .remove() is to
> gain more code coverage by sharing code, which should reduce chances of
> bugs in less-tested code (remove). Or at least that's how the saying goes...
> 
>> However, if shutdown should prepare the system for another OS, I
>> believe it should be asserting the hw reset as well or remove should
>> stop doing it. Are the dsa_switch_shutdown and dsa_switch_unregister
>> enough to prevent leaking traffic after the driver is gone? It does
>> disable all ports.  Or should we have a fallback "isolate all ports"
>> when a hw reset is missing? I guess the u-boot driver does something
>> like that.
>>
>> I don't think it is mandatory for this series but if we got something
>> wrong, it would be nice to fix it.
> 
> I don't really know anything at all about kexec. You might want to get
> input from someone who uses it. All that I know is that this should do
> something meaningful (not crash, and still work in the second kernel):
> 
> root@debian:~# kexec -l /boot/Image.gz --reuse-cmdline && kexec -e
> [   46.335430] mscc_felix 0000:00:00.5 swp3: Link is Down
> [   46.345747] fsl_enetc 0000:00:00.2 eno2: Link is Down
> [   46.419201] kvm: exiting hardware virtualization
> [   46.424036] kexec_core: Starting new kernel
> [   46.471657] psci: CPU1 killed (polled 0 ms)
> [   46.486060] Bye!
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
> [    0.000000] Linux version 5.16.0-rc2-07010-ga9b9500ffaac-dirty (tigrisor@skbuf) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.2-2020.11 (arm-10.16)) 10.2.1 20201103, GNU ld (GNU Toolchain for the A-profile Architecture 10.2-2020.11 (arm-10.16)) 2.35.1.20201028) #1519 SMP PREEMPT Wed Dec 1 08:59:13 EET 2021
> [    0.000000] Machine model: LS1028A RDB Board
> [    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0500 (options '')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000020ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x20ff6fab80-0x20ff6fcfff]
> (...)
> 
> which in this case it does.
> 
>  From other discussions I've had, there seems to be interest in quite the
> opposite thing, in fact. Reboot the SoC running Linux, but do not
> disturb traffic flowing through the switch, and somehow pick up the
> state from where the previous kernel left it.

Yes this is actually an use case that is very dear to the users of DSA 
in an airplane. The entertainment system in the seat in front of you 
typically has a left, CPU/display and right set of switch ports. Across 
the 300+ units in the plane each entertainment systems runs STP to avoid 
loops being created when one of the display units goes bad. Occasionally 
cabin crew members will have to swap those units out since they tend to 
wear out. When they do, the switch operates in a headless mode and it 
would be unfortunate that plugging in a display unit into the network 
again would be disrupting existing traffic. I have seen out of tree 
patches doing that, but there was not a good way to make them upstream 
quality.

> 
> Now, obviously that doesn't currently work, but it does raise the
> question about the usefulness of resetting the switch on shutdown.

The users would really care would likely introduce sufficient amounts of 
control knobs (module parameters, ethtool private flags, devlink?) to 
control that behavior. It does seem however universally acceptable to 
stop any DMAs and packets from flowing as a default and safe 
implementation to the upstream kernel.
-- 
Florian

