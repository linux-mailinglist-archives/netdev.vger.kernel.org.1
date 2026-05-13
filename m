Return-Path: <netdev+bounces-287673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICPxG/CgBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A615536B5C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C6C3023BF8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE04968EF;
	Wed, 13 May 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A10Sm5nC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D1314A73
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687764; cv=none; b=mUqwbwrEnmnHL9JdSzYnX6exQg3pX7uyTd2sji4wGK+wBcI4e0tLsSyYcIby0iAubjQWyIjwdPlPm9Q7wy453mQpNzp/KPhhBLTjueEOqIByqVaVz/gjwyM+Mw1e8etiYtv2Yzfwa86oLUMjQU0ZRA0fJEyJA+fxHSFcKs4S1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687764; c=relaxed/simple;
	bh=n7Ws94gxeaCRFtf3TF8uVIiRZHvc/e1UvuieOeTg8/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeZVRBJ5T0Y5J7WnkIxLTxsnN2KSi2O+v4gf2jJYyAw+MPZgIWXqDOpn1I8zbDTe7VFw+gXnMQ27/q4J0Ejz4m0o6Dbc+DFMMpNvuFVrWWPB+65xe5gYB4fwWmPEo/UhSUMvbQUfv2d/2TNLVyn5UcS0y5ez2ed+AJMv1vEw/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A10Sm5nC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778687762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfaTsBVptCeA0QuBzTDUKxyGUiuTsN+d73fyP8TMEMg=;
	b=A10Sm5nCI/gskoPvhdpyC6qBhdjlc4z6yCBJNoq87QQgAMcO74AeFdHFUCH6tNPL1zq3iQ
	RoOZfnmUhnglc2r3QFrPA6oRkwH8cK1AeEuf9TqAWQ0yvDmFGaxcxy+82eAaVvJN/ccCxb
	gi5lh+Lx4LSFsL8kyRFk1I/bt8MJ084=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-VDKQFgU_MDuDVSxLGFMDEw-1; Wed,
 13 May 2026 11:55:58 -0400
X-MC-Unique: VDKQFgU_MDuDVSxLGFMDEw-1
X-Mimecast-MFC-AGG-ID: VDKQFgU_MDuDVSxLGFMDEw_1778687756
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A549195605F;
	Wed, 13 May 2026 15:55:56 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1A831953947;
	Wed, 13 May 2026 15:55:52 +0000 (UTC)
Date: Wed, 13 May 2026 17:55:49 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: add tests for PPPoL2TP
Message-ID: <agSfBWQorPHodayz@thinkpad>
References: <20260508032158.67887-1-qingfang.deng@linux.dev>
 <af4czAjnz--nOUYf@thinkpad>
 <a8036fda-3509-437e-b787-4376992a0359@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8036fda-3509-437e-b787-4376992a0359@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 5A615536B5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 09:13:58AM +0800, Qingfang Deng wrote:
> On 2026/5/9 1:26, Felix Maurer wrote:
> > Is there a particular reason to create the test setup with a netkit pair
> > instead of the more standard veth pairs?
>
> L2TP does not need an outer ethernet header so I choose netkit instead of
> veth.

I see, thanks. In my opinion, sticking to the same environment setup for
as many selftests as possible, i.e., using veth pairs everywhere, has
more benefits in terms of maintenance of the test than leaving out the
ethernet header has. Also, while I understand that selftests are only
supported on systems that run with the respective selftest kernel
config, I still think it's good to stick to veth as it is probably
available in more kernel builds (think resource constrained
envrionments, older kernel versions, etc.).

But in the end, it's up to you and the maintainers. However, if you
stick with netkit, please name the interfaces explicitly and don't rely
on the current auto-assigned name of the peer interface.

Thanks,
   Felix


