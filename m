Return-Path: <netdev+bounces-101237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672228FDCEB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A597E284C28
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286611BDD5;
	Thu,  6 Jun 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQAT13a6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC71BC4B;
	Thu,  6 Jun 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641788; cv=none; b=e6vf442TLw1JZOKAU36QAbYw+C5K/S4i6x26PirUc3hAWedJ5VUBDW02unwJQjTkSlJ6pqp3eAi8sapf83L4XRTEF/l22St+9gbYompS6BiZ5S7laIyCeLBBK4dFdtPI/qI1RpjwCzgwPdqAJcgjEG9lJRodKGuD1uA/v/xfZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641788; c=relaxed/simple;
	bh=NdLs97+ZjaEORCCIcuQq9rHIORg2yS+bwbRGKnoymKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjKij4twlquIy5AQ9B4O8ZN4wGomum7dAkvPTsLrSIbQLFu9ivmF0BWOW0r2jtft04n0oV+5zG48h+sQNjkP4xW/hZ0I5F8HgYLR8BQjeodnDaNo5YMQ7JuE8ptybbkAjFhh/0Li32BsIRN7n81aNwvSv7R29rMys7lVoNmjqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQAT13a6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB7C3277B;
	Thu,  6 Jun 2024 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641787;
	bh=NdLs97+ZjaEORCCIcuQq9rHIORg2yS+bwbRGKnoymKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQAT13a6ueu56deIrs4ByfqUJjpP5YCQBI/8Ih/Oa2fMwVQUYUfXQxDt8mVTbn9IJ
	 pl2uK3hFfIzpwa1IcL/VNGhpue8pG06ve1T93QO97++9WNlo1VOaZ8LVb3Dhs6aW8n
	 3K/ZuyxzXkw4RcaByMECjN3Oe+/U0Z6xCxgLrgzzhIY0gz0RDBu15Sd4gdHdVAvvvE
	 6NkPetdZEC2OPivdSUWG6+cPjv7UPZP7cePv9xbOENj+Pno9VxnbDZRljvM/kOGyup
	 HLfVrLzJCVd/DjiL6h0y3buRJ9dDkKOvZDYfsQ2GZ1q7CiRz8gvgJsP5Gttrp9H4gG
	 BAMSQ3Ncd60+w==
Date: Wed, 5 Jun 2024 19:43:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v5] net: ethernet: mtk_eth_soc: ppe: add
 support for multiple PPEs
Message-ID: <20240605194305.194286d8@kernel.org>
In-Reply-To: <20240602173247.12651-1-eladwf@gmail.com>
References: <20240602173247.12651-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Jun 2024 20:32:40 +0300 Elad Yifee wrote:
>  struct mtk_mac {
>  	int				id;
> +	u8				ppe_idx;

I thought Daniel's suggestion was to remove this field.
I don't see your rebuke to that point or how it's addressed in the code.
Also it would be good if you CCed Daniel, always CC people who gave you
feedback.

