Return-Path: <netdev+bounces-298011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NPe2Asx1Kmq+pgMAu9opvQ
	(envelope-from <netdev+bounces-298011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC066FFB6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="U5bI9G/R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298011-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6CBF300382B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601723B9DB6;
	Thu, 11 Jun 2026 08:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EA37700A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:45:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167560; cv=none; b=DM98p/or9f8czIwyX7P6q8LTwErtBE7krNL4fgGLWtMPTwmlSGllNmpeh+Lz8Mq3jvfYyMmSdmU4GmG1CTuOqvabgzqnSAClWphA5E21+H16293JrB1aFKLRPutQfVWTT/btDPUDXd5DECh7o5nlRAuO5rvNJalRicLgxauO22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167560; c=relaxed/simple;
	bh=yDJBfs20l2Xs17nIeHGIm4cX8CniXBdnKTlO4JjiAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIl5gn+HbbCFxl6tOsJ1t/V9tr2M4t0i/hcEF9nIedkVF74HTRugAOU2l6+8Bx8ZpkryVUEESWTjxX6v7pRKCywtQVVHhhDRZzklERUnNG0QSw5buIsaYAcasDVch5qtqPUgjyWBNR8/2s3Vp2Dr2JSF9rO8itEBvjI0Goo6rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5bI9G/R; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDJBfs20l2Xs17nIeHGIm4cX8CniXBdnKTlO4JjiAuQ=;
	b=U5bI9G/RBSeMU28ErWDq0u100XIGhZZWVGeoQHhK3a/y8k7RlaEjP5MaVkxk+2pAXri6uu
	3QWAZeErgxirePbhzZeaXjeNStGM82lRLnMourpCvYjnrVbp64O4mcRqAkvtkPAMKsjgD0
	lILpkOsrajcMeaOeGC2tRQYKbVMUo9I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Ut5TMn77O7q3Czir8k-9Yw-1; Thu,
 11 Jun 2026 04:45:52 -0400
X-MC-Unique: Ut5TMn77O7q3Czir8k-9Yw-1
X-Mimecast-MFC-AGG-ID: Ut5TMn77O7q3Czir8k-9Yw_1781167550
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A331944A96;
	Thu, 11 Jun 2026 08:45:50 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0214E3000223;
	Thu, 11 Jun 2026 08:45:45 +0000 (UTC)
Date: Thu, 11 Jun 2026 10:45:42 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Yury Norov <ynorov@nvidia.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Luka Gejak <luka.gejak@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: simplify fill_last_seq_nrs()
Message-ID: <aip1tjdLIUXre9e1@thinkpad>
References: <20260609171545.1051322-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609171545.1051322-1-ynorov@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:yury.norov@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:kexinsun@smail.nju.edu.cn,m:ynorov@nvidia.com,m:2022090917019@std.uestc.edu.cn,m:luka.gejak@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,thinkpad:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EDC066FFB6

On Tue, Jun 09, 2026 at 01:15:44PM -0400, Yury Norov wrote:
> The function checks the HSR_PT_SLAVE_A and HSR_PT_SLAVE_B bitmaps
> for emptiness right before calling find_last_bit().
>
> This pass may be avoided, because if the bitmap is empty, the
> find_last_bit() returns >= HSR_SEQ_BLOCK_SIZE
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

Looks good to me, thank you!


