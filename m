Return-Path: <netdev+bounces-194097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABBAAC751E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37B2A27EE7
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474A1519AC;
	Thu, 29 May 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5lX5FTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7615D1
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479150; cv=none; b=K+TH4pMWEf3rYC95u9sJO6LOy20mkYgAT4l9HCkU7tjj6z3vVPYyahFR5VRNhNPIIUByimHZK5okYd8FwC9KeKpkuobBIOMYMfMPLJxLmikBaMD930DVSeeeBmwrqWA936IbiBWMf9yMzLDKLf5oMd6fssG/SO9Tty5UIYqrd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479150; c=relaxed/simple;
	bh=oS1awislkOa4QAzbVGNmjNwjbovl6xQlTS/Bn2W3Zv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOA4kqKLVzQ6y56bZqB+ZDRAzlzcsTaoKHT1Vl67mbBtFbpoa7qV0NhxYgECs/uOkPUVVYd0xEuILvcESS3715eYcKw68dJshj7T6JnfoUBLneIIje3LgzVR0ZYirD/jQlzoEIFbZVjHEpVC+BMOhdMYEHnq9mCXE4Ll/ePgLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5lX5FTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AB2C4CEE3;
	Thu, 29 May 2025 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748479150;
	bh=oS1awislkOa4QAzbVGNmjNwjbovl6xQlTS/Bn2W3Zv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5lX5FTQoPYswOWuY1S8SJDSgvQN7SVHI7mCNwPbp+RnuktC/T1vwYnfKJsFulT1R
	 FyBzdcbXcxKkY6DRtM1ZgFqHb+tQ72DWLX3RpvQZawu//ifbhRpzVytorJa+03cbHs
	 95cxKiqpvMTG7zhMLSPg7MbYIiaAGCZ2bduhiwRSnR7XTGb4Z7v2z7OoePUZcBX7Bc
	 LUKnI6DNJgKDiRJwCFlJM3Nxj4KAOzqEYodtFwyuTXwNBPUQbZqwf/GFdeKxCbbvrz
	 q0M4YOyhIpktdAEsiTe0ElABMzTJMLDdrllXdToh8QP/7WsuRD0mtslCZEDA799xmK
	 uWlCFf6FDHqsQ==
Date: Wed, 28 May 2025 17:39:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, netdev@vger.kernel.org, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next] net: Fix net_devmem_bind_dmabuf for non-devmem
 configs
Message-ID: <20250528173909.41acd7f1@kernel.org>
In-Reply-To: <CAHS8izO=64PCgs7mjobznH0D7sQ76fBXjWoTTNxzO-Or+hqhcQ@mail.gmail.com>
References: <20250528211058.1826608-1-praan@google.com>
	<CAHS8izO=64PCgs7mjobznH0D7sQ76fBXjWoTTNxzO-Or+hqhcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 14:53:35 -0700 Mina Almasry wrote:
> I'm unsure whether this needs to be resent to net now or wait for the
> merge window to reopen. I think net is for fixes to code in mainline
> linux, but the devmem TX path has not made it there yet (and is not
> even in the net tree yet). My guess is that this patch should be
> reposted to net-next once net-next reopens.

net-next "becomes" net during the merge window.
There's a period of tree-uncertainty while our PR is out,
and afterwards all fixes should target net.
No need to repost, we'll take this fix in tomorrow.

