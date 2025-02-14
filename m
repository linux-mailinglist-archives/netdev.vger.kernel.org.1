Return-Path: <netdev+bounces-166357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF0A35A6A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A1C188F3C6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A42253E8;
	Fri, 14 Feb 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="m9+USAoA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568724A08
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525499; cv=none; b=RqpggYcVV7Zq63tdQEHJ0LB2fSMwsWvqV8scxSeFSDDYDW/EJI8jZiyU4Y2vMQfH8kyDw8R2FIozk5sjSB3kk3OHEn/c9KeZ23mFSs17thHRIhzKWp8MD/y7hKkKW3MGCgh1iRhD7JNpSBTzunYJRe6KaahDcfQdhlMNmeRpXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525499; c=relaxed/simple;
	bh=wdschf9O1m1VJH/zAsQys/xXsB1sB2Iw8LhgfNwtqIs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnfYW00EFEU8NlgKEipaSTp6c1KFwySN45PtOQzosnLpjPxnnG9gHQJ2SDmJFz5N0rdEd2qAqTRgcM8EdRyFD9vwiotR8WNmmzNqlBOnuvVrlS8prmnrtSiJcPGBOw9AU/Red8mbBdyz0gufQRmZOYbICri5X2EXV4LOdmUV9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=m9+USAoA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 468202050A;
	Fri, 14 Feb 2025 10:31:35 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8iSnpJRrHIwy; Fri, 14 Feb 2025 10:31:34 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AD1E8207BE;
	Fri, 14 Feb 2025 10:31:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AD1E8207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1739525494;
	bh=kizibBiKr4GUARSQiBPxPT7jbGS25dnwPGaEukQe/QY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=m9+USAoA9Ch3PmuVCRx3vB0w/HEnoTtz2+GDvYPXjAIhkqjnLro0txWq2vKmMveYM
	 b5pITilqVqLGFZRptPj6YfeXoloX2TBP/esJnxD0yauU0BLO1WR3KJsmwAmF1neA+u
	 stHP8oMOWiN6S+UbuB+Ipa56eZzEHB01rJ/W7i6nHxDoubO7IihGD7KeI81R6iOhjY
	 4OZS8w5VcgE30DEyV5oViXrNpfxr3OUoYRZSFdfyqoiaT++RIRe7KNQthBMvYhMqZv
	 br2JxTJ6ntfu7d3Nf880SAuuE5gO/Pu+j13qExGoDHetFDHr5EVLruN53/WSrS4wjs
	 HOc4T1PFgM6nw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Feb 2025 10:31:34 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 10:31:33 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9012C3182F5B; Fri, 14 Feb 2025 10:31:33 +0100 (CET)
Date: Fri, 14 Feb 2025 10:31:33 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next] xfrm: prevent high SEQ input in non-ESN mode
Message-ID: <Z68Ndbk6JC2nV4qD@gauss3.secunet.de>
References: <36514f25843ca070b2820c650a5510cb158bbd41.1738779970.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36514f25843ca070b2820c650a5510cb158bbd41.1738779970.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 05, 2025 at 08:27:49PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
> are not used. So make sure that user gets proper error message, in case
> such assignment occurred.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot!

