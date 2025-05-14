Return-Path: <netdev+bounces-190409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658EFAB6BE3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED88A7B49BE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4B2798FB;
	Wed, 14 May 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGJH+1bs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DC2798F0
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227405; cv=none; b=RVSW4iw9uYpB77NC4iusC1srguQiKVg558mgXqQh7NCrfQg78vS3hvFQeoVohg1qy5az4SJJCoSlY9ogS2OrfB3eumMWgp+JPXN9q85Ewg6yTPBwSYo+2h98s0ozuoYoQvHyHgsbXQqic6tdduo0l+QZterNwG7KNx3oMpZFJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227405; c=relaxed/simple;
	bh=RTLE1R8JiUOKuU2qI1GnvbSo0suLnLcB+KhyI9g7AoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoWbDff2N41iWi0KUcO88+63BsXlEJUf38CF52T8q9t/EStWsHJjRsufpgmDo/XFNdy5tGr2uql7YBSori1VJQRJGmR6nXx8ErsTH+mYmQ6N+r3QnkuNf0pm4Muo1rRFSfCgeZQMS60M5BI9RF+LG9030zeOdlpUQq6eo05uUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGJH+1bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD45CC4CEE9;
	Wed, 14 May 2025 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747227405;
	bh=RTLE1R8JiUOKuU2qI1GnvbSo0suLnLcB+KhyI9g7AoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGJH+1bsoTgVyel1UHEzPLkWs8EEFFWKd/DRGZsGDFIoIVl21IMgnRdfn6maXyTGE
	 8fz3Af3BYcf3FTFKQ5mIfD8MoCzbh9eSnQ3Hd6yH0O+L3IXNmE2wn1hXCU0pzh2EkG
	 6dwGWTnkIwUBX/dePoZGkZd9O5GqTtIgAYR6YsrdJi7kS7ObKBdBEapd4wf/IB9V96
	 QY+riHizNjr3AXRZ5jQDJg6mL2Fag+Js+h11J+0KdYcc3BMGNcD3DR8fS1Oit3RTu/
	 Af+2d86h6g+EmJKxhQelpHYaWLo+/PXFRaMVx6hRdLpiHf/h1EIaahoh+8CHNR465O
	 gIzsaDaposAvA==
Date: Wed, 14 May 2025 13:56:40 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next v2 PATCH 2/2] octeontx2-pf: macsec: Get MACSEC
 capability flag from AF
Message-ID: <20250514125640.GN3339421@horms.kernel.org>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
 <1746969767-13129-3-git-send-email-sbhatta@marvell.com>
 <20250512163732.GS3339421@horms.kernel.org>
 <aCMDhyuY2_B-c0CE@59cc1f87bccd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMDhyuY2_B-c0CE@59cc1f87bccd>

On Tue, May 13, 2025 at 08:32:07AM +0000, Subbaraya Sundeep wrote:

Hi Subbaraya,

> Hi Simon,
> 
> On 2025-05-12 at 16:37:32, Simon Horman (horms@kernel.org) wrote:
> > On Sun, May 11, 2025 at 06:52:47PM +0530, Subbaraya Sundeep wrote:

...

> > Hi Subbaraya,
> > 
> > If I read things correctly otx2_setup_dev_hw_settings() is called
> > for both representors and non-representors, while otx2_probe is
> > only called for non-representors.
> > 
> > If so, my question is if this patch changes behaviour for representors.
> > And, again if so, if that is intentional.
> I assume you mean VF driver for representors and PF driver for
> non-representor. Yes this is intentional. We currently do not support
> macscec offload on VFs hence I changed only PF driver. In case we want
> to support macsec offload on VFs too then otx2vf_probe also need to be
> changed like:
> otx2_set_hw_capabilities(vf);
> err = cn10k_mcs_init(vf);

Thanks for the clarification.
In that case this patch looks good ti me.

Reviewed-by: Simon Horman <horms@kernel.org>

