Return-Path: <netdev+bounces-285327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAmOGbyQ/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFD4E9133
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94AFD300130F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B23F1660;
	Thu,  7 May 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LR3/57vo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B13F54B4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159801; cv=none; b=IGzE67xRAADvfkvhOoCRgG5wLrMUhkbQy/nPI/Ue5+4UofbW9M7QXjh3ZFQkuOrNhsmEdllEbiikVZ4v/zPkYhClkc24L95JWhNc2YsqXw/eHy+jeg/eJ9esW3V3alVaB0x7XN5na4OiI7KZHLJPTeMn281q5HtyWeC0SLCh0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159801; c=relaxed/simple;
	bh=e2NO9S2CUv0l/kJNqVzdSn/oCiFZneGT+/6/s5hgRZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/vJQVVH4Q/Na9TBnxAAmu63E7dZiAQ8jE1WGRyFKUcziAlfg3xve7vjMP5nOeIYCS+wevIJgxuSAhMbYSkJ+CMxnoqUmPKQGB06Wk/T1fWpIoJTzVkPOOkxb8p1h3Thy1pQW7RRrsFzRYySf7+4yDiDzK9d0AEw0XTDE2FouYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LR3/57vo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5BD64E42C2E;
	Thu,  7 May 2026 13:16:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A976160495;
	Thu,  7 May 2026 13:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CAC9108193CD;
	Thu,  7 May 2026 15:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778159797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XODxyG0t34liTUxM6lR0h9aJjLL9z8JcMy1OM1KkZ8M=;
	b=LR3/57vo3wtfAcr5IQ61vpLoU4u/Tr0bWWTZEBy2a0gmvY9PSTfClfGLTLXYlXJY/L9z/S
	sfD5EImCF/jCxOvEYKFXkLP4UsEJg8ijSQMCOH4ZxIZiE4xCiyF2A42soz5S9KPkxq+fdo
	gn4gH6Pv9lrKk+ABxBmTnHWDZdRcseRea1RvavSqZh+tUYwrPYCgQPaEr/4GzphrKtN7H5
	0vlap56tEL0lSiRKnHmcKQrFhd/HKdNSJEDbzLq1YXLZAgRi7eoBKYk26xprMudzXdmjzH
	UyD9JDMaiORq5GMtyGYcI9So3T5aHBnOfeXHGyBQtO6dtbJowT0a3UaYwpbnTg==
Message-ID: <a43833c5-797e-4487-87c5-a489e12e730b@bootlin.com>
Date: Thu, 7 May 2026 15:16:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
To: Jensen Huang <jensenhuang@friendlyarm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A0CFD4E9133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285327-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,leemhuis.info:email]
X-Rspamd-Action: no action

Hi,

On 07/05/2026 14:49, Jensen Huang wrote:
> On Tue, May 5, 2026 at 4:26 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> [Jumping in here, as there are no replies yet]
>>
>> BTW, Russel, just in case you missed this: looks like this regressions
>> caused by a change of yours.

I think Russell is dealing with unpleasant personal stuff, let's see if we
can figure this out while he's away.

>>
>> On 4/29/26 14:53, Jensen Huang wrote:
>>>
>>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
>>> When a network cable is connected during boot, the DMA reset
>>> occasionally fails with the error message: "Failed to reset the dma".
>>>
>>> This appears to be a timing issue related to the EEE RX clock-stop
>>> logic. Based on my investigation with the RTL8211E PHY, I monitored
>>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
>>> value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
>>> clock may have already stopped.

From what I get, your current hypthesis is that it takes a while for that
clock to stabilize and therefore we're accessing the DMA registers too soon ?

Can you confirm that with the addition of a small delay ?

>>>
>>> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
>>
>> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
>> affected? This is something that is always a good advisable (some people
>> would call it required). In this case even more, as it since a while
>> contains a fix for the change you mentioned, that wasn't backported:
>> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
>> enabled"). But this is not my area of expertise (and in different area
>> of the code), so that fix might be unrelated to your issue.
> 
> Thanks for the pointer.
> As you suggested, I have tested the mainline and confirmed that the
> issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
> I verified that the issue persists in the latest stable v6.18.26.
> I performed a git bisect and the result pointed exactly to the commit
> you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
> when VLAN is enabled").

Do you mean that c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
when VLAN is enabled") introduces the bug on 6.18.26 ?

do you have the possibility of bisecting to verify when exactly the issue
was solved between v6.18 and v6.19 ?

Maxime



