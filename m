Return-Path: <netdev+bounces-259806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP4+AxoHmWmiPAMAu9opvQ
	(envelope-from <netdev+bounces-259806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:15:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59C16BA98
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4158B300A111
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1531AAAB;
	Sat, 21 Feb 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R22gLNzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A8319852
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636503; cv=none; b=b6lytp+Qip4wDs3JsDj54Dxot8EV9EzdGCvKKP4/ik9gVMQAtJs+9KyBZScnTGLajNpA4KNbOEysHY9y4MgGzcfYIqrZ2NQ0TAV0nu8wKfuZLawXyhyR58icKfKdsUTU62VssXJIqDupPmTNMMGVgGFnS0tj/q89DKUH3dKTkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636503; c=relaxed/simple;
	bh=fBmiLH8NAhgHlNh6PoWTWTQquc8qXb2sSVi5ajaPEPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz1Efdroy6oOPKfxG3uq8zjNYFSTxZskrnmvPMcwh4WfBRgzjzm/GSLbXIFhlVjq8rrD3pJYHuy+GVwXH4x7EzhUykOxu2uW4kYAFk2ZThMck8Ty9K5bpu11t+gUoTZ6xCA0XmApcXC1yLuXylwn57Q0IrSAyI9fjdaD/bvjHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R22gLNzK; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba90683995so1256591eec.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771636501; x=1772241301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMA4zsHjc5N7FmzPqy2ujx7WN0dRWDQd+xo6v0yMfoU=;
        b=R22gLNzKgVXNb2eclhdC4q4rKokMn3c742FEUJo3ufjNZr1GXgodtSqToh2xnbLLts
         vZXPZO1wqTexlV4kYCfcWHhvsLurjUID0Mw+xjidKx/qJXIb8w9ZsjmL2/JZ049awd50
         uY8GyD/nXZr0ajoWwgFyo5kX/EGz14yV9aIABJVCXRdO5tf2H0Q8rCaw7u9i7i2xvIWw
         aulqyYS5XBwajWjRZNBWA3jqL1Fz49RFf7k0pzbXnr2dSYVov9scxCa6UgDeCmkvYXW2
         f4l6Q0vmCGbkr1kql320TKiTQimfHUXg05+MbRENZUB3xtXHVJ3M4uf6oteJ/X919f5k
         jHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771636501; x=1772241301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMA4zsHjc5N7FmzPqy2ujx7WN0dRWDQd+xo6v0yMfoU=;
        b=H5cqb0UDRqLWgKYLRR89mNaZ7Td79WzosmxIdY7W5+VVko6Ny/HS3tDgAEHgg/7/Y9
         9h8V3W3t/XNuZF31eQx2+JAdYBZJKXzRLbYr5xZxGQ4AO4pwDngqMgWagP2ywfQ1GwD3
         VjWfA3cxgmXQWAyXNvTuPYGkHQDMQB3GoqP6v+D9fbuCuDFBHSDCVzf8TquFZF1rCw4R
         8NsAhtA5t8EQRkGgZQODI2rAXGB2UA4H4UCrS5wPL7boROcDYqEMIyZ11zH1E8NQWLON
         5kC7LRPWIWOKQIhYzVNh0J2mQ/2G5YLUatNHcTtMwY6SRfuthdXFsHKRReK9zg8UJjyB
         Kmbg==
X-Forwarded-Encrypted: i=1; AJvYcCW8kQNkLWCSCOy+3gIIcYr809/rjHb72YpLYPJwbzysc1woXwUpnTwgCyeYk+dXhF25DoilTaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4a9+VaG5Qj/CXvE39ala93YoHsDeMT3b/UOoMs3kwTil9NOW
	HSWr7Kx454hUvAEc8ROUolFdzXWFBu5vMpx2P4vk2VpGZ4N6hpBH2kI=
X-Gm-Gg: AZuq6aLIbTkHTLitC+TujMOCJZpKbzo8NCSzjyqU7lKBOyJ1UBQy4V/v/rpcC/bw+M8
	rTfyDDHNLczvaTefHP4AgSNwcDUw8SbdKgLWHXZwkIegQfF7cZRJc91TIANQKT7eL8EoVayipth
	zl1AtjuouGItbcV9iDTwGqZC61jysME5mHUTePIbTcYNGcN62z0ZJToddPql8u8hlAC6N8xKsAz
	fZTgwlt2viUFX3MZfXFJpjx4EA+2y6L7WJZqnlhRUzzzPMTSCONV6EfukunRX3nIYB1jZ75SmrB
	rAP6hqc5C379zsTrf1D87ZPvGFIYM8DYQbqpwSaljkfx6G8AiAi5pOoTbhpSUGnkbZQ6McaokC1
	5OYOWtLSVZYEoHhi76J/WncXDq31+TG7tXJs9h87BM6i2q80sKUnL3eSSOZv//ZOo5YMQPaTkuj
	N5wYjGv3aaBMdNUThFDN3dQI7uqibsNv+CbVhMPY2LCmC5ENm6ocf0mgixAAP8SPQswXdqf7NRB
	FM3VaCEDybPSYj/ag==
X-Received: by 2002:a05:693c:2c93:b0:2b7:5a7f:f74c with SMTP id 5a478bee46e88-2bd6077e10bmr2998914eec.9.1771636501380;
        Fri, 20 Feb 2026 17:15:01 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc35362sm485559eec.30.2026.02.20.17.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 17:15:00 -0800 (PST)
Date: Fri, 20 Feb 2026 17:15:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZkHFB1yH2ooiukD@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch>
 <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch>
 <20260219121213.5b5ab0e7@kernel.org>
 <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B59C16BA98
X-Rspamd-Action: no action

On 02/20, I Viswanath wrote:
> On Fri, 20 Feb 2026 at 01:42, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Not sure. Another alternative is to implement the long standing idea of
> > having an async / sleeping version of ndo_set_rx_mode() orchestrated
> > by the core. Because a lot of drivers need to sleep, anyway, so they
> > just schedule a work from that callback.
> >
> > Then we can say old ndo_set_rx_mode is under netif_addr_lock.
> > ndo_set_rx_mode_async is under instance lock.
> 
> Hello, I have been working on this idea here :/
> 
> https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan@gmail.com/
> 
> I am calling it ndo_write_rx_mode but if ndo_set_rx_mode_async sounds
> better, I will go with that. As the constructs I would
> be introducing in v9 (enable/disable deferred ctx) should be useful
> for other NDOs that would want to do their work async, I am looking
> for concrete use cases to justify this. Right now, I have
> - ndo_set_rx_mode
> - ndo_change_rx_flags
> - ndo_tx_timeout (Few drivers seem to schedule this and it's under
> tx_global_lock spinlock)

Hmm, interesting, I haven't seen that. So this takes care of
non-sleeping ndo_set_rx_mode. We'd have to move ndo_change_rx_flags to
that new sleeping ndo as well (to resolve the issue that this patch tries
to address>. And then we can try to add instance locks on top of that.

> Do you mean rtnl_lock when you say instance lock?

Search for the instance locks in Documentation/networking/netdevices.rst. We
essentially need to add netdev_ops_assert_locked to __dev_set_rx_mode
and make it work.

