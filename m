Return-Path: <netdev+bounces-255844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPleJBCLgGnO9wIAu9opvQ
	(envelope-from <netdev+bounces-255844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:31:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E97CBAAB
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BE03022621
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AA3624D3;
	Mon,  2 Feb 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N66S74+o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A113624A3
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031858; cv=none; b=lbrCbo/RwYtFP61U40JhXu117O7GEx6OG5O0kqRkwSPLMMAmu+YbPK6o99mTk8E3i7HslNIPZENFwcj5KDdSIre9DJEh6ylqezfI0pg1pKFUs9OgslPH06BiG9QVp+bbCyoebmdXQXCgS2p4oUQeDHCrXszvngIJWXk1VNpHXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031858; c=relaxed/simple;
	bh=i2Lgk8oY2JEF8F21tGM3+u1FdkvAXBzchBLAiGxc3NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeBSaRoIodr83k3xmR/oxGT281lJfHIpVDkSy8+15qBh+U67AAb/qHOMMUpi2Lpf0+cV6WgAk+GUXxXNlVUlQLPxqGUifxDlcNZlbJWk1ShT9r0VFo/89MJu3JVFsr3skCWMEU22bYrqEBbzr+WGqhJWxQOolWFja4pVYVw9xRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N66S74+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770031856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu7lsKCbclEnruBJpuzF4ShVJxdVhrn3aSCbruUCHTE=;
	b=N66S74+oYYjrV87rMe6zH4vVoj6swx7Rb9Wuzb5xzas7iJuKvluOPbmfA10JUAHzB6is5B
	NzUeUuEkbCc6RMfJ6iAvn8wReEQ91ydV52X4kOv99jkQyDcnSKnzqFuMKA2mL5/HLnkhmh
	jQrPHrnkgWOyYkj7M4A9V5Vk2GqNRww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-T1YurJWVO0uyqrzlPVRLQA-1; Mon,
 02 Feb 2026 06:30:52 -0500
X-MC-Unique: T1YurJWVO0uyqrzlPVRLQA-1
X-Mimecast-MFC-AGG-ID: T1YurJWVO0uyqrzlPVRLQA_1770031851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CACE41956052;
	Mon,  2 Feb 2026 11:30:50 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3208E1800285;
	Mon,  2 Feb 2026 11:30:46 +0000 (UTC)
Date: Mon, 2 Feb 2026 12:30:44 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <aYCK5Dczg_0tbuEA@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
 <20260129133217.xNoDm9nn@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129133217.xNoDm9nn@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255844-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30E97CBAAB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:32:17PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-22 15:57:00 [+0100], Felix Maurer wrote:
> > Add tests where one link has different rates of packet loss or reorders
> > packets. PRP should still be able to recover from these link faults and
> > show no packet loss.  However, it is acceptable to receive some level of
> > duplicate packets. This matches the current specification (IEC
> > 62439-3:2021) of the duplicate discard algorithm that requires it to be
> > "designed such that it never rejects a legitimate frame, while occasional
> > acceptance of a duplicate can be tolerated." The rate of acceptable
> > duplicates in this test is intentionally high (10%) to make the test
> > stable, the values I observed in the worst test cases (20% loss) are around
> > 5% duplicates.
>
> Do you know why we have the duplicates? It is because of the high
> sending rate at which point the blocks are dropped and we can't
> recognise the duplicate?

I could not give a definitive answer on this last week, I had to dig a
bit and think through this. The reason for the duplicates is not a high
sending rate leading to dropped blocks. Rather, it's the low sending
rate leading to expiring blocks: in the test, the ping interval is set
to 10ms. As the blocks expire based on the timestamp of the first
received sequence number, the 400ms entry expiry gets hit every ca. 40
frames, at which we basically clear all received sequence number in the
block by creating a new block. This happens on both nodes (for ping
requests and replies) ca. 10 times during the test, leading to about 20
duplicate packets, which is the ca. 5% duplicates I observed in multiple
runs of this test.

This means the duplicate rate is highly dependent on the traffic pattern
and the test manages to hit exactly this situation. I'll add the
explanation to the message in v3. If similar traffic patterns are hit in
the real world too often, we could test different block sizes. I just
did this and the results are as expected:
- 64 bit blocks: the duplicate rate is about the same because the block
  still expires once.
- 32 bit blocks: the duplicate rate drops to around 4% because,
  including the netem delay in the test, this is roughly the edge
  between expiring a block and already hitting a new one. But if we keep
  the bitmap as it is, we waste 50% of memory.
- 16 bit blocks: duplicate rate is zero because we use new blocks way
  before the expiry time. But this wastes about 75% memory for each
  block and the overhead of the timestamp in each block gets quite
  significant.

I'd suggest to keep the 128 bit blocks to have a chance to detect
duplicates at higher data rates for some delay difference (up to about
5.5ms with 1Gbit/s). 64 bit blocks would halve the maximum delay
difference, but probably still strike a good balance between memory
overhead and duplicate rate. Do you prefer one over the other?

Thanks,
   Felix


