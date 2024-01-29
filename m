Return-Path: <netdev+bounces-66797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A65840B17
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0176428DEC6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DB156972;
	Mon, 29 Jan 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKb3BZeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144D155A5F
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544939; cv=none; b=VQAa+/gU+Udn5qZ/Zp2878dsdeDeAKVSyjkvFNtEygRQNfZlyGc67cs+pJUwsvoTXKFIr6CEuGA5P+HiNCgDrphJtlPISRVgdtkl6E1k9BY65vnLSp6fEA7usf5U44CCZhQWjHoeB4zwKFQsCnDwumKkxgNu8b7rYsTqjdbHTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544939; c=relaxed/simple;
	bh=TFMVuBNQIJrdnXniZVTVPM5PQSWRoJl3C1ggsv4WEME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT5VKO2VmLvbK3VzWArUGpYdUS6yoxxLRR6Z1W7IY3fNigi0/+FNYgxwNciqI/4QYnD94IJSgPi7cxAdV8GbzwmCiZ0mllF2EdAYJykNRZlYPYtLIuyEIRFXDuQn4aJH8M43UzEFQZweSzQLxWPTZx5jHvsEpRnVfbKyVuWZOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKb3BZeD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5102a2e4b7bso4256852e87.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544935; x=1707149735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0scVrOm+o1/4m6wPFyLqWYJiKkJoMlcBZDryhDKRAc=;
        b=YKb3BZeDx6dD9zA/JXzFYGMh7Y5C78igCQwbp4Y+iqeS0FIFiwrZRSIoL1CkHsNlAG
         th/uFtuprntGM1S0C6qjIxObaduaRe7xI2J6wjEjHBo6ougKgLp86pWloabbs3A0ejiS
         SXhxPY7nkZdyvMmF6DgQPOZSt8satwVK6ZtYHkxgY1dyM++/xaU6OO49qp3BvFtkuDk+
         G+hyIUZDz/41Pd1A8AGTLksmJrJbzNoGo3qF5wGbFy+9tmkAEWlATpSOaaWREs5r3I5+
         IL8kzQNKL6P3HTSKTX1aKAORpfN426ScONctU6Dy8i65aHjV/wZ9ZlYJVoHsqSG/Nk99
         mcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544935; x=1707149735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0scVrOm+o1/4m6wPFyLqWYJiKkJoMlcBZDryhDKRAc=;
        b=CvACnDugCKmhzClcbqBaF8DVeWudiEpvjuRetJGNlYw5odD3tzNP0tCxOtJMuj0kO+
         uoz4LdVsUSa5Ro4Fcl9G/tB6NWaleraxhG7Y0bvZo0YCYqpvG51Orc/kdsNrWKD88ayp
         2Sxk4EyW9GuBH4dRHAL+B1Sg7mKDYYKPYQfmzb4XlhdOzOEAILuzrKpp0+2Ylip5CzwI
         uw9moDwL7VjlyvrW73Y786e7GyxfHXozAZ4HcJFVVZj+HUUevx3tX/b+We3SP09KyI2T
         md988zdwOE3nmZOOVO/VK57hFSypk98A6WVQHm5uggeUOXBGwcE4uYXZfTldBvRAfkEi
         X0Aw==
X-Gm-Message-State: AOJu0YyS6zXKU6Mn/uY8IhobGCEQ1VqxsAQZPg6scDhbjWvj8VP3pJ5L
	uNFPfVjz+1H7llI0KWPLbviUa3oyXFePVMFh8wjrlgnhZuczAW7a
X-Google-Smtp-Source: AGHT+IHALpAmDjuL6lovS//bhLnL3/eOJdu36rGcAeyPAnXgraGW4XfoCZGwFfGDEJac+m1hO5Nxlg==
X-Received: by 2002:a19:2d43:0:b0:50e:587f:b21e with SMTP id t3-20020a192d43000000b0050e587fb21emr3458810lft.14.1706544935324;
        Mon, 29 Jan 2024 08:15:35 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id tb11-20020a1709078b8b00b00a35f9df7768sm264989ejc.182.2024.01.29.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:15:35 -0800 (PST)
Date: Mon, 29 Jan 2024 18:15:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Message-ID: <20240129161532.sub4yfbjkpfgqfwh@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>

On Sun, Jan 28, 2024 at 11:12:25PM -0300, Luiz Angelo Daros de Luca wrote:
> It looks like it is now, although "remove" mostly leaves the job for devm.
> 
> I'm still not sure if we have the correct shutdown/remove code. From
> what I could understand, driver shutdown is called during system
> shutdown while remove is called when the driver is removed.

Yeah, poweroff or reboot or kexec.

> However, it looks like that both might be called in sequence. Would it
> be shutdown,remove? (it's probably that because there is the
> dev_set_drvdata(priv->dev, NULL) in shutdown).

Yeah, while shutting down, the (SPI, I2C, MDIO, ...) bus driver might
call spi_unregister_controller() on shutdown(), and this will also call
remove() on its child devices. Even the Raspberry Pi SPI controller does
this, AFAIR. The idea of implementing .shutdown() as .remove() is to
gain more code coverage by sharing code, which should reduce chances of
bugs in less-tested code (remove). Or at least that's how the saying goes...

> However, if shutdown should prepare the system for another OS, I
> believe it should be asserting the hw reset as well or remove should
> stop doing it. Are the dsa_switch_shutdown and dsa_switch_unregister
> enough to prevent leaking traffic after the driver is gone? It does
> disable all ports.  Or should we have a fallback "isolate all ports"
> when a hw reset is missing? I guess the u-boot driver does something
> like that.
> 
> I don't think it is mandatory for this series but if we got something
> wrong, it would be nice to fix it.

I don't really know anything at all about kexec. You might want to get
input from someone who uses it. All that I know is that this should do
something meaningful (not crash, and still work in the second kernel):

root@debian:~# kexec -l /boot/Image.gz --reuse-cmdline && kexec -e
[   46.335430] mscc_felix 0000:00:00.5 swp3: Link is Down
[   46.345747] fsl_enetc 0000:00:00.2 eno2: Link is Down
[   46.419201] kvm: exiting hardware virtualization
[   46.424036] kexec_core: Starting new kernel
[   46.471657] psci: CPU1 killed (polled 0 ms)
[   46.486060] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.16.0-rc2-07010-ga9b9500ffaac-dirty (tigrisor@skbuf) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.2-2020.11 (arm-10.16)) 10.2.1 20201103, GNU ld (GNU Toolchain for the A-profile Architecture 10.2-2020.11 (arm-10.16)) 2.35.1.20201028) #1519 SMP PREEMPT Wed Dec 1 08:59:13 EET 2021
[    0.000000] Machine model: LS1028A RDB Board
[    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0500 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000020ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x20ff6fab80-0x20ff6fcfff]
(...)

which in this case it does.

From other discussions I've had, there seems to be interest in quite the
opposite thing, in fact. Reboot the SoC running Linux, but do not
disturb traffic flowing through the switch, and somehow pick up the
state from where the previous kernel left it.

Now, obviously that doesn't currently work, but it does raise the
question about the usefulness of resetting the switch on shutdown.

