Return-Path: <netdev+bounces-56502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B580F248
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3519E281A8D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EDB77F0F;
	Tue, 12 Dec 2023 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ+9I3Qk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1507765B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5841CC433C9;
	Tue, 12 Dec 2023 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702397985;
	bh=Nw8Mee/1cmXk5j/15L8kOpMSnadycdcKoM/VeC8SwLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJ+9I3QkLAQteOy2cQkEdCbgisBZEt9BqF2d7vfUoo8NP/yDUuHimrnMwY652MBSk
	 Ynk3BDJKZ+kq12GpD4UG1vVagnA1O43CBdsZ/gA2R/GFS7tysB94t0Dyb0JrZBiy8+
	 5zo6/5njSrcekrM7F50hsibbgXCXvWO0BIpHKFPbI/oXmkhAOgDthUohsOmTTvArLW
	 tH1edYCaQjCD1TvbWeV31hXq0aLDlAf+F+jqCzpvXjrjW8znsYB67EVnkjypkghV2w
	 +mZC4LjjyaOUoAfzd9JD/3e1gZ3ENduPxwCm4bL+zeOASs9jYGbHMU7HE/xCWDX+pW
	 Z4PpYBn37VPYg==
Date: Tue, 12 Dec 2023 08:19:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Simon Horman <horms@kernel.org>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
Message-ID: <20231212081944.2480f57b@kernel.org>
In-Reply-To: <b9456284-432d-2254-0af2-1dedeca0183d@gmail.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
	<0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
	<20231211191734.GQ5817@kernel.org>
	<38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
	<b9456284-432d-2254-0af2-1dedeca0183d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 15:14:17 +0000 Edward Cree wrote:
> On 12/12/2023 13:58, Edward Cree wrote:
> > On 11/12/2023 19:17, Simon Horman wrote:  
> >> On Mon, Dec 11, 2023 at 05:18:32PM +0000, edward.cree@amd.com wrote:  
>  [...]  
> >>
> >> Hi Edward,
> >>
> >> I think that probably the above should be static inline.  
> > 
> > Yep, in fact there are instances of this from patch 2 onwards (most
> >  of those aren't even static).  Clearly I hadn't had enough sleep
> >  the day I wrote this :/  
> Or maybe it's *today* I haven't had enough sleep...
> Unlike the functions in patches 2-4, which are stubs for the
>  CONFIG_DEBUG_FS=n build, these functions should *not* be "static
>  inline", because they are intended to be referenced from ops
>  structs or passed as callbacks.
> The check on patchwork is actually a false positive here, because
>  this is not a function that's defined in the header file.  It's
>  part of the body of a *macro*, EFX_DEBUGFS_RAW_PARAMETER.
> Functions are only defined when some C file expands the macro.
> 
> I will update the commit message to call out and explain this; I
>  believe the code is actually fine.

Fair point, second time in a ~month we see this sort of false positive.
I'll throw [^\\]$ at the end of the regex to try to avoid matching stuff
that's most likely a macro.

This one looks legit tho:

+void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec) {}

