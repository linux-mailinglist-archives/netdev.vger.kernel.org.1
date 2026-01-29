Return-Path: <netdev+bounces-254847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDq3FwCLe2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EDEB22DB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A7E300CC30
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3A33FE26;
	Thu, 29 Jan 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKaa5ih5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB1313281
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704186; cv=none; b=Rr/yyL0p8o3J4ox0N+k5d3WX3DQSLhAYqkiI9WjZ5UlxX8TE2Kac0kygKSO32uWFZQVdI2YHaIA5YE9Om37HD6u0Pjv71xw2O3hLYjIM0h6Ep7am6bahWmqIASaaFFzZJ16Ko6UmTgLpQd1Xak+ho54/HoWodg2qjccRq93FQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704186; c=relaxed/simple;
	bh=/b4eNyMwMVzbNtO0wqEvW4iwpDqJ3A/bN41to3+m6Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRNxc0SDaivK8tElmYZE8uhbubNbiEzfHVE1reD2/2yG9Uew1zRY+VmrkzhiESStMkRgOfZNUOUewxp6MeXXkXlNw38Xx5pxw0prKKMrRi1naXUqnv8iT4rBKjkmcz5XyywLBRawhyTUGnAzloV6YaKALL9OskjI4fTIptSJLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKaa5ih5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769704184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRFN+bsT9FwwGvOEj0EX6o1JvhKYzXv35kylJUytJQc=;
	b=SKaa5ih5GLrYpUIojY4IPLLFI4FAEK+/7Auojc9ZIVOr1bm2m3pERQ7DgW+/lVN+e/kR2v
	WX4c8q5A6zgmxnka5rYsxx3OdGj0lMLJcRlk6ufekNW2tE4a/fJYyBbtsd4xUpgKjLhZiQ
	GaBlX3fQw71wsNLl+eDru1bHbPb8vIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-jQn1s1u_OEOe0k76X7Ljvg-1; Thu,
 29 Jan 2026 11:29:41 -0500
X-MC-Unique: jQn1s1u_OEOe0k76X7Ljvg-1
X-Mimecast-MFC-AGG-ID: jQn1s1u_OEOe0k76X7Ljvg_1769704179
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BC4F1956096;
	Thu, 29 Jan 2026 16:29:39 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 644B91956056;
	Thu, 29 Jan 2026 16:29:35 +0000 (UTC)
Date: Thu, 29 Jan 2026 17:29:32 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net
Subject: Re: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <aXuK7NEW_2IZHu86@thinkpad>
References: <20260122173556.44d8b77f@kernel.org>
 <aXczshu7nvWWFMy4@thinkpad>
 <20260129152922.P0efzzu6@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129152922.P0efzzu6@linutronix.de>
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
	TAGGED_FROM(0.00)[bounces-254847-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: D5EDEB22DB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:29:22PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-26 10:28:18 [+0100], Felix Maurer wrote:
> >
> > I'll wait for feedback from Sebastian, but I'm also fine with merging
> > the fixes for the KUnit test into the other patches and reposting.
>
> Overall the new algorithm is very nice. Feel free to add
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you very much for taking the time to review this series! I'll
address the parts as I wrote in the other replies.

As Jakub wrote, there is the transient build failure due to the KUnit
test needing changes. I discussed that with Simon as well (off-list). In
the v3, I'll add the respective fixes to the KUnit test to the patches
where I change the algorithm so the build passes all the time. As the
patches 4 and 6 will look quite different with that, I'll only add your
Reviewed by tag to the remaining ones and leave 4 and 6 subject to a
quick re-review by you.

> I made a few comments where I think it should be possible to avoid
> tracking the sequence number for interface A and B but since you
> preserve what is done now, I don't mind to keep it as-it and try to
> remove it later on (unless I'm wrong and it is not doable).

I replied to that directly, I don't think that's doable. But we can take
a look at the HW-offload case in the future.

Thanks,
   Felix


