Return-Path: <netdev+bounces-35611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F07AA09A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D4282185
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FC18C35;
	Thu, 21 Sep 2023 20:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB49CA5B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54247C433C9;
	Thu, 21 Sep 2023 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695328920;
	bh=I1qPjPwX/ZgiQ8faFls/NRFN0ufD5XwNyu1yGXX83gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb1ItmWrkhLoMDVa3VWNIUYsonRsAac6VG5D4Co/JV+m6nZDuol2aUe2vk2x/O9D4
	 hpeQmXHfUyeFIV09+kGiCu8iMai7dBxHEM016VFmD/OAEbY6dzlaLPjmHnIOGhByi1
	 XrbTgtJ/gRHr9RZOo7XCXkj9nrSyhvtD+n3LXW8R3EzhV/z3OC+iVbl1iaNIHe6/Be
	 Pp9tBmrlnDnpn8H8iJj7h+n8TjYgFOvvUNfayCtE8YlS3yA0t97uWmRzdm8UfWCeA9
	 UCy2rTD+kMmdafDZc5JAPjw0yYUyt3js5+j+KRfxJk4l/9RRWSQOAI6ZuZb+G2J78D
	 63FP/knQMriBg==
Date: Thu, 21 Sep 2023 21:41:53 +0100
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/18] net/smc: decouple ism_dev from SMC-D
 device dump
Message-ID: <20230921204153.GQ224399@kernel.org>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
 <1695134522-126655-2-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695134522-126655-2-git-send-email-guwen@linux.alibaba.com>

On Tue, Sep 19, 2023 at 10:41:45PM +0800, Wen Gu wrote:
> This patch helps to decouple ISM device from SMC-D device, allowing
> different underlying device forms, such as virtual ISM devices.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/smc_ism.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index fbee249..0045fee 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -230,12 +230,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>  	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>  	struct smc_pci_dev smc_pci_dev;
>  	struct nlattr *port_attrs;
> +	struct device *priv_dev;
>  	struct nlattr *attrs;
> -	struct ism_dev *ism;
>  	int use_cnt = 0;
>  	void *nlh;
>  
> -	ism = smcd->priv;
>  	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>  			  &smc_gen_nl_family, NLM_F_MULTI,
>  			  SMC_NETLINK_GET_DEV_SMCD);
> @@ -250,7 +249,10 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>  	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>  		goto errattr;
>  	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));

Hi Wen Gu,

priv_dev is uninitialised here.

> -	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
> +	if (smcd->ops->get_dev)
> +		priv_dev = smcd->ops->get_dev(smcd);

It is conditionally initialised here.

> +	if (priv_dev->parent)

But unconditionally dereferenced here.

As flagged by clang-16 W=1, and Smatch

> +		smc_set_pci_values(to_pci_dev(priv_dev->parent), &smc_pci_dev);
>  	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>  		goto errattr;
>  	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
> -- 
> 1.8.3.1
> 
> 

