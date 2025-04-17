Return-Path: <netdev+bounces-183804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95311A9210D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676163A6E00
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C963253333;
	Thu, 17 Apr 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djt00QHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD72475C7;
	Thu, 17 Apr 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902808; cv=none; b=PWrtbKId3+EKsGOsu9ZjoDCpiHduRWb6KNndkqDZUnYL1JdZRTvQNWHD7/msvbcYtvJVgLcnWWsxcXSoizFPzZxhULjniehgT+krPk2ZASu4K83IttXZDqoCQF9Ivq1L9C3o5gmFo/nTq/Iy1uted3MoG7Fs/ymfAi3WkVsafrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902808; c=relaxed/simple;
	bh=vDbkTIHc0zXTAQW1oy0wD2cr80Dbn7VA7qtXP2ydKjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btkcUBaklimByQ9oUA6r9yLsMQcH1Jk7aMT+Ky9NyDnGbwSxpoHWat+xXJl0iLi0am1wcAcv0CoPv/t7YAAJQ1/9cvgm6IKTnvnng4tUIMmIz46KIdIWQcFv6s3ZU5QsHkNPIUbTWFU5Z63hS17aTrWfTX+4mvAOi9/yqrv3xUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djt00QHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BE8C4CEE4;
	Thu, 17 Apr 2025 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744902807;
	bh=vDbkTIHc0zXTAQW1oy0wD2cr80Dbn7VA7qtXP2ydKjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djt00QHqYgsHYUVrBdoVCvURtrC+CMCxIT/lZiGZsqCUApnoRK35Ks6D2PjVB7YMH
	 bxoP+RxujXuPqfm+YwF4JJAa8E6bN87A10k9iIUnK/s5m6caOsPHBGPMmh9ag08+MD
	 gAC1EbYxT2s3OHFRLVzHmIzbVbJ60IYZL1xaoeLRLHqJtbn04zy4jwvAr4UGB4dgzB
	 zEd70H3SChtnOxGKEyqa+CFkGh4owK4d+PsxwWTok1gDGQW8xxJMZFHomRsW0vxNrU
	 nB7+i2VpZ8i8A4dSwjQaCYERAJKxOaEYJ2QA8desbiVmn2IcqxKlQDC/4nAeQ5f8oS
	 G0DiHBvBDjuRg==
Date: Thu, 17 Apr 2025 08:13:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 5/5] net: ethernet: mtk_eth_soc: convert cap_bit
 in mtk_eth_muxc struct to u64
Message-ID: <20250417081325.0e0345ee@kernel.org>
In-Reply-To: <99177094f957c7ad66116aba0ef877df42590dec.1744764277.git.daniel@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
	<99177094f957c7ad66116aba0ef877df42590dec.1744764277.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 01:52:03 +0100 Daniel Golle wrote:
> The capabilities bitfield was converted to a 64-bit value, but a cap_bit
> in struct mtk_eth_muxc which is used to store a full bitfield (rather
> than the bit number, as the name would suggest) still holds only a
> 32-bit value.
> 
> Change the type of cap_bit to u64 in order to avoid truncating the
> bitfield which results in path selection to not work with capabilities
> above the 32-bit limit.

Could you please be more specific and name a bit or a field that goes
over 32b? Since this is a fix ideally we'd also have impact to the user
described in the commit message. But having enough info for the reviewer
to quickly validate the change is the bare minimum.

