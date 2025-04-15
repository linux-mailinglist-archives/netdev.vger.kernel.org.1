Return-Path: <netdev+bounces-182586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F221EA8938D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC75170D8B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A1274FC7;
	Tue, 15 Apr 2025 05:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8471B6CEF;
	Tue, 15 Apr 2025 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696624; cv=none; b=hD9SToSbsn96ATGRiicZ8l9C1MzcJ6kAuIaVPf1oxHQ5fe+yEVjaExjYlHqOPVQ8TLgJXucTn18SZ9RU1u+bvgjNpDyl/G+pzVdl8pqXMVp+qoOPVzU3o7JadLPPNgu26hMTovJeVUzn8tomUeTzhmc8xR+Hy3NTsPxeI7K3tO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696624; c=relaxed/simple;
	bh=O+NBj4j3iQU7jiJviRGpSHLKS7C8evzhpxJmsJ8nUn8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrYQp6ccJxAjhz5wjBdWnZjmnx4C3gXN25MZxEnm3Tr1Ggyz9RJP3libHT8l05VXDaD726G2eKkCWBezBt2u1adiccYG01qYrMNziZxHD1BKlAouqXOQgfHY8vdTWiqQAwaEWIjqtbBQfmwXAJM0tykHmZhKI1/IgpVkX6v0AIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1744696533t013t26505
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.107.143])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2050150904681905092
To: "'Abdun Nihaal'" <abdun.nihaal@gmail.com>
Cc: <mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250415032910.13139-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250415032910.13139-1-abdun.nihaal@gmail.com>
Subject: RE: [PATCH net] net: txgbe: fix memory leak in txgbe_probe() error path
Date: Tue, 15 Apr 2025 13:55:31 +0800
Message-ID: <00b701dbadca$ffa3de50$feeb9af0$@trustnetic.com>
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
Thread-Index: AQGw4ep9NYQY3hr1lQ/YBs2b0q+BSrP50eSw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYaClDVrQHFLyLKUkR75c38Ry+138fLCVf1amXOAY07nXqx50xFUcNR7
	ZBHaTeMAwONC+rski3oyaZRjiZozB0HLl72/hHl/mPg0rF4NBNuMr3+o+jU9/vKpGIsP+sk
	05V9tcRAE4Hw2N1e+f5g2V4WpbgH6ePv7oQAcO3kRD180A2biCvNsRNTjExpi6ipihVsx/Y
	v/ltxJWRUzg7xwrf8mH7VCp4z7JtnND8RYOQxwxv/FxZjVKAEEQ9Es62CBB6YDPM/781Uak
	2uOEsI75M27xRuqXsPx9bVl2K1H/frawwtfCoi4oNcqvm/+RV4P2BZ4KRT0as6zLx1MdE1I
	iMah5Ka0BUefjQ0cykjljD7QhqSLb1iiCBj0+GiChOCbA5gYX9r5owyPdcHKbN25bXJk701
	xbJbjE3oZsGzuaHglqD0O+CtHiH7b83zP+VLV+1QreNeLwZlB13+l7L1CKTcuCo+YHmS3Sb
	YOanZxLKv2w2E5QNS3a1B17FBBZfD7jyyXuXv/+j2hX8XKkqMJoGuIiWLmNmOJkaZF2ftyX
	3cwci8zxWCCW6Tjua+B2y+QQQljV8jKGmi5RPpeTr4+CCY/ZGG+6JaRgVmEe2tKeyoZBd46
	L6/F4wRgdDqdOcjl69DVKCHUTrxOboM87Lk+/p1oBEjy+HMurVtlOJYP1kE0g1+74QF5mEJ
	odLYmYx9lzjo0yYHacgdWbfXhN5/OwiS4FtaGdlmBcgTkldwF26milH+WzVkDi3MeXi+KJr
	zpHkuBpx6JLBM0OiiGzfPIPm0O7kVBjdWCeelTsOd7F+LONUKQ/LehKdu8tOpH/Yc3AaWA5
	9eYhj1xUDpoRRrzrV6ZlqMFGS3xdmpSyHfPXWohAyb5o0k4CVEHXnWDtvqI1cJaeBC34ew6
	BmVktpdGHBLFhDvGeJcWqNvcmnxHTQUgeslJcq330FJQailf7ZRn8zXlD8S6Or/3+SqPJiL
	9r1HdFOYKnRv/PI9/UvTwrFqYsHei4x1P3iQ0EOcFUixTEkCT6rGtdqUHNGRvtji+MZ03ZA
	cyyapCNg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Apr 15, 2025 11:29 AM, Abdun Nihaal wrote:
> When txgbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in txgbe_probe() function, the subsequent
> error paths after txgbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
> 
> Also change the label to which execution jumps when txgbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
> 
> Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel number")
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index a2e245e3b016..38206a46693b 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -611,7 +611,7 @@ static int txgbe_probe(struct pci_dev *pdev,
>  	/* setup the private structure */
>  	err = txgbe_sw_init(wx);
>  	if (err)
> -		goto err_free_mac_table;
> +		goto err_pci_release_regions;
> 
>  	/* check if flash load is done after hw power up */
>  	err = wx_check_flash_load(wx, TXGBE_SPI_ILDR_STATUS_PERST);
> @@ -769,6 +769,7 @@ static int txgbe_probe(struct pci_dev *pdev,
>  	wx_clear_interrupt_scheme(wx);
>  	wx_control_hw(wx, false);
>  err_free_mac_table:
> +	kfree(wx->rss_key);
>  	kfree(wx->mac_table);
>  err_pci_release_regions:
>  	pci_release_selected_regions(pdev,
> --
> 2.47.2
> 

Thanks.

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>


