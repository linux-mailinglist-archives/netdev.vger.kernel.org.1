Return-Path: <netdev+bounces-182565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B96A891C8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6FA1894484
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86519CC3E;
	Tue, 15 Apr 2025 02:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908C2A1D8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683449; cv=none; b=rvazCYGt0pRhmhfJudu4Y/1ZtIMEwFc9g1WZFtsZfM/0JY8qG4HqXs9re1Vh4yU2gizyTcUmPvT+fDvfIA00/CFSQf9FoyoT2siVJI78bxiAihld89wTFEpmXLJtUJKvfDlUjOwwyLe5Ldeut1lI2mlj7GMB6mGjIRt/tJvcy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683449; c=relaxed/simple;
	bh=thOPuvLIQzgv7to5Bo3IVi6FkYgZ8CRe10HyczY2goc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4HUNPV26024CAvj4wRRo4hdmFM8vYwfudviJinyjXpU1sTWbfaeFd7BE7dCudgyd18iWMyga2ePYvHHk7NEoUiBJt+O4fh1MmKFNtvega0fOKBWsTDT8eLQghpVmhLRFzK8zC3xSf4ehz6CGPMsLGQ/fpGwkwY+1c5QIREBkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1744683425t915t24530
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.107.143])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3094269659863382227
To: "'Abdun Nihaal'" <abdun.nihaal@gmail.com>
Cc: <Markus.Elfring@web.de>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<saikrishnag@marvell.com>,
	<przemyslaw.kitszel@intel.com>,
	<ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250412154927.25908-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250412154927.25908-1-abdun.nihaal@gmail.com>
Subject: RE: [PATCH v2 net] net: ngbe: fix memory leak in ngbe_probe() error path
Date: Tue, 15 Apr 2025 10:17:04 +0800
Message-ID: <00b401dbadac$7b36f120$71a4d360$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGCg9mRcHVPncQlJ+6fjxtFMDYEpbRWUAdQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OfaQ+Y0DiXSPAsd8W/L14qMRodbv5dOG0+DWS7J6K1bAcg/AZBEBLL0B
	bMORN99VniMdPkusMD9akSV2/B/hWUB7H6Y1KP556TdBvUZbKv2MIhN+sygozV4WPlJRbwC
	ufOAMERDLxXAYHyDQTEV68508VtFGfGb7lVDdcdJb79eIQjdqfKX65HmpoSL9pHynAKa+4r
	KxofAPZGgukW+OdUGStgMgZW/SqGDb6fpOpksbwnXvTx1MlyDOn5Ax5h1SjL+M4VVOZ4yQg
	ZG4cpH3NtUI/aNapfK3srf/1rQf5/W9tG4k5eG/0CquS6/1s6pFd4sqggG9zcdJ8jSWafT+
	fbYS22OZbEDIeG3HykAqz/XncDZFvV6t6bX3CloVkrcwPNA9TzDZHY4HRq23ndXTz4lN6PE
	7NWdzQ3wdSkQ7Ryjo27EyM4n/yWj7XpGBe4lmKpV9ucHWGRXuhugZFI0bBaVwmPAGq1xiHf
	eWjg/Jg8L5CV9Lh7IE1Eur4gh9W93ICmyk09tU3vTlkJcwmA2NYRX7awvz3lntW3/tQFT2h
	CYj2LK8N5/jkC08zhGvcBn1HHO0Ob+cIioNo3E89UaWP+A2Oj9PpKj1ZdJoeiAVh21kJaZI
	9Zst5cgZwln4agfa9hw28L3qHZBBLV6Oye3H7xAVaksL+YT2CBYcEWHtuJGpywxwyfsGz0I
	Dc2zOZp40uWrJVdlISkreXdlaBTFRyU+IofJn1tezXC+ovwFy5ke8d0i0pC5xcLGzcUO/AK
	ebPLjdmhpavBN04TRAzWBuryodqnAaOJGzKbYfeaDq0rO8r+Gv2uoC20bchaWxmXkWgVBXZ
	CnFfRhT/tmnGl7FtuX++KYfaWniYI1LQvpRbpWmmzxAGqalR0rowZet5xQxzE6Jv7eEvy0W
	GTy4l5jcOsq6osPbjPrSEAtkSn+Ktq1AgaurVbQyxPA1cjjStTQilGdgWiSfqxogLWFeFuE
	AQ7eWJeurjqxqx+013Y/eBmoFLhVb8QNl22hpPt/7QKzQ1Fl+Uyct2zj5Swi1SgwdaBwcwg
	FRDQgT7Epk+R9IaXVdGprqraVbHqMLAPeE4rJ2UA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Sat, Apr 12, 2025 11:49 PM, Abdun Nihaal wrote:
> When ngbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
> error paths after ngbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
> 
> Also change the label to which execution jumps when ngbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
> 
> Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
> v1 -> v2:
> - Add fixes tag, as suggested by Markus and Jakub.
> - Also set the branch target as net instead of net-next as it is a fix
> 
> v1 link: https://lore.kernel.org/all/20250409053804.47855-1-abdun.nihaal@gmail.com
> 
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index a6159214ec0a..91b3055a5a9f 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -625,7 +625,7 @@ static int ngbe_probe(struct pci_dev *pdev,
>  	/* setup the private structure */
>  	err = ngbe_sw_init(wx);
>  	if (err)
> -		goto err_free_mac_table;
> +		goto err_pci_release_regions;
> 
>  	/* check if flash load is done after hw power up */
>  	err = wx_check_flash_load(wx, NGBE_SPI_ILDR_STATUS_PERST);
> @@ -719,6 +719,7 @@ static int ngbe_probe(struct pci_dev *pdev,
>  err_clear_interrupt_scheme:
>  	wx_clear_interrupt_scheme(wx);
>  err_free_mac_table:
> +	kfree(wx->rss_key);
>  	kfree(wx->mac_table);
>  err_pci_release_regions:
>  	pci_release_selected_regions(pdev,
> --
> 2.47.2
> 

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks Abdun,
I think this release bug is also present in txgbe driver.
 


