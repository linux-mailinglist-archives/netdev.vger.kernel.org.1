Return-Path: <netdev+bounces-296683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LVmrIVb+JmpgpQIAu9opvQ
	(envelope-from <netdev+bounces-296683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:39:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03034659542
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:39:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F0y6iulC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296683-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7E2B30160D2
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D13644D1;
	Mon,  8 Jun 2026 17:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1F330D22;
	Mon,  8 Jun 2026 17:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940364; cv=none; b=JTtc8bnJywOx0zuhBmAKmamfCdkXcOF0LfqLhZor9Runr/F8k9Z9qQOvQqFlqn0pnVMvgMlYc6OXaQo5LSKBmDnff0DHNN6ZWX9BKJWDM1Iw2T4U2apg/6dU1v/kyNi16qLFdS/gzsEW6e3vd+4vEEkERRfTbFaIekdw6FHn7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940364; c=relaxed/simple;
	bh=kjuuTA+2zo1Sy21QxYhdYY38lkqEmpjpG2N3F2vbpu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAVhqo82UrLeDYuM31aODvtMhxZGLWl+6LfB2o+PTyKiIMpbSpCdH6dL0zEhopQw4a8HBl7pwFo9dtuQNQcIvl6RCizD+Mkaha77ZDnlFM0AvKdC3Da376BDxSZi4a3R669btJjlUVyR432WKC0p8gp2uTMCF4sGX50ifSVZxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0y6iulC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25A61F00898;
	Mon,  8 Jun 2026 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940363;
	bh=+8PPMuj7dGYYt4XZ8QyUH+ZS/fjh7w4LNN1e4bdDYcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F0y6iulCxiJ7espj/aaFftje5GZg6sp2tjcFwRkbDbfaPM+/3sSSo7iOZhSKV9rPo
	 7ChEDOcNsIocJxqW6NY6eh06k24Vn3JxAMzwyK6LIN/DGR7GrxLFxuwwPGen8Ey9L3
	 M8k9eIA/Y+q85DF3MxzULE8Jwm5pysZnDt6SAiZ6dqdtAxndTsb1alN1VPcttrFU/J
	 9vdPMI+yq6vWNclo+TDVkN7cwhaj4iW3PfQGv7E6e6yf1Eab9oGiU3Kty5dkul4PCP
	 S450grpOsUe8+zHvrlZR8tVZyCCjCr5BiOfSwiD/mubG1DWVvZ9ssQK/9kEXb3x+jw
	 s/0oGmkljGNdw==
Date: Mon, 8 Jun 2026 17:39:21 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into
 net/rxrpc/
Message-ID: <20260608173921.GA434331@google.com>
References: <20260522050740.84561-1-ebiggers@kernel.org>
 <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com>
 <20260603050557.GB18149@sol>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603050557.GB18149@sol>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296683-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marc.c.dionne@gmail.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:dhowells@redhat.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:marccdionne@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,auristor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03034659542

On Tue, Jun 02, 2026 at 10:05:57PM -0700, Eric Biggers wrote:
> On Fri, May 22, 2026 at 10:06:49AM -0300, Marc Dionne wrote:
> > On Fri, May 22, 2026 at 2:07 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > The FCrypt "block cipher" and the PCBC mode of operation are obsolete
> > > and insecure.  Since their only user is net/rxrpc/, they belong there,
> > > not in the crypto API.
> > >
> > > Therefore, this series removes these algorithms from the crypto API and
> > > replaces them with local implementations in net/rxrpc/.
> > >
> > > The local implementations are simpler too, as they avoid the crypto API
> > > boilerplate.
> > >
> > > I don't know how to test all the code in net/rxrpc/, but everything
> > > should still work.  I added a KUnit test for the crypto functions.
> > >
> > > Changed in v2:
> > >     - Added missing export of fcrypt_preparekey().
> > >     - Write "RxRPC crypto KUnit test" instead of "RxRPC KUnit test".
> > >     - Rebased onto latest net-next where decryption now happens in the
> > >       linear buffer rxrpc_call::rx_dec_buffer, simplifying the code.
> > 
> > Looks good in testing with our kafs test suite, forcing the use of
> > rxkad with encryption.
> > 
> > Feel free to add for the series:
> > Tested-by: Marc Dionne <marc.dionne@auristor.com>
> 
> Thanks!
> 
> If there's no more feedback, could this be applied to net-next?

Any update on this?

- Eric

