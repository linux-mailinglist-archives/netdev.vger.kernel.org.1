Return-Path: <netdev+bounces-22716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB4768F06
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCB1C20B5D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EE63A7;
	Mon, 31 Jul 2023 07:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078F612C
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1945C433C8;
	Mon, 31 Jul 2023 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690789085;
	bh=2irsA3UR2NHCKzIxBwtohzjleSszhcLRIjmgEyuaMck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+cMlWCZ9AnK1U1TT0BCCvsTMMBUzz1S2KeRJk2jWn/BE+hSueutMV6RLeObOyFCG
	 3fkxj/VInSwsSwSQPjrwAErNehMCDiSLG1hRFFsPDVIeBkwz5CMEVNACWLOJlKRFxE
	 xkD6P96uG/i5flDLGsD+Ei/YNH18ZofEVtWzxcopptzbg14V0m6kyjCNuUnghCXRug
	 sWPqCNVmoaHtL7B+J0HAixmmcIyGOb71k0/bdITmtqjRYrusoNM6HrB2fcxudfglRs
	 up0B5qcxpaOfXlIT4PR61CwxRTjTQWR1KJdDQmYZUqubOaXAFibERM7pQ6QlA/u556
	 /Q0apdTy+TjVg==
Date: Mon, 31 Jul 2023 10:38:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Atul Raut <rauji.raut@gmail.com>
Cc: avem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, rafal@milecki.pl,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net/macmace: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <20230731073801.GA87829@unreal>
References: <20230730231442.15003-1-rauji.raut@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730231442.15003-1-rauji.raut@gmail.com>

On Sun, Jul 30, 2023 at 04:14:42PM -0700, Atul Raut wrote:
> Since zero-length arrays are deprecated, we are replacing
> them with C99 flexible-array members. As a result, instead
> of declaring a zero-length array, use the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This fixes warnings such as:
> ./drivers/net/ethernet/apple/macmace.c:80:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>  drivers/net/ethernet/apple/macmace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
> index 8fcaf1639920..8775c3234e91 100644
> --- a/drivers/net/ethernet/apple/macmace.c
> +++ b/drivers/net/ethernet/apple/macmace.c
> @@ -77,7 +77,7 @@ struct mace_frame {
>  	u8	pad4;
>  	u32	pad5;
>  	u32	pad6;
> -	u8	data[1];
> +	DECLARE_FLEX_ARRAY(u8, data);

But data[1] is not zero-length array.

>  	/* And frame continues.. */
>  };
>  
> -- 
> 2.34.1
> 
> 

