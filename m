Return-Path: <netdev+bounces-124596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE096A1C1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790921C244C4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01AC1865E0;
	Tue,  3 Sep 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="M9R6qYGE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098571885AF
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376255; cv=none; b=uTzrEjGXvEx1QRTEC8aqJlXWGdy50CrysWuvKRi0rEoFv5CHgZ43+HNw05gAlUPzKkR9xoP7azpsyk1wHZkD5Vanq0ai6YS/g0TVk9EUydD0jsuFlzldSHTGOFBnuIWxGsMwjy+IXyvU1IQyQrey0XjOe5IHIObTtInthF0IPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376255; c=relaxed/simple;
	bh=9UgvuJyU8P2/OkpaHDJaid4l294f5IDan6gWQJtMNiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al9yq0TPNQmtS3Lw/bnAXm8osBAh5518yYTMq5XXi2990Vt8zzujFA6ko14jijMBC4l1S/JrJTsO1uCENf03H2mqXCm3RlBRxnFX1Xa31z7V6uYK8PSVFBShpT6rKWPtcf8Ypj4sJHsIo6UHeSHEAF/arLOaPFb6OxUGLD3vu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=M9R6qYGE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0E067207B3;
	Tue,  3 Sep 2024 17:10:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ot48kpR_C4v; Tue,  3 Sep 2024 17:10:44 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7E56E206F0;
	Tue,  3 Sep 2024 17:10:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7E56E206F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725376244;
	bh=XEIszLUQVn3Ff8ZAEfgggwjkfArelJH25d3Tmn5jhpQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=M9R6qYGE+IYY6lzHDGWCTP/vj34nC7ka2apDKXW3iLdQLZ4enh1pCqFUFgUOwYFtU
	 0t4lQkS9t32gu4aYMfXDqUFpKS4K9K6sB77wzxLqt5GiIcrBqjn0vtnSTDUFtOUnHo
	 TIJe++KXf8/FVMYA1Z4iGYvJuSkpeE42RXTVgyyWYheEcMgObDTicQP6ky4Vew/Baa
	 Z4SxUnOI3GwsqNfQtp4OFzGrlJpVDb5jG+FB3I06G2gVqs0Rve8TV9fyFXrMPUhDn8
	 Vzv4r4+7oOBAurzpz9fY93dZIK9PhpSl46OqSTFtJvAVrt3Age+z/LG7vIYDlMplFg
	 kKTesCrxGntPQ==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 17:10:44 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 17:10:43 +0200
Date: Tue, 3 Sep 2024 17:10:41 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <paul.wouters@aiven.io>, <antony@phenome.org>,
	<horms@kernel.org>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [devel-ipsec] [PATCH ipsec, v3 2/2] xfrm: respect ip protocols
 rules criteria when performing dst lookups
Message-ID: <Ztcm8eCyoQ5d9B4R@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20240903000710.3272505-1-eyal.birger@gmail.com>
 <20240903000710.3272505-3-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903000710.3272505-3-eyal.birger@gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 02, 2024 at 17:07:10 -0700, Eyal Birger via Devel wrote:
> The series in the "fixes" tag added the ability to consider L4 attributes
> in routing rules.
> 
> The dst lookup on the outer packet of encapsulated traffic in the xfrm
> code was not adapted to this change, thus routing behavior that relies
> on L4 information is not respected.
> 
> Pass the ip protocol information when performing dst lookups.
> 
> Fixes: a25724b05af0 ("Merge branch 'fib_rules-support-sport-dport-and-proto-match'")
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Tested-by: Antony Antony <antony.antony@secunet.com>

 
> ---
> 
> v3: pass ipproto for non UDP/TCP encapsulated traffic as suggested by
>     Antony Antony

This works with ipproto ESP.
thnks Eyal. 

-antony


