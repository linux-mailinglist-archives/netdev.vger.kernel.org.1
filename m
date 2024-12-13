Return-Path: <netdev+bounces-151774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A89F0D4B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFA283DD8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B11C07D1;
	Fri, 13 Dec 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRq2dpG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9738DD8;
	Fri, 13 Dec 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096685; cv=none; b=cOnas1LVzTZWouZPhaXS86hcSoYcp1DVcMhJnIBU90UpdBa7dDRszTq0Y8gWV518jSDrQWSSV72VoBu2tzd97EdFbWVTO/cPO3eEtvygZ+A9YHgeb0aDLbY0qcP+nzBeabo4Y3TaE5KGrvNHz2dbqpPsWY5ii9BFm2whbB9UzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096685; c=relaxed/simple;
	bh=E7bGzaJdXiP7fPDmpNB0EJgtF6vEh0y6MjIkN5TgPE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h79CbYyaZHE6/grSUika1rBdZBrpL9xefaMisu/ZXDCDqwxWxn4vSgxydp8BciG8g6zYH5M0wIfbixFcs3r+wol13pdmhb8itP1B/kV9hfsqZmoQ1vw8Tzm5IUCsTIAi2YX38zKUunQGMdWT0FTdBPZoEk4gTrjooGRmguPHoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRq2dpG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC167C4CED0;
	Fri, 13 Dec 2024 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734096684;
	bh=E7bGzaJdXiP7fPDmpNB0EJgtF6vEh0y6MjIkN5TgPE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRq2dpG801aljJvuXwC21NWsMyLD7hOs3QQhF2pOoc/6zoC1DBY9MfqzFsoPJ03bc
	 PWTpGmgYtmZLix3iyBg/S7mraOfj/DzYF4PHRGG16FeFhDFa/sWt7fSImxrz3b/izC
	 ASybP2dFBBBMAE3XX3hYRz6wDm3Jpq4dP1eDZsqr87PaH7aVwsx3BuQL2H312udFVP
	 ztT3EDjd0AAYDK8HvtFm6ojNF5Iy//p1CswL4k0mh/iCSk6EjjdfDNgjDc0nKfvTYK
	 /cjHA9H8XQI8Sr5OwzcbiaK5fFwm6Vnm2ZKSMF4lYCBxYQ7dsAJ0XegS+pYFfivX32
	 HVd84tjwuj62A==
Date: Fri, 13 Dec 2024 13:31:20 +0000
From: Simon Horman <horms@kernel.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] qed: fix uninit pointer read in
 qed_mcp_nvm_info_populate()
Message-ID: <20241213133120.GB561418@kernel.org>
References: <20241211134041.65860-2-gianf.trad@gmail.com>
 <20241212170400.GC73795@kernel.org>
 <cdbe92eb-0d35-457b-b661-d7aaf4026984@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbe92eb-0d35-457b-b661-d7aaf4026984@gmail.com>

On Fri, Dec 13, 2024 at 01:13:12PM +0100, Gianfranco Trad wrote:
> On 12/12/24 18:04, Simon Horman wrote:
> > On Wed, Dec 11, 2024 at 02:40:42PM +0100, Gianfranco Trad wrote:
> > > Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
> > > If qed_mcp_bist_nvm_get_num_images() returns -EOPNOTSUPP, this leads to
> > > jump to label out with nvm_info.image_att being uninit while assigning it
> > > to p_hwfn->nvm_info.image_att.
> > > Add check on rc against -EOPNOTSUPP to avoid such uninit pointer read.
> > > 
> > > Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
> > > Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> > > ---
> > > Note:
> > > - Fixes: tag should be "7a0ea70da56e net/qed: allow old cards not supporting "num_images" to work" ?
> > >   drivers/net/ethernet/qlogic/qed/qed_mcp.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> > > index b45efc272fdb..127943b39f61 100644
> > > --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> > > +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> > > @@ -3387,7 +3387,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
> > >   	}
> > >   out:
> > >   	/* Update hwfn's nvm_info */
> > > -	if (nvm_info.num_images) {
> > > +	if (nvm_info.num_images && rc != -EOPNOTSUPP) {
> > >   		p_hwfn->nvm_info.num_images = nvm_info.num_images;
> > >   		kfree(p_hwfn->nvm_info.image_att);
> > >   		p_hwfn->nvm_info.image_att = nvm_info.image_att;
> > 
> 
> Hi Simon,
> 
> > Are you sure that nvm_info.num_images can be non-zero if rc == -EOPNOTSUPP?
> > 
> 
> In the coverity report, the static analyzer is able to take the true branch
> on nvm_info.num_images. I didn't physically reproduce this logical state as
> I don't possess the matching hardware.
> 
> > The cited commit state:
> > 
> >      Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
> >      added support for populating flash image attributes, notably
> >      "num_images". However, some cards were not able to return this
> >      information. In such cases, the driver would return EINVAL, causing the
> >      driver to exit.
> > 
> >      Add check to return EOPNOTSUPP instead of EINVAL when the card is not
> >      able to return these information. The caller function already handles
> >      EOPNOTSUPP without error.
> > 
> > So I would expect that nvm_info.num_images is 0.
> > 
> > If not, perhaps an alternate fix is to make that so, either by setting
> > it in qed_mcp_bist_nvm_get_num_images, or where the return value of
> > qed_mcp_bist_nvm_get_num_images is checked (just before the goto out).
> > 
> 
> Makes sense, so something like this I suppose:
> 
> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> @@ -3301,8 +3301,10 @@ int qed_mcp_bist_nvm_get_num_images(struct qed_hwfn
> *p_hwfn,
>   	if (rc)
>   		return rc;
> 
> -	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED))
> +	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED)) {
> +		*num_images = 0;
>   		rc = -EOPNOTSUPP;
> +	}
> 
> Or the second option you stated.

Yes, that is what I was thinking.
But as it is a side effect, and thus hidden slightly,
on reflection perhaps the second option is better. IDK.

> > And, in any case I think some testing is in order.
> 
> I strongly agree. Let me know if I can help more with this.
> 
> Thanks for your time,
> --Gian
> 

