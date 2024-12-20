Return-Path: <netdev+bounces-153743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649059F986C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E485E7A3F6F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8921C185;
	Fri, 20 Dec 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptLZbOdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF521C175;
	Fri, 20 Dec 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715167; cv=none; b=ns/9nIJvlD3poCncj+boyIq3tFAfX+6KjIwSWKaT/G6IWVCA7NX3sAOyPmki3rT/00CWw7dxT3Ufkq8BPhJkj1/haUE3KqsiD9F4ppE1R6dKGD2qFlDt4vugT9t9fnJFBUk9dW+8OWpVS528ZyuFYQOB5hq5Vr+EuLknkUHbVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715167; c=relaxed/simple;
	bh=FUIqa+Gitn30dawnqBvseQbi6wEPRxT9Aw0rFXxUhzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDwNhBfYY6sWRPPYk/LFmmz8NhgjHJYPlzApF4S9x8XcEeOoz7/e3Tx1B3D7vgo7mkzHkAXmbiEBE4eoLonow960RrOsSqX/5MRq/xlaFQAKKIktgS6hw43s/12+RNYPN82miVGtCxZGA2F9kPxt5hp30mHdCbSfxAgjAHv2CQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptLZbOdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491CC4CECD;
	Fri, 20 Dec 2024 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734715166;
	bh=FUIqa+Gitn30dawnqBvseQbi6wEPRxT9Aw0rFXxUhzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ptLZbOdk4hkPS7sLJGgNDzID6wVCo/WUmov2dWeJwFeW1b54vCS8XTfK3IUCres8I
	 vC21u/08rQ0XHBDtkzTHB7pAZoI14szwxeY+hq2ypcVwcxUnEdpKmc6mFD0zdTg+yv
	 ViEkipvCrPkIy+w89dQFFR6HVAJHjuvr4EjuudrUazMFNEir+Dz8iXhthtISGTLxGO
	 qd0gjTFmgibNOVSUldAo/SeEcasfylKAR+DEP2gZATvyqz6Jm7Xqbp5WtsnN57WlMG
	 3pxfl4/Aa1Qh3DgqWxHze/kBTsLDgw6o3q5TLObYWB5IdlZ0qFwXyVTXkHAQuCoDA6
	 zai2Huh/QaVgw==
Date: Fri, 20 Dec 2024 09:19:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@collabora.com>
Cc: patchwork-bot+netdevbpf@kernel.org,
	"=?UTF-8?B?TsOtY29sYXM=?= F. R. A.  Prado" <"nfraprado@collabora.com"@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,>,
	""@codeaurora.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, bartosz.golaszewski@linaro.org,
	ahalaney@redhat.com, horms@kernel.org, kernel@collabora.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 0/2] net: stmmac: dwmac-mediatek: Fix inverted logic
 for mediatek,mac-wol
Message-ID: <20241220091924.6be11286@kernel.org>
In-Reply-To: <876cf020-e2ba-46a7-b9b2-82dcd47f7a04@notapiano>
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
	<173155682775.1476954.16636894744432122406.git-patchwork-notify@kernel.org>
	<876cf020-e2ba-46a7-b9b2-82dcd47f7a04@notapiano>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2024 13:09:45 -0300 N=C3=ADcolas F. R. A. Prado wrote:
> This message implies patch 2 was also applied, but I only see patch 1, no=
t patch
> 2 there:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/log/?qt=3D=
grep&q=3Dmac-wol
>=20
> So I just wanted to confirm whether it was applied or not. It would be fi=
ne for
> patch 2 to be merged through the mediatek tree as is usual if you haven't
> already taken it.

Yes, the DTS patch needs to go via the appropriate platform tree.
Sorry for not calling it out.

