Return-Path: <netdev+bounces-195970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F09EAD2F5F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E571893B94
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E127A92D;
	Tue, 10 Jun 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VM52oqXV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090C43AA4
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542492; cv=none; b=oNev4tWhMyRDuU1YYfJaqksFhGbexVabm4fDEGmSdEVJ5bwvaHeVSATg+3iI0HNf6tG1yZfLPrkg2GZMchHC2id9xCN/UP+QBBsc1l5ruc/LRBYsKpi1ejD4OOBI0SduBL8uv4v7sJ17MGP6DZCFB1SjGT30MeGWm42baV1zEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542492; c=relaxed/simple;
	bh=k7v4+twcplGp1zRFXR05tWI20ecYScDZED4R7Mklghc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dptiyp71XwbDzU/Cw3jTVe7gdFUJxFVSTTI/lemGXN4bhk3j0EzU2XQth494cyp9pM0qL2WwFVJ5gboLFtfBJ7triITgOi+yF8F6HLH2UtG3NHvCJfPUHU8ofc7C2HNEtDYrqepBNYJpDHf2U1rl39MVy1duZQ0kdwOWWVYGK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VM52oqXV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CB89D20612;
	Tue, 10 Jun 2025 09:55:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrKjfzUhJfJr; Tue, 10 Jun 2025 09:55:23 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 10832201E5;
	Tue, 10 Jun 2025 09:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 10832201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1749542123;
	bh=K0+GkTxs2F6Eh+JWlC9I+4JQ5OWrqgtP21EqRRBz51U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VM52oqXVEfvMEtyQLcp2xpHguHcCSs8MhC2FOZdWrxts5CB5qqxc76hx/fnVCOwmm
	 CGOnjluxdmkHqtcr1zwg9Pb4jH6nMoNI8BPeUBY1Q+cXf6g/TkhDjd1ORx3PGHWNd4
	 fE843pT4wGhhSxTbScd3G+MWM6XWS5QVTuTKIF38YNYRpA83ifWYEBuq0M7+tbMUmA
	 Jqar4B/4FIzGkc/N18WzGBLiGmwXDpK9clIin4228JxTDv+KQZFu3ABUw5xgNZv3Sw
	 8NX2q44yFe3Biml7Vdn8eY21XKs93+YokM8Drt/hhHsRm0UZZmpALUCzxfgQP371li
	 TBtqe1YFoD2sg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Jun 2025 09:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 09:55:22 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1154C3182D86; Tue, 10 Jun 2025 09:55:22 +0200 (CEST)
Date: Tue, 10 Jun 2025 09:55:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH ipsec 0/2] xfrm: fixes for xfrm_state_find under
 preemption
Message-ID: <aEfk6oq05IRuKpc5@gauss3.secunet.de>
References: <cover.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1748001837.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, May 23, 2025 at 05:11:16PM +0200, Sabrina Dubroca wrote:
> While looking at the pcpu_id changes, I found two issues that can
> happen if we get preempted and the cpu_id changes. The second patch
> takes care of both problems. The first patch also makes sure we don't
> use state_ptrs uninitialized, which could currently happen. syzbot
> seems to have hit this issue [1].
> 
> [1] https://syzkaller.appspot.com/bug?extid=7ed9d47e15e88581dc5b
> 
> Sabrina Dubroca (2):
>   xfrm: state: initialize state_ptrs earlier in xfrm_state_find
>   xfrm: state: use a consistent pcpu_id for xfrm_state_find

Applied, thanks a lot!

