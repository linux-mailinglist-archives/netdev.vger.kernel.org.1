Return-Path: <netdev+bounces-282269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP8/Ny+18WmjjwEAu9opvQ
	(envelope-from <netdev+bounces-282269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF94908EC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F382D3002B6F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38139D6CA;
	Wed, 29 Apr 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IxU9CWUe"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB013822AF;
	Wed, 29 Apr 2026 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448018; cv=none; b=k0+NanjXIHJWtrIPv7bZYIrURjb4IEnziDwSJOt0Od4oS7GKIdpA36D20JVHRFTVQ2zYwXfB/SD6yCM9D/qOrZQ4Yv0m2ur+wxjEXAft6h6VyjOHGG2p6lS4+K23Vhi6Fvdb8IO/By1LJwz9NP/4cioeWptxHH5l8Grul8fr6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448018; c=relaxed/simple;
	bh=ZNb0sc1kb+YUYbx1/VgwviJpU9Bu6OtIelCUTLqSKMo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ6RxJqwsw7pHpMDW8lg1IHbNToZ1GnBXIJkElUpaEwtKh7er/xvVqBa9CMT/6CKAf4E9ZMcvxsYtmME/uNxxG5HuzBRfYesIOrdP3TveSFDgKObjeMzRWOR7ojxQXu3FH6HnauYM07OtRBg/6HFo41rtRIMq5My4NriP/jU4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IxU9CWUe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2695120826;
	Wed, 29 Apr 2026 09:33:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVxe3Vei_57S; Wed, 29 Apr 2026 09:33:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6EEB2207FC;
	Wed, 29 Apr 2026 09:33:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6EEB2207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777448013;
	bh=52+BngK/BVHLCtVyMQHL4aCZOf+RV3eO/hVBIHyp5LM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IxU9CWUeSgG84ByoG2OS6pkHiXc2pMw9OsTEO8Awpq20DQtAOVbOpBRuiUjB7s8QI
	 n2BRKJyLUuoWaWdAjYg53fbsTYuBRN+hjibmgMBdYZI52aRtNqtf/timxF40pIfTI9
	 zAs9yi/h4BdXH8jlWTDqispEpWPjy1uRAcHDAxw7klybaTIVGfKpRLUJ4djWIEPPdP
	 i+nEV1sG/xzQ1aAdTC0XILclGdAWhKHrc5mIrctmPbXtA1TYoaUa0BojGJCIfUHXVL
	 ir1mh3cARMzO7Fpkoh9NSDdmu2VumAOv3eTbpdquI9jYJadEMu1/r/t6L3qH3QmzlD
	 41hAgWkn8X3Fw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 09:33:33 +0200
Received: (nullmailer pid 1151435 invoked by uid 1000);
	Wed, 29 Apr 2026 07:33:32 -0000
Date: Wed, 29 Apr 2026 09:33:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v3] xfrm: cleanup error path in
 xfrm_add_policy()
Message-ID: <afG0TLg68svCz3G1@secunet.com>
References: <20260414020947.65905-1-kartikey406@gmail.com>
 <CADhLXY7C8SAw1SehHmko6JpCqGXCDindcsDbVi0EBsbcsHbW_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY7C8SAw1SehHmko6JpCqGXCDindcsDbVi0EBsbcsHbW_A@mail.gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 37AF94908EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282269-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 07:31:40AM +0530, Deepanshu Kartikey wrote:
> On Tue, Apr 14, 2026 at 7:39 AM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
> >
> > Replace the open-coded manual cleanup in the error path of
> > xfrm_add_policy() with xfrm_policy_destroy(), which already
> > handles all the necessary cleanup internally. This is consistent
> > with how xfrm_policy_construct() handles its own error paths.
> >
> > The walk.dead flag must be set before calling xfrm_policy_destroy()
> > as required by BUG_ON(!policy->walk.dead).
> >
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > v3:
> >   - Changed prefix to ipsec-next as this is a cleanup
> >   - Dropped syzbot references as suggested by Sabrina Dubroca
> > v2:
> >   - Reworded commit message to reflect cleanup rather than bugfix
> >     as suggested by Sabrina Dubroca
> >   - Removed incorrect Fixes: and Closes: tags
> >   - Corrected subject prefix to PATCH ipsec
> > ---
> >  net/xfrm/xfrm_user.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index d56450f61669..ae144d1e4a65 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
> >
> >         if (err) {
> >                 xfrm_dev_policy_delete(xp);
> > -               xfrm_dev_policy_free(xp);
> > -               security_xfrm_policy_free(xp->security);
> > -               kfree(xp);
> > +               xp->walk.dead = 1;
> > +               xfrm_policy_destroy(xp);
> >                 return err;
> >         }
> >
> > --
> > 2.43.0
> >
> Gentle ping on this patch . Please let me know the status of this patch.
> If anything is required from my side

Your patch was submitted during the merge window. The net-next
and ipsec-next trees don't accept patches during this period.

The merge window ended last Sunday with the release of 7.1-rc1.
I prepared the ipsec-next tree for the new development cycle
yesterday. I'll consider your patch now.

