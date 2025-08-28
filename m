Return-Path: <netdev+bounces-217990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7211B3AB96
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0303AB91F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83027F4CE;
	Thu, 28 Aug 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="GMmqTmIa"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16781F9F73;
	Thu, 28 Aug 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412698; cv=none; b=m1kiHcqnIJvb72ReMv0uHLxpRjtJxvzFVeTqwY9fQwp28eM/1ugjKZu/JXcSVZrPV3yojAeRLSlZkxG7qNswoBk8P2JK9RCyfuq/ZYzjrJ3vIE3+BJ4PpFhRZv44zzeP1KRhxd72gt1QDXxP/Unek5iNyXaZI75mo7GdGOpvqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412698; c=relaxed/simple;
	bh=drVI0viUlBPg8FxrnFTeeBrCUudaXFk1KNviZsYH23w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trX5vie5LA8b1oXP2piEF9cXl5ARJ68Fx2vneosisIQ6L6x2slVg+09zFRl0syuurfD45yNtpWdq0E0RuSYZ389g8RCvPGBjwQ+0umZ2MdqDaL5Toakt9YnDelgAMMnEUrO8p0t8cuNAlGi0KTjnPKAF84pWVmHZl9pHwRjdhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=GMmqTmIa; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cCXv74LC7z9syn;
	Thu, 28 Aug 2025 22:24:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1756412691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMtC0B3pYzdpwORWGthByDnjuodZ3qeVZdonWVoF/P0=;
	b=GMmqTmIavWhVkQ++Bl5hrC5C2Dh9z3bmhqIJG49fkeDfjmcDxz5yn9Y+M961Y/ktlPIwys
	w60RTWjCj1zro6StwSSkN8aHVBHMUvXR/kkg3b0jT0U4VecY6YTcwULw0k8n5cUi262DkB
	RMI6tMY+BfpMdPcYcHamU/U3mSokASB+oSunv9LdlOTWFjFScOMxYS+HWGNztL/jFQLO7R
	CUMbB82DUJgu6jVK19mCdjoeXSV4c15WQxf1VFUWlK/RPSws+TomGIJ09hDS8byxEnO0F0
	BUOIDxes4EH+MezWFTVgIdFOJzc8k2Qgjh7L7YTnbPaNVYXaZykE9dQd5lIzlA==
Message-ID: <bc8e179a-227c-476d-97d1-f7909fe14e58@hauke-m.de>
Date: Thu, 28 Aug 2025 22:24:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/6] net: dsa: lantiq_gswip: prepare for
 supporting MaxLinear GSW1xx
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
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <cover.1756228750.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 01:05, Daniel Golle wrote:
> Continue to prepare for supporting the newer standalone MaxLinear GSW1xx
> switch family by extending the existing lantiq_gswip driver to allow it
> to support MII interfaces and MDIO bus of the GSW1xx.
> 
> This series has been preceded by an RFC series which covers everything
> needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
> had suggested to split it into a couple of smaller series and start
> with the changes which don't yet make actual functional changes or
> support new features.
> 
> Everything has been compile and runtime tested on AVM Fritz!Box 7490
> (GSWIP version 2.1, VR9 v1.2)
> 
> Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/
> 

Looks good, thanks for the work on the driver.

Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>

Hauke

