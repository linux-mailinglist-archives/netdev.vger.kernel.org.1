Return-Path: <netdev+bounces-200751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EDAE6C00
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5553AE674
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFB2E173D;
	Tue, 24 Jun 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiQWlWfw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E422E1731;
	Tue, 24 Jun 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780988; cv=none; b=shBOD3VcYFYfHl2f0eIo1xB5R86oX+SJd++WpELdjUe0oCZA9tE1k+Vm1l16sO44+9kJ1r5SyyS7MvGULsQoKIjEu3cEPhpxln34zEwxuoT5okI2Az2CA3Qnz6ZsBIHGIN2HwRMhkIvqvq+qzrdkdzN8WHyhmA1qUZ6bLFGFgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780988; c=relaxed/simple;
	bh=KV3OmoqbIFpb1DXvXtj2VuD9NpNW4mY2HLxDfq8IF0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfBUZ3vzDV2TzkMHzsb9iQlgrqzk0JObFFR2UAIAYNqf+hYLlgV36MfaOGq8fTnqxKnEh/56LkGumFj5WOpE4cDJ6xGuP0NZrJfNJgGhcdewOTBtdF1et2QKowvR4fFZXT4EIrXoQfVP0QXkIgHI40NQvCT7u+4Lk8tj2BconSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiQWlWfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8F9C4CEF0;
	Tue, 24 Jun 2025 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750780988;
	bh=KV3OmoqbIFpb1DXvXtj2VuD9NpNW4mY2HLxDfq8IF0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiQWlWfwV8V7sLkemZoKsu0cwJ6bIcmlCznpocInMarpQoeifFuQdfbcn91HnDsGh
	 cZu+i1Yhb7yVxf6XAgl5tSjvEgnqPwBim6IGIPIDrA6CsgyiEF9Lv02DIHjjCWvJjE
	 LNAG06rYU+c+zuSn/8UKg7agdqm+m2qiB/V01M2TlJef/hfpM6pN2zlk552rkCvb6p
	 IUrrgt+0aD5mf3mvvQcSwxAFL7yN8O1dJWQnzB1c3+/+rPQnIdIIEd6Q/vuuNesVbe
	 raLU0NYRgFcKXmyQStCc8p6skBx/Stk/umfLfFsqGE29qsHAvrNZl1yBV595XVUENo
	 kuMdf+BaUuBjA==
Date: Tue, 24 Jun 2025 17:03:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250624160304.GB5265@horms.kernel.org>
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <20250624095313.GB8266@horms.kernel.org>
 <cca5cdd3-79b3-483d-9967-8a134dd23219@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca5cdd3-79b3-483d-9967-8a134dd23219@jacekk.info>

On Tue, Jun 24, 2025 at 02:51:09PM +0200, Jacek Kowalski wrote:
> > > +	if (hw->mac.type == e1000_pch_tgp && checksum == (u16)NVM_SUM_FACTORY_DEFAULT) {
> > 
> > I see that a similar cast is applied to NVM_SUM. But why?
> > If it's not necessary then I would advocate dropping it.
> 
> It's like that since the beginning of git history, tracing back to e1000:
> 
> $ git show 1da177e4c3f4:drivers/net/e1000/e1000_hw.c | grep -A 1 EEPROM_SUM
>     if(checksum == (uint16_t) EEPROM_SUM)
>         return E1000_SUCCESS;
> (...)
> 
> 
> I'd really prefer to keep it as-is here for a moment, since similar
> constructs are not only here, and then clean them up separately.
> 
> Examples instances from drivers/net/ethernet/intel:
> 
> e1000/e1000_ethtool.c:  if ((checksum != (u16)EEPROM_SUM) && !(*data))
> e1000/e1000_hw.c:       if (checksum == (u16)EEPROM_SUM)
> e1000e/ethtool.c:       if ((checksum != (u16)NVM_SUM) && !(*data))
> igb/e1000_82575.c:      if (checksum != (u16) NVM_SUM) {
> igb/e1000_nvm.c:        if (checksum != (u16) NVM_SUM) {
> igc/igc_nvm.c:  if (checksum != (u16)NVM_SUM) {

Ok. But can we look into cleaning this up as a follow-up?

Reviewed-by: Simon Horman <horms@kernel.org>

