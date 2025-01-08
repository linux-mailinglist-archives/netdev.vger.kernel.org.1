Return-Path: <netdev+bounces-156197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7FA05782
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839577A3217
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD361F892F;
	Wed,  8 Jan 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="U2jsYLz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033E1F8667
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330170; cv=none; b=JZaIob2MseescfajDSrDxf4JDHeXqXoviI/J7j7PkxSD8Rt21BGexUYkcBRxK79B31K2sDg0qFMyxNRjcLD17/Lq8TKp8poJoS4WFVYzN1vIsm1r1KniNNVtt8bn74vVasNDo7/I/kZda5DbKF/yXpPCmyQgHO15T5vSTdnRZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330170; c=relaxed/simple;
	bh=unTnn6KQo5XitzCC/dKK2V1QVl5mnw753rU5j9p6tfI=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Fc8yqznRW3YDGFi8xhJ7ok6ch76G2kIq1Pe8FDXgyM6moaWxqa/0wY3q0mY3HiFkMm9SldVrEwEYVxt8sCWtTRi3C9SuaLfnvHlt8iZf2OmJIIiDHyO/Ma+ESwI/iM8wiRWm/ikREVa7XAph1Mkd7loDyj+GrJvpP+w2urggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=U2jsYLz1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so224497615ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 01:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1736330166; x=1736934966; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZPFzNsNKz2iWDthJJl/XRnudiDnv5Z0MRal5mniU3o=;
        b=U2jsYLz1JQbQ0lnHvqaviHHBed5TavFfmBNR7KzZW+Gp8E/q3rt0pPGWw6ygnZJMYq
         g3bCuD7qUL4poRSTI48oj+OiIEQOSG5a8foL4ubsnj66V9grkmDC86npOwevi6qn4xu9
         H6HiaJP7AmEGLrCv2wKjDQ3J4eq3iaFE4TCDweq+vPb8FOHRTVMX4PJ+ISEKujTvrhaz
         f0zgkdB9WcyExH//0W36FEKHwMoPIrEjRfNbrjjxCxhqyWVi4Hg3mYmxUx8l9bvIgoRs
         CbUJILx+3Vevj4yO+9s8NxrepALP6DoLtsTyLy9v9l/WmRFHP3n/D5GsOlyAxM9Uk+Vg
         xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736330166; x=1736934966;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZPFzNsNKz2iWDthJJl/XRnudiDnv5Z0MRal5mniU3o=;
        b=mP7gke6ZJBFmEe1BizCLGSp94pPlRya+eqr2WU+n7PwG+M8BUonUkn7lys0s0J8GgE
         txBUm6Dn69LwcXUkVZUJ75Y8CbCo6GQZKiZ1ubn3Zk9cZ4LyMdLtBzvhx2mUTaqMSZym
         oFPovdLOCSX5m4y4KW7WhebuDSs7S/uNXRg5tfjPFUy4jakUaeQOv+L6qHGRwwfEwIED
         PlecZtOziJXjehMjEwBaTiJEwwPbiKsBtpdttjkOWVkiJRKWQob6+qOB40u6wcSPCHpZ
         ZooC0UPYL7MWkxWQ6HUJRdobNdRJlS+agEvtgo2OMQyVwQjloZ2XAvt0hILlRr5eoWnF
         lvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4VwoJ1zJjBeNWRXRl7eH9PlvLQXg51aHB8wQQ0uEcGuipJH9IYPggn8HRFioU5iAQntlJPJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTB81rFauniAVNeC6whY0iKLdaaq3trBxPAOTApgro6vBf0nX
	2NcbvIPzLbgOEVXh54W810dQugiNsyVLDPq91xM6bxAe4roUKzgU1aFb0iSzOH0=
X-Gm-Gg: ASbGncvnT0gNjvUHia1C+CqPp2PSLLThCGWhuKFKSwXHpyUhaRq688DQA9EjaBRjF1J
	xyg8Zv1DnnET0zPQs75eGG0M3ja8nVFDZehD4GOZ4WWbMV4bElFBPXPn3/DhdA8yLGtG6GdUN3s
	GG1nrgFeYMmjAOTi5FCJuOrD2TE9ojhnXFDR6JRKzS3VVqohprgfrY2AHz9RfRlrxsgARr8NR5y
	OpDJGzUV6DpMS6i42SeGfGERf0MIFsmjFzF1jDLkTSBR72nc0ber43XA90TjjOqD8XgwQ==
X-Google-Smtp-Source: AGHT+IHRzGHW/z8gUOplPboXdYVV+4IiRhE6gpyKdsdPPbJZQTNRRQWOF5az8I0Aaw1KP9NqS9LhjA==
X-Received: by 2002:a05:6a00:3a01:b0:71d:eb7d:20d5 with SMTP id d2e1a72fcca58-72d21f31848mr3590682b3a.8.1736330165656;
        Wed, 08 Jan 2025 01:56:05 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:8dac:609c:8660:55f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dacffsm35973908b3a.120.2025.01.08.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:56:05 -0800 (PST)
