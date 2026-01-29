Return-Path: <netdev+bounces-254879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO2+J56ce2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:45:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17333B32A7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9CC1300796A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC93542D1;
	Thu, 29 Jan 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwiovnUn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983C31AAA7
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708700; cv=none; b=hfFcyA+T1yaV+6UIN2vMbXeLXb/nW7Fnu2WfClS6GM5dnG0ykwzsMdUkx+HttnCDIwUbomU2oXUvvdlUeOZiLNRCwAXME1NzM5PwuXblDY+d4pyZLlXLIyxqLg3U99CsF9fPgMU25RZsUMmq6HHJ37hyTjfi1RwbN3Av5Ib41e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708700; c=relaxed/simple;
	bh=lMlrE+/IhNWGEiQ1f0WiQ3BpNW/hc2eYXXehWYp84lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvGpPkWooGH1tJjfkNsxw+TMgNs2yMX7PxA2GjUpGISzGjGnlZTIp0Ygr4PzE1o2Eh2aB18Twj2KL3RC451A5GLhvCjda24XlQ6z4qKbIqrMnw47QtXkSmJG2iISAiZ9FKDgUPPlOXtf8xy+QWzmGpwvwzxJuRANygZk7P2zmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwiovnUn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769708697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4nPj2k60GBojm5NALeJxRrEOs4k6ywkrMeIM3W3xJE=;
	b=FwiovnUngd+xHMzyKA+a8t/GDdJ2kLbrCIyRB4IdwjfqwM5msWsNp17sz/FMp+dV+o66nn
	8gcRaRYEmQRiOXihlCO8AP3nqjKh4WUeQgbKqV+O+Hjqq6zYJNxqL3sUkeE86EcL99GUsb
	89J15natkaYOyg1QcIveAnLNNwNnJBI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8ZLR_43qPUKuutzKmIGXXA-1; Thu,
 29 Jan 2026 12:44:56 -0500
X-MC-Unique: 8ZLR_43qPUKuutzKmIGXXA-1
X-Mimecast-MFC-AGG-ID: 8ZLR_43qPUKuutzKmIGXXA_1769708694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E93D1956080;
	Thu, 29 Jan 2026 17:44:54 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A451819560A7;
	Thu, 29 Jan 2026 17:44:50 +0000 (UTC)
Date: Thu, 29 Jan 2026 18:44:47 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aXucj8L-cBUVIYHX@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129152149.dKwN1yGM@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254879-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17333B32A7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:21:49PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-29 14:31:30 [+0100], Felix Maurer wrote:
> > On Thu, Jan 29, 2026 at 12:05:00PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-22 15:56:56 [+0100], Felix Maurer wrote:
> > > > diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/selftests/net/hsr/prp_ping.sh
> > > > new file mode 100755
> > > > index 000000000000..fd2ba9f05d4c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/net/hsr/prp_ping.sh
> > > …
> > > > +	# MAC addresses will be copied from LAN A interface
> > > > +	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
> > > > +	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
> > >
> > > so I somehow started this (I think) but while browsing the spec it
> > > somehow says that the same MAC address should be used on both ports.
> > > Could it be?
> > > It says that the two frames are identical except for the LAN field and
> > > checksum. Also the duplication is defined on src-MAC + seq nr.
> > > Having this requires to merge the two MACs for a node and we do this but
> > > could this be a left over from an older version of the spec or a
> > > behaviour that was not meant happen?
> >
> > Yes, for PRP it is required that both ports, A and B, of a node send
> > with the same MAC. For us that means that the two ports need to be
> > configured with the same MAC address. This used to be a common source of
> > configuration errors. Therefore, b65999e7238e ("net: hsr: sync hw addr
> > of slave2 according to slave1 hw addr on PRP") made it so that we are
> > now copying the MAC from port A to port B.
> >
> > Therefore, I'm only setting the MAC of vethA on each node in the test.
> > Even this is not strictly necessary but it turns out that debugging is a
> > lot simpler, when it is obvious addresses belong to which node.
>
> Looking at the hsr tests, those have two different macs… It should be
> the same. It works because it merges the nodes and lookup works for
> both…

Hm, I am not sure? For PRP, it's an explicit requirement to use the same
MAC addresses for both ports. For HSR, I think the standard is less
clear about the MAC addresses. And at least our code seems to assume
that there could be different MACs on the two interfaces of a node? But
yes, the node merging addresses this.

I'll take another look at this topic tomorrow.

Thanks,
   Felix


