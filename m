Return-Path: <netdev+bounces-230767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BDBEEFF7
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC2189696E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785881DB356;
	Mon, 20 Oct 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t7vi6l6k"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCD33F6;
	Mon, 20 Oct 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923803; cv=none; b=UKmmkYsXwc5hO5GvhygRvC6ttXVdKfyTkKbzIaG+KO6rCNMddpu/KUrvduJSAikKq/StWkUYtWAwbQc6wUpcRzq6McCGvUYx6iW5q8/5MO6yGILZHHhQh4rHmvtThMeti7Q04go+0WGR/dYvzN42RKznkOeOKHTkGdE7PPm7Q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923803; c=relaxed/simple;
	bh=cOOCymlcQ4yXe5flO7dYezoRaz5b3aNPXSz3NYiNa74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS582+Mz9PbrIjHb+B6/N0fD8hZ2SfJGS57jo6j5fJ2M0z1zIxZsj4m4otJD+alsm1BWKdkFMwbZJXZSXVvqXJtLfjLEmfeQ4KUlNWyPLpCxZr3pkqQcbt/V+xx/ocD9w241V6vYDiNMg+kYVGH4n1bmuBb6SaDtQZiUXD9bMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t7vi6l6k; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bbvP9qtrOBpmi4VZWRhATVemHJdm1859xM2/i1HFr6o=;
	b=t7vi6l6kdAlDwnnIV9+5Fq2cXQ3fu9Ah4U5V60VT135lbd084E8xF5xklLqY+NgtM/6R51/5k
	/gamrgch+S8LLFH7MAeBMC8AAqNx5FhPn5QY4PFVj/eGIzy/D/h7dQoI5czth3zWRlrYy0pTE/D
	j1szK7cJxNOH5Gnkhb+wIfE=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cqdBc5WTjzmV7q;
	Mon, 20 Oct 2025 09:29:28 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D996C1A0188;
	Mon, 20 Oct 2025 09:29:51 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 09:29:50 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <markus.elfring@web.de>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<luoyang82@h-partners.com>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v02 4/6] hinic3: Add mac filter ops
Date: Mon, 20 Oct 2025 09:29:44 +0800
Message-ID: <20251020012947.2033-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <e8b52cf3-9f77-445c-8ba6-d8ac402841b7@web.de>
References: <e8b52cf3-9f77-445c-8ba6-d8ac402841b7@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 10/17/2025 7:51 PM, Markus Elfring wrote:
> …> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
>> @@ -0,0 +1,413 @@
> …> +static int hinic3_mac_filter_sync(struct net_device *netdev,
>> +				  struct list_head *mac_filter_list, bool uc)
>> +{
> …
>> +		hinic3_cleanup_filter_list(&tmp_add_list);> +		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list, &tmp_add_list);
>> +
>> +		/* need to enter promiscuous/allmulti mode */
>> +		err = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	return add_count;
>> +
>> +err_out:
>> +	return err;
>> +}
>
> Is there a need to move any resource cleanup actions behind a more appropriate label?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.17#n532
>
>
> Regards,
> Markus

Hi, Markus. Thanks for your comment.

Your suggestion is great. In "hinic3_mac_filter_sync", there are two places in
the code that return error values.
Actually the error handling code you quoted should be refined as a new function
because its error handling is special and cannot be normalized to function error
path.

> +	if (err) {
> +		hinic3_undo_del_filter_entries(mac_filter_list, &tmp_del_list);
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		netdev_err(netdev, "Failed to clone mac_filter_entry\n");
> +
> +		hinic3_cleanup_filter_list(&tmp_del_list);
> +		hinic3_cleanup_filter_list(&tmp_add_list);
> +		goto err_out;
> +	}

And anther place(only cleanup del_list & add_list) should be moved behind a
error label in function error path according to linux doc.

