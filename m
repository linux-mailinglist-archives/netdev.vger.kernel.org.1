Return-Path: <netdev+bounces-257565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHjIJQT+hWnUIwQAu9opvQ
	(envelope-from <netdev+bounces-257565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:43:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FAFF20F
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A9A03016839
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2E41322B;
	Fri,  6 Feb 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fPU014sH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E301D5CFE
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388960; cv=none; b=efb+Bxds9+On0WtvoK4TbtUuRqlN6gZlpzC6R2x4j13eXqwIa+0uYtVKNfvwtTpWULL4um0RPKEYYH4ttQfNhlN84toRygJnji69i29Q9GrJ7koxX21jaO3+6d1TMy8smGfSDUPB3xoHcMKlRx4JxGurQnFXgYXYlbPMXObhkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388960; c=relaxed/simple;
	bh=ZQo9siwZlA/Xef0MSp7khX1T2BJvm2nbH9eNkaYgevQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLzh9bP9iFOQnyf/lZlBMoQNjtiiRgC8FXXT/xu+7SYwQk3GPO3INo7I/x92Syo88FxxwbLXqZTTvD/3Tie7weCBSspU0wP8IcQ5zLiZgqc5x39On1EI6o4MBIAb63E+jRSGh56yLLyBNbuNzoUe4wvRKEKAWK4p/Wi8a/lL8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fPU014sH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5D09320897;
	Fri,  6 Feb 2026 15:42:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pnhDV4v5oKS1; Fri,  6 Feb 2026 15:42:36 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CD5F320870;
	Fri,  6 Feb 2026 15:42:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CD5F320870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770388956;
	bh=l4mW7Kbh1y3a011S67HXudxXvGYNhc68NB5BdZ/XgwA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fPU014sHWoe+DiY1X7Ne51PrK2ED3SBjGYsDjOUlBUECL0bWfxzQ366sZIvYW7GMz
	 0lV7Xk7dTUXhJhRGpcDbIi76wDODRWXWjjAw0YVFHdTNIDXfsxyZQKsVqdgn3OFFyC
	 SHr2wC3JGnWEEyVjEOHbgSz+Gbx6CqAQpWJtO36/y2Xv4y4bg89/0v50lTKraFuND/
	 i+pufo6Y2JjHYmXm1R1zumJ/Pn7zTIPDPSXHKwQv0w/koetKrfJoZuRMrzysV8IN9+
	 EVFGS58fQQVz4p7Qag0p/aRJmoEJddzGDwhgTce/roDqiDhA8FEvVCam4bNusrE8bM
	 fAr5IF5/lZgLw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 15:42:35 +0100
Received: (nullmailer pid 2376188 invoked by uid 1000);
	Fri, 06 Feb 2026 14:42:35 -0000
Date: Fri, 6 Feb 2026 15:42:35 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Florian Westphal <fw@strlen.de>, <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: Re: [RFC PATCH] xfrm: reduce struct sec_path size
Message-ID: <aYX920Dxv4-b1QyK@secunet.com>
References: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
 <aYUxubug67eqQ6aH@strlen.de>
 <57948250-bfbe-4d36-909a-987458374423@redhat.com>
 <aYW5CHT70Q7LDoWa@secunet.com>
 <7bc99990-432b-418d-bbb7-fb450f9e07ee@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7bc99990-432b-418d-bbb7-fb450f9e07ee@redhat.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-257565-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E8FAFF20F
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:36:53PM +0100, Paolo Abeni wrote:
> On 2/6/26 10:48 AM, Steffen Klassert wrote:
> > On Fri, Feb 06, 2026 at 10:37:51AM +0100, Paolo Abeni wrote:
> >> I'm trying to understand why XFRM_MAX_OFFLOAD_DEPTH is 6 exactly, but
> >> it's not obvious to me skimming over the code.
> > 
> > That is beause we allow 6 transformations per packet as a maximum.
> > But for offloading we currently support just one transformation,
> > and we probably won't support more in future. This transfomation
> > bundle stuff if from the old RFC 2401. This was obsoleted by RFC
> > 4301 which does not have the concept of transformation bundles.
> > 
> > I'm currently looking how to move our inplementation from RFC 2401
> > to RFC 4301. This should remove a lot of complexity that came with
> > the old RFC 2401.
> 
> Thanks for the insights! Looking forward to complexity reduction :)
> 
> BTW are you ok if I send a formal, non RFC patch directly targeting
> net-next? The goal would be to keep skb_extensions under control for
> 6.20, countering a very recent size increase for CAN's sake.

Sure, go ahead.

Steffen

