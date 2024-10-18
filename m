Return-Path: <netdev+bounces-137115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F19A468A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E9B1C2298C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEE205144;
	Fri, 18 Oct 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFQ3PMUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DC2205128;
	Fri, 18 Oct 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278589; cv=none; b=dsaKhM4pOqUx2FOVgRSgFHEnLRUS6nKfu/e5LgolSnSG6OCOZRG974uWHwpjg96d2mgPuSnLWNZe/Q/JxGUQPBYwDS2Yi/WYgVMx6FRyo5JAqYPUc+k2U8GX9YK5erNqoD+OcfNovUUEY9D5FnfNHt67b4Y7yiT5qZS75728iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278589; c=relaxed/simple;
	bh=SqP/qvsNiZEPm1mzggDv5we6X0qVhUOHTjC0UHyjJUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMjrkwZ/CRY7V35xVqsA7zT5vgWNwUFb9qD4M+xZVLbgHjm0dnLp9lfzqu1VU6qmeUic4uQHTjxJ5y3x7EQQdI3/C0xKKfKKs9oZqZ4aJtwbArz3AcmzbWRICQqCowd5VTra+ysAvGXxpM1AN0ffy1cnIAWIWX0AWhTOSa9Bf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFQ3PMUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B1BC4CEC3;
	Fri, 18 Oct 2024 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278589;
	bh=SqP/qvsNiZEPm1mzggDv5we6X0qVhUOHTjC0UHyjJUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFQ3PMUp45GUtDOqeWd3d+DMuMB+6wCSKfn6htijMC8NZivQv7fixPWoXckuVutJg
	 oyXDkxdVT2esqQXX4HbSJrLqh45nWJFSrwVcZS0CbSh0E8HDuNhhZE9yOGf/UesEMQ
	 AXL75l4A4cmv6bG/2hBfKrYDk8ZlIy9OVIaPhZ/Ejwkm9TcZpDUUzN7SD6UwYS22eQ
	 VPBRX7SazPu29kkVUDCghaWdSzc93q/Uh6XrJPkI04vRSxJSjq1YZK/2EpIJWu1MD4
	 DU9XkUHqWhwucmGL2fX9+x+a0rCelktopQqjTsFpTxwoM/IAxEWCKhgScjxyOa97lR
	 PJFg+A1mNhYMA==
Date: Fri, 18 Oct 2024 20:09:44 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in
 cn10k.c
Message-ID: <20241018190944.GV1697@kernel.org>
References: <20241017185116.32491-1-kdipendra88@gmail.com>
 <20241017191037.32901-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017191037.32901-1-kdipendra88@gmail.com>

On Thu, Oct 17, 2024 at 07:10:36PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


