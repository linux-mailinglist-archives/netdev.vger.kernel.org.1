Return-Path: <netdev+bounces-141193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA579B9F84
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265CE1F21984
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF03B7A2;
	Sat,  2 Nov 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gJ6h5DEN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDD7F6
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548073; cv=none; b=iLnW5Arkvec6N0KEAiuo0z1Ac1G2UnsBdD7fLtq/lP7ihRbssn8KMrTaOC6imWahF+cZq0pbuUBNXn0qEH++NX8NNmliEOmSjyeKj9+opBhMZs8Ms+WpiQfDx4KMbldIRBp6eqVpQT2UhbcOJ0eAwFFmjZW0C5oN/vDNdNzq4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548073; c=relaxed/simple;
	bh=h3KfHOiXxIXqay9u+qV6h5Gg5Upn1dV4kUUa50JrlzE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4AaC6SNSjQmAAqrn4f3pVjAnQlXeUXcI075Hu4iTO4v5kvUBb/d7SSVQ2VbcXnTpZZ0tO8VritBdpI3tdqv/aEl6049iv8LAyen/RC73RICqVO+kGoaVTsI3ESwJiQ+XjOSwSgih9POAn9XfMp46WzKGI3gvmBuLufS/WUeJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gJ6h5DEN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E21DB208BE;
	Sat,  2 Nov 2024 12:47:42 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxA0On9De2TN; Sat,  2 Nov 2024 12:47:42 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6A38E20899;
	Sat,  2 Nov 2024 12:47:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6A38E20899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1730548062;
	bh=Fkko277eiwzsQBSQmt8el4CLbGS7ePEDJsDQBR7V/ws=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gJ6h5DEN6RGThohNYdiCspJ14xqJPYbw4WNuqtf68WnXzi5rga/LJ2aU/XFtwC6wR
	 StGTwGZOkJWs1SLTjmL2rrQgA2Phhs500ReBOsbXFa92GA19ojx4jCx7YsnI8SRv0K
	 z8HVYy90TrYgnCipQ1U583Hjz6SgboJwV3jKNyyAevyb/ZtOYzaGlk05jZzkjY1bQE
	 B2mEYAmDpJy6e2MV4JPrjIZat+mDTrEc17kJfJXqBc3kNtiFlqtZXlJGdkrdJwuKqx
	 DXs4LsIkoRsXfa+1WeQSDjFD7FfwF+RmM4Am5/WKeW7EUAM/C6NJHu7rBtfOCbx4wU
	 1uOfmqOfS3Emg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 12:47:42 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 2 Nov
 2024 12:47:41 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 91CB83183E6C; Sat,  2 Nov 2024 12:47:41 +0100 (CET)
Date: Sat, 2 Nov 2024 12:47:41 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH v3 ipsec-next 0/4] Add support for RFC 9611 per cpu xfrm
 states.
Message-ID: <ZyYRXRdksWXo3RsZ@gauss3.secunet.de>
References: <20241023105345.1376856-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023105345.1376856-1-steffen.klassert@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Oct 23, 2024 at 12:53:41PM +0200, Steffen Klassert wrote:
> This patchset implements the xfrm part of per cpu SAs as specified in
> RFC 9611.
> 
> Patch 1 adds the cpu as a lookup key and config option to to generate
> acquire messages for each cpu.
> 
> Patch 2 caches outbound states at the policy.
> 
> Patch 3 caches inbound states on a new percpu state cache.
> 
> Patch 4 restricts percpu SA attributes to specific netlink message types.

This is now applied to ipsec-next, thanks to all reviewers and testers!

