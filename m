Return-Path: <netdev+bounces-290567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFgLFVVDD2r/IQYAu9opvQ
	(envelope-from <netdev+bounces-290567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05795AA65E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C884032F0D99
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B23D0BE9;
	Thu, 21 May 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYMpOBvF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DA39A4B3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383225; cv=none; b=tUum/5FR3SBav2SYQifw6n9Bt81VTB4gyK1mVeB+SfJNgSG5jgymwF4k4eryvEF9oOc0Y06H9J3EoR9RQkQsIbSh1c83Uzq5AzzFIkaDmr5tP0IU6pW82rxmHJBb/iqL0sHuZakZXZNUAgYhDoh4DV6z5zTfDuTRhyt/6pJoo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383225; c=relaxed/simple;
	bh=n73Py4tX0x6CbDtrVaVKUT6jP8Hb5QmRT3SSw45fPfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C74d3SCkuVU8Auw7g2Mz/VocqDct6Gp7qDkXvITKdNEXu5eDowtHrrarWJPS2iFxvcywJ5BOML3syUPWYbV5+pgm0ZqvtBRvAgYtlr1g+mtK1SK2z7n6GQ3Hb72gbqYNe50p9cctF2JP5nHaHA+7QtKvXgZqSzK4fQbhrfZTUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYMpOBvF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779383223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqtx7/ZgZtJqtGmUDilhAq3QEZVyLamVBnXprfT/w7Y=;
	b=NYMpOBvF/tibVnnNUdk1o1vbiKTSSIgqCFxIcXnnKxW8TaNLenVFmKbjSSvRXOZRJdyX1M
	iUC6bmIG0xn48KLv1qSHba7vxKUO4EltldzgUpUc4VvQJrYZcCu+jdTGRnK4NyDMhT3abx
	0ehJv1m80CcxgWiQIHePW9c8Qsk70W4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-Si519SFBP5myV1KRA88w4Q-1; Thu,
 21 May 2026 13:06:57 -0400
X-MC-Unique: Si519SFBP5myV1KRA88w4Q-1
X-Mimecast-MFC-AGG-ID: Si519SFBP5myV1KRA88w4Q_1779383215
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41B4219560A3;
	Thu, 21 May 2026 17:06:54 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E07CA1685;
	Thu, 21 May 2026 17:06:47 +0000 (UTC)
Date: Thu, 21 May 2026 19:06:44 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>, Luka Gejak <luka.gejak@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Carlier <devnexen@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
Message-ID: <ag87pBZfOyccPZTc@thinkpad>
References: <20260514075605.850674-1-danishanwar@ti.com>
 <20260514075605.850674-3-danishanwar@ti.com>
 <20260518184506.694c584e@kernel.org>
 <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
 <20260519165646.09b0783f@kernel.org>
 <1d8ab51a-6943-4978-88cf-adda8cc57f7e@ti.com>
 <20260520153303.33692fe3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520153303.33692fe3@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290567-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,linux.dev,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,intel.com,gmail.com,vger.kernel.org,lists.infradead.org,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D05795AA65E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:33:03PM -0700, Jakub Kicinski wrote:
> On Wed, 20 May 2026 15:30:24 +0530 MD Danish Anwar wrote:
> > What should be the next steps here? Is there any existing defined set of
> > stats where I could populate stats from ICSSG firmware for HSR (similar
> > to ndo_get_stats64 callback). Or de we need to implement a new callback
> > that will do this for HSR.
>
> I'd try to plumb this thru ndo_get_offload_stats
> Close enough for my taste, let's see if anyone objects.

I'm not super well versed with the different options for stats we have
at the moment, so I'm definitely not going to object. I'm just going to
note that the stats I listed are applicable to all HSR/PRP interfaces,
not just the ones with hardware offloads. Therefore, it would IMHO be
nice if the two didn't diverge too much in the end and (best case)
userspace can ask for either the one or the other but get the same
structure back (no need to implement it for the software-only interfaces
in this patch series, I can do that afterwards as well).

Thanks,
   Felix


