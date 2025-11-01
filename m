Return-Path: <netdev+bounces-234835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02052C27E02
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A64524E36BB
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31CF2F3614;
	Sat,  1 Nov 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OgJ+qHDB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE32C3262
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000147; cv=none; b=TgP67TIV4pXJjMLfru1gu2By1zzfY8Ugpeh/4qALaVFPXTwGjuziZ0VhXJEwL22LNyvXmGl7CEasdXjbQbcIKTcIVOc7gJmt3UXzzkMuPHX21gxGNH/5fsfgCJH2KXlobKS4cvN/5F1TiSAT72lB3auRUMiYPK6ZzTpd1AT+pMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000147; c=relaxed/simple;
	bh=C7wETZRKVW0fgyn58PIxQJiQi34YdSePuGaI7NkiBY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZOaLyk/RiRRYib2E+qKuqtw1AMp41AFxOSS9R2s+qNs+LCkcWlw8klPFi1XAA2AQkLAXX/hPLRBDGyUEgd8EeglfNvdm60cFt4t/LggC+g+GCT2lzxeaPv4yYoKdCdhm+TfkTRCqu88tZDV2LrcLWxuOck1Xy/cq9NIdF8N6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OgJ+qHDB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6BB6920851;
	Sat,  1 Nov 2025 13:29:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uiy034Ta2Ebg; Sat,  1 Nov 2025 13:29:02 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E64E220754;
	Sat,  1 Nov 2025 13:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E64E220754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1762000141;
	bh=zuku8xs+dj1BbxEn5J9Rrla39ntgSPFxuazw8ATktps=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OgJ+qHDB2sVA7e5WMIPgn9hJHiULWxN2Z1tPJyvXPHJcJd4WuRxfafwdEPwHCUZKq
	 HTlM8z7nX68r7v/bMUyXd/Qc+aYvfV0u6ayjNIT4UTB+tvAzpSB5eHN2hlksUkmO5m
	 EQgIzCeDgUHWsOkT7UBLtKZ6DU2i/Qw7LfV3MUZwlcwMjCO5Of+6w7dH+Y3fqeNUC/
	 y9GKQVZGouoZ31UObF7rG+1j6VGLoVjg9AKqTnlRM+4NMLUJStDpUVBYcG5W5lE33p
	 HizYsKjWicZj9WZDlg58GGvjqbDPDV8QbubyARd0YyR21ejixe6/7muFbOLeUiXLZX
	 JQBex0WNOsViQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 1 Nov
 2025 13:29:01 +0100
Received: (nullmailer pid 3045485 invoked by uid 1000);
	Sat, 01 Nov 2025 12:29:01 -0000
Date: Sat, 1 Nov 2025 13:29:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec v3 0/2] xfrm: Correct inner packet family
 determination
Message-ID: <aQX9DXuEBo7eBISZ@secunet.com>
References: <20251028023013.9836-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028023013.9836-1-jianbol@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Oct 28, 2025 at 04:22:46AM +0200, Jianbo Liu wrote:
> This series contains two patches addressing issues in the XFRM
> subsystem where the code incorrectly relied on static family fields
> from the xfrm_state instead of determining the family from the actual
> packet being processed.
> 
> This was particularly problematic in tunnel mode scenarios when using
> states that could handle different inner families.
> 
> V3:
>  - Change xfrm_ip2inner_mode for the sel family specified
> 
> V2:
>  - The original first patch was sent separately to "ipsec-next"
> 
> Jianbo Liu (2):
>   xfrm: Check inner packet family directly from skb_dst
>   xfrm: Determine inner GSO type from packet inner protocol

Applied, thaks a lot Jianbo!

