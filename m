Return-Path: <netdev+bounces-120259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82E958B77
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0EE1C21962
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0374194080;
	Tue, 20 Aug 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPYmGoYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkb5WQp7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPYmGoYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkb5WQp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8B125D5
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168329; cv=none; b=RfainSHjVFCjMmdWBrOUUz9y3nNe8CURbbt2BMUt/2E74TaniK6zn2M0wBWWrf4QfDj/QiQAe3svDJoYOLCjhDCN61Iz/HZc8wpQGG6fgO8+mYsarzZjR1kgcuyP6Ls2nwtT+mc15TswY1ZxpiRtMWpDV8kH1c5kwOnEezCpZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168329; c=relaxed/simple;
	bh=KTRxcxC/9SDRdPWlB74drqO/l4/3h6Du7LBRufmxnpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXcXaiNO+caIghN41qCbDYmz365SJiD8ouMjwRx1N9Ep02csrd//CHNKtzhgFRnM0cCoDrAN57XJQOBaLeNItcpdFiNX3A78rAgrHd/qnaTO2vBDKoZJx84Z9GrMSsIiIG+QftdIOaGSDEz+Ek2Kttdfiq2RHmBkkuoR5kH+0BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPYmGoYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkb5WQp7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPYmGoYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkb5WQp7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0680521C91;
	Tue, 20 Aug 2024 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724168326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddD62jFt87d70KJFfeWntLk/K8Q7BBcfhZ5+1H8rEtQ=;
	b=DPYmGoYpaCbIVoFekuzuP9kwMLM5/IooJPazejPc1DlrGQgYnGmuPyWFbruGBl5m8+kAip
	CbSa30S/9myTA6f3BR/HJxW/ktxs8mFXGnoix+Falwtm3LWkrjyr7686kdwCxfRj0DN78g
	8Pw4rYx0CJDEt5Ol+mp2AyHTKusBp78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724168326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddD62jFt87d70KJFfeWntLk/K8Q7BBcfhZ5+1H8rEtQ=;
	b=mkb5WQp76XURvFx1N76ftQUZI1vfF64jljjOn57V7K4YX6JVNImxijlIG0JmgWBVbl8X+g
	+XZgX/EvMhpyMmDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724168326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddD62jFt87d70KJFfeWntLk/K8Q7BBcfhZ5+1H8rEtQ=;
	b=DPYmGoYpaCbIVoFekuzuP9kwMLM5/IooJPazejPc1DlrGQgYnGmuPyWFbruGBl5m8+kAip
	CbSa30S/9myTA6f3BR/HJxW/ktxs8mFXGnoix+Falwtm3LWkrjyr7686kdwCxfRj0DN78g
	8Pw4rYx0CJDEt5Ol+mp2AyHTKusBp78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724168326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddD62jFt87d70KJFfeWntLk/K8Q7BBcfhZ5+1H8rEtQ=;
	b=mkb5WQp76XURvFx1N76ftQUZI1vfF64jljjOn57V7K4YX6JVNImxijlIG0JmgWBVbl8X+g
	+XZgX/EvMhpyMmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B25ED13770;
	Tue, 20 Aug 2024 15:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PRUKoW4xGbuOAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 20 Aug 2024 15:38:45 +0000
Date: Tue, 20 Aug 2024 17:38:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [RFC] Big TCP and ping support vs. max ICMP{,v6} packet size
Message-ID: <20240820153840.GA977997@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240819124954.GA885813@pevik>
 <CANn89iJgK-_xgFSjpH4m0qmcgwEMaTse7D=XbG-2qi=Gnej+xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJgK-_xgFSjpH4m0qmcgwEMaTse7D=XbG-2qi=Gnej+xA@mail.gmail.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Eric,

> On Mon, Aug 19, 2024 at 2:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Eric, Xin,

> > I see you both worked on Big TCP support for IPv4/IPv6. I wonder if anybody was
> > thinking about add Big TCP to raw socket or ICMP datagram socket. I'm not sure
> > what would be a real use case (due MTU limitation is Big TCP mostly used on
> > local networks anyway).

> I think you are mistaken.

> BIG TCP does not have any MTU restrictions and can be used on any network.

> Think about BIG TCP being GSO/TSO/GRO with bigger logical packet sizes.

First, thanks for a quick info. I need to study more BIG TCP. Because I was
wondering if this could be used for sending larger ICMP echo requests > 65k
as it's possible in FreeBSD, where it's done via Jumbograms [1]:

	ping -6 -b 70000 -s 68000 ::1

> > I'm asking because I'm just about to limit -s value for ping in iputils (this
> > influences size of payload of ICMP{,v6} being send) to 65507 (IPv4) or 65527 (IPv6):

> > 65507 = 65535 (IPv4 packet size) - 20 (min IPv4 header size) - 8 (ICMP header size)
> > 65527 = 65535 (IPv6 packet size) - 8 (ICMPv6 header size)

> This would involve IP fragmentation, this is orthogonal to GSO/GRO.

But now I'm not sure as GSO/TSO/GRO are in NIC drivers, but this change would be
needed in raw sockets and/or ICMP datagram sockets (net/ipv[46]/{raw,ping}.c).

Also from RFC 8504 point 15. [2] I understood that Jumbograms are not relevant
any more (on FreeBSD it's only for loopback):

	15.  Removed Jumbograms (RFC 2675) as they aren't deployed.

I guess that's why BIG TCP was created, to have real support anywhere.

Kind regards,
Petr

[1] https://docs.freebsd.org/en/books/developers-handbook/ipv6/#ipv6-jumbo
[2] https://datatracker.ietf.org/doc/html/rfc8504#appendix-A


> > which would then block using Big TCP.

> > The reasons are:
> > 1) The implementation was wrong [1] (signed integer overflow when using
> > INT_MAX).

> > 2) Kernel limits it exactly to these values:

> > * ICMP datagram socket net/ipv4/ping.c in ping_common_sendmsg() [2] (used in
> > both ping_v4_sendmsg() and ping_v6_sendmsg()):

> >         if (len > 0xFFFF)
> >                 return -EMSGSIZE;

> > * raw socket IPv4 in raw_sendmsg() [3]:

> >         err = -EMSGSIZE;
> >         if (len > 0xFFFF)
> >                 goto out;

> > * Raw socket IPv6 I suppose either in rawv6_send_hdrinc() [4] (I suppose when
> > IP_HDRINCL set when userspace passes also IP header) or in ip6_append_data() [5]
> > otherwise.

> > 3) Other ping implementations also limit it [6] (I suppose due 2)).

> > Kind regards,
> > Petr

> > [1] https://github.com/iputils/iputils/issues/542
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/ping.c?h=v6.11-rc4#n655
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/raw.c?h=v6.11-rc4#n498
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/raw.c?h=v6.11-rc4#n605
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/ip6_output.c?h=v6.11-rc4#n1453
> > [6] https://github.com/pevik/iputils/wiki/Maximum-value-for-%E2%80%90s-(size)

