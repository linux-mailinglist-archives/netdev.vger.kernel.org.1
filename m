Return-Path: <netdev+bounces-282661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABNvKFjs8mltvgEAu9opvQ
	(envelope-from <netdev+bounces-282661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7149DAA3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83CC130086C3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7936B048;
	Thu, 30 Apr 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCe3yhRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B08322768
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527889; cv=none; b=uVYLEEuQOePDox2a52lz9G1AWqOXOE1e4+WLbppX0tFZctlKSQilBrkVLvm8Y/altJw066e/N/sUujR1bNdyvjBvMyxGoQLaJMzkVf6QTmnhIggjOnSLMbxrmPw+4vKtoDeryZZIvCPp2sb1BTakx83VwKdYRmmb/JQsmVYojh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527889; c=relaxed/simple;
	bh=+zOn1HuPz/QRR2c3ttXpLREXaufzwdHeGeeYYsO4oyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGk/d1TsPrcMDOlf7apYFbgvpRnhQhp9H/Gs8GER8/8/TmztQ9UeGkwr46o8+hdJabCjYe5R4qv82A4QJ+8IuK4YxqxgIjv2b4lKVw6QtuEECC/xJ3mW+zf3CxRyfDd2pZD2ue6CXRzcNg6YvMY55J43aCmYV2dc4nWdZXLF6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCe3yhRQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dfb789d7fso4393491fa.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777527886; x=1778132686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GzixCwTpQHWHlB65KJEzMOkrrN2puCUVkU1mM/Uivk=;
        b=jCe3yhRQ9CsLj+T3i0B9yvXKExLa+xO/Y/2rXEgWBKHf3BFuU124JrVO1R7fxe8MiM
         aOlOYGWQAdRgyKP17rh5ZkY/e47NbePCvv4gUX9uR3bn6uqaWtCxzxJuqRYVxw8tYqk5
         nc5YYgHgpfVgWrnAU6AzrHWw1zp3iSW6HBsNe/y3uDDZ+IfGkkuQb0N8YZBwNFTOuEy8
         xO1hRttodc2V2PlLibOOcM2U+0+sXhyieLF4z/fAREu/W0BjmsecRbHq0sTm0T2XhQ6F
         7YfRHamZygfATL0//VBYVaj9Mp88sAV7vTbXlplmZXcGxBrhXvmFKsmnibQ7wos/VnKZ
         L7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527886; x=1778132686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GzixCwTpQHWHlB65KJEzMOkrrN2puCUVkU1mM/Uivk=;
        b=iPptdy3AjOP9Jc2R5CE/g1xd99y/rsVYkhYjA0Sk4UIyDQ+J5NXPEz6+C12b05+Vil
         /T9NATPIkf02Hsn8jftSoxzRA1ef+dEMuqosRaFM0vH4X6fDZJriOHa64HZjO4QUS/9G
         2Nxm0Lt6JgT5elNb+ArmBFU2fVuh/eYop4v9rmAFa6mnOEtAFcgXmWr7nZ36QsBu++Gw
         r+HR4HeKMCgdx1445ANOci1Pfiij66TqZi/DEd+gebHW2DqmB+m/erFKCFDNgsN++JZj
         2Dfc9CkRlx9/Tn88FRqK6kwdqWrhhaXQr2f2+RdnRiresTHSu34vDTCoKsspf4nyPzRB
         4a1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+WkdduXEocjVUaBm1D/Uz66onm7nOG8ZuXiXrztwjGYKYBIt8itD788vVPfqeqqrS24CRql3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWs/zMJIe+xcAivfRdYonbBAFRRWduDULpBvIOOUuQ6jZ31+I4
	Tuhaa7L3Uy9WIAiUKr0F+e3+Aafq2Nc7EZIIVue1RkcggX78TvRPAIRt
X-Gm-Gg: AeBDievZ8sGZG/5bnB5EOMGe/ChZtZw07WJYzOwIktU0nIEFG5YuczMZGTsrTw2jw8a
	tiK8lPBGBv9b1r/TF4homuAqwFjdQUNAGfcb7JgdNAf+EMHn0X7TarGtiVjyue6uJn3tYmGjArT
	CuOwf3PjvOu41NWowCQLabVnYDY+7Cho3oqF281SEAPNx+lMaGb8Z95emhR6aT7lg+lDGl2EdFt
	oktoJ47qgI3nTDuvnomsyEaSEywpBpWUajthGVW4nlujChz/du3rCHskaHMbdmjkpGh/pXIawLi
	X6LUYjljxtzSGICTH8TFG7HxJrjGDyVyqDajKOjBoI2JLQJDsAoIjXn+vfaFobpZC66F6zMn8d2
	78UWyIYfsONCFWfPf2sSIyjvo7rfqaFLVwKlhxhsRT/QvprLfPMJdVKZDXEH2g6mEKPNm0zb/CX
	gVxpLOAJ8rM/u9pNviTeb+ozTvp5s1buxV4v154mYsktA=
X-Received: by 2002:a2e:8a87:0:b0:38a:2776:1484 with SMTP id 38308e7fff4ca-3934e30721cmr5154621fa.28.1777527885318;
        Wed, 29 Apr 2026 22:44:45 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3934f7ad0a6sm2732741fa.1.2026.04.29.22.44.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Apr 2026 22:44:44 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:44:41 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <20260430074441.203192de.michal.pecio@gmail.com>
In-Reply-To: <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
	<20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
	<06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
	<9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
	<20260429200214.3e8dee67.michal.pecio@gmail.com>
	<4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F1D7149DAA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282661-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 05:36:06 +0200, Birger Koblitz wrote:
> Thanks Michal, for your explanations!
> On 29/04/2026 8:02 pm, Michal Pecio wrote:
> >>> What does interrupt mitigation do?
> >>>
> >>> Is this a different name for interrupt coalescence, where the MAC
> >>> delays interrupts for a period of time so more packets are in the
> >>> receive ring when it does interrupt, so reducing the number of
> >>> interrupts, and bigger bursts of packets are processed at once?
> >>>      
> >>
> >> I do not understand what the mechanism behind this is, there is no
> >> more documentation in the original driver. I experimented with this
> >> for some time and the effect that I see is that it prevents
> >> interrupts after shutdown.  
> > 
> > What do you mean by "after shutdown", driver unbind? You shouldn't be
> > seeing URB completions then if the disconnect() method unlinks them.
> > And if it doesn't, completions may be using driver data after free.
> > 
> > Or maybe you have pending URBs while calling set_configuration() or
> > set_interface(), which is dodgy too but at least not asking for panic.
> > 
> > Other cause of ESHUTDOWN might be serious host controller failure, but
> > you would likely get other log noise with that, at least with xhci.
> > 
> > What shows up if you repro with this enabled?
> > echo 'module usbcore +p' >/proc/dynamic_debug/control
> >   
> 
> With shutdown, I meant shutting down the driver: the error happens when 
> unloading the driver using rmmod, e.g. when testing different driver 
> versions.

Sorry, I remembered wrong. That UAF problem only applies to control
URBs on endpoint 0. All other URBs are removed by USB core *before*
rtl8152_disconnect() is called. So it doesn't need to unlink them
and it cannot predict when the URBs will be nuked by core.

> What I see when turning on debugging is this:
> [373042.499758] r8152 2-1:1.0 enx88c9b3b53125: carrier on
> [373104.440114] usbcore: deregistering interface driver r8152
> [373104.440141] xhci_hcd 0000:0c:00.0: shutdown urb 000000005501f8cc 
> ep1in-bulk
> [373104.440146] xhci_hcd 0000:0c:00.0: shutdown urb 0000000066ae4a92 
> ep1in-bulk
> [373104.440148] xhci_hcd 0000:0c:00.0: shutdown urb 00000000e9728025 
> ep1in-bulk
> [373104.440151] xhci_hcd 0000:0c:00.0: shutdown urb 00000000fa874ca0 
> ep1in-bulk
> [373104.440153] xhci_hcd 0000:0c:00.0: shutdown urb 000000006006ed5d 
> ep1in-bulk
> [373104.440156] xhci_hcd 0000:0c:00.0: shutdown urb 00000000a5bee1e7 
> ep1in-bulk
> [373104.440158] xhci_hcd 0000:0c:00.0: shutdown urb 00000000bc3a3ab0 
> ep1in-bulk
> [373104.440160] xhci_hcd 0000:0c:00.0: shutdown urb 0000000080a63692 
> ep1in-bulk
> [373104.440163] xhci_hcd 0000:0c:00.0: shutdown urb 0000000025af4e6e 
> ep1in-bulk
> [373104.440165] xhci_hcd 0000:0c:00.0: shutdown urb 0000000056d7e76e 
> ep1in-bulk
> [373104.440472] xhci_hcd 0000:0c:00.0: shutdown urb 00000000d8814536 
> ep3in-intr

And that's what happens in the log above, for the reason below:

[  +0,000015]  usb_hcd_flush_endpoint.cold+0xa/0x23 [usbcore]
[  +0,000050]  usb_disable_endpoint+0x52/0xa0 [usbcore]
[  +0,000048]  usb_disable_interface.cold+0x3f/0x4e [usbcore]
[  +0,000038]  usb_unbind_interface+0x138/0x2f0 [usbcore]
[  +0,000048]  device_release_driver_internal+0x194/0x200

> [373104.440790] r8152 2-1:1.0 enx88c9b3b53125: Stop submitting intr, 
> status -108

So this message is harmless. I'm also seeing it with RTL8153 if the
interface is up at the time of rmmod.

> In the past I have also seen the following, but am not able to reproduce it:
> [371283.534041] r8152-cfgselector 2-1: USB disconnect, device number 25
> [371283.534470] r8152 2-1:1.0 enx00e04c680023: Stop submitting intr, 
> status -108

Apparently the disconnect message is logged before calling
rtl8152_disconnect(), so that's probably harmless too.

I'm not sure how tweaking some HW registers prevents it. Maybe it
causes the HW to complete the URB (but why?) at the right moment so
that it isn't pending during usb_disable_endpoint(), IDK, weird.

Regards,
Michal

