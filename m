Return-Path: <netdev+bounces-159690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4B8A166B9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051583A9B84
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E868188012;
	Mon, 20 Jan 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hHZA/ai0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314F537E9
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355216; cv=none; b=IHLWzEVtAvCbaGfT1p7vxduMmjbmZ33dFCA3g6r6LIj0yDA0dWIgo+opxAXdJRVYYW8wK1vfQg6DTcOojnAW3gRsmEmP23Dt7CWpyIHmyKZ/QusB/m/1la4FzOyn5etoBojUN/GtSkHz6A64gN1A7aVBJrpsAIMS64bA7HG8D38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355216; c=relaxed/simple;
	bh=T/GBI7XW6RK1jBreY1yhvpVo9WZtzMd2nl9TA+9Xm0M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+XmEE3r8g+5uwGLF0TIzPU39hMu4sKirr+T3PsCESD+viOqJc6DqNDx5S0C4ecnX5PRLZ3G5QNNwle5R3Oo1gYfb6zh064CF3RGqhy1v9eXZc3sfljwLpAIhbrtwBw33T5PrPzO1tALv/zxhs2YCEYCq1kj0K/tH613+71IXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hHZA/ai0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5B388206BC;
	Mon, 20 Jan 2025 07:40:05 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4zKchGgxdipJ; Mon, 20 Jan 2025 07:40:04 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D322A206B1;
	Mon, 20 Jan 2025 07:40:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D322A206B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737355204;
	bh=a6muCss3wpCO2fgK30/Usrv+SMY/sQFtCdjzK3XQoPc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=hHZA/ai0ocSsfSciOQiZQ2FyhUIfjTVscsYLFUbuoNxTDFWP5avuCLRhtHwCXGZoJ
	 BXjjyCcSCIk8N/ERii1RAk7ocwI0QbR+SgHkTtGWT32Ke/i9oY7jy//XuC6NQuF3u7
	 Hz/YBraK/Npwdlt40evf1hv8dVV/J/7JukWPS1jOJJY2xV7avJf3CZaKxosCZrgGxC
	 cLhftuOU8B/yG+kcUvQumZRES0oi2bBcLVtTWFBa9CiUylx/yOADtoMMkjAIQ1mtsa
	 3DyPHA0CSt+vhQFmByGQfv2dDWjGs6Vb4txN5/zSIribxIXN/ahFl3nFQLh8sNGkrj
	 NAdOeyyvq7Fnw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 07:40:04 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 07:40:04 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DB96B3183E38; Mon, 20 Jan 2025 07:40:03 +0100 (CET)
Date: Mon, 20 Jan 2025 07:40:03 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH ipsec] xfrm: Fix the usage of skb->sk
Message-ID: <Z43vw6eVSiHP2EZ3@gauss3.secunet.de>
References: <Z4jq71F78d0gKo7/@gauss3.secunet.de>
 <CANn89iKg4255p92EVVm2JYinok=AVL8tPEn50yRGpnevrvnTDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKg4255p92EVVm2JYinok=AVL8tPEn50yRGpnevrvnTDg@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, Jan 18, 2025 at 09:47:48AM +0100, Eric Dumazet wrote:
> On Thu, Jan 16, 2025 at 12:18 PM Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
> >
> > xfrm assumed to always have a full socket at skb->sk.
> > This is not always true, so fix it by converting to a
> > full socket before it is used.
> >
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> SGTM, thanks Steffen !
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Now applied to the ipsec tree, thanks a lot!

