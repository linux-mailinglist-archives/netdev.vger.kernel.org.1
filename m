Return-Path: <netdev+bounces-219451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F20B41538
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E4E1B60258
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AB2D660F;
	Wed,  3 Sep 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="x6Mrn56C"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730A2D63F1
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881054; cv=none; b=UFThzamuS73monpOhiTwRtaOy/gR/aYAhDKRfDbOc992/5czgkiKlzRV0K95FWOo6nQ1GBuHz75uZsykpiVbmqZ4AcFlLutcpmZV1SjYIcn8XQJBOxWLW13yrsH3FkFUJPvXcDHiit4iY2EIT/HkcOEm4m0LhVz25fU9RvJX6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881054; c=relaxed/simple;
	bh=+ICxwKK6hJFsowULuFqAsADj1Gm0liG53o2aXB3V6Y0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9lU5TsGWbjyaYLfg7qEwlfzxIojfAhQL2mjGXdzeGRgjCBEyqPE6fCm8JiRrUbtqB1tm2h/I0e+xYgWdhv7KVG2OPW3/47Nywa0Jaq3WejHnyb8Gnlx2Y7Ptd1XlLVxd3MInuptFlP6kTunw4A4ecbbRwRnn5XX7SLrRlgGokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=x6Mrn56C; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4BAF6207BE;
	Wed,  3 Sep 2025 08:21:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8R07tqQ_LjyP; Wed,  3 Sep 2025 08:21:17 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E7452067A;
	Wed,  3 Sep 2025 08:21:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E7452067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1756880477;
	bh=LYLk/SvVcJ1awk3BtWRCyyHMoamJhFsBcefhJ2ZKgPs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=x6Mrn56Cr73DKgtJZ62fpHmvGEhFOxWORUEdLTPmUiHrgn3i1d+mzXkDKNgBuDYwU
	 jfghVRd8KZceXqZbrJm8Pr816mrQwR1/YU3nlhAzdhm7ESopcitfX8YNCPO/MweoRH
	 Ybv1s89C8Jua+frhdzSNWLdxcOPOHVQEZw12oqqsfYhc7LJOFBxrvJ+Fmtvj/ZcFm4
	 vr0HQoGQV2OwB6+gh5V81+ADN/siwmJp8rzWIQWLz9AeBe4JgwTNp/oMRozLFW5NRy
	 oiWSeKvgPyTB4YSuu7fZQxmjZbNb5+gqV7/R6MwBqONIk9xFA4qub3xztODZboPRQN
	 zpWLTKxUc+Ttw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 08:21:16 +0200
Received: (nullmailer pid 1666869 invoked by uid 1000);
	Wed, 03 Sep 2025 06:21:16 -0000
Date: Wed, 3 Sep 2025 08:21:16 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Aakash Kumar S <saakashkumar@marvell.com>,
	<herbert@gondor.apana.org.au>,
	<syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Subject: Re: [PATCH ipsec] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
Message-ID: <aLfeXFePeKjLPwaN@secunet.com>
References: <b7a2832406b97f48fbfdffc93f00b7a3fd83fee1.1756457310.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7a2832406b97f48fbfdffc93f00b7a3fd83fee1.1756457310.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Fri, Aug 29, 2025 at 10:54:15AM +0200, Sabrina Dubroca wrote:
> x->id.spi == 0 means "no SPI assigned", but since commit
> 94f39804d891 ("xfrm: Duplicate SPI Handling"), we now create states
> and add them to the byspi list with this value.
> 
> __xfrm_state_delete doesn't remove those states from the byspi list,
> since they shouldn't be there, and this shows up as a UAF the next
> time we go through the byspi list.
> 
> Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!

