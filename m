Return-Path: <netdev+bounces-108485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD2923F66
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55ED9B27256
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F561B47DC;
	Tue,  2 Jul 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBSXk1/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272E15B109
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927891; cv=none; b=WjwIeOzHWmCXnR2elzzzSK/4OBsBfYAg/+WEWl788ZJ7WKfw3is7s6KCT9+Ot7J0lr4hjiClkQKSKiYMz0BXTI+vTVDVKdqxq4VdGubJLhFpoLEnJhCJvRpvS0z5DusT0AbHvbxSnSM0ConF6tMbgIvtAHESpe16G+MvAfJ7ifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927891; c=relaxed/simple;
	bh=EjTsnUuUNXOGLv7cS8X1o+buuon7Au96rx10W4FlDsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmqkRXbdpyNwIvhkCLkGn6xFI09g5+7e6mxnmvX4aCzSqcG7sgGhATD0g3LdVyKS5MC9683EQ5gatRHOIcQwe1LHogB86qP/yOJhU7EpzyqASiGtrRHx2lH/08YVGMK15rK2ltSoHFcSFwoZ8TbXe6EBGFOAGgIAU/TDAE6/Wco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBSXk1/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3698EC116B1;
	Tue,  2 Jul 2024 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927891;
	bh=EjTsnUuUNXOGLv7cS8X1o+buuon7Au96rx10W4FlDsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBSXk1/5Q0dC5iIbjPY4xvPHaczEZ7RAtlzHSlh/bxx9EWLlZNm8AbxyPfs/IU1UY
	 9f2O4EC8flYlZEEjMaqCGp/wJWs3dq1cdaYROeKecVu0z/ShhPXhG674KrRQ//QKTF
	 YdgMWNq+ENdO56a9PhuQ3YyyylBLdN/ReocvZ4B2TsWLR7Hlg1Wbaja1QTFIUkKm0i
	 QiyHYcxjh+7EN/SjvzCAFo883yIL8Q/rfWCRepFxAY3XHKJs+4fJyVTjYeOcLDJAIB
	 8ezO/0lFhgAgFxBtFJZsju68jRwRWfB8yVRCDGvSaafi1ovqvDNIclakIRPQdQ4LO0
	 mKhqJRPgDoHSQ==
Date: Tue, 2 Jul 2024 14:44:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <20240702134447.GA616664@kernel.org>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
 <20240701143247.07bc17c9@kernel.org>
 <1623861.1719875266@famine>
 <20240701195908.06f8edc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195908.06f8edc3@kernel.org>

On Mon, Jul 01, 2024 at 07:59:08PM -0700, Jakub Kicinski wrote:
> On Mon, 01 Jul 2024 16:07:46 -0700 Jay Vosburgh wrote:
> > >	if (strlen(newval->string) < 1 ||  
> > 
> > 	I find the second option clearer, FWIW.  This isn't in a hot
> > path, and including strlen() in there makes it more obvious to my
> > reading what the intent is.  The size_t return from strlen() is
> > unsigned, so we really want to test the return value for zero-ness.
> 
> True, I picked < 1 because the line below offsets by 1.
> Either way is fine, but lets make sure we drop the parenthesis.

Thanks, I will go with < 1.

