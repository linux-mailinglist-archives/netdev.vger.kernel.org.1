Return-Path: <netdev+bounces-131777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D66D98F898
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB031C20B27
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD91AAE39;
	Thu,  3 Oct 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="INF6BWGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304C13C906
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989798; cv=none; b=nsuWkCqGayFFkdtWHnhz+MUToSogcH0n1LVqFYkIaoDyb6PVpLafve/fmNhQkxwa2GMYlcFsrFONVyG6/E0thtEhblYMX6Nn5oxTrlKZ6gHe3hoXBZQ8fvT/JbvncTR8+aKPXW98X5Te5zyFU2wD9ZnTutFRTRYRiIMYwoD4AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989798; c=relaxed/simple;
	bh=gOnpqVQxDRa0AsHcv520fsU+gyO1QLihiJp5whM4EX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqY1iNFwVgQo1KRP/PKxTplO3F1F5iI0K+5I6T1HuIc2Pwr/ee0gPdcYNWpqYp39wLj9ihrwISHCLKYL5hCIzwCzgKj0Mu52xQJz7mOl2nKuZT7g4FZ3emyACST3zagv9IVBAAtQbwPTzhQRmrg+/rBw6To8bEmuNaqzaZMslys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=INF6BWGZ; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 29153 invoked from network); 3 Oct 2024 23:09:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727989793; bh=/B72OQY3UXazz9DO5mTC1Ulshej0ST8FnRZ7Rrz8Urw=;
          h=Subject:To:Cc:From;
          b=INF6BWGZjxlPVD7+IC6CMOSMJMJDRDdeliUzhcjUS6SpD9SstwlyXS/5KdEzafju1
           Huwu08y3K9HUEMt/bUCgpMXe0Z/vjUiCZJpnAnH2TVWnK9s3XXf+WRC3712YJToO8+
           mmXDOAYdVSx1Xt4833y2PS0wk/zwMsHACVpUPLis=
Received: from 83.5.182.107.ipv4.supernova.orange.pl (HELO [192.168.3.100]) (olek2@wp.pl@[83.5.182.107])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 3 Oct 2024 23:09:53 +0200
Message-ID: <e770a088-c17b-4d6c-be96-2c28032b9130@wp.pl>
Date: Thu, 3 Oct 2024 23:09:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 05/10] net: lantiq_etop: move phy_disconnect to
 stop
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-6-rosenp@gmail.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20241001184607.193461-6-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 551cf454c491af86336e125fb7157593
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IbOE]                               

Hi Rosen,

On 1.10.2024 20:46, Rosen Penev wrote:
> phy is initialized in start, not in probe. Move to stop instead of
> remove to disconnect it earlier.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>   drivers/net/ethernet/lantiq_etop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index d1fcbfd3e255..9ca8f01585f6 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -447,6 +447,7 @@ ltq_etop_stop(struct net_device *dev)
>   
>   	netif_tx_stop_all_queues(dev);
>   	phy_stop(dev->phydev);
> +	phy_disconnect(dev->phydev);


Phy_disconnect() already calls phy_stop(). The second call is redundant.


Regards,
Aleksander


