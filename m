Return-Path: <netdev+bounces-187672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41AAA8D0F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713543AC195
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00DE19995E;
	Mon,  5 May 2025 07:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144C33997
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430292; cv=none; b=PVOxLfunBsyY29tq2YwuIlA8O/rjLDF8gzcIuC3S9QI9FXensD7n1wtyuMvd/vMwBuXwhVjfn1bMhYIc9IBx4lUX0zQSWMGcj0EzLevQj0rqMikzr6AVy4HZJ4CRfTzlkiIi1IrtCuhjHAU5Jwimf7Yq+4Zngc08KOBXfO8qcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430292; c=relaxed/simple;
	bh=JB5Kzb9s3JyBfMSbdxTHXCGx0upnjd2EUXTgAIbmWE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq2THXpfzpJSnRpDJP8vvMVMbLbC2lqWaGyFFmVsRGdDBXA2FjG69c6Ql98iyL3M3mrFqt/MzptBg5AsPK00udwGetQAQwySK/ZWdtzaHP2zXiK7PGLlzBpRZD8r9bAvR9TPT3FPqj5AawwVTlqHW5IH0wB9V4/vhZKx9Wiks3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9002A207BB;
	Mon,  5 May 2025 09:21:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7I8KFteWSpe; Mon,  5 May 2025 09:21:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 00B3F20799;
	Mon,  5 May 2025 09:21:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 00B3F20799
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 5 May
 2025 09:21:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 09:21:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B6D833182C1F; Mon,  5 May 2025 09:21:31 +0200 (CEST)
Date: Mon, 5 May 2025 09:21:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec] xfrm: ipcomp: fix truesize computation on receive
Message-ID: <aBhm++T65k7Tqaff@gauss3.secunet.de>
References: <f507d25958589ed4e6f62cdc4b8df64865865818.1745591479.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f507d25958589ed4e6f62cdc4b8df64865865818.1745591479.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Fri, Apr 25, 2025 at 04:32:55PM +0200, Sabrina Dubroca wrote:
> ipcomp_post_acomp currently drops all frags (via pskb_trim_unique(skb,
> 0)), and then subtracts the old skb->data_len from truesize. This
> adjustment has already be done during trimming (in skb_condense), so
> we don't need to do it again.
> 
> This shows up for example when running fragmented traffic over ipcomp,
> we end up hitting the WARN_ON_ONCE in skb_try_coalesce.
> 
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Patch applied, thanks Sabrina!

