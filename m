Return-Path: <netdev+bounces-250957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEDD39D47
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F463006A62
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51A32ED46;
	Mon, 19 Jan 2026 03:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B81E32CF;
	Mon, 19 Jan 2026 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794919; cv=none; b=jHY7Vjt9zhBAey+rlTndVlxoCyGp7LIvm1G539JrQwrq5e0AQwK+043EGNMDrdiywUoxVv4ltqS4XmmkWk8f4+7kYOylu0kRkrf+Gg8hcmwm61CoDc/xVv+Hb1DqmHqjdHId147I4uWkuHeEloBb7UUi1lyyNtBW+VL0Uc/dUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794919; c=relaxed/simple;
	bh=tgEgiYuM4Qx4be30r2DC8VwO76uF9uH214V+EB39PaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKd8NqA3wyO/DQQM7IDG/TfeqJ8XNIBSreMv3pdvrAyy981PYi+a2BOBovhR6q6xAa9wiiPtp8lRuLIWkukyYyWgzIXDeh6R6Y3YAn6rfMtuNGGq8oaMIOSZs7rjrvNcfh8O6fEBY76FHtZ3OdhErrYqhmJavNGKJlo+AhLuNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.20.68] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowACXtt0Eq21pmqS5BQ--.52891S2;
	Mon, 19 Jan 2026 11:54:45 +0800 (CST)
Message-ID: <e3890633-351d-401d-abb1-5b2625c2213b@iscas.ac.cn>
Date: Mon, 19 Jan 2026 11:54:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: spacemit: Check netif_carrier_ok when reading
 stats
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yixun Lan <dlan@gentoo.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 netdev@vger.kernel.org
References: <20260118100000.224793-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260118100000.224793-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowACXtt0Eq21pmqS5BQ--.52891S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY67k0a2IF6FyUM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
	6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF
	7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43Mx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fwIDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Cunkun Pan:

On 1/18/26 18:00, Chukun Pan wrote:
> Currently, when the interface is not linked up, reading the interface
> stats will print several timeout logs. Add a netif_carrier_ok check to
> the emac_stats_update function to avoid this situation:

I am unable to reproduce this problem.

Can you elaborate on what you mean by "not linked up"? I couldn't
reproduce this on an unconnected interface.

I would also appreciate more information on this in general - full
kernel logs, hardware information (which board, what you were doing with
cables, etc...)

Thanks,
Vivian "dramforever" Wang


