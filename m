Return-Path: <netdev+bounces-104393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4A90C642
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AA91F22AB2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CC14A4D8;
	Tue, 18 Jun 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XVJ5WLKV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE7199B0
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696692; cv=none; b=CEHHCSsd4mq/Y2AyowHnAmE/rZyD5omU/cd6b11OWN2cTlqCz8FYhuNsNum84ZIqJQwJNYdNhoaeYiYqVIvfM3vX7ixr+n3C7j0eOy574t/MJ1SVFfM3tU8d/iHGOzG9IvAjIJjR3u/drCBsLrOMzhBZCusruztuMHFie5Ueg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696692; c=relaxed/simple;
	bh=3BhNzx9wpW5941WigkzOjzUMm6H+LNOsPD9vMx8stNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut+DxVW4SjsgEaQSNksTLPM9O8k5UF3+nt2fBGA1MS3fKOP+iO0E3GVIqxXHtQdoB9tj8z7/doPsMmPCdkumE9u8n9WRPfR0War8XOG7YfZG6OU16dpZBjQC27Wh28hDfxgjfxerltYwq+gQNq2ZOJYPliJHUx9ZqDzapbocky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XVJ5WLKV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EA123200BC;
	Tue, 18 Jun 2024 09:44:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oC4FEKJz8BI3; Tue, 18 Jun 2024 09:44:40 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6C4D0201C7;
	Tue, 18 Jun 2024 09:44:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6C4D0201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1718696680;
	bh=ypzRrIKsSUOuTAo4eOlKAjI1t6XP8wkXIAnf+vvfmIw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XVJ5WLKVmfBMCN9x7RMNVFbK6ZdSOA0WBJI+nFFFHrmqO6uOJCqKwg3wEssdbIyd9
	 2LLWJlpALbj4c2yNQ8ITyYSE7UMbLi2wp0nNQNfrPKn1pluS0NWMPa6W+eax4i86mE
	 9/UOQXyxHCWWZ+ofnSMDTwa5sDWjdskgZhhMhgjFhaKJYHXwlZcAQZXadh9fD7/DeX
	 MRv/Cy/qabAq05u1E3EWdMtBV1QQc7b4CHtGWIEZSPKf+rCzICJOP2h/A3kZ0cY0IB
	 ZAP+XMGRLQUFxXzj1uMp9P4oml0O1UtaQrNq/kGILeKq0gXcEPhhszp8boT7C0iL8p
	 5WMY4Bvb170NQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 5F31980004A;
	Tue, 18 Jun 2024 09:44:40 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 09:44:40 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 09:44:39 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7CD6F3181A35; Tue, 18 Jun 2024 09:44:39 +0200 (CEST)
Date: Tue, 18 Jun 2024 09:44:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec 1/2] xfrm: Fix input error path memory access
Message-ID: <ZnE65zSXPPHuCQys@gauss3.secunet.de>
References: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jun 11, 2024 at 08:31:29AM +0200, Antony Antony wrote:
> When there is a misconfiguration of input state slow path
> KASAN report error. Fix this error.
> west login:
> [   52.987278] eth1: renamed from veth11
> [   53.078814] eth1: renamed from veth21
> [   53.181355] eth1: renamed from veth31
> [   54.921702] ==================================================================
> [   54.922602] BUG: KASAN: wild-memory-access in xfrmi_rcv_cb+0x2d/0x295

...

> 
> Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Applied, thanks a lot Antony.

