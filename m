Return-Path: <netdev+bounces-255849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ+SEi2QgGkl+wIAu9opvQ
	(envelope-from <netdev+bounces-255849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:53:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95904CBEFE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF1330057A4
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3035BDBF;
	Mon,  2 Feb 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPBVxsXH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE72D2488
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033086; cv=none; b=SY/sC9+y99PERnEVurWBzaCJg6uhTLdOLEUhb1VLPVoHP/qLwyAoOo63gO7VxpJWc1XjuhU2HzfrZ3PWYWaOketMP8+BYZgIBBiYu5EYT2xAqWOWaIiQ+AxhLVB/7q4iD5qo/sF8pOZS9ird6ePbHgEqwkSs+W2YOIIPaFI9eWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033086; c=relaxed/simple;
	bh=MPi7GbCYaa9rT0YkGWnZoFnEVFVhIGaMKksyCGXdSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cACOEjkR9mpwGeaedFRQwT/N31D1iQJ5dh2EiiaVnjs+MoUoNwAAg16Aka7ydMmCEln9w0xEt6CJ4Jo1S60pJyCLnDX6/PN7eCUA8UpdqGqUVzLADtWr7OBAaVsKTbB5ywLQ0H9ASJaNrjANGkQjCv1dgbhd6wAGBWleRmCjxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPBVxsXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770033084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNxBwERH2+cu5UqQ+RfCEPHG9ZT3KmD9qTqIml/0Oo0=;
	b=LPBVxsXHkvludjXyzxIExs46sl4oHNHTTl+KWU35jmkA0unyfeRKnX+CckX4xToeXn7FUd
	SVkAkzlQGfNUummuNgJw5spa4+1uet8xD0twqXT/nDz87QMyKP8g3e2MF8gOrr8LLEsb0p
	n2nMAY2UDsH5aDZMdOxovId13AbSEek=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-xUxLb_QOPPavjeajt816Tg-1; Mon,
 02 Feb 2026 06:51:20 -0500
X-MC-Unique: xUxLb_QOPPavjeajt816Tg-1
X-Mimecast-MFC-AGG-ID: xUxLb_QOPPavjeajt816Tg_1770033079
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F381956050;
	Mon,  2 Feb 2026 11:51:19 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 716261956053;
	Mon,  2 Feb 2026 11:51:15 +0000 (UTC)
Date: Mon, 2 Feb 2026 12:51:12 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aYCPsDZeJvCrJYRH@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXucj8L-cBUVIYHX@thinkpad>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-255849-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 95904CBEFE
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:44:47PM +0100, Felix Maurer wrote:
> On Thu, Jan 29, 2026 at 04:21:49PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-29 14:31:30 [+0100], Felix Maurer wrote:
> > > On Thu, Jan 29, 2026 at 12:05:00PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2026-01-22 15:56:56 [+0100], Felix Maurer wrote:
> > > > > diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/selftests/net/hsr/prp_ping.sh
> > > > > new file mode 100755
> > > > > index 000000000000..fd2ba9f05d4c
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/net/hsr/prp_ping.sh
> > > > …
> > > > > +	# MAC addresses will be copied from LAN A interface
> > > > > +	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
> > > > > +	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
> > > >
> > > > so I somehow started this (I think) but while browsing the spec it
> > > > somehow says that the same MAC address should be used on both ports.
> > > > Could it be?
> > > > It says that the two frames are identical except for the LAN field and
> > > > checksum. Also the duplication is defined on src-MAC + seq nr.
> > > > Having this requires to merge the two MACs for a node and we do this but
> > > > could this be a left over from an older version of the spec or a
> > > > behaviour that was not meant happen?
> > >
> > > Yes, for PRP it is required that both ports, A and B, of a node send
> > > with the same MAC. For us that means that the two ports need to be
> > > configured with the same MAC address. This used to be a common source of
> > > configuration errors. Therefore, b65999e7238e ("net: hsr: sync hw addr
> > > of slave2 according to slave1 hw addr on PRP") made it so that we are
> > > now copying the MAC from port A to port B.
> > >
> > > Therefore, I'm only setting the MAC of vethA on each node in the test.
> > > Even this is not strictly necessary but it turns out that debugging is a
> > > lot simpler, when it is obvious addresses belong to which node.
> >
> > Looking at the hsr tests, those have two different macs… It should be
> > the same. It works because it merges the nodes and lookup works for
> > both…
>
> Hm, I am not sure? For PRP, it's an explicit requirement to use the same
> MAC addresses for both ports. For HSR, I think the standard is less
> clear about the MAC addresses. And at least our code seems to assume
> that there could be different MACs on the two interfaces of a node? But
> yes, the node merging addresses this.

I'm still not 100% certain, but I agree that the standard reads more
like the MAC addresses should be the same for the two HSR ports. At the
moment, the kernel and the test assumes that they can/should be
different. Therefore, I think we should fix this across the board in
another patchset if we agree that's the right thing to do.

Thanks,
   Felix


