Return-Path: <netdev+bounces-250692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74503D38D28
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 09:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E450D30060E5
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6830AAA9;
	Sat, 17 Jan 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="MsacfGes"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781ED32A3C5
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768636800; cv=none; b=lDfJuHVwfuVWUUMZfNnUECFo9lHnzQ1FiWZu1RMlDaQt4HXLR4Ivhfc9py9XHeXQ+IHu0MP6ogxPpS5U0wCJP8SLPJhocMTJTyAZAyIFnbn5XYELxSE0lu2xZ9dCW/pT7cOtDCbkXBoLks/DnwWpHO/Z6Sqj/ijzYN9ypBNGBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768636800; c=relaxed/simple;
	bh=kiy7jjnwu41yVzlHymSVTjyCswIwRjtWFH4Lz2ixVhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAbkf0uJJdmE6svKLY1pnUy3AGVl45LfYjXnWAu5X0xB3Z3NvMbFhCK2vJAZPUJ+cNVwG5RPdKKyjfantLdEwnOPVCTdUmNqHE2kdVBOzpUoADbMbKSv0PLjXQfb2Tz4vLjb48fyUhEJK7ym8cOGRY15KvCz5tq4djDjk4t97rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=MsacfGes; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768636780; x=2632550380;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kiy7jjnwu41yVzlHymSVTjyCswIwRjtWFH4Lz2ixVhM=;
	b=MsacfGeswgrQY6iSTOWPcAkdP80isLgr3FUhztPJjrV5IXyvuZYZytocdigzWA7O
	cHyx6ATaXoHKEdNcqNAc+OKwf0m7FM7TpN0yOKTuxvYy1pYFtTjsghR5ZtA469Ip
	iyfL83/bQM+6el7RAImcRjhCSmli53q+h2zTXATeiZI=;
X-AuditID: 0a0901b2-df5da70000001406-19-696b416ca045
Received: from mailgw03.horizon.ai ( [10.69.1.10])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id 9E.27.05126.C614B696; Sat, 17 Jan 2026 15:59:40 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange003.hobot.cc (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Sat, 17 Jan 2026
 15:59:38 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <linux@armlinux.org.uk>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>,
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tao03.wang@horizon.auto>
Subject: Re: [PATCH net v3] net: stmmac: fix transmit queue timed out after resume for tso
Date: Sat, 17 Jan 2026 15:59:22 +0800
Message-ID: <20260117075926.128979-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aWrJvrpIAZHQS2uv@shell.armlinux.org.uk>
References: <aWrJvrpIAZHQS2uv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange003.hobot.cc
 (10.69.1.10)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC5crIpZvjmJ1pMLVBxOLny2mMFssf7GC1
	mHO+hcXi6bFH7BaP+k+wWVzY1sdqsbBtCYvF5V1z2CwOTd3LaPHy9TZmi3l/17JaHFsgZvHt
	9BtGB16Py9cuMnvMW1PtsWXlTSaPp/1b2T12zrrL7rFgU6nHplWdbB47d3xm8ni/7yqbx+dN
	cgFcUVw2Kak5mWWpRfp2CVwZhyZ1MxWcYa2YtPs1ewPjaZYuRk4OCQETibmrHjJ2MXJxCAms
	YJQ4f6ufFcJ5zihxemo3M0gVm4CGxN2p14A6ODhEBKQljs3RAKlhFrjPJHHs6G5GkBphgSiJ
	D99PsIHUsAioSuxpqgMJ8wrYSlxsfMoEsUxe4vqUA4wgJZwCphKPD5eAhIWAbthxYSIzRLmg
	xMmZT8BuYwaa0n0EopUZqLV562xmiHoVieaT89khRspJvN6wnw3CjpHYPukY2wRGoVlIRs1C
	MmoWklELGJlXMQrnJmbmpJcbGOtl5BdlVuXn6SVmbmIExR0n46YdjEsWfNQ7xMjEwXiIUYKD
	WUmE98L7rEwh3pTEyqrUovz4otKc1OJDjNIcLErivNqKcZlCAumJJanZqakFqUUwWSYOTqkG
	po4pISUHJGcHN19RKWO86J6x+OAa1eoXCyuMj4YpnPsffO1Q6sxjzJ/1ikv1LS2N3es2T60V
	ZkiTu1YttaD1apPpVtFzLpK3f+ekKrEfnRoVlOnb56xs6mWgGcjYPUXs7L+ZDG8/Ri0OVTh0
	xeasyz7fM7t15mb9iQ07/Wf16wBWuzOvd7Ex+VXsn3byd+pRDZ7AxwUzv7R9ZnbPWTS1nnXC
	iwkrNpcsONsdkXabyzcml7FM0fZDUrfotOye7ZXrbrkJyFyPuragiCFW6Iz2qV8Gcm1f7icy
	9xpaF8fZiKdqHRNkUX+o2v/8+GpB34jtGr77bZ7+1fxXzM41Y66CePhC9QsOBuF9BooTj9kr
	sRRnJBpqMRcVJwIAVpPlbSoDAAA=

> Rather than using tx_q->tx_skbuff_dma[].last_segment to determine
> whether the first descriptor entry is the only segment, calculate the
> number of descriptor entries used. If there is only one descriptor,
> then the first is also the last, so mark it as such.

This is a good idea. tx_q->tx_skbuff_dma[].last_segment no longer carries
 much meaning and can indeed be removed altogether.

> +       is_last_segment = ((tx_q->cur_tx - first_entry) &
> +                          (priv->dma_conf.dma_tx_size - 1)) == 1;

Since tx_q->cur_tx may wrap around and become smaller than first_entry,
the following statement is more concise:
is_last_segment = (tx_q->cur_tx == first_entry);

