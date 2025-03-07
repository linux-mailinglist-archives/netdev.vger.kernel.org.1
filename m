Return-Path: <netdev+bounces-172792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC5A56087
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5AC1895457
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB119D081;
	Fri,  7 Mar 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DQj7/Imc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BBA19ABD1
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326965; cv=none; b=Px2r+NOao0ocE6XS/5y/vc2c9j7HkP536ehz9V+tFPkcJCrFhk+vUSgbT+n9zsz1xdm7wXkcXumsWbNNxZWAFQbKJd4xU0zWEp2DlMlAGrcsmy5yy0yNa8/1YrRM+Hjevt4Z8zQOrD8fpxk7hMmPkpAGnVolwuyEGlnUqMxIvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326965; c=relaxed/simple;
	bh=ceUt8jZh//dgX8toJ1NZG+ydsh7sTZqCCjqSumiEDYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCbKko20c18VSQFGMB1Xr2mv5WaQPBDabOHcHN6GJyfjsiVh17uA1APiy2IMaTaqIgS88yUCCrp59WYla7Fdw/uZ+I5HuzyLZEA5fjWzBqqTRrsiH4LkWZRivmmmu5+uNWBm8fRo6JYEZwfQmt048V2Dd5ZHh5kOK1WQWRMPWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DQj7/Imc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2ED0320842;
	Fri,  7 Mar 2025 06:50:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCZBqe1HLdXO; Fri,  7 Mar 2025 06:50:50 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A54EA207BB;
	Fri,  7 Mar 2025 06:50:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A54EA207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1741326650;
	bh=29f+pgvqluMPQGFxzIIGwwKsHatu0dtVzGGpc4oGUCU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DQj7/Imc29H33JIwqD+S5IqxqDsKmJ2Bf0D755B+T6GfnsjksDuwJk9rsFYLt71Qx
	 0hm2iLv2Nv04jgfEHtf8z8JAH0VmaZHm7SEbUqyLUvDgtj103ce/a5y7Q97/2qrBId
	 VSdkmhbC+tUxsBD5m3DF2hT3OGufqhnWk+zneiPZOKia6S5/gl2+hKrq02+HTeFOOK
	 FDtXcZlzaZw0EaW/F1exfp/dTaARmcKAgbc7TxdXNepNARZ5Ng0tASj+wQpSR36Ujf
	 er0QOvWhqe+E5fQljOh1jzecxyEMG2fKvZUCoB0BRYtNFS0D9359/JLpATrMiGAOBU
	 6rkQ9pRIIDHEg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Mar 2025 06:50:50 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 06:50:49 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8D1A13182D7B; Fri,  7 Mar 2025 06:50:49 +0100 (CET)
Date: Fri, 7 Mar 2025 06:50:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chiachang Wang <chiachangwang@google.com>
CC: Leon Romanovsky <leonro@nvidia.com>, <netdev@vger.kernel.org>,
	<stanleyjhu@google.com>, <yumike@google.comy>
Subject: Re: [PATCH ipsec v3 1/1] xfrm: Migrate offload configuration
Message-ID: <Z8qJOVuMr+GamxUO@gauss3.secunet.de>
References: <20250224061554.1906002-1-chiachangwang@google.com>
 <20250224061554.1906002-2-chiachangwang@google.com>
 <20250224124956.GB53094@unreal>
 <CAOb+sWEdZ-kY6-qnG2u0h_JzeVyrf0b_eT+L=2t-5zCGaXedHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOb+sWEdZ-kY6-qnG2u0h_JzeVyrf0b_eT+L=2t-5zCGaXedHA@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 07, 2025 at 01:42:25PM +0800, Chiachang Wang wrote:
> Hi Leon,
> 
> Thank you for your review and suggestions. I noticed your patches
> haven't been merged into the tree yet. I'm unsure if rebasing my patch
> onto yours would work correctly with the kernel upstream. It seems
> your patches are suitable for merging. Since I'm not familiar with the
> timeline for your patch's inclusion, could you please advise on how
> long it might take for them to be in the tree? This would help me
> rebase my patch properly. or there are any other alternative way
> rather than waiting your patch?

Rebase your patch on top of the ipsec-next tree. This is the target tree
for xfrm changes that will go to -next. Leons patchset is already merged
into this tree.

Thanks!


