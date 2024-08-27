Return-Path: <netdev+bounces-122194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605C9604EE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59632832A6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E461991D0;
	Tue, 27 Aug 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZDIkDSrC"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8256198A19
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748920; cv=none; b=LJ3WlrZqxiXdPc+8ezSMc3Fnng5VtxFnDYIxD3CJiKRycgCHg0tY73Pq5wem4OMTmtI48/1DhNTVSXYpou9+4I94G8fvarRa8DWprJxghKhGMLj2YVCM9JEBnbwBVN5j3G8OHHBXvcJ2GQcP67Xctj0fMichXyXQKlHjHIlR/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748920; c=relaxed/simple;
	bh=fJ9gbA2mlJF8DYxMXcaOviWRtnIjCtDDtL7JTU+yBLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+XGbQoshuJ5/BKsIO/P9dHPfhCnVJsJRWBg1E8BgTM6XRCF2Hbc7Ftnx7OEQwwMFB9H9KosSEP5nMeTVmc3mZgP+13ok4BIu7bwjzAhHr9RUJuv9baoaDOQ+XE7tDwcsso4iFVP0P66y2BdOCRNRKbPU7yJcQlhzNuQdEz8RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZDIkDSrC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 244D1207CA;
	Tue, 27 Aug 2024 10:55:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqN4T0x-vXBT; Tue, 27 Aug 2024 10:55:08 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 94B7D20519;
	Tue, 27 Aug 2024 10:55:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 94B7D20519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724748908;
	bh=AUD9jDbLPqceGvVYZIt8ZFZ2Fi98nvFyYpqdXweOW60=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ZDIkDSrCRF9rHJ7PoSwnUHzsCcFkvlqp749fn97UjGqp6gNS9ISVdocrKGxHv0gds
	 uBU27LuNwZUouTbTREyW+J4eWgxN8CRolPAMcw1mqQYKZrRK8R39ItikDXkZlxae4K
	 Zrp/AvMzHDGA5BXhMaMJ313UA0ZlpJNn4Hz/zqlniMklzfZRuy7ekrchZ3RkutiRQ5
	 lHOamX1g3o/zdbRWKo34ki736zoM1jF33FuzEGdPpPZdjP1OWNh6uCAlcomfNuA7+C
	 px79JfDAwDwK3dW1dbVs2CZ8Dw6kpgtuHsyEMdLxYghCYF2Lp+v0SLQkQhNCW70ue4
	 1FfHFPdmnaZog==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 10:55:08 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 10:55:08 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DD59E31800A4; Tue, 27 Aug 2024 10:55:07 +0200 (CEST)
Date: Tue, 27 Aug 2024 10:55:07 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<noel@familie-kuntze.de>, <tobias@strongswan.org>
Subject: Re: [PATCH ipsec-next 0/4] xfrm: speed up policy insertions
Message-ID: <Zs2Ua9JwHvjDWpXP@gauss3.secunet.de>
References: <20240822130643.5808-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822130643.5808-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 03:04:28PM +0200, Florian Westphal wrote:
> Policy insertions do not scale well, due to both a lienar list walk
> to find the insertion spot and another list walk to set the 'pos' value
> (a tie-breaker to detect which policy is older when there is ambiguity
>  as to which one should be matched).
> 
> First patch gets rid of the second list walk on insert.
> Rest of the patches get rid of the insertion walk.
> 
> This list walk was only needed because when I moved the policy db
> implementation to rbtree I retained the old insertion method for the
> sake of XFRM_MIGRATE.
> 
> Switching that to tree-based lookup avoids the need for the full
> list search.
> 
> After this, insertion of a policy is largely independent of the number
> of pre-existing policies as long as they do not share the same source/
> destination networks.
> 
> Note that this is compile tested only as I did not find any
> tests for XFRM_MIGRATE.
> 
> Florian Westphal (4):
>   selftests: add xfrm policy insertion speed test script
>   xfrm: policy: don't iterate inexact policies twice at insert time
>   xfrm: switch migrate to xfrm_policy_lookup_bytype
>   xfrm: policy: remove remaining use of inexact list

Applied, thanks a lot Florian!

