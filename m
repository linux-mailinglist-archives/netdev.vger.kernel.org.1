Return-Path: <netdev+bounces-299962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OUMWOP2+MWrYpgUAu9opvQ
	(envelope-from <netdev+bounces-299962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B56956C2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nd1TD6O5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299962-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A273185DB2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C5391842;
	Tue, 16 Jun 2026 21:24:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D003806C5;
	Tue, 16 Jun 2026 21:24:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645042; cv=none; b=eDRb+zfJklBtUiDgLSa/D8Ps2UkT/8g2RMOxUJDRy/pH2dOszMa9HBH/E/+2OtnNh0vMF8EJigh9Qc22JAgDBs2UhGHLXWhXrg9394YCpap0Ohxff8LVylxCnaaPXqqHGanZPOnZa2TH14jvXWnPbZA9Q+FwY/Z7nB5tnyM20wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645042; c=relaxed/simple;
	bh=dnnMlt3NUnfVd8e98ce32rX8ijCUFqeuBErQQK8v++o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOFE3c/h4b1ooWkTmiMvuHmvJIa4p7w+e9KpIpsZKwLXWzxWvQ18I9ytv1b71kjo2St2Tf/Gh79OwlhSlGlFwmSFL26rQVZDcBHYZoXg0UvQnQJsrBkZwSX4Phc2fQ2ZT/HGSRAn/RwPCWC13HwnVoqUxWAC3g5MxDiBqAemyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd1TD6O5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B6B1F000E9;
	Tue, 16 Jun 2026 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781645040;
	bh=s8T3aYLI5DrbNJ7kwq8RJnZMCafMwusd1xaM5iiYTs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nd1TD6O5S2qKlg41LTPvwRTWI0/7TIpZqhKSZbT/fj+EEqkqb+BNfQhD73YkUmFrD
	 rG73uHU+IwquWgLtqpKGhJKJXFu6cRE4SprWVUA/SPVvFbXhpJnARLGpU29qPYsxgl
	 3/Efh6aT7dVAYq59chbPV0E48bgOmapD/DEplPOuKYWeZs6ybF+kpIF/eAmoC17CYP
	 g2Jry4Fcl+ygOHJZ81+EiLs396mhq+GmOAkwRhuFaO4cR5yX9YWySEkquNvdjepXdG
	 bD6Nhk6/yC5Dt7el/jS3PLv+3bVWcqdVH+hzq+OrefHcdvA4VJt3Al1H5cs6YN00Pz
	 frm3zw6BVlcXg==
Date: Tue, 16 Jun 2026 14:23:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <20260616142359.43300727@kernel.org>
In-Reply-To: <ajG5hg9oJvyxPplG@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
	<ajFpejsl1ukTbG96@krikkit>
	<20260616082816.4dd0f035@kernel.org>
	<ajG5hg9oJvyxPplG@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,cca46a9d1276f38af2ae];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F6B56956C2

On Tue, 16 Jun 2026 23:00:54 +0200 Sabrina Dubroca wrote:
> 2026-06-16, 08:28:16 -0700, Jakub Kicinski wrote:
> > On Tue, 16 Jun 2026 17:19:22 +0200 Sabrina Dubroca wrote:  
> > > I suspect err==0, and sock_error() consumed sk_err in between (the
> > > alternative would be err > 0).
> > > 
> > > Something like this?  
> > 
> > Makes sense, but what's eating sk_err?  
> 
> The 2 remaining sock_error() in tls_rx_rec_wait()? [1]

How did that elude my grep..

> > Don't we depend on it being set
> > to avoid further state transitions once we hit a crypto error?  
> 
> I kind of thought so too.

In which case the question is whether we should try to remove 
the sock_error() instead? (stating the obvious I guess)

> > I thought that's why we don't consume sk_err in recvmsg and sendmsg in
> > the first place (we are not calling sock_error() anywhere)  
> 
> Umm...
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/tls/tls_sw.c#n1095
> 


