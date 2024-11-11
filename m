Return-Path: <netdev+bounces-143707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F289C3BD1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A5D1C21B0F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E717838C;
	Mon, 11 Nov 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rIuqH2vA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54B15C15F;
	Mon, 11 Nov 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320757; cv=none; b=kO7YMyQlLn/0TIG5VpllbtxvUgXm7ENGmcO24L9BlvBLcZ6s04LDDbsPnhtcR081QUfT6u77afzJ6H2v6cFnSos/fuxSCPstIxpr3uJ4m6Z36sYAZk3cyy0Muhm0P3Nda/rawdoBH3qSd/cWpeDFSkuxI2ceIHTav0Fi4KC/0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320757; c=relaxed/simple;
	bh=Hfjqn7SDOIyQITK6gpOpUjN15fT1QwZHztZC4zX812A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YubwZPjh6tzYxNiU3oNgUP6tiBgiJuk7MRJHh5HrXsGooATHr1WQGRqKTrKTyQOmXLljpNaRdx4gi0foLcm1BxKb7ntVk0dWvJQDsKeUP9zkVkqgizZn5DAiwp125K5AgXa5Y/uRZFd6lH5MEXDzonzrXU0LDDOESwHK1tv3gHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rIuqH2vA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1670440B2295;
	Mon, 11 Nov 2024 10:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1670440B2295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731320746;
	bh=Hfjqn7SDOIyQITK6gpOpUjN15fT1QwZHztZC4zX812A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIuqH2vAytZns3wNa36rXMzC4BLTmXefN/cD3DYvYqdxnQr0BkkQ8PSw5RUy2qpVM
	 fveb3CnNu3Gtzxko9BHvXbDd+BhzGR2K1ZoHJdKRTeOGfC/SXCeqmxQW/YTWM4CEgG
	 WxzkJ7N8eNqCrcdopvi/jDySjA0HuDoQQE5L90ec=
Date: Mon, 11 Nov 2024 13:25:42 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Vitalii Mordan <mordan@ispras.ru>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of
 tx_clk handling routines
Message-ID: <20241111-def1390bf54ce26f76be250c-pchelkin@ispras.ru>
References: <20241108173334.2973603-1-mordan@ispras.ru>
 <e1b263d8-adc0-455b-adf1-9247fae1b320@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b263d8-adc0-455b-adf1-9247fae1b320@stanley.mountain>

Hi,

On Mon, 11. Nov 12:39, Dan Carpenter wrote:
> smatch warnings:
> drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c:163 intel_eth_plat_probe() error: we previously assumed 'dwmac->data' could be null (see line 101)

There is a patch [1] targeted at net-next tree which removes the check. I
think there should be v2 posted soon.

As it's not the first time Smatch is pointing at this issue [2], is there
something to improve? I mean, posting the patches in form of a series or
explaining in commit message that the check is redundant and is a subject
for removal? Adding new redundant checks for the fix-patch would not be
good..

What would be the most appropriate way?

[1]: https://lore.kernel.org/netdev/20240930183926.2112546-1-mordan@ispras.ru/
[2]: https://lore.kernel.org/netdev/20241003111811.GJ1310185@kernel.org/

--
Thanks,
Fedor

