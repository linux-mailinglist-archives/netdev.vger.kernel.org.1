Return-Path: <netdev+bounces-255095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACMqOmGJfGmbNgIAu9opvQ
	(envelope-from <netdev+bounces-255095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F755B968E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00E863004617
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799E32B99E;
	Fri, 30 Jan 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehJyMnGn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DA2F0C7F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769311; cv=none; b=U5k0tD50li6/DR0oCmXM6q6edscpHT2U9Xn3MPWF6/b2Wht/7MxZjrvEVtw/WRPca3Qu/CfXsbMAQBP+AQ0x73fFaxpgtbNf7n7dlxdGMyjjRf62IBEJQGZIKpTsIWUsepSP2zpuw0CSZHxMNIjlMmTbpNbTMz4Hkz5Ry+2rM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769311; c=relaxed/simple;
	bh=pInq3nYo2aIvkLqD1iP+GB2C4CFLtloDcyYkgYVwpNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFpzdH9vYU0RlEUM7n9uLXBezJ7zBBSH2ZpkkZ5uHHXvm/tDCGtc7/dwaj8qnj0/+T1lZRTRcaZ6Rm7S90179mMSByKlNSsoh6bx0AsZDSXa7U9vNf0x0ytFUKOqD2tLepdFiZ7KgoWTQh88NqbL8cDxMMGSrfTSEnw2MfElKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehJyMnGn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769769308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO/64yNVs5PmscdVfUWxzm7PpbROaEkKZpAus+RTrmg=;
	b=ehJyMnGnzdu5QgXDkzeGRkC64Dboh8axV9rkVUs+V5mAJweBkIbBnO1a3seiT1s1KdGb9H
	jzEhRGCIyn+UQhDa11NCPQcg+gRkAD6xhC2vofqi4RoT2ccGbDkt13QJ5wujoCMCDgpLTW
	y7m6RCSbHI5MEQp7sfp+ZU4Cro+3d7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-p6Pr3cvYMM69U_oWaVMhzA-1; Fri,
 30 Jan 2026 05:35:05 -0500
X-MC-Unique: p6Pr3cvYMM69U_oWaVMhzA-1
X-Mimecast-MFC-AGG-ID: p6Pr3cvYMM69U_oWaVMhzA_1769769303
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6233F1954B0C;
	Fri, 30 Jan 2026 10:35:03 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E30003000218;
	Fri, 30 Jan 2026 10:34:58 +0000 (UTC)
Date: Fri, 30 Jan 2026 11:34:55 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <aXyJTzwJ3x34B-xR@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <aXugXpSajp6jzG1o@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXugXpSajp6jzG1o@thinkpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255095-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F755B968E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:01:02PM +0100, Felix Maurer wrote:
> On Thu, Jan 29, 2026 at 05:17:04PM +0100, Felix Maurer wrote:
> > On Thu, Jan 29, 2026 at 03:43:48PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-22 15:57:01 [+0100], Felix Maurer wrote:
> > > …
> > > > As the problem (we accidentally skip over a sequence number that has not
> > > > been received but will be received in the future) is similar to PRP, we can
> > > > apply a similar solution. The duplicate discard algorithm based on the
> > > > "sparse bitmap" works well for HSR if it is extended to track one bitmap
> > > > for each port (A, B, master, interlink). To do this, change the sequence
> > > > number blocks to contain a flexible array member as the last member that
> > > > can keep chunks for as many bitmaps as we need. This design makes it easy
> > > > to reuse the same algorithm in a potential PRP RedBox implementation.
> > >
> > > I know you just "copy" the logic based on what we have now but…
> > > Why do we have to track the sequence number for A, B and interlink? The
> > > 'master' port is what we feed into the stack so this needs to be
> > > de-duplicated. I am not sure how 'interlink' works so I keep quiet here.
> > > But A and B? There shouldn't be any duplicates on A and B unless the
> > > destination node forwards the node. Or do I miss something?
> > > I'm bringing this up because limiting to one (or two since I am unsure
> > > about interlink) would save some memory and avoid needless updates. And
> > > if you have HW-offloading enabled then you shouldn't see any packets
> > > which are not directed to _this_ node.
> >
> > About the interlink: that's the interface where you attach devices that
> > know nothing about HSR, i.e., when we are a RedBox. I consider it very
> > similar to the master port, it's our responsibility to de-duplicate what
> > we send out there.
> >
> > I was thinking about exactly this while working on the patch as well and
> > I came to each conclusion (A,B are needed vs. are not needed) at least
> > once. In the end, I think we will need it. It's right that a well
> > behaving node in the ring should not forward "frames for which the node
> > is the unique destination" (5.3.2.1). But there could be frames that
> > have no unique destination in the ring at all: multicast frames or
> > frames addressed to a non-existing MAC address. We should not forward
> > such frames either to prevent them from looping forever.
> >
> > Now, such frames should probably only reach back to us, if we sent them
> > (either from our stack or from the interlink port). We could track
> > sequence numbers sent to master and interlink (for de-duplication) and
> > sent by master and interlink (for loop prevention) for more clarity, but
> > then we're back at four bitmaps again.
>
> Please disregard this. If we are the source, we can easily detect it
> from the frame. I'll consider this again. Like I wrote, I'm jumping
> between necessary and not.

I took another look at this. I think the IEC 62439-3:2021 is not super
clear on this (it often refers to "duplicate frames" without being exact
about in which domain they are duplicates). But the section on HSR Modes
(5.3.2.1) is quite telling when all modes are read in combination.

First, there is the mode H, which is the default and mandatory to
implement. In this mode, a node should forward all frames "except for
frames sent by the node itself, duplicate frames and frames for which
the node is the unique destination". Note that "duplicate frame" is not
further specified here. As we don't implement different modes, we should
follow mode H in our implementation.

In contrast, there is also mode X (sometimes referred to as "traffic
reduction").  It is supposed to work like mode H, but without sending
"counter-duplicates", i.e., frames that are "a duplicate of a frame that
it received [...] from the opposite direction."

To me, this means two things for mode H, i.e., what we should be doing:
- For a frame with one sequence number coming from one node, we should
  be forwarding the frame once in each direction.
- There could be duplicates of these frames in either direction that we
  should not forward. This is also hinted at in other parts of the
  standard, that there could be multiple duplicates, especially when HSR
  rings are coupled.

Therefore, I think it is correct to do the duplicate tracking once for
each port, especially separately for port A and port B.

Thanks,
   Felix


> > I agree that we can and should optimize the HW-offloaded case. I'd
> > suggest to do that in a separate patchset, though, partly because I
> > don't have access to a hardware with HSR offload at the moment.
>


