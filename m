Return-Path: <netdev+bounces-66150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68483D83E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BA61F2D819
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE631A731;
	Fri, 26 Jan 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZkJxiWNq"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41841EB3C
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264402; cv=none; b=uykE0YItuT8/4dvPPbSqjfpIzEgR4S5T8hilV2ky+Dc2oHbeMEQaVibdmDQozA0Y++H4P3vM630lKFmJcXwodpeQhd3WfaDEnxCYsv82u+u88B337LBzt6YYCMVNYdb+4gOLvanW0ilMzceOe2ehbU5dnnl/dJ6IS9AKpVva2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264402; c=relaxed/simple;
	bh=6GLPo60gqGu2Od60A7VCHfjR7l+P8Lk70OlAEqztLpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/bqX0fBM2u6xxtO0QcRbBLEtQkHo96FH9OMU1ngQuRxcXHZ38oJD6PEyLWXuoPRV4BwvEMJsB8CZfgjcf4QY2emP2uhUIl39Nx29ivFB07hN125y8iP8toveIOGPbdc1h1j0tH1jwc99OCbJmP4CrGqiAqKZNpHhtda7qLTvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZkJxiWNq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5F6A320612;
	Fri, 26 Jan 2024 11:19:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwQwreEPfhZH; Fri, 26 Jan 2024 11:19:56 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D212A2058E;
	Fri, 26 Jan 2024 11:19:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D212A2058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1706264396;
	bh=IP+WAf2vTms3bhf9HdZdKdU5ClpflLuel6gG09g85hQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ZkJxiWNqBERqPR5Q/w+hIXePhP0xNaLZzgXm0+Werk5Oj/GzItPxLCa0dg9Ts23Cs
	 3eX2bNWaoQt2yhZz+WVgvE95mtDRllgdhYq4oj7UIAQs7Et/qSsjyxqLENuzXa2krR
	 Q5Duxoi3XqHdi+5T2hZyk+b6xawyaPoSUpTbfWQdlSfHzuGEvq2sV8FxTZb6JR3HO/
	 WyJotyXWKaOPoj0nyecPjX8O4WailPP7We7IjcLHrQbvrLugnxU9fY8XLESr0oQgxH
	 XImviQrBdoVasoWFdmZRrWUGazqoTFjVHGl4i9NXCuRvc6KhTS3Don6K4WjID4KfuR
	 LG6Bi4FhX4cSA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id CA70580004A;
	Fri, 26 Jan 2024 11:19:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 11:19:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 11:19:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 00E9E3182A56; Fri, 26 Jan 2024 11:19:55 +0100 (CET)
Date: Fri, 26 Jan 2024 11:19:55 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mike Yu
	<yumike@google.com>
Subject: Re: [PATCH net] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <ZbOHS5lkH7k9LYy5@gauss3.secunet.de>
References: <20240124081354.111307-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124081354.111307-1-saeed@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Jan 24, 2024 at 12:13:54AM -0800, Saeed Mahameed wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In addition to citied commit in Fixes line, allow UDP encapsulation in
> TX path too.
> 
> Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> CC: Steffen Klassert <steffen.klassert@secunet.com> 
> Reported-by: Mike Yu <yumike@google.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Applied, thanks everyone!

