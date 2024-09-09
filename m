Return-Path: <netdev+bounces-126526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A916E971AC7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B1E1F22A94
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE31B9B43;
	Mon,  9 Sep 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uVcSyN7L"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414C1B9B29
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888097; cv=none; b=kyE8T7kcH15eaeUqVsbQaFyfY9ErReN8XWK7wOcenFPZVv4jrYVf+U1wCXi0wBImjN29AIf466xCBHIcMpv0WywnRceK1tYiZq1A5/ZD+hDnqYxpJpn4TAdmayxU8tX2g/Lb9UDT/4zqB+e2+5Sbpz2ZaaFUZKyHQmo4ZAanDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888097; c=relaxed/simple;
	bh=tIEMl8vEaa8GVtiPU5UuXiwjnQSLH7Z0LYhFSi/RVn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1srKgf0qKUfJpKP+8I0xz/foVvY1ANhZqvUs6BaIKn++6Ujy2WqBAnO+e3Kv0DFzUlvkUxO2kl495z0oXs8VdgjuRLpe7XqiJTuVMSTjKAC3yeBo5mD2AqUpNf/RxgJmpctloXnIOxu+aoPQXdleczBKCDSO4t7Atkg3wKPtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uVcSyN7L; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 195082074A;
	Mon,  9 Sep 2024 15:21:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7RkEb3MDlJnd; Mon,  9 Sep 2024 15:21:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 948DC2067F;
	Mon,  9 Sep 2024 15:21:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 948DC2067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725888093;
	bh=kkK7ITJ6d820xYAplnQqNtdeblJ+KPBShJj99x2AalY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uVcSyN7L/NfZdQqEOWdD0UksWiex6pAQ9HIpqJ030kAPaldlhrUphPw71wPgamWDq
	 j8B7MGe9WXdACYM9TY16ueTEV+VHW0rxanYlDLvpiz1E7xfhjRfUx6nTDIaCSt4o9A
	 bTE6AOSz7RcJKGaPyB9Sw8EUiIaKCMWxKYO42t+M336/6jMc4rvLOj9O4kTOCFP2Oe
	 qMyNifvmrh64KYSNcDZ/ktD4uKJnzrcakjH0CHa6vV2p8kaKjs2HQNVjvvRYhQ15LH
	 9QQA5oj7rjvpxCGce64yyTbSoEOWUQ3pEpGoxwPEAoYzCsJHBCGS15kmi1QHcyK7sh
	 KpRA93QSnZtLw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 15:21:33 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:21:33 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 043A83181DDC; Mon,  9 Sep 2024 15:21:32 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:21:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/11] pull request (net-next): ipsec-next 2024-09-09
Message-ID: <Zt72XMBpASeOo96y@gauss3.secunet.de>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909100328.1838963-1-steffen.klassert@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 09, 2024 at 12:03:17PM +0200, Steffen Klassert wrote:
> 1) Remove an unneeded WARN_ON on packet offload.
>    From Patrisious Haddad.
> 
> 2) Add a copy from skb_seq_state to buffer function.
>    This is needed for the upcomming IPTFS patchset.
>    From Christian Hopps.
> 
> 3) Spelling fix in xfrm.h.
>    From Simon Horman.
> 
> 4) Speed up xfrm policy insertions.
>    From Florian Westphal.
> 
> 5) Add and revert a patch to support xfrm interfaces
>    for packet offload. This patch was just half coocked.
> 
> 6) Extend usage of the new xfrm_policy_is_dead_or_sk helper.
>    From Florian Westphal.
> 
> 7) Update comments on sdb and xfrm_policy.
>    From Florian Westphal.
> 
> Please pull or let me know if there are problems.

Please wait with pulling, I forgot to apply two fixes
for the policy changes. Will send another pull request
tomorrow.

