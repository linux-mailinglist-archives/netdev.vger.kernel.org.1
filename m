Return-Path: <netdev+bounces-99749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F258D6327
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3491C23FB7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A3158DB1;
	Fri, 31 May 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAvRLJD4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977D158DA0
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162611; cv=none; b=a8xXvVKWyoKes4jagYz7kwgaEPsJNxmuY1qGNVCzhnYlhA1jW6yDsBO6ubCOX4tq5SFxjb/6DYUWw/gBBFqkqL1ru/an5Gcp9Lf1Hl1tvj/omblI08XmlqcnJsslQ0snWIDbybHkJyR9MaVH4BqEJ9nkBFkCkCIu/DjVVCgbEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162611; c=relaxed/simple;
	bh=fHZWsCZgLehsBmHUlJSI0XG6+oxgaHq5c/G9th2fkKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0ys/slujG58H7+/J2oLkaf2kzAP8tGg0wEQRxNrRR8FriHaRKBvj5cq2JneiqyqBEgGzokUHEhMG1olc4YwhlWTWZujcbOxjC9R6Z4AN8akdxt5zSTRcQSMK4r3/JQOdzkFwpf2Vna7tLjpXrbeiARARy4Y+Sdc2KfolNxMdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAvRLJD4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717162608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiMkkJB35GmuPxh7rMmIJANRZ/YYuyNN0vLhNarAFs4=;
	b=hAvRLJD4Z8aUAMYU/o9YSpblpLjWo1sT4/TAQIrkZHwKoFhFwDD2AhL7g/57JRark6QEcR
	pWPD9taMYnXGyO4S+sV0ZEIN8R66JqjGkxDkwKodmX7Mc85wB1Ue1cVvkrIbsh3VlXC9fz
	wFzNhfoHxKJAXzwIOBdPxxnA/xiG5s0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-aWC-bGuhMaqNRZl_Gz-zEg-1; Fri, 31 May 2024 09:36:47 -0400
X-MC-Unique: aWC-bGuhMaqNRZl_Gz-zEg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b84359026so771199e87.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162605; x=1717767405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiMkkJB35GmuPxh7rMmIJANRZ/YYuyNN0vLhNarAFs4=;
        b=aBuAPd65mcCzTxrJerZ/kizEYtlKngVCM9AvP66/W1zJpCxlseZgH+Yoepvtr0Rz5d
         oXccrrtO6AsN0P/Q9uXZtZMsgCgSyQoN1Y88nuvPlN+500Sf+uD0ow/O4aeP7LXex8va
         wRIKdZOsBsrybwot4d3/LuIQJzrOXQaIv0izn621cy4TpSS7S5Ay2ghUbLJHGzzxOVzT
         ATSN1ivwKjUYtCGCCpusbmfw3TDZJCkgYnwf6lYm0SE0LO14bWp2GpA4xmMdapWPNhEV
         ilcAbuHkClH1r2zBl1WV0ESeCq+tbXdnLZ0lqQB0NI/dcM6mPpzHwvQqjt2nlsVVbauE
         CeUw==
X-Forwarded-Encrypted: i=1; AJvYcCXfM+kiVPdX7CAhItLsUzveKRmmydA/L4l7zdAsHXF6jZ4ZPgyH9H3Nsmw8PT6C+/JrZ8ZioYRvW+L8ero/Fc5bWC/YIUIU
X-Gm-Message-State: AOJu0YyLYl7obYSoYqlHxfynbaHLXA0wtZ8m9ZURfoKZ5YPF3bxIXjw0
	up/B89ZguHdv+xuwlX3XWfqAfM+ngyD5uuxVMi23MOtzwFsALRXIhAuvcf1HC3gUsfn6ezO7T76
	XQ213+njW/Y/QkCjCO0mM95ovG+H6UYGPNQaKp6EdOfBrZQJ9AVQlrA==
X-Received: by 2002:a05:6512:4ce:b0:52b:7a5f:817f with SMTP id 2adb3069b0e04-52b8956b5bemr1133058e87.19.1717162605718;
        Fri, 31 May 2024 06:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEro17MUNy0FfJuJni5QfWCgWFnnZ+g2Nai9cZuxNwB9y0ZSsPWHEN4eW5raMCs3pl5xLc2dg==
X-Received: by 2002:a05:6512:4ce:b0:52b:7a5f:817f with SMTP id 2adb3069b0e04-52b8956b5bemr1133036e87.19.1717162605234;
        Fri, 31 May 2024 06:36:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d4b6sm1005484a12.74.2024.05.31.06.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:36:44 -0700 (PDT)
Message-ID: <d8341ffe-c0d9-4a37-869a-956cc1425f74@redhat.com>
Date: Fri, 31 May 2024 15:36:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hung tasks due to a AB-BA deadlock between the leds_list_lock
 rwsem and the rtnl mutex
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Linux LEDs <linux-leds@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johanneswueller@gmail.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Genes Lists <lists@sapience.com>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
 <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
 <42d498fc-c95b-4441-b81a-aee4237d1c0d@leemhuis.info>
 <618601d8-f82a-402f-bf7f-831671d3d83f@redhat.com>
 <01fc2e30-eafe-495c-a62d-402903fd3e2a@lunn.ch>
 <2a6045e2-031a-46b6-9943-eaae21d85e37@redhat.com>
 <e6800715-6bc0-49a0-bd00-5a75b852ea9d@lunn.ch>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e6800715-6bc0-49a0-bd00-5a75b852ea9d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/31/24 3:29 PM, Andrew Lunn wrote:
>>> drivers/net/ethernet/realtek/r8169_leds.c:	led_cdev->hw_control_trigger = "netdev";
>>> drivers/net/ethernet/realtek/r8169_leds.c:	led_cdev->hw_control_trigger = "netdev";
>>> drivers/net/ethernet/intel/igc/igc_leds.c:	led_cdev->hw_control_trigger = "netdev";
>>> drivers/net/dsa/qca/qca8k-leds.c:		port_led->cdev.hw_control_trigger = "netdev";
>>> drivers/net/phy/phy_device.c:		cdev->hw_control_trigger = "netdev";
>>
>> Well those drivers combined, esp. with the generic phy_device in there
>> does mean that the ledtrig-netdev module now gets loaded on a whole lot
>> of x86 machines where before it would not.
> 
> phy_device will only do something if there is the needed Device Tree
> properties. Given that very few systems use DT on x86, that should not
> be an issue.

That is good to know.

> So only x86 systems with r8169 and igc should have the
> trigger module loaded because of this.

Those are very popular NICs though, so that is still a lot of
systems.

> It would be good to understand
> why other systems have the trigger loaded.

Actually my system has a RTL8168 ethernet NIC so the netdev trigger
getting loaded there is expected.

> However, as you say, this
> will not fix the underlying deadlock, it will just limit it to systems with r8169
> and igc...

Right, given on the above discussion I believe that it likely already
is limited to systems with Realtek r8169 or Intel i225 / i226 NICs.

Regards,

Hans




