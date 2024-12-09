Return-Path: <netdev+bounces-150141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A389B9E922C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E325518862C1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45A21B1A8;
	Mon,  9 Dec 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayIJjFNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07179216E27;
	Mon,  9 Dec 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743720; cv=none; b=gWN67FNBe3KKIJcLVJfhsSoMhEARAPlbr+eut+gpTHiYKtiYnVpFe7Wdhlj/60bB2OeReIL7ASjT8BdqxEAGze0unL3lnvYXPNV3rlgKBVeXiVUKtay92KcCfC685jGEMMP1SXpZTmexyQp/PmLjZTJ5JU7VOHMHds7EiXtLoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743720; c=relaxed/simple;
	bh=30vRIwgjK3YRSebTHVWTfJe+cngnCdDLBhdQNmGB8BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHzPtDTMCRstFdWBSKAnx+GUw0qgtkFBvgFlgD4biIabJgBnhmddqzRRrDV5yXwt8FMHXKqbVF5AtxhJqqKoA2GippSvahVU5pvKNiRagP7Uk0w8mKbNSpJf0hvomT0i+vlYJYAWUA4I6LCpyLWB0a5rQUmXreljWXoV1xZTBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayIJjFNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A62C4CED1;
	Mon,  9 Dec 2024 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733743719;
	bh=30vRIwgjK3YRSebTHVWTfJe+cngnCdDLBhdQNmGB8BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayIJjFNQRsHkl1Ln/M7aXXzcC1Rl6IPRhIwnJcUW5nm7Cu0FqsClSgyyUHq5+5mn2
	 7lokAijq8JNZQt+M89kSIjEQxUzw8vGXrFeiiiUZKzyaaT50KQhOJuavZPA29Rjcgt
	 pC13ftf5Yv6I11kOEc85dtcdMTz5CV9LtFjJQ3KrgTROKOayd5HMuIuVKFMLniMkWU
	 dkcmJhpcbTmTgpivarKCMYiYeg/MQTElhJIWfGR8NjGgtez7HGbZK3vpBEPz6uJDQR
	 CYSF0yvkaUzhMtcq8mQ5hwReA3LKIM7hkPJJSL3S5DkPGexWHsnyKPU8nss8FR4Sd+
	 fPzzQXkDlX7Ig==
Date: Mon, 9 Dec 2024 11:28:35 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
	edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net v2 PATCH] octeontx2-af: Fix installation of PF multicast
 rule
Message-ID: <20241209112835.GB2581@kernel.org>
References: <20241205113435.10601-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205113435.10601-1-gakula@marvell.com>

On Thu, Dec 05, 2024 at 05:04:35PM +0530, Geetha sowjanya wrote:
> Due to target variable is being reassigned in npc_install_flow()
> function, PF multicast rules are not getting installed.
> This patch addresses the issue by fixing the "IF" condition
> checks when rules are installed by AF.
> 
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

