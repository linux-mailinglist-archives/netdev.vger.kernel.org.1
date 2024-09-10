Return-Path: <netdev+bounces-126821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E059729BD
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F831B22A3E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF8175D50;
	Tue, 10 Sep 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WPGIWjGK"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD0208A5
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950641; cv=none; b=QHk6wsEnzwJivzF/2rNb7Jw1cio+Oxa3yx0kf9QfZ+obHX4qlDjwfiU54YVCQsB3FHpw2T2aMGnTsVwss/uoSE7OMXsNWtEJvsMUfgSCxCh85p42ynf1zLE8P/Hs1sTueBfUsRhMhj9d4PVxEXEdAyt1bCCOyrBOnaXTm78sk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950641; c=relaxed/simple;
	bh=CFqNPuSGmVOVgnbIjDOgkUj81ff02E33l0trqD5HUnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXMt0U/SozLuSR1zkNljJUBKdyQeH2whz0vqlMTDY5k9UmQ/s//59et3Dp1sa3dQzCtc9yI4XDdX+fjP3xkG9wnvAf9egBGuKbst2HYB+HqbdSEU9nlgmpx1j9Gark6OVaobkGBe3GqpGYystJLWutE4hSGO08s6BzAI0/hUC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WPGIWjGK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7B7072087C;
	Tue, 10 Sep 2024 08:43:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3uqS0Pejiny; Tue, 10 Sep 2024 08:43:56 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BA6162074A;
	Tue, 10 Sep 2024 08:43:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BA6162074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725950636;
	bh=8oXgvKG9Rk8a3gn+yfvyTPpEd9xEH2pRTZn0PaSVXbM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WPGIWjGKobnATHdi8uMpbCD1ZuT0a/Y6rJf8lsu+4G6OzBiQWJV9qCie76GdliJZk
	 yx4QdeBa24Ah2S3nCJ95vDNHwqbymWKdV19YqBid/bLOdWrOiyJB+iPaPn4Sr/+BX0
	 ZdJDQCxxN0DqHQv/sNuubhuLuYuAEN2P29Jo58pyx1e557stQrRw5FtGtXQjsH+td4
	 FSl9tIujEFDXyk8BeSPZEIhxK17Swpwv2ldLf+1QXzTBkQZEavHgItoSBRePFVsKR4
	 qnVYP4DZPVsOzVOxr1WIahS2JGUgZroLcb3lJquvuU8lnhrTZWzgOg5VbzMDf0nphx
	 OhRQggNLncAnQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:43:56 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:43:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2E4AA3183D5C; Tue, 10 Sep 2024 08:43:56 +0200 (CEST)
Date: Tue, 10 Sep 2024 08:43:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, Julian Wiedmann <jwiedmann.dev@gmail.com>
Subject: Re: [PATCH ipsec-next] xfrm: policy: fix null dereference
Message-ID: <Zt/qrKmCX3u6BMu+@gauss3.secunet.de>
References: <06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com>
 <20240830143920.9478-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830143920.9478-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Aug 30, 2024 at 04:39:10PM +0200, Florian Westphal wrote:
> Julian Wiedmann says:
> > +     if (!xfrm_pol_hold_rcu(ret))
> 
> Coverity spotted that ^^^ needs a s/ret/pol fix-up:
> 
> > CID 1599386:  Null pointer dereferences  (FORWARD_NULL)
> > Passing null pointer "ret" to "xfrm_pol_hold_rcu", which dereferences it.
> 
> Ditch the bogus 'ret' variable.
> 
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>

Now appiled to ipsec-next, thanks!

