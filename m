Return-Path: <netdev+bounces-297776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AzEaGGmSKWppZwMAu9opvQ
	(envelope-from <netdev+bounces-297776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858D66B886
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MtG7Pxbg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297776-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08CFA30D35A5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4D33F5B8;
	Wed, 10 Jun 2026 16:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4E32AAC6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:26:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108798; cv=none; b=WigdpNHEUQQBAnOgOpLx2IbGghJygXUVRQ8/aUc026rlMDgpBChMCkPRpslDZk49ZRhpqitOeFYWUvMSBI6rcCfVhrllOTka2B6QRUJ/lTB/dOB6YM8hlNuv7NMJWqSpzlWOc103DUgjosyE2UcfODLhUxdmJVQ0iKkQL2esQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108798; c=relaxed/simple;
	bh=GXGRj1R6e/yaSUmJYq2wZ7LEFvOQh4Xhk2ehY294tuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWzPMLVVLRaHt/3FOWXjZ5KRBxTwmAHfQWL8ICHUuUuFLLdtvo8PAava2uX78dYdXibwPTw3UBaRwrX2p2rbr2mpqOXnHJKa3PF2PxgqZJUWRhqdaTx6QFrE0ttgUiiccfEOjZLkBooLViayy8OPHMnYJgVj5JpXu3Wzk3BWygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtG7Pxbg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781108795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXGRj1R6e/yaSUmJYq2wZ7LEFvOQh4Xhk2ehY294tuc=;
	b=MtG7PxbgM7hB0h7WnEAGcNY+paDYMAfadhZ4W9Oe+wcDOJTJqgIObgJqIMzrJ/bE+C3Ptt
	b00UwBaEvh6vApo/vr+75TKvIMNVRfAfTzxS57HIsWEcCPS0Y4MyOv5DVHmrtc1Fx8hgmF
	IW5g3cBW0yrlYV+3sOihJ5R89ZL9Pp0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-pU5PK4CsN46QF5EWjhMXpw-1; Wed,
 10 Jun 2026 12:26:32 -0400
X-MC-Unique: pU5PK4CsN46QF5EWjhMXpw-1
X-Mimecast-MFC-AGG-ID: pU5PK4CsN46QF5EWjhMXpw_1781108790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86E91945CB5;
	Wed, 10 Jun 2026 16:26:30 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.89.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 284571800591;
	Wed, 10 Jun 2026 16:26:29 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink,
 audit: prevent false ENOBUFS on timeout expiry
Date: Wed, 10 Jun 2026 12:26:27 -0400
Message-ID: <3707933.dWV9SEqChM@x2>
Organization: Red Hat
In-Reply-To: <20260609143558.49d96656@kernel.org>
References:
 <20260513172443.1128496-1-rrobaina@redhat.com> <2756655.vYhyI6sBWr@x2>
 <20260609143558.49d96656@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgrubb@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:rrobaina@redhat.com,m:audit@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paul@paul-moore.com,m:eparis@redhat.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgrubb@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0858D66B886

Hello,

On Tuesday, June 9, 2026 5:35:58=E2=80=AFPM Eastern Daylight Time Jakub Kic=
inski=20
wrote:
> On Tue, 09 Jun 2026 13:40:23 -0400 Steve Grubb wrote:
> > > > You're right, it is. I see how this flag would fix the pathological
> > > > behavior that was reported. But as I have looked at this suggestion,
> > > > there seems to be one wrinkle. User space should not need to know
> > > > that
> > > > the audit code in the kernel has this retry mechanism.
> > >=20
> > > It's not about the retry mechanism, at least in my mind - I read
> > > your reply as "user space should not know that there was congestion".
> > > Why?
> >=20
> > In the audit case, it is not useful. I know there can be an endless
> > supply and there's not much that can be done except dequeueing what's
> > next.
> >=20
> > > It's not very useful, I get that, but user space can just clear
> > > the congestion signal and keep going.
> >=20
> > How? The recvfrom man page doesn't even discuss ENOBUFS. Which is one of
> > the strongest arguments for a kernel side patch. The fact that there is
> > exists a socket option to declare that you do not want ENOBUFS on
> > netlink sockets is esoteric knowledge. The netlink(7) man page does
> > cover the flag. But even where it discusses ENOBUFS, it does not mention
> > that this is preventable by setting a socket option. I do appreciate
> > this being pointed out. But getting from the recvfrom man page to a
> > solution is not obvious.
>=20
> socket errors are generally "consumed" when they are returned.
> The user space should see one ENOBUF=20

It does. The man page is unhelpful.

> and then once the rcvbuf is drained completely the CONGESTION bit should
> also get auto cleared. This is my mental model how Netlink works, LMK if
> you're seeing different behavior, my memory is faulty...

Well, yes that is normal for other netlink subsystems. And it looks like=20
we're not missing any magic cure. However, that congestion bit is what real=
ly=20
causes a major headache for the audit system because it has it's own retry=
=20
scaffolding. Auditd ack's each message so that the kernel side advances. In=
=20
any event, I patched auditd to set NETLINK_NO_ENOBUFS. It's not the solutio=
n=20
I hoped for, but if I understand what this does, it should solve our proble=
m=20
for auditd.

Thanks,
=2DSteve
=20
> > > > It seems like the audit subsystem should set the flag on auditd's
> > > > socket at registration time in auditd_set(). The kernel is the right
> > > > place for this because it's the kernel that manages the retry/ hold
> > > > queues and sets the sk_sndtimeo that triggers the overrun path -
> > > > auditd has no knowledge of these internals.
> > >=20
> > > We have to carry this code somewhere, either in user space or in
> > > the kernel. I'd prefer not to carry it in the kernel.
> >=20
> > I can put this in the audit daemon. But whoever else writes a similar a=
pp
> > will have to independently discover the same solution when faced with t=
he
> > pathologically bad behavior. A kernel side fix would have made it easier
> > for future app developers to be successful.





