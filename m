Return-Path: <netdev+bounces-29238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A678241B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674F4280ECA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392221867;
	Mon, 21 Aug 2023 07:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04EEBB
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD898C433C7;
	Mon, 21 Aug 2023 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692601416;
	bh=vRar8l9ILaoEFw2+hFnxiFjdmBLeNqB26P7+WKEFpEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmnUrr+ijfI+YGEqR+Dwr+2FoqGPF814T8gAkuNXxPnMFtxclMIt6kb/18LEtRBU/
	 eC4f8rSexpWfvcMeD2j4Bzr1s5ZlX6hc3bln2n4HhWsdWoa0hZPRb6iqOOmrJru9LQ
	 SXBl7UL/zgnbqnZNdCjUdWZ/QOnvdAsBDJr+FOofLaDNW7SnMDTwW3xic+ZMtveILc
	 vps3FXciom+5+DWOK5WXGIngg/+WjfQxo0EqGboc1Yc+Gv1ouqG0x+qiQ5E0kmoW9s
	 Fogp5aNi2IXPrNBUHT/ihu0mmbuV2YCNxup2AfpYcupXhefJ7x04SOLPEAYqO0XgRL
	 n2H95Iugz0rrw==
Date: Mon, 21 Aug 2023 09:03:31 +0200
From: Simon Horman <horms@kernel.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	gongruiqi1@huawei.com
Subject: Re: [PATCH RESEND net-next] alx: fix OOB-read compiler warning
Message-ID: <20230821070331.GA2711035@kernel.org>
References: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>

On Mon, Aug 21, 2023 at 09:32:18AM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> The following message shows up when compiling with W=1:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
> ./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In order to get alx stats altogether, alx_get_ethtool_stats() reads
> beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
> and refactor the unnecessarily complicated BUILD_BUG_ON btw.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


