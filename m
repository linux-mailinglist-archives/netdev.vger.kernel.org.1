Return-Path: <netdev+bounces-256273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FX2ClfqgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DED9062
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2AD2313629F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7163128D2;
	Tue,  3 Feb 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyiPcclb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24433FE0C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121444; cv=none; b=DDNSr/kFHDgfVLz+76VOxhSdHvPWDm3CvtU6Ijxv9lgBZu0l/iBQd/aXHAtNY84DDppRVARVo2uub2oDTkscKplLrOB4/dcmhKGM/FpcMb7uJLaHmutcf8fwBJcFRUHCI642jsdZO31qKy+zTk0eo1ZH+1A7nuavagWYSnnHOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121444; c=relaxed/simple;
	bh=JmC3o7t+ZDZfPLPPdFtV+BoPLkKHQN8OC4Lcvdj+DqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMQitA1MpcJVN/sTCwy/eMo4Z5ocUeHMGh9QqnhgPLLUQ6bGZckehd+CVgXovXPRrR873Hm/WMMJMIkvG63j8tgeQk0pX59SzcNHoNUXjNkIA4B3ayfA3NzwccDzttOqVrIOKsTyTRu2uqweboJbFypNDqd604qEMxZPieRdjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyiPcclb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770121441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nydlJhhd54DuyndBF+Yma/53jn9dbImQ+yXAYDAQ1wM=;
	b=fyiPcclbEE3FBehmnM9y8S16piLLMjZlpHZM+Suea1dlYPdbzVFY+/ASHkNrtl+9SdEL9b
	v9VYMnrxZD0+p78Jqw22WnpgqUNrAlpe4NULlUuz3o8HW0ZemoeGuyc3qKFQ7/f+gkg8SC
	9pEFhk+lI7pd0lwKO9QXtPkhKRtOFoI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-GP5TsYLONsC-QScNlYLNQQ-1; Tue,
 03 Feb 2026 07:23:58 -0500
X-MC-Unique: GP5TsYLONsC-QScNlYLNQQ-1
X-Mimecast-MFC-AGG-ID: GP5TsYLONsC-QScNlYLNQQ_1770121437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA1C618002C8;
	Tue,  3 Feb 2026 12:23:56 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB33180009E;
	Tue,  3 Feb 2026 12:23:53 +0000 (UTC)
Date: Tue, 3 Feb 2026 13:23:50 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aYHo1uEK2e8Vg4WM@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
 <20260202155510.C1zpsxnk@linutronix.de>
 <aYHJ9KHdiBEGfjwA@thinkpad>
 <20260203115526._PRE3nvY@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203115526._PRE3nvY@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256273-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885DED9062
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:55:26PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 11:12:36 [+0100], Felix Maurer wrote:
> > On Mon, Feb 02, 2026 at 04:55:10PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-02-02 12:51:12 [+0100], Felix Maurer wrote:
> > > > > Hm, I am not sure? For PRP, it's an explicit requirement to use the same
> > > > > MAC addresses for both ports. For HSR, I think the standard is less
> > > > > clear about the MAC addresses. And at least our code seems to assume
> > > > > that there could be different MACs on the two interfaces of a node? But
> > > > > yes, the node merging addresses this.
> > > >
> > > > I'm still not 100% certain, but I agree that the standard reads more
> > > > like the MAC addresses should be the same for the two HSR ports. At the
> > > > moment, the kernel and the test assumes that they can/should be
> > > > different. Therefore, I think we should fix this across the board in
> > > > another patchset if we agree that's the right thing to do.
> > >
> > > I would suggest to do so. This could serve as bad example and my PTP
> > > userland patches expect the same MAC on both ports. So ;)
> >
> > I'll put it on my list for another patchset :)
> > But this of course brings up how the MAC addresses should be handled on
> > the HSR interfaces in general. At the moment, for HSR we copy the MAC of
> > portA to master. For PRP, the MAC of portA is copied to master and
> > portB.
> >
> > If the MACs should be the same for both ports of an HSR interface,
> > should we set them when creating the HSR interface, similarly to PRP?
> We do this?

We didn't always do this, but since b65999e7238e ("net: hsr: sync hw
addr of slave2 according to slave1 hw addr on PRP"), we are doing this
for PRP.

> > And does it make sense to copy from portA (feels somewhat arbitrary to
> > me) or would it be cleaner to copy from master to portA and portB?
>
> I do
> | ip link set $portA down
> | ip link set $portB down
> | ip link set dev $portA address $mac
> | ip link set dev $portB address $mac
> | ip link add name $if type hsr slave1 $portA slave2 $portB supervision 45 version 1
>
> and then up, up, up to get up the three interfaces functional. $mac is
> the MAC $portA.
>
> On the other hand it shouldn't matter because while adding the HSR tag,
> the MAC of the hsr interface should be taken but somehow I observed that
> packets, which originate on the $portB interface have the MAC address of
> this interface. So I did this and forgot about it later…
> But then hardware offloading might behave different if it considers the
> address of the interface so it might required to set the MAC address.
>
> I am uncertain what the best practice would be here.
> Forcing the MAC of portA to portB could be done at setup phase by the
> stack but would require that the interface is down…

I think that's a pretty common series of setup steps, yes. But as even
we are not sure how the MAC addresses should be set, I think we should
not expect that users will configure this correctly, but do the right
thing(tm) automatically.

But like you, I'm uncertain what would be the right thing to do and
which port should control the MAC for all the others.

Thanks,
   Felix


