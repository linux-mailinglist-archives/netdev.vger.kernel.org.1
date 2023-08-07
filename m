Return-Path: <netdev+bounces-25009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8757728BD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2591C20BF4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79F10946;
	Mon,  7 Aug 2023 15:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6910942
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9EC433C7;
	Mon,  7 Aug 2023 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691420936;
	bh=3X1Vxk3O7jBMOUlDxSVXoV/71wfwQb0HWcjFUwMy5Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoFH7P/uXdhCKxI8ajWHuFOpMCeQRfjNCZMw9N8cD40C7ddzxpedWW4MKBNFRjcBq
	 2XslMjeGyEHH1nM4CyO+2wtPdFrQcag0efOdo2s8cP1w7hDvYgvKmAEAkfwWuceDu/
	 JCkhJOCV9Oauol5guq9lKMBZoaOyqgsyaTmRlKHgm/bomio+3HGZV0gzAjKJlhgVlG
	 C3WtIfy4DLvsAG70e/a72ekV2TpUy3+Yj5nv4JOnLkbRZpZIpvms6l6I/qQPBN9EO0
	 9km67WDRBjsOQWZpLNeg4P4TYqucucJJSarnINgtl3Ym93mmOAxm6VnVgD+tpVGtff
	 ZK0v+sAE3LqoQ==
Date: Mon, 7 Aug 2023 17:08:51 +0200
From: Simon Horman <horms@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
	tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 net-next 5/6] net/smc: support max links per lgr
 negotiation in clc handshake
Message-ID: <ZNEJA1E6ouOuaAcc@vergenet.net>
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-6-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807062720.20555-6-guangguan.wang@linux.alibaba.com>

On Mon, Aug 07, 2023 at 02:27:19PM +0800, Guangguan Wang wrote:

...

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c

...

> @@ -1414,6 +1420,9 @@ int smc_llc_srv_add_link(struct smc_link *link,
>  		goto out;
>  	}
>  
> +	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)

Hi Guangguan Wang,

The function will return rc.
Should it be set to an error value here?

Flagged by Smatch.

> +		goto out;
> +
>  	/* ignore client add link recommendation, start new flow */
>  	ini->vlan_id = lgr->vlan_id;
>  	if (lgr->smc_version == SMC_V2) {
> -- 
> 2.24.3 (Apple Git-128)
> 

