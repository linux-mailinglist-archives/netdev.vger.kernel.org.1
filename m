Return-Path: <netdev+bounces-234834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB52C27DF9
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B4D3A6166
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A62F6193;
	Sat,  1 Nov 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qjbeLNVi"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27582F2608
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000023; cv=none; b=KHVohGX16nQMNBovYkjtRTjQvlMw72Nx2LCuY4TabB1vUK5vHrBDzTfl7vCjhODejRmd4HwrV9HhkaaHtpEkCFTnPKd5RfwMCRzI2HVv0J/nhK7Uw+/fQdVAfQEkrqMlRNaJ+1bjPrzEHKn3nx5lzIG02QrdjLUmOuxI3HzMWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000023; c=relaxed/simple;
	bh=Etxn1jKut8luil+fb2sCY2jg53AMjlPXBkfbCeRiofA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNCqKOrGmuAF9F/O1NGr+BRQR7rdplQwi/Rqq0kT9EowLCkBbFK+R/0ScuEYEPBCHYZ7lQWor0XgsjUgOaL8K0mFcZ8+ZZUtayxCjZBmPrnDuK59swzF4QlX6t0f8TKmCrkMUJ/e90mmOAvZ9Oi0PaghyPjFJfcayCDVtaOmsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qjbeLNVi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AD5B320754;
	Sat,  1 Nov 2025 13:26:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhVQeTevsJMJ; Sat,  1 Nov 2025 13:26:51 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BEDD720704;
	Sat,  1 Nov 2025 13:26:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BEDD720704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1762000011;
	bh=GxdQtgLz3QT6n5vA/el0q2FQGC5dD+ouuKJHsDgjcho=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=qjbeLNViEe5rvfVjnSd7m6NGMFpuEjcGpHlCd2gBn2/RuWS7X7FpgmWHXWDoLvzqw
	 0yNNXowrDqtUC+oLmYJc0SGuJ3dJme3AO5u5761KrtysmrU7HOsisSnOuVh1y7/+EY
	 pA5t+bVlKr0dUkndxIjkZJxWhg5Ch1jVDLUBCzHoRSkcfd8/fJTGkw59sOcPdMw5g8
	 Fomn12ZUlp1lIXRGTmY5nTqJM5mBwiZbeRMLqHPPial6zL3MMMBZP168qj28eDapNY
	 urvDDSt3n+1qMlAb42BBzf+94KAlcyy48ADVhbL++Q3BASaDW3ZrMv/Jp71HmFXZ3G
	 /kxUPZJM27vKg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 1 Nov
 2025 13:26:51 +0100
Received: (nullmailer pid 3043879 invoked by uid 1000);
	Sat, 01 Nov 2025 12:26:50 -0000
Date: Sat, 1 Nov 2025 13:26:50 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>, Tobias Brunner
	<tobias@strongswan.org>, Antony Antony <antony@phenome.org>, Tuomo Soini
	<tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH v2 ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aQX8ipi5E7nccmJU@secunet.com>
References: <aQBitXM2fxLb82Eq@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQBitXM2fxLb82Eq@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Oct 28, 2025 at 07:29:09AM +0100, Steffen Klassert wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let config NET_KEY default to no in Kconfig. The pfkey code
> will be removed in a second step.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Acked-by: Antony Antony <antony.antony@secunet.com>
> Acked-by: Tobias Brunner <tobias@strongswan.org>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> Acked-by: Tuomo Soini <tis@foobar.fi>
> Acked-by: Paul Wouters <paul@nohats.ca>

This is now applied to ipsec-next,

thanks everyone!

