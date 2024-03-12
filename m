Return-Path: <netdev+bounces-79388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A7878ECC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBB51C237A8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 06:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317E347C2;
	Tue, 12 Mar 2024 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nnAxn9n8"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9632C84
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224420; cv=none; b=R/92ihSZFFFKpS03v2iC7TLrdQa2aoxyuX+s2Tenr+dGy5ifLE1kjrepWMd+G9VRrBVY0YkRNunkN3IS8KuXG4ePqjpgdS8gWeHtzVCN6z4UZSLLUxniPa/uuTdm/ejfZITquam5M7j4rad/OoL/luERYoG2sp/vX9eb5RVcf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224420; c=relaxed/simple;
	bh=c3dPdIjvwjvE8P+ORHCEnETznFpNXgM4Lc1yrw/H1NU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RadKrI8CJsBHvef+x78+DzuCuetGfW79niXphTcT1B0BgBr7O+KuvDS3I2MoMKPDOOMJu8FAwGrXj2sc/2Ri+163kVYZHdsWCrZOQgYEAKU19Wrx930keqpCSmeEBs/cM0IXzcvJgg5jqDb9U66tPTYkza9IlKU6F5OAibKZWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nnAxn9n8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5EEBD20799;
	Tue, 12 Mar 2024 07:20:09 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fewJ3RLKTdw1; Tue, 12 Mar 2024 07:20:07 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D4BAF206B0;
	Tue, 12 Mar 2024 07:20:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D4BAF206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710224407;
	bh=J409srRFAyWJ04odYB9Txf7DyRO9ftTSbbOyDu+Rnqo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nnAxn9n8Y/gEKRRyZioLaik9PA6cGNmt2h1/9/Zn1vlZzjFwp1ON4lypdXmqDiuWj
	 PYomnuvcsrbf+e9vtjQrr8DdK45LI7mjX8JGfJYX90wA5ns6pvg+HVHtFB/6PYj1ts
	 OtOMpYjIkZGZ5FfAZjNow12duskSOpnm8zD5XQg6VqN441ZTuqas/SgZiWtIhNox4Z
	 vf0tAtGTRVUBbg5LzErmp5Q+Nxeh8VErohpovjk6lCt3n7+pA7h0jYFh5rWZjs0/qH
	 KRowrKmHi+NzhhAFf8vDfcjWNonv+ONLNPWczPioaKdQLlfY32Oe/YBK3i3LGDSUuK
	 jhK8TxG4Unjgg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id C347380004A;
	Tue, 12 Mar 2024 07:20:07 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 07:20:07 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 07:20:07 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0DE6C31804F1; Tue, 12 Mar 2024 07:20:07 +0100 (CET)
Date: Tue, 12 Mar 2024 07:20:06 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
 <20240306100438.3953516-3-steffen.klassert@secunet.com>
 <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Mar 11, 2024 at 05:25:03PM +0100, Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > In addition to citied commit in Fixes line, allow UDP encapsulation in
> > TX path too.
> > 
> > Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > Reported-by: Mike Yu <yumike@google.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> This is causing self-test failures:
> 
> https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> 
> reverting this change locally resolves the issue.
> 
> @Leon, @Steffen: could you please have a look?

Looks like the check for x->encap was removed unconditionally.
I should just be removed when XFRM_DEV_OFFLOAD_PACKET is set,
otherwise we might create a GSO packet with UPD encapsulation.

Leon?

