Return-Path: <netdev+bounces-190637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EDAB7F8D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014613B32AA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD641ADFFE;
	Thu, 15 May 2025 08:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B638DD8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296091; cv=none; b=WCxmHEN9SMI+oC9eltsWQqKPplmfYV8zCezc66W2gAj59jr/pr7ALqbeGRvLb7cJLwWOMmjAKt4iqKgbjjL6hJ+MpEVRYHZXUXwPWjw8ZAiQBnctYXuOt9xB74/myC7B2OQwhRO7J3nIuS+lhOkbDpkuYRjOsVddPvqpDIiiDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296091; c=relaxed/simple;
	bh=Glxi0h1nfMcnnRx3zvoh2aMVxWibqcmtRTyPLQT/wvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEhkf71KUm5bdNqLv1oPFQlYSlT5IeI6wq1E5L5/U08heZKutGbIK5aymJV7w3isaAXX1FdCe20rme2sepRSjA8DBkWfUUPuTBE5rH8CLScU3CJUKf/MYXZfQVXYN+u3ijJy1QTe3a1YlEiSFLma0e0EXuJDYvG71cHaITD1h6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6B432208A6;
	Thu, 15 May 2025 09:53:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wd1uPkR_dprU; Thu, 15 May 2025 09:53:50 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DB4C4207D8;
	Thu, 15 May 2025 09:53:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DB4C4207D8
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 15 May
 2025 09:53:49 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 09:53:48 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4CAF63182C0E; Thu, 15 May 2025 09:53:48 +0200 (CEST)
Date: Thu, 15 May 2025 09:53:48 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
CC: <netdev@vger.kernel.org>, <fw@strlen.de>, <pabeni@redhat.com>,
	<kuba@kernel.org>, Louis DeLosSantos <louis.delos.devel@gmail.com>
Subject: Re: [PATCH net] xfrm: Sanitize marks before insert
Message-ID: <aCWdjLjehouyturu@gauss3.secunet.de>
References: <aBtErrG9y1Fb-_wq@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBtErrG9y1Fb-_wq@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, May 07, 2025 at 01:31:58PM +0200, Paul Chaignon wrote:
> Prior to this patch, the mark is sanitized (applying the state's mask to
> the state's value) only on inserts when checking if a conflicting XFRM
> state or policy exists.
> 
> We discovered in Cilium that this same sanitization does not occur
> in the hot-path __xfrm_state_lookup. In the hot-path, the sk_buff's mark
> is simply compared to the state's value:
> 
>     if ((mark & x->mark.m) != x->mark.v)
>         continue;
> 
> Therefore, users can define unsanitized marks (ex. 0xf42/0xf00) which will
> never match any packet.
> 
> This commit updates __xfrm_state_insert and xfrm_policy_insert to store
> the sanitized marks, thus removing this footgun.
> 
> This has the side effect of changing the ip output, as the
> returned mark will have the mask applied to it when printed.
> 
> Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
> Co-developed-by: Louis DeLosSantos <louis.delos.devel@gmail.com>

Applied, thanks a lot!

