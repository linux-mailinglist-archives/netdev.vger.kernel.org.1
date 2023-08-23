Return-Path: <netdev+bounces-30028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F4785AE2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E51328134E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4669BA27;
	Wed, 23 Aug 2023 14:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFCA4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416A2C433C8;
	Wed, 23 Aug 2023 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692801464;
	bh=nFJQaMzN4+WOLIo2ulDo6fG5gqWoQo4wo3RYzpQckXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxOf27+jWp737fuS7z8Smvhvl7GaSIrp09nUEqpoI18ihVEJs7YH2wukNxniJICIX
	 IKtHxdngK5gi8uVYA1JFKq3/Diis4fChN2cizYXXSSKNjag9UWSbNXpuJmGPwYxNNa
	 8SMuXEcs7gp39l4ed5PoNzETHL8UNlmY7mYb6vWu/g57L9TYmTuYtQqtTSh4Ve3a1d
	 RTb+9ttsUAWlYqf2zj6EEfY56xh44BJB0GziyURSx879VjFqR5MbECpCtd6eNa5tFy
	 ndVk5MYvnvJMHPD2jMAm4U6WkFQys1qQPhWo3Q+c7Kh/8whDYb9sUkcjWueixgc1Z3
	 whpEeZarTXf+g==
Date: Wed, 23 Aug 2023 07:37:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <netdev@vger.kernel.org>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4 3/3] net: lan743x: Return PTR_ERR() for
 fixed_phy_register()
Message-ID: <20230823073743.61770fa4@kernel.org>
In-Reply-To: <2763f37a-8707-7fad-5dd4-cc4247fe3e1b@huawei.com>
References: <20230821025020.1971520-1-ruanjinjie@huawei.com>
	<20230821025020.1971520-4-ruanjinjie@huawei.com>
	<20230822170335.671f3bef@kernel.org>
	<2763f37a-8707-7fad-5dd4-cc4247fe3e1b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 15:43:58 +0800 Ruan Jinjie wrote:
> > EPROBE_DEFER is not a unix error code. We can't return it to user
> > space, so propagating it from ndo_open is not correct.  
> 
> When the error is EPROBE_DEFER, Whether print the netdev_err is ok? And
> what should it return?
> 
> How about this?
> 
> if (IS_ERR(phydev)) {
>      ......
>      if (PTR_ERR(phydev) != -EPROBE_DEFER)
>          return PTR_ERR(phydev);
>      else
>          return -EIO;
> }

That's too much code to copy & paste into every driver.

Someone who understands the code flow very well should tackle this.
Please leave the cases where fixed_phy_register() is called outside 
of probe alone.

