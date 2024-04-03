Return-Path: <netdev+bounces-84430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03702896EF0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983541F2385A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4E241E2;
	Wed,  3 Apr 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/Oewkmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22A487B0
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147851; cv=none; b=LZPsTq6bgPB5YniyPNoHfNR/z0w/BhkpgB+WTMoiqyun2pJxkZCwqvgovaqGOBTpyoMqrqP9mq3MAFN7PDaCgIqN4/AeO29qnImd/9eaezORjmJqeEGfDYCPkWuAweh6jUpRiSQsmfUOfdfzxtVnOk5ElPzT/jkbR6orklrXhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147851; c=relaxed/simple;
	bh=S7x9QiDoowGIbnctarzQNfXhKPrZcvn4Hy0ePlHDQ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdIMOERTtCUXK5BRdO2ppEtYrInoi7PW1HF9xqgqwLofdP5T7kpcL6MnxzF7uyJxpkszTk1nKVMLGs2e73Ahu+yE7kOuG5YQaT41NOW4EOpfsNqEeNr6eGzPJaw7cdYZmrElTHU4vuheB52Tl2ZKD7lDKEgpgAlew1EgafTl3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/Oewkmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ECFC433F1;
	Wed,  3 Apr 2024 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147851;
	bh=S7x9QiDoowGIbnctarzQNfXhKPrZcvn4Hy0ePlHDQ1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/OewkmiF9bsZPsQ14r4KmEqExGTj0Qdc5fa3At06fHMpT5szFRO5WQXhmH63GiCE
	 CXgyczbW/DF6RP/Xgl5XJwiXSA+AezpAcBl+iYiwWnVwuvQgXAzHwYlf+BSLBeCkrm
	 FzbuCLvtQiUu46FRLUd41g1hBee+WkMM3FT9/EKgv8cPpYurj/cGHYbOGKggRorWb7
	 bK+PVWu2+s2srcvqKMtbSsi0xeXumdkDQt84VKGrMiJW+owtbI8356A/d5X///E88G
	 OYOHoHux+GDN1397t80A04mSJWlm/yNfTGQE4NjLuFwb8V4sM7Q0R3EzY9Kfq+ui2m
	 vUxwfo0988PGA==
Date: Wed, 3 Apr 2024 13:37:27 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 03/15] mlxsw: pci: Do not setup tasklet from
 operation
Message-ID: <20240403123727.GY26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <a326cae5fc1ad085a1a063c004983de6fe389414.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a326cae5fc1ad085a1a063c004983de6fe389414.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:16PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, the structure 'mlxsw_pci_queue_ops' holds a pointer to the
> callback function of tasklet. This is used only for EQ and CQ. mlxsw
> driver will use NAPI in a following patch set, so CQ will not use tasklet
> anymore. As preparation, remove this pointer from the shared operation
> structure and setup the tasklet as part of queue initialization.
> For now, setup tasklet for EQ and CQ. Later, CQ code will be changed.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


