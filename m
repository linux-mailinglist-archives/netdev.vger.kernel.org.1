Return-Path: <netdev+bounces-206559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92343B0377F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB4B189A419
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0322DFA5;
	Mon, 14 Jul 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="F3CdRZ67"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4A226D10
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476545; cv=none; b=PQkg5kxszJ7XL66otpIqVinJUCd+hxtgK2HquUSge98R+t+i+U8koKrQRoW985qEhcx1KbgUYKxcxI3GSCsgMVHPLGxeJrwSc1VYf4YqC9Sbu6l+S4gXziDf5na9SL13abq4/ViWY9wvrtu6OLBQyh0x5AndNvj377FV5CKakpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476545; c=relaxed/simple;
	bh=bgIOWn/K5EAZW6hzZogZ/IrackZtioQTLxvGGcbHIe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxG4mSqlDcOLgRFvki3GAjH7cpLKiLzNOOROAvdZySFNVgWyIDONTuO6ug+mBtnuYTunxEOlQuz5STdpAjAoeAz3x5/U0ZHb21vvL80gdcbJZmXf22NKK4K+kuvF7qBY16WV+DHT2ec94mAp6AN9wy2unjofbFSedfy4sorsyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F3CdRZ67; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7E3FD20799;
	Mon, 14 Jul 2025 09:02:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGijH4O1YSYy; Mon, 14 Jul 2025 09:02:14 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 016D72019D;
	Mon, 14 Jul 2025 09:02:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 016D72019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1752476534;
	bh=yh+GIEOVmSr2pyx2mdwaLLrODuQ3PbvNg+9h7dMEgPI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=F3CdRZ67neaAFvctlHUuXu1RKqdvBP8oC+dd7aE0HxD3FCSXm7AD6soWOy2/jo1S9
	 t4tY66/O4zP46bE9oKEhnSnaECCGXV2VSYYShyckRJp0ru7Y1TTzYr2BpTRz6HAHHh
	 Aaq0XiRaxvRP056sHZUVU8NDLzzRED/94ITU5Z5cTnUNYbts1oYD/FSdQgnCq+DPNY
	 NMZABA7pFrodgVwrSeafD0wFDBvlyHgtKeOLh8VhvAvF5+KsavPOrjzGq+8KfG7suY
	 COx1IgAteVQ30yg/KwSq2UrC7ORHv0YSXr4T7b8ltu6XVTN/10icEGHrqA9c5I4O97
	 lnBdXxs3LWQKw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 14 Jul
 2025 09:02:13 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 09:02:13 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EFC253184234; Mon, 14 Jul 2025 09:02:12 +0200 (CEST)
Date: Mon, 14 Jul 2025 09:02:12 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"Alexey Dobriyan" <adobriyan@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH ipsec 0/2] ipsec: fix splat due to ipcomp fallback tunnel
Message-ID: <aHSrdJoHLtp6eIGK@gauss3.secunet.de>
References: <cover.1751640074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1751640074.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Fri, Jul 04, 2025 at 04:54:32PM +0200, Sabrina Dubroca wrote:
> IPcomp tunnel states have an associated fallback tunnel, a keep a
> reference on the corresponding xfrm_state, to allow deleting that
> extra state when it's not needed anymore. These states cause issues
> during netns deletion.
> 
> Commit f75a2804da39 ("xfrm: destroy xfrm_state synchronously on net
> exit path") tried to address these problems but doesn't fully solve
> them, and slowed down netns deletion by adding one synchronize_rcu per
> deleted state.
> 
> The first patch solves the problem by moving the fallback state
> deletion earlier (when we delete the user state, rather than at
> destruction), then we can revert the previous fix.
> 
> Sabrina Dubroca (2):
>   xfrm: delete x->tunnel as we delete x
>   Revert "xfrm: destroy xfrm_state synchronously on net exit path"

Series applied, thanks Sabrina!

