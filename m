Return-Path: <netdev+bounces-302295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rPMqAMouP2pRPwkAu9opvQ
	(envelope-from <netdev+bounces-302295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE76D0C22
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DF4HFjeV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302295-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB469300F0F3
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E161FCE;
	Sat, 27 Jun 2026 02:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5940D560
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 02:00:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525635; cv=none; b=iARyaELatuY1XnqFxzOeFGl46Ky7ke9lcW8kfkZW72JtpHm5n0CPqTqQS6I9UFykuMtJBOVrMCLOh85fuNLFphXvmu9nB5KvuyFDp0i1vY9ZyFMxISeN60PSmYWjKi0eeGDMxFmHU9qFVplwUQVxQOK5hU5K2QvGv3pem5+dKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525635; c=relaxed/simple;
	bh=tdghv4m6igqruZl3i17E1AitEhp5hBdz2aZ/ruBes/4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hiVjc+YJGuNc9pgZgm7ScCFsqJl8pXkOdy5KJJxdW4QnxO3Pz6e2W8EwIhAx4S3GsTWuwDV+6xeDM18omf4XFlrYVhQdLZ/Zwe8Pfz6tAZnlUadXWZIWjDcoEjmnlHsT4K1scwKmkgKSrNHVHPlZlI+OQ4xccH+bSrPNR0VfIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DF4HFjeV; arc=none smtp.client-ip=95.215.58.171
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782525631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qly20BwYW7Q5PttZGy/epQwb3FRzsbU+9R2X09dI0qA=;
	b=DF4HFjeVa9S9AddhxLRQ19HjhW5lt5NV4rjTFRlrP6sFdJQ9ojWRYFqmOafq/fHCC7W0Di
	ifVV4gN/Z5+7dnVcCtYlrnXojAXJF8aH2XgqCmCKoTZevFSdDaFTInEIHWDFq1lPqis0B4
	6likOKKxah2WZ0kd6lYVWaGTnvTS4d0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local
 bind range
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com>
Date: Sat, 27 Jun 2026 09:59:57 +0800
Cc: Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 luoxuanqiang <luoxuanqiang@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6AFD54C-1618-4501-80C2-88F796BA95C0@linux.dev>
References: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
 <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302295-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:luoxuanqiang@kylinos.cn,m:kuniyu@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAFE76D0C22



> 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 07:40=EF=BC=8CKuniyuki Iwashima =
<kuniyu@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jun 26, 2026 at 2:40=E2=80=AFAM <xuanqiang.luo@linux.dev> =
wrote:
>>=20
>> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>>=20
>> IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral =
port
>> range on a per-socket basis.  __inet_hash_connect() already treats =
such a
>> range as an explicit application partition and scans it with step 1 =
[1].
>>=20
>> Do the same in inet_csk_find_open_port():
>=20
> What's the use case of IP_LOCAL_PORT_RANGE + bind(, 0)
> without IP_BIND_ADDRESS_NO_PORT ?
Hi Kuniyuki,

Thanks for the question!

The use case is when an application wants to restrict ephemeral port
allocation to a socket-local IP_LOCAL_PORT_RANGE, but still needs
bind(..., 0) to allocate and reserve a local port immediately.

IP_BIND_ADDRESS_NO_PORT is useful when the application can defer port
allocation until connect(), but it changes this behavior: bind(..., 0)
does not reserve a port in that case. So it is not a replacement for
applications that need the local port before connect(), for example to
publish it to another component or set up local policy.

This patch is also intended to keep the bind(..., 0) path consistent =
with
Eric's earlier change in __inet_hash_connect().

Thanks,
Xuanqiang=

