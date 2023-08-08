Return-Path: <netdev+bounces-25268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B57739E2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 13:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09E9281756
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2505F4FE;
	Tue,  8 Aug 2023 11:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7A100A1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE8C433C7;
	Tue,  8 Aug 2023 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691493356;
	bh=Y0gDf+zRvLF+bJ9zyS6zyoKtY4CCNUh7ukjcveiZlj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iqt7X9EtI+QZTynZGeAJpcYkRI7AetqWS+3y2RJX0WpvZ4u5HQxpfweFVEvN4shpe
	 ejDAQXpd3OnV/s1K15fMGMEXW3M5I1fdzDFDrCOi23bi5UfS5kjaXkYTRhwXP8LuJ9
	 kJcW0cWVsq+S9feAPmZNP6xqyE2eAvWXJvPnPjILdTH1xIv/THbnxPRce9UUbEqzHI
	 XNKahAjc6GeQRUW/B3b5AzUPurgbX/K4XFhod+F8dBzMKVQQxGFAZJlgB0sZiPTb0B
	 qlQzMvVehGQfRtXrVCw3NYSW0yn9v0odyu2UIiVgDiTyNkFMFa5iPPuqb/eQPsqlzW
	 9ge7AFyC8vqhA==
Date: Tue, 8 Aug 2023 05:16:58 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	gustavo@embeddedor.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next 1/2] bnxt_en: Fix W=1 warning in bnxt_dcb.c from
 fortify memcpy()
Message-ID: <ZNIkKpWh8NnIyzJ7@work>
References: <20230807145720.159645-1-michael.chan@broadcom.com>
 <20230807145720.159645-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807145720.159645-2-michael.chan@broadcom.com>

On Mon, Aug 07, 2023 at 07:57:19AM -0700, Michael Chan wrote:
> Fix the following warning:
> 
> inlined from ‘bnxt_hwrm_queue_cos2bw_qcfg’ at drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:165:3,
> ./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
>     __read_overflow2_field(q_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Modify the FW interface defintion of struct hwrm_queue_cos2bw_qcfg_output
> to use an array of sub struct for the queue1 to queue7 fields.  Note that
> the layout of the queue0 fields are different and these are not part of
> the array.  This makes the code much cleaner by removing the pointer
> arithmetic for memcpy().

Thanks for fixing this. :)

> 
> Link: https://lore.kernel.org/netdev/20230727190726.1859515-2-kuba@kernel.org/
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

--
Gustavo


