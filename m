Return-Path: <netdev+bounces-234670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C2C25DD9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE58423DCC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDA2DECB9;
	Fri, 31 Oct 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvvuLBX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CSaLgj5u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N1VBlHlW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C3ibAOSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24812D3A75
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924941; cv=none; b=ieZmaX2JrzzzNY/AMyVEcBMNnjhtC/CmCvtX8QHUWy+npb6/tZ85n1cbE/yqxIknCGyG2yHWlvQmilGsB+cgKzl0zyRMadXYlkQR/GzYpw+nmHgDaysns+xCqeKvpaKaXXEKMMAwxMhx5DPDrrXc+Jd+v6+j4Byr4CJ3OrQfLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924941; c=relaxed/simple;
	bh=u1H8y8Vd7BNxaixOkx1N50pHvue9IBSpzBkkFlBBc7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuDnieOE1RDuDxWe95zkuYEIRgQHo7a+3ffS2C+2qWUDgLv6McEIwabQ0EL+0Rm5rSsiVFbmBvvG8DFppdiU2iQgih9Of8ZTKuvKevHlckS5QLqKO0eBSFoNiHPQ76kGYiDhLcthJBXmWlV3rmhd4av/+0It1VrcD259RmfYpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jvvuLBX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CSaLgj5u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N1VBlHlW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C3ibAOSu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAFFD22060;
	Fri, 31 Oct 2025 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761924938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTrayXkWBQ243Fr06I9R6N8F/Dz2fVCExTzhLcSW7QA=;
	b=jvvuLBX6eRZdWnDxZUWCLDdwDqCQxJPndp0Js5OViRrYAsZXgJYFQgSYsvXUFmNuj+0n0x
	Q+sIPjS8dN4Sid6iNm3HqhQNVsI5EB5MFdMvQqOhYCtKb5u0clrJj6TLT9CluOghoKHJGt
	iVQRwIG8q5wdeYfSSN177UKJEP5a88g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761924938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTrayXkWBQ243Fr06I9R6N8F/Dz2fVCExTzhLcSW7QA=;
	b=CSaLgj5uB8ub8e3FaH0J8twmCDxYJoejo1OmiZBQDlZhn567tL9cApOsAODybbc30je3Ld
	Dv02ulfmJqe4WzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761924937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTrayXkWBQ243Fr06I9R6N8F/Dz2fVCExTzhLcSW7QA=;
	b=N1VBlHlWxGpseLfy8E7f7YYKtHURzfK4Be2EB539ih///9PoZp+V/WvmdhebUx8r746z2h
	NavdJ/iMupKJcxLHVs90DW1lvqlQzT4R5DDV3avDnDG4a++7Y5gWNMo/VfY4t4TAyQCKvG
	PwIJunSb5PP5KyrTDkUcgoYeTg//6y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761924937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTrayXkWBQ243Fr06I9R6N8F/Dz2fVCExTzhLcSW7QA=;
	b=C3ibAOSuwE0e3RVd590Zly7JfAteqpmrYBGX/qBahRWUX+DcZQvqN2ttiM/l3iF4t7zhyf
	kYh2gK8WTJUUkjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5946413393;
	Fri, 31 Oct 2025 15:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oiw2DknXBGn+SwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 15:35:37 +0000
Message-ID: <eef9a83f-6103-4ab2-927c-921dd9a6a5b3@suse.de>
Date: Fri, 31 Oct 2025 17:35:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20251031114518.GA17287@pendragon.ideasonboard.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20251031114518.GA17287@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt,netdev];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi Laurent,

On 10/31/25 1:45 PM, Laurent Pinchart wrote:
> Hi Stan,
> 
> On Fri, Aug 22, 2025 at 12:34:35PM +0300, Stanimir Varbanov wrote:
>> Hello,
>>
>> Changes in v2:
>>  - In 1/5 updates according to review comments (Nicolas)
>>  - In 1/5 added Fixes tag (Nicolas)
>>  - Added Reviewed-by and Acked-by tags.
>>
>> v1 can found at [1].
>>
>> Comments are welcome!
> 
> I'm very happy to see support for Raspberry Pi 5 progressing fast
> upstream.
> 
> I've tested the latest mainline kernel (v6.18-rc3) that includes this
> series (except for 1/5 that is replaced by
> https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.com/
> as far as I understand). The ethernet controller is successfully
> detected, and so is the PHY. Link status seems to work fine too, but
> data doesn't seem to go through when the kernel tries to get a DHCP
> address (for NFS root). Here's the end of the kernel log (with the
> messages related to the USB controller stripped out):
> 
> [    0.896779] rp1_pci 0002:01:00.0: assign IRQ: got 27
> [    0.896809] rp1_pci 0002:01:00.0: enabling device (0000 -> 0002)
> [    0.896840] rp1_pci 0002:01:00.0: enabling bus mastering
> [    0.931874] macb 1f00100000.ethernet: invalid hw address, using random
> [    0.944448] macb 1f00100000.ethernet eth0: Cadence GEM rev 0x00070109 at 0x1f00100000 irq 95 (da:2e:6d:9d:52:a4)
> [    0.989067] macb 1f00100000.ethernet eth0: PHY [1f00100000.ethernet-ffffffff:01] driver [Broadcom BCM54210E] (irq=POLL)
> [    0.989272] macb 1f00100000.ethernet eth0: configuring for phy/rgmii-id link mode
> [    0.991271] macb 1f00100000.ethernet: gem-ptp-timer ptp clock registered.
> [    4.039490] macb 1f00100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control tx
> [    4.062589] Sending DHCP requests .....
> [   40.902771] macb 1f00100000.ethernet eth0: Link is Down
> [   43.975334] macb 1f00100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control tx
> 
> I've tried porting patches to drivers/net/phy/broadcom.c from the
> Raspberry Pi kernel to specifically support the BCM54213PE PHY (which is
> otherwise identified as a BCM54210E), but they didn't seem to help.
> 
> What's the status of ethernet support on the Pi 5, is it supposed to
> work upstream, or are there pieces still missing ?
> 

We have this [1] patch queued up, could you give it a try please.

[1] https://www.spinics.net/lists/kernel/msg5889475.html




