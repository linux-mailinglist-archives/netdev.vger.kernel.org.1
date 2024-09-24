Return-Path: <netdev+bounces-129448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0DD983F86
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329AA280F23
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30027148318;
	Tue, 24 Sep 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GKxqBN62"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701C14830D
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163801; cv=none; b=Y4mBuEZB8XKfWjy5YpcJ6+wFidj/FG/ZTBtWbB59B0cawAl5BKXiFa46k7ZtmsIIwWbnXjuGUOywBZY1nnLs93CVAq1vEDOE3J0RHpslCvkFAfdB0Ow5Sy/gTY8sxAbloUqXuVwUkHrP/X5L2lRncDxvgXQdkZw9MQCKLW55VRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163801; c=relaxed/simple;
	bh=X7AaNZLiVZcuAnzeO/2iTPaSxqYRJZ+qLdefltnRntQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQBVmXAA/n5r4sbh2Q93kF1RLya2j5mbQQZe9Siu8qtbqH92gtkmFPiqCe6FEUo7963YzO3ZHDjH38xYKFrr3URNIs5tTyZQuRtRyxkSLosqsENRoDsbAZXIWOg3IJyQUDqilHUm8wXmq6BO6sxQpjsJQZpeZxKxlyI6Tzor6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GKxqBN62; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 95C94206BC;
	Tue, 24 Sep 2024 09:43:15 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uufCeY-tROV; Tue, 24 Sep 2024 09:43:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1CCA1205E3;
	Tue, 24 Sep 2024 09:43:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1CCA1205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727163795;
	bh=a3/SLDtT0iWEgfhqTJM2mfLG58JpBd+oGQ81eNMT+mU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GKxqBN62yq4vFr0mhUNTbdaeVhIjy8QVynL9E4fmjPK57m5SsxDfzJuaq9Kb6vIXf
	 1Ew5xtXwbhsbTH12XSM3aIKLvRc02U/f7/CmH0mmfPezUt/AeJ+JH40ymYG5JGGwpc
	 PwUJG4GtizaBceRZiWjFOD0dXZ32wwxZTV0BwQFd4jsUIWq0S+pCCor60OQ5qm8E7t
	 NctsmKN9/aZdpp/fjd/KxzH/CneHrA4oGT5sSS3g3vnsqO1zY8fdqo04CAMZwBLXbf
	 X4yaMhtpmeWvcrXJJs8V02GRzclyx92mRNxtR9PgnXGU901/Fg/yL8Yb7er9GmR6Pi
	 cD0XF0b6wifhQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 09:43:14 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 09:43:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5E48D3182A8C; Tue, 24 Sep 2024 09:43:14 +0200 (CEST)
Date: Tue, 24 Sep 2024 09:43:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <herbert@gondor.apana.org.au>,
	<paul.wouters@aiven.io>, <antony@phenome.org>, <horms@kernel.org>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec,v3 0/2] xfrm: respect ip proto rules criteria in
 xfrm dst lookups
Message-ID: <ZvJtkq/i/1xMQPBx@gauss3.secunet.de>
References: <20240903000710.3272505-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903000710.3272505-1-eyal.birger@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 02, 2024 at 05:07:08PM -0700, Eyal Birger wrote:
> This series fixes the route lookup for the outer packet after
> encapsulation, including the L4 criteria specified in IP rules
> 
> The first patch is a minor refactor to allow passing more parameters
> to dst lookup functions.
> The second patch actually passes L4 information to these lookup functions.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> ---
> 
> v3: pass ipproto for non UDP/TCP encapsulated traffic (e.g. ESP)
> v2: fix first patch based on reviews from Steffen Klassert and
>     Simon Horman
> 
> Eyal Birger (2):
>   xfrm: extract dst lookup parameters into a struct
>   xfrm: respect ip protocols rules criteria when performing dst lookups

This is now applied to the ipsec tree, thanks a lot Eyal!

