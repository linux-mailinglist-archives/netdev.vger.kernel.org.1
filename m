Return-Path: <netdev+bounces-105383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB55910E8E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755731F22DA4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E71B14FD;
	Thu, 20 Jun 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqTtOATU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F551DDEE;
	Thu, 20 Jun 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904683; cv=none; b=kyTwV1+D9Iei5nm2KmJ2ypkMpgcj3/eOJxHru+inD11bYukUtUvFWliyNlVYkzZc1f+iuT1R/n7RWrmLQb97JUaZHQOW8jkxi5q4wFCAxAlO8dPMsrJ17pzE88PMxr114AQO9zORC7d9AIYB/bRF7lwPf/n+si4rOgEvzxZ0cr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904683; c=relaxed/simple;
	bh=c07EwySV5A8jyBItyxYvOoGB6xh76nUFiW66NCfaRWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+r6nCzwuCSlsgXflmVcL1PbOLMeXgRJe/HZGzHhv0o3sw8Sl2+SXKtfDqQ2+MG0AcbT5qjRm6S0IgOAZdB0mix17SIH+D+Hoin8jeznjPTlR8crUlyAKrD5NESsGXEXeR1dyWbVIKeMrqbkG+72IZESpw4lQiOkXJedS63ddNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqTtOATU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E54C2BD10;
	Thu, 20 Jun 2024 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718904682;
	bh=c07EwySV5A8jyBItyxYvOoGB6xh76nUFiW66NCfaRWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqTtOATUvwlDYXLFMQX0a7F6u0ozKkRdNk9dpdW9p+sV9iHMSGhNwFzTuTKaVY0OS
	 gRSCLXGMnwsH5XJNlQLjm2/Io5kfSfemcVIH22LiBX39gQOUMe2JqIE0dBEFXB7mD2
	 Iy+RdOZe7GRR81nEm40hlDkq3y6ltI54V9BHcupMlm3Xs4QsH8EXI7t40q77uQMRvy
	 V/W2Ind/qTVPKWTnJa9irSlCJwd6rk4yzd/rYn5eoKlZU3gmlF08ilWNC3T0HEL7lu
	 hgyDe4q24UIqdh7JuJmFY2NxOWikW+nHAT3R9Z4wt4UF+2PzhtIntH2XM2Rj2pbZos
	 kN0W+jAVwNb6A==
Date: Thu, 20 Jun 2024 18:31:18 +0100
From: Simon Horman <horms@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next] net: stmmac: unexport stmmac_pltfr_init/exit()
Message-ID: <20240620173118.GP959333@kernel.org>
References: <20240619140119.26777-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140119.26777-1-brgl@bgdev.pl>

On Wed, Jun 19, 2024 at 04:01:19PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> These functions are only used within the compilation unit they're defined
> in so there's no reason to export them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


