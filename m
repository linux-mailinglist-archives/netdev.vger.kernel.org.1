Return-Path: <netdev+bounces-204007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9ADAF8765
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD291C876D1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EB1DF247;
	Fri,  4 Jul 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="s75o/XOI"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB429A2
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608092; cv=none; b=AlqK4qmpj6gRBp8jBefOYmGH/fqK8rVE88t0plzkiSTzTNPwcOKiVMsltOIXX7iZKbvubUdmyaPdPBkLT9XbVl0CJJmFzRaI/nJchYpFXkvXNUoeXV1op6QadNtXA1BiVHjJUCOcyZVnUqk5xDkSzS+TKT3NsFd1umFetZ3Fheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608092; c=relaxed/simple;
	bh=pCmpmqNU+lG2jDy/e0Ny+2PIPaedzqZYHrXL2NchU9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7Q4QUxLiMSgRAvoenKhrLnIVbJ0O6kOPpqIB9Hl6YMRnTgm8gL22oR2j5HC60Cf+oJQLnWzUr9rFRFvgcwafOcg3aMXE8DeR0vQfBvM4beJUHoxzyO+qKMcyx/9Y4LWIJ46Q13xLqA+rE452NNwSA0mFogHPrD54WNIE/ndGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=s75o/XOI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AACA220820;
	Fri,  4 Jul 2025 07:48:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HmYhTKWB5lhb; Fri,  4 Jul 2025 07:48:03 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 99B2220872;
	Fri,  4 Jul 2025 07:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 99B2220872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751608074;
	bh=f+FFyoWhLRsx0avbs36s0XvQ1/oZSmS4tFdD95JV/Qc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=s75o/XOIQtqRKGI0csmv/85nm2kgGnV/vD6rPBiw0YnfFZLAGFRU1/0AdTEUsMlhr
	 1Vz6kNVUccrOmcjCSIGlZgIxEccMb3MFxMuIDiAM2aZOe6h0yjZWRtcO2qYN2nM1Ts
	 bQ5Ac+subfyJW6LaErjFRArGguSalmKu0PCrHCSAkNCUrci8gaovKYHmR0/saV6AuU
	 ynqAO1i2bUHXfzr/UGW1l4IX/kKxaBVAK6WkEJfG5g0f2qxCb7iX8RDzaoXGJyy2kR
	 VQEGzOOAP8x94oqq8EZvhZgmj+xD8nUNRm7O7qdL6+K3uTreObHD+nJuFYxHBWA5nz
	 OzUK779t4ZVnw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 4 Jul
 2025 07:47:54 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 07:47:53 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 31248318017C; Fri,  4 Jul 2025 07:47:53 +0200 (CEST)
Date: Fri, 4 Jul 2025 07:47:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Erwan Dufour <erwan.dufour@withings.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, Erwan Dufour <mrarmonius@gmail.com>,
	<netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <jv@jvosburgh.net>, <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Message-ID: <aGdrCYtJ5oe3NI7i@gauss3.secunet.de>
References: <20250629210623.43497-1-mramonius@gmail.com>
 <aGJiZrvRKXm74wd2@fedora>
 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
 <aGN_q_aYSlHf_QRD@fedora>
 <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>
 <aGTlcAOa6_ItYemu@fedora>
 <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Thu, Jul 03, 2025 at 01:58:36AM +0200, Erwan Dufour wrote:
> Hi Liu,
> 
> Thanks for your explanation. Unfortunately，the alignment still not works.
> 
> With pleasure. Thank you very much for providing an example with an
> explanation.
> Hopefully, there were no mistakes and I managed to correct all the errors
> in the new patch.
> 
> New Patch:
> 
> >From 39639cf83712b13271fc3d8bbe3f4d9cd0b38db6 Mon Sep 17 00:00:00 2001
> From: Erwan Dufour <erwan.dufour@withings.com>
> Date: Wed, 2 Jul 2025 22:12:10 +0000
> Subject: [PATCH net-next] xfrm: bonding: Add xfrm packet offload for
>  active-backup mode
> 
> Implement XFRM policy offload functions for bond device in active-backup mode.
>  - xdo_dev_policy_add = bond_ipsec_add_sp
>  - xdo_dev_policy_delete = bond_ipsec_del_sp
>  _ xdo_deb_policy_free = bond_ipsec_free_sp

We should not add further xfrm offloads to bonding as long
as the security issues are not solved. Moving an already
used SA from one device to another can lead to IV reusage,
as discussed here:

https://lore.kernel.org/all/ZsbkdzvjVf3GiYHa@gauss3.secunet.de/

This should be fixed before we add another offload.

