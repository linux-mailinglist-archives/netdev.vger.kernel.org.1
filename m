Return-Path: <netdev+bounces-286250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NNkL5Q8AGqXEgEAu9opvQ
	(envelope-from <netdev+bounces-286250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 113B1503077
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4AA300E266
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51521773D;
	Sun, 10 May 2026 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="f2jRXoe4"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D017A303
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400402; cv=none; b=gLHzBamNPYwwMYvpr2ix3GliLPXh9r8/PFGSWrexpPugupQHNlHOoN0SS6ac7fxFxLiwsDVNUBiqtN07gbz1dTDXSnVOiBglycernKW3vmyw9Vqy1rfsxOJsrXAF+2CgJTahwIznQdO68NTWCLAixTTihKOGsgSaA/jV4JikRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400402; c=relaxed/simple;
	bh=YuttV47+6m+TFaw92mfQzQZaDqezNPL4rbSMSc242QY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzzDdXI5OGyyTOu6yP86FxJd51Pu6g9YX3yWlL5NxbJGt1NnX8i1tgQrhmSo8adMiuZzHnq7l/Q2kuZa40BwgfMKyEtq7xIAzjue//gsBiWDoPIOWNXdA3XBoW0LGrfBY8VniJtFxVQdjQj21Q82dcV4mKkWNNs9bGF46HUbHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=f2jRXoe4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 77E20207FC;
	Sun, 10 May 2026 10:06:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6no0xnMoIlyT; Sun, 10 May 2026 10:06:30 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 05649207E4;
	Sun, 10 May 2026 10:06:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 05649207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778400390;
	bh=YuttV47+6m+TFaw92mfQzQZaDqezNPL4rbSMSc242QY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=f2jRXoe4rWKzsfna757y3BZpcAALdxgOF20QfqBfp21qRcCVGsBx0eNkyHWSBjUc6
	 r+dArt+SddzmGklYnKyPsakNQyc9UBozgONJkkuLpImaZHvdSnPhZgpzOX6wlUdmAp
	 yQNciqmZU/aBfT0oczx9uwO9fDhsFU5cyxa31YHTyh3TEGTK/oekTyn3QxR/vhFraU
	 S+gghyx9rZM/5NGzExQrrrJ02WC/tV6dTK7yomzb6TMGj1EHnrr6G9xXA/i+Cy8RWM
	 M8/Vc20hf9PVzQyMQqHvr8y8S27BjeGlo6stl4axV2BJOR9gpq9rRD9jNwx+mZhXxL
	 DCVahVe2iIi5Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 10 May
 2026 10:06:29 +0200
Received: (nullmailer pid 600125 invoked by uid 1000);
	Sun, 10 May 2026 08:06:28 -0000
Date: Sun, 10 May 2026 10:06:28 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <sd@queasysnail.net>, <tobias@strongswan.org>,
	<herbert@gondor.apana.org.au>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next v2] esp: Consolidate esp4 and esp6
Message-ID: <agA8hOtLyrklYEX6@secunet.com>
References: <afr4ipktV91sA8WU@secunet.com>
 <20260509135639.1309815-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260509135639.1309815-2-horms@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 113B1503077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 02:56:40PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

I've seen it already, a v3 is already under test.

Thanks!

