Return-Path: <netdev+bounces-165336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A8A31AD7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653C51888DBB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90799F9D6;
	Wed, 12 Feb 2025 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUB7Aohh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691182C187;
	Wed, 12 Feb 2025 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321489; cv=none; b=Rs9VHqGTCf5tQMkBtK13IFyllCjusBU4eZvmbDoGZFf2kR2WtVICcrh1+hRzUZG0ORct6ZIOitDiSL0Z1KYLLvyhLcbJ2H5PEhYMLmum0bAXlySR2b4mq7HwI/oxrBQRxTFvnythHGbF/kMGkYkxniGToymTFxJaYj7me/ocS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321489; c=relaxed/simple;
	bh=VeoIbDzVqmui1/kOCFxZmx+bZMjORYTB/ZUjr6uj000=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgduTz97gZQMawolmL9qz04xEHNJUtfUT9PB9lKkva4PRSf+pwl8cWkKbBiLVCzVA4nJB4ACMD0XahpgfkQDst0DjkOOXHjed/8h6a+lqFfrwwXJxmED7li2OZsfb+5k0shnDIG1LbEr2/YOL2HUJNHIB/7IPFpznF4EHeujz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUB7Aohh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CB6C4CEDD;
	Wed, 12 Feb 2025 00:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739321488;
	bh=VeoIbDzVqmui1/kOCFxZmx+bZMjORYTB/ZUjr6uj000=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JUB7Aohh8OSwM4X4zNkrv438iwEU1mi2ELXa0huB/spNm8QxIkJp3gKXh0SGbCK8h
	 2MHgJtvccSGNKvEdwMdeJHa9UBflrJt7K1rorXUNEe+y0wWJQ7CO0s6ZAurel3SV2V
	 SqG7/ik9FaPMIpafcWwSrHmiNamvEOotmY3eF5EVTOHRXpamxVfz6JvY/CiRvAEtW+
	 6SEHhXuKpAmIpaHuk+WAxeFU0rkXGmCv77SX3z5sCOz49r5+YZ7FQoQjI02KHgQ2Gi
	 uQ41LPAefhAU/j+M69sGd40dgFI0BjkARyN126PM0Lxp5Oij3ZQaOCk+Lo7CC+Yhz1
	 i2i1c16fgfoVA==
Date: Tue, 11 Feb 2025 16:51:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "Frank Wunderlich"
 <frank-w@public-files.de>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Message-ID: <20250211165127.3282acb0@kernel.org>
In-Reply-To: <20250209110936.241487-1-ericwouds@gmail.com>
References: <20250209110936.241487-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Feb 2025 12:09:36 +0100 Eric Woudstra wrote:
> This patch adds QinQ support to mtk_flow_offload_replace().
> 
> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
> of PPPoE and Q-in-Q is not allowed.

AFAIU the standard asks for outer tag in Q-in-Q to be ETH_P_8021AD,
but you still check:

> 			    act->vlan.proto != htons(ETH_P_8021Q))
> 				return -EOPNOTSUPP;

If this is a HW limitation I think you should document that more
clearly in the commit message. If you can fix it, I think you should..
-- 
pw-bot: cr

