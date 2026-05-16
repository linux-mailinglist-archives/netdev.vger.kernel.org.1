Return-Path: <netdev+bounces-288597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCScBZckCGoVbQMAu9opvQ
	(envelope-from <netdev+bounces-288597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:02:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606155AB4A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCAFB3010DAD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66B380FD0;
	Sat, 16 May 2026 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QUhedKOu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97D35DA4F
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778918529; cv=none; b=P/y6DleUx26XRFTnuOUtGhTTU6VagFHV4Cm7SUbPx/rf4Uubrr0Uq+DtX1fOUJgC+jda98Db8xzxjCDJggM8C+up1z+qJz5E1/qvVQw4wjr+zU7XqI/mgl1XfMJK6yf5gIT6AOtpbj5B9UGxAnsOdYLwcAsMgxzUH9fo/Uua/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778918529; c=relaxed/simple;
	bh=rmBSBoqJRgR44i7sBj9XLcJHtxfdoUpHPDMy33NveKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q51DC66I56Z2T3VkiPpaFJ/GEnJTkq5Tl3Mr5ZjIqoF0fKNtaWcTHjXOd1rpIDIQHUpnKmAqzUrgXHkmayREC0wnsNMzvXXus4983k285ny9240cyH++Gt7T7K6tAexGIhbXUpZp7pBayTU0qmLv8leq+MQ0PnpuSg+msDBrV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QUhedKOu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0C3DC20842;
	Sat, 16 May 2026 10:02:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7Dzd5T0gJ7N; Sat, 16 May 2026 10:02:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 89A1E201E2;
	Sat, 16 May 2026 10:02:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 89A1E201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778918525;
	bh=DA9scekMGU8ncq/7IzwYDmbCTWbYK7SOnOCps6YNF8M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QUhedKOu2VyIsRk4Mpt1FGj1kTQU6gLCLtRMF3ms3qucCGQk62CG2aqhkaqUr88zR
	 Tga+SFQIdo/T9hBI6MmTyCfo/uipaHjLGNlaYFpAXxuNE4jgvJfi3alg7Kuf1GCppP
	 m4WYyN1P3upY6uH3dBhP5Q8FzOdXexzqqFqfnJUUtEFh9a3/oyUJ/twLR0GYDjyuJ2
	 YFsyldNm+3csFZ/e4Hfunrjd8ewRXmGT1pvQ/BG5cgwhVJWL7ejQYhkdQZ5I+BgGTy
	 rmD+32IXdWzPITHNLR5HwooStImPelSHQOfx1QsZ73ogiXWkQppv7Jvickz/GRFXN5
	 hvZClK5esXUSQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 10:02:04 +0200
Received: (nullmailer pid 498450 invoked by uid 1000);
	Sat, 16 May 2026 08:02:04 -0000
Date: Sat, 16 May 2026 10:02:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Ahern <dsahern@kernel.org>
CC: <herbert@gondor.apana.org.au>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, David Ahern
	<dahern@nvidia.com>
Subject: Re: [PATCH net-next] xfrm: Reject excessive values for XFRMA_TFCPAD
Message-ID: <aggkfHjZRge5j1lu@secunet.com>
References: <20260513165028.33171-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260513165028.33171-1-dsahern@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 6606155AB4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288597-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:50:24AM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> tfcpad is a u32, but that full range is excessive for padding.
> Limit it to max IP length (64k).
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>

Also applied, thanks a lot!

