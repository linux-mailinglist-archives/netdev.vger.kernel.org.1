Return-Path: <netdev+bounces-129662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF1985443
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 09:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF328132C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16A156F3F;
	Wed, 25 Sep 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FSPcdzke"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B5156F30
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249786; cv=none; b=XO0CrVYOWPmfMHldiRhG2poNNEkqacuPkDZ5DhCG7s1wpLL0AOniunyokncX0xNCcNVFn9yq0vQLDroyTangs6QUqZXY9oJOWzmgPBOD/C+sVftd+n76KnitqDMukCV2WiaQIisYGkOCiSu8/bX6LnI+d4j214NgAoMMtQ1MMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249786; c=relaxed/simple;
	bh=HVeXp/x5rJUeUPcHd/1F1Nelhk6loN3qd4lm7deEZxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu0ONj0Gfc7+fw+u+D6rT1D8QCcVuRXU1xBc/J1BBZnt+pkJp6tqdz4OBIYixoaGKdzk+9e3u0XMqbdi0jyW16kpgBp4YCBms5FfQMU9OxXNLeLNnpow2y8Q/5xLeDgj/IE66Aj1e8u+kKrY38IRphR+Z8M60iV7vFBlT85ffLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FSPcdzke; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BE258207C6;
	Wed, 25 Sep 2024 09:36:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9W0LwQbW4P-J; Wed, 25 Sep 2024 09:36:19 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9913E206D2;
	Wed, 25 Sep 2024 09:36:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9913E206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727249779;
	bh=8W84ooKFIti4Malg7MovOqoNqP3eP78XnycVKszkFsw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=FSPcdzkeygcST+FKKuB31+pmRGJhjKm1FJEqqL+dPo88UShqRSO4qhgNhBmkBrNh2
	 Ds+22tMJLQnyeiNcbl1EoWGWL8GPCcU/f63JWlY0RDXXKHlfh4Jfnl/Dj3rO8s/o4W
	 DoRnohrr2FUOsFY9Oi164Q0kmyacbDHYHQt7qmE7gUdl7UEpvoTnXwG5goDb1WaCmb
	 /BQ9/hb7CJwI1aFpYT1YfAAFtyNpqkgTvxX3XM1Af/VGD9bYSRo6xjKvduZgcSRfdV
	 pK354YqTiPDhf4LB9Nd3hZsFESTQerBz6eSBiqSiHjfkfJYdiuq8uWCzHKXSlH0Cdj
	 dGFfkUqNYzrTQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 09:36:19 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 09:36:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 17FBA3184E08; Wed, 25 Sep 2024 09:36:19 +0200 (CEST)
Date: Wed, 25 Sep 2024 09:36:19 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec] xfrm: policy: remove last remnants of pernet
 inexact list
Message-ID: <ZvO9c0jeAeZZBDOr@gauss3.secunet.de>
References: <20240918091251.21202-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240918091251.21202-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Sep 18, 2024 at 11:12:49AM +0200, Florian Westphal wrote:
> xfrm_net still contained the no-longer-used inexact policy list heads,
> remove them.
> 
> Fixes: a54ad727f745 ("xfrm: policy: remove remaining use of inexact list")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied, thanks Florian!

