Return-Path: <netdev+bounces-74226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF648608B0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D061F24A5F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19EBA5F;
	Fri, 23 Feb 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pc6wQcWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5098B67A;
	Fri, 23 Feb 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708654132; cv=none; b=GQXNM7VsbTzdzsHk+F7CBCtTEjSuqIDcAt1Q4zoZy32yY9xQPrF6K3yEotMnY1WeoCL3V4X7+fG6nas7toeVdSeQMEWpsDlSGYTCme346ezyyhoWpUuaLWMBKVLUt8Ak9tMjpWrLzMwfmcxgYQaI6AyVDvljsKd+RcbsGcjvpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708654132; c=relaxed/simple;
	bh=ZMkOBjon0zabIVHymipUw7nZW87QH+RIQGogdjEOVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avMcl1u4So5vnk5rgKlue5DWme7W1of6Nu7Vaeda8GmHfCCEnrERUVJ1FVYbi08qtnE9Qyt50tEaRjMHakQXuQZuC7B0PS9qGLdJVl+3/yJyjv0VcZGqKpYduVL0DxGmNHhn8hFBtEsYeQBofaG4IThp8SU0S17O87hO9SBJOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pc6wQcWD; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=lCE9TnObaj9CSGcGHs9TSjrZX9bW094ZFtuDVElRcVg=;
	b=pc6wQcWDigcnsqIJFEhtNoozHHMXPVOdQ9QGTxZKVuJ/+cl3LAWv8I/78CXOqM
	eYRGgx06AHlQE3Ed6kk/2MSw3jCupZWDo/E5dqrsXZTqamzd7dZvUSr/WWsWiE1F
	VSWTtOzX9sBEjDRmM0EOCXjwMMg6mEjuRKjxQKXDTFn3I=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADHrojr_ddlCaQsBA--.4847S3;
	Fri, 23 Feb 2024 10:07:40 +0800 (CST)
Date: Fri, 23 Feb 2024 10:07:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Message-ID: <Zdf96y7q4298dkmG@dragon>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240202110511.135d26b7@kernel.org>
 <ZcIPCxgO3Gxc/aXh@dragon>
 <20240206074151.577d33f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206074151.577d33f1@kernel.org>
X-CM-TRANSID:C1UQrADHrojr_ddlCaQsBA--.4847S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcjg4DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQyNZV6Nm5-2UQAAsB

On Tue, Feb 06, 2024 at 07:41:51AM -0800, Jakub Kicinski wrote:
> On Tue, 6 Feb 2024 18:50:51 +0800 Shawn Guo wrote:
> > > Any preference on whether all these go via a platform tree,
> > > or should we pick up the net patch to netdev? I guess taking
> > > the DTB via netdev would be the usual way to handle this?  
> > 
> > No, it's not.  Taking DTS changes through arch/platform tree is the
> > usual way.
> 
> I said DTB.

If the DTB here means Device Tree Blob which is generated by DTC (Device
Tree Compiler) taking DTS (Device Tree Source) as input, it's a build
result and so neither of us could take.

Shawn


