Return-Path: <netdev+bounces-248169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F3D04862
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE4F30F07AC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760962D6E5C;
	Thu,  8 Jan 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/861jCw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C828688C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890132; cv=none; b=SjEJeZIsDP+7flM9xyjf9b5gcXCQVAszw8S8vCJFHk9eOXbNdGVMRrUHlVxbnGkl5NS8hZARQD+CrJXbCPnCkehqpws2KItSwqdxYrMHbJz/3mfXDeEKvZBqdwVNbe09tV4j5AcrJ/NnXSncjmi+bbwbLqNKtm6pm5sInaZnwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890132; c=relaxed/simple;
	bh=UP2qNg/rUR2ZAC+yCo2XzpGPVTbsI+Axry4bLVpUhlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRgjOMl1aCsSepQ0v2NXy1T+6Vjt+d9GZ2D3cT1Qn8SUPOgi8LVrUD6sT+fbHVMGQ+RhD1NTanPYqkkxoJlocDDJUdhKFYhQkPiPiV8j4BcDDIVZqsqy7PRaNsVuHrE4OVAyOsmtiV3oF0eUvhJ0C5BohrSvebjUAf7K0jplZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/861jCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C10C116C6;
	Thu,  8 Jan 2026 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767890131;
	bh=UP2qNg/rUR2ZAC+yCo2XzpGPVTbsI+Axry4bLVpUhlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/861jCw0+1Vb8drQOd/iFXE+wiCJL7dst7PSHqUJ3CetZT+BYGNl9lWg3g46KWUP
	 3r/TAOy++Zf1okJJ+1N2kXGkdt9Pck/BF4Fo+qCR59Z2BrJVfqfUMaEHFTPBxaCWHC
	 1OJxmTuFVqBkg++LTnlVL4xxgXAbDINd9XsEhT63ZZ13KHt/buEHF4HEZsK+/wgQ9J
	 X0rHEUJ+lLOpWNCrSged52K5LmhVJRj6I/YNebemg4+wDjmeF3JjofM9HbGaB8PPsq
	 YswAGqvimPO+iRaPu1ORiHTFHQ0tiCKeulhU9QJSpqCcXZKzU45CEEizvalm2a5nK+
	 dFuKLd6z9kNfA==
Date: Thu, 8 Jan 2026 08:35:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Joris Vaisvila <joey@tinyisr.com>, netdev@vger.kernel.org, nbd@nbd.name,
 sean.wang@mediatek.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <20260108083530.6169b627@kernel.org>
In-Reply-To: <20260108150457.GI345651@kernel.org>
References: <20260106052845.1945352-1-joey@tinyisr.com>
	<20260108150457.GI345651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 15:04:57 +0000 Simon Horman wrote:
> On Tue, Jan 06, 2026 at 07:18:28AM +0200, Joris Vaisvila wrote:
> > The MT7628 does not expose MAC control registers. Writes to these
> > registers corrupt the ESW VLAN configuration. Existing drivers
> > never use the affected features, so this went unnoticed.
> > 
> > This patch skips MCR register reads and writes on MT7628, preventing
> > invalid register access.
> > 
> > Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
> > Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> 
> While I think a minimal patch along these lines is appropriate as a bug
> fix. I am wondering if, as a follow-up, consideration could be given to
> registering alternate phy ops for MT7628. This would push the conditional
> handling to probe rather than calback execution time. And I suspect it
> would lead to a cleaner implementation.

Plus the commit message says: "Existing drivers never use the affected
features, so this went unnoticed." which makes it sound like user will
not notice the bad writes today?

So perhaps we can go for the cleaner approach and stick to net-next
(without fixing the older kernels?). Sorry for not reading the commit
message closely enough on v1.

