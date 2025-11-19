Return-Path: <netdev+bounces-240190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFBC714BF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41BA4E136D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B18308F39;
	Wed, 19 Nov 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSpLMKwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAE2E6CB2;
	Wed, 19 Nov 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592007; cv=none; b=li8q+F1DZ4XkG3MzWaW8Ymv9N9JH5fYM2bM3YK8FWtDU1YXv81RbMickO8H/52cuEbFbhLqocewRi8u8f0NoswKb1Fxn3zP3olOqqxBPUrKzoMTSTj70utH7pzwd0sOTddAKtFHsdEbGjc/dNFWFqVapheftP1KGxPZzwuh65UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592007; c=relaxed/simple;
	bh=nPEusvPgOAT/NwcTaXoVhxtHcPgLEuoF4hq8tl6Ym2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVZg8vhqumUJrKFkjU/zWq8AnldAZX/2Jcv7fzFsK5hTh00y85JKwnWjZO0Ftrdo8DqPhwyr0EQlK/2xEzt4poRFRTG8Yk0iKkrG0rwqTJ1DPIpgifV1Ez3NRsHTfjVp6HgLYgC4ChbC1SRWkGMeMnv0F0vELtlZcPE2W2JuuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSpLMKwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70DC4CEF5;
	Wed, 19 Nov 2025 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763592005;
	bh=nPEusvPgOAT/NwcTaXoVhxtHcPgLEuoF4hq8tl6Ym2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSpLMKwubKK/uuJ/ah6lCGsEP67W1mVEiB6oLXd1Oy+e3PDU5vcHAjc+umu7Khrjf
	 pi22HF7KH5hmFgdWj1eWwYX+VVN7z4Op6yRM8o7JfBX2PXsCAmnpBNkIsr3EzDuyiL
	 BdTQ64vQkVO0mcAicVT+tIeV8SxqOARHKbuLg50OyASau6FXheVDwcw2hfD6TbjE2u
	 FaGrXzzthTNhQAkPsiw9Auq/eB6M5RO4bEWHronoGZlgaBljgpZzqF/BeJeQpVcTdC
	 NvaTMH+aQVpqfpysQM2od4ehEQ+fiDLXNfVVPVfSsiBnu1uLpPBEt1ycSXSA2ozqNU
	 oDgSAFjYj/c7A==
Date: Wed, 19 Nov 2025 14:40:04 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <202511191439.C737EF792@keescook>
References: <aPdx4iPK4-KIhjFq@kspp>
 <20251023172518.3f370477@kernel.org>
 <949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
 <20251024162354.0a94e4b1@kernel.org>
 <bf9c2ceb-f80f-4fea-999d-4f46b2369721@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9c2ceb-f80f-4fea-999d-4f46b2369721@embeddedor.com>

On Tue, Nov 18, 2025 at 01:36:41PM +0900, Gustavo A. R. Silva wrote:
>  struct ip_options_data {
>  	struct ip_options_rcu	opt;
> -	char			data[40];
>  };

If this just contains struct ip_options_rcu now, can ip_options_data
just be removed entirely?

-Kees

-- 
Kees Cook

