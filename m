Return-Path: <netdev+bounces-38796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3E7BC888
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73328281E2C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875E28E3D;
	Sat,  7 Oct 2023 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIzj7hK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A33171C2
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72083C433C8;
	Sat,  7 Oct 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696691425;
	bh=LH6IWkmyMSvjK2Q3N3HjTHI8GVBa4KuURUr6eXtccys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIzj7hK0L/DbwMAVrxGzakiLql+kw3pXx1ew0g45ixAo3GNkeQrZzd9PuDWCWxF0Q
	 9IBOXzzVpCsDt4JbpDmYgKUBKpNX66jLsOOr9tVCZ3XSODwohF1YU51Wz+vb8VDu74
	 8Hmcp5ZInqFxhE0tUi7gjmR1snrHvZNqezzcM1Vyz/ZSBAYEgwoRvJzHA7kujsBVpi
	 2REy0U1jFFh3BGvyd+PmEiqEfNdsyDXsBeKG+hQKKqnvjFFCyUT799FTz4+7oUYpCo
	 YaRyhio3Qc2+RS1XQBg66Gx7nlykEqJT67KZ7rKF79iuhooOR4XCaxgUXM4A8/t7Fp
	 XhWS0vNlAW3HQ==
Date: Sat, 7 Oct 2023 17:10:21 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20231007151021.GC831234@kernel.org>
References: <20231005072349.52602-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005072349.52602-1-dg573847474@gmail.com>

On Thu, Oct 05, 2023 at 07:23:49AM +0000, Chengfeng Ye wrote:
> Timer interrupt ax25_ds_timeout() could introduce double locks on
> &ax25_list_lock.
> 
> ax25_ioctl()
> --> ax25_ctl_ioctl()
> --> ax25_dama_off()
> --> ax25_dev_dama_off()
> --> ax25_check_dama_slave()
> --> spin_lock(&ax25_list_lock)
> <timer interrupt>
>    --> ax25_ds_timeout()
>    --> spin_lock(&ax25_list_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch use spin_lock_bh()
> on &ax25_list_lock inside ax25_check_dama_slave().
> 
> Fixes: c19c4b9c9acb ("[AX.25]: Optimize AX.25 socket list lock")
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Hi Chengfeng Ye,

Are there other functions that spin_lock(&ax25_list_lock)
that also need to use spin_lock_bh()?

...

