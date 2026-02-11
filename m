Return-Path: <netdev+bounces-258309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMFSLK2vjGl/sAAAu9opvQ
	(envelope-from <netdev+bounces-258309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:34:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A351262C6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0055230429BF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60333F38C;
	Wed, 11 Feb 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGHVRd7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F9A932
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827494; cv=none; b=X7h1XvqS798whyd1f87vsDEFNPhgcHwC8LwFVCwoATR4TexIZ6CPNxnnIBDP2xfaXepPt7qaeECv8zPQNXuLBLWCvbAARjiL9Rdgv31jGJYmO0F6+95bGOz3c+eGmUL5tsWJqT0Rtpv1umH+OFGU5E9ylSUWsMqIgI6AOo+jp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827494; c=relaxed/simple;
	bh=WwnrkQ1E5PvAGPN3ZaleFFPohkmk/0K4Aa0etEvh1jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdd99+QpQmrHZsTXRhwEgcdtpRsu6wrgChs2LH2DT2DE60/qW1/Jxya6qDkF1mhK4FumCZ6WVPVP97sAYzyfQPNVgIFY/+v9EiAh1pj2RBR+zGONILHxbNox3JmVfM9lNNbWh0PtM3KmljqAZ21KmfZhIkT9mrOFbCRh8RKAcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGHVRd7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B16C4CEF7;
	Wed, 11 Feb 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770827494;
	bh=WwnrkQ1E5PvAGPN3ZaleFFPohkmk/0K4Aa0etEvh1jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kGHVRd7DL0BBmsfajlzP/ybhGZLY35cwAP7uWqwB0E2BKSr/IfesACVUiYW82LZvV
	 5dpbhdpynVP8LlbXsdoscoQiH2QXs7CFvyj0CAXAOOvSNy80BZnS7BAKTYLgcALy41
	 z+JV7BGtkQR2DI9zRqJvjHmAtJE1knsMBi+x+haBfsH3wBCGE9P1fwXLVTGiP6Wg44
	 OiqYlnRyYD6SSMb1Oog49AHj+8nF56E3ye/BfUh3Egrqx9xbj/OI45n4mBoGoqFvY1
	 lNZ0PVZGRNWEeMnz+ZVDsFiT96dmlYwt49wGJlSX9HQ5QgySCte+klz4K3UANpHfkm
	 RcYIc0UFHvEmA==
Date: Wed, 11 Feb 2026 08:31:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, "David S . Miller" <davem@davemloft.net>,
 Linux Netdev List <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <20260211083132.15b15870@kernel.org>
In-Reply-To: <CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
	<20260206052930.1882740-5-michael.chan@broadcom.com>
	<aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
	<CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
	<20260210174627.2360a03c@kernel.org>
	<CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
	<20260210201706.1da13881@kernel.org>
	<CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
	<CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-258309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35A351262C6
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 13:29:06 +0530 Pavan Chebbi wrote:
> > > If you check the carrier manually in a second terminal while it's
> > > running -- do you see it go to 1? The helper keeps the file open  
> >
> > Thanks for the nudge. I think I get the real issue now. It's not the
> > cmd() but ifup.exec()
> > I am using :
> > ifup = defer(ip, f"link set dev {cfg.ifname} up")
> > and later
> > ifup.exec()
> >
> > I see that exec() takes unusually long time for carrier to go to 1.
> > Upto 20s and sometimes still fails.
> > Same with both direct exec or deferred. And this explains why I cannot
> > ping for long time after suite exists. Thats because I rely on defer()
> > to bring the interface up after bnxt exits with carrier 0 for the
> > second test.
> > If replace the exec with direct call to ip(f"link set dev {cfg.ifname}
> > up") I see it works reliably.
> 
> My experiments are pointing to 'self.cancel()' sometimes taking a lot
> of time as part of the exec().
> I don't know but I feel the new test code itself should be OK. I can
> send a v3 and you can run it once too?

Could you reply to this thread with what the version of the patch where
you see defer() takes a long time? We use defer all over the place..

