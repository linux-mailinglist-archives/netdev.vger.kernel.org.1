Return-Path: <netdev+bounces-141561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5159BB686
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C71AB23504
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE9224F6;
	Mon,  4 Nov 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wIl3ckA9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED98BEE;
	Mon,  4 Nov 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727773; cv=none; b=mThrADVW4meo/MvVSw8ZB4MbjZuta4iIZl6MYa69fr+BHmDCy7aiJ6aQRUn5PsFzyGEMnqdZyF5XLGrYlGq8NQOCfRIicqM1W3sb/VnCopqljbf8oQIoUezWmP2H6mNjaD9N2jm1LTHoY2RW5cm70jXhISnMhgqK+dDhoQK6dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727773; c=relaxed/simple;
	bh=19K1akdAErOr697EFRw24TKIGKC8ZAe5FwEKvCMX90M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HSoiV5BH2vt2wzjKPNfnWDVayhq2PjSbEhhk0YmL1QITZ0T1wp+JY4AvZ0do9+u8g3XPpAnSkURsdvtcQfF3hC7Sqwu4eqF224nqTdGnJYWPGUHWTNnlubfi5RS7z83PAlZlGhisNifuypFr00gQDnDRWzqILZxCsxb8YbJSRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wIl3ckA9; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730727772; x=1762263772;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=Qa/srygtponKFMHad9K5Zrj8KYozifJ/bpljTaDS7Jk=;
  b=wIl3ckA9a99H8dlISM5vQduWac/SvL7ewsDcrvcjsY6kavIkvguROGEO
   AGi+/llm4RtTy8oZkaPuOdstiea48WtjF57bJ3olS2XmWwaYosaKvyidH
   ovd+/kqnopsm6STECEUo4GANIh/OflN9LW3R4ItbyYqnoJ52KU7Htum9V
   g=;
X-IronPort-AV: E=Sophos;i="6.11,257,1725321600"; 
   d="scan'208";a="440104328"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 13:42:48 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:39364]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.199:2525] with esmtp (Farcaster)
 id c38ac48c-0061-4fba-bda0-ac78022b4880; Mon, 4 Nov 2024 13:42:47 +0000 (UTC)
X-Farcaster-Flow-ID: c38ac48c-0061-4fba-bda0-ac78022b4880
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:42:45 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com.amazon.com (10.13.248.51) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:42:39 +0000
References: <20241101214828.289752-1-rosenp@gmail.com>
 <20241101214828.289752-3-rosenp@gmail.com>
User-agent: mu4e 1.10.3; emacs 29.3
From: Shay Agroskin <shayagr@amazon.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Arthur Kiyanovski <akiyano@amazon.com>, "David
 Arinzon" <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, "Saeed
 Bishara" <saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jian Shen
	<shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: ena: simplify some pointer addition
Date: Mon, 4 Nov 2024 15:36:52 +0200
In-Reply-To: <20241101214828.289752-3-rosenp@gmail.com>
Message-ID: <pj41zlzfmfktdh.fsf@u95c7fd9b18a35b.ant.amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)


Rosen Penev <rosenp@gmail.com> writes:

> Use ethtool_sprintf to simplify the code.
>
> Because strings_buf is separate from buf, it needs to be 
> incremented
> separately.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 17 
>  ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c 
> b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index fa9d7b8ec00d..96fa55a88faf 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -1120,7 +1120,7 @@ static void ena_dump_stats_ex(struct 
> ena_adapter *adapter, u8 *buf)
>  	u8 *strings_buf;
>  	u64 *data_buf;
>  	int strings_num;
> -	int i, rc;
> +	int i;
>
>  	strings_num = ena_get_sw_stats_count(adapter);
>  	if (strings_num <= 0) {
> @@ -1149,17 +1149,16 @@ static void ena_dump_stats_ex(struct 
> ena_adapter *adapter, u8 *buf)
>  	/* If there is a buffer, dump stats, otherwise print them 
>  to dmesg */
>  	if (buf)
>  		for (i = 0; i < strings_num; i++) {
> -			rc = snprintf(buf, ETH_GSTRING_LEN + 
> sizeof(u64),
> -				      "%s %llu\n",
> -				      strings_buf + i * 
> ETH_GSTRING_LEN,
> -				      data_buf[i]);
> -			buf += rc;
> +			ethtool_sprintf(&buf, "%s %llu\n", 
> strings_buf,
> +					data_buf[i]);
> +			strings_buf += ETH_GSTRING_LEN;
>  		}
>  	else
> -		for (i = 0; i < strings_num; i++)
> +		for (i = 0; i < strings_num; i++) {
>  			netif_err(adapter, drv, netdev, "%s: 
>  %llu\n",
> -				  strings_buf + i * 
> ETH_GSTRING_LEN,
> -				  data_buf[i]);
> +				  strings_buf, data_buf[i]);
> +			strings_buf += ETH_GSTRING_LEN;
> +		}
>
>  	kfree(strings_buf);
>  	kfree(data_buf);

Thank you for submitting the patch. If I'm not mistaken, there are 
some bugs introduced here:

1. You update string_buf pointer itself, but later you pass the 
variable to kfree, this
   would likely end up freeing the wrong address (/causing a 
   kernel panic)
2. The ethtool_sprintf increases the `buf` pointer by 
ETH_GSTRING_LEN, while the previous code increased it
   by (ETH_GSTRING_LEN + sizeof(u64)) bytes.
   This causes a corruption in the buffer.

This function and mechanism is already planned for an overhaul in 
a future patch. We prefer to leave this patch out.

Thanks, Shay

