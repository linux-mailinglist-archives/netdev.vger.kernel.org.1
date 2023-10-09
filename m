Return-Path: <netdev+bounces-38990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798167BD571
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B1B1C208E8
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A8800;
	Mon,  9 Oct 2023 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPHn6xM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B91C05
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D14CC433C7;
	Mon,  9 Oct 2023 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696841050;
	bh=BGJHNwJNMBztON4oLZ3LK2mJH//4F5a7Anr3Jd6sFmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPHn6xM3gL5Za1CbvpeiFF3F0gzdQ3DjDTTeg9Ovi4zhADS2ZCOnru4zQMiodrHX9
	 Ku/FOE3+x9wXR+FMb/kuc4HHJwpwk5aOZL3bT+dypbMozi8tk+xD19g90Stq4ltEEG
	 8PY1pFf30rnGzUH4RocDUvCqJeIFugAqv570BPUOLbqFIKPp22v6vRExQ8fq1Der8I
	 yVFNvbJJh+KjYq4HeYvJqtA3EiE4i0QDJv+DLoSQwqQolVRcJ2XPio3z0+v+IEaQQg
	 pPOGsGSi5P72ZzUuCstB2fPY/FRBGLOz2WzlwcezIpAS0xiXjXbDBeLS0lgoSfR9Pq
	 Vbo7g+Hk/PkWg==
Date: Mon, 9 Oct 2023 11:44:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-next 2/2] rdma: Add support to dump SRQ resource
 in raw format
Message-ID: <20231009084406.GC5042@unreal>
References: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
 <20231007035855.2273364-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007035855.2273364-3-huangjunxian6@hisilicon.com>

On Sat, Oct 07, 2023 at 11:58:55AM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> Add support to dump SRQ resource in raw format.
> 
> This patch relies on the corresponding kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Example:
> $ rdma res show srq -r
> dev hns3 149000...
> 
> $ rdma res show srq -j -r
> [{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> ---
>  rdma/res-srq.c | 17 ++++++++++++++++-
>  rdma/res.h     |  2 ++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/rdma/res-srq.c b/rdma/res-srq.c
> index 186ae281..d2581a3f 100644
> --- a/rdma/res-srq.c
> +++ b/rdma/res-srq.c
> @@ -162,6 +162,20 @@ out:
>  	return -EINVAL;
>  }

<...>

>  static int res_srq_line(struct rd *rd, const char *name, int idx,
>  			struct nlattr **nla_line)
>  {
> @@ -276,7 +290,8 @@ int res_srq_parse_cb(const struct nlmsghdr *nlh, void *data)
>  		if (ret != MNL_CB_OK)
>  			break;
>  
> -		ret = res_srq_line(rd, name, idx, nla_line);
> +		ret = (rd->show_raw) ? res_srq_line_raw(rd, name, idx, nla_line) :
> +		       res_srq_line(rd, name, idx, nla_line);

You are missing same change in res_srq_idx_parse_cb(), see commit e2bbf737e61b ("rdma: Add support to get MR in raw format")
as an example.

Thanks

>  		if (ret != MNL_CB_OK)
>  			break;
>  	}
> diff --git a/rdma/res.h b/rdma/res.h
> index 70e51acd..e880c28b 100644
> --- a/rdma/res.h
> +++ b/rdma/res.h
> @@ -39,6 +39,8 @@ static inline uint32_t res_get_command(uint32_t command, struct rd *rd)
>  		return RDMA_NLDEV_CMD_RES_CQ_GET_RAW;
>  	case RDMA_NLDEV_CMD_RES_MR_GET:
>  		return RDMA_NLDEV_CMD_RES_MR_GET_RAW;
> +	case RDMA_NLDEV_CMD_RES_SRQ_GET:
> +		return RDMA_NLDEV_CMD_RES_SRQ_GET_RAW;
>  	default:
>  		return command;
>  	}
> -- 
> 2.30.0
> 

