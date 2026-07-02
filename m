Return-Path: <netdev+bounces-304246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+GxCUOtRmrGbQsAu9opvQ
	(envelope-from <netdev+bounces-304246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A326FC02B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auristor.com header.s=MDaemon header.b=henci3RM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304246-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=auristor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D223222C1D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD273939D3;
	Thu,  2 Jul 2026 17:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4549393DF2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:36:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013792; cv=none; b=gpZABrxPqHQsIc0jdvnVrUTuHmaMt3nk0tuvKprDdRCHir9yN/QnMYPHkz1AtxC8xt3EtBplIj2H9Qdq7yJZ4y8rK11s03b3aGPDWgIGjP2zxcgGJDvunmeJrZOMnStjanuAOmGbzDk8gcMQcu4x8RkeAtw8JtzNOQU0fs1ar3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013792; c=relaxed/simple;
	bh=RUaN4mVDth67xv6TUgfQmwVGz0VokzoU4gxuLs0iemY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2sbGkEZZO/2KfdeyKptD/gN5vXheJICxkkWsr9sPrd6PZc6zTiYrGL5n5SImr0DYk1XX4NjDGl2xfo/VtPueehv4q2G2uoK1oYUCFs+bXTfaTWPpKP7gZLHBxFJk9RhyvwNr22A8RfFHGn9a9Xk7Fupsl3trSQi7fx+22ZJMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=henci3RM; arc=none smtp.client-ip=208.125.0.237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=1669; t=1783013429;
	x=1783618229; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3A69ef=3A5905=3Abf91=3A4fde]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.3)=20=0D=0A=09with=20ESMTPSA=20id=20md500100541968
	3.msg=3B=20Thu,=2002=20Jul=202026=2013=3A30=3A28=20-0400|Message
	-ID:=20<692ffbf0-7c96-4f99-94cc-1e184e1ec575@auristor.com>|Date:
	=20Thu,=202=20Jul=202026=2013=3A31=3A01=20-0400|MIME-Version:=20
	1.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PATC
	H=20net=201/4]=20afs=3A=20Fix=20NULL=20deref=20in=0D=0A=20afs_de
	liver_cb_init_call_back_state3()|To:=20David=20Howells=20<dhowel
	ls@redhat.com>,=20netdev@vger.kernel.org|Cc:=20Marc=20Dionne=20<
	marc.dionne@auristor.com>,=20Jakub=20Kicinski=20<kuba@kernel.org
	>,=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=20Eric
	=20Dumazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=20<pab
	eni@redhat.com>,=20Simon=20Horman=20<horms@kernel.org>,=0D=0A=20
	linux-afs@lists.infradead.org,=20linux-kernel@vger.kernel.org,=0
	D=0A=20stable@kernel.org|References:=20<20260702144919.172295-1-
	dhowells@redhat.com>=0D=0A=20<20260702144919.172295-2-dhowells@r
	edhat.com>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Altma
	n=20<jaltman@auristor.com>|Autocrypt:=20addr=3Djaltman@auristor.
	com=3B=20keydata=3D=0D=0A=20xsFNBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslS
	kcAKhSegWt5j86DpaRL0W8fxg6YjxwEPvwoH=0D=0A=20BGa/rpSdBd1gkmzeYxD
	3hVZdj75r6nVS9f/mxNQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66=0D=0A=20+Z
	SnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM7
	1ltIZx=0D=0A=20kqcrAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG
	50+KccZN4SS5xxdGuh1tA9U=0D=0A=20TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo
	1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1ztmksJbLQ=0D=0A=20aCtW8kF42nF8MpP
	dIPTSPr2uGvpRtCjRbh4lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y=0D=0A=
	20kkxUQeMUjaaXZDHYUSyQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2kcs
	GKUEGkLvnV=0D=0A=20wwvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqOqnD
	BTKUXWQQZCW9Rqt7acdE8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuNCDt6QSgjVbhc3
	hA3hCtE1iW/HhuBAzKiuzJ9era+q9QjTtLPIkQDHRpcC=0D=0A=20MMWvK0Y1uQ3
	4Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs=0D
	=0A=20dG1hbiAoQXVyaVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT
	7CwXkEEwECACMF=0D=0A=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeA
	QIXgAAKCRD3enNVkraaBDdzD/0XQUDW=0D=0A=20UWXrpapHdvZaHzPHc3xobRi4
	PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D=0A=20Mj5vE7+
	7ZRd+J76J4DJH2qoaXX8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP
	6=0D=0A=203bt4LRIa+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1
	OrnNCMWRcq7dmTCbZ0=0D=0A=20R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOO
	xOWS8lgdqzjcK3NsfiERrVbOWM83ZVy0/GN=0D=0A=20vpusjhI/3Q8lbV/p+IsJ
	k/v1grkRzgU0frES2ANEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+=0D=0A=20gNL
	Qe+XN7kvDwGu0jYhTIZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA
	13Zkl=0D=0A=20nm4AYjp7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9V0W
	3SeynBgPtR4qpt4N8yKCcw=0D=0A=20suLCAKfBv9RcL641XZi/Fp9btSuTPUm5L
	w3SIGr5U+SyezmhzlwsObIF9W624aorriWoXNf3=0D=0A=20GgH9ZH0Hkc6aS99p
	IZhh5USWRO/pS+lv5eNkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs=0D=0A=2
	0zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL
	46XZHA59c=0D=0A=20VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmr
	ZS85inz3otdyz/zlyNSWma8qGN=0D=0A=20UlMbiwFQqfXWVBAPGoRC0a0aJrd4I
	ayLuvv1UqEwx7Otp7y5RNHtRv35/kho0Z+UheYVdGm2=0D=0A=20I06xIc+aNKW2
	LO7R5BNtjpADPIG+NSdsVIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo=0D=
	0A=20z+S27gCGJvY6zF22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNg
	THUZClbJj4iq1=0D=0A=20EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7cBoI
	w434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ=0D=0A=20R30p3oqoliGiLsWvHHxyXjuMB
	F4XJ6MRXmD65/qOhuo2DKduHMNlmxzgSzvWgXZeNJq+OcS8=0D=0A=20jQZDt2Na
	2pMKjWytau7xQu2ndm0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye
	=0D=0A=20a9IpTwsVfkF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGx
	XegCaF4Jwz2nxS4Fv=0D=0A=207VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9
	vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpKMU8=0D=0A=20PROIFw0AEQEAAcLBXwQYA
	QIACQUCTAuU7QIbDAAKCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv=0D=0A=20lcY/
	2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2O
	RKVL=0D=0A=200ZJS1QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqU
	dahir2uaRfMkwM+0imOlc=0D=0A=20utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo
	/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAaDov7yHsSRwUM+
	qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A=20
	kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1txex
	L/lLw8AU=0D=0A=20LhUeGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwqKch
	NCxmgH9vd0aQm8TKCrWAW4kU1=0D=0A=20Ig6aMNuZiWloVZfKrmWizbgeGKE9rh
	NPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2vUAXB53Jphl=0D=0A=20F74GwEsh+85i9
	/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC=0D=0
	A=204kG/E7pI/4lke5X5X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3duRTU
	p6K0++S/qsqT=0D=0A=20akGVmjD5917A1HqWfMmiKA=3D=3D|Organization:=
	20AuriStor,=20Inc.|Disposition-Notification-To:=20Jeffrey=20E=20
	Altman=20<jaltman@auristor.com>|In-Reply-To:=20<20260702144919.1
	72295-2-dhowells@redhat.com>|Content-Type:=20text/plain=3B=20cha
	rset=3DUTF-8=3B=20format=3Dflowed|Content-Transfer-Encoding:=207
	bit; bh=zNM3yA0krt/jWCldo6sVN+kvV/4C1mvgf+X3JrbN+ks=; b=henci3RM
	WspA6OslzwjGVsrUNGqBs0jSc94VjI13jkxG5HTRN2DbZrJHYcwdBOb0/SbAjQuD
	KU29qsqat73YgYxvjRzwePhgGK5dJWyfgs5f0yT30SBk6tQ7KhWZm58WbkDteWIw
	tBjApcfQ+pJMj/PUZQ1RUHMdDeVsmycEiSU=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Thu, 02 Jul 2026 13:30:29 -0400
