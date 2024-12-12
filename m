Return-Path: <netdev+bounces-151454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60E9EF43E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E842E28E0C2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692662210DB;
	Thu, 12 Dec 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izDHSMfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41021576E;
	Thu, 12 Dec 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023105; cv=none; b=ZvWrPSS+MMxC8L1QG9WTXIknOJ4OQhiLqoFNR4VV3pBnz0ixk8+Q5NHwDDbUnLHMUgIzDf1TiXjeNrDIQqSflkXupFFLt24F+HmaTsBySg8lw7JmUQldLwENkcbVH169oZgc1v7cPRGH2uCsKvxdQBHbRkBoabS0qPPer95ehY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023105; c=relaxed/simple;
	bh=tGubaQrA7Kc8sj47oQPz3QlNRojgFSU2Q3YW9KxNBmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA2hMAo55eYAHu+mMgF2ISeVt1o+2FTp65njttZyatocisWWLy+qkKT8PRoPxDN2DK3T7LQorkIJ7cxF5k8sp3qNW4jUkcZeJCJ4kkY8jFq7YC7USKPiVT7W5RfcwIDGWjBYnWN1t2VnDSW5/Km2RZl1655bNL2zlHPjF0UKkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izDHSMfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9133C4CED4;
	Thu, 12 Dec 2024 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023104;
	bh=tGubaQrA7Kc8sj47oQPz3QlNRojgFSU2Q3YW9KxNBmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izDHSMfe2MxIbPL4oXaHX39VrN31l0P1vZkpFC8ZFAalbM+Oiq2FZ1J/cwE7LD7XV
	 fNyHyCux54lGynGvoU9mRL7381+0EB2mjBEw4cM7eRE6pMNymtN/NJkH+Jcx0Am242
	 tpxzoiLbhkxNZQ26wxa3GUPWQK0cPzlQ+E8jWepBkYOHNBoCwNZqjiCuTU6srWTNHO
	 HMLA1VU8TYxMn0sCJF7ls1ecF2eAQhtKMnX0D0C0nT0iTdf4Di1OnIsgBmHtTVqdbT
	 IghhDuTBEDhKCFtlR/j7cuj6PPxYs9aJICGBp6+SUufo7IFXVWWCVrt148LmrfJswU
	 2hFonbjb6mjNA==
Date: Thu, 12 Dec 2024 17:04:00 +0000
From: Simon Horman <horms@kernel.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] qed: fix uninit pointer read in
 qed_mcp_nvm_info_populate()
Message-ID: <20241212170400.GC73795@kernel.org>
References: <20241211134041.65860-2-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211134041.65860-2-gianf.trad@gmail.com>

On Wed, Dec 11, 2024 at 02:40:42PM +0100, Gianfranco Trad wrote:
> Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
> If qed_mcp_bist_nvm_get_num_images() returns -EOPNOTSUPP, this leads to
> jump to label out with nvm_info.image_att being uninit while assigning it
> to p_hwfn->nvm_info.image_att.
> Add check on rc against -EOPNOTSUPP to avoid such uninit pointer read.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
> Note:
> - Fixes: tag should be "7a0ea70da56e net/qed: allow old cards not supporting "num_images" to work" ?
>   
>  drivers/net/ethernet/qlogic/qed/qed_mcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> index b45efc272fdb..127943b39f61 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> @@ -3387,7 +3387,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
>  	}
>  out:
>  	/* Update hwfn's nvm_info */
> -	if (nvm_info.num_images) {
> +	if (nvm_info.num_images && rc != -EOPNOTSUPP) {
>  		p_hwfn->nvm_info.num_images = nvm_info.num_images;
>  		kfree(p_hwfn->nvm_info.image_att);
>  		p_hwfn->nvm_info.image_att = nvm_info.image_att;

Are you sure that nvm_info.num_images can be non-zero if rc == -EOPNOTSUPP?

The cited commit state:

    Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
    added support for populating flash image attributes, notably
    "num_images". However, some cards were not able to return this
    information. In such cases, the driver would return EINVAL, causing the
    driver to exit.

    Add check to return EOPNOTSUPP instead of EINVAL when the card is not
    able to return these information. The caller function already handles
    EOPNOTSUPP without error.

So I would expect that nvm_info.num_images is 0.

If not, perhaps an alternate fix is to make that so, either by setting
it in qed_mcp_bist_nvm_get_num_images, or where the return value of
qed_mcp_bist_nvm_get_num_images is checked (just before the goto out).

And, in any case I think some testing is in order.


