Return-Path: <netdev+bounces-202886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FFAEF8A3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F755167650
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A985C5E;
	Tue,  1 Jul 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1u43gwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880497260D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373216; cv=none; b=sHY/3z42OvcALQSIvbvehPMMrX3siz/ytM29xqvXzJSR4uV4rmKaVcLIhGNV0I0TQQ00vOAv2nRhXCMFkC5gT2CH95P0lhsY4XOYp4WnSfcsoe2I6aXO4TI9OGrLYQNRavkhgVPW28eYqibvI0/02j9ZLljPbVBG9HhTbiCA1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373216; c=relaxed/simple;
	bh=an6El7LQThWyxle2ua9iz3GhLonkcJ8T/Jl+bJxDVag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw80DbWqMZroWfTYs8n8acxYyYktOSKUKGX3oRdm/ME4zBGp/hfXzUOn8KgxYJR/8Plu/wJsaukVKEchMHyjVEREFI7egM/Qod+DpJByyEfUaCY/bOTCfMebB6S5wbKAbOmf1Nw/LqWZmgdlP/irRDGDrXS6wxten+x9teEqSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1u43gwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D2CC4CEEB;
	Tue,  1 Jul 2025 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373215;
	bh=an6El7LQThWyxle2ua9iz3GhLonkcJ8T/Jl+bJxDVag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1u43gwPRMoQ/rTZvdkqeBcUBEYwT1QZ4BkzVjCYor+tAmTzI775BRdA6jANrTy9v
	 065owKpzED1m1iv0KgNaH4NxJqbj5BBr+Nv8plmoYJpSuUqZh4LDUoDxnZdffNAkSA
	 sBc5PMqxGMrpj3T8mfwxHvEShk3lS31H9N2+Z8vmcITFSeQ8V+YY/rdwcq0RLbkVbH
	 HrnTKad+h4rV2x8buOteKFhBMgSpF4l2L/mKADQucRLTJKUVtKlJitj4fEiTvybHQs
	 zptQY7XHRTVNsxPoOSyVMxVEFx+AVDho6C/ZvrNRttH5TvK7IMx8pZIV9R8ez+gh6F
	 rIQXh18tODtjQ==
Date: Tue, 1 Jul 2025 13:33:28 +0100
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	tariqt@nvidia.com, gus@collabora.com, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH v29 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <20250701123328.GO41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-2-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630140737.28662-2-aaptel@nvidia.com>

On Mon, Jun 30, 2025 at 02:07:18PM +0000, Aurelien Aptel wrote:

...

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0f2443d4ec58..c1b3d6e1e5e5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -507,7 +507,8 @@ struct sock {
>  	u8			sk_gso_disabled : 1,
>  				sk_kern_sock : 1,
>  				sk_no_check_tx : 1,
> -				sk_no_check_rx : 1;
> +				sk_no_check_rx : 1,
> +				sk_no_condense : 1;

nit: sk_no_condense should be added to the kernel doc for struct sock

     Flagged by ./scripts/kernel-doc -none

>  	u8			sk_shutdown;
>  	u16			sk_type;
>  	u16			sk_protocol;

