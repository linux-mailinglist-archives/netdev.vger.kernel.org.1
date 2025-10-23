Return-Path: <netdev+bounces-232243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A883C0320B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34423A1DD5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3733734B41E;
	Thu, 23 Oct 2025 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="gyAWoTId"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C27467E;
	Thu, 23 Oct 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246259; cv=none; b=ZL+tWtFAOAFJ9BP+7MS80mUPxi72/Pi1S4x8vnlgEbIohXz7hu7ivV1n3o0ZYhWMUUXj+qWUbLf1e1eQ3Gc+Zoku4cBHzp+Xmq8Vh63lzkGX1RkARViBTJja5AynX8gtSekSNEg9y+2mluRKgnuxLCpOG/7N3GZzjwUIglDtkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246259; c=relaxed/simple;
	bh=d/erygPoiHqkkNHP5PnCMMv/LWWb+FmWY1h3Nkz4ewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpXJMgLj5oFXNrLD0vPJFWczKGEsZ9tCg86f5S3ggFl0r9hGIKMASeFLiZePLlRIAgXZK06i5JYhZa9lnVJ3PjcmcLc3tMCrZq09dq8AsEZutJf1Tj1NSyTLlucIBGAxCuIFgOuXKBGWLLNCDpt7W42mGvCT7DgZR+xVGs/5fX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=gyAWoTId; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cswSC3NY2z9v3Z;
	Thu, 23 Oct 2025 21:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1761246251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+oODwYQ9lwCe9K/U/bcB93zGBEd5OOIcO9Gk5OEwZY=;
	b=gyAWoTIdPUmPAVVSpBiAqYhyXGXQWQnr/zxymmoNXkUC7ALR0KovpU6BRPZVh0jqE2dh8E
	6nuzcoxuMsc6CwxgBXMuXa8n5AbpD/UTxqN5bBqV6t5YHTuR+wy6Xt8XDaIrYW1rawZLQS
	xdZyqv0xPyUDOBm6e6KBQne/Rjzo7ibXn2lXxPTvJlaqUEjiLUYjs3O0acTmzg1X1mQEkX
	N3CIQFXusvdSMlIVK/xvWAKatfycuUC7A0aQmeES4wOOnCcSn9ThnAqJdKBHaFGImtd7on
	A6trL2dRq0ESIZ49+AqhX4jE7LVFICpAtwXRBt4QE1bupK9IN50u0G2pkOVmlg==
Message-ID: <7b379440-be1a-4a2c-86e0-9d69d6835095@hauke-m.de>
Date: Thu, 23 Oct 2025 21:04:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
References: <cover.1761045000.git.daniel@makrotopia.org>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <cover.1761045000.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:16, Daniel Golle wrote:
> This series refactors the lantiq_gswip driver to utilize the regmap API
> for register access, replacing the previous approach of open-coding
> register operations.
> 
> Using regmap paves the way for supporting different busses to access the
> switch registers, for example it makes it easier to use an MDIO-based
> method required to access the registers of the MaxLinear GSW1xx series
> of dedicated switch ICs.
> 
> Apart from that, the use of regmap improves readability and
> maintainability of the driver by standardizing register access.
> 
> When ever possible changes were made using Coccinelle semantic patches,
> sometimes adjusting white space and adding line breaks when needed.
> The remaining changes which were not done using semantic patches are
> small and should be easy to review and verify.
> 
> The whole series has been
> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changes since v4:
>   * use REGMAP_UPSHIFT(2) macro instead of -2 value for reg_shift
> 
> Changes since v3:
>   * unlock mutex in error path
>   * simplify some of the manually converted register reads by changing
>     the type to u32 instead of using a u32 tmp variable and then assigning
>     the value to the previously used u16 variable.
> 
> Changes since v2:
>   * correctly target net-next tree (fix typo in subject)
> 
> Changes since RFC:
>   * drop error handling, it wasn't there before and it would anyway be
>     removed again by a follow-up change
>   * optimize more of the regmap_write_bits() calls
> 
> 
> Daniel Golle (7):
>    net: dsa: lantiq_gswip: clarify GSWIP 2.2 VLAN mode in comment
>    net: dsa: lantiq_gswip: convert accessors to use regmap
>    net: dsa: lantiq_gswip: convert trivial accessor uses to regmap
>    net: dsa: lantiq_gswip: manually convert remaining uses of read
>      accessors
>    net: dsa: lantiq_gswip: replace *_mask() functions with regmap API
>    net: dsa: lantiq_gswip: optimize regmap_write_bits() statements
>    net: dsa: lantiq_gswip: harmonize gswip_mii_mask_*() parameters
> 
>   drivers/net/dsa/lantiq/Kconfig        |   1 +
>   drivers/net/dsa/lantiq/lantiq_gswip.c | 471 +++++++++++++-------------
>   drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
>   3 files changed, 243 insertions(+), 235 deletions(-)
> 
I reviewed the series and it looks good to me.

Acked-by; Hauke Mehrtens <hauke@hauke-m.de>


