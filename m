Return-Path: <netdev+bounces-109828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F892A0AB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1771C20DFB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1523774;
	Mon,  8 Jul 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neENpgff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D631DA4E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436716; cv=none; b=mqq9uz+Dao3wcgI/BH43EMITMdr2rHw35l9PsveCfapRI9+ZH2RM05dsXruIC/kWGhEl/fmZP7P4wzICwmmjgH6IPD0/HDHLEd6ASkBI5YfVKplDgPsp3FIUDVWgUZB75D7Ut6rqKDAt7xTf6BAfij6Fwmp9t3RD3D8lfeMKxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436716; c=relaxed/simple;
	bh=XywALW3tsHVdVyQKTsdqg8ZeMP0vgyRkxpi6v9aJDdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftX6vOluc8EMcgeNYqM+VFX7nwQ6SZ78X3IsrRN0frwu30bhEgqymmvQJhgAuvvpqX8X76yGxl8V+EE4mb6Q6wSynP8lFkJKJJwoWDZNfcR/HGpUEvPbSmVkGtn/KIOpv/pbVVD5Uf7PIa4nY3ypi2UImCzHcxkA8wb28xFi/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neENpgff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35FCC4AF0A;
	Mon,  8 Jul 2024 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720436715;
	bh=XywALW3tsHVdVyQKTsdqg8ZeMP0vgyRkxpi6v9aJDdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neENpgffc/QAZdBr/kRadfxBiGHBqxZOEgzcHmr9MnXuBtWxU/RP3dOt9x/bO8zm9
	 JARM+pZvNAS7cADgHCvBuy8T/lK7qFFpSR2th3saZaZGXr6df8kBmgJnJ2uCFGEGhX
	 k8msLi72uJ2v5yO4y5HFpuvstxqDWW65jI6Q/rIQUVMMKS+o4pknZwmcKE5XHPU5nc
	 eLwxzw9Fvd0LJF8tWjDwq3NtaKAq6gwUQu/sflzvFW7Wdp+3EYAdvKyxUydi2aJyMy
	 o7VlKXZzbo7ZtqDm8BnR2kyPHRi0fMMn/KFOhJylaDJumQq9QUtc3ThtPVT+juvL/p
	 G5DqZj0la535A==
Date: Mon, 8 Jul 2024 12:05:11 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netxen_nic: Use {low,upp}er_32_bits() helpers
Message-ID: <20240708110511.GM1481495@kernel.org>
References: <319d4a5313ac75f7bbbb6b230b6802b18075c3e0.1720430602.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319d4a5313ac75f7bbbb6b230b6802b18075c3e0.1720430602.git.geert+renesas@glider.be>

On Mon, Jul 08, 2024 at 11:25:14AM +0200, Geert Uytterhoeven wrote:
> Use the existing {low,upp}er_32_bits() helpers instead of defining
> custom variants.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Geert,

I agree your patch is a good cleanup, so from that PoV.

Reviewed-by: Simon Horman <horms@kernel.org>

But it also also seems to me that the last non-cleanup fix this patch
received was the following commit in May 2012, which was included in v4.0.

commit 01da0c2b0391 ("netxen_nic: Fix estimation of recv MSS in case of LRO")

So I do wonder if rather than cleaning up this driver,
we should discuss if it should be removed.

...

