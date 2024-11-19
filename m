Return-Path: <netdev+bounces-146027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643959D1C29
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B94B280E2D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B24946F;
	Tue, 19 Nov 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piJSSwXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84F139B;
	Tue, 19 Nov 2024 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975377; cv=none; b=OjXGjow3sLPjCNflQOOokTH53RikF8SkqoR7+TFJxlrzJMM7LBFZH9fBAX7RB/1N33Y9ZTeOX1V5RtNmfGFBLlB9psf0KUUsGH+l3VOEiwPDH+iAhU7VNNhodCFYZ/UajY7rj6nqb0owkVGYj829MW5hjMwt2KVENxm7HoORSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975377; c=relaxed/simple;
	bh=GpbCz0pM76XAP0NgB3a7AtBnjYiKPsaLoNI2+DeXrjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyidnscKtdXRA/9d6i2gt4UnekUJENaoODAb5sPV++Wm1qPuzEHNpBzVvsGY4hRKmoizjbyKXAbI0lUESwmEAeDsIneN/2MgAyTL4pS8qjYZTnmhfy6y+9L6GOs5ownJXopnvN37ZtmbFJrwYUfd5d1Azh1d20f2PHaJ67d/z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piJSSwXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06775C4CECC;
	Tue, 19 Nov 2024 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731975376;
	bh=GpbCz0pM76XAP0NgB3a7AtBnjYiKPsaLoNI2+DeXrjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piJSSwXXgGzU8amrPFgXkOYdVxTC4szUmSQY9Uut/NH33BiCqiQX+TY+Pn9wpfdkk
	 ZrRU6anAY4f4+8iaejeyly9k3wh4nSE7nqqtFEyjxm5qE9Z2Mg7CFKpPhbt2a0KtYR
	 K3oAaiELHUhS/1kTTcOwkBPUtfbhkMGDWzMAkr6Kl31gT0cV008FffGF3Rm5yfZTWV
	 /7fah4Sc9BNykEfAg8e1Hn9xEufjR84TgbFKO8IvSo+WMWlnYQOXQes5U3BoBGxRG5
	 h1jNKaGtb4yQaLonrVRNB8sFrUiM0oIZdmTP/0J1omQvN/tivUEt8OFwLa/lD3ScGg
	 RzLKceu+ZBN9w==
Date: Mon, 18 Nov 2024 16:16:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andy King
 <acking@vmware.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Raphael Isemann <teemperor@gmail.com>
Subject: Re: [PATCH 0/2] vmxnet3: Fix inconsistent DMA accesses
Message-ID: <20241118161615.2d0f101b@kernel.org>
In-Reply-To: <CAOZ5it3cgGB6D8jsFp2oRCY5DpO5hoomsi-OvP+55R2cfwkGgA@mail.gmail.com>
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
	<20241114193855.058f337f@kernel.org>
	<CAOZ5it3cgGB6D8jsFp2oRCY5DpO5hoomsi-OvP+55R2cfwkGgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 08:31:35 -0700 Brian Johannesmeyer wrote:
> > But committing patch 1 just
> > to completely revert it in patch 2 seems a little odd.  
> 
> Indeed, this was a poor choice on my part. I suppose the correct way
> to do this would be to submit them separately (as opposed to as a
> series)? I.e.: (i) one patch to start adding the synchronization
> operations (in case `adapter` should indeed be in a DMA region), and
> (ii) a second patch to remove `adapter` from a DMA region? Based on
> the feedback, I can submit a V2 patch for either (i) or (ii).

What is the purpose of the first patch? Is it sufficient to make 
the device work correctly?

If yes, why do we need patch 2.
If no, why do we have patch 1, instead of a revert / patch 2...

