Return-Path: <netdev+bounces-120516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CF959B01
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE001C22979
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008A1D1312;
	Wed, 21 Aug 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ia1rwMwO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644B134AC
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241163; cv=none; b=JV8KdoCytEBT+dlN2zbMCx+bR3yVnfH89lMgO0V4ECZJlgEjbZhlxzqW0ijfB6k1AzvpXmtApCjtmY8aVO8ADhA2HmwCxG2d505BN+MnmqMszsD4U/dwGu0uvF3UGBYgdXoyTk7KOXJalLAn1OemprV2ocCoZXcMqnBGdVd8Bzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241163; c=relaxed/simple;
	bh=pQnQrdy5EdtwqN2xEhrdTh+SfDe4Y5cSsMar+RnhBU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpmnVmfCqtc8vvObKWkf2oZIwnG6qVChzpR0nIlySXRAsk8K8VW1ejFAko1kXtUEfsGR1IsYQka4eNqwU5KQOVM2CpK0O2GY8K3U7on0zvE0mu2u7VLJWMnXYzxucvFDErKvMwKhx9kBKLqQPGPa/cuDARdAxFN88maNJ5bSA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ia1rwMwO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E2CF6208A2;
	Wed, 21 Aug 2024 13:52:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxiRIIcnVP1Z; Wed, 21 Aug 2024 13:52:31 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 051AD207F4;
	Wed, 21 Aug 2024 13:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 051AD207F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724241151;
	bh=ICgCuM7WnGOr46hqWyCWQr02wQLo1aHJ4g0nhlbGEgw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ia1rwMwO1fZUKa+/FMiI6+1vwNVbvJJQpYdXKeUWIleBv/ZNOyVvvVdYgCz+h2YDt
	 syVPg0BmyUizTYj4C8e50PNKNdcl8YiGat2bPBo8b4zdDPKzj8BAv8w0IOLycccerp
	 o/xTauYs8O1tkwQ/gL9nf0hpnB4TpixQ5FEcFnqVY4XN0PZF0veR0rFKR/8bPR81xp
	 fkzxj8+7vURW2WQy27FyJEocOqLnsAeSFvleATyY/tDppQM+1WjHhGZ35TjyB75oKk
	 GWqJYVNTfV5rC1kFbcnQUCtJHOrgTaQhyWyf8qOkVNcoj1jTLu4NICHl52EAEm4hJD
	 /AGO1tXU4yNng==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 13:52:30 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 13:52:30 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 348C03183CDE; Wed, 21 Aug 2024 13:52:30 +0200 (CEST)
Date: Wed, 21 Aug 2024 13:52:30 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v4 1/1] net: add copy from skb_seq_state to
 buffer function
Message-ID: <ZsXU/pneNZFC+Goe@gauss3.secunet.de>
References: <20240815172114.696205-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815172114.696205-1-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 15, 2024 at 01:21:14PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add an skb helper function to copy a range of bytes from within
> an existing skb_seq_state.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
> This is used in a followup patchset implementing IP-TFS/AggFrag
> encapsulation (https://www.rfc-editor.org/rfc/rfc9347.txt)
> 
> Patchset History:
> 
>   v1 (8/9/2024)
>     - Created from IP-TFS patchset v9
> 
>   v2 (8/9/2024)
>     - resend with corrected CC list.
> 
>   v3 (8/15/2024)
>     - removed ___copy_skb_header refactoring
> 
>   v4 (8/15/2024)
>     - change returned error from -ENOMEM to -EINVAL
> ---
>  include/linux/skbuff.h |  1 +
>  net/core/skbuff.c      | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

Applied, thanks Chris!

Looking forward to the IP-TFS pachset...

