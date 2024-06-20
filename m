Return-Path: <netdev+bounces-105307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9A9106A2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CDA282AF5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2851AD4A3;
	Thu, 20 Jun 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo6Dlw03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FF1AD48B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891148; cv=none; b=J+lODC+otrzIDLTSNdz8Z5UqAX51SoyOwMHDreJ6IimFfAOdcB+3OMnnxRrxgYiJQeQ1vuuczJA1VFOPEPX0TQpMEb1jFesybTMY+Wj0fWLiFwBRqK7Jrvt/Dt7Wly7xWf9S+SG16IICGrvdl78pzYb3DQXYj+uidSjpGp1Z0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891148; c=relaxed/simple;
	bh=LjnbhWXQYul63vQ+DA6xjJXGdgliS0uVuqTNFFWWNxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEHHbTh8rATfpqWbtllYeJUlqfSoGdD3zm+sBSTMK9NLvkynWWco2McwJURto6sQR3OPLKfQWUwTEzj5HeGWiIxIEa9fRwSEGn9nci3cywwbSW1RIcbEyMDs9WwJuMH0pxcEOMX8oTgY1krGviZeZhxpW1/2SKvkdH05lUVRwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo6Dlw03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBABEC2BD10;
	Thu, 20 Jun 2024 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718891148;
	bh=LjnbhWXQYul63vQ+DA6xjJXGdgliS0uVuqTNFFWWNxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mo6Dlw032lqISVnxlyhmZqrC7NqD+bq/ACOrsTuZRMParpx4183OTaAMsRi0aS/uT
	 60QxwlPBgo0zR6AevOkgzmaPDoFTYfvf8ANE7/zJFM5Z6l3CBRHWeRVete4xMMcWAa
	 +yb6oElw5pVA6TdY7KLZ/Wu7J7thVrX9GEatL1x20tUexQZrJwfP3LqsFnyO+1HSZV
	 WIaKr+fPHrWFkyOIE82I15SFSu2RY68ZCCIMFhLY4gOaw3MGb2dhxG8aPvcpQNLfQj
	 dT7oNEh9b92vXVNub6fO7YvsBhbQASzpM5t7NmK+fhHsh4fSCrm3vjup5CGFUzI8WQ
	 pLaKCIi9E+4yQ==
Date: Thu, 20 Jun 2024 06:45:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 2/3] bnxt_en: Set TSO max segs on devices with
 limits
Message-ID: <20240620064546.16b0019e@kernel.org>
In-Reply-To: <CACKFLin56WqRqSsg=ku4=_8sCbQFYrHLhhc27_quqHhHRTZzuA@mail.gmail.com>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
	<20240618215313.29631-3-michael.chan@broadcom.com>
	<20240619171301.6fefef59@kernel.org>
	<CACKFLin56WqRqSsg=ku4=_8sCbQFYrHLhhc27_quqHhHRTZzuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 23:50:42 -0700 Michael Chan wrote:
> > If we're only going to see 0 or 2047 pulling in the FW interface update
> > and depending on newer FW version isn't a great way to fix this, IMHO.
> 
> This issue only affects the newest chip which just started production
> and the production FW has this updated interface.

Hm, okay, I see this only needs to go back to 6.8.

> > TCP has min MSS of 500+ bytes, so 2k segments gives us 1MB LSO at min
> > legitimate segment size, right? So this is really just a protection
> > against bugs in the TCP stack, letting MSS slide below 100.  
> 
> That's true for Big TCP, but what about UDP GSO?  Can UDP GSO exceed
> 2k segments?

I really don't think 2k segment limit is of any practical concern.

What I have seen for UDP GSO, since its used mostly for QUIC and mostly
on edge / in CDN - the speeds are much lower, so the QUIC stacks only 
use sends of 16k or so.

Anyway, the "this is only needed in 6.8" convinced me, I'll apply.

