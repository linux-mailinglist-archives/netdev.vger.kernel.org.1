Return-Path: <netdev+bounces-257537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMSJMmvahWnfHQQAu9opvQ
	(envelope-from <netdev+bounces-257537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:11:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3367FD7AC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5B9300698C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C643A0B0C;
	Fri,  6 Feb 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BdRdhxly"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FE361DC1;
	Fri,  6 Feb 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379878; cv=none; b=udxREC8WpTtWF2ZzxyzYemJKBoFixvT2yy0QccHHnRdoV5ywiu1USb9LVEE85bqlLS3H+nyuesbyafdoNGwd1MuMPVbWmztwQ0/0TeNyRoeSoobgWUvzVQf3BBFruC5hx9pIqvgG9dvI9UxWFePGslKRls/2ei6Ez1BlrZOppac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379878; c=relaxed/simple;
	bh=singIeLIaxBOhho6/qJo5E+oQFqvt7GzcQiJv4BX/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJVkC7TftDa2hBzTujguIVwPj7ii6zTTZa/lPmpISJVelVEwE3aGW/CSfZjoX8hejBy89uF+gtxBmgIwC6cDdCQ+KgOSI1Mv6MaebxV5mVNYFInaANT8hnwstQzUTmBDq0EwQsiwZtgo4RsDUPVzfFb2zpnK+dh+2Y1pNF4HRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BdRdhxly; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=17CApZ0SXsDocYCoDQD0Gmc7fTR3XjxqZI9nCOlKYTs=; b=BdRdhxly2pfDgcLk4ldPHLlKoZ
	QufkOshxgDhDBB1Tus0Zc7xhItQ0bXmnOg7gFLs89NcReKXA+MAEYYjXnuB8SVC78LhOFuGo7IVDp
	0Z9ICFQ33qJZx0p7l2T+EtT1RDKixRRk7+XQw6eq6LD9UQter6Dz8WcYY23Um5iRCErUGW9Kkgs/b
	q3+jkyipvWSr0X0Kfhau1tUyXtx+djPDHf0lWJfuD2gnRHBrr9beqvhmmT4na8FoLVyxbo6gBgJko
	FX81GvQ/OAuxDLpy10PapniLf7dU59JSHUNx2PJ2lf+tRGeEg+GUs46yW9F3v+aeSWsQJsaaQcGoA
	j7+HZwLg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voKfn-0079It-AJ; Fri, 06 Feb 2026 12:10:55 +0000
Date: Fri, 6 Feb 2026 04:10:49 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v6 0/4] net: netconsole: convert to NBCON
 console infrastructure
Message-ID: <aYXaMyaJuQHEntQy@gmail.com>
References: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
 <87fr7gp0qb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr7gp0qb.fsf@jogness.linutronix.de>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257537-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3367FD7AC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:12:52AM +0106, John Ogness wrote:
> On 2026-02-03, Breno Leitao <leitao@debian.org> wrote:
> > This series adds support for the nbcon (new buffer console) infrastructure
> > to netconsole, enabling lock-free, priority-based console operations that
> > are safer in crash scenarios.
> >
> > The implementation is introduced in three steps:
> >
> > 0) Extend printk to expose CPU and taskname (task->comm) where the
> >    printk originated from. (Thanks John and Petr for the support in
> >    getting this done)
> > 1) Refactor the message fragmentation logic into a reusable helper function
> > 2) Extend nbcon support to non-extended (basic) consoles using the same
> >    infrastructure.
> >
> > The initial discussion about it appeared a while ago in [1], in order to
> > solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
> > cause is that some hosts were calling IRQ unsafe locks from inside console
> > lock.
> >
> > At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
> > kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
> > nbcon: Allow unsafe write_atomic() for panic"), and now we can
> > implement netconsole on top of nbcon.
> >
> > Important to note that netconsole continues to call netpoll and the
> > network TX helpers with interrupt disable, given the TX are called with
> > target_list_lock.
> >
> > Netdev maintainers, Petr suggested that this patchset goes through netdev[2]
> >
> > Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> > Link: https://lore.kernel.org/all/aW9D5M0o9_8hdVvt@pathway.suse.cz/ [2]
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > ---
> > Changes in v6:
> > - Do not select PRINTK_EXECUTION_CTX in NETCONSOLE_DYNAMIC (Jakub)
> > - Do not make PRINTK_EXECUTION_CTX user visible (Jakub)
> 
> I am really sorry, but I failed to communicate what I meant about
> introducing the CONSOLE_HAS_EXECUTION_CTX symbol.
> 
> As Jakub mentioned, NETCONSOLE_DYNAMIC should just directly select
> PRINTK_EXECUTION_CTX and get rid of the CONSOLE_HAS_EXECUTION_CTX symbol
> (like you had in v1).

Ack! Let me update it.

Thanks for the clarification,
--breno

