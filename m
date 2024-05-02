Return-Path: <netdev+bounces-92938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226748B962C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F581F23AB7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81228DBC;
	Thu,  2 May 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YW7hE5SI"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111637171
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637473; cv=none; b=ti/Qp7I5UMb1NvFOUmC4HgWe0U8pmLAjqKX502mx1J3AIlwoUoNP2ocC/8JBoyZQWnsa8orvJT15hZ8PJaPqqo4/lOHgkb85lHlpnVeL5zpG4UEOIcC2BmERcbATVFjRzA3td2jUdvocPkufEYmkKjPM3ShwxMES4XhNCoMOrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637473; c=relaxed/simple;
	bh=DGriqAhOTxd76Dxo40uWa+dm3rxSPa7nDe62YWF8jxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6ldT3lRuHeKqM6pLXAkR2Xt+hT+OnMWc7l133MtsrKE+e0V0L58zeXo1qbjxtjlsJFUOD7QoOwRefIDzhDZPP3xFDKnjfSAOFIcYgfajmdkohKLTLU8Y4RvWZP+rxK07LIS4y6ut+0W3MxMiMsH1S7MnoAChxwlhJKyOYbzGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YW7hE5SI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 53A14207D5;
	Thu,  2 May 2024 10:11:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrnlXnTVRmpA; Thu,  2 May 2024 10:11:01 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C7FCA207D1;
	Thu,  2 May 2024 10:11:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C7FCA207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714637461;
	bh=XlxtaM8lRUkWczyMwyFrGpOwaRWtFb5B2/p3Dv93ObU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YW7hE5SIoYFxziicEs2SHOEn/Yt7lO4nRxG1cFYT93CCur5Yxe6rQDnOy6l4rGlvb
	 Y3EyoVqztiiXjHmA17v+BqkT/7AhBpymWB9hMLRM9XflID9GBzC8GHEWEMZ5KTvEqE
	 UXwTJDuJ2ocvadUrrQpGUzUCUbcdbwF44frs7hMr+Ggxo0MWkE/aBdDo+WAHmSFiiW
	 /SY2Ty/MOHiiSAggQoAHjImZXIHuya7fwsHQMdEWHeE4KmlaRnM71hfw7ceL7AOCM7
	 fx5LKE9ET5BPuaqbC2LBs43sFs2Hr1RyK38/ibkcPbw5hAwUkz29/vcM4DVoMChDEG
	 S5pX5ItnwoMuA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id BA4BE80004A;
	Thu,  2 May 2024 10:11:01 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 10:11:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 10:11:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C81453182B5F; Thu,  2 May 2024 10:11:00 +0200 (CEST)
Date: Thu, 2 May 2024 10:11:00 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"Sabrina Dubroca" <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v14 0/4] xfrm: Introduce direction attribute
 for SA
Message-ID: <ZjNKlPAUUgcUkE6F@gauss3.secunet.de>
References: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714460330.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Apr 30, 2024 at 09:08:06AM +0200, Antony Antony wrote:
> Hi,
> 
> Inspired by the upcoming IP-TFS patch set, and confusions experienced in
> the past due to lack of direction attribute on SAs, add a new direction
> "dir" attribute. It aims to streamline the SA configuration process and
> enhance the clarity of existing SA attributes.
> 
> This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
> ('in' for input or 'out' for output). Alsp add validations of existing
> direction-specific SA attributes during configuration and in the data
> path lookup.
> 
> This change would not affect any existing use case or way of configuring
> SA. You will notice improvements when the new 'dir' attribute is set.
> 
> v14: add more SA flag checks.
> v13: has one fix, minor documenation updates, and function renaming.
> 
> Antony Antony (4):
>   xfrm: Add Direction to the SA in or out
>   xfrm: Add dir validation to "out" data path lookup
>   xfrm: Add dir validation to "in" data path lookup
>   xfrm: Restrict SA direction attribute to specific netlink message
>     types

Series applied, thanks a lot Antony!

