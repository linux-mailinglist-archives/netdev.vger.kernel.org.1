Return-Path: <netdev+bounces-84893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20411898929
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD681C275CF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953C12838B;
	Thu,  4 Apr 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="B23BDeQV"
X-Original-To: netdev@vger.kernel.org
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC9127B53
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.87.249.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238535; cv=none; b=bGAFjbFy7PEn9akpht8DeURxCjSqw+BtHwPMFxLQ094jyfc6w9RV35QdS6LUQ/E24n537KAfQi/oPVDG1BLUl0RDzKjJfURLahU/74hcaVOmMJIzUre6BVex4AMAXVnCYdLUgYA7MBiHgNJEondz2OM9nyrJkREakKDvc/zyq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238535; c=relaxed/simple;
	bh=mIFldIxsyswVURtM9BrGTcEwvxTPcZlj2ZOPgHs4MzE=;
	h=From:To:cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=fw21U/QTSPWZ6f8yQqhTsI3ixsV1TDcrQmajwrdeDYcW+g2uQYc5VcKFYpDmCdmmCsLrFbWhitr/8vegE3AvBtUSeMan/Q5a7yo9TbKbwBXckQkStkV9PbQKLsUUSChs1U/Bj2/RjqhR8IXEXAsrr3X6N/rFRsTrkKRcoWKwLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca; spf=pass smtp.mailfrom=sandelman.ca; dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b=B23BDeQV; arc=none smtp.client-ip=209.87.249.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 18D773898D;
	Thu,  4 Apr 2024 09:48:51 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2P3nYOsZ9C0L; Thu,  4 Apr 2024 09:48:50 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
	by tuna.sandelman.ca (Postfix) with ESMTP id 1643F3898C;
	Thu,  4 Apr 2024 09:48:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1712238530;
	bh=ilhp6ksPfdCG2aDvEEDmbbmayi3/AggJU3SReavMMeU=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=B23BDeQVAkb7Rfp1RlI9NIC2IT9SlG22gb3xZobxCuiPwQdTKDTEh6bmbBPISiEFd
	 yoZ7d7hb91m7+6jGuyAc2BW6b/stg7Z7eXDZRufQAIQiepnOvujLy6kGAuS8mBujf+
	 HX28KIIhvUwe04/YFFauQFCV0jcam0PbwKwrYHo1g2wSjrCxQcziP7j3iFg7bVF+TC
	 egzZd0iFhKtk7rdgMf6wceG3I2cC4P3mDEX68efyhnkhFBWGs6rzrpOdlJjwPuf7mA
	 ilqfWbLlOyfSawAOgCH6KLyMoWjK3OHCTf67Bv9a+4UfK/7Xe1CArlpfklCFHCNqWy
	 WOZMRi5cZb0NQ==
Received: from obiwan.sandelman.ca (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 0BD90111;
	Thu,  4 Apr 2024 09:48:50 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: antony.antony@secunet.com
cc: Steffen Klassert <steffen.klassert@secunet.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
    David Ahern <dsahern@kernel.org>, devel@linux-ipsec.org,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    "David S. Miller" <davem@davemloft.net>,
    Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2] udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support
In-Reply-To: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
References: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; GNU Emacs 28.2
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27921.1712238530.1@obiwan.sandelman.ca>
Date: Thu, 04 Apr 2024 09:48:50 -0400
Message-ID: <27922.1712238530@obiwan.sandelman.ca>

Antony Antony via Devel <devel@linux-ipsec.org> wrote:
    > With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
    > simplifying the codebase and eliminating unnecessary complexity.

Good.


