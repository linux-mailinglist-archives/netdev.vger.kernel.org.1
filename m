Return-Path: <netdev+bounces-30269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC05786AAA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA21C20BE1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F7CA7A;
	Thu, 24 Aug 2023 08:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFE24544
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDFC433C9;
	Thu, 24 Aug 2023 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692867021;
	bh=jvmeqWtT+a95MPO2TYGl+YZLchPcbm7vpnWoKkHsTr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7XwvjGSkwadPCyOme2Y80LtvEzWAmaGiqzGu9KuHeBfDHJdyfgOY2puZax44q/vO
	 nLQ4INGXuMQChKuWM8U1O+MdZwInT3WTZ2b+bcx2CedOb/AtVcjiAcbK1XqxbCF52z
	 xAFa4W5Kmqdi6Bcl19qThqdapio0h5MSS/YU/EYYO/WJDaifUbUr0s3LJGGSHxvRmc
	 nNAM+E4DMdHW2qHBi9YsHJgb4pJDfwnrKTiQ4ehtdrScEawPPpJk5QSlmoW4cTmD+E
	 Idn/8V+GWVx3VmYou3xnDrRha8HYUQ33X34Ksl/R7RIPmgG9ybyv53gcASkKIXzRTK
	 snNqLSpYe1peA==
Date: Thu, 24 Aug 2023 10:50:07 +0200
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] selftests: bonding: delete link1_1 in the
 cleanup path
Message-ID: <20230824085007.GE3523530@kernel.org>
References: <20230823032640.3609934-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823032640.3609934-1-shaozhengchao@huawei.com>

On Wed, Aug 23, 2023 at 11:26:40AM +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So delete link1_1 in the cleanup path and
> drop any warning message.

Hi Zhengchao Shao,

It seems unfortunate to drop all warning and error messages.
What if the message is about something other than link1_1 not existing?

Would it be practical to check if link1_1 exists,
say by looking in sysfs, before trying to delete it?

> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> index 7b2d421f09cf..2b3c678c5205 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> @@ -11,6 +11,7 @@ finish()
>  {
>  	ip netns delete server || true
>  	ip netns delete client || true
> +	ip link del link1_1 >/dev/null 2>&1
>  }
>  
>  trap finish EXIT
> -- 
> 2.34.1
> 
> 

