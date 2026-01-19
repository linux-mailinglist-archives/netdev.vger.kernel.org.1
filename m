Return-Path: <netdev+bounces-251232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 464A7D3B5DE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4817F301EA32
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9A38B9AC;
	Mon, 19 Jan 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy03zumJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08C38B7C9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847515; cv=none; b=NQwA4MQFGDpV7TbGrSH37XnxhGTaUtZ/1xMlsu9wzCvR3V2yTjfs1aw+dO4weNaNDXe6fAkwGI0q+I1JkYFOm4EQiDakoC5DR8XgxOEBTRbdfy7e89aR/fqc76RXPdLnZB2Di4pCi+wA6sLiLQO5XErDHK+1pVSuAIMsZO0z7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847515; c=relaxed/simple;
	bh=PNFR6x6MWV8gXQnZRSFzIRZzBJppfo5zle9BpQEsrMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2GofOBE4+jO9LScvF6RguxWZIomzGkIukYwP+gIs2WD9WpCpZyyP+3Q9GRUf1HBHBg/vyqR8jTyKysWMF86PuJr132uEyHCafGKlAGZbrNIawbKiRVJzycyD7iUskd+4cRYgzHfyFV9d/P2/X96tyQKS62W1mzD4WS1SAFEsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy03zumJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3745C116C6;
	Mon, 19 Jan 2026 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847515;
	bh=PNFR6x6MWV8gXQnZRSFzIRZzBJppfo5zle9BpQEsrMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uy03zumJBrZX+lQh0nHr5EG7jjCb6vJbMCjNeb+aNHCm1JfbQWDvAZPaR2OgnMSBq
	 4cEWvlsEulbH8OtkyMKJaeCnX/qwmaUn0ZvAouoOtiRjAwiMbPPmdaaZw6VeTiPS8P
	 LNXBdo57KVr4/TlnApLoSubySOKbIaiVt7HDTmmzCyy2Ue+5PMJDNDdxgH33+rCc10
	 TjTMKB93P50iHWEb4xVgEw9rysa2tomWmY4vu3tjzCUxaXNmzXVgUct6EacxcHJUt7
	 i+jWLcBCxoXa9rgObkMy8EkdF6DlYLKHJCJHpmY1sBAdHd2IlKlHpQHOBKYMo0fUBc
	 +nuxbKIiI/T9Q==
Date: Mon, 19 Jan 2026 10:31:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1] net/sched: act_gate: pack schedule entries
 into a single blob
Message-ID: <20260119103154.07161f2d@kernel.org>
In-Reply-To: <20260116113049.159824-1-p@1g4.org>
References: <20260116113049.159824-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 11:30:56 +0000 Paul Moses wrote:
> Store gate schedule entries in a flexible array within tcf_gate_params to
> reduce allocations and improve cache locality. Update the timer, dump,
> and parsing paths to use index-based access, and reject overflowing
> cycle times.
> 
> Signed-off-by: Paul Moses <p@1g4.org>
> Depends-on: <20260116112522.159480-3-p@1g4.org>

Please repost this once it can be applied.
And when you do please CC people appropriately.
-- 
pw-bot: cr

