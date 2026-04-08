Return-Path: <netdev+bounces-276356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M3wKAYT1mngAwgAu9opvQ
	(envelope-from <netdev+bounces-276356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:34:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09A3B91BC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7496300863C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629E3A6409;
	Wed,  8 Apr 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p77gfSBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D33A2548
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637230; cv=none; b=BjKLJZ9Irqnr7UEQm97IanApymbvP3T/B4JhqfehdWZ/Og7rC6TmiL8X4nW+T08+bHUxu9/C/IIvBLZyJ6kFQoFBlJ2sZy0W7n1b5xsxatL7xjVIMFEzUq1a5uZHDLE0s1JPCM9FuMGZjHQEdAkzAwS9iP3dLVVlZJcCJhWK3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637230; c=relaxed/simple;
	bh=OKjKmjKCU62uaCjhibuDqhSE1AGMzLcspem2OqAtVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXRB6QGYO+QLcXpXYFpMcuaWGRzlIfp7dUE161E1SB4oeeHNICWgcPsZ4l6RSvc/cRTMQKclYXbcvLZFKkph9W9l05X+eXyxWEieTpNSUR2mEmHylMWtGPQyUEuy/gSDF/AbjZPDmIAsk8YfKaTDWK3P0CBRbGnXyQYbM0UZKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p77gfSBu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488971db0fdso48094515e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637227; x=1776242027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbj1pinyLCpTvRMDqb5wMltAGKRQ0z6dfcrCaaij6ks=;
        b=p77gfSBuAxonX9liwZs+8/t5Mudz4WzeCGIoIxYvYIjpyA3tLkryVpFL4NFPypkswo
         y2I+VVzgrjUd10ofAtxbWy3xVVEKHqt40qaZsvsUZrUFxhR+SJWWfeKZLncB6lu5M9z7
         /+yfuyXJi4tdiDDIfAtiauxD6s2BzLDVxZOt3VB9BUohrKOIcuoxctCRQ2uky0cJ/5QH
         S/4m8vwXpUVv1OmZmqFztiCNstj0LouYQEiQ3VihAskewy6QWq02TBIsXihwa/puJMRb
         rhzyNRlSkyBQTp3xfIzWsSk9ZK+aCijcv+/iy3FjYDiO1qmk0cD8TX+KrngXTsIh4qxN
         P5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637227; x=1776242027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pbj1pinyLCpTvRMDqb5wMltAGKRQ0z6dfcrCaaij6ks=;
        b=suNrz+p6gfiKlpLlaEi7L5mcDXozm1hzS7UvSdzJEHRpFG/0l6kVlKWQZsqfOYE6CH
         cRvis0selUDgHJgKAYeZPJs4nB/FS3YutouSD4HWKznMa/K6mHHlRcgH8cTp3Qun2UdP
         sP57MGCNfKFIn+WRPM0hEPaPbaeRSCt3yMSgy0aS1z5aEbWJIJHjeuguH0t3gao/lW7x
         YCbwmVySVbiI9EkX+56Zyxen8Dknj9alaI/AIRLaTfsmwilE+9lPqN5Uo5GDAa0mv71B
         +rwdb1XrRG8w4owLebEdFd3dft4ghe0FIET1S4xJYagf1TVDHhxZnotTUQGBwF1hWWdn
         VLkg==
X-Forwarded-Encrypted: i=1; AJvYcCX09MbM9bbtmPllf0PMD4fEobsgdv0QZy3HTv0RJoAUV69hDy4NAvI77oz0OPXB10/uuogACJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XZCyf7HUWOQ/V+zmPC1zFZ6pVPmtZwmVqziI/S724+h8qOEd
	kVk3kg30toIjoZCFYJa8RUaVhRk0RFm7x8LjVLrHE+1J0aD4VAAtJZGjYfBwLQ==
X-Gm-Gg: AeBDietCKMJiBPQ7955zl5qGO9STJWIt0Df9R2hLJRC276AEMZ/DBAEYE9TCD0XCLsd
	PU0JlEJYoInum3W90SxoFuthWOheqWQZPFzC/1N0pbXNEqiMAi2k+j+PuYfKhBvRHTj8HOPdAO9
	g3fxH+xD8vSY4t+Dd0dg6hM8gFz8D76Ovb9+BAtFHs3H/O00AB6dnw6z4MJEvGX9JGFT79CfGIR
	omxpuGyvmuQzm2BxDxDqWuroc7HS9Sd4wfPJCtrjQjxi7F+9AJQ0xtFS0kr09bYXBVNSwuE7wzx
	o3p/45hQnGOYzikhBvMMsRNanOTuFRAuR2+L60Bznuzl5AR4+tHNx6lmYwqTx+mxgDf/OMD/TiO
	CxMA3tcrGi01wrrrEQgcxVpcdz0BNKs8XYu+vN3lS6xd/m3zz1/EXoJ456BLRO7+GyKdnfMBwp9
	CwRNq9TBdv3brH1Wc1jZ3oQBakXeOGCFMy
X-Received: by 2002:a05:600c:3b1b:b0:488:8bdd:cfb9 with SMTP id 5b1f17b1804b1-488996b01c8mr283650655e9.1.1775637227307;
        Wed, 08 Apr 2026 01:33:47 -0700 (PDT)
Received: from foxbook (bfi53.neoplus.adsl.tpnet.pl. [83.28.46.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5db33b4sm17711325e9.6.2026.04.08.01.33.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Apr 2026 01:33:46 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:33:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Petko Manolov <petkan@nucleusys.com>, Simon Horman <horms@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Message-ID: <20260408103343.19cf599a.michal.pecio@gmail.com>
In-Reply-To: <76d6b341-27d5-44aa-92fb-3b8966d609df@lunn.ch>
References: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
	<20260403154538.GA187715@horms.kernel.org>
	<20260405085212.GA8491@cabron.k.g>
	<76d6b341-27d5-44aa-92fb-3b8966d609df@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276356-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE09A3B91BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 01:38:06 +0200, Andrew Lunn wrote:
> > > -	get_registers(dev, CSCR, 2, &tmp);
> > > +	if (get_registers(dev, CSCR, 2, &tmp) < 0)
> > > +		tmp = 0;
> > >  	if (tmp & CSCR_LINK_STATUS)
> > >  		netif_carrier_on(netdev);
> > >  	else  
> > 
> > I was wondering if calling netif_carrier_off() is the right thing
> > to do in case get_registers() fail.
> > 
> > There are multiple get_registers() calls that don't check the error
> > and if we do this in set_carrier() maybe we should do the same
> > thing across the whole driver?  
> 
> What does it actually mean if get_registers() fails? The device is
> gone? Hot unplugged? If so, you are going to get a cascade of errors,
> and then hopefully the USB core code removes the device?
> 
> Are there any legitimate reasons for get_registers() to fail if the
> device is still plugged in?

In principle it might be temporary EMI or a flaky cable. These errors
rarely reach drivers due to retries in USB layer, but in extreme cases
the device may be in unknown state and it may become functional later.
IIRC net layer has some operations which are presumed trivial enough
that they would never fail, so this could be annoying.

It does seem rare enough in practice that for 25 years nobody noticed
carrier status being set to a random vaule by this driver.

BTW, some functions like rtl8150_reset() pre-set data to a value which
will be safe in case of get_register() failure. But here, unhandled
set_register() error is dodgy - the 0x10 bit may never turn on.

Regards,
Michal