Received: from [IPV6:2603:7002:100:8400:69ef:5905:bf91:4fde] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.3) 
	with ESMTPSA id md5001005419683.msg; Thu, 02 Jul 2026 13:30:28 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Thu, 02 Jul 2026 13:30:28 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:69ef:5905:bf91:4fde
X-MDHelo: [IPV6:2603:7002:100:8400:69ef:5905:bf91:4fde]
X-MDArrival-Date: Thu, 02 Jul 2026 13:30:28 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1643f5c58b=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <692ffbf0-7c96-4f99-94cc-1e184e1ec575@auristor.com>
Date: Thu, 2 Jul 2026 13:31:01 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] afs: Fix NULL deref in
 afs_deliver_cb_init_call_back_state3()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20260702144919.172295-1-dhowells@redhat.com>
 <20260702144919.172295-2-dhowells@redhat.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260702144919.172295-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304246-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_X_AS(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[auristor.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,infradead.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72A326FC02B

On 7/2/2026 10:49 AM, David Howells wrote:
> Fix afs_deliver_cb_init_call_back_state3() to avoid a potential NULL deref
> should call->server be NULL (ie. afs_rx_new_call() failed to find a
> matching server record) when it checks the server's UUID.
>
> Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
> Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@kernel.org
> ---
>   fs/afs/cmservice.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index 5540ae1cad59..d579a665e3da 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -364,7 +364,8 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
>   	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
>   		return afs_io_error(call, afs_io_error_cm_reply);
>   
> -	if (memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
> +	if (call->server &&
> +	    memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
>   		pr_notice("Callback UUID does not match fileserver UUID\n");
>   		trace_afs_cm_no_server_u(call, call->request);
>   		return 0;

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>




