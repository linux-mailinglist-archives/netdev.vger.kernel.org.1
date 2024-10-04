Return-Path: <netdev+bounces-132133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13963990898
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF72E2851C2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966711C3033;
	Fri,  4 Oct 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="PFzawmIg"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B434381AF;
	Fri,  4 Oct 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058022; cv=none; b=ZdMzegdWjyP1LLagUtTEqt6qWRmj+UkMPjaZQxjpBpOGIs/5p/uKfDKGBarhl00M1xTDn2yZWxIEUO0BGGwF7WCL8K7SvAdERSqv8G6s8+XSPcaZAOVisZX2tTm04/QgV2y4J8SFX0EbUm1C8bZoXuVr+b52vRNOqTvJKvAOwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058022; c=relaxed/simple;
	bh=hBEkja4vsp8Q+UgRWsauTlSOZKkD2s2KwqDgpEX/uJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b9Fn0/3Xurfve/Kg21aJYtAxfg6u2abaxnGMvt/cyZ5yoymMpG84qG0EX6/Hwu5L4RNzeeqRjApdoptKLJZNo5RQEkWZ4Yy7yz8/70z0FEdQcy6sq90tusgT2RO+Tw3MCurxBGJC4z4i502pWcJOrYwWKYV8GX++zSw85gZG2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=PFzawmIg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D2BF6A0B23;
	Fri,  4 Oct 2024 18:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ijzlpeLR8Qk5dJIN+iMY
	X7gC2mOR+PiOcoJGQL8hW+E=; b=PFzawmIgHOk+HBmeF3Q2upf54TdUHRayxQsN
	gT0dGZl0CNFXuaOaydOcbqiUL4Fn7ETLGwGQlJHlcoLd1MbxrGahS5n0IFwwTaQQ
	dcmu5fPKH5QgM7e5d91aOikDOXZyQLckF3v6X1jkip0SZiku0oYZsQjQF378GdAA
	GQ5Ab1IQx7jqVWpvXAZKvWy89wDABlvJiOW63r2Iv3JzOusd/GWzNHAMbyusTCmt
	bo+aUuJdQLO73qhYzcaWjcxDvMzKa/NUrji7ADsd6volTFtgx4x/ItK8wnApQCNB
	jwnQL/F6nLl90+PoAv2ACZDfVAYWeN3/Uk6MsOrlpk7+h1017D9pwOHb3k3U0YXl
	Z3oepfEqqNKrNMgRmyt+xNdY0O8s6dfgbEx4veC5b4qcUjqPQyUnxD+wfyHFiCqD
	c8dBv8wbcjVcgPI2LpLDy3qKReB7V+G0ej6d0aEAfmXUIn2cRE4WtGiTKo3ErMCC
	cHTk5AeVdoCyVefTdh6QyRyD07nVzth+Ec8gAyA+Qv5g2bkxylJ590jE23oKWaJf
	+VdeS3KtSi6m5qgg9Szt5fFt2liXG3lajITPkpE4Ze0RrOTu0PVmX7vYnVphubOA
	7xf0/FA21sKTjsMpFx8LKDAlBALen728XP7B2V4+Q/BQ/4qnQJi4VdSx6/X+E5nN
	6vUhTa4=
Message-ID: <adb2817f-3e87-447c-9ce1-ab3785c96e80@prolan.hu>
Date: Fri, 4 Oct 2024 18:06:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net: fec: make PPS channel configurable
To: Francesco Dolcini <francesco@dolcini.it>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Linux Team <linux-imx@nxp.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Frank Li" <Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>
References: <20241004152419.79465-1-francesco@dolcini.it>
 <20241004152419.79465-4-francesco@dolcini.it>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241004152419.79465-4-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855657165


On 2024. 10. 04. 17:24, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Depending on the SoC where the FEC is integrated into the PPS channel
> might be routed to different timer instances. Make this configurable
> from the devicetree.
> 
> When the related DT property is not present fallback to the previous
> default and use channel 0.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Rafael Beims <rafael.beims@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>


