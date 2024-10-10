Return-Path: <netdev+bounces-134150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B39982E3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9249FB266B6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C91BD4F7;
	Thu, 10 Oct 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3SgVLVI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3371BC9EC;
	Thu, 10 Oct 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554063; cv=none; b=MIlpbTGK+fsoOugotS+aEYXHRaRKUx/6Xsjh0ZfgcUme0YK7sXTJf1RuHD23R+NZdtAiijz5l7axQGqc/wfmZk+ctcLXUO1/UwMrsD/o1PifO1Kco2myHfJkwNWXkoXir90Jww4tDXXVtW/jE/Gg/eNc2nLeVvls5dKQYtV6K3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554063; c=relaxed/simple;
	bh=oPlyeFx/F1I/aRcvpCxc3VfOaqbZr0rB7xSA+d2OXL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT4aoaRJx+J+FoRX1RN1IHM9Flh1RlmmK+l0iZvH7K03tJ5lBgO/peF3zaRivwSMW4XBozKa+vFqMjdLhjhDD8krqgOXMztBL1IjoW5vl0hP/EmsWYG62naO1yBtAJcRQhDLUB1KHZwkQAbov2dNixtBwXylxq0KUAIJJaf1fJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3SgVLVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5957C4CEC5;
	Thu, 10 Oct 2024 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554062;
	bh=oPlyeFx/F1I/aRcvpCxc3VfOaqbZr0rB7xSA+d2OXL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3SgVLVIqruuohIu0xat728yKnTfBVNfmmb0+RBxHWp9ozpllcGr0Z2vq8sysz9wo
	 s8hpEFtp2Vr7bbUKHxQNCFuVU/x0TynZJ0ODZ6nnUO0YKq73uvawz+rB7HO4YwTXdW
	 ZAjouwm/MxnlFpPPNjus+OAVpbIiIBQK08QYluX4Jd9VPLBsNNGxolIGOx2L6m/Q8b
	 714Tlt9sCFkpiTw0sbIasgBtBTpFUMCCrhEvwV2iSVu6ePTFuXSIND93wBTIdLTKvg
	 YREOo2bU06oBAaB9CV1xW9y9fLUMGsR/P1Ee8xDkmPJxoPzGjGbtTmBSZjGqbpzxUm
	 sqldDspH3uTew==
Date: Thu, 10 Oct 2024 10:54:17 +0100
From: Simon Horman <horms@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, Abin Joseph <abin.joseph@amd.com>
Subject: Re: [PATCH net-next v3 3/3] net: emaclite: Adopt clock support
Message-ID: <20241010095417.GB1098236@kernel.org>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1728491303-1456171-4-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728491303-1456171-4-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Oct 09, 2024 at 09:58:23PM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
> 
> Adapt to use the clock framework. Add s_axi_aclk clock from the processor
> bus clock domain and make clk optional to keep DTB backward compatibility.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v3:
> - Remove braces around dev_err_probe().
> 
> Changes for v2:
> - None

Reviewed-by: Simon Horman <horms@kernel.org>


