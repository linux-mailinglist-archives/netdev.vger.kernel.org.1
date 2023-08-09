Return-Path: <netdev+bounces-25704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1A77536A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E822819B3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA820EC;
	Wed,  9 Aug 2023 07:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51890ECD
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2156BC433C9;
	Wed,  9 Aug 2023 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691564587;
	bh=P2+3vf+gBALf2UGu15Ac/T463go2awfYas36ymRipBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jod8fe3hOqqkL3j5kbVUq2qQm+GHBF8hrvNay9C/ZMfrd3yi7fSMXkpSOPrssAYyY
	 XULvJ6XtdjS/wtWa0Bj2EYj3VTHUWzs/cqVrGjhHdP/bfuvz2/3u+HllwdGK28edUm
	 f537bCuDOhyGl74bvCgASsIme1km/1zAFRKT667qJWOuRBgA6vTnI8B8k4IkxLq57P
	 D5d0EisXO8GDSz/9Y6dXfMPwBo2XjVUekxGr/QqBoLiBVRDrCN/VWs55a2djm6qO0C
	 Wny/oRsqOQHaA1/3fJZyqczIUAdKCTmEfoRqEgGI56CAb/aNHJDR3VgDTEfNXDjHvp
	 gcXSlRpk/JCUQ==
Date: Wed, 9 Aug 2023 10:03:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <20230809070302.GR94631@unreal>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809020902.1941471-1-shaojijie@huawei.com>

On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> items to a string for content, and we add '\n' and '\0' in the last
> two bytes of content.
> 
> strscpy() will add '\0' in the last byte of destination buffer(one of
> items), it result in finishing content print ahead of schedule and some
> dump content truncation.
> 
> One Error log shows as below:
> cat mac_list/uc
> UC MAC_LIST:
> 
> Expected:
> UC MAC_LIST:
> FUNC_ID  MAC_ADDR            STATE
> pf       00:2b:19:05:03:00   ACTIVE
> 
> The destination buffer is length-bounded and not required to be
> NUL-terminated, so just change strscpy() to memcpy() to fix it.

I think that you should change to strtomem() and not use plain memcpy().

Thanks