Date: Wed, 08 Jan 2025 16:59:02 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [RFC v4] wwan dev: Add port for NMEA channel for WWAN devices
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Slark Xiao <slark_xiao@163.com>, Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <EAIRPS.ENVJYU16CN9C3@unrealasia.net>
In-Reply-To: <c833b868-9593-43e9-b0e9-780fea1e8f55@gmail.com>
References: <20250105124819.6950-1-zaihan@unrealasia.net>
	<CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
	<3c7d38cb.5336.1943f5e66de.Coremail.slark_xiao@163.com>
	<T3JQPS.DLBZIVAM0L9Q2@unrealasia.net>
	<c833b868-9593-43e9-b0e9-780fea1e8f55@gmail.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Sergey,

On Wed, Jan 8 2025 at 01:42:00 AM +0200, Sergey Ryazanov 
<ryazanov.s.a@gmail.com> wrote:
> Hi Muhammad, Slark,
> 
> I should clarify here a bit. Export through GNSS does not mean 
> creating a dedicated PCI driver. It means call the 
> gnss_register_device() function to export the device to the user 
> space as instance of the GNSS class. This should help for 
> ModemManager as well to avoid the NMEA port access. Since the device 
> class will clearly indicate that the NMEA port has nothing common 
> with a cell modem control.

Yes, after reading Slark's email, i began to understand the 
requirements and i agree with your explanation since I use ModemManager 
and support for PCIe devices with MHI seems lacking in ModemManager 
compared to USB based WWAN devices because of the issue above.

I did not try to create a dedicated PCI driver, after looking at the 
code i was trying to allocate the device from the parent driver. Which 
didn't work.

Unlike most other use-case in IoT and Embedded, my use case is more for 
Desktop usage where interaction with ModemManager is important.

> 
> Still, as it was pointed by Loic, it is a good idea to call 
> gnss_register_device() from WWAN core in order to make the WWAN 
> device a common parent of the NMEA port. This should help user space 
> applications as well. A user space application (e.g. GPSd) can easily 
> find a control AT/MBIM/etc port to activate the GNSS functionality of 
> the physical device by checking the NMEA port siblings.

Which is what my patch was trying to achieve in wwan_core.c - with the 
wwan_create_port() function with this code.

+        /* NMEA check to attach GNSS port */
+        if (type == WWAN_PORT_NMEA) {
+                struct gnss_device *gdev = 
gnss_allocate_device(parent);
+
+                if (gdev)
+                        gnss_register_device(gdev);
+        }

This was what was suggested in the email by Slark. Maybe i am missing 
something. Do i need to allocate the gnss device with 
gnss_allocate_device()?

I see from gnss code that i need a "gnss_device" to be able to register.

Also this is a just a tip of the iceberg, i would have to look at 
deregistering the device - removal as well, along the way

> 
>> But the patch i'm giving does not work. (NULL deference err,
>> possibly due to gdev being NULL).
>> 
>> Just sharing on some progress i've made.
> 
> A small hint. If a patch is not going to be merged here and now, it's 
> good idea put "RFC" keyword in the subject. E.g.:
> 
> [RFC v4] wwan dev: Add port for NMEA channel for WWAN devices

Will do.
> 
> And another small hint. Use the bottom/inline posting style please. 
> It's really hard to read the email conversation backward.

Sorry about that, i'll follow the list etiquette from now on.
> 
>> I'm still looking at it and trying to figure out though.
> 
> It will be great if you will manage to create the discussed 
> infrastructure inside the WWAN core code. I've already promised Slark 
> to make a prototype, but have a hard time to find a time to do it 
> properly. Sorry :(

You mean a new function to pass the parent device, allocate and 
register?

Tried:

Modem PCIe driver <-> WWAN core <-> GNSS core <-> /dev/gnss0

I can work on this but i would need some guidance on what needs to be 
done. The gnss patch above i did was all the understanding i had with 
what Slark mentioned in this email. The gnss patch did try to 
initialize gnss in dmesg but it just crashes. No /dev/gnss0 device.

Eventhough it's not that urgent for me because i still can read gps 
data on the current setup but i hope to implement this for sake of 
completeness since USB WWAN support with GPS is already well supported 
with ModemManager. (mmcli CLI for GPS subcommands gets error all the 
time for my PCIe device but that problem's specific to ModemManager)

and since i have the hardware, so why not i try to implement to support 
it. ;-)

I think i'll figure something out. :-)


> 
>> On Tue, Jan 7 2025 at 02:05:38 PM +0800, Slark Xiao 
>> <slark_xiao@163.com> wrote:
>>> 
>>> At 2025-01-07 03:44:35, "Loic Poulain" <loic.poulain@linaro.org> 
>>> wrote:
>>>> Hi Muhammad,
>>>> 
>>>> + Slark



