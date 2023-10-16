Return-Path: <netdev+bounces-41530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB47CB340
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A961428146F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC33418A;
	Mon, 16 Oct 2023 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KVsG4cco"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06807339BE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:19:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2B183
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kaRD/tIOoW3biP5hfVTOtXuckMfMdH8zXsXzcqD7oCY=; b=KVsG4ccoRS4cJ1xLdwk6iWJ58N
	HuXmuViMQiFAGFaYDC2HWJtmLlt8y5G1k04KEnUoAMVjWYt0qIHq5V7ubQf9ESjQrqH0UfXZB5UcF
	P6y7rhg4slkgY3dWVQd+eXC5/kqj0NaaR1PR5GD1c1IIsEUkpJGbzJux0vKCibm0SSPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qsT7R-002O1H-JP; Mon, 16 Oct 2023 21:19:13 +0200
Date: Mon, 16 Oct 2023 21:19:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: txgbe: clean up PBA string
Message-ID: <23d363d0-70d6-42b7-9efd-d9953b3bc7f5@lunn.ch>
References: <20231016094831.139939-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016094831.139939-1-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 05:48:31PM +0800, Jiawen Wu wrote:
> Replace deprecated strncpy with strscpy, and add the missing PBA prints.
> 
> This issue is reported by: Justin Stitt <justinstitt@google.com>
> Link: https://lore.kernel.org/netdev/002101d9ffdd$9ea59f90$dbf0deb0$@trustnetic.com/T/#t
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 394f699c51da..123e3ca78ef0 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -741,8 +741,9 @@ static int txgbe_probe(struct pci_dev *pdev,
>  	/* First try to read PBA as a string */
>  	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
>  	if (err)
> -		strncpy(part_str, "Unknown", TXGBE_PBANUM_LENGTH);
> +		strscpy(part_str, "Unknown", sizeof(part_str));
>  
> +	netif_info(wx, probe, netdev, "PBA No: %s\n", part_str);
>  	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);

In general, we try not to spam the kernel log, especially not for the
good case. You can get the MAC address with ip link show. How
important is the part? Can you get the same information from lspci?
Or maybe you could append it to the driver name in wx_get_drvinfo()?

	Andrew

