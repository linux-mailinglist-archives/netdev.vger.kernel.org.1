Return-Path: <netdev+bounces-82013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B488C160
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3CA1C3E6DF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD786E616;
	Tue, 26 Mar 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHA9ZYUr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3659150
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454392; cv=none; b=ILotfSe1755DLP0irU87s8xubG3RwyYDxNCTewpEfvqa4YgBDrYojrL51vvRwa6VK9BZD87iRduLvvEPHBtpxDanmc9llsDOUG10gfssvKJOiTfzEko3wcHdOwJ3MaPUnWqWGDTaaYlLSecvo0/4oL3mbdn/+eOtgcQX3DMTM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454392; c=relaxed/simple;
	bh=/OboRI6wQUa5mCA+RlrkHJhr1pO31/2RzaZacp30huk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owbx0o5o8db7StPnMjPlGWpU5OMocNU/Rui6T9e9FZBhiHxiJ3z6dTdmDuCs73eCAMti2QZj0nO/xuFe7DT7a+uaVqdnL5txX2NzlypF5QjAwVywKav0Vg4wgwb4RCgCK8c1QHtq5j82iStfUkyLZj5SVQCHk6UXzjMwRztVobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHA9ZYUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BEAC433C7;
	Tue, 26 Mar 2024 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454392;
	bh=/OboRI6wQUa5mCA+RlrkHJhr1pO31/2RzaZacp30huk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHA9ZYUrTZOKxmt9YexgQdSjiqEuZxccqUiJTdpSfiyU/LOCChn8ZrvdS4u9/uH9d
	 ljwt40dW4wXbErVQkIzX+TXqlBt2bd16dckuv2aa6fLVPXnDPyMJoM7FZdcmbGSDEI
	 PXO5MteYOLNYBrcDidBNjmqFPtj5Lrr6CgSASmoYjSL7aaFZLkfDCTFKEbOEfbagDN
	 Wao7R6q+uNpGEYv3z5QDmSWPuosUrSU9o0EeYsPhvSAlCIztL3b95nMh1EeI1D9ofH
	 5cXwLJYSUjJXXLngzeDqf/3sfFBazsBeZduD3P1kgn+l6JSHvrnhelzF095IS4EsXx
	 zlddtnhGRNrWA==
Date: Tue, 26 Mar 2024 11:59:48 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 4/4] tls: get psock ref after taking rxlock to avoid
 leak
Message-ID: <20240326115948.GS403975@kernel.org>
References: <cover.1711120964.git.sd@queasysnail.net>
 <fe2ade22d030051ce4c3638704ed58b67d0df643.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2ade22d030051ce4c3638704ed58b67d0df643.1711120964.git.sd@queasysnail.net>

On Mon, Mar 25, 2024 at 04:56:48PM +0100, Sabrina Dubroca wrote:
> At the start of tls_sw_recvmsg, we take a reference on the psock, and
> then call tls_rx_reader_lock. If that fails, we return directly
> without releasing the reference.
> 
> Instead of adding a new label, just take the reference after locking
> has succeeded, since we don't need it before.
> 
> Fixes: 4cbc325ed6b4 ("tls: rx: allow only one reader at a time")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


