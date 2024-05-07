Return-Path: <netdev+bounces-93991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F148BDD9B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B0C1F252FB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3A14D2BB;
	Tue,  7 May 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WA6+igVF"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41E14D433
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072444; cv=none; b=A50cTUHi4RlalrE3aQv3Vzm/b6oTtzcIu4L0kjY8goPVw5Q1UExDeC/Q9A92dGeri3NinY07ld2ebe7an9JQkDAGr+PYoqGd/fOXKjZyRpIkopDVNaboC1tGgBh2mL5GPLIqUbWBQvbYiLijUOjHkAOqoFk4nF516CSA2zXnjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072444; c=relaxed/simple;
	bh=jlM5txzFZ9WGOwwWjDYGB2K5DkqYGjfkPZbqbcV4ZAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7Vcj8cTkbYhzoH6uYw1PAeEP5079tL4ERgof8WT3gQV7mf+7j5oPmYq8rSIxJt3gxumXFh/i+kNi6G7DkwvoKE+AOBIAY51zjk2Djhq2pWmu1lXWkREZkMV/lF6t6jmynBYuINBu2BOvwWIH16fCiEPnSkiNbT8W9hVQXhrvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WA6+igVF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CEF0E201C7;
	Tue,  7 May 2024 11:00:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOA8wC8e3jTT; Tue,  7 May 2024 11:00:28 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5DD85207AC;
	Tue,  7 May 2024 11:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5DD85207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1715072428;
	bh=A+IUFmrPq6D4hLdVrXPdIx2jJbx8oow202JHdyMt6L0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WA6+igVFtnrQfAKMbLqebPQQR7h2xVhfOw1+9bSk6wDxrp3Np///Cs022wrg9WgQk
	 +YxnkXsimwE5hg1q8idtV5qwoS1Wuf5YAoktcMZYWnCpejIHDvmsGU87sf7DRrUew6
	 QUHe7J0mK9U0tl0mahezKQxInOr8+cIUiqUyARjEPQnLmvkzG2T5WjENngxIA72sjk
	 MCRJ4AFWOXyxFhn1ES/3hFL73ODAp1Sc10LINssnUkwvHigIP63jMB2rM5UWc7GFqQ
	 Rz1ms+pv7WEoBpzMVB7FQ9XCKBRPLJFh1hjntWH89xooIx1oUv24FGjs1XXm976Zqm
	 eLWodt/MgDOyQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 4AB3D80004A;
	Tue,  7 May 2024 11:00:28 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 7 May 2024 11:00:28 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 May
 2024 11:00:27 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9E97A3182A87; Tue,  7 May 2024 11:00:27 +0200 (CEST)
Date: Tue, 7 May 2024 11:00:27 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/5] pull request (net-next): ipsec-next 2024-05-03
Message-ID: <Zjntq3jSFL2Uud9i@gauss3.secunet.de>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
 <20240504143657.GA2279@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240504143657.GA2279@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, May 04, 2024 at 03:36:57PM +0100, Simon Horman wrote:
> 
> Hi Steffen, all,
> 
> This comment is not strictly related to this pull request
> and certainly not intended to impede progress of it towards upstream.
> 
> However, while looking over it I noticed that Sparse flags a rather
> large number of warnings in xfrm code, mostly relating to __rcu annotations.
> I'm wondering if, at some point, these could be addressed somehow.

Yes, maybe just start to not introduce new ones and then fix
existing ones over time. I'll have a look on how I can integrate
Sparse checks in my workflow.

