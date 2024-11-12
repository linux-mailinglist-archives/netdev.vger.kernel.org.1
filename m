Return-Path: <netdev+bounces-144055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F439C5648
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5668C28FB21
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00201FA82C;
	Tue, 12 Nov 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AQsLa6oV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D271FA82A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409412; cv=none; b=ijlb1ZJVET9BIWyGYGl9p/To9tkBYkwQNP8/wwS0bf5J1sJkD4vDppu/YXvtswEJ/UFm2pzWkpfilF0oecvrneD3av2H7UyKnn3HwhTe4GV/w6joQJtDK85Bcq1PORNrPXz7+vd/5KxtyyDfjxmggLa6J8OEvpmtxhGqe7i4B10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409412; c=relaxed/simple;
	bh=/x5YuiCq/AjlWF9tqKWYeUp2cHtlt9hMzbn2yZkndvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIJA0fnxUuREDNBZNfmFq4r/Roys5feZQrD24kMPvai9EZdNLxQ5DPNAghWd8/seO82kKVmbECA2NEqYHjz2gQ15yHk/o3JXtsmZVg6RVZvP5qZnh3y6peERGtioA4m6d0b/6zT3DdWRVuC0DcowB+j/7aXLeTxmIFmlw+E4AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AQsLa6oV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 70E73201AA;
	Tue, 12 Nov 2024 12:03:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8uRhBvCatskY; Tue, 12 Nov 2024 12:03:27 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ED16B2019D;
	Tue, 12 Nov 2024 12:03:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ED16B2019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731409407;
	bh=bQUg+6pMBIpLJkp3D1IzVm9YXVvxcWbp7gUwe2wZd3A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AQsLa6oVU6bNmkg4HKdxj9hSAX9e2r8RIeXUf6pTG7cWs9wPmHj7NzqMYE9cT2sS5
	 KBoZw396lcB1mIRKVT+eV0j1z7NHweA0pF0F8n098dULmoefl9gMxYsdsVUR7b+F9H
	 NHf++1ZvlD+N1GPVEyv7qugeWlpkNmIaMKmQ1BonjSGILUA1yDqHoDsgJuexSmK63f
	 K0Yj7xgNlEBuGPs9WCy8AHwB/+nrWZc4cQhSRI9fCkdCDWNOtGNFC1OerHnKhVQM8k
	 AK8+Dekv/6cxX7sAPepFsPZ8frBU0MNBBYGpAJuwPZX7jSHA+t7fTvbOcSyhwuW4zp
	 w59xU2HfdUqGg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 12:03:26 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 12:03:26 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 02AE531844BF; Tue, 12 Nov 2024 12:03:25 +0100 (CET)
Date: Tue, 12 Nov 2024 12:03:25 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kees Bakker <kees@ijzerbout.nl>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <ZzM1/S72Qj0tBCC0@gauss3.secunet.de>
References: <f9eb1025-9a3d-42b3-a3e4-990a0fadbeaf@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9eb1025-9a3d-42b3-a3e4-990a0fadbeaf@ijzerbout.nl>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Nov 11, 2024 at 09:42:02PM +0100, Kees Bakker wrote:
> Hi Steffen,
> 
> Sorry for the direct email. Did you perhaps forgot a "goto out_cancel" here?

Yes, looks like that. Do you want to send a patch?

> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> [...]
> @@ -2576,6 +2603,8 @@ static int build_aevent(struct sk_buff *skb, struct
> xfrm_state *x, const struct
>      err = xfrm_if_id_put(skb, x->if_id);
>      if (err)
>          goto out_cancel;
> +    if (x->pcpu_num != UINT_MAX)
> +        err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> 
>      if (x->dir) {
>          err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> 
> -- 
> Kees Bakker

