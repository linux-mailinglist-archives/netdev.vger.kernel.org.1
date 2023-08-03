Return-Path: <netdev+bounces-24103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CD76EC55
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E8282279
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0E23BCD;
	Thu,  3 Aug 2023 14:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427C1F93A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF1C433C8;
	Thu,  3 Aug 2023 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691072484;
	bh=ogXR4tBfbvDt56hWyYjrB/Y2m0ixGBj//Z9eIHMQls0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCicPtZvRu2WkzaACqECBgE/7AyP1KR/ut7Bxlp/9+mr8tsBAPxvaIQnzJP0DvFVN
	 u9tf/X78IlM+nQO7BPGOyvqw4HyYhpyVpGe+l+jWQwLlzSCb4t3MB5qIk22ryz8JBp
	 DI/Hg4xAQWah7u+xtIOWCjsPnfwHH+25Hg/XEH4xeIYPHJpjSGeFTMvvxB1ewkqnjh
	 ar6B0msplDGQaKKtNGJXoodASPETKbZwM/JdK1ltq0VDgGnCahLJ88XdWZf6Ttm5+c
	 8YtiNFuAGWDKUcedfFXW2HMH0r3tgrStXrq9wYwpvs6UEpGeL2Qf+6aqt8hR/G3v42
	 D495rfY6Uqctg==
Date: Thu, 3 Aug 2023 07:21:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com
Subject: Re: [PATCH net-next 1/2] eth: bnxt: fix one of the W=1 warnings
 about fortified memcpy()
Message-ID: <20230803072123.1fbd56db@kernel.org>
In-Reply-To: <58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com>
References: <20230727190726.1859515-1-kuba@kernel.org>
	<20230727190726.1859515-2-kuba@kernel.org>
	<58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 07:08:13 -0600 Gustavo A. R. Silva wrote:
> In function 'fortify_memcpy_chk',
>      inlined from 'bnxt_hwrm_queue_cos2bw_qcfg' at drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:165:3:
> include/linux/fortify-string.h:592:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd 
> parameter); maybe use struct_group()? [-Wattribute-warning]
>    592 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Here is a potential fix for that:
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> index 31f85f3e2364..e2390d73b3f0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> @@ -144,7 +144,7 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
>          struct hwrm_queue_cos2bw_qcfg_output *resp;
>          struct hwrm_queue_cos2bw_qcfg_input *req;
>          struct bnxt_cos2bw_cfg cos2bw;
> -       void *data;
> +       struct bnxt_cos2bw_cfg *data;
>          int rc, i;
> 
>          rc = hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_QCFG);
> @@ -158,11 +158,11 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
>                  return rc;
>          }
> 
> -       data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);
> +       data = (struct bnxt_cos2bw_cfg *)&resp->queue_id0;
>          for (i = 0; i < bp->max_tc; i++, data += sizeof(cos2bw.cfg)) {
>                  int tc;
> 
> -               memcpy(&cos2bw.cfg, data, sizeof(cos2bw.cfg));
> +               memcpy(&cos2bw.cfg, &data->cfg, sizeof(cos2bw.cfg));
>                  if (i == 0)
>                          cos2bw.queue_id = resp->queue_id0;

Neat trick, but seems like casting to the destination type should
really be the last resort. There's only a handful of members in this
struct, IMHO assigning member by member is cleaner.
But I'll defer to Michael.

