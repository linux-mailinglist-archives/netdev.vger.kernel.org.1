Return-Path: <netdev+bounces-280107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCKHMphu52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9C43AA67
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 636EB300404A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A33CF68D;
	Tue, 21 Apr 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vMkJyLSA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267D3CFF5A;
	Tue, 21 Apr 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774770; cv=none; b=hq2w/t8k+ouoF+pCHGtr/GYPOjfpWYTmeVNbRbqbqXZof8PeADZKKEAC0E76E/c572at2ZfW/CjZud57hmd+adcOw4H+uZr2MZ/M4xQF3uWFPMPIK69JORFWQUs53iWwbJMXXPgaN30UABdo3/Ws3WhmomU9XFXIttoAIymg0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774770; c=relaxed/simple;
	bh=FQUyXWQVM+YuNW8hLLBN8C1mr41Ou4vkDSJGr7RLI9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLpvOYHRMBsUo4/qSBRYacEe4+sbvDVcahlTVqvU/6+2IAe2fWJzuAg9UOZuK3qgLJIvif5P0IzFfW5JstDSc2ODugLk70Yaf3XnCE2PIqXwknIEdjTs7cIYfSWlVISCqfybiqRbVs3a1Epq0WDyjOfk9Pqg1rUiakf3Ev8BY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vMkJyLSA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CojY5epJaQHYMuXOD58raOu9GZcCKSAkFBErgdsKqzg=; b=vMkJyLSACrqDGk0E6dZD9O6Sel
	3YP3mNz+cFkpY3YFQeOgFN+VEloUfxeVW2GXShT0qwMXQZhET/orScLl79PLywjrAg0XdXJhRhBer
	vLpeO8hyHEFqg718LVxzbA7YMD8beYNwtweUzwmrTSnBG4nvmGczpxvwGH9yoph2gHUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFAHI-00GtKR-VM; Tue, 21 Apr 2026 14:32:32 +0200
Date: Tue, 21 Apr 2026 14:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: petkan@nucleusys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Zhan Jun <zhanjun@uniontech.com>,
	syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: rtl8150: fix use-after-free in
 rtl8150_start_xmit()
Message-ID: <e64d95d6-817c-480f-8205-525f407279eb@lunn.ch>
References: <73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280107-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,3f46c095ac0ca048cb71];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: CCB9C43AA67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 07:04:12PM +0800, Morduan Zang wrote:
> From: Zhan Jun <zhanjun@uniontech.com>
> 
> syzbot reported a KASAN slab-use-after-free read in rtl8150_start_xmit()
> when accessing skb->len for tx statistics after usb_submit_urb() has
> been called:
> 
>   BUG: KASAN: slab-use-after-free in rtl8150_start_xmit+0x71f/0x760
>     drivers/net/usb/rtl8150.c:712
>   Read of size 4 at addr ffff88810eb7a930 by task kworker/0:4/5226
> 
> The URB completion handler write_bulk_callback() frees the skb via
> dev_kfree_skb_irq(dev->tx_skb). The URB may complete on another CPU
> in softirq context before usb_submit_urb() returns in the submitter,
> so by the time the submitter reads skb->len the skb has already been
> queued to the per-CPU completion_queue and freed by net_tx_action():
> 
>   CPU A (xmit)                      CPU B (USB completion softirq)
>   ------------                      ------------------------------
>   dev->tx_skb = skb;
>   usb_submit_urb()      --+
>                           |-------> write_bulk_callback()
>                           |           dev_kfree_skb_irq(dev->tx_skb)
>                           |         net_tx_action()
>                           |           napi_skb_cache_put()   <-- free
>   netdev->stats.tx_bytes  |
>     += skb->len;          <-- UAF read
> 
> Fix it by caching skb->len before submitting the URB and using the
> cached value when updating the tx_bytes counter. This mirrors the
> fix pattern used by other USB network drivers.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69e69ee7.050a0220.24bfd3.002b.GAE@google.com/
> Closes: https://syzkaller.appspot.com/bug?extid=3f46c095ac0ca048cb71
> Signed-off-by: Zhan Jun <zhanjun@uniontech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

For future patches, please could you set the subject line correctly. See

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

