Return-Path: <netdev+bounces-217993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DBB3ABA8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E117AD072
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0327AC3A;
	Thu, 28 Aug 2025 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="CfMK/dsn"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E621E487;
	Thu, 28 Aug 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413056; cv=none; b=Xoo+Ph+R4XJu9MT3j6PBhft01M8wurDwgfPwbTuRrvExjmwrKH5MkgKrXST3PWUwBhoeMcVJ6vqBxP3Z9T7UmtifIo6aFm2PpRELME02yvH5CcNuaJAtWu5ZhFjC8+ih4OGSj11fX2UaRq3O+ELviPOgA3iUIqzyW4yU4BULpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413056; c=relaxed/simple;
	bh=zER9DfFp64kz5WFudLZ9+ZE5m5h5Lmzkq063pHm6LgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTO2ogPgMw1S02zDk4bALqyU59Vjj2G0Ixci9VbgWGK5qxrF4k6zeyNBK9xou088P7jOIojS20sUAgTTmEXZDr9sG15HtngxKZlLBrtUb0dqGlR8D0ptMNFbve5z4d7/NE41jMeuT+XBgv1zIHmxwv0swVxcvRNAh3VY0DFIMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=CfMK/dsn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cCY1x4CCKz9tW3;
	Thu, 28 Aug 2025 22:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1756413045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPpvjuub457HJxPPJwXhoJ9YQryNGu4CPN4en8+1PMs=;
	b=CfMK/dsnJJTqPyWm1fmvCbSRnFeTPt02NIkJ294zm3GW8Mrkx8koonkeqwMyX7VgRSHNc8
	9qrZpENJOcXpjXaa2izMwGxWna74WBmzSYELLBtwlAhdvkY4dHg3bDHMeCvTFUlFVvsFZ9
	Z9U+SjFya/h/PYwHWwMVfiAUSoJXOoPLsbcgPCCc3J5nrtY5JfznP+cilK/+w5AK8XDVBL
	NET4Kda69lovpmK45F7cAmP2w7PVqKiTBlFqoGXdP7rqAFmAxkMAJpLTrKhGfbDfB80plq
	umVwXv21UD0TwbiTsWbiSfSWlP+HpolneoPT41RBr+I2OAM98IkMlRANDtDJZQ==
Message-ID: <b4b7d4e6-ad38-469c-8b88-65cb78f97de9@hauke-m.de>
Date: Thu, 28 Aug 2025 22:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 4/6] net: dsa: lantiq_gswip: support offset of
 MII registers
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <8cb10636ec71e0a237d7132685884ce885f14bb5.1756228750.git.daniel@makrotopia.org>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <8cb10636ec71e0a237d7132685884ce885f14bb5.1756228750.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 01:06, Daniel Golle wrote:
> The MaxLinear GSW1xx family got a single (R)(G)MII port at index 5 but
> the registers MII_PCDU and MII_CFG are those of port 0.
> Allow applying an offset for the port index to access those registers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes
> 
>   drivers/net/dsa/lantiq/lantiq_gswip.c | 12 ++++++++++--
>   drivers/net/dsa/lantiq/lantiq_gswip.h |  1 +
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> index 3e2a54569828..64e378852284 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
....
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 19bbe6fddf04..2df9c8e8cfd0 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -233,6 +233,7 @@ struct gswip_hw_info {
>   	int max_ports;
>   	unsigned int allowed_cpu_ports;
>   	unsigned int mii_ports;
> +	int mii_port_reg_offset;

Maybe you should set the mii_port_reg_offset attribute explicitly to 0.

>   	const struct gswip_pce_microcode (*pce_microcode)[];
>   	size_t pce_microcode_size;
>   	enum dsa_tag_protocol tag_protocol;

Hauke

