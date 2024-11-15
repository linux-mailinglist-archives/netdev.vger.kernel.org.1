Return-Path: <netdev+bounces-145192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6899CDA39
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C21F22518
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B618A931;
	Fri, 15 Nov 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cOOLvVTv"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63E16F851;
	Fri, 15 Nov 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658092; cv=none; b=LtKOIMjXaKO7H/hO4vjUYr9ing/SfraXSQrEx/Z8KluH1WSCtiW4e1CqvvW//LcfdA73wOZ/qJL3jFdUVaaID7X6pkGvTI/zmwf+YHE5nHrFwpOy2HqOQP8ljcJ+fk6TDthEeNVtuYEI2CSOZ6wm3m+rIh/0pLITHt6meL6KPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658092; c=relaxed/simple;
	bh=KuZ8QQ0cN64s3FNYFRJncJ2EVtUJX2FM+AsdhOX+SQE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwLMGzecNQ/ki8VsUjEUl2+HFz84oP2EbeD2kY4hZioxAOV0Ux7qQho5k+TY1LgXzsZ3/BOw9ZXGL4rcaUFYKHY+9ul422Fm/1vP6q5ZsgbC4YsavkYRaSyZan654x8Z13m9qAYtgKESy2ePFdhwOmxhkdNwLrx+E4FzVoUBpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cOOLvVTv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9FEFD20518;
	Fri, 15 Nov 2024 09:08:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-6HhHY6o4B4; Fri, 15 Nov 2024 09:08:08 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 27976201A7;
	Fri, 15 Nov 2024 09:08:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 27976201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731658088;
	bh=ioc3w/ajVaSKxC3ChNCoi980p2KqNM5ThD83d1relDk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=cOOLvVTv71G31D8lSGdeqTeACccZG7gOi5KjVrsfpbRVwVdVjZ9f//usYwlCAS+EQ
	 zlvlmzUuw/n7elQBin7olwSQcdALuqG9k/fiGyqCdJcSgtwQZIGd7nOzLiGF6KarZh
	 bvoBXkZnAa8b9p6hf5puJTPm50bBTtExaZB3nBs0UOPUD3RO4mmG/x66YJCRIbiDMo
	 TJ518i2GjFXQJCDZ3wZJm2asvc2NwtuAb9qZe7r4omv/PD6b36CSdtXyoGyFGSxett
	 Ut9/g4t08in/ULETh5SFYWlY7eahl+fsbF+6r7W4+XhqMQW6N578dYv1+ADA8FZTNR
	 8eKJtKsHJ3EFA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:08:07 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:08:07 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8532D3184210; Fri, 15 Nov 2024 09:08:07 +0100 (CET)
Date: Fri, 15 Nov 2024 09:08:07 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Yang <danielyangkang@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "open list:NETWORKING [IPSEC]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: replace deprecated strncpy with strscpy_pad
Message-ID: <ZzcBZ5gEhE1QX2d1@gauss3.secunet.de>
References: <20241113092058.189142-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241113092058.189142-1-danielyangkang@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Nov 13, 2024 at 01:20:58AM -0800, Daniel Yang wrote:
> The function strncpy is deprecated since it does not guarantee the
> destination buffer is NULL terminated. Recommended replacement is
> strscpy. The padded version was used to remain consistent with the other
> strscpy_pad usage in the modified function.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Applied to ipsec-next, thanks!

