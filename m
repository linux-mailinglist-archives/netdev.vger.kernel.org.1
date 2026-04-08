Return-Path: <netdev+bounces-276355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDFzMpgS1mngAwgAu9opvQ
	(envelope-from <netdev+bounces-276355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:32:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D133B913A
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A5453014686
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD6536BCDA;
	Wed,  8 Apr 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VLVdr9d5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321C8472;
	Wed,  8 Apr 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637139; cv=none; b=NCaxklpUAsAdIxnBrO/U3aPNhfUUrGREMNjosqwwujIXIleaN01STrcQ9dvP3xyRDv7LsQxvQlVe3wynzrR49wjvdopIFA2kIYTvDEWALv7NS9LCEV+RC+2wr51LGA1oHeILV9c3B/GEG+fODkYfx1YeJwYs77IMo4OU7/n0qRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637139; c=relaxed/simple;
	bh=NlGdaIsS43LlOgMlfXZbFLaGpg10FnvNajYpOIWJY68=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNbBw2w+JVfNlinlQ66JK6EWCZplTF+vZz9LVazN+6nYzo36i8V9G6nl2ePInygohACP8pKFweGGs0X+kXZlSl34M6zQc2I/5b/3y7OOWuv7wgeNNI3BzrFtOCyh53WpunjqV+w8YxRJT1O2w4Z1of601kGDEB6wN9Kh22An5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VLVdr9d5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7FD4F207D1;
	Wed,  8 Apr 2026 10:32:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CCp7eoLfP2F; Wed,  8 Apr 2026 10:32:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F201D20660;
	Wed,  8 Apr 2026 10:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F201D20660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775637129;
	bh=dyZ18m2OFgbhLlelyUts6F/mhgaTkcKyDoLFGARJgq4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VLVdr9d5M0iWNEwRkuFgmpyFtFC03gKU5K9kZf15LEbAN2ZKUU+/zijwHWvPRsnj1
	 CgbymJGaJBeEYzvpimEij0Q3aVGwOp1H8G5k4bawfXpEaU1YPbDgfilPkD0gSNlHyi
	 XVLfMx3XELfi7dn4f7EJ/Jpgt47BSv9FfbovcrXrhTO4l0P06pdwXZg545cOZDP32I
	 yWuj75ichPujmVibAFw1kiuiKF3BZA06JHtRMHscMYYhRO2FzS4pIWVnA/6ArMrjXe
	 D/vzz3fls69rGkiy8wfcsK3KYnL3bHs7GwPdmbEQR3iTFsOCrn7ZvOKNwm057vABVb
	 toTzzsAszAQiQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 10:32:08 +0200
Received: (nullmailer pid 2634035 invoked by uid 1000);
	Wed, 08 Apr 2026 08:32:06 -0000
Date: Wed, 8 Apr 2026 10:32:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <adYShpt5qjZNeczd@secunet.com>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
 <2026040634-deodorant-shakiness-a64e@gregkh>
 <20260406103851.59a200fc@kernel.org>
 <2026040745-crafter-awkward-8901@gregkh>
 <20260407181211.5419f2cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407181211.5419f2cc@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-276355-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47D133B913A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:12:11PM -0700, Jakub Kicinski wrote:
> On Tue, 7 Apr 2026 07:51:15 +0200 Greg Kroah-Hartman wrote:
> > > > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > > > alignment for some reason...
> > > > 
> > > > Want me to do that?  I don't have a way to test any of this, I just
> > > > found it using some static code analysis tools that looked at holes in
> > > > structures.  
> > > 
> > > Do you have any more Netlink leaks in the queue? If you do let's do it,
> > > if you don't we can wait until the next victi^w patch to arrive.  
> > 
> > I do not have any more, sorry.  So is it worth it for just these 2?
> > Your call :)
> 
> These are fine. I would have applied but I think Steffen will take them
> via the ipsec tree first (LMK if that's not the plan, Steffen)

I have them already in my ipsec testing branch, will be merged today.

Thanks!

