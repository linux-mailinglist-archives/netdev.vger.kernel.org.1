Return-Path: <netdev+bounces-134069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A933997CE9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F26E1C22610
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F91A3A8A;
	Thu, 10 Oct 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grk7exM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D71A303C;
	Thu, 10 Oct 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540901; cv=none; b=fSv0ChbixQDGs2yqMgK2WJPvWs8+E87N29EntGGreR0jgINithvEiaLaEoH2o7aMmqaHspq/OG4FKTyTVkpJl/FM1Y0t/qaJu+ZJrEKhCkbi9bfa/FtLsjd2yZaazQ7ZRp7w6TNqQYkIa/K1XiiEC3TYsHEZ7jMZ46K0TZVolfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540901; c=relaxed/simple;
	bh=GOnmLWrFgzrOd+f0EQl6aCDszrZ23nW8rO9vc93Vbyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbiFFuCcRfNZxALBFN4gQF6oCJ0PgdHvUcYVl1hw7tJm+LiQ7mD5CL0MC9z0xL4Iq2gEIv6vilSg9Lwqsn0cBPLiazNXD0p7TjbNPaNC49yQZwzY2CuH1XI/2CvFz+Q7CSjHpFTCMi5+VS903E+xgpMDh6tFNuauwixD2frljpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grk7exM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A70C4CECE;
	Thu, 10 Oct 2024 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728540900;
	bh=GOnmLWrFgzrOd+f0EQl6aCDszrZ23nW8rO9vc93Vbyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Grk7exM+qqT3LT56kTnk/kp2ohFJDeZaoefTO3m3Iogb4fCiC91syqVKOchaRbZ1X
	 yieSxr7u+yIvqgubZbTjbKgSRnOCpxrP4d2xq8xYNcJMZ+XxyOubqG7YFeYpeuLdpa
	 0xrQ3D1lNdtTetS2NjomuFoHI/9/tPZSlq/WRRQj3qeCVJhvnK0XK3J6nmuGorDv4v
	 vVVOpZ66P+uz2oSHzDdxllUPYge/zrW2+tJFqgITjiGJKadVB6qGTR1M3KE9jfn6DP
	 uGUnQ/VefRqq1zHZEwd/l0aMBZG+qwS9tem7i83JiV7sHDcsmuzJUwLxDz5AiQMS8J
	 uOlWyuJo3CXKw==
Date: Thu, 10 Oct 2024 08:14:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yijie Yang <quic_yijiyang@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com
Subject: Re: [PATCH 1/3] dt-bindings: net: qcom,ethqos: add description for
 qcs615
Message-ID: <24b46siwlah4omyqbr4gn4mrc3h3753yslwndr4v7zyvqr7dz6@6n4b3jbcxs6p>
References: <20241010-schema-v1-0-98b2d0a2f7a2@quicinc.com>
 <20241010-schema-v1-1-98b2d0a2f7a2@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-schema-v1-1-98b2d0a2f7a2@quicinc.com>

On Thu, Oct 10, 2024 at 10:03:43AM +0800, Yijie Yang wrote:
> Add compatible for the MAC controller on qcs615 platform.
> Since qcs615 shares the same EMAC as sm8150, so it fallback to that
> compatible.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


