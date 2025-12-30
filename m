Return-Path: <netdev+bounces-246310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1899CE9332
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E812300E7A7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8462836B1;
	Tue, 30 Dec 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LUB97ugr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECA23EAA3;
	Tue, 30 Dec 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086742; cv=none; b=Gg8EqAAlFLK/y0CePKCKe5iUJb18CdugejoNiY2TeXtwbCEsyxW3HoKqXPRx3QID6Sy6CzgA59neMfAlPUdGE4UwdtqgugaRJodAb0gPc8/A9y3+U/6SEheOKr0QkEL1vHGYUvh4cIgCGH7H3ZWVxGnjEdU3y+LZFx5KZ7fOApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086742; c=relaxed/simple;
	bh=lBUfAe2VVwbvu6C16BoOenshFGHw0UHedNpdgIQN2Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVrY3PPp03k5lECzamqdezNbJcPNPuyK3G54ZsT9vKCss4PyCeujjP0gCZFZrpU4M31o+Yazd+dH6vtDYGNK8oljWlL5uohCM9BrX9gyfd/ysbpOv8rZq4vbH1IKW3hcVkId7bE/RFdb8SLOSovcHruw+3ZAaK4Z6l+jM2fcjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LUB97ugr; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f04a4f98;
	Tue, 30 Dec 2025 17:25:33 +0800 (GMT+08:00)
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
Date: Tue, 30 Dec 2025 09:25:32 +0000
Message-Id: <20251230092532.1145752-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2835cc53-326d-41d4-9ca5-1558c0ccbbaa@web.de>
References: <2835cc53-326d-41d4-9ca5-1558c0ccbbaa@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b6e93b7ef03a1kunmb572493d1570f7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTBodVkNJQhlNThoeTEtDGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=LUB97ugrSbG2dYy7slsaIRLk11MLVNnllH8qS03mYK7htX5/pceUGOOjObkD2yv0RvdEH/Yt7ltomqFUDyrABtZk++9a0FuDvP0VvOLHj7Wg0onuvqkW5qU3oDzVscyyPZhFYDMYe3/n5ihEp8elgwpPC7B/mfbKO59LhJDUjgU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2RqaemvHqIMoWJBM34rF5+MolasJKwo8U93muvRBZaY=;
	h=date:mime-version:subject:message-id:from;

On Tue, Dec 30, 2025 at 10:15:05AM+0100, Markus Elfring wrote:
> …
> > +++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
> > @@ -456,6 +456,7 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
> >  	struct sk_buff_head *free_list;
> >  	union mux_msg mux_msg;
> >  	struct sk_buff *skb;
> > +	int i;
> …
> 
> May this variable be defined in the loop header instead?
> 
> Regards,
> Markus

Thanks for the suggestion.

I would prefer to keep the declaration at the top of the block to maintain 
consistency with the existing coding style of this function and to keep 
the patch focused strictly on the fix.

Regards,
Zilin Guan

