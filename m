Return-Path: <netdev+bounces-256338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJYLFaoVgmmZPAMAu9opvQ
	(envelope-from <netdev+bounces-256338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E860BDB574
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E20FC30B06A2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE63B8BCE;
	Tue,  3 Feb 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO4EvauH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4222EFD9E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132760; cv=none; b=bjrt0KohYuix5nFmIUQvz5rakZxmPtV5m+yFOirWbVK+tzaHBFpZVfkG9VUf5O836sT/d/kdVOBTXVHWY0tl79XrvBHL6AguczDYl1P+8wGCS1moyh8syfY2aebMFxmldW3RkJv+0ZTRMmRXXNwLaoBuOvHQcy4hwK7diXjaRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132760; c=relaxed/simple;
	bh=9sWOhep21ch0Vat5rnWWwWnEVXUUG+imtNyTsiZUyfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnEQ50S3g8H8LQZYWtfpxNTOuMXAWhOx/ckOwY5jycURDzDNdBkTVXFC09w36haO4a2Yklos+U0vxh6gN14pWj9ljZGYISGod8QAzaKWYSg2KzltoD8UJFsI7ASbgLVMU18oHq1RgsnZHfbXQtr4HrEx3UA8OPxByFUPEff742k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO4EvauH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770132757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgir+Nhy1JREHjf60vszWew/AEWaJ4RJ2UIZ8jl+t1A=;
	b=VO4EvauHOlUZjr7Ll3vkrlGOmWMsZtHYjYxh6H/GZFBspqLfq+DoVjph0zNDwQO9gmy0EC
	g5l08kuk9GU8qyISKSaLT9A1jOtQO3ZsRT2/WPAwYGyRzlzHrEgzTxJ5bc9y3MNGUFgUxI
	omByRV1suP5RFeKQb33Ok9e8XcswzmI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Wwa-nPAjMO6kWPlQFjbGkw-1; Tue,
 03 Feb 2026 10:32:33 -0500
X-MC-Unique: Wwa-nPAjMO6kWPlQFjbGkw-1
X-Mimecast-MFC-AGG-ID: Wwa-nPAjMO6kWPlQFjbGkw_1770132751
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39210180057E;
	Tue,  3 Feb 2026 15:32:31 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C65919560B2;
	Tue,  3 Feb 2026 15:32:27 +0000 (UTC)
Date: Tue, 3 Feb 2026 16:32:24 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <aYIVCHouYi5h1dHU@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
 <20260129133217.xNoDm9nn@linutronix.de>
 <aYCK5Dczg_0tbuEA@thinkpad>
 <20260202164550.1TDNCEe_@linutronix.de>
 <aYHlhKiSh8YrXjT1@thinkpad>
 <20260203144903.ifAQ9Yh4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203144903.ifAQ9Yh4@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
	TAGGED_FROM(0.00)[bounces-256338-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E860BDB574
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:49:03PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 13:09:40 [+0100], Felix Maurer wrote:
> > I agree, the reboot case is safe because of the 500ms quiet period. But
> > I kinda fear a situation where a node sends a lot of packets (making
> > it's sequence number wrap within the 400ms), but only a small fraction
>
> wrap? A lot of packets means you force-recycle the oldest block. This
> doesn't have an impact on timing.
>
> > of that to us, so that we don't clear blocks because of a full buffer.
>
> Why does this make a difference? Are you describing it from PRP
> perspective? From HSR point of view, each node sees all frames. If you
> have HW support for de-duplication then you don't see duplicates.

Good point, I didn't state that explicitly. All of my reasoning was
based on a PRP perspective, where we don't necessarily see all frames.

> > That could make a block live pretty long, when we hit it multiple times,
> > which could in turn lead to valid, new frames being dropped. I'd say
>
> The block covers up to 128 frames and you have 64 blocks. This covers
> 8192 incremental seq-numbers and every block gets recycled 8 times until
> the seq-number overflow.
>
> I think you are afraid if a node sends 65536 packets in less than 400ms
> and the receiving node observes only a fraction of it (less than 8192)
> so it does not expire blocks by force. This may indeed lead to dropping
> "new" packets.
> But this should be only a PRP problem or also a HSR problem if the used
> sequence number has "random" increments.

Yes, that's about the scenario I'm considering (I very much agree it's
an edge case, though). At it's face, this is only a PRP problem.

But I think this PRP problem can extend into an HSR ring. The standard
describes how HSR rings can be coupled to a PRP network using two
RedBoxes in HSR-PRP mode. Assuming a node in the PRP network sends a
frame, if the RedBox knows the receiver is a node in the PRP network, it
will not inject the frame into the HSR ring.  Therefore, the MACs in the
PRP network could be appearing as nodes sending with random increments
in our HSR ring. Notably, we can't know if such RedBoxes exist in our
ring. Yeah, it's another condition that needs to be met, and the edge
case get's thinner.

Thanks,
   Felix


