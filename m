Return-Path: <netdev+bounces-230050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C56BE3390
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9E1A64239
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA431AF2F;
	Thu, 16 Oct 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S/yKF7YM"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3452D2495;
	Thu, 16 Oct 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616305; cv=none; b=XT1scaBPVgN619PsebDDn9YUnEV18rm9Oux4jwpjYMuscrOao5usJL5xoHTU4nKyXnhhQuvdpjo9M4KS23s53IR/h3OV3k2SPgD/DzpwG7e86C7yjVtW/do3hwaD/IP6Z0wKQdWb3kO8hzDwghmGIUiFRwaWj64297OyMSDgBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616305; c=relaxed/simple;
	bh=r6wUi3xcLjSainNg2mWEJLiS/UtI/590E6KLLtoGu9I=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1ApuNAJVEqJEL+AICdkt01Z+KRvRfA4B//p5uejAO6YEt3jVOqBs4kJaU7c8/222Zf+ZON67YH+PUG9eNmHwyitYpdl+pcMYohJljaMdtfoNP611gxmgmeyQnxbusCsq2bwvH2YsFqi7BoC/AQyjgEq9fgnXqdD0RxJeKBtZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S/yKF7YM; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59GC4r752097423;
	Thu, 16 Oct 2025 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760616293;
	bh=iKKzurQ0ZXO5q18t5L5wXU2cS1JLQhkE6vGidqQGQvE=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=S/yKF7YMR4y3sz40L0oCv/9276eTWXAZlruX6A1fME/T0/m1t1T//RQS4OJ159xad
	 YOWYtS+JxicglGuPF1fAHB8sD257K1dGS+8vGhrjWDHit5r2gawZhew8DPNYBaz2Wv
	 JdAhwcBA1ZWss58cl/l4EauPEU1uUxOZz0wTeeI8=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59GC4rPL1187214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Oct 2025 07:04:53 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 07:04:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 07:04:53 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59GC4nM23691442;
	Thu, 16 Oct 2025 07:04:50 -0500
Message-ID: <809b0315205e08f3e490fd0fc6ba4496683b04b2.camel@ti.com>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: fix timestamp loss
 due to race conditions
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Aksh Garg <a-garg7@ti.com>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <danishanwar@ti.com>,
        <s-vadapalli@ti.com>
Date: Thu, 16 Oct 2025 17:34:56 +0530
In-Reply-To: <20251016115755.1123646-1-a-garg7@ti.com>
References: <20251016115755.1123646-1-a-garg7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, 2025-10-16 at 17:27 +0530, Aksh Garg wrote:
> Resolve race conditions in timestamp events list handling between TX
> and RX paths causing missed timestamps.
>=20
> The current implementation uses a single events list for both TX and RX
> timestamps. The am65_cpts_find_ts() function acquires the lock,
> splices all events (TX as well as RX events) to a temporary list,
> and releases the lock. This function performs matching of timestamps
> for TX packets only. Before it acquires the lock again to put the
> non-TX events back to the main events list, a concurrent RX
> processing thread could acquire the lock (as observed in practice),
> find an empty events list, and fail to attach timestamp to it,=20
> even though a relevant event exists in the spliced list which is yet to
> be restored to the main list.
>=20
> Fix this by creating separate events lists to handle TX and RX
> timestamps independently.
>=20
> Fixes: c459f606f66df ("net: ethernet: ti: am65-cpts: Enable RX HW timesta=
mp for PTP packets using CPTS FIFO")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>=20
> Link to v1:
> https://lore.kernel.org/all/20251010150821.838902-1-a-garg7@ti.com/
>=20
> Changes from v1 to v2:
> - Created a helper function am65_cpts_purge_event_list() to avoid
>   code duplication
> - Removed RX timestamp lookup optimization from am65_cpts_find_rx_ts(),=
=20
>   which will be handled in a separate patch series
> - Fixed function name: am65_cpts_cpts_purge_events() to=20
>   am65_cpts_purge_events()
>  =20
>  drivers/net/ethernet/ti/am65-cpts.c | 63 ++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 20 deletions(-)

Thank you for fixing the issue.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

