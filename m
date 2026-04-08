Return-Path: <netdev+bounces-276385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHBzA7Qg1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6903B9EA0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EC5B302BE97
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E1298CAF;
	Wed,  8 Apr 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aj+R5Hq4"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DA19CCF7;
	Wed,  8 Apr 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640615; cv=none; b=VQTA4NDcDQNBQT3H1Z+VChatm7NGqNWiW4xg8T5QSnQktsEPgLuJz14P3E+VPDMR/Ht2eS+QhWomBU8SRI4v3FeH5GN0q6ZkvITmFiIaCCYiJ44Pdi49uoiHDRBfq+SvNxD6DMTJU9tqNMo/5LZfkMYiBxXArRWCepyKi9sxrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640615; c=relaxed/simple;
	bh=IlhjxjdPXvr+PTXcRTRspzg2If3RH+XNDXz5bdoe7wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeMXEo2dNboKwIgAOXBVDwIzppfsVKYJpfGqIGURjF1myJ0wa1o+9hbd9VOOFqCbFXDEbVlXieEFZynvHcK5g7L3KJRUtDCgUmoW1Z7X+MCJXQ53gAQPSEoDliwRrct6O3Yl16DqZxOipmN9WqTuT4H+LRmqc2UfoPEsu3RvY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aj+R5Hq4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 85012201D5;
	Wed,  8 Apr 2026 11:30:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfd65NMbL36T; Wed,  8 Apr 2026 11:30:12 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EE126207A4;
	Wed,  8 Apr 2026 11:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EE126207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775640612;
	bh=WSVSzlPK7gCp5BxaLEMvdfsViw+64KTIylJyXJ3WmN0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=aj+R5Hq4KucUtsI8+eE/V+4bsG2DrpS2DQmos/SbJ4loZzDFK/BsmLN00XiFlaoIk
	 aw2UoqysNel8oQy5/KHUi01OOlYZLQEVvZRic6mUpUcBrh34mqA2/Xs7UTkpAryTX/
	 +J7uPFWKdNS7QawD2oHFdLJGzkFd6s4xTLyCdpXs1XXuVVqkHJeokk0zL9irTzJX4b
	 uEkruK9vvRzHObQL8/1+hyvrgTz1oIzpmn2cl4JgxZ5iu4+qfjPQhwjNDyfYYna4qH
	 dKx9jj8rfElBDmQmtG88tqDmfupLwBvMQqL/YekhbItaY+Le8sXBBuYbPxdshzVJG5
	 WCP1aZO1X87VQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:30:11 +0200
Received: (nullmailer pid 66073 invoked by uid 1000);
	Wed, 08 Apr 2026 09:30:10 -0000
Date: Wed, 8 Apr 2026 11:30:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <adYgIr5vlORzWqi7@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-276385-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E6903B9EA0
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

Both patches are now applied to the ipsec tree. Thanks a lot!

