Return-Path: <netdev+bounces-209952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A7B11735
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A24161654
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A823C50A;
	Fri, 25 Jul 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J8RG4pGI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFC23C4F2
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414999; cv=none; b=hPVopB9dn0J6iTbhYpHd8BdP5pte91cFv/vOMnZq2uagDJM3O/dv2MJ+c6MUtI7aPICzUUMMFeqR2IgeT9aVe4BxljdFX7bsGHxk7KRbljWQOqFh5oVj0svPFGtXc3nya3oxxPNVU30CfTBFZTGyroqIMZwq4Xv70dnXnFjhxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414999; c=relaxed/simple;
	bh=zstK35mmA9juoQw20Ov3Iw9XX0+6+2G+gDYye4Qp314=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=dqMYIwNZ1SZ62j+ozl/UQavy+dZwYJJkWJB6DDCXhIMnqteDDdhGEPYcs85/QxS1D81oZWFb9Fy/4WpNp01p8x3acnzAZLOV/Oa16fjKO3Qxm44ZdSGPK+vMTvka24XnUtJ6Jk+ze0rxop04rBZHW2tZrB6z2nIQM6ryuomCNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J8RG4pGI; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753414994; h=Message-ID:Subject:Date:From:To;
	bh=vinw7/i39C0MpkA7/FoBU8SqU/KCgQ8tkJq9RXxClNI=;
	b=J8RG4pGIz2q1IIbsm0jT+tXUvdfkulkO1En+nF9WMkAuCsoRN2WqLfmmlolvnVqSbK/7pDe6Uj5LBhOpqFQuZWgmUwhusp7t1FM4bN8FWWOvth0urNeWQckZNvazsf1YkfAmRmwtXW5od17R+t3IAxkLowgAcE5FnAkp8Dc3tdE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WjvFl1o_1753414993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 11:43:13 +0800
Message-ID: <1753414751.8289475-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 25 Jul 2025 11:39:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
 <20250724164418.GB1266901@horms.kernel.org>
In-Reply-To: <20250724164418.GB1266901@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 24 Jul 2025 17:44:18 +0100, Simon Horman <horms@kernel.org> wrote:
> On Thu, Jul 24, 2025 at 07:06:45PM +0800, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
>
> This is a 40k LoC patch.
> It would be nice to add a bit more information about
> what it includes.
>
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
>
> ...
>
> >  19 files changed, 4067 insertions(+)
>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
>
> > +int eea_adminq_config_host_info(struct eea_net *enet)
> > +{
> > +	struct device *dev = enet->edev->dma_dev;
> > +	struct eea_aq_host_info_cfg *cfg;
> > +	struct eea_aq_host_info_rep *rep;
> > +	int rc = -ENOMEM;
> > +
> > +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +	if (!cfg)
> > +		return rc;
> > +
> > +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> > +	if (!rep)
> > +		goto free_cfg;
> > +
> > +	cfg->os_type = EEA_OS_LINUX;
>
> The type of the lvalue above is a little endian integer.
> While the type of the rvalue is a host byte order integer.
> I would address this as follows:
>
> 	cfg->os_type = cpu_to_le16(EEA_OS_LINUX);
>
> Likewise for other members of cfg set in this function,
> noting that pci_domain is a 32bit entity.
>
> Flagged by Sparse.
>
> There are a number of other (minor) problems flagged by Sparse
> in this patch. Please address them and make sure patches
> are Sparse-clean.

I did the check by make C=1, but I found that my sparse is old ^_^.
I updated the sparse, and cleared all the reports.

...

>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
>
> ...
>
> > +void *ering_cq_get_desc(const struct ering *ering)
> > +{
> > +	u8 phase;
> > +	u8 *desc;
> > +
> > +	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
> > +
> > +	phase = *(u8 *)(desc + ering->cq.desc_size - 1);
> > +
> > +	if ((phase & ERING_DESC_F_CQ_PHASE)  == ering->cq.phase) {
>
> nit: unnecessary inner-parentheses

I think we should keep it.

Thanks.


