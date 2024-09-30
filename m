Return-Path: <netdev+bounces-130465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D702598A9B8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62048B27992
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516F1925B7;
	Mon, 30 Sep 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugl1J3YG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56818EFFA;
	Mon, 30 Sep 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713587; cv=none; b=r4PyrF5eIXAumRfpNl4YJ6YuPp1XgG9vY+h6RqWGUT2Z64BTkbldQWL5wtjVC6JeSFC2MHYb55IpU/WZ00EXPGYNep8qJl8HEluHy11Wr0i04YnxP4uFAi/EccD4A7oPpAAuxT2SLtp3OJsYPjFQt6POK1MaSvEmvJhaF6wg7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713587; c=relaxed/simple;
	bh=TIWfDecnPPFhRuOyhI8T7G5gSY8edfMZadan2Y+C70I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdC0MOtjL6d0TTDgqOUkc8sYTRZOyhR+8QpWvkW7trv94JCF8qh+GgKyN5hEMag+PvtRWPpR2px7mqyrZ7jkh0BcGVv9Xohh/PVM0XmAGzcHDOIt4lPbWGRuA+S1UKAnw/rl54pnclLtxv3EC1rSaxNHmLugczEEQHXr4eXlpi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugl1J3YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B175FC4CEC7;
	Mon, 30 Sep 2024 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727713586;
	bh=TIWfDecnPPFhRuOyhI8T7G5gSY8edfMZadan2Y+C70I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ugl1J3YGXIJ3WdXxUrWF4WaafTI/mkKozHha1BA9Ql7LDwpQbOe+dmS640uAMj1FT
	 XY/ZMGkKBWl9OBG3mIbrZaOWZJf/a42U8wMG7PpudaYcHMrEKtW4agjtGSwlZ2zRhU
	 UnBvzp10RMI/tbos8ahqVicIoYFd4G9sBXn7/1849+Y1MoMX5IsVaWEIGpR7WeQKTO
	 JmuVah8lvKVktsRgeylyOvr4VxAX6ZduZt2MmQSjANevkVR1a9Yk09kt6QpEgzvKib
	 6k8xY/ElE4w3o2ss+yR/V2Sr51F0KnVuZr88tx6F+WYAV8ldZbHJuJhDX4LKMLTmGc
	 8zrgaSUQlflWA==
Date: Mon, 30 Sep 2024 17:26:22 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net v3] octeon_ep: Add SKB allocation failures handling
 in __octep_oq_process_rx()
Message-ID: <20240930162622.GF1310185@kernel.org>
References: <20240930053328.9618-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930053328.9618-1-amishin@t-argos.ru>

On Mon, Sep 30, 2024 at 08:33:28AM +0300, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> A similar situation is present in the __octep_vf_oq_process_rx() of the
> Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().

One step at a time :)

> Compile tested only.
> 
> v3:
>   - Implement helper which frees current packet resources and increase
>     index and descriptor as suggested by Simon
>     (https://lore.kernel.org/all/20240919134812.GB1571683@kernel.org/)
>   - Optimize helper as suggested by Paolo
>     (https://lore.kernel.org/all/b9ae8575-f903-425f-aa42-0c2a7605aa94@redhat.com/)	

Thanks for the revision.
This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> v2: https://lore.kernel.org/all/20240916060212.12393-1-amishin@t-argos.ru/
>   - Implement helper instead of adding multiple checks for '!skb' and
>     remove 'rx_bytes' increasing in case of packet dropping as suggested
>     by Paolo
>     (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
> v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/
> 
>  .../net/ethernet/marvell/octeon_ep/octep_rx.c | 82 +++++++++++++------
>  1 file changed, 59 insertions(+), 23 deletions(-)

...

