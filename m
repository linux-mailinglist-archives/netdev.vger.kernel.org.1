Return-Path: <netdev+bounces-70468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE184F236
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015DC1F239C2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE5266B4D;
	Fri,  9 Feb 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNwavRx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF7664D6
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470598; cv=none; b=Vv3LGfQg+mGrsfPgQ1berSvwWJi9I0H+pi2D2P/jK+pOQl5jhjPWKgLigPnqVoVZVa9sQghc+hk8dTd2rbfsRQ1evNRILjJO6ihCXX2YlaTgJQdY1BDTyJLdZQrFr/knQpdpFZrVf5cknkVyXSEH5K/zHlq9J67zazIKg5GFYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470598; c=relaxed/simple;
	bh=X4qwwYKPTTLDrW3D9SDkkRguDUFaAsuNeavzsI9R7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGwnRHfdaePIjQ4I6nHCtdqD6npvW+nraWG73JEvX3NVzqIqL1Mop4GSykdLP6OBmVE/pSns81avHg1hjLYtSK21US3PIZ8fpDvdyaY3BE29gTkK6Y50GwE8hF102D8rsco3MX8VfpRwuFp7RVoFRStEmbk/F244pB4pCkJW9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNwavRx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A0C433C7;
	Fri,  9 Feb 2024 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470597;
	bh=X4qwwYKPTTLDrW3D9SDkkRguDUFaAsuNeavzsI9R7IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNwavRx/iyKrKfk7mjRJ+nfbQYUqgLf0TA5q+JmUGu4R4m64sSURqPkdFm/P1f1mM
	 4f84wGiAVTwRsq2lHB7NSjkgPHiBXv3DkaiJzLlU6YWfcY9GZ2fW2sBXesFjiQnxLl
	 u9U7TGJ8JIi/1eIIJO65Pv/ZIhHTbttCIEMsy1qganjVgd3q/j0RxcWJJWwFL8jhxI
	 JfBdS6b1sJ/bhJZGWGu5HOTdHMKU/iFalMh1h0FG7iaOSSfEO8cKOym0ZX9pk7n6I4
	 OWuvlshK/N4H0x0ZT8k9qIeScOVx+XtGCHuxmwDCVcKMo3YUTknpbZaepZCjj2dsKu
	 EN24BEDu29K5g==
Date: Fri, 9 Feb 2024 09:23:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/7] net: tls: factor out tls_*crypt_async_wait()
Message-ID: <20240209092313.GN1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-2-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:18PM -0800, Jakub Kicinski wrote:
> Factor out waiting for async encrypt and decrypt to finish.
> There are already multiple copies and a subsequent fix will
> need more. No functional changes.
> 
> Note that crypto_wait_req() returns wait->err
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


