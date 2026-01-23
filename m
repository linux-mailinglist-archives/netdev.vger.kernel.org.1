Return-Path: <netdev+bounces-252786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBgNN+pSc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65D74989
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBFCF30382A9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867629BDAE;
	Fri, 23 Jan 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MHnVZk8l"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB66301702;
	Fri, 23 Jan 2026 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165354; cv=none; b=MyCLncEyBL7ZOA95Kbq1E0zX9E5zWOkBOSTMQzvJIwthYeE9/kc0kDS7kam1XiBLhLwqb1ZLJ+ANFTug+fAjSseKEZxpsVjQNpqy8eFt2378zjrPqFMWNKo+RRzX+YC72OU59ytKNuFF6fPDjaOF/cglyjfI2nzl2nBEWYWolg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165354; c=relaxed/simple;
	bh=GMrqokOjh3k3YsjHV1IcTV/TZ9eSopUtljN4V26GQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHtQkHeorhZn67vR7c74tqEvLEAqOudCzxRQwwcjxX8X14jg1FGSsNahcpMe825FrkmqwKztBBKsMNm939mQGPLPFqQKC51o1/Eax0oHjt1dO/aJqnx+eKHstRfrwez/vRCHG5/7Hf8TxGlT1Z32BcHQJnDiL9O52nC9aPuffuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MHnVZk8l; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S/r8KF8KuCYJGeBfJA6eGHiYYYS8fyuSrkH1t69XORk=; b=MHnVZk8lTWcw4NC3USZpD3t1Ah
	jTnJYr3y8zalQgea1l1dX/FdZMHo2UnFpIVTzlbEVz26PTu1HaWchPICGeiJhLbg716KN/FppgSjp
	xqBzXM8+EVziAUcVLFe49APmXEcVo01y+FpUxe0fXpw90cnb/NB1sPexBh01z4oFtlmL0wa+V4Oui
	qQRU3lOKxNX8MOryH2hinciWvdldBzmtYI55E2TpNAAmpJ3YsKofXNvJdpVl08Y95npwRHz6/gaxa
	ON26scFzVC4ip2Ml1WJJecgnhpGcwo6XkeI7blD4LEwFSxoFtnbGpXbWm8mW/1CFQOz6hinZDP7It
	oDXleOPw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjEij-00DmjE-3Z; Fri, 23 Jan 2026 10:48:53 +0000
Date: Fri, 23 Jan 2026 02:48:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: convert to NBCON console
 infrastructure
Message-ID: <aXNRR7dQHZ7bN2mS@gmail.com>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
 <20260120-nbcon-v2-3-b61f960587a8@debian.org>
 <aXKSDoi8Yue_Ghxj@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXKSDoi8Yue_Ghxj@horms.kernel.org>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252786-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E65D74989
X-Rspamd-Action: no action

Hello Simon!

On Thu, Jan 22, 2026 at 09:09:34PM +0000, Simon Horman wrote:
> On Tue, Jan 20, 2026 at 08:23:49AM -0800, Breno Leitao wrote:
> > Convert netconsole from the legacy console API to the NBCON framework.
> > NBCON provides threaded printing which unblocks printk()s and flushes in
> > a thread, decoupling network TX from printk() when netconsole is
> > in use.
> > 
> > Since netconsole relies on the network stack which cannot safely operate
> > from all atomic contexts, mark both consoles with
> > CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
> > 
> > CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> > scenarios (panic) where regular messages are sent in threaded mode.
> > 
> > Implementation changes:
> > - Unify write_ext_msg() and write_msg() into netconsole_write()
> > - Add device_lock/device_unlock callbacks to manage target_list_lock
> > - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
> >   operations.
> >   - If nbcon_enter_unsafe() fails, just return given netconsole lost
> >     the ownership of the console.
> > - Set write_thread and write_atomic callbacks (both use same function)
> > 
> > Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 97 ++++++++++++++++++++++++++++++------------------
> >  1 file changed, 60 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> 
> ...
> 
> > +static void netconsole_device_lock(struct console *con __always_unused,
> > +				   unsigned long *flags)
> > +{
> > +	spin_lock_irqsave(&target_list_lock, *flags);
> > +}
> > +
> > +static void netconsole_device_unlock(struct console *con __always_unused,
> > +				     unsigned long flags)
> > +{
> >  	spin_unlock_irqrestore(&target_list_lock, flags);
> >  }
> >  
> 
> Hi Breno,
> 
> I'm wondering if we could consider the following annotations,
> as "suggested" by Sparse[1].

This is great. I hadn't realized that Al Viro's sparse tree includes this
additional check, which is really useful.

Are you using Al Viro's branch rather than the sparse mainline?

(I'm asking to see if I should also follow master and do the same, in
true padawan fashion)


