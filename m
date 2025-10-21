Return-Path: <netdev+bounces-231422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D22BF92B0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF19318A4CF8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4E2690D1;
	Tue, 21 Oct 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+Z/ffp+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F7350A37;
	Tue, 21 Oct 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087744; cv=none; b=EJUt/U5tsypgizFz41ILx6Qex6hb6ZeiekURrnepIZB/HRG0uwfOZv3xdZkFMvggDRHK0Y8DqcHYF6md1dWSfAmWozB5goVnTwSy1VexW64a63gH/ZbTr3C4fk4mZ3aW29nGx52/sI0Er7Ch6y/L4m/YKyztv7xs5NzbQ0W9Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087744; c=relaxed/simple;
	bh=jebPbjme7P2kWR8ZBbngJLly0Zj7VzPVjORl20HOTyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFweYZhjCkAUEm9Tls52I59VSub2sQO+HDoP792I36ZhMqBfRqDlqoStKveuJFLcC70hPaa6yUW3vMohbklXDTsPex+RkKsSU6wRoV+yDbXbB/0lXeI0bVYLVlKPvo/vKXPLMeEIiDAUjb291Y77PFGZ3NEhVs1MdwwcZWtVyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+Z/ffp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD849C4CEF1;
	Tue, 21 Oct 2025 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761087743;
	bh=jebPbjme7P2kWR8ZBbngJLly0Zj7VzPVjORl20HOTyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+Z/ffp++yk1l4a4ImWFacO3Xbayi82Qa014hran1qQITfIuDpVRQHXPUH//jEK3O
	 Sp3sfTP6wr+Aq1Y1W+iTY7TZbNXdQXYG9LoZtDrQ9IR+/y0Il/eHNiT+l9EPyUYdxy
	 bTWaa0VSOGq7xbLOXAehLsVxJjpdLj6DF2ea17J0pknwn7+CX0FrpuMcDUgAWRL6th
	 2240836ngUv8ifxU/sqBRS23QAaocFlMDL9Hk80q3kleFhRCiz5XQXrXxWO2YPP7mM
	 n0v4HGJlMLWsFe+cNsQ8CwNcColVc8bCLgNmjYkH0fYa+V48CZoJUETSScLnKaFwGB
	 yC6c2+d6T9+zg==
Date: Tue, 21 Oct 2025 16:02:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251021160221.4021a302@kernel.org>
In-Reply-To: <911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
	<20251017182358.42f76387@kernel.org>
	<d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
	<20251020180309.5e283d90@kernel.org>
	<911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 10:02:01 +0200 Maxime Chevallier wrote:
> Let me know if you need more clarifications on this

The explanation was excellent, thank you. I wonder why it's designed
in such an odd way, instead of just having current_time with some
extra/fractional bits not visible in the timestamp. Sigh.

In any case, I don't feel strongly but it definitely seems to me like
the crucial distinction here is not the precision of the timestamp but
whether the user intends to dial the frequency.

