Return-Path: <netdev+bounces-254882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEhsA3ege2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:01:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF3B357B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D506C3003ECD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0027B32C;
	Thu, 29 Jan 2026 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glIWdAtM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC21E505
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709679; cv=none; b=U/9jX1MynWRi4IxQISc74YV/cwW3tE9XHLBL9ioblOCiq+ZHBgq5zZm57U1ovX3/+9A+mO0h1kF4JtlE+ssHuWbAr1KibdhjXv56JYDXZdD7NVdoJmDlmfNbeCLPB1PfSkxkdpiEdE21pRJfdx2nwSaBxvzxscYV5DYzZJrn6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709679; c=relaxed/simple;
	bh=hqnz2Yka0+yMYOwwaVJuFR9fXZgvZ8rWgU4ZRSas4u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM3+9EU8MfXKeE0w+6Ki9sBro7fYt2CirFoiQ2L9tT8dic2OJV7+3IZxBW0rHzyDSxur8KfV6oCE37qSe0Y3kHa1HNbrY1vBIKF9dmAmxGms+oDjjK/xIZC4r149UNQmx021nsczLFJifuBUmOkCy935T+l2SKj64OqrsIDP50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glIWdAtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769709676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlWDdID/lECf2P9dbap2F+3Rq4t6lYfBbzsoNu3m0IM=;
	b=glIWdAtM0YLMzcJSoVGvcVhnsx760lem92zV6ff4UvlN9V0xxjrHr/69PBIcqQP/mkwynd
	GHSWuJqnhc/nVtYqmwvl1iZvadfD1K5d3U+/dngFpa4bbCAf/BWK61FYnrwEHgT/62ZcYN
	SWlhNJiLjXIaLpZzf5+kyw29/0f0UXo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-3D8K8-c4PtCKXYNb-cudqw-1; Thu,
 29 Jan 2026 13:01:11 -0500
X-MC-Unique: 3D8K8-c4PtCKXYNb-cudqw-1
X-Mimecast-MFC-AGG-ID: 3D8K8-c4PtCKXYNb-cudqw_1769709669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 799021800372;
	Thu, 29 Jan 2026 18:01:09 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CA371955F43;
	Thu, 29 Jan 2026 18:01:05 +0000 (UTC)
Date: Thu, 29 Jan 2026 19:01:02 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <aXugXpSajp6jzG1o@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXuIAFJ_m6gMUFFO@thinkpad>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254882-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62DF3B357B
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:17:04PM +0100, Felix Maurer wrote:
> On Thu, Jan 29, 2026 at 03:43:48PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-22 15:57:01 [+0100], Felix Maurer wrote:
> > …
> > > As the problem (we accidentally skip over a sequence number that has not
> > > been received but will be received in the future) is similar to PRP, we can
> > > apply a similar solution. The duplicate discard algorithm based on the
> > > "sparse bitmap" works well for HSR if it is extended to track one bitmap
> > > for each port (A, B, master, interlink). To do this, change the sequence
> > > number blocks to contain a flexible array member as the last member that
> > > can keep chunks for as many bitmaps as we need. This design makes it easy
> > > to reuse the same algorithm in a potential PRP RedBox implementation.
> >
> > I know you just "copy" the logic based on what we have now but…
> > Why do we have to track the sequence number for A, B and interlink? The
> > 'master' port is what we feed into the stack so this needs to be
> > de-duplicated. I am not sure how 'interlink' works so I keep quiet here.
> > But A and B? There shouldn't be any duplicates on A and B unless the
> > destination node forwards the node. Or do I miss something?
> > I'm bringing this up because limiting to one (or two since I am unsure
> > about interlink) would save some memory and avoid needless updates. And
> > if you have HW-offloading enabled then you shouldn't see any packets
> > which are not directed to _this_ node.
>
> About the interlink: that's the interface where you attach devices that
> know nothing about HSR, i.e., when we are a RedBox. I consider it very
> similar to the master port, it's our responsibility to de-duplicate what
> we send out there.
>
> I was thinking about exactly this while working on the patch as well and
> I came to each conclusion (A,B are needed vs. are not needed) at least
> once. In the end, I think we will need it. It's right that a well
> behaving node in the ring should not forward "frames for which the node
> is the unique destination" (5.3.2.1). But there could be frames that
> have no unique destination in the ring at all: multicast frames or
> frames addressed to a non-existing MAC address. We should not forward
> such frames either to prevent them from looping forever.
>
> Now, such frames should probably only reach back to us, if we sent them
> (either from our stack or from the interlink port). We could track
> sequence numbers sent to master and interlink (for de-duplication) and
> sent by master and interlink (for loop prevention) for more clarity, but
> then we're back at four bitmaps again.

Please disregard this. If we are the source, we can easily detect it
from the frame. I'll consider this again. Like I wrote, I'm jumping
between necessary and not.

Thanks,
   Felix


> I agree that we can and should optimize the HW-offloaded case. I'd
> suggest to do that in a separate patchset, though, partly because I
> don't have access to a hardware with HSR offload at the moment.


