Return-Path: <netdev+bounces-279729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIEcF2cg5mkMsAEAu9opvQ
	(envelope-from <netdev+bounces-279729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF242AEA2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D1893010733
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596212D7DDD;
	Mon, 20 Apr 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K6JyBKmb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35442BD11;
	Mon, 20 Apr 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689184; cv=none; b=sUeWMRI5eZK+HEf2we6tL2OQK3K5p/vgTUTfuGrmJ+dJ1RNOiWQrVppQ4MSuabMwxWXVQyXj5CsqNDxWiPbur8Qtv+LLIBmajmwxV26tcYhXuZtpzeLEi58QZfkPe/pjTztGg3S+aMw7PrZzJ03xjEwdLPrMBXE8A4iEvzQZ2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689184; c=relaxed/simple;
	bh=lxLsQbD1Kkcqnni8iApsDF5XQ1ROw/fxT+GNDupZLHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9uZmc4MeroNC1WSlRnmm7b2284L93O6lCF2ejJryP02Y3Kv/NHV8nlEP1cBYwjRY+P/MgvIE8RpH6eiDFXI22B0QT3PoW6fwXymV7CllYP0fByg43WUxlfyYciqyLFR12GweQ4pRCAJbXxevLFkSwtgVXICuhQt9ZBV5V22XFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K6JyBKmb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YXGOIIpEbeAk9/rcVFwREHyAE3XJQCKE4U994tpVsvY=; b=K6JyBKmbIdPE0Krs32QLqKQbE9
	ApS739uceETfRGR4ZfABaxibC7ypUUnHsmeViXxjpfhRkJHmUMSYMFSEsRVM+jiZ1lFL3uB/kADeR
	Ljmvcu3hLFIGeHyu5VhPde+w3GCNrop41C6oWqVRdhw17wQTnMvlR8IryUZVxfUk08k4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEo0p-00GjzM-CI; Mon, 20 Apr 2026 14:46:03 +0200
Date: Mon, 20 Apr 2026 14:46:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: hamachi: fix divide by zero in hamachi_init_one
Message-ID: <ea469046-79dd-4a6e-905e-ea2251ff303b@lunn.ch>
References: <20260418121804.149171-1-25181214217@stu.xidian.edu.cn>
 <e1d937ec-d909-4553-9f1e-c89f9b556d6a@lunn.ch>
 <2543c18f.5194.19da8c3b8d1.Coremail.25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2543c18f.5194.19da8c3b8d1.Coremail.25181214217@stu.xidian.edu.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62CF242AEA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

So what is your security model here? How did i get the hacked card
into the machine? If i have physical access, isn't it already too
late?

As far as i can see, this devices does not load firmware. Even if it
did load firmware from /lib/firmware, i need root to put a hacked
version there.

The PacketEngine Hamachi was in use around year 2000. It needs a PCI
slot. Not PCIe but PCI. Do they even exist any more? Both the card and
a machine with a PCI slot?

Maybe, rather than fix this /0, you should look around and see if you
can find any indication this hardware is still in use, and if not,
submit a patch removing the whole driver?

> +++ b/drivers/net/ethernet/packetengines/hamachi.c
> @@ -745,6 +745,14 @@ static int hamachi_init_one(struct pci_dev *pdev,
>  		   dev->name, chip_tbl[chip_id].name, readl(ioaddr + ChipRev),
>  		   ioaddr, dev->dev_addr, irq);
>  	i = readb(ioaddr + PCIClkMeas);
> +
> +	if ((i & 0x80) && !(i & 0x7f)) {
> +		dev_err(&pdev->dev, "Invalid PCIClkMeas value (0x%02x), hardware untrusted.\n", i);
> +		unregister_netdev(dev);
> +		ret = -EIO;
> +		goto err_out_unmap_rx;
> +	}
> +
>  	printk(KERN_INFO "%s:  %d-bit %d Mhz PCI bus (%d), Virtual Jumpers "
>  		   "%2.2x, LPA %4.4x.\n",
>  		   dev->name, readw(ioaddr + MiscStatus) & 1 ? 64 : 32,

If you do decide it is worth keeping the driver, please add another
label at the end of the function, and do the unregister_netdev there.

Could i also suggest you consider more likely scenarios. It is much
easier to produce a hacked USB dongle than a PCI card. Users plug in
USB dongles without thinking, where as few users plug in a PCI
card. You are more likely to fix security problems which affect real
systems if you look at USB devices. I would also suggest that / 0 is
not that important. But can you trigger a buffer overrun?

    Andrew

---
pw-bot: cr

