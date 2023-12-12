Return-Path: <netdev+bounces-56371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76B80EA49
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5227F1F21368
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588085CD3D;
	Tue, 12 Dec 2023 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQeIAI1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD365CD1C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 11:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE88C433C8;
	Tue, 12 Dec 2023 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702380229;
	bh=Yc6c1Duux/aJZRVG7ThxsBy8BNeRcHgqMI331FQ/0lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQeIAI1kJuI/5OuNNBvzd6M4m7J6nrtCoQ250xSXJJxIcgkTdwrAy27H5eQu2U7m8
	 39AgFBelagybs6K9nmu7SmpfuBRfDR88+rrllFl0vdnRJXWe+avkZKgobfiB4D/tPc
	 ha07K3CNSHmVJ6f+i/aKKVhmVrUAUKJl1xqWN+yKowuCISNJjfmcrUZOyj0LsumflV
	 mzCp4BOOmxpPMelq6fiBgsNsZ2WaoQcZUjcmFENqQbWD5oxE9O6RQKruwjWCPc63G8
	 5aMF3mnvbZwRc3daXLt5iQpnUJIjq61aHeIvpcCmaUl0TI5uzsAfM3123lfHkxqN7f
	 HOatnoH+aeZ9Q==
Date: Tue, 12 Dec 2023 11:23:44 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 1/1] net: dl2k: Use proper conversion of
 dev_addr before IO to device
Message-ID: <20231212112344.GZ5817@kernel.org>
References: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>

On Fri, Dec 08, 2023 at 05:33:27PM +0200, Andy Shevchenko wrote:
> The driver is using iowriteXX()/ioreadXX() APIs which are LE IO
> accessors simplified as
> 
>   1. Convert given value _from_ CPU _to_ LE
>   2. Write it to the device as is
> 
> The dev_addr is a byte stream, but because the driver uses 16-bit
> IO accessors, it wants to perform double conversion on BE CPUs,
> but it took it wrong, as it effectivelly does two times _from_ CPU
> _to_ LE. What it has to do is to consider dev_addr as an array of
> LE16 and hence do _from_ LE _to_ CPU conversion, followed by implied
> _from_ CPU _to_ LE in the iowrite16().
> 
> To achieve that, use get_unaligned_le16(). This will make it correct
> and allows to avoid sparse warning as reported by LKP.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312030058.hfZPTXd7-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy,

I agree with your reasoning that the explicit conversion is reversed.

Reviewed-by: Simon Horman <horms@kernel.org>

