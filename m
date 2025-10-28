Return-Path: <netdev+bounces-233361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFBC12841
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE563BAD89
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E66E221FBB;
	Tue, 28 Oct 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVxOSjKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802722128B;
	Tue, 28 Oct 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614326; cv=none; b=mVGu2ElYsEOOQjqGwhZgV0N0xYIzNFkDjq4Xuf9DkjoEyrpFkoBp6nVKIzPi3h+S8Av5oulkH1cp+DMn9b9VJs7PpS6VMte9yJ5VICv7C1ge29Whs6HmskbsLQcRA8dH+zf2fAXqiIWFqvfFO58r6YFdzqyNWa/0pc/qrTWm+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614326; c=relaxed/simple;
	bh=RHhM/qywsqdyUblveLAmS29UOgKFyY7LcoAlOyfOuZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP6N+GP8Gi0AeB5X5m1PNjs7Oe+LbcHdgxVmAaaCUaZZKFPSAQF4rIQ4jRgkEPl7ilV6vdLwGiwn2z795nfh/AzbqkNKoPuvfMVSKXjIcTht27pEf8d226VORwp/woQDluBgUOuFppHFCFfe4ZtfwU8XifQ2bs2r1PIHUZANKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVxOSjKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85CC4CEF1;
	Tue, 28 Oct 2025 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614326;
	bh=RHhM/qywsqdyUblveLAmS29UOgKFyY7LcoAlOyfOuZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVxOSjKHYT/Ou1ueqWcbtE3n++DQUE3kPgaFSYdCrrYs0vpXrHXbHbj/+YWxKRbW6
	 +HZZoCIM9q84sPeLgdu9tMW3Spl4G9jrWxiLF5cFrNHldrA54udceqQyAnBEHeu0sk
	 GrCO7/+ORTXxX7idkjNX+81uR7mlXEzlUlIiKsv54MsW0e2x0BEDBh+8Z8JXbrt66Z
	 iMUS/Cfhewe8zflbMXq5n+IjokrzwqvnSuXW4ll0/6X1WUHnjpP4OMAg1t0/YnuakH
	 KG8Q79/4ABed+jfUNwVYVDdrsc5HW8Y7/FzrBHjMJopnIIII7PLB4ITtrxQDTKT0Nk
	 XXFa5IfbgO+Vg==
Date: Mon, 27 Oct 2025 18:18:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, tglx@linutronix.de,
 louis.peens@corigine.com, mingo@kernel.org, mheib@redhat.com,
 easwar.hariharan@linux.microsoft.com, sdf@fomichev.me, kees@kernel.org,
 niklas.soderlund@corigine.com, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfp: xsk: fix memory leak in nfp_net_alloc()
Message-ID: <20251027181844.790a2a20@kernel.org>
In-Reply-To: <20251024152528.275533-1-nihaal@cse.iitm.ac.in>
References: <20251024152528.275533-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 20:55:22 +0530 Abdun Nihaal wrote:
>  err_free_nn:
> +	kfree(nn->dp.xsk_pools);
>  	if (nn->dp.netdev)
>  		free_netdev(nn->dp.netdev);

Please add dedicated jump label for places which need to free xsk_pools
-- 
pw-bot: cr

