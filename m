Return-Path: <netdev+bounces-87428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D88A3197
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95630283EA9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6C1465BD;
	Fri, 12 Apr 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE4j/rDt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB21465A5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933656; cv=none; b=YssKptWuRPCOjq44xojVOHwsxPhVoD7dpZwbb3zC7xZhBPtelvEIfsZ4b8iNPnEze73Fduhcbq+JqQvomq53iCl6UkwheLaqbq1mmrVlEmROuMHG8OloErufb8WQ+/0ykc985v6vJjlnyFH/d1FyP+NA1sFkovgSzY2OsE3WYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933656; c=relaxed/simple;
	bh=fE6GJCaL1Z+SA9wmZ/6YIs0xrdm1oYZQE3iRw9EwLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFG12GXvtBH7cyJcc2/AbIVmTkWD2z5cIfI+5k7prLytlcCb93zAHGfezo28n6aHZSo1jY8DkaVM5mrUdaQYaK3MFfuw4Grh4NAddicvOhAmJQf18mhxsKrKoa25smDcMuz5m3fkEk6aVBmYNbRVVZh8RxlQRoX6Eqkq0HAkpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE4j/rDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F33C32781;
	Fri, 12 Apr 2024 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933656;
	bh=fE6GJCaL1Z+SA9wmZ/6YIs0xrdm1oYZQE3iRw9EwLbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OE4j/rDt7T5tJt1WnCMDsix7rqq/qY1f5n0HbAiExJdfDKOxYuRW+ERDSews7Jjxb
	 mE6pals/XlvcgFsZsBjrGlkTDLo4nI76s74wGEDYMdxW+atX63bjZYCWBrG8sA3ehv
	 wQ8k7F/AdsVkeqWmUHPJKp/8buziwATP+vpYlRDD2lmPz3bBkJnilJIkwPtu6bXV++
	 YUx2DaM68JLgKm82USS83Eq8fjDrHXcYL+lhdZF3+KwGLcBI8k4EXocHAYStwgdKa9
	 augSZhPiAK3RqiJcJiR5W8HFgGyk46zlhmjegkcgxD6GqJCm15tO9eNcE358SGy3QH
	 EuMHaWrPoJOuA==
Date: Fri, 12 Apr 2024 07:54:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ks8851: Handle softirqs at the end of
 IRQ thread to fix hang
Message-ID: <20240412075414.4509b75c@kernel.org>
In-Reply-To: <20240412075220.17943537@kernel.org>
References: <20240405203204.82062-1-marex@denx.de>
	<20240405203204.82062-2-marex@denx.de>
	<ZhQEqizpGMrxe_wT@smile.fi.intel.com>
	<a8e28385-5b92-4149-be0c-cfce6394fbc2@denx.de>
	<20240412075220.17943537@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 07:52:20 -0700 Jakub Kicinski wrote:
> In general, yes, trimming the bottom of the stack is good hygiene.

That sentence puts the words "bottom" and "hygiene" uncomfortably close
together. Oh, well, it's Friday..

