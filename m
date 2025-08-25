Return-Path: <netdev+bounces-216676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B292B34EC7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9B1A86D52
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768329ACD7;
	Mon, 25 Aug 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nngDs9Hl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43A2248A5;
	Mon, 25 Aug 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159803; cv=none; b=ZymffkPP5dJ0xIdH3hIflLIWTKyjPlb7YTiOCBv8UVLpI5BCGNPGpD2h/A+3+c4E8KFl03SlQ/b6uCT7TR7tn45fo3vSkMCSZ+rTn06G43NVGXoQ/Yh7n8fyW+JncZ9YmrjJanRx3R3S93XDJMcnYRvJqz2EY+xpAHYjO6c7GB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159803; c=relaxed/simple;
	bh=GQED81N/3RN4me/aBbpHkkTnSE0rz1dLwGdaaoZs8uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYojl0sdRcSD9hspOKmF0AiF8jnjT24B8qfzJUuNO1i+1TCEj6p/OM5eHo0Fj5dxTDuPSWiJUSMAfUafZe7t1GxmvQr5yGij31aVv/b7hL9d25SaOGZ6vDEvOF+oPvhgweq2Q+iY/djneRnl2FthcqX8NaCCDGnzFIw+QvKDOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nngDs9Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C38C4CEED;
	Mon, 25 Aug 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159803;
	bh=GQED81N/3RN4me/aBbpHkkTnSE0rz1dLwGdaaoZs8uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nngDs9HlA1MEJOt1a+JjLfyqN78DtafGWuxfc4yHq8pJOhj3h4emOQIZIoy4z+cWg
	 bvFzklvrrx0VV9ocZMQF7H4KslkGjC3ECZoBEQjB/EAoy3ty0Jmy2VQSywtgaOlspB
	 g36DgQLNc/FAYnFoOcJaQDgNCECRC9C+J3EPQZ+c8lJUvyMrvgOAZxHKjwtGlf7XuT
	 hUlWu/FyRIZzZeHiU0CDPYc3XogYy2N6nEdKeNMlciONr9NsFbUVYnU03Sk0KUJxsu
	 d1SNiLypRoB87YIJeYEcBPTBCmVoYsN79YVVp1LBL4CcNTm94jG1NM7/vnBHa5WUkq
	 1IkdziWgwKu0w==
Date: Mon, 25 Aug 2025 15:10:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: pse-pd: pd692x0: Separate
 configuration parsing from hardware setup
Message-ID: <20250825151001.38af758c@kernel.org>
In-Reply-To: <20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 17:37:01 +0200 Kory Maincent wrote:
>  	manager = kcalloc(PD692X0_MAX_MANAGERS, sizeof(*manager), GFP_KERNEL);
>  	if (!manager)
>  		return -ENOMEM;
>  
> +	port_matrix = devm_kcalloc(&priv->client->dev, PD692X0_MAX_PIS,
> +				   sizeof(*port_matrix), GFP_KERNEL);
> +	if (!port_matrix)
> +		return -ENOMEM;

Leaking manager..

