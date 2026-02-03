Return-Path: <netdev+bounces-256234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKHxAibKgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:12:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C94D7610
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC8E30125DB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3939C63B;
	Tue,  3 Feb 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEbFE3Re"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAB303CB6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113571; cv=none; b=n3aIOmkqnCVIVtDpjOP6ZoTSzKOD9hi6fvK0pQYuB82XahpgOGX4sBB/fMfeGu/oYbB/WGc3xboaC0i2ma6OllK6LR5kWFNuL4aFSbXGsTPDUrgd/4HRwyPHBT4YJqFPryXXEd9uum0mHDGjG3MSV/1FIrOQxHRug2Uq/Sx2zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113571; c=relaxed/simple;
	bh=DnvSTSv7LBx+Vzu1CvkDgGdKvfZghPhdaJxtfT+MCqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFiwQniCjykykpgWC7gIJN7lkSCX1rwPW4nSIMOJvBujTyobb0/e0fF8EzQJzEIg79IDZHvjzu/saoi6ZVgvUkR8P9rVy34q1GKHQK+ThLcSaafRqSmN1ndivZbB0BjlFF9uP8Y5Mf5du7IZUtpuTk4IcqnL4VmdABc6SwwCbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEbFE3Re; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770113568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP1IfYkUQ7uY1f69gZHH45lNWuRMCFoJZjwdxVzExvE=;
	b=VEbFE3ReTNrnqtr3GzRQn4dpzpNbv3Tmir4Wm7n25+ytIhx2tjJ3FhJX5EC4gtVZ1V1uKQ
	YrcJTCQICtZ/mTJdG0F/tRM4uwczmye8tpeY/C60IPx5FHPWPwpkLTM652wtzSZ8WRk26V
	aQI0bNgYDWmpDLUee/ClelXbjU1MjiI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-0y91T9zWNUO2rMCnxhDWaA-1; Tue,
 03 Feb 2026 05:12:45 -0500
X-MC-Unique: 0y91T9zWNUO2rMCnxhDWaA-1
X-Mimecast-MFC-AGG-ID: 0y91T9zWNUO2rMCnxhDWaA_1770113563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4525B19560B7;
	Tue,  3 Feb 2026 10:12:43 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A1431956053;
	Tue,  3 Feb 2026 10:12:39 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:12:36 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aYHJ9KHdiBEGfjwA@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
 <20260202155510.C1zpsxnk@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202155510.C1zpsxnk@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256234-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 61C94D7610
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 04:55:10PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-02 12:51:12 [+0100], Felix Maurer wrote:
> > > Hm, I am not sure? For PRP, it's an explicit requirement to use the same
> > > MAC addresses for both ports. For HSR, I think the standard is less
> > > clear about the MAC addresses. And at least our code seems to assume
> > > that there could be different MACs on the two interfaces of a node? But
> > > yes, the node merging addresses this.
> >
> > I'm still not 100% certain, but I agree that the standard reads more
> > like the MAC addresses should be the same for the two HSR ports. At the
> > moment, the kernel and the test assumes that they can/should be
> > different. Therefore, I think we should fix this across the board in
> > another patchset if we agree that's the right thing to do.
>
> I would suggest to do so. This could serve as bad example and my PTP
> userland patches expect the same MAC on both ports. So ;)

I'll put it on my list for another patchset :)
But this of course brings up how the MAC addresses should be handled on
the HSR interfaces in general. At the moment, for HSR we copy the MAC of
portA to master. For PRP, the MAC of portA is copied to master and
portB.

If the MACs should be the same for both ports of an HSR interface,
should we set them when creating the HSR interface, similarly to PRP?
And does it make sense to copy from portA (feels somewhat arbitrary to
me) or would it be cleaner to copy from master to portA and portB?

Thanks,
   Felix


