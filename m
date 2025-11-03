Return-Path: <netdev+bounces-235012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11041C2B349
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A73A7050
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B86301032;
	Mon,  3 Nov 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HuJ3Ukg2"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933B30146D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167617; cv=none; b=AKl8KNbyaxPiV5WSIBxMu8hEsXhLG8/mEaz0PLsiuEg7ECus/uL/Be+VaGUy6s2grgwAsjoJn4OPTDe9lU0mdUNGiqDaGHzBUzb7PaTYbhOOIgIVMak68HbdKG3Shh/SlvCBJYOF+CgNRRJemc9h+gi3jxTB1e2RuzBZVpJpF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167617; c=relaxed/simple;
	bh=26oGhMZAJyNHpFLdz9ki9jli2smy2hqkireoxhuIGU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noNuQacg7RRcYPJkZVo++c5wLUOXqTO8QBcq4O/ElXwhKApSyHHEJqJRjXVTbVijTFtFTPRZmQrnd7sh8De/9ETmVRgWJHyfrUszsDDOECiUwG/m+P8CUhDQSYm43UhuWOoHGwNF4DSFaYu0A0c84OyZmuNAIxtotizxPl9E9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HuJ3Ukg2; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k3raHiXWg0zqo7N0tTXtJ8Dlr7ndBSw8IaKZRUm67h8=;
	b=HuJ3Ukg2NILzX2GCCOsAjtqBj8dIaT9NBMut5XQSfFFxjz7TZDOcRhKcv6v9gOHsH9lXV3pRq
	Cm6dSN3Tv/4tQFwTIlihlmtazam3JxCICeK9Fh8JPnhVmb6cZSjzgj25esm9KmyQnNkWAUCYYik
	B7xQXH3xVZGpfGepgpUBeF0=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0T8z0YnxzpStg;
	Mon,  3 Nov 2025 18:58:43 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6796914020C;
	Mon,  3 Nov 2025 19:00:10 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 19:00:07 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <alok.a.tiwari@oracle.com>
CC: <alok.a.tiwarilinux@gmail.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next] hinic3: fix misleading error message in hinic3_open_channel()
Date: Mon, 3 Nov 2025 19:00:03 +0800
Message-ID: <20251103110003.835-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20251031112654.46187-1-alok.a.tiwari@oracle.com>
References: <20251031112654.46187-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 10/31/2025 7:26 PM, Alok Tiwari wrote:
> The error message printed when hinic3_configure() fails incorrectly
> reports "Failed to init txrxq irq", which does not match the actual
> operation performed. The hinic3_configure() function sets up various
> device resources such as MTU and RSS parameters , not IRQ initialization.
>
> Update the log to "Failed to configure device resources" to make the
> message accurate and clearer for debugging.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> Fixes: b83bb584bc97 ("hinic3: Tx & Rx configuration")
> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index 0fa3c7900225..bbf22811a029 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -304,7 +304,7 @@ static int hinic3_open_channel(struct net_device *netdev)
>  
>  	err = hinic3_configure(netdev);
>  	if (err) {
> -		netdev_err(netdev, "Failed to init txrxq irq\n");
> +		netdev_err(netdev, "Failed to configure device resources\n");
>  		goto err_uninit_qps_irq;
>  	}
>  

Thanks for your change.

Reviewed-by: Fan Gong <gongfan1@huawei.com>

