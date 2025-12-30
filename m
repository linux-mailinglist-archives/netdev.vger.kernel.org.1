Return-Path: <netdev+bounces-246347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74320CE97FE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9E3301EC71
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E172DCBF8;
	Tue, 30 Dec 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="T2Sf4zWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78460222590;
	Tue, 30 Dec 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092691; cv=none; b=Ua8XiFcZYhRfQC8gaMlTmGkCmjsPD1ZQg1lInFfiCUmWZnfmGvpZocgX7Nyy5tJP6Hv2gfBgIQpXNYI/aQj7QiJmfkTw3R5O6iMoZzP6GGmhs377ujjG62pi6fT9wQcOVyOV/patkrraPmcCLPlrPgGzGlBGXAJDvb525f8up18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092691; c=relaxed/simple;
	bh=F0CydUX36atljRFcC0lk0ZP/JGD/uDK4RbtAqtC301g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzKkOgvOjg83vscff8RI1FcfiGmmiYflmpIfeivk2VcqZWf0oOMMlxOn4Rxh+lii8MfKVw4Ly95J41xJiVreyKSuTm2GWIpeHrL+oqrmEOoUcDhcmpyqYLfFRUytqtfN6OyL2uGrbZjSlVUcj9BIOg3KUGQc5LS5ISIvQ4jOsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=T2Sf4zWM; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f071aa9e;
	Tue, 30 Dec 2025 19:04:42 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: markus.elfring@web.de
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	johannes@sipsolutions.net,
	kernel-janitors@vger.kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
Date: Tue, 30 Dec 2025 11:04:41 +0000
Message-Id: <20251230110441.1205454-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a79bed83-8a43-4ed8-94d4-542b7285835e@web.de>
References: <a79bed83-8a43-4ed8-94d4-542b7285835e@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b6eee800f03a1kunmd5da7ee315bc2e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTxoYVkhKHUIYGENDGU9OSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=T2Sf4zWMEYerkfFCJzQcTmT2FCm2XpTB3p7eHKGnOkFO/8/V+RwpPzJAkQcHyqHSJnIRKtmvJgTlIeopSBRdDpVFItSXGaRtb4LOYyvCBtI49Ni1nz9bjGI8tGYnhfmJ9OC+KrofTPFEFMg+FippPxEFU8aUJCoCifu/Ri/QFzo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=7/RXZ93bmqyzIid2z4BLYpbdA6KQARRTDAWMUQSplSY=;
	h=date:mime-version:subject:message-id:from;

On Tue, Dec 30, 2025 at 10:42:22AM+0100, Markus Elfring wrote:
> Do you tend to interpret such information still as the beginning
> of the function implementation?
> ...
> Would the mentioned variable be relevant only for an additional if branch?

I prefer to strictly follow the existing coding style of the current file, 
where all local variables are declared at the top of the function. I do 
not wish to mix different declaration styles in this patch.

If you believe the file should be converted to C99 style, that would be 
better handled in a separate cleanup patch for the entire file, rather 
than mixing it into this bug fix.

Regards,
Zilin Guan

