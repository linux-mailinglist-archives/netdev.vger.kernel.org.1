Return-Path: <netdev+bounces-94375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF278BF4A3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CED11C212B1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825EEAD0;
	Wed,  8 May 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIDOKnkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452D14A90;
	Wed,  8 May 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135890; cv=none; b=tuy3QlRrQzOnlGY2SXwwulbgL/F8BEpP6aewyS7g6IbjP+6zkO1RknNA3imhI+91vNfYGhZ4bnS2u/doDRtHKbOlYlEpcVc0cxD3501zFSPkf+n5hF9MIRJeAuibcCVP5T5iAOd2LLJA69LBrT8fzxmkD/tyOdw779RzPBkXXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135890; c=relaxed/simple;
	bh=dsBL6HgegF48D35JstK0cIlIlZdFApTieo0cYPVr5Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX5jDdVXgUmbkezxMrPQwX9Je6XEF8s90akLuuZCIL2/uLLxYGlpzEeIwbeKi6FajbnxAw2Mhaod4u1Gijf0oEFRtbDaDX4NfFtnvBkpNlVAK2AlrQn8J0cUSm4jOFbq0EMOMZaJTa8zJJEhvwmRiEX4+ZG/I3MojC0YB+8V9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIDOKnkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0ABC2BBFC;
	Wed,  8 May 2024 02:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135890;
	bh=dsBL6HgegF48D35JstK0cIlIlZdFApTieo0cYPVr5Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HIDOKnkJrbXtr5wXd5qa/3nTHY8MTVQaCBT47zw2bi1QGaHwkpkW+xVOzUHgkFhnb
	 5aOtKLnMFQy02o2kFA/0daAvjMhFNghFtH3dVhfgsPHAfZjBk+HEakb4xPAkiPvfaF
	 kfYcwGMdQRgr0ptNia/iVPZj+Qvd2RBlsT3X3EYE1ClGMXj6MIqiY5Biv3ht8WyyLb
	 ru8joIQlImeO1TwjC6gmVd8YjxDWF5OJe1PWHJ4FoTu986bXv2Ijw6BJet5dasYJ1q
	 4/YNwI1d/88AXFBwH8g0u2s6BciUoJ4Lv3D4+FKY+dulaYObF0GkhXqtsLENZ2mfiH
	 rK2wnuyAcqz1g==
Date: Tue, 7 May 2024 19:38:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: ethernet: mediatek: split tx and rx
 fields in mtk_soc_data struct
Message-ID: <20240507193808.36a2ba37@kernel.org>
In-Reply-To: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
References: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 13:24:28 +0100 Daniel Golle wrote:
> Subject: [PATCH net v2 2/2] net: ethernet: mediatek: use ADMAv1 instead of ADMAv2.0 on
>  MT7981 and MT7986

Please repost without the second patch inline after the first :)

