Return-Path: <netdev+bounces-296700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BQ9MfkXJ2otrgIAu9opvQ
	(envelope-from <netdev+bounces-296700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:28:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D865A0F2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=rSupFt4z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296700-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE789300BEA6
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8873D9678;
	Mon,  8 Jun 2026 19:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F033F8D6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 19:28:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946932; cv=none; b=rSmJyWirknVG8nVo85v59Ds4ZOirc0dDq0+0ktZo6oxr6lanhYo1xVU3sCiCyMB6pNRUQV8txUPi+lIcTjv5NRGNLJMIXlvA78tq9ptE2sjcOauWl4IAxO+XCefWE4OGoS1jwvka2sTQBQV1hxnSDI4IbxjZtvnjuweZ6f+4p94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946932; c=relaxed/simple;
	bh=sqs/ZubQKPTfttoIER6Fmdln9yE0C8y67ApWAX5ifKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K17SLFzqZ+qvEfSCI5lbi62VvSFKWBDS1aq2J6HzEMinVSQtHqhB9wR49RWExTqM8Kg++ELOnhOo90gRiZT9YwFulWPPIx/5TQ7L/RXRLvyma+KjdYdGedblV3r13ouRP5IOeIDW82fbyTKpXBoSNiW6Zf/i84sX5D6WHyUF1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=rSupFt4z; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2729772eec.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1780946931; x=1781551731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zapFnonrQM41kujDNo+8UITgO5BTVmp3mURqlxPhOk=;
        b=rSupFt4zrrqqHiDk4+4dGraU/vD6GgIhqmIburqBJJxsc9yT1A+hATz8C0yLrYiQcb
         dEGjnbjSd6g/DGWKQ2O3hyB1EfZ8NZAzaTVk8fVIIk9wDPv2MhoIvd5yplBJFroovpE2
         dSs8hte6k0E7FI3CLOlTAag1DEV5FXFf95Hz9v4TUFOeZ1A5DU5AmANad2O72pWEu1MG
         B/q21jk9d4O05skjlzMx01rK5nfHf1JoFFw2DFLM6esW4OqSQiG1+Wz7HaYGgvnOqCnt
         EgbT2xzVq+EEdnKxJFMrR4yqbVE5ODGY672Cp911xEVMy4lY/oZ5cJuvm8GV9q39ZUmT
         DvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946931; x=1781551731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zapFnonrQM41kujDNo+8UITgO5BTVmp3mURqlxPhOk=;
        b=Q3CJ4KvLvDwPWxHo5Jsjad6TsT+017HMj9X1495D1AiND+QmSCcP+zGllxlxeC5TL2
         p9A7yr6hFnSNNaQ/YRkXsl28nT9UFl+nBXoIBQBlxivdB6C7NNQZuHEnYLehVLYQf9tS
         fQM8e63H1SjTPXddElo+7GOUw6q09SJPVMDfBMb4JR0kzsg6vO1YwfjQo4u8g3x+weLD
         qhaiEyZnyH1q8J2rxaIZVER42eAU9N3Ge1niFRzZXao/pZzl35Tqz25NwaE+8iOmcMIi
         mflqINfJZkrFbE8HBcKqyvU5UMKehNTaoIutnxe7uN0Dzxy+iLkwdOjGiYsvZGZ/sAH8
         XtVQ==
X-Gm-Message-State: AOJu0Yw/8jf5z26cad9brWkg1h3LMQfUZ2+NVzj3zmdLvhLZGnviRhy6
	GIsTkQ25XclDbctdsohuVmrmS0o1CigAPxvSsC/cdSB0UoHBZep54Q9wwnpkjm5nAtJAp8pq6uo
	0kVV4
X-Gm-Gg: Acq92OGvFwLRmlsrSaHtfPYk5Hkmhk6VnRcqSVdn8vWxZLWC5SHTt1aCnJpKCvxBKV6
	b72m5bwsCqqhJ9Nj8mCl2xoO7/i6Gd7UwtLLmyRzrW0ul+ndIqkqX7Eh/h+W5iQTJ4jMSkwG70C
	OM55BXQD3Xk3YIBUs1EpwrQqagAZWvutkxZvw3eA8hIYWzXhFBSIyBmhRTy7dNbo7sg7/KBw2rT
	UWedCUMzZAsch/L/wR9VabycZn16wm45g/OdU3K0bG3CHa0/k2kVmTx9176560RGPPY13BKal+h
	Pe4DUvmf0HNc3XnlEy9ly/OB2IspATA7Q16FsyAr+cg4fhPxi3sYSqxWo7JDOpv5xq3LNQfb/n0
	8wpF4iDHzuYeYeAJF/x6jj/wzXF5hh/2oQORqI9WCchqRA4N/FZTmbIipmv3ThNsjYi1tJ8sldy
	efeSGkv4c9ZliVlkmjBKPil10s5jLkHnmJ066TU3JH8lPiAwFhuhY93wVj5VgiSLXhlis=
X-Received: by 2002:a05:693c:374c:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-3077b32a2a0mr8659792eec.30.1780946930508;
        Mon, 08 Jun 2026 12:28:50 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:44bd:f433:15c2:72b7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm19412202eec.27.2026.06.08.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:28:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:28:48 -0700
From: Cong Wang <cwang@multikernel.io>
To: Nolan Woods <nolan@i2labs.ca>
Cc: netdev@vger.kernel.org
Subject: Re: net: disable default loopback
Message-ID: <aicX8Bk3e-zTmcsN@pop-os.localdomain>
References: <350cea13-9bf1-4605-82c9-b85114fc88fd@i2labs.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350cea13-9bf1-4605-82c9-b85114fc88fd@i2labs.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nolan@i2labs.ca,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296700-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,multikernel.io:from_mime,pop-os.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B59D865A0F2

On Fri, Mar 20, 2026 at 12:46:47AM +0700, Nolan Woods wrote:
> Hello,
> I am building a highly constrained Linux environment where I want to remove
> any possibility of a process communicating with other local processes via
> the network stack. It appears that the kernel automatically creates the
> loopback device and I can't locate any configuration that might disable it.
> I need to be able to create loopbacks in namespaces, disabling the network
> stack entirely isn't an option. I also do not want to depend on NetFilter or
> any sort of packet rules. I can disable the link after it is created, but
> that approach still has the potential of the link being brought back up.
> SELinux might be an option but is just another form of filtering
> rules. Ideally the process wouldn't even have the option to bind to the
> interface.
> 
> I found this comment that implies that there might be some sort of
> unbreakable implicit network stack dependency on the loopback: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/core/dev.c#n13266
> 
> Can anyone elaborate on this?

Right, loopback is literally part of IPV4/IPV6 protocol, there are
definitely implicit dependencies in Linux kernel. For starter, there are
already many places hard-coding 'lo' in the Linux kernel
(see dev_net(dev)->loopback_dev). It is not trivial to just disable/remove
the loopback system-wide without breaking the entire system.

There are a few solutions you can explore:

1) Create a network namespace and disable loopback inside, this would
only impact the processes inside the network namespace, not outside.

2) Use eBPF LSM (or something similar) to explicitly block 127.0.0.0/8
subnet. This is also global, which means you have to explicitly make it
per-process in your eBPF code.

3) Use seccomp user notification to intercept syscall's. For example,
sandlock (https://github.com/multikernel/sandlock) leverages it to
control network access (including loopback). More nicely, you could even
intercept and filter netlink dump output which makes 'lo' not even
visible to the process. :)

Hope this helps.

Regards,
Cong

