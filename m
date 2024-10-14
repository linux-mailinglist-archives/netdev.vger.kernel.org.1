Return-Path: <netdev+bounces-135101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F899C404
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980E2B243B8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E91531E1;
	Mon, 14 Oct 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWo5zf1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A121514EE;
	Mon, 14 Oct 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895888; cv=none; b=dSuqMlFTXOde6ArklOY1KGItsbSlopJ29vtkJT+SrtEqAjK7c0zp3Jhm6pFwCdKKheNyRNSNljlKvedk4EOfABen3hJHUIdThJE0+xc6Y5mY+ioD2Gm9r/mp7l3HtjlMAAkj2qVzDB5VTKE90CEpYdHGiR45Ixr7+Qg8oBt883k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895888; c=relaxed/simple;
	bh=HlYKvFyTI+h9yfs5jdeGzQdG/BYt6ViKVZgJ3ftC7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9lvWSQd00fZvvQFyQ4P4fjqQi8tZnx1gGMhPz5Bi5loAXUyGqmhcmeq9MUAHZc9eTZCrw77HEByADAKZ2zSxq/baq5nRxfeHyA0jNS0mQlHSEeotLgWnGHi8Bd6f8u4rUKOzri/pjR/T9zDqFBkEH5+eLZeYtuEG1Pd+Sk769A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWo5zf1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3705C4CEC3;
	Mon, 14 Oct 2024 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728895887;
	bh=HlYKvFyTI+h9yfs5jdeGzQdG/BYt6ViKVZgJ3ftC7yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWo5zf1RYDeR5/6QMU2aPVhosbME/qwKL2vNGtLRlYt0TWyhY9OO2Yj8/BkJGPRtB
	 va+roREyhtt6b6wVu2BtBZrfh9JDZlrP3py/H+QW0wtsEYpO7UpLNILZQkqtt/aw5i
	 zy0uV5CPQbd/3/lTW2O0808zKtA2iSSUYlZ91KXb4NcMC20exHBUlmu/Ubcuq+03+M
	 JThqHyjqMfd3gdv4pMQQ70MlmdINVIYYqEH2c3++6deAuIzupc9+Z0bFrF/5mZ0sLz
	 CLhPgGbn478N8Jb8nSiM14ZlQirTcvDY6/4Ai4WG0xbTH645eaBltR5JtgCgAG6K7T
	 lsRhCFNSFA2rg==
Date: Mon, 14 Oct 2024 09:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v1 net-next] net: ethernet: mtk_ppe_offload: Allow
 QinQ
Message-ID: <20241014085122.GN77519@kernel.org>
References: <20241013185056.4077-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013185056.4077-1-ericwouds@gmail.com>

On Sun, Oct 13, 2024 at 08:50:56PM +0200, Eric Woudstra wrote:
> mtk_foe_entry_set_vlan() in mtk_ppe.c already seems to support
> double vlan tagging, but mtk_flow_offload_replace() in
> mtk_ppe_offload.c only allows for 1 vlan tag, optionally in
> combination with pppoe and dsa tags.
> 
> This patch adds QinQ support to mtk_flow_offload_replace().
> 
> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
> of PPPoE and Q-in-Q is not allowed.
> 
> As I do not have any documentation of the ppe hardware, I do not
> know if there is any other reason to not implement Q-in-Q in
> mtk_flow_offload_replace().
> 
> Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Hi Eric,

I see that this patch supports up to two VLANs, both with EtherType 0x8100.
And assuming that is supported by the hardware, that seems fine to me.

But I winder if you know if this hardware supports other VLAN EtherTypes,
such as  0x88a8 which is described in 802.1ad?

...

