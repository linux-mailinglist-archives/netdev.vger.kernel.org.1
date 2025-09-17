Return-Path: <netdev+bounces-224000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3EB7D9B6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6EA16826D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7052337EBF;
	Wed, 17 Sep 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HkvugRbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603043164
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111928; cv=none; b=UP4br9PxuAoc9JJjrnVPof3s5F8UG1xPbLZLn5oZtVSuZMN0z+VD3rD44INnso+zc/+gDnaa9w2f/Rx+Wc2zECJuWEnmGbuPgkW0NQvD1DFXPCgrMmrqFUR62xGuzJwnZjx6qRHebRZ2czGn1zlPb5i9tlVq6DJ/gTO9McK/X+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111928; c=relaxed/simple;
	bh=hfGHEKj+Li5C+SsyBXQ5+0EUnOsVD4wRyx9sD6DmIzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/i269W103g8ADbYSSkIIh0BzCQWdSkbHRDDnqTtks7XknrKtUF3/HjtR3qY6k4WmeHdoGaDlu1co9CjDzDrnzGH/XYndeylwJBJkFyvLV5eTPhjfbt2a8LYSBBnrpyJbopLalO0QhPgcsRsim0+YDLxkVbUSgefuAKDUjZtp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HkvugRbS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b042cc39551so1098652966b.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758111925; x=1758716725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=HkvugRbSmQmsWNuWVrAIphvTAX3krdROP5+PXI5WRJcjaLKIqKeq11+pC8XtbO+A6t
         V+1clxw0GB+epCvnHcel8Lc4rw2OJouRl/biHaZJ8D4WIlzbZbKvNiGNWU7Qmcz3UwOu
         dQh4lAmSfzYWwB40jY2LsMtGsfN+YME+lR4VuzjezFYN1VbQ5XUbPs4n+XCwDqPoNSJk
         BEl6bLpDtpaqOKpuYSUktVkk+PdUZZCQMRtAe4TZ7fddhBYwl6klQQD8GnRNii5LzmoC
         zK+w2rbylUl3m63IR4lNSV+g75AiwgsON8A+OJHv6VNFXeP4vkwMKAEipZePkgOmx7od
         dg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111925; x=1758716725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=QLHgDWtQdCUsJXNhTzRBy3o9XH5qM5NFeiklx32bEhEDOMgUfxK8JUaUpbmxyrpYrt
         +8osb8S6nXyo2ciCoPO3x1DW6StOkWozvcXtWarfwUi96ZdUV+8b40yFC7oYBHb75fss
         3vThgja4pJDZjKPsDcvA/nsAr5coxA497WNul4ale8EpT8XEaX+lSUfG22b5PcZgtSYB
         8DcVh8tIihVfbF8+5QCIg1mXWXaAmImXH7h9a2BlzdaELl0yPNa4xX+YzywHnSUPmHXW
         9AB323sF64DMcBU3jU6TkGIEL1KsGzkx4iQ1C4a+hYLr5+BvnttJCkGoH8U9Fb4rTRYt
         Nhyw==
X-Forwarded-Encrypted: i=1; AJvYcCU6MwYk4w9MCjr6U9oK4gsN97mjXfe2m3719wr7N2JIse2gcV75h9TD9kSDBNj6HGmAcgwtz3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJ2KgmHnjjjj0YotYA1PM01/DJSdmkCdd0RP2W1UKELv1YDi3
	Tn5CxByn1D/lPEILXkfbOc/XoFrH1J6LPt3ASqz6BDipBLsG6M0uF4RDWfN5XQdsWCnj3e9VAXx
	oPW3wgh4=
X-Gm-Gg: ASbGncszuvpKOyY1b6YdIxypJrR+8nhanyCi0WUmFkvuV4SdfE9lCeuQqOjXAzw0LeS
	T55mfHVSbUBshfx3uvk/cHJd+Rkz8rIueZS9xnwjOEUyKyqGzHHXwqOfCgJqDv76F5RIr3ml+uQ
	l/5TOFAGl4+HYKBMXSmFG340pPusqsVtMxoVTKahmDfUcwsd+Rv9jac+uKuSUrrUuRKDAUeDFHu
	91d/ycirKyZl2rSyNcN8aVJViLuufGiH8svfunBcISdzNcS8OQ45kGcSUlmbtWGDbVrZODatibx
	yChEYNY97crfqDnhh9uXpfOxgFEYec18U3I2sAaXafpbtXJXAq2TgkFxEyq9GL/2Nf/ir9oCRPL
	RoZSlE0jxkv47rphA/3ss5pOvShN2ZnEus4dw7UABKtjJkMAPwZ7lW6HgHu+wXojO
X-Google-Smtp-Source: AGHT+IEMHO2+mrGwehsjHQd9adkafh7FOklixGAh9piZ10AcM2OldRJUtx+VWHX506OwdEOot1gHeQ==
X-Received: by 2002:a17:907:3da0:b0:b07:b645:e5b8 with SMTP id a640c23a62f3a-b1bbfa2bb35mr217910766b.30.1758111924771;
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f1989123fsm8515308a12.37.2025.09.17.05.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Message-ID: <cae31224-95f2-4c62-bdb5-1e1e81f2b726@suse.com>
Date: Wed, 17 Sep 2025 14:25:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
 <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.09.25 13:52, Oleksij Rempel wrote:
> Hi Oliver,
> 
> On Wed, Sep 17, 2025 at 12:10:48PM +0200, Oliver Neukum wrote:
>> Hi,
>>
>> On 17.09.25 11:54, Oleksij Rempel wrote:
>>
>>> With autosuspend active, resume paths may require calling phylink/phylib
>>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM

This very strongly suggested that the conditional call is the issue.

>>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>>> and poor test coverage (autosuspend is usually disabled by default in
>>> distros), forbid runtime PM here to avoid these hazards.
>>
>> This reasoning depends on netif_running() returning false during system resume.
>> Is that guaranteed?
> 
> You’re right - there is no guarantee that netif_running() is false
> during system resume. This change does not rely on that. If my wording
> suggested otherwise, I’ll reword the commit message to make it explicit.
> 
> 1) Runtime PM (autosuspend/autoresume)
> 
> Typical chain when user does ip link set dev <if> up while autosuspended:
> rtnl_newlink (RTNL held)
>    -> __dev_open -> usbnet_open
>       -> usb_autopm_get_interface -> __pm_runtime_resume
>          -> usb_resume_interface -> asix_resume
> 
> Here resume happens synchronously under RTNL (and with USB PM locking). If the
> driver then calls phylink/phylib from resume (caller must hold RTNL; MDIO I/O),
> we can deadlock or hit PM-lock vs MDIO wake issues.
> 
> Patch effect:
> I forbid runtime PM per-interface in ax88772_bind(). This removes the
> synchronous autoresume path.
> 
> 2) System suspend/resume
> 
> Typical chain:
> ... dpm_run_callback (workqueue)
>   -> usb_resume_interface -> asix_resume
> 
> This is not under RTNL, and no pm_runtime locking is involved. The patch does
> not change this path and makes no assumption about netif_running() here.
> 
> If helpful, I can rework the commit message.

It would maybe good to include a wording like:

With runtime PM, the driver is forced to resume its device while
holding RTNL, if it happens to be suspended. The methods needed
to resume the device take RTNL themselves. Thus runtime PM will deadlock.


	Regards
		Oliver



