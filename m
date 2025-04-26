Return-Path: <netdev+bounces-186212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C365A9D731
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944189C86E9
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A41F12F2;
	Sat, 26 Apr 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihFHd1dp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CF10F9;
	Sat, 26 Apr 2025 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633595; cv=none; b=lmhUrwIeBzkUTLhryAO3xm1eoSI4U2JCdnlXSV9/wKp+J6nTPRwJwwn46xTsglifu3FnN+3NkMBdzhr1Pv9YBt7qn/fTPWPIuDS/tHmrzM+mqfTEr4WSx6z3WBp5biesHwZJNJMURvFjKZXFhx60pMduAiKhs86UuFWRHUUJ5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633595; c=relaxed/simple;
	bh=CZWHyrSRI9rXVWjIfZhJMz/8qMBovApYmofIr02qYqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qz+gdJZqcW/ZBfxGcHkDk+vygfm0VyCnBB2VIJHaRenr6jKM5b9HYLIdyLstwgLJHJk7CRBtCz0rgq9Vot1uUtTQB/jcl+rDDoEvwJCF8llAPoIkVsw5+uA8xwYMSTXS4kIq+olVK5S2+fPnPwUd7HIOG9MpGV4VA7aCV8kq28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihFHd1dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1667AC4CEE4;
	Sat, 26 Apr 2025 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745633594;
	bh=CZWHyrSRI9rXVWjIfZhJMz/8qMBovApYmofIr02qYqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihFHd1dpkRKkjIbze4T1hv+T18Nf9KFeghaGyUMZCpU7f7WKRL6++Fig2DqIke+bG
	 LujSGPHQiWXmVCH3ySideOWtYonDKfE7bfckOZPVoKofWqZizYhpKDxPimyXDSO986
	 ACyfYdbA2LoD2qiLEp2AEGse5ZNuT2ozeCrpBB7F7idY7PLeRX11aAcQtBC/9vucuS
	 kWQqJpTCDBzvleYUdng9gDyEYqHhno8BXg6erh3y+qS0XGOsxvzUR2t5jQ4vcJ90yX
	 QnpeEqBY/CkdgFgkTR8op9wItIWHU+9sfsjAMulC8MRmTbxLY1SexJi020RkHjPWMC
	 iqU08BtkrtplA==
Date: Fri, 25 Apr 2025 19:13:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Felix Fietkau
 <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao
 Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, kernel@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/2] net: ethernet: mtk-star-emac: rearm
 interrupts in rx_poll only when advised
Message-ID: <20250425191313.3692348b@kernel.org>
In-Reply-To: <20250424111623.706c1acc@device-40.home>
References: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
	<20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-2-f3fde2e529d8@collabora.com>
	<20250424111623.706c1acc@device-40.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 11:16:23 +0200 Maxime Chevallier wrote:
> > In mtk_star_rx_poll function, on event processing completion, the
> > mtk_star_emac driver calls napi_complete_done but ignores its return
> > code and enable RX DMA interrupts inconditionally. This return code
> > gives the info if a device should avoid rearming its interrupts or not,
> > so fix this behaviour by taking it into account.
> > 
> > Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> > Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>  
> 
> I'm unsure wether this counts as a bugfix, as no bug was
> seen, and there are quite a few divers that already ignore the return
> from napi_complete_done().
> 
> I don't think the patch is wrong, but maybe it should be sent to
> net-next :/

Agreed, probably the only case where it would matter would be busy
polling. But it's trivial and looks correct, so probably not worth 
the respin

