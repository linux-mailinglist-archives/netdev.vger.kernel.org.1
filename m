Return-Path: <netdev+bounces-278011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJnqMH213GlVVgkAu9opvQ
	(envelope-from <netdev+bounces-278011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA63E9C46
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12803019BB9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB13AF677;
	Mon, 13 Apr 2026 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+wTotKv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049C3AE71E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071696; cv=none; b=YAan04BvgAJH4cDIlexajPrvGy4PtF36cVclfMtdR+x3f8xwCcFOXJaOVRmXMpgoX1ooNvF6Oh3JETVLizbWNKmiQtpPMVi3nrPI+Wyd7l37pT8QDdd50fkgbZFYo4OLLOMtCF+BtAdbHTHPTgmdp6xda8W5FIwC1AKAkFVqlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071696; c=relaxed/simple;
	bh=EbOzQjeAlCbrNoGjkAlLZRdIKSC8rV0R947KMWpOTls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UedgIYRgsWmEzm+rqwm4jeGBNgmg3Dishs9CUpS7zPkcE5qSlV9aFkEi1Fvu7EjEblO3fDaXvco42z2Bv6BYBYaQTjWxxtKZTTZhKVMZs0jjL1nkjbAYu/J3LcQ6Jzv72NlTmnxo69TKVw2F9PPZCqVn5ZSQJRi2e5dNIkCejoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+wTotKv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776071694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Amw1IQyLXGLCBkbJ7N2kGgFQbYxjmSFWU332iVkB80=;
	b=Q+wTotKv/AQhBn9cfRysBwPvDw6SCXMn4usjShZRQTW40ey5wYF/fAowyp71/GjsTXE64t
	JpzEGXrxt0DrDOt9HdckN2QBfEIGdv4VEZnuZ+KNTxHykFEmi9Spn9LANj/ocoXTMfDpsY
	9ldioXnAGIZh6sVBveewqYssdevVlhI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-uz8z3eniNfCInjRPz1Fgkg-1; Mon,
 13 Apr 2026 05:14:53 -0400
X-MC-Unique: uz8z3eniNfCInjRPz1Fgkg-1
X-Mimecast-MFC-AGG-ID: uz8z3eniNfCInjRPz1Fgkg_1776071692
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9BDC1800372;
	Mon, 13 Apr 2026 09:14:51 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85AFE3000C16;
	Mon, 13 Apr 2026 09:14:49 +0000 (UTC)
Date: Mon, 13 Apr 2026 11:14:46 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luka Gejak <luka.gejak@linux.dev>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <ady0Bjkpiwm06Jmk@thinkpad>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
 <20260407162502.19462-2-luka.gejak@linux.dev>
 <20260412124558.190c725f@kernel.org>
 <DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev>
 <20260412133157.3b335e1b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412133157.3b335e1b@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30DA63E9C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 01:31:57PM -0700, Jakub Kicinski wrote:
> On Sun, 12 Apr 2026 22:13:35 +0200 Luka Gejak wrote:
> > Regarding the TLV loop: I actually implemented a TLV walker in v4 [1]
> > for this exact reason, but I moved to strict sequential parsing in v5
> > based on reviewer's feedback to keep the implementation simple. Could
> > you please check if the approach used in v4 is what you had in mind?
> > If so, I will rebase that logic onto the memory safety fixes
> > (pskb_may_pull) from v5 and submit it as v6.
>
> That's not really what I had in mind. I was thinking of a loop which
> just skips the TLVs in order, leaving the parsing of known TLVs as is.
> But I've never used HSR maybe this sort of strict validation is somehow
> okay in HSR deployments.

Hi Jakub,

I'm chiming in here as I was one of the reviewers asking for the strict
validation. The HSR supervision frames have this TLV structure that may
appear to support optionals or (unknown) extensions of some kind. But
the standard just has two potential frame formats (for normal and RedBox
supervision frames), both of them completely specified. Also, the
supervision frames have a version field in the beginning. IMHO, this
leaves no room to put other TLVs there. Therefore, I don't think we gain
anything but unexpected behavior if we start accepting frames with
arbitrary additional TLVs/data.

Thanks,
   Felix


